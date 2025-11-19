# pip install sqlalchemy pandas python-dotenv oracledb

# Grant Connection -- garanta a conexão ao user

import os
import time
import logging
import pandas as pd
import re
import oracledb
from sqlalchemy import create_engine
from datetime import datetime
from selenium import webdriver
from selenium.webdriver.edge.service import Service
from selenium.webdriver.edge.options import Options
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.common.exceptions import TimeoutException, NoSuchElementException
from dotenv import load_dotenv
from io import StringIO
from pathlib import Path

load_dotenv(dotenv_path=Path(r"C:\Users\luiz.smorais\Documents\MS\STAGE\STAGE.env"))

# Execute esta célula isoladamente (reinicie o kernel antes se já editou o .env)
from dotenv import load_dotenv
from pathlib import Path
import os
import oracledb

env_path = Path(r"C:\Users\luiz.smorais\Documents\MS\STAGE\STAGE.env")
print("load_dotenv from:", env_path)
load_dotenv(dotenv_path=env_path, override=True)

# Mostrar variáveis (mascare a senha ao logar)
def show(var):
    v = os.getenv(var)
    print(f"{var} exists:", bool(v), " value repr:", repr(v) if v else None)

show("ORACLE_USER")
show("ORACLE_PASS")
show("ORACLE_HOST")
show("ORACLE_PORT")
show("ORACLE_SERVICE")

# Preparar valores (strip para evitar espaços invisíveis)
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
    
user = os.getenv("ORACLE_USER")
password = os.getenv("ORACLE_PASS")
host = os.getenv("ORACLE_HOST")
port = os.getenv("ORACLE_PORT")
service = os.getenv("ORACLE_SERVICE")

db_url = f"oracle+oracledb://{user}:{password}@{host}:{port}/?service_name={service}"
engine = create_engine(db_url, connect_args={"mode":oracledb.SYSDBA})

print("DB host/service:", f"{host}:{port}/{service}")

print(db_url)

query = """
SELECT *
FROM STAGE.MEC_AQUISICAO
"""
documentos = pd.read_sql(query, engine)
df_documentos = pd.DataFrame(documentos)
display(df_documentos)


# Extrair lista de processos
processos = df_documentos["num_processo_sei"].astype(str).tolist()

logging.info(f"{len(processos)} processos carregados do banco de dados.")


import time
import logging
import pandas as pd
from io import StringIO
from datetime import datetime
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.edge.service import Service
from selenium.webdriver.edge.options import Options
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from dotenv import load_dotenv
from io import StringIO
from pathlib import Path

# Carregar variáveis de ambiente
load_dotenv()

EDGE_DRIVER_PATH=r"C:\Users\luiz.smorais\Documents\MS\STAGE\web-driver\edgedriver_win64\msedgedriver.exe"
DOWNLOAD_DIR=r"C:\Users\luiz.smorais\Documents\MS\STAGE\downloads"

logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s - %(levelname)s - %(message)s",
    handlers=[logging.FileHandler("sei_automation.log"), logging.StreamHandler()],
)

def substituir_caracteres_especiais(nome):
    return re.sub(r'[^\w\s]', '_', nome)

def garantir_diretorio_download(diretorio):
    if not os.path.exists(diretorio):
        os.makedirs(diretorio)
        logging.info(f"Diretório de download criado: {diretorio}")

def realizar_login(driver, usuario, senha, orgao):
    driver.get('https://sei.saude.gov.br/')
    logging.info("Página de login do SEI carregada com sucesso.")
    usuario_field = WebDriverWait(driver, 60).until(EC.visibility_of_element_located((By.ID, 'txtUsuario')))
    senha_field = WebDriverWait(driver, 60).until(EC.visibility_of_element_located((By.ID, 'pwdSenha')))
    orgao_field = WebDriverWait(driver, 60).until(EC.visibility_of_element_located((By.ID, 'selOrgao')))
    usuario_field.send_keys(usuario)
    senha_field.send_keys(senha)
    orgao_field.send_keys(orgao)
    senha_field.send_keys(Keys.RETURN)
    logging.info("Login realizado com sucesso.")

def alternar_para_iframe(driver, id_iframe):
    WebDriverWait(driver, 15).until(EC.frame_to_be_available_and_switch_to_it((By.ID, id_iframe)))
    logging.info(f"Alternando para o iframe '{id_iframe}'.")

def pesquisar_processo(driver, Processo):
    pesquisa = WebDriverWait(driver, 15).until(EC.visibility_of_element_located((By.ID, 'txtPesquisaRapida')))
    pesquisa.clear()
    pesquisa.send_keys(Processo)
    pesquisa.send_keys(Keys.RETURN)
    time.sleep(10)
    logging.info(f"Processo {Processo} pesquisado.")
    logging.info(f"URL atual após pesquisa: {driver.current_url}")
    if "Não foram encontrados documentos" in driver.page_source:
        logging.warning(f"Processo {Processo} não encontrado.")
        return False
    return True

