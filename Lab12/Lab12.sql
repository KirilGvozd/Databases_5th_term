-- Task 1
create table LAB12_TABLE
(
    FIRST_COLUMN  NUMBER not null
        primary key,
    SECOND_COLUMN VARCHAR2(20)
);

-- Task 2
BEGIN
  FOR i IN 1..10
    LOOP
      INSERT INTO LAB12_TABLE VALUES (i, 'Some text');
      end loop;
end;

-- Task 3 & 4
create or replace trigger BEFORE_INSERT_TRIGGER
    before insert
    on LAB12_TABLE
begin
    DBMS_OUTPUT.PUT_LINE('BEFORE_INSERT_TRIGGER');
end;

create or replace trigger BEFORE_UPDATE_TRIGGER
    before update
    on LAB12_TABLE
begin
    DBMS_OUTPUT.PUT_LINE('BEFORE_UPDATE_TRIGGER');
end;

create or replace trigger BEFORE_DELETE_TRIGGER
    before delete
    on LAB12_TABLE
begin
    DBMS_OUTPUT.PUT_LINE('BEFORE_DELETE_TRIGGER');
end;

INSERT INTO LAB12_TABLE VALUES (11, 'New row');
UPDATE LAB12_TABLE SET SECOND_COLUMN = 'Updated row' WHERE FIRST_COLUMN = 10;
DELETE FROM LAB12_TABLE WHERE FIRST_COLUMN = 11;
COMMIT;

-- Task 5

create or replace trigger BEFORE_INSERT_TRIGGER_ROW
    before insert
    on LAB12_TABLE
    for each row
begin
    DBMS_OUTPUT.PUT_LINE('BEFORE_INSERT_TRIGGER_ROW');
end;

create or replace trigger BEFORE_UPDATE_TRIGGER_ROW
    before update
    on LAB12_TABLE
    for each row
begin
    DBMS_OUTPUT.PUT_LINE('BEFORE_UPDATE_TRIGGER_ROW');
end;

create or replace trigger BEFORE_DELETE_TRIGGER_ROW
    before delete
    on LAB12_TABLE
    for each row
begin
    DBMS_OUTPUT.PUT_LINE('BEFORE_DELETE_TRIGGER_ROW');
end;

INSERT INTO LAB12_TABLE VALUES (12, 'New row');
UPDATE LAB12_TABLE SET SECOND_COLUMN = 'Updated row' WHERE FIRST_COLUMN = 9;
DELETE FROM LAB12_TABLE WHERE FIRST_COLUMN = 11;
COMMIT;

-- Task 6
CREATE OR REPLACE TRIGGER DML_TRIGGER
    BEFORE INSERT OR UPDATE OR DELETE ON LAB12_TABLE
    BEGIN
        IF INSERTING
            THEN DBMS_OUTPUT.PUT_LINE('DML_TRIGGER_INSERTING');
        ELSIF UPDATING
            THEN DBMS_OUTPUT.PUT_LINE('DML_TRIGGER_UPDATING');
        ELSIF DELETING
            THEN DBMS_OUTPUT.PUT_LINE('DML_TRIGGER_DELETING');
        END IF;
    end;

INSERT INTO LAB12_TABLE VALUES (13, 'New row');
UPDATE LAB12_TABLE SET SECOND_COLUMN = 'Updated row' WHERE FIRST_COLUMN = 13;
DELETE FROM LAB12_TABLE WHERE FIRST_COLUMN = 11;
COMMIT;

-- Task 7
create or replace trigger AFTER_INSERT_TRIGGER
    after insert
    on LAB12_TABLE
begin
    DBMS_OUTPUT.PUT_LINE('AFTER_INSERT_TRIGGER');
end;

create or replace trigger AFTER_UPDATE_TRIGGER
    after update
    on LAB12_TABLE
begin
    DBMS_OUTPUT.PUT_LINE('AFTER_UPDATE_TRIGGER');
end;

create or replace trigger AFTER_DELETE_TRIGGER
    after delete
    on LAB12_TABLE
begin
    DBMS_OUTPUT.PUT_LINE('AFTER_DELETE_TRIGGER');
end;

-- Task 8
create or replace trigger AFTER_INSERT_TRIGGER_ROW
    after insert
    on LAB12_TABLE
    for each row
begin
    DBMS_OUTPUT.PUT_LINE('AFTER_INSERT_TRIGGER_ROW');
end;

create or replace trigger AFTER_UPDATE_TRIGGER_ROW
    after update
    on LAB12_TABLE
    for each row
