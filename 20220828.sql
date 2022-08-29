--날짜 함수
SELECT
    sysdate
FROM
    dual;

SELECT
    month_between(sysdate, '2018/12/20')
FROM
    dual;

-- 지정한 요일 중에서 가장 가까운 일이 몇일 인지 찾는다
SELECT
    next_day(DATE '2022-08-29', '화')
FROM
    dual;

SELECT
    next_day(DATE '2022-08-28', 6)
FROM
    dual;

SELECT
    next_day(DATE '2022-08-28', 7)
FROM
    dual;

SELECT
    next_day(DATE '2022-08-28', '토')
FROM
    dual;

-- 원하는 달의 수 만큼 지정한 날짜에 더해준다
SELECT
    add_months(DATE '2022-02-01', 1)
FROM
    dual;

SELECT
    add_months(DATE '2022-02-28', 1)
FROM
    dual;

SELECT
    add_months(DATE '2022-08-28', 5)
FROM
    dual;

-- 지정한 날짜에서 달의 마지막 날짜를 구해준다
SELECT
    last_day(DATE '2022-08-28')
FROM
    dual;

SELECT
    last_day(DATE '2022-02-01')
FROM
    dual;

SELECT
    last_day(DATE '2022-12-01')
FROM
    dual;

-- to_~~~

-- 지정한 날짜를 원하는 날짜 형태로 출력해 달라
SELECT
    TO_DATE('20220828', 'yyyymmdd')
FROM
    dual;
-- 지정한 날짜와 시간을 원하는 형태로 출력 해 달라
SELECT
    TO_DATE('20220828123456', 'yyyymmdd hhmiss')
FROM
    dual;

-- to_char : 원하는 날짜를 원하는 format 형식으로 변환한다 
SELECT
    to_char(sysdate, 'yyyy-mm-dd hh:mi:ss')
FROM
    dual;

SELECT
    to_char(sysdate, 'yyyy-mm-dd hh:mi')
FROM
    dual;

SELECT
    to_char(sysdate, 'yyyy-mm-dd')
FROM
    dual;

SELECT
    to_char(sysdate, 'yyyy-mm-dd hh24:mi:ss')
FROM
    dual;

-- 문자를 숫자로 변환하고 연산도 가능하다 
SELECT
    '1234' + 200,
    TO_NUMBER('1234'),
    TO_NUMBER('1234') + 100
FROM
    dual;

-- to_number(컬럼)을 쓰면 컬럼 타입을 number로 바꿀 수 있다
-- to_date(컬럼)을 쓰면 컬럼 타입을 date로 바꿀 수 있다
SELECT
    *
FROM
    emp2;

desc emp2;

-- ,를 세자리 이상마다 찍어준다
-- 원하는 숫자를 ''안의 , 자리 수 만큼 ,를 찍어준다
SELECT
    to_char(2000, '999,999')
FROM
    dual;

SELECT
    to_char(1234678901234, '999,999,999,999,999')
FROM
    dual;
--select to_char(1234678901234, '###,###,###,###,###') from dual;

-- 원하는 돈의 화폐로 출력 할 수 있다
SELECT
    to_char(2000, 'L999,999')
FROM
    dual;

SELECT
    to_char(2000, '$999,999')
FROM
    dual;

-- decode(필드, 해당하는 값이 있느냐, 문장, ...)
-- 대상에 해당하는 값이 일치 하는 경우 사용함

-- case [대상] when 조건 1 then 문장
-- 

SELECT
    *
FROM
    dept;

SELECT
    deptno,
    decode(deptno, 10, '판교점', 20, '정자점',
           30, '야탑점', 40, '서울본사') name
FROM
    dept;

-- 원하는 컬럼들을 가지고 원하는 명령어를 해줄 수 있다
SELECT
    deptno,
    decode(deptno,
           10,
           SUM(sal),
           20,
           MAX(sal),
           30,
           MIN(sal)) sal
FROM
    emp
GROUP BY
    deptno;

