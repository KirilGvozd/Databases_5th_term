-- Task 1
CREATE TABLE Export_table (
    id integer,
    some_string nvarchar2(50)
);

CREATE TABLE Import_table (
    id integer,
    some_string nvarchar2(50)
);

CREATE TABLE Job_status (
    status nvarchar2(50),
    error_message nvarchar2(700),
    date_of_message date default SYSDATE
);

INSERT INTO Export_table (id, some_string) VALUES (1, 'First string');
INSERT INTO Export_table (id, some_string) VALUES (2, 'Second string');
INSERT INTO Export_table (id, some_string) VALUES (3, 'Third string');
INSERT INTO Export_table (id, some_string) VALUES (4, 'Fourth string');
COMMIT;

-- Task 2 and 3
CREATE OR REPLACE PROCEDURE Procedure_for_job
IS CURSOR cursor_for_job iS SELECT * FROM Export_table;
    error_message varchar2(700);
    BEGIN
        FOR row in cursor_for_job
        LOOP
            INSERT INTO Import_table (id, some_string) VALUES (row.id, row.some_string);
        end loop;
        DELETE FROM Export_table;
        INSERT INTO Job_status (status, date_of_message) VALUES ('SUCCESS', SYSDATE);
        COMMIT;
        EXCEPTION WHEN OTHERS THEN
            error_message := SQLERRM;
            INSERT INTO Job_status (status, error_message) VALUES ('FAILURE', error_message);
            COMMIT;

    end Procedure_for_job;

DECLARE job_number USER_JOBS.JOB%type;
BEGIN
    DBMS_JOB.SUBMIT(job_number, 'BEGIN Procedure_for_job; END;', SYSDATE, 'SYSDATE + 7');
    COMMIT;
    SYS.DBMS_OUTPUT.PUT_LINE(job_number);
end;

SELECT * FROM Job_status;
 -- Task 4
 SELECT JOB, WHAT, LAST_DATE, LAST_SEC, NEXT_DATE, NEXT_SEC, NEXT_DATE, BROKEN FROM USER_JOBS;

-- Task 5
BEGIN
    DBMS_JOB.RUN(2);
end;

SELECT * FROM Job_status;
SELECT * FROM Export_table;
SELECT * FROM Import_table;

BEGIN
    DBMS_JOB.REMOVE(2);
end;

-- Task 6
BEGIN
    DBMS_SCHEDULER.CREATE_SCHEDULE(
    SCHEDULE_NAME => 'Schedule_1', START_DATE => SYSDATE, REPEAT_INTERVAL => 'FREQ=WEEKLY', COMMENTS => 'Schedule_1 WEEKLY'
    );
end;

SELECT * FROM USER_SCHEDULER_SCHEDULES;

BEGIN
    DBMS_SCHEDULER.CREATE_PROGRAM(
    PROGRAM_NAME => 'Program_1', PROGRAM_TYPE => 'STORED_PROCEDURE', PROGRAM_ACTION => 'Procedure_for_job', NUMBER_OF_ARGUMENTS => 0, ENABLED => TRUE, COMMENTS => 'Program_1'
    );
end;

SELECT * FROM USER_SCHEDULER_PROGRAMS;

BEGIN
    DBMS_SCHEDULER.CREATE_JOB(
    JOB_NAME => 'Scheduler_job_1', PROGRAM_NAME => 'Program_1', SCHEDULE_NAME => 'Schedule_1', ENABLED => TRUE);
end;

SELECT * FROM USER_SCHEDULER_JOBS;

BEGIN
    DBMS_SCHEDULER.DISABLE('Scheduler_job_1');
end;

BEGIN
    DBMS_SCHEDULER.ENABLE('Scheduler_job_1');
end;

BEGIN
    DBMS_SCHEDULER.RUN_JOB('Scheduler_job_1');
end;

SELECT * FROM Job_status;

BEGIN
    DBMS_SCHEDULER.DROP_JOB('Scheduler_job_1');
end;