def extrair_dados_tabela(driver, Processo):
    df_todos_dados = pd.DataFrame()
    pagina_atual = 1
    while True:
        try:
            tabela = WebDriverWait(driver, 60).until(EC.visibility_of_element_located((By.ID, 'tblHistorico')))
            tabela_html = tabela.get_attribute('outerHTML')
            tabela_io = StringIO(tabela_html)
            df_tabela = pd.read_html(tabela_io)[0]
            df_tabela['Processo'] = Processo
            df_todos_dados = pd.concat([df_todos_dados, df_tabela], ignore_index=True)

            pagina_seletor = WebDriverWait(driver, 60).until(EC.visibility_of_element_located((By.XPATH, '//*[@id="selInfraPaginacaoSuperior"]')))
            total_opcoes = len(pagina_seletor.find_elements(By.TAG_NAME, 'option'))

            if pagina_atual < total_opcoes:
                pagina_atual += 1
                driver.execute_script(
                    "arguments[0].value = arguments[1]; arguments[0].dispatchEvent(new Event('change'));",
                    pagina_seletor, pagina_atual
                )
                logging.info(f"Navegando para a página {pagina_atual}.")
                WebDriverWait(driver, 30).until(
                    EC.presence_of_element_located((By.ID, 'tblHistorico'))
                )
            else:
                break
        except Exception as e:
            logging.error(f"Erro ao extrair dados da tabela: {str(e)}")
            break

    df_todos_dados.drop_duplicates(inplace=True)
    data_atual = datetime.now().strftime('%Y-%m-%d')
    nome_arquivo_csv = f'andamento_{data_atual}.csv'
    output_csv_path = os.path.join(DOWNLOAD_DIR, nome_arquivo_csv)
    df_todos_dados.to_csv(
        output_csv_path,
        mode='a',
        header=not os.path.exists(output_csv_path),
        index=False,
        encoding='utf-8'
    )
    logging.info(f"Tabela de andamento para o processo {Processo} salva em {output_csv_path}.")

def pesquisar_e_processar_documentos(driver, processos):
    for Processo in processos:
        nome_arquivo = substituir_caracteres_especiais(Processo)
        try:
            logging.info(f"Iniciando a busca do processo {Processo}.")
            if not pesquisar_processo(driver, Processo):
                continue
            alternar_para_iframe(driver, 'ifrArvore')
            botao_consultar = WebDriverWait(driver, 60).until(EC.visibility_of_element_located((By.CSS_SELECTOR, '#divConsultarAndamento > a')))
            if botao_consultar.is_displayed() and botao_consultar.is_enabled():
                driver.execute_script("arguments[0].click();", botao_consultar)
            logging.info("Botão 'Consultar Andamento' clicado.")
            time.sleep(2)
            driver.switch_to.default_content()
            alternar_para_iframe(driver, 'ifrVisualizacao')            
            WebDriverWait(driver, 30).until(
                EC.presence_of_element_located((By.ID, 'tblHistorico'))
            )         
            try:
                botao_historico_completo = WebDriverWait(driver, 15).until(EC.visibility_of_element_located((By.ID, 'ancTipoHistorico')))
                if "Ver histórico completo" in botao_historico_completo.text and botao_historico_completo.is_displayed():
                    driver.execute_script("arguments[0].click();", botao_historico_completo)
                    logging.info(f"Botão 'Ver histórico completo' clicado para o processo {Processo}.")
                    WebDriverWait(driver, 30).until(
                                EC.presence_of_element_located((By.ID, 'tblHistorico'))
                            )
            except Exception:
                logging.info(f"Botão 'Ver histórico completo' não disponível para o processo {Processo}.")

            extrair_dados_tabela(driver, Processo)

        except Exception as e:
            logging.error(f"Erro ao processar o processo {Processo}: {str(e)}")
        finally:
            driver.get('https://sei.saude.gov.br/')

def main():
    edge_options = Options()
    edge_options.add_experimental_option('prefs', {
        'download.default_directory': DOWNLOAD_DIR,
        'download.prompt_for_download': False,
        'download.directory_upgrade': True,
        'safebrowsing.enabled': True
    })
    service = Service(EDGE_DRIVER_PATH)
    driver = webdriver.Edge(service=service, options=edge_options)
    logging.info("WebDriver do Edge inicializado com sucesso.")

    garantir_diretorio_download(DOWNLOAD_DIR)

    usuario_env = os.getenv('USUARIO')
    senha_env = os.getenv('SENHA')
    orgao_env = os.getenv('ORGAO')

    if not all([usuario_env, senha_env, orgao_env]):
        logging.error("Variáveis de ambiente USUARIO, SENHA ou ORGAO não configuradas.")
        raise ValueError("Variáveis de ambiente ausentes.")

    realizar_login(driver, usuario_env, senha_env, orgao_env)

    # Exemplo de lista de processos
    pesquisar_e_processar_documentos(driver, processos)

    driver.quit()
    logging.info("Navegador fechado.")

if __name__ == "__main__":
    main()
    
