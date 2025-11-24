.\venv\Scripts\activate

# 4. Instala tudo de uma vez
pip install --upgrade pip
pip install -r requirements.txt
playwright install chromium

# 5. Cria o STAGE.env com suas credenciais
notepad STAGE.env
# ← cola isso dentro do notepad e salva:
# USUARIO=luiz.smorais
# SENHA=DLog2026!
# ORGAO=MS
# ORACLE_USER=sys
# ORACLE_PASS=oracle
# ORACLE_HOST=10.1.45.234
# ORACLE_PORT=1521
# ORACLE_SERVICE=freepdb1

# 6. RODA O SCRAPER (finalmente na sua máquina!)
python SEI_SCRAPPER.py
