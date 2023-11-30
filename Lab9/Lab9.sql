-- Task 1
DECLARE
    auditorium_res AUDITORIUM%rowtype;
BEGIN
    SELECT * INTO auditorium_res FROM AUDITORIUM WHERE AUDITORIUM = '313-1';
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
end;
