CREATE TABLE dim_tempo (
    id_tempo NUMBER PRIMARY KEY,
    data DATE,
    ano NUMBER,
    mes NUMBER,
    dia NUMBER,
    nome_mes VARCHAR2(20),
    nome_dia VARCHAR2(20)
);


CREATE TABLE dim_produto (
    id_produto NUMBER PRIMARY KEY,
    nome_produto VARCHAR2(100),
    categoria VARCHAR2(50),
    marca VARCHAR2(50),
    preco_unitario NUMBER(10,2)
);

CREATE TABLE dim_cliente (
    id_cliente NUMBER PRIMARY KEY,
    nome_cliente VARCHAR2(100),
    sexo CHAR(1),
    idade NUMBER,
    cidade VARCHAR2(50),
    estado VARCHAR2(2),
    pais VARCHAR2(50)
);

CREATE TABLE dim_vendedor (
    id_vendedor NUMBER PRIMARY KEY,
    nome_vendedor VARCHAR2(100),
    setor VARCHAR2(50),
    supervisor VARCHAR2(100)
);

DELETE IF EXISTS fato_vendas;
CREATE TABLE fato_vendas (
    id_venda NUMBER PRIMARY KEY,
    id_tempo NUMBER,
    id_produto NUMBER,
    id_cliente NUMBER,
    id_vendedor NUMBER,
    quantidade NUMBER,
    valor_total NUMBER(12,2),
    desconto NUMBER(5,2)
);

    -- Chaves estrangeiras
    FOREIGN KEY (id_tempo) REFERENCES dim_tempo(id_tempo),
    FOREIGN KEY (id_produto) REFERENCES dim_produto(id_produto),
    FOREIGN KEY (id_cliente) REFERENCES dim_cliente(id_cliente),
    FOREIGN KEY (id_vendedor) REFERENCES dim_vendedor(id_vendedor)
); 	