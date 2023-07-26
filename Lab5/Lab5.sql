-- Задание №1
SELECT * FROM DBA_TABLESPACES;

-- Задание №2
ALTER TABLESPACE GKV_QDATA ONLINE;

CREATE TABLE GKV_T1
(
    Id number(2) primary key,
    Worker nvarchar2(20)
)TABLESPACE GKV_QDATA;

INSERT INTO GKV_T1 (Id, Worker) VALUES (1, 'Кирилл');
INSERT INTO GKV_T1 (Id, Worker) VALUES (2, 'Олег');
INSERT INTO GKV_T1 (Id, Worker) VALUES (3, 'Влад');

-- Задание №3
