-- Задание №1
-- В докере не нашёл этих файлов

-- Задание №2
-- В консоли: show parameter instance

-- Задание №3
SELECT * FROM V$PDBS; -- В консоли
SELECT * FROM V$TABLESPACE;
SELECT * FROM DBA_DATA_FILES;
SELECT * FROM ALL_USERS;
SELECT * FROM DBA_ROLE_PRIVS;

-- Задание №7
SELECT * FROM GKV_TABLE;

-- Задание №8


-- Задание №10
SELECT * FROM DBA_SEGMENTS WHERE OWNER = 'DB_USER';

-- Задание №11
CREATE VIEW All_extents AS SELECT EXTENTS, BLOCKS, BYTES FROM DBA_SEGMENTS;
SELECT * FROM All_extents;