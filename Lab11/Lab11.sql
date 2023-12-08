-- Task 1
CREATE OR REPLACE PROCEDURE GET_TEACHERS (PCODE TEACHER.PULPIT%type)
AS BEGIN
    FOR rec IN (SELECT * FROM TEACHER WHERE PULPIT = PCODE)
    LOOP
        DBMS_OUTPUT.PUT_LINE('Teacher: ' || rec.TEACHER || ' Name: ' || rec.TEACHER_NAME || ' Pulpit: ' || rec.PULPIT);
        end loop;
end;

BEGIN
    GET_TEACHERS('ИСиТ');
end;

-- Task 2
CREATE OR REPLACE FUNCTION GET_NUM_TEACHERS (PCODE TEACHER.PULPIT%TYPE)
RETURN NUMBER
AS
    number_of_teachers number;
    BEGIN
    SELECT COUNT(*) INTO number_of_teachers FROM TEACHER WHERE PULPIT = PCODE;
    RETURN number_of_teachers;
end;


BEGIN
    DBMS_OUTPUT.PUT_LINE(GET_NUM_TEACHERS('ИСиТ'));
end;

-- Task 3
CREATE OR REPLACE PROCEDURE GET_TEACHERS (FCODE FACULTY.FACULTY%type)
AS BEGIN
    FOR rec IN (SELECT * FROM TEACHER JOIN PULPIT ON TEACHER.PULPIT = PULPIT.PULPIT WHERE FACULTY = FCODE)
    LOOP
        DBMS_OUTPUT.PUT_LINE('Teacher: ' || rec.TEACHER || ' Name: ' || rec.TEACHER_NAME || ' Faculty: ' || rec.FACULTY);
        end loop;
end;

BEGIN
    GET_TEACHERS('ИДиП');
end;

CREATE OR REPLACE PROCEDURE GET_SUBJECTS (PCODE SUBJECT.PULPIT%TYPE)
AS BEGIN
    FOR rec IN (SELECT * FROM SUBJECT WHERE PULPIT = PCODE)
    LOOP
        DBMS_OUTPUT.PUT_LINE('Subject: ' || rec.SUBJECT_NAME || '   Pulpit: ' || rec.PULPIT);
        end loop;
end;

BEGIN
    GET_SUBJECTS('ИСиТ');
end;

-- Task 4
CREATE OR REPLACE FUNCTION GET_NUM_TEACHERS (FCODE FACULTY.FACULTY%type)
RETURN NUMBER
AS
    number_of_teachers number;
    BEGIN
    SELECT COUNT(*) INTO number_of_teachers FROM TEACHER JOIN PULPIT ON TEACHER.PULPIT = PULPIT.PULPIT WHERE FACULTY = FCODE;
    RETURN number_of_teachers;
end;


BEGIN
    DBMS_OUTPUT.PUT_LINE(GET_NUM_TEACHERS('ИДиП'));
end;

-- Task 5
CREATE OR REPLACE PACKAGE TEACHERS AS
  PROCEDURE GET_TEACHERS(FCODE FACULTY.FACULTY%TYPE);
  PROCEDURE GET_SUBJECTS(PCODE SUBJECT.PULPIT%TYPE);
  FUNCTION GET_NUM_TEACHERS(FCODE FACULTY.FACULTY%TYPE) RETURN NUMBER;
  FUNCTION GET_NUM_SUBJECTS(PCODE SUBJECT.PULPIT%TYPE) RETURN NUMBER;
END TEACHERS;

CREATE OR REPLACE PACKAGE BODY TEACHERS AS
  PROCEDURE GET_TEACHERS(FCODE FACULTY.FACULTY%TYPE) AS
  BEGIN
    FOR rec IN (SELECT * FROM TEACHER JOIN PULPIT ON TEACHER.PULPIT = PULPIT.PULPIT WHERE FACULTY = FCODE) LOOP
      DBMS_OUTPUT.PUT_LINE('Teacher ID: ' || rec.TEACHER || ', Name: ' || rec.TEACHER_NAME || ', Faculty: ' || rec.FACULTY);
    END LOOP;
  END;

  PROCEDURE GET_SUBJECTS(PCODE SUBJECT.PULPIT%TYPE) AS
  BEGIN
    FOR rec IN (SELECT * FROM SUBJECT WHERE PULPIT = PCODE) LOOP
      DBMS_OUTPUT.PUT_LINE('Subject ID: ' || rec.PULPIT || ', Name: ' || rec.SUBJECT_NAME || ', Pulpit: ' || rec.PULPIT);
    END LOOP;
  END;

  FUNCTION GET_NUM_TEACHERS(FCODE FACULTY.FACULTY%TYPE) RETURN NUMBER AS
    vCount NUMBER;
  BEGIN
    SELECT COUNT(*) INTO vCount FROM TEACHER JOIN PULPIT ON TEACHER.PULPIT = PULPIT.PULPIT WHERE FACULTY = FCODE;
    RETURN vCount;
  END;

  FUNCTION GET_NUM_SUBJECTS(PCODE SUBJECT.PULPIT%TYPE) RETURN NUMBER AS
    vCount NUMBER;
  BEGIN
    SELECT COUNT(*) INTO vCount FROM SUBJECT WHERE PULPIT = PCODE;
    RETURN vCount;
  END;
END TEACHERS;

-- Task 6
BEGIN
    TEACHERS.GET_SUBJECTS('ИСиТ');
    TEACHERS.GET_TEACHERS('ИДиП');
    DBMS_OUTPUT.PUT_LINE(TEACHERS.GET_NUM_TEACHERS('ИДиП'));
    DBMS_OUTPUT.PUT_LINE(TEACHERS.GET_NUM_SUBJECTS('ИСиТ'));
end;