#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# Requisitos:
#   pip install -U playwright pandas python-dotenv
#   playwright install

import os
import re
import sys
import json
import asyncio
import logging
from pathlib import Path
from typing import List
from datetime import datetime, timedelta

import pandas as pd
from dotenv import load_dotenv
from playwright.async_api import async_playwright, Page, Browser, BrowserContext, TimeoutError as PwTimeout

# =========================================================
# CONFIG & LOG
# =========================================================
BASE_DIR = Path(__file__).resolve().parent
ENV_PATH = BASE_DIR / "STAGE.env"
load_dotenv(ENV_PATH)

SEI_URL  = os.getenv("SEI_URL")
USUARIO  = os.getenv("USUARIO")
SENHA    = os.getenv("SENHA")
ORGAO    = os.getenv("ORGAO")
HEADLESS = os.getenv("HEADLESS", "false").strip().lower() in {"1", "true", "yes"}

RECORTE_HORAS    = int(os.getenv("RECORTE_HORAS", "24"))
MAX_RETRY        = int(os.getenv("MAX_RETRY", "2"))
RETRY_BASE_SLEEP = int(os.getenv("RETRY_BASE_SLEEP", "2"))

if not all([SEI_URL, USUARIO, SENHA, ORGAO]):
    raise RuntimeError("Defina SEI_URL, USUARIO, SENHA e ORGAO em STAGE.env")

DOWNLOADS_ROOT = BASE_DIR / "downloads_playwright"
DOWNLOADS_ROOT.mkdir(parents=True, exist_ok=True)

PLANILHA_PATH = BASE_DIR / "7 - processos COPAD/Quantidado de Processos (1).xlsx"
MANIFEST_PATH = BASE_DIR / "downloads_manifest.json"

logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s - %(levelname)s - %(message)s"
)
log = logging.getLogger("sei_pdf")

# =========================================================
# UTILS
# =========================================================
def sanitize_processo_dir(processo: str) -> str:
    s = (processo or "").strip()
    s = re.sub(r'[\\/:*?"<>|]+', "_", s)
    s = re.sub(r"_+", "_", s).strip("_")
    return s or "processo_sem_numero"

def now_stamp() -> str:
    return datetime.now().strftime("%Y%m%d-%H%M%S")

def carregar_processos() -> List[str]:
    if not PLANILHA_PATH.exists():
        raise FileNotFoundError(f"Planilha não encontrada: {PLANILHA_PATH}")
    df = pd.read_excel(PLANILHA_PATH, dtype=str, engine="openpyxl")
    col = next((c for c in df.columns if "processo" in c.lower()), df.columns[0])
    processos = df[col].astype(str).str.strip().tolist()
    processos = [p for p in processos if p and p.lower() != "nan"]
    # únicos preservando ordem
    seen, uniq = set(), []
    for p in processos:
        if p not in seen:
            seen.add(p)
            uniq.append(p)
    log.info(f"{len(uniq)} processos carregados")
    return uniq

def _load_manifest() -> dict:
    if MANIFEST_PATH.exists():
        try:
            return json.loads(MANIFEST_PATH.read_text(encoding="utf-8"))
        except Exception:
            return {}
    return {}

def _save_manifest(manifest: dict) -> None:
    MANIFEST_PATH.write_text(json.dumps(manifest, ensure_ascii=False, indent=2), encoding="utf-8")

def _now_iso() -> str:
    return datetime.now().isoformat(timespec="seconds")

def pasta_tem_pdf(proc_dir: Path) -> bool:
    return any(p.suffix.lower() == ".pdf" for p in proc_dir.glob("*.pdf"))

def deve_baixar(processo: str, proc_dir: Path, recorte_horas: int, manifest: dict) -> tuple[bool, str]:
    if pasta_tem_pdf(proc_dir):
        return False, "already"

    recorte = timedelta(hours=max(recorte_horas, 0))
    info = (manifest.get(processo) or {})
    status = info.get("status")
    ts = info.get("timestamp")

    if status == "success" and ts:
        try:
            when = datetime.fromisoformat(ts)
            if datetime.now() - when < recorte:
                return False, "recent_success"
        except Exception:
            pass

    if status == "failed":
        return True, "retry_failed"

    return True, "new"

def marca_status(manifest: dict, processo: str, status: str, dest: Path | None = None, err: str | None = None) -> None:
    record = manifest.get(processo, {})
    record["status"] = status
    record["timestamp"] = _now_iso()
    if dest is not None:
        record["path"] = str(dest)
    if err is not None:
        record["error"] = err
    manifest[processo] = record

def compute_backoff(try_idx: int, base: int) -> int:
    return (2 ** (try_idx - 1)) * max(base, 1)

# =========================================================
# LOGIN
# =========================================================
async def fazer_login(page: Page) -> None:
    log.info("Login no SEI...")
    await page.goto(SEI_URL)
    await page.locator("#txtUsuario").fill(USUARIO)
    await page.locator("#pwdSenha").fill(SENHA)
    await page.select_option("#selOrgao", label=ORGAO)
    await page.locator("#sbmAcessar").click()
    await page.wait_for_selector("#txtPesquisaRapida")
    log.info("Login concluído")

