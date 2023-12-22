CREATE TABLESPACE First_tablespace
DATAFILE 'First_tablespace.dbf'
SIZE 7M
AUTOEXTEND ON
MAXSIZE UNLIMITED
EXTENT MANAGEMENT LOCAL;

CREATE TABLESPACE Second_tablespace
DATAFILE 'Second_tablespace.dbf'
SIZE 7M
AUTOEXTEND ON
MAXSIZE UNLIMITED
EXTENT MANAGEMENT LOCAL;

CREATE TABLESPACE Third_tablespace
DATAFILE 'Third_tablespace.dbf'
SIZE 7M
AUTOEXTEND ON
MAXSIZE UNLIMITED
EXTENT MANAGEMENT LOCAL;

CREATE TABLESPACE Fourth_tablespace
DATAFILE 'Fourth_tablespace.dbf'
SIZE 7M
AUTOEXTEND ON
MAXSIZE UNLIMITED
EXTENT MANAGEMENT LOCAL;

ALTER USER GKV QUOTA UNLIMITED ON First_tablespace;
ALTER USER GKV QUOTA UNLIMITED ON Second_tablespace;
ALTER USER GKV QUOTA UNLIMITED ON Third_tablespace;
ALTER USER GKV QUOTA UNLIMITED ON Fourth_tablespace;

-- Task 1
CREATE TABLE T_RANGE (
    id_column integer,
    part_column integer
)
PARTITION BY RANGE (part_column)
(
    PARTITION first_part VALUES LESS THAN (10) TABLESPACE First_tablespace,
    PARTITION second_part VALUES LESS THAN (20) TABLESPACE Second_tablespace,
    PARTITION third_part VALUES LESS THAN (30) TABLESPACE Third_tablespace,
    PARTITION fourth_part VALUES LESS THAN (40) TABLESPACE Fourth_tablespace
);


INSERT INTO T_RANGE (id_column, part_column) VALUES (1, 9);
INSERT INTO T_RANGE (id_column, part_column) VALUES (2, 11);
INSERT INTO T_RANGE (id_column, part_column) VALUES (3, 29);
INSERT INTO T_RANGE (id_column, part_column) VALUES (4, 37);
COMMIT;

SELECT * FROM T_RANGE PARTITION (first_part);
SELECT * FROM T_RANGE PARTITION (second_part);
SELECT * FROM T_RANGE PARTITION (third_part);
SELECT * FROM T_RANGE PARTITION (fourth_part);

-- Task 2
CREATE TABLE T_INTERVAL (
    id_column integer,
    time_id date
)
PARTITION BY RANGE (time_id)
INTERVAL (NUMTOYMINTERVAL(1, 'MONTH'))
(
    PARTITION first_dates VALUES LESS THAN (TO_DATE('2020-01-01', 'yyyy-mm-dd')) TABLESPACE First_tablespace,
    PARTITION second_dates VALUES LESS THAN (TO_DATE('2021-02-02', 'yyyy-mm-dd')) TABLESPACE Second_tablespace,
    PARTITION third_dates VALUES LESS THAN (TO_DATE('2022-03-03', 'yyyy-mm-dd')) TABLESPACE Third_tablespace,
    PARTITION fourth_dates VALUES LESS THAN (TO_DATE('2023-04-04', 'yyyy-mm-dd')) TABLESPACE Fourth_tablespace
);

INSERT INTO T_INTERVAL (id_column, time_id) VALUES (1, '11-11-2019');
INSERT INTO T_INTERVAL (id_column, time_id) VALUES (2, '11-11-2020');
INSERT INTO T_INTERVAL (id_column, time_id) VALUES (3, '11-11-2021');
INSERT INTO T_INTERVAL (id_column, time_id) VALUES (4, '11-11-2022');
COMMIT;

SELECT * FROM T_INTERVAL PARTITION (first_dates);
SELECT * FROM T_INTERVAL PARTITION (second_dates);
SELECT * FROM T_INTERVAL PARTITION (third_dates);
SELECT * FROM T_INTERVAL PARTITION (fourth_dates);

-- Task 3
CREATE TABLE T_HASH (
    id_column integer,
    string_column varchar2(50)
)
PARTITION BY HASH (string_column)
(
    PARTITION first_part TABLESPACE First_tablespace,
    PARTITION second_part TABLESPACE Second_tablespace,
    PARTITION third_part TABLESPACE Third_tablespace,
    PARTITION fourth_part TABLESPACE Fourth_tablespace
);