begin
    DBMS_OUTPUT.PUT_LINE('AFTER_UPDATE_TRIGGER_ROW');
end;

create or replace trigger AFTER_DELETE_TRIGGER_ROW
    after delete
    on LAB12_TABLE
    for each row
begin
    DBMS_OUTPUT.PUT_LINE('AFTER_DELETE_TRIGGER_ROW');
end;

-- Task 9
CREATE TABLE AUDIT_ (
    OperationDate date,
    OperationType varchar2(30),
    TriggerName varchar2(30),
    Data varchar2(50)
);

-- Task 10
CREATE OR REPLACE TRIGGER DML_BEFORE_TRIGGER_ROW
    BEFORE INSERT OR UPDATE OR DELETE
    ON LAB12_TABLE FOR EACH ROW
    BEGIN
        IF INSERTING THEN
            DBMS_OUTPUT.PUT_LINE('DML_BEFORE_TRIGGER_ROW INSERT');
            INSERT INTO AUDIT_ (OperationDate, OperationType, TriggerName, Data)
            VALUES (sysdate, 'INSERT', 'DML_BEFORE_TRIGGER_ROW', :new.FIRST_COLUMN || ' ' || :new.SECOND_COLUMN);
        ELSIF UPDATING THEN
            DBMS_OUTPUT.PUT_LINE('DML_BEFORE_TRIGGER_ROW UPDATE');
            INSERT INTO AUDIT_ (OperationDate, OperationType, TriggerName, Data)
            VALUES (sysdate, 'UPDATE', 'DML_BEFORE_TRIGGER_ROW', :old.FIRST_COLUMN || ' ' || :old.SECOND_COLUMN ||
                                                                '->' || :new.FIRST_COLUMN || ' ' || :new.SECOND_COLUMN);
        ELSIF DELETING THEN
            DBMS_OUTPUT.PUT_LINE('DML_BEFORE_TRIGGER_ROW DELETE');
            INSERT INTO AUDIT_ (OperationDate, OperationType, TriggerName, Data)
            VALUES (sysdate, 'DELETE', 'DML_BEFORE_TRIGGER_ROW', :old.FIRST_COLUMN || ' ' || :old.SECOND_COLUMN);
        end if;
    end;

CREATE OR REPLACE TRIGGER DML_AFTER_TRIGGER_ROW
    AFTER INSERT OR UPDATE OR DELETE
    ON LAB12_TABLE FOR EACH ROW
    BEGIN
        IF INSERTING THEN
            DBMS_OUTPUT.PUT_LINE('DML_AFTER_TRIGGER_ROW INSERT');
            INSERT INTO AUDIT_ (OperationDate, OperationType, TriggerName, Data)
            VALUES (sysdate, 'INSERT', 'DML_AFTER_TRIGGER_ROW', :new.FIRST_COLUMN || ' ' || :new.SECOND_COLUMN);
        ELSIF UPDATING THEN
            DBMS_OUTPUT.PUT_LINE('DML_AFTER_TRIGGER_ROW UPDATE');
            INSERT INTO AUDIT_ (OperationDate, OperationType, TriggerName, Data)
            VALUES (sysdate, 'UPDATE', 'DML_AFTER_TRIGGER_ROW', :old.FIRST_COLUMN || ' ' || :old.SECOND_COLUMN ||
                                                                '->' || :new.FIRST_COLUMN || ' ' || :new.SECOND_COLUMN);
        ELSIF DELETING THEN
            DBMS_OUTPUT.PUT_LINE('DML_AFTER_TRIGGER_ROW DELETE');
            INSERT INTO AUDIT_ (OperationDate, OperationType, TriggerName, Data)
            VALUES (sysdate, 'DELETE', 'DML_AFTER_TRIGGER_ROW', :old.FIRST_COLUMN || ' ' || :old.SECOND_COLUMN);
        end if;
    end;

