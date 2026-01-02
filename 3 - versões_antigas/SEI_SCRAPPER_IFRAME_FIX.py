#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import os
import asyncio
import random
import logging
import json
from pathlib import Path
from typing import List, Dict
from datetime import datetime

import pandas as pd
from dotenv import load_dotenv
from playwright.async_api import async_playwright

BASE_DIR = Path(__file__).parent.resolve()
ENV_PATH = BASE_DIR / "STAGE.env"

load_dotenv(dotenv_path=ENV_PATH)

USUARIO = os.getenv("USUARIO")
SENHA   = os.getenv("SENHA")
ORGAO   = os.getenv("ORGAO")

logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s - %(levelname)s - %(message)s",
)

DOWNLOADS_DIR = BASE_DIR / "downloads"
DOWNLOADS_DIR.mkdir(exist_ok=True)

# ======================================================================
# 1. CARREGAMENTO DOS PROCESSOS
# ======================================================================

def carregar_processos() -> List[str]:

    # Caminho principal fornecido pelo usuário
    main_path = Path(r"/home/admin/sei-scraper/[lixeira]/processos/Relatorio de Aquisiçoes.csv")

    # Seleção entre caminho principal e alternativo
    if main_path.exists():
        csv_path = main_path
    else:
        alt_path = BASE_DIR / "lixeira" / "processos" / "Relatorio de Aquisiçoes.csv"
        if alt_path.exists():
            csv_path = alt_path
        else:
            logging.error("CSV não encontrado no caminho principal nem no alternativo:")
            logging.error(f" → {main_path}")
            logging.error(f" → {alt_path}")
            return []

    try:
        df = None
        last_exc = None

        # Teste de múltiplos encodings
        for enc in ("utf-8", "utf-8-sig", "cp1252", "latin-1"):
            try:
                df = pd.read_csv(csv_path, dtype=str, encoding=enc, sep=None, engine="python")
                logging.info(f"CSV lido com sucesso → {csv_path} (encoding={enc})")
                break
            except Exception as e_read:
                last_exc = e_read

        if df is None:
            raise last_exc

        # Seleciona coluna do processo
        col = next(
            (
                c for c in df.columns
                if any(kw in str(c).lower() for kw in ["processo", "nº", "sei"])
            ),
            df.columns[0]
        )

        processos = df[col].astype(str).str.strip().tolist()

        # Filtragem simples
        processos = [p for p in processos if p and p.lower() != "nan" and len(p) > 10]

        # Remove duplicados mantendo ordem
        processos = list(dict.fromkeys(processos))

        logging.info(f"{len(processos)} processos carregados do CSV")
        return processos

    except Exception as e:
        logging.error(f"Erro ao ler o CSV {csv_path}: {e}")
        return []

# ======================================================================
# 2. SCRAPER SEI CORRIGIDO (CARREGAMENTO DOS IFRAMES)
# ======================================================================

class SEIScraper:

    async def esperar_iframe(self, page, name: str, timeout=60000):
        """Espera o iframe existir e ser carregado."""
        await page.wait_for_selector(f'iframe[name="{name}"]', timeout=timeout)
        for _ in range(60):  # tentativas por ~6 segundos
            frame = page.frame(name=name)
            if frame:
                return frame
            await asyncio.sleep(0.1)
        return None

    async def login(self, page):
        await page.goto("https://sei.saude.gov.br/", timeout=150000)

        await page.wait_for_selector("#txtUsuario")
        await page.fill("#txtUsuario", USUARIO)
        await page.fill("#pwdSenha", SENHA)
        await page.select_option("#selOrgao", label=ORGAO)

        await page.click("#sbmAcessar")
        await page.wait_for_selector("#txtPesquisaRapida")

    async def extrair_historico(self, page, processo: str):

        # === 1. abrir busca rápida ===
        await page.fill("#txtPesquisaRapida", processo)
        await page.keyboard.press("Enter")

        # === 2. esperar iframe principal ===
        frame_visual = await self.esperar_iframe(page, "ifrVisualizacao", 120000)
        if not frame_visual:
            logging.error(f"{processo}: iframe ifrVisualizacao não carregou.")
            return []

        # === 3. esperar iframe arvore ===
        frame_arvore = await self.esperar_iframe(frame_visual, "ifrArvore", 120000)
        if not frame_arvore:
            frame_arvore = page.frame(name="ifrArvore")
        if not frame_arvore:
            logging.error(f"{processo}: iframe ifrArvore não carregou.")
            return []

        # === 4. esperar botão consultar andamento ===
        try:
            btn = frame_arvore.locator("a[onclick*='consultarAndamento']")
            await btn.wait_for(state="visible", timeout=90000)
        except:
            logging.error(f"{processo}: botão consultarAndamento não apareceu.")
            return []

        await btn.click()
        await asyncio.sleep(1)

        # === 5. esperar iframe conteúdo ===
        frame_conteudo = await self.esperar_iframe(page, "ifrConteudoVisualizacao", 120000)
        if not frame_conteudo:
            logging.error(f"{processo}: iframe ifrConteudoVisualizacao não carregou.")
            return []

        # === 6. clicar "Ver histórico completo" ===
        try:
            link = frame_conteudo.locator("a:has-text('Ver histórico completo')")
            await link.wait_for(state="visible", timeout=90000)
            await link.click()
        except:
            logging.error(f"{processo}: link 'Ver histórico completo' não apareceu.")
            return []

        await asyncio.sleep(1.2)

        # === 7. extrair tabela ===
        historico = []
        while True:
            try:
                rows = frame_conteudo.locator("#tblHistorico tbody tr")
                qtd = await rows.count()
            except:
                break

            for i in range(qtd):
                cols = await rows.nth(i).locator("td").all_text_contents()
                if len(cols) >= 4:
                    historico.append({
                        "data_hora": cols[0].strip(),
                        "unidade": cols[1].strip(),
                        "usuario": cols[2].strip(),
                        "descricao": cols[3].strip(),
                    })

            # paginar:
            try:
                nxt = frame_conteudo.locator("#lnkInfraProximaPaginaInferior img")
                src = await nxt.get_attribute("src")
                if "proxima_off" in src:
                    break
                await frame_conteudo.locator("#lnkInfraProximaPaginaInferior").click()
                await asyncio.sleep(1)
            except:
                break

        return historico


# ======================================================================
# 3. EXECUÇÃO PRINCIPAL
# ======================================================================

async def main():

    processos = carregar_processos()
    if not processos:
        logging.error("Nenhum processo carregado do CSV.")
        return

    resultados = {}

    async with async_playwright() as p:
        browser = await p.chromium.launch(headless=True)
        context = await browser.new_context()

        page = await context.new_page()
        scraper = SEIScraper()
        await scraper.login(page)

        for proc in processos:
            logging.info(f"Processo → {proc}")
            res = await scraper.extrair_historico(page, proc)
            resultados[proc] = res

        await browser.close()

    ts = datetime.now().strftime("%Y%m%d_%H%M%S")
    out = DOWNLOADS_DIR / f"sei_full_{ts}.json"

    with open(out, "w", encoding="utf-8") as f:
        json.dump(resultados, f, ensure_ascii=False, indent=2)

    logging.info(f"Histórico salvo em {out}")

if __name__ == "__main__":
    asyncio.run(main())
