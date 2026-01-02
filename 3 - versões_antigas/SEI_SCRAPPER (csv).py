## SEI_SCRAPPER (csv).py - VERSÃO CORRIGIDA DEFINITIVA (26/11/2025)

import os
import asyncio
import random
import logging
import json
from pathlib import Path
from dataclasses import dataclass
from typing import List, Dict
from datetime import datetime

from dotenv import load_dotenv
from playwright.async_api import async_playwright, TimeoutError as PWTimeout, Page   # ← CORRIGIDO AQUI
import pandas as pd

# =============================================
# 1. CONFIGURAÇÃO E .ENV
# =============================================
BASE_DIR = Path(__file__).parent.resolve()
ENV_PATH = BASE_DIR / "STAGE.env"

if not ENV_PATH.exists():
    raise FileNotFoundError(f"Arquivo STAGE.env não encontrado em: {ENV_PATH}")

load_dotenv(dotenv_path=ENV_PATH)

USUARIO = os.getenv("USUARIO")
SENHA   = os.getenv("SENHA")
ORGAO   = os.getenv("ORGAO")

if not all([USUARIO, SENHA, ORGAO]):
    raise ValueError("Faltam USUARIO, SENHA e/ou ORGAO no STAGE.env")

DOWNLOADS_DIR = BASE_DIR / "downloads"
DOWNLOADS_DIR.mkdir(exist_ok=True)

logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s - %(levelname)s - %(message)s",
    datefmt="%Y-%m-%d %H:%M:%S"
)

# =============================================
# 2. DATACLASS
# =============================================
@dataclass
class Andamento:
    data: str
    hora: str
    unidade: str
    usuario: str
    acao: str
    observacao: str
    documentos: str
    pagina: int

# =============================================
# 3. LEITURA DO CSV (INTACTA)
# =============================================
def carregar_processos() -> List[str]:
    csv_path = BASE_DIR / "processos.csv"
    
    if not csv_path.exists():
        alt_path = Path(r"[lixeira]/processos/Relatorio de Aquisiçoes.csv")
        if alt_path.exists():
            csv_path = alt_path
        else:
            logging.error(f"CSV não encontrado no caminho principal nem no alternativo:")
            logging.error(f"   → {csv_path}")
            logging.error(f"   → {alt_path}")
            return []

    # =============================================
    # A partir daqui o CSV foi encontrado em csv_path
    # =============================================
    try:
        df = None
        last_exc = None
        for enc in ("utf-8", "utf-8-sig", "cp1252", "latin-1"):
            try:
                df = pd.read_csv(csv_path, dtype=str, encoding=enc, sep=None, engine="python")
                logging.info(f"CSV lido com sucesso → {csv_path} (encoding={enc})")
                break
            except Exception as e_read:
                last_exc = e_read
                
        if df is None:
            raise last_exc

        # Detecta a coluna que contém o número do processo
        col = next(
            (c for c in df.columns if any(kw in str(c).lower() for kw in ["processo", "nº", "sei", "protocolo"])),
            df.columns[0]
        )

        processos = df[col].astype(str).str.strip().tolist()
        processos = [p for p in processos if p and p != "nan" and len(p) > 10]
        processos = list(dict.fromkeys(processos))  # remove duplicados mantendo ordem

        logging.info(f"{len(processos)} processos carregados do CSV")
        return processos

    except Exception as e:
        logging.error(f"Erro ao ler o CSV {csv_path}: {e}")
        return []

