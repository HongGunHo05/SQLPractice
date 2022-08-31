-- rownum : 검색할때 자동 행 번호 추가  /  rowid  ---------------------
SELECT
	ename,
	job,
	rownum
FROM
	emp;

SELECT
	rownum,
	ename,
	job
FROM
	emp;

DELETE
FROM
	emp
WHERE
	ROWNUM = 4;
-- rownum 은 select에만 적용 , 삭제, 수정에는 사용 안됨
--dual : 테이블
--rownum : 번호 부여  -- 오라클 데이터베이스 이용한 게시판 만들경우 페이징처리에 사용, cf) 1 limit 7  : MySql
--rowid : 
SELECT
	rownum,
	ename,
	job,
	rowid
FROM
	emp;

SELECT
	rownum,
	job,
	ename
FROM
	emp
WHERE
	sal > 3000;

SELECT
	ROWNUM,
	ename,
	sal
FROM
	(
	SELECT
		*
	FROM
		EMP
	ORDER BY
		sal);
-- Sequence : 자동 증가 번호 ------------------------------------------------
/*
Sequence 생성방법>
create sequence 시퀀스이름 -- 1부터 시작, 1씩 증가
    [start with 시작값 ]
    [increment by 증가치 ]
    [maxvalue 최대값 ]
    [minvalue 최소값 ]
    [cycle | nocycle ]
    [cache | nocache ]
*/

DROP SEQUENCE autonum;

CREATE SEQUENCE autonum;
-- 1부터 시작해서 1씩 증가한다.

SELECT
	autonum.nextval
FROM
	dual;
-- 시퀀스값 증가
SELECT
	autonum.currval
FROM
	dual;
-- 현재 시퀀스값 가져오기

CREATE TABLE kosa_T (
    NO number,
    name varchar2(20)
);

INSERT
	INTO
	kosa_T
VALUES(autonum.nextval,
'aa');

INSERT
	INTO
	kosa_T
VALUES(autonum.nextval,
'bb');

INSERT
	INTO
	kosa_T
VALUES(autonum.nextval,
'cc');

INSERT
	INTO
	kosa_T
VALUES(autonum.nextval,
'dd');

SELECT
	*
FROM
	kosa_T;

DROP TABLE kosa;

CREATE SEQUENCE seq_kosa;

CREATE TABLE kosa (
    num number,
    id varchar2(20),
    name varchar2(20)
);

INSERT
	INTO
	kosa
VALUES(seq_kosa.nextval,
'dd',
'name');

INSERT
	INTO
	kosa
VALUES(seq_kosa.nextval,
'ff',
'name');

INSERT
	INTO
	kosa
VALUES(seq_kosa.nextval,
'gg',
'name');

DROP SEQUENCE seq_kosa;

CREATE SEQUENCE seq_kosa
    INCREMENT BY 100;

SELECT
	*
FROM
	kosa;
--create SEQUENCE seq_board
ALTER SEQUENCE seq_board
--    maxvalue  1000;
--     INCREMENT by 100;
      CYCLE 
      cache 2;

CREATE TABLE kosa2 (
    num number,
    id varchar2(20),
    name varchar2(20)
);

INSERT
	INTO
	kosa2
VALUES(seq_board.nextval,
'dd',
'name');

INSERT
	INTO
	kosa2
VALUES(seq_board.nextval,
'ff',
'name');

INSERT
	INTO
	kosa2
VALUES(seq_board.nextval,
'gg',
'name');

SELECT
	*
FROM
	kosa2;

CREATE SEQUENCE seq_jumin_no
    INCREMENT BY 10
START WITH
10
    MAXVALUE 150
    MINVALUE 9
    CYCLE
    cache 2 ;

CREATE TABLE jumin_T (
    seq number,
    name varchar2(20),
    phone VARCHAR2(15)
);

INSERT
	INTO
	jumin_T
