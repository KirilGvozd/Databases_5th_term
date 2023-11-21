-- Задание №1
BEGIN
    NULL;
end;

-- Задание №2
BEGIN
    DBMS_OUTPUT.PUT_LINE('Hello World');
end;

-- Задание №3
BEGIN
    declare
      x number(3):=21;
      y number(3):=0;
      z number(3);
    begin
      dbms_output.put_line('x= ' || x || ', y= ' || y);
      z:=x/y;
      dbms_output.put_line('z= '|| z);
    exception
      when others
      then dbms_output.put_line('error = '|| sqlerrm || ', error sqlcode = ' || sqlcode);
    end;
END;

-- Задание №4
BEGIN
    declare
    z number(10,2) := 21;
    begin
        begin
            z := 5/0;
        exception
            when OTHERS
            then dbms_output.put_line('ERROR SQLCODE = ' || sqlcode || chr(10) || 'ERROR MESSAGE = ' || sqlerrm);
        end;
        dbms_output.put_line('z = '||z);
    end;
end;

-- Задание №5
-- (В консоли) show parameter plsql_warnings;
SELECT NAME, VALUE FROM V$PARAMETER WHERE NAME = 'plsql_warnings';

-- Задание №6
SELECT KEYWORD FROM V$RESERVED_WORDS WHERE LENGTH = 1 AND KEYWORD != 'A';

-- Задание №7
SELECT KEYWORD FROM V$RESERVED_WORDS WHERE LENGTH > 1 AND KEYWORD != 'A' ORDER BY KEYWORD;

-- Задание №8
-- (В консоли) show parameter plsql;
SELECT NAME, VALUE FROM V$PARAMETER WHERE NAME LIKE 'plsql%';

-- Задание №9-№13
    DECLARE
        first_number number(5) := 20;
        second_number number(5) := 15;
        third_number number(5);
    BEGIN
        third_number := first_number + second_number;
        DBMS_OUTPUT.PUT_LINE('Сложение: '|| third_number);
        third_number := MOD(first_number, second_number);
        DBMS_OUTPUT.PUT_LINE('Деление с остатком: '|| third_number);
    end;
    DECLARE
    float_number number(2, 5) := 2.124;
    second_float_number number(3, 10) := 12.21;
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Первое число: '|| float_number);
        DBMS_OUTPUT.PUT_LINE('Второе число: '|| second_float_number);
    end;
    DECLARE
    third_float_number number(2, -3) := 12.21;
    fourth_float_number number(3, -4) := 12412;
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Третье число: '|| third_float_number);
        DBMS_OUTPUT.PUT_LINE('Четвёртое число: '|| fourth_float_number);
    end;

-- Задание №14-15
DECLARE
binary_float_number binary_float := 123.21414;
binary_double_number binary_double := 123.12421541;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Binary float число: '|| binary_float_number);
    DBMS_OUTPUT.PUT_LINE('Binary double число: '|| binary_double_number);
end;

-- Задание №16-17
DECLARE
number_with_power number := 1e-5;
boolean_variable boolean := true;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Число в степени: '|| number_with_power);
    DBMS_OUTPUT.PUT_LINE('Булевая переменная: '|| boolean_variable);
end;

-- Задание №18
DECLARE
constant_number constant number := 12;
constant_string constant nvarchar2 := 'Строка';
BEGIN
    DBMS_OUTPUT.PUT_LINE('constant_number / 3: '|| constant_number / 3);
    DBMS_OUTPUT.PUT_LINE('constant_number * 3: '|| constant_number * 3);
    DBMS_OUTPUT.PUT_LINE('constant_string: '|| constant_string);
end;

-- Задание №19
DECLARE
pulp PULPIT.PULPIT%TYPE;
BEGIN
    pulp := 'ИСиТ';
    DBMS_OUTPUT.PUT_LINE(pulp);
end;

-- Задание №20
DECLARE
faculty_res FACULTY%ROWTYPE;
BEGIN
    faculty_res.FACULTY := 'ТОВ';
    faculty_res.FACULTY_NAME := 'Технология Органических Веществ';
    DBMS_OUTPUT.PUT_LINE(faculty_res);
end;

-- Задание №21-22
DECLARE
some_number number := 12;
BEGIN
    IF some_number > 10 THEN
        DBMS_OUTPUT.PUT_LINE('10 <' || some_number);
    ELSIF some_number = 10 THEN
        DBMS_OUTPUT.PUT_LINE('12 =' || some_number);
    ELSE
        DBMS_OUTPUT.PUT_LINE('10 >' || some_number);
    end if;
end;

-- Задание №23
DECLARE
some_number number := 10;
BEGIN
    CASE
        WHEN some_number < 10 THEN DBMS_OUTPUT.PUT_LINE('10 >' || some_number);
        WHEN some_number = 10 THEN DBMS_OUTPUT.PUT_LINE('10 =' || some_number);
        WHEN some_number BETWEEN 1 AND 5 THEN DBMS_OUTPUT.PUT_LINE('1 <' || some_number || '< 5');
    END CASE;
end;

-- Задание №24
DECLARE some_number number := 5;
BEGIN
    LOOP some_number := some_number + 1;
    DBMS_OUTPUT.PUT_LINE(some_number);
    EXIT WHEN some_number = 10;
    END LOOP;
end;

-- Задание №25
DECLARE some_number number := 1;
BEGIN
    WHILE (some_number < 5)
        LOOP some_number := some_number + 1;
        DBMS_OUTPUT.PUT_LINE(some_number);
        END LOOP;
end;

-- Задание №26
BEGIN
    FOR x in 1..5
    LOOP DBMS_OUTPUT.PUT_LINE(x);
    END LOOP;
end;