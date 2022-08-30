-- view -------------
/*
    create or replace view 뷰이름 as --> 뷰 수정
    뷰의 내용
    
    
    drop view 뷰이름 --> 뷰 삭제
*/

SELECT
    *
FROM
    professor;

SELECT
    *
FROM
    emp;

CREATE OR REPLACE VIEW v_emp AS
    SELECT
        empno,
        ename,
        deptno
    FROM
        emp;
--where deptno = 20;

SELECT
    *
FROM
    v_emp;

--emp 테이블 제거하면 v_emp 테이블은?
--같이 제거 된다. 복사본도 같이 제거 된다.

--v_emp 테이블 제거하면 emp 테이블은?
--v_emp 테이블은 가상의 테이블이기 때문에 emp 테이블은 제거 되지 않는다.

CREATE OR REPLACE VIEW v_student_join AS
    SELECT
        p.profno,
        p.name,
        p.position,
        s.grade,
        d.dname,
        p.deptno
    FROM
             professor p
        JOIN student    s ON p.profno = s.profno
        JOIN department d ON s.deptno1 = d.deptno;

SELECT
    *
FROM
    v_student_join;
    

----- 제약조건 제거
--alter table 테이블 명, drop constraint 제약조건명 cascade;
ALTER TABLE board DROP CONSTRAINT board_no_pk CASCADE;

ALTER TABLE dept DROP CONSTRAINT fk_deptno;  --외래키 제거
ALTER TABLE dept DROP CONSTRAINT pk_dept; -- pk라서 삭제 할 수 없다
ALTER TABLE dept DROP CONSTRAINT pk_dept CASCADE; -- cascade를 붙이면 삭제 할 수 있다 

-- pk 생성------------------
--alter table 테이블 명 add (constraint 제약조건명 primary key(컬럼명1, 컬럼명2.....));
ALTER TABLE dept ADD (
    CONSTRAINT pk_dept PRIMARY KEY ( deptno )
);

SELECT
    *
FROM
    c_empall;

desc c_empall;

ALTER TABLE c_empall ADD (
    CONSTRAINT c_emp_pk_empno PRIMARY KEY ( empno )
);

SELECT
    *
FROM
    cal;

desc cal;

ALTER TABLE cal ADD (
    CONSTRAINT cal_num_pk PRIMARY KEY ( num_day )
);

SELECT
    *
FROM
    all_constraints
WHERE
    table_name = 'cal';

-- 레코드 복사-----------------------------------------
/*
insert into 테이블이름
select 컬럼명, ... from 테이블이름
*/

SELECT
    *
FROM
    c_emp4;

CREATE TABLE c_emp6
    AS
        SELECT
            ename,
            empno,
            hiredate
        FROM
            emp
        WHERE
            1 = 0;
-- 구조 복사 

SELECT
    *
FROM
    c_emp6;

INSERT INTO c_emp6
    SELECT
        emp_type,
        pay,
        birthday
    FROM
        emp2; 
--다른 테이블에서 필드 개수와 타입 맞게 가져 올 수 있다.
--레코드 갯수, 데이터 타입, 데이터 크기 맞추면 됨.

-- 넣기 전 테이블의 필드의 자료형 수정한다.
ALTER TABLE c_emp6 MODIFY
    ename VARCHAR(16);

ALTER TABLE c_emp6 MODIFY
    empno NUMBER;

desc c_emp6;
desc emp2;