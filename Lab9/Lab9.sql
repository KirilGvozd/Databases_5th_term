-- Task 1
DECLARE
    auditorium_res AUDITORIUM%rowtype;
BEGIN
    SELECT * INTO auditorium_res FROM AUDITORIUM WHERE AUDITORIUM = '206-1';
    DBMS_OUTPUT.PUT_LINE(auditorium_res.AUDITORIUM || ' Capacity: ' || auditorium_res.AUDITORIUM_CAPACITY);
    EXCEPTION WHEN OTHERS
    THEN DBMS_OUTPUT.PUT_LINE(sqlerrm);
end;

-- Task 2
DECLARE
    auditorium_res AUDITORIUM%rowtype;
BEGIN
    SELECT * INTO auditorium_res FROM AUDITORIUM;
    DBMS_OUTPUT.PUT_LINE(auditorium_res.AUDITORIUM || ' Capacity: ' || auditorium_res.AUDITORIUM_CAPACITY);
    EXCEPTION WHEN OTHERS
    THEN DBMS_OUTPUT.PUT_LINE(sqlerrm);
end;

-- Task 3
DECLARE
    auditorium_res AUDITORIUM%rowtype;
BEGIN
    SELECT * INTO auditorium_res FROM AUDITORIUM;
    DBMS_OUTPUT.PUT_LINE(auditorium_res.AUDITORIUM || ' Capacity: ' || auditorium_res.AUDITORIUM_CAPACITY);
    EXCEPTION WHEN TOO_MANY_ROWS
        THEN DBMS_OUTPUT.PUT_LINE('Too many rows.');
    WHEN OTHERS
        THEN DBMS_OUTPUT.PUT_LINE(sqlerrm);
end;

-- Task 4
DECLARE
    auditorium_res AUDITORIUM%rowtype;
BEGIN
    SELECT * INTO auditorium_res FROM AUDITORIUM WHERE AUDITORIUM = '404-1';
    DBMS_OUTPUT.PUT_LINE(auditorium_res.AUDITORIUM || ' Capacity: ' || auditorium_res.AUDITORIUM_CAPACITY);
    EXCEPTION WHEN NO_DATA_FOUND
        THEN DBMS_OUTPUT.PUT_LINE('No data found');
    WHEN OTHERS
        THEN DBMS_OUTPUT.PUT_LINE(SQLERRM);
end;

DECLARE
    auditorium_res AUDITORIUM%rowtype;
BEGIN
    SELECT * INTO auditorium_res FROM AUDITORIUM WHERE AUDITORIUM = '313-1';
    DBMS_OUTPUT.PUT_LINE(auditorium_res.AUDITORIUM || ' Capacity: ' || auditorium_res.AUDITORIUM_CAPACITY);

    IF sql%isopen
        THEN DBMS_OUTPUT.PUT_LINE('isopen: true');
    ELSE
        DBMS_OUTPUT.PUT_LINE('isopen: false');
    END IF;

    IF sql%found
        THEN DBMS_OUTPUT.PUT_LINE('found: true');
    ELSE
        DBMS_OUTPUT.PUT_LINE('found: false');
    END IF;

    IF sql%notfound
        THEN DBMS_OUTPUT.PUT_LINE('notfound: true');
    ELSE
        DBMS_OUTPUT.PUT_LINE('notfound: false');
    END IF;

    DBMS_OUTPUT.PUT_LINE('rowcount: ' || sql%rowcount );
end;

-- Task 5
BEGIN
    UPDATE TEACHER
        SET PULPIT = 'ИСиТ'
    WHERE TEACHER = 'БЗБРДВ';
    COMMIT;
    ROLLBACK;
    EXCEPTION
        WHEN OTHERS
            THEN DBMS_OUTPUT.PUT_LINE(sqlerrm);
end;

SELECT * FROM TEACHER WHERE TEACHER = 'БЗБРДВ';

-- Task 6
BEGIN
    UPDATE AUDITORIUM
        SET AUDITORIUM_CAPACITY = 'qwertyui'
    WHERE AUDITORIUM = '313-1';
    EXCEPTION
        WHEN OTHERS
            THEN DBMS_OUTPUT.PUT_LINE(sqlerrm);
end;

-- Task 7
BEGIN
    INSERT INTO AUDITORIUM_TYPE (AUDITORIUM_TYPE, AUDITORIUM_TYPENAME) VALUES ('LK-K', 'Some new lection room');
    COMMIT;
    INSERT INTO AUDITORIUM_TYPE (AUDITORIUM_TYPE, AUDITORIUM_TYPENAME) VALUES ('LB-LB', 'Some new lab room');
    ROLLBACK;
    EXCEPTION
        WHEN OTHERS
            THEN DBMS_OUTPUT.PUT_LINE(sqlerrm);
