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
# CARREGAMENTO DE PROCESSOS
# ============================================================

def carregar_processos() -> List[str]:
    main_path = Path(r"/home/admin/sei-scraper/[lixeira]/processos/Relatorio de Aquisiçoes.csv")

    if main_path.exists():
        csv_path = main_path
    else:
        alt_path = BASE_DIR / "lixeira" / "processos" / "Relatorio de Aquisiçoes.csv"
        if alt_path.exists():
            csv_path = alt_path
        else:
            logging.error("CSV não encontrado")
            return []

    df = None
    for enc in ("utf-8", "utf-8-sig", "cp1252", "latin-1"):
        try:
            df = pd.read_csv(csv_path, dtype=str, encoding=enc, sep=None, engine="python")
            break
        except Exception:
            pass

    if df is None:
        return []

    col = next(
        (c for c in df.columns if any(k in c.lower() for k in ["processo", "sei", "nº"])),
        df.columns[0]
    )

    processos = (
        df[col]
        .astype(str)
        .str.strip()
        .tolist()
    )

    processos = [p for p in processos if p and p.lower() != "nan" and len(p) > 10]
    processos = list(dict.fromkeys(processos))

    logging.info(f"{len(processos)} processos carregados")
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

        
        return historico

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
            try:
                await scraper.processar_processo(page, proc)
            except Exception as e:
                logging.error(f"[{proc}] erro geral: {e}")

            # reset seguro
            await page.goto("https://sei.saude.gov.br/")
            await page.wait_for_timeout(800)

        await browser.close()


if __name__ == "__main__":
    asyncio.run(main())