CREATE TABLE GKV_t
(
    x number(3) PRIMARY KEY,
    s varchar2(50)
);


INSERT INTO GKV_T (x, s) VALUES (1, 'Kirill');
INSERT INTO GKV_T (x, s) VALUES (2, 'Natalie');
INSERT INTO GKV_T (x, s) VALUES (3, 'Oleg');
COMMIT;

UPDATE GKV_T SET s = 'Vlad' WHERE x = 3;
UPDATE GKV_T SET s = 'Anton' WHERE x = 1;
COMMIT;

SELECT x FROM GKV_T WHERE s = 'Anton';
SELECT COUNT(*) AS Row_Count FROM GKV_T;

DELETE FROM GKV_T WHERE x = 2;
COMMIT;

CREATE TABLE GKV_t1
(
    studentId number(3) CONSTRAINT fk_id REFERENCES GKV_t(x),
    mark number(2) PRIMARY KEY
);

INSERT INTO GKV_t1 (studentId, mark) VALUES (1, 9);
INSERT INTO GKV_t1 (studentId, mark) VALUES (3, 4);
COMMIT;

SELECT s, mark FROM GKV_t LEFT OUTER JOIN GKV_t1 ON GKV_t.x = GKV_t1.studentId;
SELECT s, mark FROM GKV_t RIGHT OUTER JOIN GKV_T1 ON GKV_t.x = GKV_t1.studentId;
SELECT s, mark FROM GKV_T INNER JOIN GKV_t1 ON GKV_t.x = GKV_t1.studentId;

DROP TABLE GKV_t;
DROP TABLE GKV_t1;