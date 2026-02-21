-- MODELAMIENTO DE BASES DE DATOS 001A

-- PROYECTO SEMANA 7 - Holding Carpenter SPA

-- GRUPO N°10
-- SEBASTIAN RODRIGUEZ / MATIAS SUAREZ

/* 
===================================
    CREACION USUARIO SOLICITADO
===================================
*/

CREATE USER PRY2204_S7 
IDENTIFIED BY "PRY2204.semana_7"
DEFAULT TABLESPACE DATA
TEMPORARY TABLESPACE TEMP
QUOTA UNLIMITED ON DATA;

GRANT CREATE SESSION TO PRY2204_S7;

GRANT RESOURCE TO PRY2204_S7;

ALTER USER PRY2204_S7 DEFAULT ROLE RESOURCE;

/* 
================================
    ELIMINACION DE TABLAS
        Y SECUENCIAS
================================
*/
DROP SEQUENCE SEQ_COMUNA;
DROP SEQUENCE SEQ_COMPANIA;

DROP TABLE TITULACION;
DROP TABLE TITULO;
DROP TABLE DOMINIO;
DROP TABLE IDIOMA;
DROP TABLE PERSONAL;
DROP TABLE GENERO;
DROP TABLE COMPANIA;
DROP TABLE COMUNA;
DROP TABLE REGION;
DROP TABLE ESTADO_CIVIL;



/* 
====================================
        CREACION DE CASOS
              CASO 1
====================================
*/


CREATE TABLE COMPANIA 
( 
id_empresa NUMBER (2) NOT NULL, 
nombre_empresa VARCHAR2 (25) NOT NULL, 
calle VARCHAR2 (50) NOT NULL, 
numeracion NUMBER (5) NOT NULL, 
renta_promedio NUMBER (10) NOT NULL, 
pct_aumento NUMBER (4,3), 
cod_comuna NUMBER (5) NOT NULL,
cod_region NUMBER (2) NOT NULL,

CONSTRAINT COMPANIA_PK PRIMARY KEY (id_empresa),
CONSTRAINT COMPANIA_UN_NOMBRE UNIQUE (nombre_empresa)
);

CREATE TABLE COMUNA 
( 
id_comuna NUMBER (5) NOT NULL, 
comuna_nombre VARCHAR2 (25) NOT NULL, 
cod_region NUMBER (2) NOT NULL,

CONSTRAINT COMUNA_PK PRIMARY KEY (id_comuna, cod_region)
);

CREATE TABLE DOMINIO 
( 
id_idioma NUMBER (3) NOT NULL, 
persona_rut NUMBER (8) NOT NULL, 
nivel VARCHAR2 (25) NOT NULL,

CONSTRAINT DOMINIO_PK PRIMARY KEY (id_idioma, persona_rut)
);

CREATE TABLE ESTADO_CIVIL 
( 
id_estado_civil VARCHAR2 (2)  NOT NULL, 
descripcion_est_civil VARCHAR2 (25) NOT NULL,

CONSTRAINT ESTADO_CIVIL_PK PRIMARY KEY (id_estado_civil)
);

CREATE TABLE GENERO 
( 
id_genero VARCHAR2 (3) NOT NULL, 
descripcion_genero VARCHAR2 (25) NOT NULL,

CONSTRAINT GENERO_PK PRIMARY KEY (id_genero)
);

CREATE TABLE IDIOMA 
( 
id_idioma NUMBER (3) GENERATED ALWAYS AS IDENTITY (START WITH 25 INCREMENT BY 3), 
nombre_idioma VARCHAR2 (30) NOT NULL,

CONSTRAINT IDIOMA_PK PRIMARY KEY (id_idioma)
);

CREATE TABLE PERSONAL 
( 
rut_persona NUMBER (8) NOT NULL, 
dv_persona CHAR (1) NOT NULL,
primer_nombre VARCHAR2 (25) NOT NULL, 
segundo_nombre VARCHAR2 (25), 
primer_apellido VARCHAR2 (25) NOT NULL, 
segundo_apellido VARCHAR2 (25) NOT NULL, 
fecha_contratacion DATE NOT NULL, 
fecha_nacimiento DATE NOT NULL, 
email VARCHAR2 (100), 
calle VARCHAR2 (50) NOT NULL, 
numeracion NUMBER (5) NOT NULL, 
sueldo NUMBER (5) NOT NULL, 
cod_comuna NUMBER (5) NOT NULL,
cod_region NUMBER (2) NOT NULL,
cod_genero VARCHAR2 (3), 
cod_estado_civil VARCHAR2 (2),
cod_empresa NUMBER (2) NOT NULL,
encargado_rut NUMBER (8),

CONSTRAINT PERSONAL_PK PRIMARY KEY (rut_persona)
);

