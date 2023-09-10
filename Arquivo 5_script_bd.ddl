-- Generated by Oracle SQL Developer Data Modeler 23.1.0.087.0806
--   at:        2023-09-09 22:36:12 BRT
--   site:      Oracle Database 11g
--   type:      Oracle Database 11g



DROP TABLE t_bairro CASCADE CONSTRAINTS;

DROP TABLE t_chamado CASCADE CONSTRAINTS;

DROP TABLE t_cidade CASCADE CONSTRAINTS;

DROP TABLE t_cliente CASCADE CONSTRAINTS;

DROP TABLE t_cliente_end CASCADE CONSTRAINTS;

DROP TABLE t_cliente_pf CASCADE CONSTRAINTS;

DROP TABLE t_cliente_pj CASCADE CONSTRAINTS;

DROP TABLE t_cliente_sessao CASCADE CONSTRAINTS;

DROP TABLE t_endereco CASCADE CONSTRAINTS;

DROP TABLE t_estado CASCADE CONSTRAINTS;

DROP TABLE t_func_cargo CASCADE CONSTRAINTS;

DROP TABLE t_func_departamento CASCADE CONSTRAINTS;

DROP TABLE t_funcionario CASCADE CONSTRAINTS;

DROP TABLE t_pedido CASCADE CONSTRAINTS;

DROP TABLE t_pedido_item CASCADE CONSTRAINTS;

DROP TABLE t_produto CASCADE CONSTRAINTS;

DROP TABLE t_produto_categ CASCADE CONSTRAINTS;

DROP TABLE t_video_categoria CASCADE CONSTRAINTS;

DROP TABLE t_video_produto CASCADE CONSTRAINTS;

DROP TABLE t_video_visualizacao CASCADE CONSTRAINTS;

-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE t_bairro (
    cd_bairro          NUMBER NOT NULL,
    nm_bairro          VARCHAR2(100),
    t_cidade_cd_cidade NUMBER(10) NOT NULL
);

ALTER TABLE t_bairro ADD CONSTRAINT t_bairro_pk PRIMARY KEY ( cd_bairro );

CREATE TABLE t_chamado (
    cd_chamado                          NUMBER(10) NOT NULL,
    ds_cliente                          VARCHAR2(4000 CHAR) NOT NULL,
    cls_chamado                         CHAR(1),
    dt_hr_abertura                      DATE NOT NULL,
    dt_hr_atendimento                   DATE,
    dt_hr_fechamento                    DATE,
    idx_satisfacao                      NUMBER(1),
    st_chamado                          CHAR(1) NOT NULL,
    t_cliente_cd_cliente                NUMBER(10) NOT NULL,
    tp_chamado                          CHAR(10) NOT NULL,
    t_produto_cd_produto                NUMBER NOT NULL, 
--  ERROR: Column name length exceeds maximum allowed length(30) 
    t_funcionario_t_func_cargo_cd_cargo NUMBER NOT NULL,
    t_produto_nm_produto                VARCHAR2(150 CHAR) NOT NULL,
    t_funcionario_cd_funcionario        NUMBER NOT NULL,
    t_cliente_t_cliente_id              NUMBER NOT NULL
);

ALTER TABLE t_chamado
    ADD CONSTRAINT cns_chamado_satisfacao CHECK ( idx_satisfacao BETWEEN 1 AND 10 );

ALTER TABLE t_chamado
    ADD CONSTRAINT cns_chamado_status CHECK ( st_chamado IN ( 'A', 'C', 'E', 'F', 'X' ) );

ALTER TABLE t_chamado
    ADD CONSTRAINT cns_chamado_tipo CHECK ( tp_chamado IN ( 'Reclamação', 'Sugestão' ) );

ALTER TABLE t_chamado ADD CONSTRAINT t_com_chamado_pk PRIMARY KEY ( cd_chamado );

CREATE TABLE t_cidade (
    cd_cidade          NUMBER(10) NOT NULL,
    nm_cidade          VARCHAR2(150 CHAR) NOT NULL,
    id_estado          NUMBER,
    t_estado_id_estado NUMBER NOT NULL
);

ALTER TABLE t_cidade ADD CONSTRAINT t_cidade_pk PRIMARY KEY ( cd_cidade );