CREATE OR REPLACE TRIGGER DML_BEFORE_TRIGGER
    BEFORE INSERT OR UPDATE OR DELETE ON LAB12_TABLE
    BEGIN
        IF INSERTING
            THEN DBMS_OUTPUT.PUT_LINE('DML_BEFORE_TRIGGER INSERT');
            INSERT INTO AUDIT_ (OperationDate, OperationType, TriggerName, Data)
            VALUES (sysdate, 'INSERT', 'DML_BEFORE_TRIGGER', :new.FIRST_COLUMN || ' ' || :new.SECOND_COLUMN);
        ELSIF UPDATING
            THEN DBMS_OUTPUT.PUT_LINE('DML_BEFORE_TRIGGER UPDATE');
            INSERT INTO AUDIT_ (OperationDate, OperationType, TriggerName, Data)
            VALUES (sysdate, 'UPDATE', 'DML_BEFORE_TRIGGER', :old.FIRST_COLUMN || ' ' || :old.SECOND_COLUMN ||
                                                                '->' || :new.FIRST_COLUMN || ' ' || :new.SECOND_COLUMN);
        ELSIF DELETING
            THEN DBMS_OUTPUT.PUT_LINE('DML_BEFORE_TRIGGER DELETE');
            INSERT INTO AUDIT_ (OperationDate, OperationType, TriggerName, Data)
            VALUES (sysdate, 'DELETE', 'DML_BEFORE_TRIGGER', :old.FIRST_COLUMN || ' ' || :old.SECOND_COLUMN);
        END IF;
    end;

CREATE OR REPLACE TRIGGER DML_AFTER_TRIGGER
    AFTER INSERT OR UPDATE OR DELETE ON LAB12_TABLE
    BEGIN
        IF INSERTING
            THEN DBMS_OUTPUT.PUT_LINE('DML_BEFORE_TRIGGER INSERT');
            INSERT INTO AUDIT_ (OperationDate, OperationType, TriggerName, Data)
            VALUES (sysdate, 'INSERT', 'DML_AFTER_TRIGGER', :new.FIRST_COLUMN || ' ' || :new.SECOND_COLUMN);
        ELSIF UPDATING
            THEN DBMS_OUTPUT.PUT_LINE('DML_BEFORE_TRIGGER UPDATE');
            INSERT INTO AUDIT_ (OperationDate, OperationType, TriggerName, Data)
            VALUES (sysdate, 'UPDATE', 'DML_AFTER_TRIGGER', :old.FIRST_COLUMN || ' ' || :old.SECOND_COLUMN ||
                                                                '->' || :new.FIRST_COLUMN || ' ' || :new.SECOND_COLUMN);
        ELSIF DELETING
            THEN DBMS_OUTPUT.PUT_LINE('DML_BEFORE_TRIGGER DELETE');
            INSERT INTO AUDIT_ (OperationDate, OperationType, TriggerName, Data)
            VALUES (sysdate, 'DELETE', 'DML_AFTER_TRIGGER', :old.FIRST_COLUMN || ' ' || :old.SECOND_COLUMN);
        END IF;
    end;

INSERT INTO LAB12_TABLE (FIRST_COLUMN, SECOND_COLUMN) VALUES (20, 'New text');
UPDATE LAB12_TABLE SET SECOND_COLUMN = 'Updated text' WHERE FIRST_COLUMN = 20;
DELETE FROM LAB12_TABLE WHERE FIRST_COLUMN = 20;
COMMIT;

-- Task 11
INSERT INTO LAB12_TABLE (FIRST_COLUMN, SECOND_COLUMN) VALUES ('dfghjk', 1);

-- Task 12
DROP TABLE LAB12_TABLE;

CREATE OR REPLACE TRIGGER PREVENTING_DROP_TABLE_TRIGGER
    BEFORE DROP
    ON GKV.SCHEMA
    BEGIN
        IF DICTIONARY_OBJ_NAME = 'LAB12_TABLE' THEN
        RAISE_APPLICATION_ERROR(-20000, 'You can not drop table LAB12_TABLE');
        end if;
    end;

DROP TRIGGER PREVENTING_DROP_TABLE_TRIGGER;
-- Task 13
DROP TABLE LAB12_TABLE;

-- Task 14
CREATE VIEW Lab12_table_view AS SELECT * FROM LAB12_TABLE;

CREATE OR REPLACE TRIGGER INSTEAD_OF_INSERT_TRIGGER
    INSTEAD OF INSERT ON Lab12_table_view
    BEGIN
        IF INSERTING THEN
            DBMS_OUTPUT.PUT_LINE('INSTEAD_OF_INSERT_TRIGGER');
            INSERT INTO LAB12_TABLE (FIRST_COLUMN, SECOND_COLUMN) VALUES (50, 'Instead of action');
        end if;
    end INSTEAD_OF_INSERT_TRIGGER;

INSERT INTO Lab12_table_view (FIRST_COLUMN, SECOND_COLUMN) VALUES (25, 'Some new value in view');