SELECT
    deptno,
    nvl(SUM(decode(deptno, 10, sal)),
        0) deptno10,
    nvl(SUM(decode(deptno, 20, sal)),
        0) deptno20,
    nvl(SUM(decode(deptno, 30, sal)),
        0) deptno30,
    nvl(SUM(decode(deptno, 40, sal)),
        0) deptno40
FROM
    emp
GROUP BY
    deptno;
    
--- case 대상 when 조건 then 문장 else 문장 end
SELECT
    deptno,
    CASE deptno
        WHEN 10 THEN
            'ACCOUNTING'
        WHEN 20 THEN
            'RESEARCH'
        WHEN 30 THEN
            'SALES'
        ELSE
            'OPERATIONS'
    END AS "Dept Name"
FROM
    dept;

SELECT
    ename,
    CASE
        WHEN sal < 1000                THEN
            sal + ( sal * 0.8 )
        WHEN sal BETWEEN 1000 AND 2000 THEN
            sal + ( sal * 0.5 )
        WHEN sal BETWEEN 2001 AND 3000 THEN
            sal + ( sal * 0.3 )
        ELSE
            sal + ( sal * 0.1 )
    END sal
FROM
    emp;
    
    
-- 문제 pdept에 따라서 지사명을 출력하세요 (dcode, case 이용)
SELECT
    *
FROM
    dept2;

SELECT
    pdept,
    nvl((decode(pdept, 0001, area)),
        0) pdept0001,
    nvl((decode(pdept, 1000, area)),
        0) pdept1000,
    nvl((decode(pdept, 1003, area)),
        0) pdept1003,
    nvl((decode(pdept, 1006, area)),
        0) pdept1006,
    nvl((decode(pdept, 1007, area)),
        0) pdept1007
FROM
    dept2
ORDER BY
    pdept;
    

--JOIN--------------------------------------------------------------------------
-- pk/ fk 관계
-- 두개 이상의 테이블을 하나의 테이블로 만들어 한번의 검색으로 여러 컬럼의 정보을 확인할 때 사용함

SELECT
    *
FROM
    emp;

SELECT
    *
FROM
    dept;

SELECT
    *
FROM
    emp,
    dept;

-- 테이블명.필드명 원래 이렇게 써야 한다
-- 테이블을 여러개 쓰는데 같은 속성 없다면 원래 써야 하는데로 쓴다
SELECT
    ename,
    job,
    sal,
    e.deptno,
    dname
FROM
    emp  e,
    dept d
WHERE
    e.deptno = d.deptno; 
-- 테이블 별칭을 정할 수 있다
-- 정할 때는 한칸 띄우고 쓴다 
-- 별칭을 정했으면 별칭을 써야 한다
-- inner join
-- 둘이 공통적으로 가지고 있는 것만 보여줘

SELECT
    ename,
    job,
    sal,
    e.deptno,
    dname
FROM
         emp e
    JOIN dept d ON e.deptno = d.deptno;
-- inner join (inner 생략 가능)
-- 양쪽 테이블에서 일치 하는 것 출력
-- join을 쓰면 on으로 조건 --> 세트라 생각

SELECT
    ename,
    job,
    sal,
    e.deptno,
    dname
FROM
    emp  e
    LEFT OUTER JOIN dept d ON e.deptno = d.deptno;
-- left outer join: 왼쪽에 있는 데이터를 모두, 오른쪽 일치하는 데이터만...

SELECT
    ename,
    job,
    sal,
    e.deptno,
    dname
FROM
    emp  e
    RIGHT OUTER JOIN dept d ON e.deptno = d.deptno;
-- left outer join: 오른쪽에 있는 데이터를 모두, 왼쪽 일치하는 데이터만...

INSERT INTO dept (
    deptno,
    loc
) VALUES (
    50,
    'SEOUL'
);

SELECT
    *
FROM
    dept;

SELECT
    ename,
    job,
    sal,
    e.deptno,
    dname
FROM
    emp  e
    RIGHT OUTER JOIN dept d ON e.deptno = d.deptno;