CREATE TABLE t_cliente (
    t_cliente_id   NUMBER NOT NULL,
    cd_cliente     NUMBER(10) NOT NULL,
    nm_cliente     VARCHAR2(255 CHAR) NOT NULL,
    data_criacao   DATE NOT NULL,
    data_alteracao DATE
);

ALTER TABLE t_cliente ADD CONSTRAINT t_cliente_pk PRIMARY KEY ( t_cliente_id );

CREATE TABLE t_cliente_end (
    t_cliente_cd_cliente    NUMBER(10) NOT NULL,
    t_endereco_cd_endereco  NUMBER NOT NULL,
    nr_endereco             NUMBER(10) NOT NULL,
    compl_endereco          VARCHAR2(50 CHAR),
    fl_principal            CHAR(1 CHAR) NOT NULL,
    dt_criacao_endereco     DATE NOT NULL,
    dt_alteracao_endereco   DATE NOT NULL,
    t_endereco_cd_endereco2 NUMBER NOT NULL,
    t_cliente_t_cliente_id  NUMBER NOT NULL
);

ALTER TABLE t_cliente_end ADD CONSTRAINT t_cliente_end_pk PRIMARY KEY ( t_endereco_cd_endereco );

CREATE TABLE t_cliente_pf (
    t_cliente_t_cliente_id NUMBER NOT NULL,
    cd_cliente             NUMBER(10) NOT NULL,
    cd_cliente2            NUMBER NOT NULL,
    cpf                    VARCHAR2(11 CHAR) NOT NULL,
    sexo                   CHAR(1 CHAR),
    genero                 VARCHAR2(50 CHAR),
    data_nascimento        DATE NOT NULL
);

ALTER TABLE t_cliente_pf ADD CONSTRAINT t_cliente_pf_pk PRIMARY KEY ( t_cliente_t_cliente_id );

ALTER TABLE t_cliente_pf ADD CONSTRAINT t_cliente_pf_cd_cliente_un UNIQUE ( cd_cliente );

CREATE TABLE t_cliente_pj (
    t_cliente_t_cliente_id NUMBER NOT NULL,
    cd_cliente             NUMBER(10) NOT NULL,
    cd_cliente2            NUMBER NOT NULL,
    cnpj_cliente           VARCHAR2 
--  ERROR: VARCHAR2 size not specified 
     NOT NULL,
    insc_est_cliente       VARCHAR2 
--  ERROR: VARCHAR2 size not specified 
     NOT NULL,
    dt_fundacao            DATE NOT NULL
);

ALTER TABLE t_cliente_pj ADD CONSTRAINT t_cliente_pj_pk PRIMARY KEY ( t_cliente_t_cliente_id );

ALTER TABLE t_cliente_pj ADD CONSTRAINT t_com_cliente_pj_pk UNIQUE ( cd_cliente );

ALTER TABLE t_cliente_pj ADD CONSTRAINT t_cliente_pj_cd_cliente2_un UNIQUE ( cd_cliente2 );

CREATE TABLE t_cliente_sessao (
    cd_sessao              NUMBER NOT NULL,
    dt_hr_inicio_sessao    TIMESTAMP WITH LOCAL TIME ZONE NOT NULL,
    dt_hr_termino_sessao   TIMESTAMP WITH LOCAL TIME ZONE,
    dt_criacao_sessao      DATE NOT NULL,
    dt_alteracao_sessao    DATE NOT NULL,
    t_cliente_cd_cliente   NUMBER(10) NOT NULL,
    t_cliente_t_cliente_id NUMBER NOT NULL
);

ALTER TABLE t_cliente_sessao ADD CONSTRAINT t_cliente_sessao_pk PRIMARY KEY ( cd_sessao );

CREATE TABLE t_endereco (
    cd_endereco        NUMBER NOT NULL,
    ds_logradouro      VARCHAR2(200 CHAR) NOT NULL,
    cep_endereco       VARCHAR2(9 CHAR),
    t_bairro_cd_bairro NUMBER NOT NULL
);

ALTER TABLE t_endereco ADD CONSTRAINT t_endereco_pk PRIMARY KEY ( cd_endereco );

CREATE TABLE t_estado (
    id_estado NUMBER NOT NULL,
    cd_estado CHAR(2 CHAR),
    nm_estado VARCHAR2(100 CHAR),
    ds_regiao VARCHAR2(50 CHAR)
);

