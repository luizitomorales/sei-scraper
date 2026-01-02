#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import os
import asyncio
import logging
from pathlib import Path
from typing import List, Dict
from datetime import datetime, timezone
import json
import pandas as pd
from dotenv import load_dotenv
from playwright.async_api import async_playwright, Page, Frame
import re
import oracledb
from sqlalchemy import create_engine
from datetime import datetime


# ============================================================
# CONFIGURAÇÃO
# ============================================================

BASE_DIR = Path(__file__).parent.resolve()
ENV_PATH = BASE_DIR / "STAGE.env"

load_dotenv(ENV_PATH)

USUARIO = os.getenv("USUARIO")
SENHA   = os.getenv("SENHA")
ORGAO   = os.getenv("ORGAO")

logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s - %(levelname)s - %(message)s"
)

# ============================================================
# ACESSO AO BANCO
# ============================================================

user = (os.getenv("ORACLE_USER") or "").strip()
pwd  = (os.getenv("ORACLE_PASS") or "").strip()
host = (os.getenv("ORACLE_HOST") or "").strip()
port = (os.getenv("ORACLE_PORT") or "1521").strip()
service = (os.getenv("ORACLE_SERVICE") or "").strip()

dsn = f"{host}:{port}/{service}"
print("DSN:", dsn)

# Tentar conexão direta com oracledb para obter erro claro
try:
    conn = oracledb.connect(user=user, password=pwd, dsn=dsn)
    print("Conexão OK — usuário conectado:", conn.username)
    conn.close()
except Exception as e:
    # imprime erro detalhado para diagnosticar (não compartilhe em logs públicos)
    print("Conexão falhou:", type(e).__name__, "-", e)
    # dica rápida: ORA-28009 = SYS precisa de mode=SYSDBA; ORA-01017 = credenciais inválidas/conta bloqueada

# ============================================================
# CARREGAMENTO DE PROCESSOS VIA QUERY DO BANCO ORACLE
# ============================================================


from typing import List
import logging
import pandas as pd


def carregar_processos(engine) -> List[str]:
    """
    Carrega números de processos SEI a partir do banco de dados.
    Retorna lista única, limpa e ordenada conforme extração.
    """

    query = """
        SELECT num_processo_sei
        FROM STAGE.MEC_AQUISICAO
        WHERE num_processo_sei IS NOT NULL
    """

    try:
        logging.info("Executando query para carregar processos do banco de dados")
        df = pd.read_sql(query, engine)

    except Exception as e:
        logging.error("Erro ao executar query no banco de dados: %s", e)
        return []

    if df.empty:
        logging.warning("Query executada, mas nenhum processo foi retornado")
        return []

    # Normalização e limpeza
    processos = (
        df["num_processo_sei"]
        .astype(str)
        .str.strip()
        .tolist()
    )

    # Remove duplicados mantendo ordem
    processos = list(dict.fromkeys(processos))

    logging.info(f"{len(processos)} processos carregados do banco de dados")
    return processos


# ============================================================
# UTILITÁRIOS DE IFRAME (CHAVE DO SUCESSO)
# ============================================================
async def get_frame(page: Page, name: str, timeout=30000) -> Frame:
    for _ in range(int(timeout / 500)):
        for f in page.frames:
            if f.name == name:
                return f
        await asyncio.sleep(0.5)
    raise TimeoutError(f"Iframe '{name}' não encontrado")

