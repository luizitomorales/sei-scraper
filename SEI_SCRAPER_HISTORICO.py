#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import os
import asyncio
import logging
import traceback
from pathlib import Path
from typing import List, Dict
from datetime import datetime
import json
import pandas as pd
from dotenv import load_dotenv
from playwright.async_api import async_playwright, Page, Frame

# ============================================================
# CONFIGURAÇÃO
# ============================================================

BASE_DIR = Path(__file__).parent.resolve()
ENV_PATH = BASE_DIR / "STAGE.env"

load_dotenv(ENV_PATH)

USUARIO = os.getenv("USUARIO")
SENHA   = os.getenv("SENHA")
ORGAO   = os.getenv("ORGAO")

# Configurações de reprocessamento
MAX_TENTATIVAS_POR_PROCESSO = 3  # Número máximo de tentativas por processo na mesma execução
DELAY_ENTRE_TENTATIVAS = 30      # Segundos entre tentativas do mesmo processo

if not USUARIO or not SENHA or not ORGAO:
    logging.error("Credenciais não encontradas no arquivo .env")
    logging.error(f"USUARIO: {'OK' if USUARIO else 'FALTANDO'}")
    logging.error(f"SENHA: {'OK' if SENHA else 'FALTANDO'}")
    logging.error(f"ORGAO: {'OK' if ORGAO else 'FALTANDO'}")
    exit(1)

logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s - %(levelname)s - %(message)s"
)

# ============================================================
# GERENCIADOR DE SKIP (APENAS PARA RELATÓRIO)
# ============================================================

class SkipManager:
    def __init__(self, base_dir: Path):
        self.base_dir = base_dir
        self.skip_dir = base_dir / "output" / "skip"
        self.skip_dir.mkdir(parents=True, exist_ok=True)
        
    def salvar_falha(self, processo: str, erro: str, tentativa: int = 1, detalhes: str = ""):
        """Salva um processo que falhou (apenas para relatório)"""
        hoje = datetime.now().strftime("%Y-%m-%d")
        arquivo = self.skip_dir / f"processos_pendentes_{hoje}.json"
        
        falhas = []
        if arquivo.exists():
            try:
                with open(arquivo, "r", encoding="utf-8") as f:
                    falhas = json.load(f)
            except:
                pass
        
        # Atualizar ou adicionar
        encontrado = False
        for f in falhas:
            if f["processo"] == processo:
                f["data_falha"] = datetime.now().isoformat()
                f["erro"] = erro
                f["tentativas"] = tentativa
                f["detalhes"] = detalhes[:500]
                encontrado = True
                break
        
        if not encontrado:
            falhas.append({
                "processo": processo,
                "data_falha": datetime.now().isoformat(),
                "erro": erro,
                "tentativas": tentativa,
                "detalhes": detalhes[:500]
            })
        
        with open(arquivo, "w", encoding="utf-8") as f:
            json.dump(falhas, f, ensure_ascii=False, indent=2)
    
    def registrar_sucesso(self, processo: str):
        """Remove processo da lista de pendentes quando obtém sucesso"""
        hoje = datetime.now().strftime("%Y-%m-%d")
        arquivo = self.skip_dir / f"processos_pendentes_{hoje}.json"
        
        if arquivo.exists():
            try:
                with open(arquivo, "r", encoding="utf-8") as f:
                    falhas = json.load(f)
                
                falhas = [f for f in falhas if f["processo"] != processo]
                
                with open(arquivo, "w", encoding="utf-8") as f:
                    json.dump(falhas, f, ensure_ascii=False, indent=2)
            except:
                pass
    
    def gerar_relatorio(self, sucessos: List[str], falhas: List[str]):
        """Gera relatório final da execução"""
        hoje = datetime.now().strftime("%Y-%m-%d")
        
        relatorio = {
            "data_execucao": hoje,
            "timestamp": datetime.now().isoformat(),
            "processos_sucesso": sucessos,
            "processos_falha": falhas,
            "total_sucesso": len(sucessos),
            "total_falhas": len(falhas)
        }
        
        relatorio_path = self.skip_dir / f"relatorio_execucao_{hoje}_{datetime.now().strftime('%H%M%S')}.json"
        with open(relatorio_path, "w", encoding="utf-8") as f:
            json.dump(relatorio, f, ensure_ascii=False, indent=2)
        
        logging.info(f"📊 Relatório salvo: {relatorio_path}")

