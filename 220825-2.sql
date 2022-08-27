-- DML 
-- select distinct | * | 컬럼명 as 별칭, 컬럼명 별칭,....
-- from 테이블이름
-- [where 조건식 ]
-- [order by 컬럼명 desc | asc , .. ]
SELECT
    *
FROM
    emp2;

SELECT
    name,
    empno,
    deptno
FROM
    emp2
WHERE
    emp_type = '정규직'
ORDER BY
    name DESC;

SELECT
    name     AS "성 명",
    empno    사원번호,
    deptno   "부 서",
    emp_type AS 근무타입,
    position "직 급"
FROM
    emp2
WHERE
    position = '부장'
    OR name = '유관순';  -- varchar2 타입의 경우 ' '을 사용해줘야 됨

SELECT
    *
FROM
    emp2
WHERE
    deptno = 1000;

-- 연산자
SELECT
    mod(7, 3)
FROM
    dual;
-- 관계(비교)연산자 중 같다는 sql에서는 (=)이고 자바에서는 (==)이다.

SELECT
    name,
    bonus,
    nvl(bonus, 0) + 100 AS "보너스 추가" -- null값은 연산이 안 됨 따라서 nvl함수(nvl(대상, 0))를 사용해야 됨 
FROM
    professor;
--    where bonus is null; 

    -- bonus = null -> x 
    -- bonus is null -> o , bonus is not null
    
    -- nvl 함수

SELECT
    *
FROM
    professor;

SELECT
    *
FROM
    professor
WHERE
    position = '정교수'
    OR position = '조교수';

SELECT
    *
FROM
    professor
WHERE
    position IN ( '정교수', '조교수' );

SELECT
    *
FROM
    student
WHERE
    grade IN ( 3, 2, 1 ); -- 권장 --> 속도가 더 빠르기에 
    -- where grade = 3 or grade = 2 or grade = 1

SELECT
    *
FROM
    student
WHERE
    grade NOT IN ( 3, 2, 1 ); -- not 을 쓰면 제외하고 조회

SELECT
    *
FROM
    professor;

SELECT
    *
FROM
    professor
WHERE
    fdeptno BETWEEN 103 AND 201;

SELECT
    *
FROM
    emp2
WHERE
    name LIKE '김%'; -- % : 모든 

SELECT
    *
FROM
    emp2
WHERE
    name LIKE '%윤%';

SELECT
    *
FROM
    professor
WHERE
    name LIKE '__'; -- _ 언더바 하나가 한 글자 의미
-- 두글자 들어 온 것을 찾는다

SELECT
    *
FROM
    professor
WHERE
    name LIKE '허_';

SELECT
    *
FROM
    professor
WHERE
    name LIKE '나_%'; -- '나_%';

SELECT
    *
FROM
    professor
WHERE
    name LIKE '%원_%';

--is null --> null 값 찾기

-- 숫자 --
SELECT
    *
FROM
    professor;
-- where pay > 500;
-- where pay <= 300;
-- where pay >= 250 and pay <500;
-- where pay >= 250 or pay < 500;





--------------------------------------------------------------------------------
SELECT
    *
FROM
    professor
WHERE
        pay >= 500
    AND bonus >= 60;
--1번

UPDATE emp2
SET
    name = '너한라'
WHERE
    name = '나한라';
--2번

UPDATE emp2
SET
    hobby = '수영'
WHERE
    hobby = '등산';
--3번

DELETE FROM emp2
WHERE
    emp_type = '계약직';
--4번

SELECT
    *
FROM
    professor
WHERE
    pay >= 50
    OR bonus >= 50;
--5번

SELECT
    *
FROM
    gift;

SELECT
    *
FROM
    gift
WHERE
    gname NOT LIKE '%세트%';
--6번

UPDATE gift
SET
    gname = NULL
WHERE
    gno = 10;
--7번

INSERT INTO gift (
    gname,
    g_start
) VALUES (
    NULL,
    999
);
--8번

SELECT
    *
FROM
    gift
WHERE
    gname IS NOT NULL
    OR gname NOT IN '';
--9번