# ============================================================
# SCRAPER
# ============================================================
class SEIScraper:

    async def login(self, page: Page):
        logging.info("Login no SEI")
        await page.goto("https://sei.saude.gov.br/", timeout=150000)

        await page.fill("#txtUsuario", USUARIO)
        await page.fill("#pwdSenha", SENHA)
        await page.select_option("#selOrgao", label=ORGAO)
        await page.click("#sbmAcessar")

        await page.wait_for_selector("#txtPesquisaRapida")
        logging.info("Login concluído")

    async def processar_processo(self, page: Page, processo: str) -> List[Dict]:
        logging.info(f"[{processo}] Iniciando")

        historico = []

        # === BUSCA ===
        await page.fill("#txtPesquisaRapida", processo)
        await page.keyboard.press("Enter")
        await page.wait_for_timeout(800)

        # === IFRAME ARVORE ===
        frame_arvore = await get_frame(page, "ifrArvore")

        btn = frame_arvore.locator("#divConsultarAndamento > a")
        await btn.wait_for(timeout=60000)
        await btn.click()

        logging.info(f"[{processo}] Consultar andamento clicado")

        # CRÍTICO: aguardar reload interno
        await page.wait_for_timeout(1000)

        # === IFRAME VISUALIZAÇÃO ===
        frame_visual = await get_frame(page, "ifrVisualizacao")

        # === HISTÓRICO (ID FIXO, SEM TEXTO) ===
        anc = frame_visual.locator("#ancTipoHistorico")
        await anc.wait_for(timeout=50000)

        await anc.click()
        logging.info(f"[{processo}] Histórico alternado (completo/resumido)")

        # após clique, iframe recarrega internamente → rebind
        await page.wait_for_timeout(800)
        frame_visual = await get_frame(page, "ifrVisualizacao")

        # === TABELA ===
        await frame_visual.wait_for_selector("#tblHistorico", timeout=30000)

        while True:
            count = await frame_visual.locator("#tblHistorico tbody tr").count()

            for i in range(count):
                try:
                    row = frame_visual.locator("#tblHistorico tbody tr").nth(i)
                    cols = await row.locator("td").all_text_contents()
                except Exception:
                    # iframe foi recriado pelo SEI
                    await asyncio.sleep(0.5)
                    frame_visual = await get_frame(page, "ifrVisualizacao")
                    row = frame_visual.locator("#tblHistorico tbody tr").nth(i)
                    cols = await row.locator("td").all_text_contents()

                if len(cols) >= 4:
                    historico.append({
                        "data_hora": cols[0].strip(),
                        "unidade": cols[1].strip(),
                        "usuario": cols[2].strip(),
                        "descricao": cols[3].strip(),
                    })

            # PAGINAÇÃO
            img = frame_visual.locator("#lnkInfraProximaPaginaInferior img")
            if await img.count() == 0:
                break
            
            src = await img.get_attribute("src")
            if not src or "proxima_off" in src:
                break
            
            await frame_visual.locator("#lnkInfraProximaPaginaInferior").click()
            await asyncio.sleep(0.8)
        
            # rebinding OBRIGATÓRIO após paginação
            frame_visual = await get_frame(page, "ifrVisualizacao")
        logging.info(f"[{processo}] Finalizado ({len(historico)} registros)")
        
        coleta = {
    "processo": processo,
    "timestamp_coleta": datetime.now().isoformat(),
    "total_registros": len(historico),
    "historico": historico
}

        self.salvar_historico(coleta)

        
        return [    ]

def salvar_historico(self, coleta: Dict):
    data = coleta["timestamp_coleta"][:10]  # YYYY-MM-DD
    processo = coleta["processo"].replace("/", "_")

    base = BASE_DIR / "output" / "historico" / data
    base.mkdir(parents=True, exist_ok=True)

    arquivo = base / f"{processo}.json"

    with open(arquivo, "w", encoding="utf-8") as f:
        json.dump(coleta, f, ensure_ascii=False, indent=2)

    logging.info(f"[{coleta['processo']}] Histórico salvo em {arquivo}")

# ==========================================================
# MAIN
# ==========================================================

async def main():
    processos = carregar_processos()

    async with async_playwright() as p:
        browser = await p.chromium.launch(headless=False)
        page = await browser.new_page()

        scraper = SEIScraper()
        await scraper.login(page)

        for proc in processos:
            tentativas = 2
            sucesso = False
        
            for tentativa in range(1, tentativas + 1):
                try:
                    logging.info(f"[{proc}] Tentativa {tentativa}/{tentativas}")
                    resultado = await scraper.processar_processo(page, proc)
        
                    if resultado:
                        sucesso = True
                        break
                    else:
                        raise RuntimeError("Histórico vazio")
        
                except Exception as e:
                    logging.error(f"[{proc}] Falha na tentativa {tentativa}: {e}")
        
                    # backoff progressivo
                    espera = 2 ** tentativa
                    logging.info(f"[{proc}] Backoff {espera}s antes da próxima tentativa")
                    await asyncio.sleep(espera)
        
                    # reset seguro de estado
                    await page.goto("https://sei.saude.gov.br/", timeout=120000)
                    await page.wait_for_selector("#txtPesquisaRapida")
        
            if not sucesso:
                logging.error(f"[{proc}] FALHA DEFINITIVA após {tentativas} tentativas")


if __name__ == "__main__":
    asyncio.run(main())