# ============================================================
# CARREGAMENTO DE PROCESSOS
# ============================================================

def carregar_processos() -> List[str]:
    """Carrega todos os processos do CSV"""
    csv_paths = [
        Path("/home/admin/sei-scraper/[lixeira]/processos/lista_sem_duplicatas.csv"),
        BASE_DIR / "lista_sem_duplicatas.csv",
        BASE_DIR / "processos.csv"
    ]
    
    csv_path = None
    for path in csv_paths:
        if path.exists():
            csv_path = path
            break
    
    if not csv_path:
        logging.error("CSV não encontrado")
        return []
    
    logging.info(f"Carregando processos de: {csv_path}")
    
    df = None
    for enc in ("utf-8", "utf-8-sig", "cp1252", "latin-1"):
        try:
            df = pd.read_csv(csv_path, dtype=str, encoding=enc)
            logging.info(f"CSV carregado com encoding {enc}")
            break
        except:
            pass
    
    if df is None:
        logging.error("Não foi possível carregar o CSV")
        return []
    
    # Identificar coluna de processos
    col = None
    for c in df.columns:
        c_lower = c.lower()
        if any(k in c_lower for k in ["processo", "sei", "nº", "numero"]):
            col = c
            break
    
    if col is None:
        col = df.columns[0]
    
    logging.info(f"Coluna identificada: {col}")
    
    # Extrair e limpar processos
    processos = df[col].astype(str).str.strip().tolist()
    processos = [p for p in processos if p and p.lower() != "nan" and len(p) > 10]
    processos = list(dict.fromkeys(processos))
    
    return processos


def carregar_processos_pendentes() -> List[str]:
    """
    Carrega APENAS os processos que ainda não foram processados com sucesso.
    Permite reprocessar pendentes de execuções anteriores.
    """
    
    todos_processos = carregar_processos()
    if not todos_processos:
        return []
    
    # Processos que já foram processados com sucesso (em QUALQUER data)
    historico_dir = BASE_DIR / "output" / "historico"
    ja_processados_com_sucesso = set()
    
    if historico_dir.exists():
        for data_dir in historico_dir.iterdir():
            if data_dir.is_dir():
                for arquivo in data_dir.glob("*.json"):
                    nome = arquivo.stem.replace("_", "/")
                    ja_processados_com_sucesso.add(nome)
    
    # Filtrar apenas os que NUNCA tiveram sucesso
    processos_pendentes = [p for p in todos_processos if p not in ja_processados_com_sucesso]
    
    logging.info(f"\n{'='*50}")
    logging.info(f"📊 PROCESSOS PENDENTES")
    logging.info(f"{'='*50}")
    logging.info(f"   Total de processos no CSV: {len(todos_processos)}")
    logging.info(f"   ✅ Já processados com sucesso: {len(ja_processados_com_sucesso)}")
    logging.info(f"   ⏸️  Ainda pendentes: {len(processos_pendentes)}")
    logging.info(f"{'='*50}\n")
    
    return processos_pendentes

# ============================================================
# UTILITÁRIOS
# ============================================================

async def get_frame(page: Page, name: str, timeout=30000) -> Frame:
    """Encontra um iframe pelo nome"""
    start = asyncio.get_event_loop().time()
    while (asyncio.get_event_loop().time() - start) * 1000 < timeout:
        for f in page.frames:
            if f.name == name:
                return f
        await asyncio.sleep(0.3)
    raise TimeoutError(f"Iframe '{name}' não encontrado")

# ============================================================
# SCRAPER
# ============================================================