-- 문제 professor / student table 이용
--inner join
--outerjoin - left/ right

-- 교수이름, 직위, 학과 코드, 교수 코드, 학생이름 , 학번 , 학년 , 주전공학과
-- inner, outer ,left right join
SELECT
    *
FROM
    professor;

SELECT
    *
FROM
    student;

SELECT
    p.name   "교수이름",
    position "직위",
    deptno   "학과코드",
    p.profno "교수코드",
    s.name   "학생이름",
    studno   "학번",
    grade    "학년",
    deptno1  "주전공학과"
FROM
         professor p
    JOIN student s ON p.profno = s.profno;

SELECT
    p.name   "교수이름",
    position "직위",
    deptno   "학과코드",
    profno   "교수코드",
    s.name   "학생이름",
    studno   "학번",
    grade    "학년",
    deptno1  "주전공학과"
FROM
    professor p
    LEFT JOIN student   s ON p.profno = s.profno;

SELECT
    p.name   "교수이름",
    position "직위",
    deptno   "학과코드",
    p.profno "교수코드",
    s.name   "학생이름",
    studno   "학번",
    grade    "학년",
    deptno1  "주전공학과"
FROM
    professor p
    LEFT OUTER JOIN student   s ON p.profno = s.profno;

SELECT
    p.name   "교수이름",
    position "직위",
    deptno   "학과코드",
    p.profno "교수코드",
    s.name   "학생이름",
    studno   "학번",
    grade    "학년",
    deptno1  "주전공학과"
FROM
    professor p
    RIGHT OUTER JOIN student   s ON p.profno = s.profno;
    
    
-- 여러개의 테이블 (3개 이상) 조인
--여러개의 테이블 조인
--select 컬럼명 , .....
--from 테이블이름1 별칭1 [Inner] join 테이블이름2 별칭2
--on 별칭1.컬럼명 = 별칭2.컬럼명 [Inner] join 테이블이름3 별칭3 on 별칭2.컬럼명 = 별칭3.컬럼명

SELECT
    *
FROM
    department;

SELECT
    p.profno,
    p.name,
    s.studno,
    s.name,
    s.grade,
    d.dname
FROM
         professor p
    JOIN student    s ON p.profno = s.profno
    JOIN department d ON s.deptno1 = d.deptno;

SELECT
    p.profno,
    p.name,
    s.studno,
    s.name,
    s.grade,
    d.dname
FROM
    professor  p
    LEFT JOIN student    s ON p.profno = s.profno
    RIGHT JOIN department d ON s.deptno1 = d.deptno;

    
--self join
SELECT
    e.empno,
    e.ename,
    e.job,
    em.mgr,
    em.ename
FROM
         emp e
    JOIN emp em ON e.mgr = em.empno;
    
    
    
-- 테이블 복사 / 레코드 복사 --------------------------------------------------------
/*
    create table 테이블 이름
    as selete 필드명, ..... from  테이블명
*/

SELECT
    *
FROM
    emp;

CREATE TABLE c_empall
    AS
        SELECT
            *
        FROM
            emp;
-- 복사는 하는데 제약조건은 복사를 하지 못 한다

SELECT
    *
FROM
    c_empall;

-- 특정 속성의 값을 선택에 복사하기
CREATE TABLE c_emp_20
    AS
        SELECT
            *
        FROM
            emp
        WHERE
            deptno = 20;

SELECT
    *
FROM
    c_emp_20;

CREATE TABLE c_emp_30
    AS
        SELECT
            empno 사번,
            ename 사원명,
            job   직책,
            sal   급여
        FROM
            emp
        WHERE
            deptno = 30;

SELECT
    *
FROM
    c_emp_30;

SELECT
    *
FROM
    c_empall; -- 전체복사
SELECT
    *
FROM
    c_emp_20; -- 조건에 맞는 것만 복사
SELECT
    *
FROM
    c_emp_30; -- 조건 적용, 별칭 추가
    
    