# =========================================================
# FLUXO BÁSICO: PDF
# =========================================================
async def gerar_pdf_processo_basico(page: Page, numero_processo: str, root_downloads: Path) -> Path:
    # Pastas e nome do arquivo
    proc_dir = root_downloads / sanitize_processo_dir(numero_processo)
    proc_dir.mkdir(parents=True, exist_ok=True)
    destino = proc_dir / f"{sanitize_processo_dir(numero_processo)}_{now_stamp()}.pdf"

    # 1) Pesquisa
    await page.locator("#txtPesquisaRapida").fill(numero_processo)
    await page.keyboard.press("Enter")

    # 2) Wait: contêiner e iframe de conteúdo
    await page.wait_for_selector("#divIframeVisualizacao", timeout=20_000)
    await page.wait_for_selector("iframe#ifrConteudoVisualizacao", timeout=20_000)

    # 3) Entrar no iframe de conteúdo (onde está a barra #divArvoreAcoes)
    fl = page.frame_locator("#ifrConteudoVisualizacao")

    # 4) Clicar no PDF (sem fallbacks de layout)
    await fl.locator("#divArvoreAcoes").wait_for(state="visible", timeout=15_000)
    anchor_pdf = fl.locator("#divArvoreAcoes a[href*='acao=procedimento_gerar_pdf']")
    await anchor_pdf.first.scroll_into_view_if_needed()
    await anchor_pdf.first.click()

    # 5) No iframe de destino (target="ifrVisualizacao"): marcar 'Todos' e 'Gerar'
    #await page.wait_for_selector("iframe#ifrVisualizacao", timeout=20_000)
    frame_pdf = page.frame(name="ifrVisualizacao")

    # Selecionar "Todos"
    try:
        await frame_pdf.locator("label.infraRadioLabel[for='optTodos']").click()
    except Exception:
        await frame_pdf.locator("#optTodos, input[type='radio'][value='T']").check()

    # GERAR pela barra superior (prioritário)
    barra_gerar = frame_pdf.locator(
        "#divInfraBarraComandosSuperior >> xpath=.//*[contains(normalize-space(.), 'Gerar')]"
    )

    if await barra_gerar.count():
        await barra_gerar.first.scroll_into_view_if_needed()
        async with page.expect_download() as dl_info:
            await barra_gerar.first.click()
        download = await dl_info.value
        await download.save_as(str(destino))
    else:
        # fallback mínimo: input/button 'Gerar'
        btn_gerar = frame_pdf.locator(
            "input[name='btnGerar'], "
            "input[type='submit'][value*='Gerar'], "
            "input[type='button'][value*='Gerar'], "
            "button:has-text('Gerar')"
        ).first

        await btn_gerar.wait_for(state="visible", timeout=20_000)
        async with page.expect_download() as dl_info:
            await btn_gerar.click()
        download = await dl_info.value
        await download.save_as(str(destino))

    return destino

# =========================================================
# MAIN (com manifesto, skip e retry)
# =========================================================
class Counters:
    def __init__(self):
        self.skipped_already = 0
        self.skipped_recent = 0
        self.success = 0
        self.failed = 0
        self.retried = 0

    def log_summary(self):
        log.info(
            "Resumo: sucesso=%d | falha=%d | pulados_por_pasta=%d | pulados_por_recente=%d | retentativas=%d",
            self.success, self.failed, self.skipped_already, self.skipped_recent, self.retried
        )

async def run() -> None:
    processos = carregar_processos()
    manifest = _load_manifest()
    counters = Counters()

    async with async_playwright() as p:
        browser: Browser = await p.chromium.launch(
            headless=HEADLESS,
            args=["--start-maximized"] if not HEADLESS else ["--window-size=1920,1080"],
        )
        context: BrowserContext = await browser.new_context(
            accept_downloads=True,
            no_viewport=not HEADLESS,
        )
        page: Page = await context.new_page()

        await fazer_login(page)

        for proc in processos:
            proc_dir = DOWNLOADS_ROOT / sanitize_processo_dir(proc)
            doit, motivo = deve_baixar(proc, proc_dir, RECORTE_HORAS, manifest)

            if not doit:
                if motivo == "already":
                    counters.skipped_already += 1
                    log.info(f"[{proc}] pulado: já existe PDF na pasta")
                elif motivo == "recent_success":
                    counters.skipped_recent += 1
                    log.info(f"[{proc}] pulado: sucesso recente (< {RECORTE_HORAS}h)")
                continue

            tries = 0
            ok = False
            last_err = None

            while tries <= MAX_RETRY and not ok:
                tries += 1
                if tries > 1:
                    counters.retried += 1
                    sleep_s = compute_backoff(tries, RETRY_BASE_SLEEP)
                    log.info(f"[{proc}] nova tentativa {tries}/{MAX_RETRY+1} após {sleep_s}s…")
                    await asyncio.sleep(sleep_s)

                try:
                    destino = await gerar_pdf_processo_basico(page, proc, DOWNLOADS_ROOT)
                    marca_status(manifest, proc, "success", dest=destino)
                    _save_manifest(manifest)
                    counters.success += 1
                    log.info(f"[{proc}] PDF salvo em: {destino}")
                    ok = True
                except Exception as e:
                    last_err = str(e)
                    marca_status(manifest, proc, "failed", err=last_err)
                    _save_manifest(manifest)
                    if tries > MAX_RETRY:
                        counters.failed += 1
                        log.error(f"[{proc}] falhou após {tries} tentativa(s): {last_err}")
                    else:
                        log.warning(f"[{proc}] falhou (tentativa {tries}/{MAX_RETRY+1}): {last_err}")

                # Volta para a home para tentar o próximo / próxima tentativa
                try:
                    await page.goto(SEI_URL)
                    await page.wait_for_selector("#txtPesquisaRapida")
                except Exception:
                    pass

        counters.log_summary()
        await context.close()
        await browser.close()

def main():
    try:
        asyncio.run(run())
    except KeyboardInterrupt:
        print("\nInterrompido pelo usuário.")
        sys.exit(130)

if __name__ == "__main__":
    main()