# Carregar variáveis de ambiente do arquivo .env
load_dotenv()

# Configuração do caminho do WebDriver
EDGE_DRIVER_PATH = r"C:\Users\luiz.smorais\Documents\STAGE\DE-PARA SEI COMPRAS\web-driver\msedgedriver.exe"
DOWNLOAD_DIR = r"C:\Users\luiz.smorais\Documents\STAGE\downloads"

# Configuração de logs
logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s - %(levelname)s - %(message)s",
    handlers=[logging.FileHandler("sei_automation.log"), logging.StreamHandler()],
)

# Função para substituir caracteres especiais por _
def substituir_caracteres_especiais(nome):
    return re.sub(r'[^\w\s]', '_', nome)

# Função para garantir que o diretório de download exista
def garantir_diretorio_download(diretorio):
    try:
        if not os.path.exists(diretorio):
            os.makedirs(diretorio)
            logging.info(f"Diretório de download criado: {diretorio}")
    except Exception as e:
        logging.error(f"Erro ao criar o diretório de download: {str(e)}")
        raise

# Função para realizar login no SEI
def realizar_login(driver, usuario, senha, orgao):
    try:
        driver.get('https://sei.saude.gov.br/')
        logging.info("Página de login do SEI carregada com sucesso.")

        usuario_field = WebDriverWait(driver, 60).until(
            EC.presence_of_element_located((By.ID, 'txtUsuario'))
        )
        senha_field = WebDriverWait(driver, 60).until(
            EC.presence_of_element_located((By.ID, 'pwdSenha'))
        )
        orgao_field = WebDriverWait(driver, 60).until(
            EC.presence_of_element_located((By.ID, 'selOrgao'))
        )

        usuario_field.send_keys(usuario)
        senha_field.send_keys(senha)
        orgao_field.send_keys(orgao)
        senha_field.send_keys(Keys.RETURN)
        logging.info("Login realizado com sucesso.")
    except Exception as e:
        logging.error(f"Erro durante o login: {str(e)}")
        raise

# Função para aguardar iframe e alternar
def alternar_para_iframe(driver, id_iframe):
    WebDriverWait(driver, 15).until(EC.frame_to_be_available_and_switch_to_it((By.ID, id_iframe)))
    logging.info(f"Alternando para o iframe '{id_iframe}'.")

# Função para realizar a pesquisa do processo
def pesquisar_processo(driver, Processo):
    try:
        pesquisa = WebDriverWait(driver, 15).until(
            EC.presence_of_element_located((By.ID, 'txtPesquisaRapida'))
        )
        pesquisa.clear()
        pesquisa.send_keys(Processo)
        pesquisa.send_keys(Keys.RETURN)
        logging.info(f"Processo {Processo} pesquisado.")
        time.sleep(2)  # Espera adicional para garantir que o conteúdo carregue
    except Exception as e:
        logging.error(f"Erro ao pesquisar o processo {Processo}: {str(e)}")

# Função para extrair e salvar dados da tabela
def extrair_dados_tabela(driver, Processo, nome_arquivo):
    df_todos_dados = pd.DataFrame()
    pagina_atual = 1

    while True:
        try:
            tabela = WebDriverWait(driver, 60).until(
                EC.presence_of_element_located((By.CLASS_NAME, 'infraTable'))
            )
            tabela_html = tabela.get_attribute('outerHTML')
            tabela_io = StringIO(tabela_html)
            df_tabela = pd.read_html(tabela_io)[0]
            df_tabela['Processo'] = Processo
            df_todos_dados = pd.concat([df_todos_dados, df_tabela], ignore_index=True)

            pagina_seletor = WebDriverWait(driver, 60).until(
                EC.presence_of_element_located((By.XPATH, '//*[@id="selInfraPaginacaoSuperior"]'))
            )
            total_opcoes = len(pagina_seletor.find_elements(By.TAG_NAME, 'option'))

            if pagina_atual < total_opcoes:
                pagina_atual += 1
                driver.execute_script(
                    "arguments[0].value = arguments[1]; arguments[0].dispatchEvent(new Event('change'));",
                    pagina_seletor, pagina_atual
                )
                logging.info(f"Navegando para a página {pagina_atual}.")
                time.sleep(1)
            else:
                break
        except Exception as e:
            logging.error(f"Erro ao extrair dados da tabela: {str(e)}")
            break
    # Salvar output_csv
    df_todos_dados.drop_duplicates(inplace=True)

    data_atual=datetime.now().strftime('%Y-%m-%d')
    nome_arquivo_csv = f'andamento_{data_atual}.csv'
    output_csv_path = os.path.join(DOWNLOAD_DIR, nome_arquivo_csv)
    
    df_todos_dados.to_csv(
    output_csv_path,
    mode='a',  # append, não sobrescreve
    header=not os.path.exists(output_csv_path),  # escreve cabeçalho só se o arquivo não existir
    index=False,
    encoding='utf-8'
)

    logging.info(f"Tabela de andamento para o processo {Processo} salva em {output_csv_path}.")

