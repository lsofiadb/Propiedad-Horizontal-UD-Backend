
--Taller final Conjutnos
--Creación de  tablespace default
CREATE TABLESPACE conjuntos_def DATAFILE 'C:\oraclexe\app\oracle\oradata\XE\conjuntos_def.dbf' SIZE 2M AUTOEXTEND ON;

-- tablespace temporary 
CREATE TEMPORARY TABLESPACE conjuntos_tmp TEMPFILE 'C:\oraclexe\app\oracle\oradata\XE\conjuntos_tmp.dbf' SIZE 2M AUTOEXTEND ON;

-- CREATE USER de prueba
CREATE USER CONJUNTO IDENTIFIED BY CONJUNTO DEFAULT TABLESPACE conjuntos_def TEMPORARY TABLESPACE conjuntos_tmp QUOTA 2M ON conjuntos_def PASSWORD EXPIRE;

GRANT connect, resource TO CONJUNTO;

-- Creación de usuarios
CONNECT SYSTEM/1234;

DROP USER U_RESPONSABLE CASCADE;
DROP USER U_ADMINISTRADOR CASCADE;
DROP USER U_SECRETARIA CASCADE;
DROP USER U_CONTADOR CASCADE;


CREATE USER U_RESPONSABLE IDENTIFIED BY U_RESPONSABLE DEFAULT TABLESPACE conjuntos_def TEMPORARY TABLESPACE conjuntos_tmp QUOTA 2M ON alquiler_def PASSWORD EXPIRE;
CREATE USER U_ADMINISTRADOR IDENTIFIED BY U_ADMINISTRADOR DEFAULT TABLESPACE conjuntos_def TEMPORARY TABLESPACE conjuntos_tmp QUOTA 2M ON alquiler_def PASSWORD EXPIRE;
CREATE USER U_SECRETARIA IDENTIFIED BY U_SECRETARIA DEFAULT TABLESPACE conjuntos_def TEMPORARY TABLESPACE conjuntos_tmp QUOTA 2M ON alquiler_def PASSWORD EXPIRE;
CREATE USER U_CONTADOR IDENTIFIED BY U_CONTADOR DEFAULT TABLESPACE conjuntos_def TEMPORARY TABLESPACE conjuntos_tmp QUOTA 2M ON alquiler_def PASSWORD EXPIRE;


-- CREACIÓN de roles y asignación de privilegios
DROP ROLE R_RESPONSABLE;
CREATE ROLE R_RESPONSABLE;
-- El responsable puede consultar las siguientes tablas
GRANT SELECT ON CONJUNTO.CONJUNTO TO R_RESPONSABLE;
GRANT SELECT ON CONJUNTO.ZONA_COMUN TO R_RESPONSABLE; 
GRANT SELECT ON CONJUNTO.APARTAMENTO TO R_RESPONSABLE;
GRANT SELECT ON CONJUNTO.PARQUEADERO TO R_RESPONSABLE; 
--GRANT SELECT ON CONJUNTO.CUENTA_COBRO TO R_RESPONSABLE;
--GRANT SELECT ON CONJUNTO.CONCEPTO TO R_RESPONSABLE; 
--GRANT SELECT ON CONJUNTO.DETALLE_POR TO R_RESPONSABLE; 
--GRANT SELECT ON CONJUNTO.PAGO TO R_RESPONSABLE; 
GRANT SELECT ON CONJUNTO.PERSONA TO R_RESPONSABLE; 
GRANT SELECT ON CONJUNTO.RESPONSABLE TO R_RESPONSABLE; 
GRANT SELECT ON CONJUNTO.RESIDENTE TO R_RESPONSABLE; 
GRANT SELECT ON CONJUNTO.RESERVA TO R_RESPONSABLE; 