class SEIScraper:
    
    def __init__(self):
        self.skip_manager = SkipManager(BASE_DIR)

    async def login(self, page: Page):
        """Realiza login no SEI"""
        logging.info("Iniciando login no SEI")
        
        await page.goto("https://sei.saude.gov.br/", timeout=150000)
        await page.wait_for_load_state("networkidle")
        
        # Verificar se já está logado
        try:
            await page.locator("#txtPesquisaRapida").wait_for(timeout=5000)
            logging.info("Já estava logado!")
            return
        except:
            pass
        
        await page.locator("#txtUsuario").wait_for(timeout=10000)
        await page.locator("#txtUsuario").fill(USUARIO)
        await page.locator("#pwdSenha").fill(SENHA)
        await page.locator("#selOrgao").select_option(label=ORGAO)
        
        async with page.expect_navigation(wait_until="networkidle", timeout=30000):
            await page.locator("#sbmAcessar").click()
        
        await page.locator("#txtPesquisaRapida").wait_for(timeout=10000)
        logging.info("Login concluído com sucesso")

    async def processar_processo(self, page: Page, processo: str, tentativa: int) -> bool:
        """Processa um único processo e retorna True se sucesso"""
        logging.info(f"[{processo}] Tentativa {tentativa}/{MAX_TENTATIVAS_POR_PROCESSO}")
        
        historico = []
        
        try:
            # === BUSCA DO PROCESSO ===
            await page.locator("#txtPesquisaRapida").fill(processo)
            await asyncio.sleep(0.5)
            await page.keyboard.press("Enter")
            await page.wait_for_timeout(2000)
            
            # === IFRAME ÁRVORE ===
            try:
                frame_arvore = await get_frame(page, "ifrArvore", timeout=30000)
            except TimeoutError:
                logging.error(f"[{processo}] Iframe ifrArvore não encontrado")
                return False
            
            # === CLICAR EM CONSULTAR ANDAMENTO ===
            try:
                btn = frame_arvore.locator("#divConsultarAndamento > a")
                await btn.wait_for(timeout=20000)
                await btn.click()
                logging.info(f"[{processo}] Consultar andamento clicado")
            except Exception as e:
                logging.warning(f"[{processo}] Botão 'Consultar Andamento' não encontrado: {e}")
                return False
            
            await page.wait_for_timeout(3000)
            
            # === FALLBACK 1: IFRAME VISUALIZAÇÃO ===
            frame_visual = None
            try:
                frame_visual = await get_frame(page, "ifrVisualizacao", timeout=30000)
                logging.info(f"[{processo}] ifrVisualizacao encontrado")
            except:
                try:
                    frame_visual = await get_frame(page, "ifrConteudoVisualizacao", timeout=10000)
                    logging.info(f"[{processo}] Fallback: ifrConteudoVisualizacao encontrado")
                except:
                    logging.error(f"[{processo}] Nenhum iframe encontrado")
                    return False
            
            # === FALLBACK 2: BOTÃO "VER HISTÓRICO COMPLETO" ===
            # SÓ CLICA SE O TEXTO FOR "Ver histórico completo"
            # Se já estiver "Ver histórico resumido", já está no modo completo
            alternou = False
            
            # Estratégia 1: Seletor por ID, verificando o texto
            try:
                anc = frame_visual.locator("#ancTipoHistorico")
                if await anc.count() > 0 and await anc.is_visible():
                    texto = await anc.text_content()
                    if texto and "completo" in texto.lower():
                        await anc.click()
                        logging.info(f"[{processo}] Alternado via #ancTipoHistorico (estava resumido)")
                        await page.wait_for_timeout(1500)
                        alternou = True
                    else:
                        logging.info(f"[{processo}] Já está completo: '{texto}'")
            except:
                pass
            
            # Estratégia 2: Dentro da divInfraAreaDados
            if not alternou:
                try:
                    anc = frame_visual.locator("#divInfraAreaDados a")
                    if await anc.count() > 0 and await anc.is_visible():
                        texto = await anc.first.text_content()
                        if texto and "completo" in texto.lower():
                            await anc.first.click()
                            logging.info(f"[{processo}] Alternado via #divInfraAreaDados a: '{texto}'")
                            await page.wait_for_timeout(1500)
                            alternou = True
                        else:
                            logging.info(f"[{processo}] Já está completo: '{texto}'")
                except:
                    pass
            
            # Estratégia 3: Link com texto "completo" (excluindo "resumido")
            if not alternou:
                try:
                    anc = frame_visual.locator("a:has-text('completo')")
                    if await anc.count() > 0 and await anc.is_visible():
                        texto = await anc.first.text_content()
                        if texto and "completo" in texto.lower() and "resumido" not in texto.lower():
                            await anc.first.click()
                            logging.info(f"[{processo}] Alternado via a:has-text('completo')")
                            await page.wait_for_timeout(1500)
                            alternou = True
                        else:
                            logging.info(f"[{processo}] Já está completo: '{texto}'")
                except:
                    pass
            
            # Estratégia 4: Link com onclick específico para completo
            if not alternou:
                try:
                    anc = frame_visual.locator("a[onclick*=\"verHistorico('P')\"]")
                    if await anc.count() > 0 and await anc.is_visible():
                        await anc.first.click()
                        logging.info(f"[{processo}] Alternado via onclick verHistorico('P')")
                        await page.wait_for_timeout(1500)
                        alternou = True
                except:
                    pass
            
            if not alternou:
                logging.info(f"[{processo}] Modo completo já ativo")
            
            # Re-obter referência do iframe após clique
            if alternou:
                try:
                    frame_visual = await get_frame(page, "ifrVisualizacao", timeout=10000)
                except:
                    try:
                        frame_visual = await get_frame(page, "ifrConteudoVisualizacao", timeout=10000)
                    except:
                        pass
            
            # === FALLBACK 3: TABELA DE HISTÓRICO ===
            tabela_encontrada = False
            tabela_ref = None
            
            try:
                await frame_visual.wait_for_selector("#tblHistorico", timeout=5000)
                tabela_ref = frame_visual.locator("#tblHistorico")
                tabela_encontrada = True
                logging.info(f"[{processo}] Tabela encontrada via #tblHistorico")
            except:
                pass
            
            if not tabela_encontrada:
                try:
                    tabela = frame_visual.locator("table.infraTable")
                    if await tabela.count() > 0:
                        tabela_ref = tabela
                        tabela_encontrada = True
                        logging.info(f"[{processo}] Tabela encontrada via table.infraTable")
                except:
                    pass
            
            if not tabela_encontrada:
                try:
                    tabela = frame_visual.locator("table")
                    if await tabela.count() > 0:
                        tabela_ref = tabela
                        tabela_encontrada = True
                        logging.info(f"[{processo}] Tabela encontrada via fallback genérico")
                except:
                    pass
            
            if not tabela_encontrada:
                logging.warning(f"[{processo}] Nenhuma tabela de histórico encontrada")
                return False
            
            # === EXTRAIR HISTÓRICO COM PAGINAÇÃO ===
            pagina = 1
            while True:
                rows = None
                try:
                    rows = tabela_ref.locator("tbody tr")
                    if await rows.count() == 0:
                        rows = tabela_ref.locator("tr:not(:has(th))")
                except:
                    rows = tabela_ref.locator("tr")
                
                count = await rows.count()
                logging.info(f"[{processo}] Página {pagina}: {count} linhas")
                
                for i in range(count):
                    try:
                        cols = await rows.nth(i).locator("td").all_text_contents()
                        if len(cols) >= 4:
                            historico.append({
                                "data_hora": cols[0].strip(),
                                "unidade": cols[1].strip(),
                                "usuario": cols[2].strip(),
                                "descricao": cols[3].strip().replace('\n', ' ').replace('\r', ' ')
                            })
                    except:
                        continue
                
                # === PAGINAÇÃO ===
                proximo_encontrado = False
                
                try:
                    proximo = frame_visual.locator("#lnkInfraProximaPaginaInferior")
                    if await proximo.count() > 0:
                        img = proximo.locator("img")
                        if await img.count() > 0:
                            src = await img.get_attribute("src")
                            if src and "proxima_off" in src:
                                break
                        await proximo.click()
                        await page.wait_for_timeout(2000)
                        pagina += 1
                        proximo_encontrado = True
                except:
                    pass
                
                if not proximo_encontrado:
                    try:
                        proximo = frame_visual.locator("a:has(img[src*='proxima'])")
                        if await proximo.count() > 0:
                            await proximo.first.click()
                            await page.wait_for_timeout(2000)
                            pagina += 1
                            proximo_encontrado = True
                    except:
                        pass
                
                if not proximo_encontrado:
                    break
                
                # Re-obter referências
                try:
                    frame_visual = await get_frame(page, "ifrVisualizacao", timeout=10000)
                except:
                    try:
                        frame_visual = await get_frame(page, "ifrConteudoVisualizacao", timeout=10000)
                    except:
                        pass
                
                try:
                    tabela_ref = frame_visual.locator("#tblHistorico")
                    if await tabela_ref.count() == 0:
                        tabela_ref = frame_visual.locator("table.infraTable")
                except:
                    pass
            
            if historico:
                coleta = {
                    "processo": processo,
                    "timestamp_coleta": datetime.now().isoformat(),
                    "total_registros": len(historico),
                    "paginas": pagina,
                    "tentativa": tentativa,
                    "historico": historico
                }
                self.salvar_historico(coleta)
                logging.info(f"[{processo}] ✅ SUCESSO - {len(historico)} registros")
                return True
            else:
                logging.warning(f"[{processo}] ⚠️ Histórico vazio")
                return False
                    
        except Exception as e:
            logging.error(f"[{processo}] ❌ Falha: {e}")
            traceback.print_exc()
            return False

    def salvar_historico(self, coleta: Dict):
        """Salva histórico em JSON"""
        data = coleta["timestamp_coleta"][:10]
        processo = coleta["processo"].replace("/", "_")
        base = BASE_DIR / "output" / "historico" / data
        base.mkdir(parents=True, exist_ok=True)
        arquivo = base / f"{processo}.json"
        with open(arquivo, "w", encoding="utf-8") as f:
            json.dump(coleta, f, ensure_ascii=False, indent=2)
        logging.info(f"[{coleta['processo']}] Salvo em {arquivo}")

