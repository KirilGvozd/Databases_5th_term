CREATE TABLE Students
(
    Name nvarchar2(20),
    NumberOfGroup number(2)
);

CREATE VIEW StudentsView AS SELECT Name FROM STUDENTS;

CREATE TABLE Products
(
    NameOfProduct nvarchar2(20),
    Price number(3),
    Amount number(2)
)TABLESPACE GKV_QDATA;

SELECT * FROM PRODUCTS;