# =============================================
# 4. SCRAPER PRINCIPAL - LOGIN CORRIGIDO (BOTÃO CERTO + ESPERA CERTA)
# =============================================
class SEIScraper:
    def __init__(self):
        self.usr = USUARIO
        self.pwd = SENHA
        self.org = ORGAO

    async def _human_type(self, page, selector: str, text: str):
        await page.fill(selector, "")
        for char in text:
            await page.type(selector, char, delay=random.randint(80, 200))

    async def login(self, page):
        logging.info("Fazendo login no SEI...")
        await page.goto("https://sei.saude.gov.br/", timeout=120000)
        await page.wait_for_selector("#txtUsuario", state="visible", timeout=120000)

        await self._human_type(page, "#txtUsuario", self.usr)
        await self._human_type(page, "#pwdSenha", self.pwd)
        await page.select_option("#selOrgao", label=self.org)  # ← Seleciona órgão por label
        await page.click("#sbmAcessar")  # ← BOTÃO CORRETO: #sbmAcessar (como no seu Selenium de sucesso!)

        # Espera pela tela pós-login (igual ao seu Selenium: #txtPesquisaRapida)
        try:
            await page.wait_for_selector("#txtPesquisaRapida", state="visible", timeout=120000)
            logging.info("LOGIN REALIZADO COM SUCESSO!")
        except PWTimeout:
            # Diagnóstico melhorado
            current_url = page.url
            page_content = await page.content()
            if "sip/login.php" in current_url:
                logging.error("Redirecionado para SIP - verifique credenciais ou CAPTCHA manual.")
                raise Exception("LOGIN FALHOU: Redirecionamento para SIP (possível erro de credenciais ou bloqueio)")
            elif "inválidos" in page_content or "senha" in page_content:
                raise Exception("LOGIN FALHOU: Usuário ou senha inválidos")
            else:
                raise Exception(f"LOGIN FALHOU - URL: {current_url}")

    async def extrair_historico(self, page: Page, numero: str) -> List[Dict]:
        historico = []
        try:
            await page.goto(
                f"https://sei.saude.gov.br/sei/controlador.php?acao=procedimento_trabalhar&id_procedimento={numero}",
                timeout=180000
            )
            await page.wait_for_load_state("networkidle", timeout=90000)
            await asyncio.sleep(2)

            # === Frame esquerdo: Consultar Andamento ===
            frame_arvore = page.frame_locator("#ifrArvore")
            await frame_arvore.locator("a[title='Consultar Andamento']").wait_for(state="visible", timeout=60000)
            await frame_arvore.locator("a[title='Consultar Andamento']").click(timeout=30000)
            await asyncio.sleep(2)

            # === Frame direito: Ver histórico completo ===
            frame_visualizacao = page.frame_locator("#ifrVisualizacao")
            await frame_visualizacao.get_by_text("Ver histórico completo").wait_for(state="visible", timeout=60000)
            await frame_visualizacao.get_by_text("Ver histórico completo").click(timeout=30000)
            await asyncio.sleep(2)

            # === Espera a tabela final aparecer ===
            await frame_visualizacao.locator("#tblHistorico").wait_for(state="visible", timeout=60000)
            await asyncio.sleep(1)

            pagina = 1
            while True:
                # Extrai todas as linhas da página atual
                rows = await frame_visualizacao.locator("#tblHistorico tbody tr").all()

                for row in rows:
                    cols = await row.locator("td").all_text_contents()
                    if len(cols) < 6:
                        continue
                    docs = await row.locator("td:nth-child(6) a, td:nth-child(7) a").all_text_contents()

                    historico.append(Andamento(
                        data=cols[0].strip(),
                        hora=cols[1].strip(),
                        unidade=cols[2].strip(),
                        usuario=cols[3].strip(),
                        acao=cols[4].strip(),
                        observacao=cols[5].split("\n", 1)[0].strip(),
                        documentos=" | ".join(d.strip() for d in docs) if docs else "",
                        pagina=pagina
                    ).__dict__)

                # === Paginação ===
                try:
                    img_src = await frame_visualizacao.locator("#lnkInfraProximaPaginaSuperior img") \
                                                    .get_attribute("src", timeout=8000)
                    if img_src and ("disabled" in img_src.lower() or "off" in img_src.lower()):
                        break
                    await frame_visualizacao.locator("#lnkInfraProximaPaginaSuperior").click(timeout=15000)
                    await asyncio.sleep(2)
                    pagina += 1
                except:
                    break

            logging.info(f"{numero}: {len(historico)} andamentos extraídos com sucesso")

        except Exception as e:
            logging.error(f"Erro ao extrair {numero}: {str(e)}")

        return historico


    async def run(self):
        processos = carregar_processos()
        if not processos:
            logging.error("Nenhum processo para processar.")
            return

        resultados: Dict[str, List[Dict]] = {}
        semaphore = asyncio.Semaphore(5)

        async with async_playwright() as p:
            browser = await p.chromium.launch(headless=True)
            context = await browser.new_context(
                accept_downloads=True,
                viewport={"width": 1920, "height": 1080},
                user_agent="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36"
            )

            # Login único
            login_page = await context.new_page()
            await self.login(login_page)
            await login_page.close()

            # Worker para cada processo
            async def worker(proc: str):
                async with semaphore:
                    page = await context.new_page()
                    try:
                        hist = await self.extrair_historico(page, proc)
                        resultados[proc] = hist
                        logging.info(f"{proc}: {len(hist)} andamentos")
                    finally:
                        await page.close()

            await asyncio.gather(*[worker(p) for p in processos], return_exceptions=True)

            await context.close()
            await browser.close()

        # Salva JSON final
        timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
        arquivo_final = DOWNLOADS_DIR / f"sei_historico_{self.org}_{timestamp}.json"
        with open(arquivo_final, "w", encoding="utf-8") as f:
            json.dump(resultados, f, indent=2, ensure_ascii=False)

        logging.info(f"FINALIZADO! JSON salvo em: {arquivo_final}")

        # Salva JSON
        timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
        arquivo_final = DOWNLOADS_DIR / f"sei_historico_{self.org}_{timestamp}.json"
        with open(arquivo_final, "w", encoding="utf-8") as f:
            json.dump(resultados, f, indent=2, ensure_ascii=False)

        logging.info(f"FINALIZADO! JSON salvo em: {arquivo_final}")

# =============================================
# EXECUÇÃO
# =============================================
if __name__ == "__main__":
    scraper = SEIScraper()
    asyncio.run(scraper.run())