VALUES(seq_jumin_no.nextval,
'aa',
'1111');

INSERT
	INTO
	jumin_T
VALUES(seq_jumin_no.nextval,
'bb',
'2222');

INSERT
	INTO
	jumin_T
VALUES(seq_jumin_no.nextval,
'cc',
'3333');

INSERT
	INTO
	jumin_T
VALUES(seq_jumin_no.nextval,
'cc',
'4444');

INSERT
	INTO
	jumin_T
VALUES(seq_jumin_no.nextval,
'dd',
'5555');

INSERT
	INTO
	jumin_T
VALUES(seq_jumin_no.nextval,
'ee',
'666');

SELECT
	*
FROM
	jumin_T;
-- Transaction  ------------------------------------------
CREATE TABLE c_emp100
AS
    SELECT
	*
FROM
	emp
WHERE
	1 = 2;
-- 조건에 맞지 않은 상태
---------------------------------------------------
BEGIN
    FOR i IN 1..10000 loop
        INSERT
	INTO
	c_emp100
            SELECT
	*
FROM
	emp;
END loop;
END;
----------------------------------------------------
SELECT
	*
FROM
	c_emp100;

ROLLBACK;

COMMIT;

UPDATE
	c_emp100
SET
	sal = 1000;

DELETE
FROM
	c_emp100
WHERE
	deptno = 20;

ROLLBACK;
-------------------------------------------------------------------
UPDATE
	c_emp100
SET
	sal = 888
WHERE
	deptno = 20;

SAVEPOINT update_sal;
-- savepoint 식별자; 

UPDATE
	c_emp100
SET
	sal = 99
WHERE
	deptno = 30;

SAVEPOINT update_sal_30;

UPDATE
	c_emp100
SET
	sal = 1
WHERE
	deptno = 30;

SELECT
	*
FROM
	c_emp100;

SELECT
	sum(sal)
FROM
	c_emp100;
--  131960000

ROLLBACK TO SAVEPOINT update_sal;
-- rollback to savepoint  식별자; 
COMMIT;

SELECT
	sum(sal)
FROM
	c_emp100;
-- 225900000
ROLLBACK TO SAVEPOINT update_sal_30;
----------------------------------------------------------------
SAVEPOINT create_tt;

CREATE TABLE tt ( id number );

INSERT
	INTO
	tt
VALUES(1);

INSERT
	INTO
	tt
VALUES(2);

INSERT
	INTO
	tt
VALUES(3);

INSERT
	INTO
	tt
VALUES(4);

SELECT
	*
FROM
	tt;

ROLLBACK TO SAVEPOINT create_tt;

DROP TABLE tt;

COMMIT / ROLLBACK ;
-- DML 명령에만 적용됨
------------------------------------------------------------------
show USER;

SELECT
	*
FROM
	emp2;

SELECT
	*
FROM
	smile.tt;

INSERT
	INTO
	smile.tt
VALUES(7);

COMMIT;

GRANT
SELECT
	ON
	kingsmile.emp TO smile;

GRANT
INSERT
	,
	DELETE
	,
	UPDATE
	ON
	kingsmile.emp TO smile;

GRANT
INSERT
	,
	DELETE
	,
	UPDATE
	ON
	smile.tt TO kingsmile;
--DROP TABLE table명 [CASCADE CONSTRAINTS] ;
DROP TABLE dept CASCADE CONSTRAINTS;
-- 걸려있는 제약조건까지 제거함. 

REVOKE ALL ON
계정명.테이블이름
FROM
계정명;

DELETE
FROM
	smile.tt
WHERE
	id IN(1, 3, 7);

COMMIT;

REVOKE
DELETE
	ON
	smile.tt
FROM
	kingsmile;

REVOKE
SELECT
	ON
	kingsmile.emp
FROM
	smile;
-----------------------------------------------------
SELECT
	*
FROM
	c_emp_20;

SELECT
	*
FROM
	reg_test;