INSERT INTO T_HASH (id_column, string_column) VALUES (1, 'First string');
INSERT INTO T_HASH (id_column, string_column) VALUES (2, 'Second string');
INSERT INTO T_HASH (id_column, string_column) VALUES (3, 'Third string');
INSERT INTO T_HASH (id_column, string_column) VALUES (4, 'Fourth string');
COMMIT;

SELECT * FROM T_HASH PARTITION (first_part);
SELECT * FROM T_HASH PARTITION (second_part);
SELECT * FROM T_HASH PARTITION (third_part);
SELECT * FROM T_HASH PARTITION (fourth_part);

-- Task 4
CREATE TABLE T_LIST (
    id_column integer,
    char_column char(2)
)
PARTITION BY LIST (char_column)
(
    PARTITION first_part VALUES ('Z') TABLESPACE First_tablespace,
    PARTITION second_part VALUES ('X') TABLESPACE Second_tablespace,
    PARTITION third_part VALUES ('C') TABLESPACE Third_tablespace,
    PARTITION fourth_part VALUES (default) TABLESPACE Fourth_tablespace
);

INSERT INTO T_LIST (id_column, char_column) VALUES (1, 'A');
INSERT INTO T_LIST (id_column, char_column) VALUES (2, 'Z');
INSERT INTO T_LIST (id_column, char_column) VALUES (3, 'X');
INSERT INTO T_LIST (id_column, char_column) VALUES (4, 'C');
INSERT INTO T_LIST (id_column, char_column) VALUES (5, 'AD');
COMMIT;

SELECT * FROM T_LIST PARTITION (first_part);
SELECT * FROM T_LIST PARTITION (second_part);
SELECT * FROM T_LIST PARTITION (third_part);
SELECT * FROM T_LIST PARTITION (fourth_part);

-- Task 5
ALTER TABLE T_RANGE ENABLE ROW MOVEMENT;
SELECT * FROM T_RANGE PARTITION (first_part);
UPDATE T_RANGE SET part_column = 11 WHERE id_column = 1;
SELECT * FROM T_RANGE PARTITION (first_part);
SELECT * FROM T_RANGE PARTITION (second_part);

ALTER TABLE T_INTERVAL ENABLE ROW MOVEMENT;
SELECT * FROM T_INTERVAL PARTITION (first_dates);
UPDATE T_INTERVAL SET time_id = '01-01-2020' WHERE id_column = 1;
SELECT * FROM T_INTERVAL PARTITION (first_dates);
SELECT * FROM T_INTERVAL PARTITION (second_dates);

ALTER TABLE T_HASH ENABLE ROW MOVEMENT;
SELECT * FROM T_HASH PARTITION (fourth_part);
UPDATE T_HASH SET string_column = 'First column changed' WHERE id_column = 1;
SELECT * FROM T_HASH PARTITION (second_part);
SELECT * FROM T_HASH PARTITION (fourth_part);

ALTER TABLE T_LIST ENABLE ROW MOVEMENT;
SELECT * FROM T_LIST PARTITION (first_part);
UPDATE T_LIST SET char_column = 'Z' WHERE id_column = 1;
SELECT * FROM T_LIST PARTITION (first_part);
SELECT * FROM T_LIST PARTITION (fourth_part);

-- Task 7
ALTER TABLE T_RANGE MERGE PARTITIONS first_part, second_part INTO PARTITION partition_for_merge TABLESPACE First_tablespace;
SELECT * FROM T_RANGE PARTITION (partition_for_merge);

-- Task 8
ALTER TABLE T_RANGE SPLIT PARTITION partition_for_merge AT (15)
    INTO ( PARTITION first_part TABLESPACE Third_tablespace, PARTITION second_part TABLESPACE Fourth_tablespace);
SELECT * FROM T_RANGE PARTITION (first_part);
SELECT * FROM T_RANGE PARTITION (second_part);

-- Task 9
CREATE TABLE T_RANGE_for_exchange (
    id_column integer,
    part_column integer
);

ALTER TABLE T_RANGE EXCHANGE PARTITION first_part WITH TABLE T_RANGE_FOR_EXCHANGE WITHOUT VALIDATION;
SELECT * FROM T_RANGE_FOR_EXCHANGE;
SELECT * FROM T_RANGE PARTITION (first_part);