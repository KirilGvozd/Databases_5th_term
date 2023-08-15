ALTER DATABASE OPEN;

-- Задание №2
CREATE SEQUENCE S1
INCREMENT BY 10
START WITH 1000
NOMINVALUE
NOMAXVALUE
NOCYCLE
NOCACHE
NOORDER;

COMMIT;

SELECT S1.nextval FROM dual;
SELECT S1.currval FROM dual;

-- Задание №3 и №4
CREATE SEQUENCE S2
START WITH 10
INCREMENT BY 10
MAXVALUE 100
NOCYCLE;
COMMIT;

SELECT S2.nextval FROM dual;
SELECT S2.currval FROM dual;

ALTER SEQUENCE S2 INCREMENT BY 100;

-- Задание №5
CREATE SEQUENCE S3
START WITH 10
INCREMENT BY -10
MINVALUE -100
MAXVALUE 20
NOCYCLE
ORDER;
COMMIT;

SELECT S3.nextval FROM dual;
SELECT S3.currval FROM dual;

ALTER SEQUENCE S3 INCREMENT BY -100;
COMMIT;

-- Задание №6
CREATE SEQUENCE S4
START WITH 1
INCREMENT BY 1
MAXVALUE 10
CYCLE
CACHE 5
NOORDER;
COMMIT;

SELECT S4.nextval FROM dual;
SELECT S4.currval FROM dual;

-- Задание №7
SELECT * FROM SYS.ALL_SEQUENCES WHERE SEQUENCE_OWNER = 'PDB1_ADMIN';

-- Задание №8
CREATE TABLE T1
(
    N1 NUMBER(20),
    N2 NUMBER(20),
    N3 NUMBER(20),
    N4 NUMBER(20)
)CACHE STORAGE ( BUFFER_POOL KEEP );
COMMIT;

INSERT INTO T1 (N1, N2, N3, N4) VALUES (S1.nextval, S2.nextval, S3.nextval, S4.nextval);
INSERT INTO T1 (N1, N2, N3, N4) VALUES (S1.nextval, S2.nextval, S3.nextval, S4.nextval);
INSERT INTO T1 (N1, N2, N3, N4) VALUES (S1.nextval, S2.nextval, S3.nextval, S4.nextval);
INSERT INTO T1 (N1, N2, N3, N4) VALUES (S1.nextval, S2.nextval, S3.nextval, S4.nextval);
INSERT INTO T1 (N1, N2, N3, N4) VALUES (S1.nextval, S2.nextval, S3.nextval, S4.nextval);
INSERT INTO T1 (N1, N2, N3, N4) VALUES (S1.nextval, S2.nextval, S3.nextval, S4.nextval);
INSERT INTO T1 (N1, N2, N3, N4) VALUES (S1.nextval, S2.nextval, S3.nextval, S4.nextval);

SELECT * FROM T1;

-- Задание №9
CREATE CLUSTER ABC
(
    X number(10),
    V varchar(12)
    )HASHKEYS 200;
COMMIT;

-- Задание №10
CREATE TABLE A
(
    XA number(10),
    VA varchar(12),
    ZA number(2)
)CLUSTER ABC(XA, VA);

-- Задание №11
CREATE TABLE B
(
    XB number(10),
    VB varchar(12),
    ZB number(2)
)CLUSTER ABC(XB, VB);

-- Задание №12
CREATE TABLE C
(
    XC number(10),
    VC varchar(12),
    ZC number(2)
)CLUSTER ABC(XC, VC);

-- Задание №13
SELECT * FROM USER_TABLES;
SELECT * FROM USER_CLUSTERS;

-- Задание №14
CREATE SYNONYM SYNONC FOR C;
COMMIT;

SELECT * FROM SYNONC;

-- Задание №15
CREATE PUBLIC SYNONYM SYNONB FOR B;
COMMIT;

SELECT * FROM SYNONB;

-- Задание №16
CREATE TABLE First_table
(
    Some_number number(2) primary key,
    Some_string nvarchar2(20)
);

CREATE TABLE Second_table
(
    Second_string nvarchar2(20),
    Second_number number(2),
    constraint Some_number_fk foreign key (Second_number) references First_table(Some_number)
);
COMMIT;

INSERT INTO First_table (Some_number, Some_string) VALUES (1, 'First string');
INSERT INTO First_table (Some_number, Some_string) VALUES (2, 'Second string');
INSERT INTO Second_table (Second_string, Second_number) VALUES ('First string', 1);
INSERT INTO Second_table (Second_string, Second_number) VALUES ('Second string', 2);

CREATE VIEW V1 AS SELECT * FROM First_table JOIN Second_table St on First_table.Some_number = St.Second_number;
SELECT * FROM V1;

-- Задание №17
CREATE MATERIALIZED VIEW MV
BUILD IMMEDIATE
REFRESH COMPLETE ON DEMAND NEXT SYSDATE+NUMTODSINTERVAL(2, 'minute')
AS SELECT * FROM First_table LEFT JOIN Second_table St on First_table.Some_number = St.Second_number;

SELECT * FROM MV;
COMMIT;