ALTER TABLE t_estado ADD CONSTRAINT t_estado_pk PRIMARY KEY ( id_estado );

CREATE TABLE t_func_cargo (
    cd_cargo           NUMBER NOT NULL,
    nm_cargo           VARCHAR2(150 CHAR) NOT NULL,
    dt_criacao_cargo   DATE NOT NULL,
    dt_alteracao_cargo DATE NOT NULL
);

ALTER TABLE t_func_cargo ADD CONSTRAINT t_func_cargo_pk PRIMARY KEY ( cd_cargo );

CREATE TABLE t_func_departamento (
    cd_departamento         NUMBER NOT NULL,
    nm_departamento         VARCHAR2(150 CHAR),
    cd_nivel                NUMBER,
    dt_criacao_departamento DATE,
    data_alteracao          DATE
);

ALTER TABLE t_func_departamento ADD CONSTRAINT t_func_departamento_pk PRIMARY KEY ( cd_departamento );

CREATE TABLE t_funcionario (
    cd_funcionario                      NUMBER NOT NULL,
    nm_funcionario                      VARCHAR2(10),
    dt_nascimento_func                  DATE,
    cpf_funcionario                     VARCHAR2(11 CHAR) NOT NULL,
    dt_criacao_func                     DATE NOT NULL,
    dt_alteracao_func                   DATE NOT NULL,
    cd_cargo                            NUMBER NOT NULL,
    t_func_cargo_cd_cargo               NUMBER NOT NULL,
    t_func_cargo_cd_cargo2              NUMBER NOT NULL, 
--  ERROR: Column name length exceeds maximum allowed length(30) 
    t_func_departamento_cd_departamento NUMBER NOT NULL
);

ALTER TABLE t_funcionario ADD CONSTRAINT t_funcionario_pk PRIMARY KEY ( cd_funcionario );

CREATE TABLE t_pedido (
    cd_pedido              NUMBER NOT NULL,
    t_cliente_cd_cliente   NUMBER(10) NOT NULL,
    dt_criacao_pedido      DATE NOT NULL,
    dt_alteracao_pedido    DATE NOT NULL,
    t_cliente_t_cliente_id NUMBER NOT NULL
);

ALTER TABLE t_pedido ADD CONSTRAINT t_pedido_pk PRIMARY KEY ( cd_pedido );

CREATE TABLE t_pedido_item (
    cd_pedido_item           NUMBER NOT NULL,
    qt_item                  NUMBER NOT NULL,
    vl_unitario              FLOAT NOT NULL,
    valor_total_item         FLOAT NOT NULL,
    dt_criacao_pedido_item   DATE NOT NULL,
    dt_alteracao_pedido_item DATE NOT NULL,
    t_produto_cd_produto     NUMBER NOT NULL,
    t_produto_nm_produto     VARCHAR2(150 CHAR) NOT NULL,
    t_pedido_cd_pedido       NUMBER NOT NULL
);

ALTER TABLE t_pedido_item ADD CONSTRAINT t_pedido_item_pk PRIMARY KEY ( cd_pedido_item );

CREATE TABLE t_produto (
    cd_produto                               NUMBER NOT NULL,
    nm_produto                               VARCHAR2(150 CHAR) NOT NULL,
    desc_produto                             VARCHAR2(300 CHAR) NOT NULL,
    desc_completa_produto                    VARCHAR2(1000 CHAR) NOT NULL,
    vl_unitario                              FLOAT NOT NULL,
    peso_gr                                  FLOAT(8) NOT NULL,
    altura_cm                                FLOAT NOT NULL,
    largura_cm                               FLOAT NOT NULL,
    comprimento_cm                           FLOAT NOT NULL,
    ean                                      VARCHAR2(13 CHAR),
    dt_criacao                               DATE NOT NULL,
    dt_alteracao                             DATE NOT NULL, 
--  ERROR: Column name length exceeds maximum allowed length(30) 
    t_produto_categoria_cd_categoria_produto NUMBER NOT NULL
);

ALTER TABLE t_produto ADD CONSTRAINT t_produto_nm_produto_un UNIQUE ( nm_produto );

ALTER TABLE t_produto ADD CONSTRAINT t_produto_desc_produto_un UNIQUE ( desc_produto );