end;

-- Task 8
BEGIN
    INSERT INTO AUDITORIUM_TYPE (AUDITORIUM_TYPE, AUDITORIUM_TYPENAME) VALUES ('sdfvgbhjkmjnbvcxzxcvbnm', 'Hihihaha');
    COMMIT;
    EXCEPTION
        WHEN OTHERS
            THEN DBMS_OUTPUT.PUT_LINE(sqlerrm);
end;

-- Task 9
BEGIN
    DELETE FROM SUBJECT WHERE SUBJECT = 'БД';
    COMMIT;
    DELETE FROM SUBJECT WHERE SUBJECT = 'ПСП';
    ROLLBACK;
    EXCEPTION
        WHEN OTHERS
            THEN DBMS_OUTPUT.PUT_LINE(sqlerrm);
end;

-- Task 10
BEGIN
    DELETE FROM TEACHER WHERE TEACHER = 13;
    IF (sql%rowcount = 0)
        THEN RAISE NO_DATA_FOUND;
    END IF;
    EXCEPTION
        WHEN OTHERS
            THEN DBMS_OUTPUT.PUT_LINE(sqlerrm);
end;

-- Task 11
DECLARE
    cursor teacher_cursor IS SELECT * FROM TEACHER;
    teacher_column TEACHER.TEACHER%type;
    teacher_name_column TEACHER.TEACHER_NAME%type;
    pulpit_column TEACHER.PULPIT%type;
BEGIN
    OPEN teacher_cursor;
    LOOP
        FETCH teacher_cursor INTO teacher_column, teacher_name_column, pulpit_column;
        EXIT WHEN teacher_cursor%notfound;
        DBMS_OUTPUT.PUT_LINE(teacher_column || ' ' || teacher_name_column || ' ' || pulpit_column);
    end loop;
    CLOSE teacher_cursor;
EXCEPTION
    WHEN OTHERS
        THEN DBMS_OUTPUT.PUT_LINE(sqlerrm);
end;

-- Task 12
DECLARE
    cursor subject_cursor IS SELECT * FROM SUBJECT;
    subject_rec SUBJECT%rowtype;
BEGIN
    OPEN subject_cursor;
    FETCH subject_cursor INTO subject_rec;
    WHILE (subject_cursor%found)
        LOOP
            DBMS_OUTPUT.PUT_LINE(subject_rec.SUBJECT || ' ' || subject_rec.PULPIT || ' ' || subject_rec.SUBJECT_NAME);
            FETCH subject_cursor INTO subject_rec;
        end loop;
    CLOSE subject_cursor;
    EXCEPTION
        WHEN OTHERS
            THEN DBMS_OUTPUT.PUT_LINE(sqlerrm);
end;

-- Task 13
DECLARE
    cursor pulpit_teacher_cursor
        IS SELECT PULPIT.PULPIT, TEACHER.TEACHER_NAME FROM PULPIT JOIN TEACHER ON PULPIT.PULPIT = TEACHER.PULPIT;
    pulpit_teacher_rec pulpit_teacher_cursor%rowtype;
BEGIN
    FOR pulpit_teacher_rec IN pulpit_teacher_cursor
        LOOP
            DBMS_OUTPUT.PUT_LINE(pulpit_teacher_rec.PULPIT || ' ' || pulpit_teacher_rec.TEACHER_NAME);
        end loop;
    EXCEPTION
        WHEN OTHERS
            THEN DBMS_OUTPUT.PUT_LINE(sqlerrm);
end;

