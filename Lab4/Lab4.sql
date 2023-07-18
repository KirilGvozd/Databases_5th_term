-- Задание №1
SELECT name, open_mode FROM v$pdbs;
SELECT pdb_name, pdb_id, status FROM SYS.dba_pdbs;

-- Задание №2
SELECT * FROM v$instance;

-- Задание №3
SELECT * FROM SYS.PRODUCT_COMPONENT_VERSION;

-- Задание №4
CREATE PLUGGABLE DATABASE GKV_PDB
ADMIN USER pdb1_admin IDENTIFIED BY password
ROLES = (DBA)
FILE_NAME_CONVERT =('/opt/oracle/oradata/XE/pdbseed', '/opt/oracle/oradata/XE/GKV_PDB');


-- Задание №5
SELECT name, open_mode FROM v$pdbs;

-- Задание №6