CREATE TABLE t_produto_categ (
    cd_categoria_produto                     NUMBER NOT NULL,
    nm_categoria                             VARCHAR2(150 CHAR) NOT NULL,
    cd_nivel                                 NUMBER NOT NULL,
    st_categoria                             VARCHAR2(50 CHAR) NOT NULL,
    dt_inicio_categoria                      DATE NOT NULL,
    dt_termino_categoria                     DATE,
    dt_criacao_categoria                     DATE NOT NULL,
    dt_alteracao_categoria                   DATE NOT NULL, 
--  ERROR: Column name length exceeds maximum allowed length(30) 
    t_produto_categoria_cd_categoria_produto NUMBER NOT NULL
);

ALTER TABLE t_produto_categ ADD CONSTRAINT t_produto_categ_pk PRIMARY KEY ( cd_categoria_produto );

CREATE TABLE t_video_categoria (
    cd_video_categoria           NUMBER NOT NULL,
    nm_video_categoria           VARCHAR2(150 CHAR) NOT NULL,
    dt_criacao_video_categoria   DATE NOT NULL,
    dt_alteracao_video_categoria DATE NOT NULL
);

ALTER TABLE t_video_categoria ADD CONSTRAINT t_video_categoria_pk PRIMARY KEY ( cd_video_categoria );

CREATE TABLE t_video_produto (
    cd_video                              NUMBER NOT NULL,
    st_video                              VARCHAR2(50 CHAR) NOT NULL,
    t_produto_cd_produto                  NUMBER NOT NULL,
    dt_criacao_video                      DATE NOT NULL,
    dt_alteracao_video                    DATE NOT NULL, 
--  ERROR: Column name length exceeds maximum allowed length(30) 
    t_video_categoria_cd_video_categoria  NUMBER NOT NULL,
    t_produto_nm_produto                  VARCHAR2(150 CHAR) NOT NULL, 
--  ERROR: Column name length exceeds maximum allowed length(30) 
    t_video_categoria_cd_video_categoria2 NUMBER NOT NULL
);

ALTER TABLE t_video_produto ADD CONSTRAINT t_video_produto_pk PRIMARY KEY ( cd_video );

CREATE TABLE t_video_visualizacao (
    cd_visualizacao            NUMBER NOT NULL,
    dt_inicio_visualizacao     TIMESTAMP WITH LOCAL TIME ZONE NOT NULL,
    dt_termino_visualizacao    TIMESTAMP WITH LOCAL TIME ZONE,
    t_video_produto_cd_video   NUMBER NOT NULL,
    t_video_produto_cd_video2  NUMBER NOT NULL,
    t_cliente_sessao_cd_sessao NUMBER NOT NULL
);

ALTER TABLE t_video_visualizacao ADD CONSTRAINT t_video_visualizacao_pk PRIMARY KEY ( cd_visualizacao );

ALTER TABLE t_bairro
    ADD CONSTRAINT t_bairro_t_cidade_fk FOREIGN KEY ( t_cidade_cd_cidade )
        REFERENCES t_cidade ( cd_cidade );

ALTER TABLE t_chamado
    ADD CONSTRAINT t_chamado_t_cliente_fk FOREIGN KEY ( t_cliente_t_cliente_id )
        REFERENCES t_cliente ( t_cliente_id );

ALTER TABLE t_chamado
    ADD CONSTRAINT t_chamado_t_funcionario_fk FOREIGN KEY ( t_funcionario_cd_funcionario )
        REFERENCES t_funcionario ( cd_funcionario );

ALTER TABLE t_chamado
    ADD CONSTRAINT t_chamado_t_produto_fk FOREIGN KEY ( t_produto_nm_produto )
        REFERENCES t_produto ( nm_produto );

ALTER TABLE t_cidade
    ADD CONSTRAINT t_cidade_t_estado_fk FOREIGN KEY ( t_estado_id_estado )
        REFERENCES t_estado ( id_estado );

ALTER TABLE t_cliente_end
    ADD CONSTRAINT t_cliente_end_t_cliente_fk FOREIGN KEY ( t_cliente_t_cliente_id )
        REFERENCES t_cliente ( t_cliente_id );

ALTER TABLE t_cliente_end
    ADD CONSTRAINT t_cliente_end_t_endereco_fk FOREIGN KEY ( t_endereco_cd_endereco2 )
        REFERENCES t_endereco ( cd_endereco );