-- Task 14
DECLARE
    cursor auditorium_cursor (start_capacity AUDITORIUM.AUDITORIUM_CAPACITY%type, end_capacity AUDITORIUM.AUDITORIUM_CAPACITY%type)
    IS SELECT * FROM AUDITORIUM WHERE AUDITORIUM_CAPACITY >= start_capacity AND AUDITORIUM_CAPACITY <= end_capacity;
    auditorium_rec auditorium_cursor%rowtype;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Auditoriums with the capacity less than 20: ');
    FOR auditory in auditorium_cursor(0, 20)
        LOOP
            DBMS_OUTPUT.PUT_LINE(auditory.AUDITORIUM || ' ' || auditory.AUDITORIUM_CAPACITY);
        end loop;

    DBMS_OUTPUT.PUT_LINE('Auditoriums with the capacity between 21 and 30:');
    OPEN auditorium_cursor(21, 30);
    LOOP
        FETCH auditorium_cursor INTO auditorium_rec;
        EXIT WHEN auditorium_cursor%notfound;
        DBMS_OUTPUT.PUT_LINE(auditorium_rec.AUDITORIUM || ' ' || auditorium_rec.AUDITORIUM_CAPACITY);
    end loop;
    CLOSE auditorium_cursor;

    DBMS_OUTPUT.PUT_LINE('Auditoriums with the capacity between 31 and 60:');
    OPEN auditorium_cursor(31, 60);
    FETCH auditorium_cursor INTO auditorium_rec;
    WHILE (auditorium_cursor%found)
     LOOP
        DBMS_OUTPUT.PUT_LINE(auditorium_rec.AUDITORIUM || ' ' || auditorium_rec.AUDITORIUM_CAPACITY);
        FETCH auditorium_cursor INTO auditorium_rec;
    end loop;
    CLOSE auditorium_cursor;

    DBMS_OUTPUT.PUT_LINE('Auditoriums with the capacity between 61 and 80');
    FOR auditory in auditorium_cursor(61, 80)
    LOOP
        DBMS_OUTPUT.PUT_LINE(auditory.AUDITORIUM || ' ' || auditory.AUDITORIUM_CAPACITY);
    end loop;

    DBMS_OUTPUT.PUT_LINE('Auditoriums with the capacity more than 81: ');
    FOR auditory in auditorium_cursor(81, 1000)
    LOOP
        DBMS_OUTPUT.PUT_LINE(auditory.AUDITORIUM || ' ' || auditory.AUDITORIUM_CAPACITY);
    end loop;
    EXCEPTION
        WHEN OTHERS
            THEN DBMS_OUTPUT.PUT_LINE(sqlerrm);
end;

-- Task 15
DECLARE
    type subject_ref_cursor is ref cursor return SUBJECT%rowtype;
    subject_cursor subject_ref_cursor;
BEGIN
    OPEN subject_cursor FOR SELECT * FROM SUBJECT;
    FOR subject in subject_cursor
        LOOP
            DBMS_OUTPUT.PUT_LINE(subject.SUBJECT_NAME || ' ' || subject.PULPIT);
        end loop;
EXCEPTION
    WHEN OTHERS
        THEN DBMS_OUTPUT.PUT_LINE(sqlerrm);
end;

-- Task 16
DECLARE
    cursor auditorium_type_cursor iS SELECT AUDITORIUM_TYPE, cursor (
        SELECT AUDITORIUM FROM AUDITORIUM auditorium_table WHERE auditorium_type_table.AUDITORIUM_TYPE = auditorium_table.AUDITORIUM_TYPE
    ) FROM AUDITORIUM_TYPE auditorium_type_table;
    auditorium_cursor sys_refcursor;
    auditorium_type_table AUDITORIUM_TYPE.AUDITORIUM_TYPE%type;
    text varchar2(1000);
    auditorium_table AUDITORIUM.AUDITORIUM%type;
BEGIN
    OPEN auditorium_type_cursor;
    FETCH auditorium_type_cursor INTO auditorium_type_table, auditorium_cursor;
    WHILE (auditorium_type_cursor%found)
        LOOP
            text := RTRIM(auditorium_type_table) || ':';
            LOOP
                FETCH auditorium_cursor INTO auditorium_table;
                EXIT WHEN auditorium_cursor%notfound;
                text := text || ',' || RTRIM(auditorium_table);
            end loop;
            DBMS_OUTPUT.PUT_LINE(text);
            FETCH auditorium_type_cursor INTO auditorium_table, auditorium_cursor;
        end loop;
    CLOSE auditorium_type_cursor;
EXCEPTION
    WHEN OTHERS
        THEN DBMS_OUTPUT.PUT_LINE(sqlerrm);
end;

-- Task 17
DECLARE
    cursor auditorium_cursor (start_capacity AUDITORIUM.AUDITORIUM_CAPACITY%type, end_capacity AUDITORIUM.AUDITORIUM_CAPACITY%type)
    IS SELECT AUDITORIUM, AUDITORIUM_CAPACITY
       FROM AUDITORIUM WHERE AUDITORIUM_CAPACITY >= start_capacity AND AUDITORIUM_CAPACITY <= end_capacity FOR UPDATE;
    auditorium_column AUDITORIUM.AUDITORIUM%type;
    auditorium_capacity_column AUDITORIUM.AUDITORIUM_CAPACITY%type;
