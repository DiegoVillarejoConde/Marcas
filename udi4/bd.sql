CREATE DATABASE proyectos;
USE proyectos;

CREATE TABLE clientes (
cod INT(2) PRIMARY KEY,
dir VARCHAR(25) NOT NULL,
tfno INT(9) NOT NULL
);


CREATE TABLE proyecto (
cod VARCHAR(5) PRIMARY KEY,
descripcion VARCHAR(50) NOT NULL,
cuantia INT(5) NOT NULL,
fechaini DATE NOT NULL,
fechafin DATE NOT NULL,
codcliente INT(2),
CONSTRAINT fk_codcliente FOREIGN KEY (codcliente) REFERENCES clientes(cod),
CONSTRAINT ck_cod CHECK (cod LIKE 'S%' OR cod LIKE 'T%'));


CREATE TABLE colaboradores (
nif VARCHAR(9)PRIMARY KEY,
nombre VARCHAR(25) NOT NULL,
apellidos VARCHAR(30) NOT NULL,
domicilio VARCHAR(50) NOT NULL,
tfno INT(9) NOT NULL,
banco VARCHAR(30) NOT NULL,
numerocuenta VARCHAR(30) NOT NULL,
CONSTRAINT ck_nombre CHECK (UPPER(LEFT(nombre,1))),
CONSTRAINT ck_banco CHECK (UPPER(LEFT(banco,1))));


CREATE TABLE colaboraciones (
codproyecto VARCHAR(5),
nifcolaborador VARCHAR(9),
CONSTRAINT fk_codproyecto FOREIGN KEY (codproyecto) REFERENCES proyecto(cod),
CONSTRAINT fk_nifcolaborador FOREIGN KEY (nifcolaborador) REFERENCES colaboradores(nif),
CONSTRAINT pk_compuesta PRIMARY KEY (codproyecto,nifcolaborador));


CREATE TABLE pagos(
numero INT(4) PRIMARY KEY,
concepto VARCHAR(20) NOT NULL,
importe DECIMAL(5,2) NOT NULL,
fecha DATE NOT NULL,
codigotipodepago INT(3),
codigoproyecto VARCHAR(5),
nifcolaborador VARCHAR(9),
CONSTRAINT fk_codigotipodepago1 FOREIGN KEY (codigotipodepago) REFERENCES tipos_de_pago(cod),
CONSTRAINT fk_codiproyectosgoproyecto1 FOREIGN KEY (codigoproyecto) REFERENCES proyecto(cod),
CONSTRAINT fk_nifcolaborador1 FOREIGN KEY (nifcolaborador) REFERENCES colaboradores(nif));

CREATE TABLE tipos_de_pago (
cod INT(3) PRIMARY KEY,
descripcion VARCHAR(24) NOT NULL);

ALTER TABLE pagos ADD CHECK (importe < 35000);

ALTER TABLE tipos_de_pago ADD COLUMN (tipo CHAR(15));

ALTER TABLE tipos_de_pago ADD CHECK (tipo IN ('Efectivo','Transferencia','Plazos'));

/* Restricción 7 */

ALTER TABLE proyecto ADD CHECK ( MONTH (fechaini) > '09' AND YEAR (fechaini) > '2009');

ALTER TABLE colaboradores ADD CHECK ( tfno NOT LIKE '9%');

ALTER TABLE proyecto ADD COLUMN ( nombre  VARCHAR(20));

/* 12 */

ALTER TABLE pagos NOCHECK CONSTRAINT CONSTRAINT_1;

DROP TABLE colaboraciones; 

ALTER TABLE pagos DROP COLUMN concepto;