# Função principal para pesquisar e processar documentos
processos_nao_processados = []
def pesquisar_e_processar_documentos(driver, processos):
    processos_nao_processados = []

    for Processo in processos:
        nome_arquivo = substituir_caracteres_especiais(Processo)

        try:
            logging.info(f"Iniciando a busca do processo {Processo}.")
            pesquisar_processo(driver, Processo)

            alternar_para_iframe(driver, 'ifrArvore')

            botao_consultar = WebDriverWait(driver, 60).until(
                EC.presence_of_element_located((By.CSS_SELECTOR, '#divConsultarAndamento > a'))
            )
            driver.execute_script("arguments[0].click();", botao_consultar)
            logging.info("Botão 'Consultar Andamento' clicado.")
            driver.switch_to.default_content()

            alternar_para_iframe(driver, 'ifrVisualizacao')

            # Tenta clicar em "Ver histórico resumido"
            try:
                botao_historico_resumido = WebDriverWait(driver, 15).until(
                    EC.presence_of_element_located((By.XPATH, '//*[@id="ancTipoHistorico" and contains(text(), "Ver histórico resumido")]'))
                )
                if botao_historico_resumido.is_displayed():
                    driver.execute_script("arguments[0].click();", botao_historico_resumido)
                    logging.info(f"Botão 'Ver histórico resumido' clicado para o processo {Processo}.")
                    extrair_dados_tabela(driver, Processo, nome_arquivo)
            except TimeoutException:
                logging.info(f"Botão 'Ver histórico resumido' não encontrado para o processo {Processo}.")

            # Sempre tenta clicar em "Ver histórico completo"
            try:
                botao_historico_completo = WebDriverWait(driver, 15).until(
                    EC.presence_of_element_located((By.XPATH, '//*[@id="ancTipoHistorico"]'))
                )
                driver.execute_script("arguments[0].click();", botao_historico_completo)
                logging.info(f"Botão 'Ver histórico completo' clicado para o processo {Processo}.")
                extrair_dados_tabela(driver, Processo, nome_arquivo)
            except TimeoutException:
                logging.warning(f"Botão 'Ver histórico completo' não encontrado para o processo {Processo}.")
                processos_nao_processados.append(Processo)

        except Exception as e:
            logging.error(f"Erro ao processar o processo {Processo}: {str(e)}")
            processos_nao_processados.append(Processo)

        finally:
            driver.get('https://sei.saude.gov.br/')

    # Reprocessamento automático
    if processos_nao_processados:
        logging.warning(f"Iniciando reprocessamento de {len(processos_nao_processados)} processos não processados.")
        for Processo in processos_nao_processados:
            try:
                logging.info(f"Reprocessando o processo {Processo}.")
                nome_arquivo = substituir_caracteres_especiais(Processo)
                pesquisar_processo(driver, Processo)
                alternar_para_iframe(driver, 'ifrArvore')
                botao_consultar = WebDriverWait(driver, 60).until(
                    EC.presence_of_element_located((By.CSS_SELECTOR, '#divConsultarAndamento > a'))
                )
                driver.execute_script("arguments[0].click();", botao_consultar)
                driver.switch_to.default_content()
                alternar_para_iframe(driver, 'ifrVisualizacao')

                botao_historico_completo = WebDriverWait(driver, 30).until(
                    EC.presence_of_element_located((By.XPATH, '//*[@id="ancTipoHistorico"]'))
                )
                driver.execute_script("arguments[0].click();", botao_historico_completo)
                logging.info(f"Botão 'Ver histórico completo' clicado no reprocessamento para o processo {Processo}.")
                extrair_dados_tabela(driver, Processo, nome_arquivo)

            except Exception as e:
                logging.error(f"Falha no reprocessamento do processo {Processo}: {str(e)}")

            finally:
                driver.get('https://sei.saude.gov.br/')


# Função principal
def main():
    try:
        # Configuração do WebDriver para o Edge
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

        # Garantir que o diretório de download exista
        garantir_diretorio_download(DOWNLOAD_DIR)

        # Obter valores das variáveis de ambiente do arquivo .env
        usuario_env = os.getenv('USUARIO')
        senha_env = os.getenv('SENHA')
        orgao_env = os.getenv('ORGAO')

        if not all([usuario_env, senha_env, orgao_env]):
            logging.error("Variáveis de ambiente USUARIO, SENHA ou ORGAO não configuradas no arquivo .env.")
            raise ValueError("Variáveis de ambiente ausentes.")

        # Realizar login
        realizar_login(driver, usuario_env, senha_env, orgao_env)

        ## Carregar os números de processo a partir do arquivo CSV
        #csv_dir = r'C:\Users\luiz.smorais\Documents\STAGE\processos'
        #csv_file = [f for f in os.listdir(csv_dir) if f.lower().endswith('.csv')]
        #csv_files_full_path = [os.path.join(csv_dir, f) for f in csv_file]
        #latest_csv = max(csv_files_full_path, key=os.path.getmtime)

        #df_documentos = pd.read_csv(latest_csv, sep=';', dtype={'Nº do Processo no SEI': str}, encoding='latin1')
        #logging.info("Arquivo CSV carregado com sucesso.")

        # Extrair processos do DataFrame
        #processos = df_documentos['Nº do Processo no SEI'].tolist()

        # Pesquisar e processar documentos
        pesquisar_e_processar_documentos(driver, processos)

    except Exception as e:
        logging.error(f"Erro durante a execução do script: {str(e)}")
    finally:
        # Fechar o navegador
        if 'driver' in locals():
            driver.quit()
            logging.info("Navegador fechado.")

if __name__ == "__main__":
    main()