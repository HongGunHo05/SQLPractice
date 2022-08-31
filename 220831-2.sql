-- PL/SQL ( Procedural Language ) -----------------------------
/*형식>
Declare  
    선언(선택)
Begin
     실행(필수)
End;
*/
BEGIN
	DBMS_output.put_line('이도연');
--출력
END;
---------------------------------------------
DECLARE
	NAME VARCHAR2(20):= '김연아';
BEGIN
	DBMS_OUTPUT.PUT_LINE('이름은 ' || name);
--화면에출력
END;
-----------------------------------------------------
DECLARE
	e_name emp.ename%TYPE;

e_sal emp.sal%TYPE;
BEGIN
	SELECT
	sal,
	ename
INTO
	e_sal,
	e_name
FROM
	emp
WHERE
	empno = '7788';

DBMS_OUTPUT.PUT_LINE('7788님의 이름은 ' || e_name || ' 급여는 ' || e_sal);
END;
-----------------------------------------------------
DECLARE
	num1 NUMBER := 3;

num2 NUMBER := 5;

BEGIN
   IF num1 >= num2 THEN 
         DBMS_OUTPUT.PUT_LINE(num1 || '이 큽니다');
ELSE DBMS_OUTPUT.PUT_LINE(num2 || '이 큽니다');
END IF;
END;
-----------------------------------------------------------------
DECLARE
	num1 NUMBER;

num2 NUMBER;

BEGIN
    num1 := & num1;

num2 := & num2;

IF num1 >= num2 THEN 
         DBMS_OUTPUT.PUT_LINE(num1 || '이 큽니다');
ELSE DBMS_OUTPUT.PUT_LINE(num2 || '이 큽니다');
END IF;
END;
-----------------------------------------------------------------
DECLARE
	n_sales NUMBER := 300000;

n_commission NUMBER( 10,
2 ) := 0;

BEGIN
  IF n_sales > 200000 THEN
    n_commission := n_sales * 0.1;

ELSIF n_sales <= 200000
AND n_sales > 100000 THEN 
    n_commission := n_sales * 0.05;

ELSIF n_sales <= 100000
AND n_sales > 50000 THEN 
    n_commission := n_sales * 0.03;
ELSE
    n_commission := n_sales * 0.02;
END IF;

DBMS_OUTPUT.PUT_LINE(n_sales || ',  ' || n_commission );
END;
------------------------------------------------------
IF condition_1 THEN
    IF condition_2 THEN
        nested_if_statements;
END IF;
ELSE
    else_statements;
END IF;
------------------------------------------------------------