CREATE TABLE REGION 
( 
id_region NUMBER (2) GENERATED ALWAYS AS IDENTITY (START WITH 7 INCREMENT BY 2), 
nombre_region VARCHAR2 (25) NOT NULL,

CONSTRAINT REGION_PK PRIMARY KEY (id_region)
);

CREATE TABLE TITULACION 
( 
cod_titulo VARCHAR2 (3) NOT NULL, 
persona_rut NUMBER (8) NOT NULL, 
fecha_titulacion DATE  NOT NULL,

CONSTRAINT TITULACION_PK PRIMARY KEY (cod_titulo, persona_rut)
);

CREATE TABLE TITULO 
( 
id_titulo VARCHAR2 (3) NOT NULL, 
descripcion_titulo VARCHAR2 (60) NOT NULL,

CONSTRAINT TITULO_PK PRIMARY KEY (id_titulo)
);


/* 
====================================
    CREACION DE CLAVES FORANEAS
====================================
*/

ALTER TABLE COMPANIA ADD CONSTRAINT COMPANIA_FK_COMUNA FOREIGN KEY (cod_comuna, cod_region) REFERENCES COMUNA (id_comuna, cod_region);

ALTER TABLE COMUNA ADD CONSTRAINT COMUNA_FK_REGION FOREIGN KEY (cod_region) REFERENCES REGION (id_region);

ALTER TABLE DOMINIO ADD CONSTRAINT DOMINIO_FK_IDIOMA FOREIGN KEY (id_idioma) REFERENCES IDIOMA (id_idioma);

ALTER TABLE DOMINIO ADD CONSTRAINT DOMINIO_FK_PERSONAL FOREIGN KEY (persona_rut) REFERENCES PERSONAL (rut_persona);

ALTER TABLE PERSONAL ADD CONSTRAINT PERSONAL_FK_COMPANIA FOREIGN KEY (cod_empresa) REFERENCES COMPANIA (id_empresa);

ALTER TABLE PERSONAL ADD CONSTRAINT PERSONAL_FK_COMUNA FOREIGN KEY (cod_comuna, cod_region) REFERENCES COMUNA (id_comuna, cod_region);

ALTER TABLE PERSONAL ADD CONSTRAINT PERSONAL_FK_ESTADO_CIVIL FOREIGN KEY (cod_estado_civil) REFERENCES ESTADO_CIVIL (id_estado_civil);

ALTER TABLE PERSONAL ADD CONSTRAINT PERSONAL_FK_GENERO FOREIGN KEY (cod_genero) REFERENCES GENERO (id_genero);

ALTER TABLE PERSONAL ADD CONSTRAINT PERSONAL_PERSONAL_FK FOREIGN KEY (encargado_rut) REFERENCES PERSONAL (rut_persona);

ALTER TABLE TITULACION ADD CONSTRAINT TITULACION_FK_PERSONAL FOREIGN KEY (persona_rut) REFERENCES PERSONAL (rut_persona);

ALTER TABLE TITULACION ADD CONSTRAINT TITULACION_FK_TITULO FOREIGN KEY (cod_titulo) REFERENCES TITULO (id_titulo);


/* 
====================================
            CASO 2
    CREACION DE CASOS CON ALTER
====================================
*/

-- Aunque el email de una persona es opcional, no se debe repetir.
ALTER TABLE PERSONAL ADD CONSTRAINT PERSONAL_UN_EMAIL UNIQUE (email);

-- El dígito verificador del RUN del PERSONAL debe estar en el siguiente listado: 0,1,2,3,4,5,6,7,8,9,’K’.
ALTER TABLE PERSONAL ADD CONSTRAINT PERSONAL_CK_DV CHECK (dv_persona IN ('0','1','2','3','4','5','6','7','8','9','K'));

-- Debes considerar que el sueldo mínimo del personal es de 450.000 pesos.
ALTER TABLE PERSONAL ADD CONSTRAINT PERSONAL_CK_SUELDO CHECK (sueldo >= 450000);

/* 
====================================
            CASO 3
    CREACION DE SEQUENCIAS
====================================
*/

-- Se conocen que hay del orden de 350 comunas. Por lo tanto, para poblar la tabla correspondiente debes usar una identificación numérica que comience en 1101 y que se incremente en 6 (usa objeto secuencia).
CREATE SEQUENCE seq_comuna START WITH 1101 INCREMENT BY 6;

-- Se sabe que el sistema debe administrar 7 compañías distintas, por un tema de seguridad el id_empresa debe iniciar en 10, y se debe incrementar en 5 unidades (usa objeto secuencia)
CREATE SEQUENCE seq_compania START WITH 10 INCREMENT BY 5;


/* 
====================================
            CASO 3
    POBLAMIENTO DEL MODELO
====================================
*/

-- Tabla REGION
INSERT INTO REGION (nombre_region) VALUES ('ARICA Y PARINACOTA');
INSERT INTO REGION (nombre_region) VALUES ('METROPOLITANA');
INSERT INTO REGION (nombre_region) VALUES ('LA ARAUCANIA');

