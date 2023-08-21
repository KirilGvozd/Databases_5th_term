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

-- Задание №9-№17
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
    second_float_number number(3, 10) := 12.2134;
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