# ============================================================
# MAIN - APENAS PROCESSOS PENDENTES
# ============================================================

async def main():
    logging.info("=" * 60)
    logging.info("INICIANDO SCRAPER - APENAS PROCESSOS PENDENTES")
    logging.info("=" * 60)
    
    # Carrega APENAS os processos que nunca tiveram sucesso
    processos = carregar_processos_pendentes()
    
    if not processos:
        logging.info("✅ Todos os processos já foram processados com sucesso!")
        return
    
    logging.info(f"📋 Processos pendentes a processar: {len(processos)}")
    
    async with async_playwright() as p:
        browser = await p.chromium.launch(headless=False)
        page = await browser.new_page()
        
        scraper = SEIScraper()
        
        try:
            await scraper.login(page)
        except Exception as e:
            logging.error(f"Falha no login: {e}")
            await browser.close()
            return
        
        sucessos = []
        falhas = []
        
        for idx, proc in enumerate(processos, 1):
            logging.info(f"\n{'='*50}")
            logging.info(f"[{idx}/{len(processos)}] Processando pendente: {proc}")
            logging.info(f"{'='*50}")
            
            sucesso = False
            
            for tentativa in range(1, MAX_TENTATIVAS_POR_PROCESSO + 1):
                if tentativa > 1:
                    logging.info(f"⏳ Aguardando {DELAY_ENTRE_TENTATIVAS}s antes da próxima tentativa...")
                    await asyncio.sleep(DELAY_ENTRE_TENTATIVAS)
                
                sucesso = await scraper.processar_processo(page, proc, tentativa)
                
                if sucesso:
                    sucessos.append(proc)
                    break
            
            if not sucesso:
                falhas.append(proc)
                logging.error(f"[{proc}] ❌ FALHA DEFINITIVA após {MAX_TENTATIVAS_POR_PROCESSO} tentativas")
            
            # Delay entre processos
            await asyncio.sleep(2)
        
        await browser.close()
        
        # Relatório final
        scraper.skip_manager.gerar_relatorio(sucessos, falhas)
        
        logging.info("\n" + "=" * 60)
        logging.info(f"✅ PROCESSAMENTO CONCLUÍDO!")
        logging.info(f"   ✅ Sucessos nesta execução: {len(sucessos)}/{len(processos)}")
        logging.info(f"   ❌ Ainda pendentes: {len(falhas)}/{len(processos)}")
        
        if falhas:
            logging.info(f"\n📌 Processos ainda pendentes:")
            for f in falhas:
                logging.info(f"   - {f}")
        logging.info("=" * 60)


if __name__ == "__main__":
    asyncio.run(main())