-- Tabla IDIOMA
INSERT INTO IDIOMA (nombre_idioma) VALUES ('Ingles');
INSERT INTO IDIOMA (nombre_idioma) VALUES ('Chino');
INSERT INTO IDIOMA (nombre_idioma) VALUES ('Aleman');
INSERT INTO IDIOMA (nombre_idioma) VALUES ('Espanol');
INSERT INTO IDIOMA (nombre_idioma) VALUES ('Frances');

-- Tabla COMUNA
INSERT INTO COMUNA (id_comuna, comuna_nombre, cod_region) VALUES (seq_comuna.nextval,'Arica',7);
INSERT INTO COMUNA (id_comuna, comuna_nombre, cod_region) VALUES (seq_comuna.nextval,'Santiago',9);
INSERT INTO COMUNA (id_comuna, comuna_nombre, cod_region) VALUES (seq_comuna.nextval,'Temuco',11);


--Tabla COMPANIA
INSERT INTO compania (id_empresa, nombre_empresa, calle, numeracion, renta_promedio, pct_aumento, cod_comuna, cod_region) VALUES (seq_compania.nextval, 'CCyRojas', 'Amapolas', 506, 1857000, 0.5, 1101, 7);
INSERT INTO compania (id_empresa, nombre_empresa, calle, numeracion, renta_promedio, pct_aumento, cod_comuna, cod_region) VALUES (seq_compania.nextval, 'SenTTy', 'Los Alamos', 3490, 897000, 0.025, 1101, 7);
INSERT INTO compania (id_empresa, nombre_empresa, calle, numeracion, renta_promedio, pct_aumento, cod_comuna, cod_region) VALUES (seq_compania.nextval, 'Praxia LTDA', 'Las Camelias', 11098, 2157000, 0.035, 1107, 9);
INSERT INTO compania (id_empresa, nombre_empresa, calle, numeracion, renta_promedio, pct_aumento, cod_comuna, cod_region) VALUES (seq_compania.nextval, 'TIC spa', 'FLORES S.A.', 4357, 857000, NULL, 1107, 9);
INSERT INTO compania (id_empresa, nombre_empresa, calle, numeracion, renta_promedio, pct_aumento, cod_comuna, cod_region) VALUES (seq_compania.nextval, 'SANTANA LTDA', 'AVDA VIC. MACKENA', 106, 757000, 0.015, 1101, 7);
INSERT INTO compania (id_empresa, nombre_empresa, calle, numeracion, renta_promedio, pct_aumento, cod_comuna, cod_region) VALUES (seq_compania.nextval, 'FLORES Y ASOCIADOS', 'PEDRO LATORRE', 557, 589000, 0.015, 1107, 9);
INSERT INTO compania (id_empresa, nombre_empresa, calle, numeracion, renta_promedio, pct_aumento, cod_comuna, cod_region) VALUES (seq_compania.nextval, 'J.A. HOFFMAN', 'LATINA D.32', 509, 1857000, 0.025, 1113, 11);
INSERT INTO compania (id_empresa, nombre_empresa, calle, numeracion, renta_promedio, pct_aumento, cod_comuna, cod_region) VALUES (seq_compania.nextval, 'CAGLIARI D.', 'ALAMEDA', 206, 1857000, NULL, 1107, 9);
INSERT INTO compania (id_empresa, nombre_empresa, calle, numeracion, renta_promedio, pct_aumento, cod_comuna, cod_region) VALUES (seq_compania.nextval, 'Rojas HNOS LTDA', 'SUCRE', 106, 957000, 0.005, 1113, 11);
INSERT INTO compania (id_empresa, nombre_empresa, calle, numeracion, renta_promedio, pct_aumento, cod_comuna, cod_region) VALUES (seq_compania.nextval, 'FRIENDS P. S.A', 'SUECIA', 506, 857000, 0.015, 1113, 11);


/* 
====================================
            CASO 4
    RECUPERACION DE DATOS
      ---> INFORME 1 <---
====================================
*/

SELECT 
nombre_empresa AS "Nombre Empresa", 
calle || ' N°' || numeracion AS "Dirección", 
renta_promedio AS "Renta Promedio",
(renta_promedio * pct_aumento) + renta_promedio AS "Simulación de Renta"
FROM COMPANIA
ORDER BY 3 DESC, 1 ASC;

/* 
====================================
            CASO 4
    RECUPERACION DE DATOS
      ---> INFORME 2 <---
====================================
*/

SELECT 
id_empresa AS "CODIGO",
nombre_empresa AS "EMPRESA",
renta_promedio AS "PROM RENTA ACTUAL",
(pct_aumento + 0.15) AS "PCT AUMENTADO EN 15%",
renta_promedio * (pct_aumento + 0.15) AS "RENTA AUMENTADA"
FROM COMPANIA
ORDER BY 3 ASC, 1 DESC;