-- 제약조건 확인 방법 1 -> 툴 이용 ( 테이블 클릭하고 원하는 것 보기)
-- 제약조건 확인 방법 2 -> 명령어 이용
SELECT
    *
FROM
    all_constraints
WHERE
    table_name = 'EMP'; 
    -- 오라클은 테이블 이름을 대문자로 저장한다 그래서 대문자로 해줘야 한다

-- 문제1 교수테이블에서 전임강사만 뽑아서 테이블 생성하기
-- 문제2 emp 테이블에서 mgr가 7566번인 사람만 추출해서 새로운 테이블 생성하기

--문제 1번
SELECT
    *
FROM
    professor
WHERE
    position = '전임강사';

CREATE TABLE c_professor
    AS
        SELECT
            *
        FROM
            professor
        WHERE
            position = '전임강사';

SELECT
    *
FROM
    c_professor;
--문제 2번
SELECT
    *
FROM
    emp
WHERE
    mgr = 7566;

CREATE TABLE c_emp
    AS
        SELECT
            *
        FROM
            emp
        WHERE
            mgr = 7566;

SELECT
    *
FROM
    c_emp;
    
    
-- 구조물만 복사 하기를 원할 때

/*
create table 테이블이름
as select 필드명,... from 테이블 이름 where 조건
*/

SELECT
    *
FROM
    emp
WHERE
    1 = 0; -- 조건을 거짓으로 만드는 것이다

CREATE TABLE c_emp4
    AS
        SELECT
            *
        FROM
            emp
        WHERE
            1 = 0;

SELECT
    *
FROM
    c_emp4;
-- 구조물만 복사

CREATE TABLE c_emp5
    AS
        SELECT
            empno,
            ename,
            job,
            sal
        FROM
            emp
        WHERE
            1 = 0;

SELECT
    *
FROM
    c_emp5;
-- 원하는 필드에 해당하는 레코드 복사 (empno, ename, job, sal)

-- Union --- pk / fk 관계 아닌 상태 테이블 합치기
SELECT
    *
FROM
    emp
UNION
SELECT
    *
FROM
    c_empall;
-- union은 중복 된 것은 안 보여준다

SELECT
    *
FROM
    emp
UNION ALL
SELECT
    *
FROM
    c_empall;
-- all 을 붙이면 중복 된 것도 보여준다

INSERT INTO c_empall VALUES (
    7788,
    'smile',
    'manager',
    7566,
    '2202/01/17',
    5000,
    1000,
    30
);

SELECT
    *
FROM
    emp
UNION
SELECT
    *
FROM
    c_emp5;
-- 유니온 시 필드의 개수가 맞지 않으면 안된다

SELECT
    empno,
    ename,
    job,
    sal
FROM
    emp
UNION
SELECT
    *
FROM
    c_emp5;
-- 필드의 개수를 맞추어 주면 가능하다

desc emp;

-- 유니온 시 필드 갯수와 데이터 타입도 일치해야 한다 
SELECT
    empno,
    ename,
    job,
    comm
FROM
    emp
UNION
SELECT
    *
FROM
    c_emp5;
    
    
-- 검색 시 주의사항

SELECT
    *
FROM
    c_empall;

SELECT
    *
FROM
    c_empall
WHERE
    job = 'MANAGER'
    OR job = 'manager';
-- 쿼리문은 대소문자 구분 안한다.
-- 단 레코드는 대소문자 구분한다
-- MANAGER와 manager은 다르게 구분한다

SELECT
    *
FROM
    c_empall
WHERE
    job IN ( 'MANAGER', 'manager' );

SELECT
    *
FROM
    c_empall
WHERE
    job NOT IN ( 'MANAGER', 'manager' );

SELECT
    empno 사원번호,
    ename 이름,
    sal   급여
FROM
    emp
-- where ename = 'FORD';
-- where 이름 = 'FORD'; -- 별칭으로 조건 안됨
ORDER BY
    급여 DESC; -- 정렬은 별칭으로 가능하다 