DROP ROLE R_ADMINISTRADOR; 
CREATE ROLE R_ADMINISTRADOR;
-- EL ADMINISTRADOR DEBE PODER ASIGNAR LAS RESERVAS
GRANT SELECT, UPDATE ON CONJUNTO.APARTAMENTO TO R_ADMINISTRADOR;
GRANT SELECT, UPDATE  ON CONJUNTO.PARQUEADERO TO R_ADMINISTRADOR;
GRANT SELECT, UPDATE ON CONJUNTO.ZONA_COMUN TO R_ADMINISTRADOR;
GRANT SELECT, UPDATE ON CONJUNTO.CONJUNTO TO R_ADMINISTRADOR;
-- Leer las cuentas de cobro de los responsables
GRANT SELECT ON CONJUNTO.CUENTA_COBRO TO R_ADMINISTRADOR;
GRANT SELECT ON CONJUNTO.CONCEPTO TO R_ADMINISTRADOR; 
GRANT SELECT ON CONJUNTO.DETALLE_POR TO R_ADMINISTRADOR; 
GRANT SELECT ON CONJUNTO.PAGO TO R_ADMINISTRADOR; 
-- CRU de las reservas
GRANT SELECT, INSERT, UPDATE ON CONJUNTO.RESERVA TO R_ADMINISTRADOR;
-- CRU de las personas
GRANT SELECT, INSERT, UPDATE ON CONJUNTO.PERSONA TO R_ADMINISTRADOR;
GRANT SELECT, INSERT, UPDATE ON CONJUNTO.RESPONSABLE TO R_ADMINISTRADOR;
GRANT SELECT, INSERT, UPDATE ON CONJUNTO.RESIDENTE TO R_ADMINISTRADOR;

DROP ROLE R_CONTADOR;
CREATE ROLE R_CONTADOR;
-- CRU EN LAS CUENTAS DE COBRO
GRANT SELECT, INSERT, UPDATE ON CONJUNTO.CUENTA_COBRO TO R_CONTADOR;
GRANT SELECT, INSERT, UPDATE ON CONJUNTO.DETALLE_POR TO R_CONTADOR;
GRANT SELECT, INSERT, UPDATE ON CONJUNTO.CONCEPTO TO R_CONTADOR;
GRANT SELECT, INSERT, UPDATE ON CONJUNTO.PAGO TO R_CONTADOR;
-- CONSULTAR PERSONA, RESPONSABLE Y APARTAMENTO, PARA REALIZAR OPERACIONES DE REPORTE ETC
GRANT SELECT ON CONJUNTO.PERSONA TO R_CONTADOR;
GRANT SELECT ON CONJUNTO.RESPONSABLE TO R_CONTADOR; 
GRANT SELECT ON CONJUNTO.APARTAMENTO TO R_CONTADOR; 

DROP ROLE R_SECRETARIA;
CREATE ROLE R_SECRETARIA;
-- Consultoria en general
GRANT SELECT ON CONJUNTO.CONJUNTO TO R_SECRETARIA;
GRANT SELECT ON CONJUNTO.ZONA_COMUN TO R_SECRETARIA;
GRANT SELECT ON CONJUNTO.APARTAMENTO TO R_SECRETARIA;
GRANT SELECT ON CONJUNTO.PARQUEADERO TO R_SECRETARIA;
GRANT SELECT ON CONJUNTO.CUENTA_COBRO TO R_SECRETARIA;
GRANT SELECT ON CONJUNTO.CONCEPTO TO R_SECRETARIA; 
GRANT SELECT ON CONJUNTO.DETALLE_POR TO R_SECRETARIA; 
GRANT SELECT ON CONJUNTO.PAGO TO R_SECRETARIA;
GRANT SELECT ON CONJUNTO.RESERVA TO R_SECRETARIA;
--Actualización de datos de responsable, persona y residente
GRANT SELECT, UPDATE ON CONJUNTO.PERSONA TO R_SECRETARIA;
GRANT SELECT, UPDATE ON CONJUNTO.RESPONSABLE TO R_SECRETARIA;
GRANT SELECT, UPDATE ON CONJUNTO.RESIDENTE TO R_SECRETARIA;



-- ASIGNACIÓN DE ROLES CON USUARIOS
GRANT CONNECT, R_RESPONSABLE TO U_RESPONSABLE;
GRANT CONNECT, R_ADMINISTRADOR TO U_ADMINISTRADOR;
GRANT CONNECT, R_CONTADOR TO U_CONTADOR;
GRANT CONNECT, R_SECRETARIA TO U_SECRETARIA;


--PRUEBAS
--OBTENER EL ROL DADO EL USUARIO
--SELECT  GRANTED_ROLE FROM DBA_ROLE_PRIVS WHERE GRANTEE='U_RESPONSABLE';
-- OBTENER USUARIO DADO EL ROL
--SELECT GRANTEE FROM DBA_ROLE_PRIVS WHERE GRANTED_ROLE='R_CONTADOR';