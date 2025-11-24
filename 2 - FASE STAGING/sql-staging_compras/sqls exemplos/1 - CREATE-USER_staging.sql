-- Conecte-se como SYSDBA
-- Altere para o container FREEPDB1
ALTER SESSION SET CONTAINER = FREEPDB1;

-- Criar usuário local
CREATE USER staging IDENTIFIED BY "123";

-- Conceder roles básicas
GRANT CONNECT, RESOURCE TO staging;

-- Conceder privilégios adicionais para desenvolvimento
GRANT CREATE VIEW, CREATE PROCEDURE, CREATE SEQUENCE, CREATE TRIGGER TO staging;

-- Definir tablespaces
ALTER USER staging DEFAULT TABLESPACE USERS;
ALTER USER staging TEMPORARY TABLESPACE TEMP;
ALTER USER staging QUOTA UNLIMITED ON USERS;
