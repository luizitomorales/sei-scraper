# sei_scraper.py
import json
import asyncio
import random
import os
import logging
import time
from pathlib import Path
from dataclasses import dataclass, asdict
from typing import List
from datetime import datetime
from playwright.async_api import async_playwright, Page
from dotenv import load_dotenv
from sqlalchemy import create_engine
import oracledb
import pandas as pd

# =============================================
# 1. CONFIGURAÇÃO
# =============================================
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

# Carregar .env
ENV_PATH = Path(r"STAGE.env")
load_dotenv(dotenv_path=ENV_PATH)

# --- SEI ---
usr = os.getenv("USUARIO")
pwd = os.getenv("SENHA")
org = os.getenv("ORGAO")  # ex: 110002530

# --- ORACLE ---
oracle_user = os.getenv("ORACLE_USER")
oracle_pass = os.getenv("ORACLE_PASS")
oracle_host = os.getenv("ORACLE_HOST")
oracle_port = os.getenv("ORACLE_PORT", "1521")
oracle_service = os.getenv("ORACLE_SERVICE")

# --- PASTA DE SAÍDA ---
timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
DOWNLOADS_DIR = Path.cwd() / "downloads"
DOWNLOADS_DIR.mkdir(exist_ok=True)
arquivo_json = DOWNLOADS_DIR / f"sei_historico_{org}_{timestamp}.json"
print(f"Arquivo será salvo em: {arquivo_json}")

# Validação
required = [usr, pwd, org, oracle_user, oracle_pass, oracle_host, oracle_service]
if not all(required):
    raise ValueError("Faltam variáveis no .env: USUARIO, SENHA, ORGAO, ORACLE_*")

# =============================================
# 2. CONEXÃO ORACLE (SYSDBA)
# =============================================
db_url = f"oracle+oracledb://@{oracle_host}:{oracle_port}/?service_name={oracle_service}"
engine = create_engine(db_url, connect_args={
    "user": oracle_user,
    "password": oracle_pass,
    "mode": oracledb.SYSDBA
})

def carregar_processos() -> List[str]:
    query = """
    SELECT num_processo_sei 
    FROM STAGE.MEC_AQUISICAO 
    WHERE num_processo_sei IS NOT NULL
    """
    try:
        df = pd.read_sql(query, engine)
        processos = df["num_processo_sei"].astype(str).dropna().tolist()
        logging.info(f"{len(processos)} processos carregados do Oracle.")
        return processos
    except Exception as e:
        logging.error(f"Erro ao carregar processos: {e}")
        return []

# =============================================
# 3. DATACLASS
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
# 4. PLAYWRIGHT SCRAPER
# =============================================
class SEIScraper:
    def __init__(self):
        self.usr = usr
        self.pwd = pwd
        self.org = org

    async def _human_type(self, page: Page, selector: str, text: str):
        await page.fill(selector, "")
        for char in text:
            await page.type(selector, char, delay=random.randint(50, 150))

    async def login(self, page: Page):
        await page.goto("https://sei.saude.gov.br/sip/login.php", timeout=60000)
        await self._human_type(page, "#txtUsuario", self.usr)
        await self._human_type(page, "#pwdSenha", self.pwd)
        await page.click("#sbmLogin")
        await page.wait_for_selector("#txtPesquisaRapida", timeout=30000)
        logging.info("Login realizado com sucesso!")

    async def extrair_historico(self, page: Page, numero: str) -> List[Andamento]:
        historico = []
        try:
            await self._human_type(page, "#txtPesquisaRapida", numero)
            await page.keyboard.press("Enter")
            await page.wait_for_timeout(3000)

            frame1 = page.frame_locator("#ifrVisualizacao").first
            await frame1.locator("//div[@id='divConsultarAndamento']/a").click(timeout=15000)
            await page.wait_for_timeout(2000)

            frame2 = page.frame_locator("#ifrArvore").first
            await frame2.locator("#ancTipoHistorico").click(timeout=15000)
            await page.wait_for_timeout(2000)

            pagina = 1
            while True:
                tabela = frame2.locator("#tblHistorico")
                rows = await tabela.locator("tbody tr").all()
                for row in rows:
                    cols = await row.locator("td").all_text_contents()
                    if len(cols) < 6: continue
                    docs = await row.locator("td:nth-child(6) a").all_text_contents()
                    historico.append(Andamento(
                        data=cols[0].strip(),
                        hora=cols[1].strip(),
                        unidade=cols[2].strip(),
                        usuario=cols[3].strip(),
                        acao=cols[4].strip(),
                        observacao=cols[5].split("\n")[0].strip(),
                        documentos=" | ".join(docs),
                        pagina=pagina
                    ))
                try:
                    next_btn = frame2.locator("#lnkInfraProximaPaginaSuperior")
                    img_src = await next_btn.locator("img").get_attribute("src")
                    if "disabled" in img_src:
                        break
                    await next_btn.click()
                    await page.wait_for_timeout(1000)
                    pagina += 1
                except:
                    break
            return historico
        except Exception as e:
            logging.error(f"Erro no scraping de {numero}: {e}")
            return []

    async def run(self):
        processos = carregar_processos()
        if not processos:
            logging.error("Nenhum processo carregado.")
            return

        resultados = {}
        MAX_CONCURRENT = 5
        sem = asyncio.Semaphore(MAX_CONCURRENT)

        async with async_playwright() as p:
            browser = await p.chromium.launch(headless=True)
            context = await browser.new_context(
                accept_downloads=True,
                downloads_path=str(DOWNLOADS_DIR.resolve()),
                viewport={"width": 1920, "height": 1080}
            )

            # Login único
            login_page = await context.new_page()
            await self.login(login_page)
            await login_page.close()

            async def worker(numero: str):
                async with sem:
                    page = await context.new_page()
                    try:
                        hist = await self.extrair_historico(page, numero)
                        resultados[numero] = [asdict(a) for a in hist]
                        logging.info(f"{numero}: {len(hist)} andamentos")
                    except Exception as e:
                        logging.error(f"Erro {numero}: {e}")
                        resultados[numero] = []
                    finally:
                        await page.close()

            tasks = [worker(proc) for proc in processos]
            await asyncio.gather(*tasks)
            await browser.close()

        # Salvar JSON
        timestamp = int(time.time())
        arquivo = DOWNLOADS_DIR / f"sei_historico_{self.org}_{timestamp}.json"
        with open(arquivo, "w", encoding="utf-8") as f:
            json.dump(resultados, f, indent=2, ensure_ascii=False)
        logging.info(f"JSON salvo: {arquivo}")

# =============================================
# 5. EXECUÇÃO
# =============================================
if __name__ == "__main__":
    scraper = SEIScraper()
    asyncio.run(scraper.run())