BEGIN
    OPEN auditorium_cursor(40, 80);
    FETCH auditorium_cursor INTO auditorium_column, auditorium_capacity_column;
    WHILE (auditorium_cursor%found)
        LOOP
            auditorium_capacity_column := auditorium_capacity_column * 0.9;
            UPDATE AUDITORIUM SET AUDITORIUM_CAPACITY = auditorium_capacity_column WHERE CURRENT OF auditorium_cursor;
            DBMS_OUTPUT.PUT_LINE(auditorium_column || ' ' || auditorium_capacity_column);
            FETCH auditorium_cursor INTO auditorium_column, auditorium_capacity_column;
        end loop;
    CLOSE auditorium_cursor;
    ROLLBACK;
EXCEPTION
    WHEN OTHERS
        THEN DBMS_OUTPUT.PUT_LINE(sqlerrm);
end;

-- Task 18
DECLARE
    cursor auditorium_cursor (start_capacity AUDITORIUM.AUDITORIUM_CAPACITY%type, end_capacity AUDITORIUM.AUDITORIUM_CAPACITY%type)
    IS SELECT AUDITORIUM, AUDITORIUM_CAPACITY
       FROM AUDITORIUM WHERE AUDITORIUM_CAPACITY >= start_capacity AND AUDITORIUM_CAPACITY <= end_capacity FOR UPDATE;
    auditorium_column AUDITORIUM.AUDITORIUM%type;
    auditorium_capacity_column AUDITORIUM.AUDITORIUM_CAPACITY%type;
BEGIN
    OPEN auditorium_cursor(0, 20);
    FETCH auditorium_cursor INTO auditorium_column, auditorium_capacity_column;
    WHILE (auditorium_cursor%found)
        LOOP
            DELETE FROM AUDITORIUM WHERE CURRENT OF auditorium_cursor;
            DBMS_OUTPUT.PUT_LINE(auditorium_column || ' ' || auditorium_capacity_column);
            FETCH auditorium_cursor INTO auditorium_column, auditorium_capacity_column;
        end loop;
    CLOSE auditorium_cursor;
    COMMIT;
EXCEPTION
    WHEN OTHERS
        THEN DBMS_OUTPUT.PUT_LINE(sqlerrm);
end;

SELECT AUDITORIUM, AUDITORIUM_CAPACITY FROM AUDITORIUM ORDER BY AUDITORIUM_CAPACITY;

-- Task 19
DECLARE
    cursor auditorium_cursor (capacity_parameter AUDITORIUM.AUDITORIUM_CAPACITY%type)
    IS SELECT AUDITORIUM, AUDITORIUM_CAPACITY, ROWID FROM AUDITORIUM WHERE AUDITORIUM_CAPACITY >= capacity_parameter FOR UPDATE;
BEGIN
    FOR xxx IN auditorium_cursor(80)
    LOOP
        CASE
            WHEN xxx.AUDITORIUM_CAPACITY >= 90
                THEN DELETE AUDITORIUM WHERE ROWID = xxx.ROWID;
            WHEN xxx.AUDITORIUM_CAPACITY >= 80
                THEN UPDATE AUDITORIUM SET AUDITORIUM_CAPACITY = AUDITORIUM_CAPACITY * 1.1 WHERE ROWID = xxx.ROWID;
        END CASE;
    end loop;

    FOR auditorium in auditorium_cursor(80)
        LOOP
            DBMS_OUTPUT.PUT_LINE(auditorium.AUDITORIUM || ' ' || auditorium.AUDITORIUM_CAPACITY);
        end loop;
    ROLLBACK;
EXCEPTION
    WHEN OTHERS
        THEN DBMS_OUTPUT.PUT_LINE(sqlerrm);
end;

-- Task 20
DECLARE
    cursor teachers_cursor IS SELECT * FROM TEACHER;
    teachers teachers_cursor%rowtype;
BEGIN
    OPEN teachers_cursor;
    LOOP
        FETCH teachers_cursor INTO teachers;
        EXIT WHEN teachers_cursor%notfound;
        DBMS_OUTPUT.PUT_LINE(teachers.TEACHER || ' ' || teachers.TEACHER_NAME || ' ' || teachers.PULPIT);
        IF (MOD(teachers_cursor%rowcount, 3) = 0)
            THEN DBMS_OUTPUT.PUT_LINE('------------------');
        END IF;
    end loop;
    CLOSE teachers_cursor;
EXCEPTION
    WHEN OTHERS
        THEN DBMS_OUTPUT.PUT_LINE(sqlerrm);
end;