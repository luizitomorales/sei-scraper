@"
FROM mcr.microsoft.com/playwright/python:v1.47.0-jammy
WORKDIR /app
COPY SEI_SCRAPPER.py .
COPY STAGE.env .
RUN pip install --no-cache-dir python-dotenv sqlalchemy pandas oracledb
CMD ["python", "SEI_SCRAPPER.py"]
"@ | Out-File -Encoding UTF8 Dockerfile