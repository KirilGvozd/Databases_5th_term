-- Задание №1
-- cat /opt/oracle/homes/OraDBHome21cXE/network/admin/sqlnet.ora
-- cat /opt/oracle/homes/OraDBHome21cXE/network/admin/tnsnames.ora

-- Задание №2
-- show parameter instance

-- Задание №3
-- connect system/Kirill@localhost:1521/GKV_PDB
SELECT NAME, OPEN_MODE FROM V$PDBS;
SELECT * FROM V$TABLESPACE;
SELECT * FROM DBA_DATA_FILES;
SELECT * FROM DBA_TEMP_FILES;
SELECT * FROM ALL_USERS;
SELECT * FROM DBA_ROLE_PRIVS;

-- Задание №4
-- regedit

-- Задание №6
-- connect U1_GKV_PDB/20122003@localhost:1521/GKV_PDB;

-- Задание №7
SELECT * FROM U1_GKV_TABLE;

-- Задание №8
-- set timing on

-- Задание №9
-- describe U1_GKV_Table

-- Задание №10
SELECT OWNER, SEGMENT_NAME, MAX_SIZE FROM DBA_SEGMENTS WHERE OWNER = 'U1_GKV_PDB';

-- Задание №11
SELECT EXTENTS, BLOCKS, BYTES FROM DBA_SEGMENTS;
CREATE VIEW Segments AS SELECT EXTENTS, BLOCKS, BYTES FROM DBA_SEGMENTS;
SELECT * FROM Segments;