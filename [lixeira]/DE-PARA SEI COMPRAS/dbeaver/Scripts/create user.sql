/*ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;

CREATE USER testeEstrela IDENTIFIED BY "123";

GRANT CONNECT, RESOURCE TO testeEstrela;

-- Tablespace padrão
ALTER USER testeEstrela DEFAULT TABLESPACE USERS;

-- Tablespace temporária
ALTER USER testeEstrela TEMPORARY TABLESPACE TEMP;

-- Quota de uso no tablespace USERS
ALTER USER testeEstrela QUOTA UNLIMITED ON USERS;*/

SELECT tablespace_name FROM dba_tablespaces;*/