ALTER TABLE t_cliente_pf
    ADD CONSTRAINT t_cliente_pf_t_cliente_fk FOREIGN KEY ( t_cliente_t_cliente_id )
        REFERENCES t_cliente ( t_cliente_id );

ALTER TABLE t_cliente_pj
    ADD CONSTRAINT t_cliente_pj_t_cliente_fk FOREIGN KEY ( t_cliente_t_cliente_id )
        REFERENCES t_cliente ( t_cliente_id );

ALTER TABLE t_cliente_sessao
    ADD CONSTRAINT t_cliente_sessao_t_cliente_fk FOREIGN KEY ( t_cliente_t_cliente_id )
        REFERENCES t_cliente ( t_cliente_id );

ALTER TABLE t_endereco
    ADD CONSTRAINT t_endereco_t_bairro_fk FOREIGN KEY ( t_bairro_cd_bairro )
        REFERENCES t_bairro ( cd_bairro );

ALTER TABLE t_funcionario
    ADD CONSTRAINT t_funcionario_t_func_cargo_fk FOREIGN KEY ( t_func_cargo_cd_cargo2 )
        REFERENCES t_func_cargo ( cd_cargo );

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE t_funcionario
    ADD CONSTRAINT t_funcionario_t_func_departamento_fk FOREIGN KEY ( t_func_departamento_cd_departamento )
        REFERENCES t_func_departamento ( cd_departamento );

ALTER TABLE t_pedido_item
    ADD CONSTRAINT t_pedido_item_t_pedido_fk FOREIGN KEY ( t_pedido_cd_pedido )
        REFERENCES t_pedido ( cd_pedido );

ALTER TABLE t_pedido_item
    ADD CONSTRAINT t_pedido_item_t_produto_fk FOREIGN KEY ( t_produto_nm_produto )
        REFERENCES t_produto ( nm_produto );

ALTER TABLE t_pedido
    ADD CONSTRAINT t_pedido_t_cliente_fk FOREIGN KEY ( t_cliente_t_cliente_id )
        REFERENCES t_cliente ( t_cliente_id );

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE t_produto_categ
    ADD CONSTRAINT t_produto_categoria_t_produto_categoria_fk FOREIGN KEY ( t_produto_categoria_cd_categoria_produto )
        REFERENCES t_produto_categ ( cd_categoria_produto );

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE t_produto
    ADD CONSTRAINT t_produto_t_produto_categoria_fk FOREIGN KEY ( t_produto_categoria_cd_categoria_produto )
        REFERENCES t_produto_categ ( cd_categoria_produto );

ALTER TABLE t_video_produto
    ADD CONSTRAINT t_video_produto_t_produto_fk FOREIGN KEY ( t_produto_nm_produto )
        REFERENCES t_produto ( nm_produto );

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE t_video_produto
    ADD CONSTRAINT t_video_produto_t_video_categoria_fk FOREIGN KEY ( t_video_categoria_cd_video_categoria2 )
        REFERENCES t_video_categoria ( cd_video_categoria );

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE t_video_visualizacao
    ADD CONSTRAINT t_video_visualizacao_t_cliente_sessao_fk FOREIGN KEY ( t_cliente_sessao_cd_sessao )
        REFERENCES t_cliente_sessao ( cd_sessao );

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE t_video_visualizacao
    ADD CONSTRAINT t_video_visualizacao_t_video_produto_fk FOREIGN KEY ( t_video_produto_cd_video2 )
        REFERENCES t_video_produto ( cd_video );

--  ERROR: No Discriminator Column found in Arc FKArc_2 - constraint trigger for Arc cannot be generated 

--  ERROR: No Discriminator Column found in Arc FKArc_2 - constraint trigger for Arc cannot be generated

CREATE SEQUENCE t_cliente_t_cliente_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER t_cliente_t_cliente_id_trg BEFORE
    INSERT ON t_cliente
    FOR EACH ROW
    WHEN ( new.t_cliente_id IS NULL )
BEGIN
    :new.t_cliente_id := t_cliente_t_cliente_id_seq.nextval;
END;
/



-- Oracle SQL Developer Data Modeler Summary Report: 
-- 
-- CREATE TABLE                            20
-- CREATE INDEX                             0
-- ALTER TABLE                             49
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           1
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          1
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                  16
-- WARNINGS                                 0
