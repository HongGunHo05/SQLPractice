--PL
/*

CREATE PROCEDURE 프로시져이름 IS
[
변수이름 데이터타입; --프로시져내에서 사용할 변수선언 변수이름 데이터타입;
....
] 
BEGIN
기능 구현; 
END;
 */
-------------------------------------
CREATE OR REPLACE
PROCEDURE p_msg
IS
BEGIN 
	DMBS_OUTPUT.PUT_LINE('오늘 뭐 먹지?');
END;

EXECUTE p_msg;
-------------------------------------

CREATE OR REPLACE
PROCEDURE p_msg (name IN varchar2)
IS
BEGIN 
	DMBS_OUTPUT.PUT_LINE(name || '오늘 뭐 먹지?');
END;

EXECUTE p_msg('geonho');

EXEC p_msg('heungmin');
--------------------------------------

CREATE OR REPLACE
PROCEDURE p_test(
-- 프로시저 생성 
name IN VARCHAR2,
            su IN NUMBER
) 
IS
BEGIN
	DBMS_OUTPUT.PUT_LINE(name || '님 점수는 : ' || su );
END;

EXEC p_test('건호',
99);

EXEC p_test('park',
77);
----------------------------------------------------------
SELECT
	*
FROM
	userlist;

DROP TABLE userlist;

CREATE TABLE userlist (
    id varchar2(10),
    name varchar2(20),
    age NUMBER,
    addr varchar2(50)
);

DESC userlist;

CREATE OR REPLACE
PROCEDURE p_userlist(
-- 프로시저 생성 
id IN userlist.id%TYPE := 'kingsmile',
    name IN userlist.name%TYPE DEFAULT '도연이',
    age IN userlist.age%TYPE := 10,
    addr IN userlist.addr%TYPE := NULL
) 
IS
BEGIN
    INSERT
	INTO
	userlist
VALUES(id,
name,
age,
addr);

DBMS_OUTPUT.PUT_LINE('insert 정보는 : ' || id || ' ' || name || ' ' || age || ' ' || addr );
END;
------------------------------------------
EXEC p_userlist('yuna',
'김연아',
30,
군포 );

SELECT
	*
FROM
	userlist;

EXEC p_userlist(id => '박보검',
age => 33);
------------------------------------------
SELECT
	*
FROM
	USER_OBJECTS
WHERE
	LOWER(OBJECT_type)= 'procedure';

EXEC p_userlist('yuna',
'김연아',
30,
'군포');
-------------------------------------------
CREATE PROCEDURE p_sal
IS
v_salary num := 0;

v_dept_id NUMBER := 0;

BEGIN
	v_dept_id := round(dbms_random.value(10, 120), -1);

DBMS_OUTPUT.PUT_LINE('v_dept_id = ' || v_dept_id);

SELECT
	sal
INTO
	v_salary
FROM
	emp
WHERE
	DEPTNO = v_dept_id
	AND rownum = 1;

DBMS_OUTPUT.PUT_LINE(v_salary);

IF v_salary BETWEEN 1 AND 3000 THEN 
DBMS_OUTPUT.PUT_LINE('보수 적음');

ELSIF v_salary BETWEEN 3001 AND 6000 THEN 
DBMS_OUTPUT.PUT_LINE('시세에 맞춰');

ELSIF v_salary BETWEEN 6001 AND 9000 THEN 
DBMS_OUTPUT.PUT_LINE('보수 좋음');
ELSE  
DBMS_OUTPUT.PUT_LINE('완전 좋음');
END IF;
END;
--------------------------------------------
EXEC p_sal;

SELECT
	*
FROM
	emp;

CREATE OR REPLACE
PROCEDURE p_out( x IN OUT NUMBER )
AS
BEGIN
    dbms_output.put_line( 'x = ' || x );

x := 33;
END;

VARIABLE x VARCHAR2(25);

EXEC p_out(:x);

print x;

EXEC p_out(:x);

VARIABLE y VARCHAR2(25);

EXEC p_out(:y);

print y;
