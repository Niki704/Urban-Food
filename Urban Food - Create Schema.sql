SHOW CON_NAME;
SHOW PDBS;
ALTER PLUGGABLE DATABASE ORCLPDB OPEN;
ALTER SESSION SET CONTAINER = ORCLPDB;
CREATE USER niki IDENTIFIED BY Niki;

GRANT CONNECT, RESOURCE TO niki;
GRANT CREATE SESSION TO niki;
GRANT UNLIMITED TABLESPACE TO niki;

SELECT username FROM dba_users WHERE username = 'NIKI';