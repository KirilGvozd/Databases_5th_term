-- Задание №1
SELECT * FROM DBA_TABLESPACES;
SELECT * FROM DBA_DATA_FILES;
SELECT * FROM DBA_TEMP_FILES;

-- Задание №2
CREATE TABLESPACE GKV_QDATA
DATAFILE 'GKV_QDATA.dbf'
SIZE 10M
AUTOEXTEND ON NEXT 5M
MAXSIZE 30M
OFFLINE;

ALTER USER C##GKV QUOTA 2M ON GKV_QDATA;

ALTER TABLESPACE GKV_QDATA ONLINE;

CREATE TABLE GKV_T1
(
    Id number(6) primary key,
    Worker nvarchar2(20)
)TABLESPACE GKV_QDATA;

INSERT INTO GKV_T1 (Id, Worker) VALUES (1, 'Кирилл');
INSERT INTO GKV_T1 (Id, Worker) VALUES (2, 'Олег');
INSERT INTO GKV_T1 (Id, Worker) VALUES (3, 'Влад');

-- Задание №3
SELECT DISTINCT * FROM DBA_SEGMENTS WHERE TABLESPACE_NAME = 'GKV_QDATA';

-- Задание №4
DROP TABLE GKV_T1;
SELECT DISTINCT * FROM DBA_SEGMENTS WHERE TABLESPACE_NAME = 'GKV_QDATA';
SELECT * FROM USER_RECYCLEBIN;
COMMIT;
-- Задание №5
FLASHBACK TABLE GKV_T1 TO BEFORE DROP;
SELECT * FROM GKV_T1;

-- Задание №6
BEGIN
FOR k in 4..10000
    LOOP
    INSERT INTO GKV_T1 (Id) VALUES (k);
    end loop;
    COMMIT;
END;

-- Задание №7
SELECT SEGMENT_NAME, SEGMENT_TYPE, TABLESPACE_NAME, BYTES, BLOCKS, EXTENTS, BUFFER_POOL FROM DBA_SEGMENTS WHERE TABLESPACE_NAME = 'GKV_QDATA';
SELECT * FROM USER_EXTENTS WHERE TABLESPACE_NAME = 'GKV_QDATA';

-- Задание №8
DROP TABLESPACE GKV_QDATA INCLUDING CONTENTS AND DATAFILES;

-- Задание №9
SELECT GROUP#, STATUS, MEMBERS FROM V$LOG;

-- Задание №10
SELECT * FROM V$LOGFILE;

-- Задание №11
ALTER SYSTEM SWITCH LOGFILE;
SELECT GROUP#, STATUS, MEMBERS FROM V$LOG;

-- Задание №12
ALTER DATABASE ADD LOGFILE GROUP 4 '/opt/oracle/oradata/XE/redo04.log' SIZE 50m BLOCKSIZE 512;
ALTER DATABASE ADD LOGFILE MEMBER '/opt/oracle/oradata/XE/redo04_1.log' TO GROUP 4;
ALTER DATABASE ADD LOGFILE MEMBER '/opt/oracle/oradata/XE/redo04_2.log' TO GROUP 4;
SELECT * FROM V$LOG;

-- Задание №13
ALTER DATABASE DROP LOGFILE GROUP 4;

-- Задание №14
SELECT NAME, LOG_MODE FROM V$DATABASE;
SELECT INSTANCE_NAME, ARCHIVER, ACTIVE_STATE FROM V$INSTANCE;

-- Задание №17
SELECT * FROM V$LOG;
ALTER SYSTEM SET LOG_ARCHIVE_DEST_1 ='LOCATION=/opt/oracle/oradata/XE/Archive';
ALTER SYSTEM SWITCH LOGFILE;
SELECT * FROM V$ARCHIVED_LOG;

-- Задание №19
SELECT * FROM V$CONTROLFILE;

-- Задане №20 (В консоли)
-- В консоли: SHOW PARAMETER CONTROL;

-- Задание №21 (В консоли)
-- В консоли: SHOW PARAMERER spfile;

-- Задание №22
CREATE PFILE = 'GKV_PFILE.ora' FROM SPFILE;

-- Задание №23
SELECT * FROM V$PWFILE_USERS;
-- В консоли: show parameter remote_login_passwordfile;

-- Задание №24
SELECT * FROM V$DIAG_INFO;

SELECT DISTINCT SEGMENT_TYPE FROM DBA_SEGMENTS;

--/opt/oracle/dbs/spfileXE.ora