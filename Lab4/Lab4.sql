-- Задание №1
SELECT name, open_mode FROM v$pdbs;
SELECT pdb_name, pdb_id, status FROM SYS.dba_pdbs;

-- Задание №2
SELECT * FROM v$instance;

-- Задание №3
SELECT * FROM SYS.PRODUCT_COMPONENT_VERSION;

-- Задание №4
CREATE PLUGGABLE DATABASE GKV_PDB
ADMIN USER pdb1_admin IDENTIFIED BY 20122003
ROLES = (DBA)
FILE_NAME_CONVERT =('/opt/oracle/oradata/XE/pdbseed', '/opt/oracle/oradata/XE/GKV_PDB');


-- Задание №5
SELECT name, open_mode FROM v$pdbs;

-- Задание №6 (Это уже на PDB)
CREATE TABLESPACE TS_GKV
DATAFILE 'C:\Labs\Databases\Lab4\TS_PDB.dbf'
SIZE 7M
AUTOEXTEND ON NEXT 5M
MAXSIZE 30M;

CREATE TEMPORARY TABLESPACE TS_GKV_TEMP
TEMPFILE 'C:\Labs\Databases\Lab4\TS_PDB_TEMP.dbf'
SIZE 5M
AUTOEXTEND ON NEXT 3M
MAXSIZE 30M;

CREATE ROLE RL_PDB_GKV;
GRANT ALL PRIVILEGES TO RL_PDB_GKV;
GRANT CREATE SESSION TO RL_PDB_GKV;
COMMIT;

CREATE PROFILE PF_PDB_GKV LIMIT
PASSWORD_LIFE_TIME 180
SESSIONS_PER_USER 3
FAILED_LOGIN_ATTEMPTS 7
PASSWORD_LOCK_TIME 1
PASSWORD_REUSE_TIME 10
PASSWORD_GRACE_TIME DEFAULT
CONNECT_TIME 180
IDLE_TIME 30;

CREATE USER U1_GKV_PDB IDENTIFIED BY 20122003
DEFAULT TABLESPACE TS_GKV
TEMPORARY TABLESPACE TS_GKV_TEMP
PROFILE PF_PDB_GKV
ACCOUNT UNLOCK;

GRANT RL_PDB_GKV TO U1_GKV_PDB;

-- Задание №7
CREATE TABLE GKV_table
(
    Name nvarchar2(20),
    NumberOfGroup number(2)
);

INSERT INTO GKV_TABLE (Name, NumberOfGroup) VALUES ('Кирилл', 6);
INSERT INTO GKV_TABLE (Name, NumberOfGroup) VALUES ('Илья', 4);
INSERT INTO GKV_TABLE (Name, NumberOfGroup) VALUES ('Олег', 6);
INSERT INTO GKV_TABLE (Name, NumberOfGroup) VALUES ('Александр', 5);
INSERT INTO GKV_TABLE (Name, NumberOfGroup) VALUES ('Александр', 6);

SELECT * FROM GKV_table WHERE NumberOfGroup = 6;
SELECT * FROM GKV_table WHERE Name = 'Александр';

-- Задание №8
SELECT TABLESPACE_NAME, STATUS, CONTENTS FROM USER_TABLESPACES;
SELECT TABLESPACE_NAME, FILE_NAME FROM DBA_DATA_FILES;
SELECT TABLESPACE_NAME, FILE_NAME FROM DBA_TEMP_FILES;
SELECT * FROM DBA_ROLES;
SELECT * FROM DBA_ROLE_PRIVS ORDER BY GRANTEE;
SELECT * FROM DBA_PROFILES ORDER BY PROFILE;
SELECT * FROM DBA_USERS ORDER BY USERNAME;
SELECT USERNAME, GRANTED_ROLE FROM DBA_USERS JOIN DBA_ROLE_PRIVS ON USERNAME = GRANTEE ORDER BY USERNAME;

-- Задание №9
CREATE USER C##GKV IDENTIFIED BY 12345
ACCOUNT UNLOCK;

GRANT CREATE SESSION TO C##GKV;

-- Задание №11
SELECT * FROM v$session WHERE username IS NOT NULL;

-- Задание №12
SELECT *  FROM DBA_DATA_FILES;

-- Задание №13
ALTER PLUGGABLE DATABASE GKV_PDB CLOSE IMMEDIATE;
DROP PLUGGABLE DATABASE GKV_PDB;
DROP USER C##GKV;