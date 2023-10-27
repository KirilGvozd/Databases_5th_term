-- Задание №1
SELECT SUM(VALUE) FROM V$SGA;

-- Задание №2
SELECT * FROM V$SGA;

-- Задание №3
SELECT COMPONENT, GRANULE_SIZE, CURRENT_SIZE / GRANULE_SIZE AS RATIO FROM V$SGA_DYNAMIC_COMPONENTS;

-- Задание №4
SELECT CURRENT_SIZE FROM V$SGA_DYNAMIC_FREE_MEMORY;

-- Задание №5
SELECT COMPONENT, MAX_SIZE, CURRENT_SIZE FROM V$SGA_DYNAMIC_COMPONENTS;

-- Задание №6
SELECT COMPONENT, CURRENT_SIZE FROM V$SGA_DYNAMIC_COMPONENTS WHERE COMPONENT LIKE '%DEFAULT%' OR COMPONENT LIKE'%KEEP%'
                                                                OR COMPONENT LIKE '%RECYCLE%';

-- Задание №7
CREATE TABLE GKV_table
(
    Id number(2)
)STORAGE ( BUFFER_POOL KEEP );
INSERT INTO GKV_TABLE (ID) VALUES (1);
INSERT INTO GKV_TABLE (ID) VALUES (2);
INSERT INTO GKV_TABLE (ID) VALUES (3);
COMMIT;
SELECT SEGMENT_NAME, TABLESPACE_NAME, BUFFER_POOL FROM USER_SEGMENTS;

-- Задание №8
CREATE TABLE Some_table
(
    Id number(2)
)STORAGE ( BUFFER_POOL DEFAULT );
INSERT INTO Some_table (ID) VALUES (1);
INSERT INTO Some_table (ID) VALUES (2);
INSERT INTO Some_table (ID) VALUES (3);
COMMIT;
SELECT SEGMENT_NAME, TABLESPACE_NAME, BUFFER_POOL FROM USER_SEGMENTS;

-- Задание №9
-- В консоли: SHOW PARAMETER log_buffer;

-- Задание №10
SELECT (MAX_SIZE - CURRENT_SIZE) AS Free_space FROM V$SGA_DYNAMIC_COMPONENTS WHERE COMPONENT = 'large pool';

-- Задание №11
SELECT USERNAME, SERVICE_NAME, SERVER, OSUSER, MACHINE, PROGRAM FROM V$SESSION WHERE USERNAME iS NOT NULL;

-- Задание №12
SELECT NAME, DESCRIPTION FROM V$BGPROCESS WHERE PADDR != '00';

-- Задание №13
SELECT PNAME, PID, USERNAME, PROGRAM FROM V$PROCESS;

-- Задание №14
SELECT COUNT(*) FROM V$BGPROCESS WHERE PADDR != '00' AND NAME LIKE 'DBW%';

-- Задание №15
SELECT * FROM V$SERVICES;

-- Задание №16
SELECT * FROM V$DISPATCHER;
-- В консоли: show parameter dispatchers;

-- Задание №17
-- OracleOraDB21Home1 TNSListener

-- Задание №18
-- cat /opt/oracle/homes/OraDBHome21cXE/network/admin/listener.ora

-- Задание №19
-- lsnrctl
-- help --> start, stop,status - ready, blocked, unknown
-- services, version
-- servacls - get access control lists
-- reload - reload the parameter files and SIDs
-- save_config - saves configuration changes to parameter file

-- Задание №20
SELECT NAME, NETWORK_NAME FROM V$SERVICES;