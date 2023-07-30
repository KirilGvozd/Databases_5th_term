-- Задание №1
SELECT NAME, DESCRIPTION FROM V$BGPROCESS;

-- Задание №2
SELECT NAME, DESCRIPTION FROM V$BGPROCESS WHERE PADDR != '00';

-- Задание №3
SELECT COUNT(*) FROM V$BGPROCESS WHERE PADDR != '00' AND NAME LIKE 'DBW%';

-- Задание №4
SELECT * FROM V$SESSION;

-- Задание №5
SELECT USERNAME, SERVER FROM V$SESSION WHERE USERNAME IS NOT NULL;

-- Задание №6
SELECT * FROM V$SERVICES;

-- Задание №7
SELECT * FROM V$DISPATCHER;
-- В консоли: show parameter dispatchers;

-- Задание №8
-- В докере нет такого сервиса, только если вы установили прямо на винду

-- Задание №9
