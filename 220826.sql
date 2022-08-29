--정규직이면서 백원만
SELECT
    *
FROM
    emp2
WHERE
        emp_type = '정규직'
    AND name = '백원만';

--정규직이거나 유도봉
SELECT
    *
FROM
    emp2
WHERE
    emp_type = '정규직'
    OR name = '유도봉';

--김씨가 아닌 수습직원 찾기
SELECT
    *
FROM
    emp2
WHERE
        emp_type = '수습직'
    AND name NOT LIKE '김%';
    
--수습직이거나 김씨성을 가진 사람 찾기
SELECT
    *
FROM
    emp2
WHERE
    emp_type = '수습직'
    OR name LIKE '김%';

--문제 1 이름에서 '김영조' 사람들을 보여주세요
SELECT
    *
FROM
    professor
WHERE
    name = '김영조';

--문제 2 이름에서 '김'씨 성을 가진 사람들을 보여주세요 
SELECT
    *
FROM
    professor
WHERE
    name LIKE '김%';

--문제 3 이름이 두 글자인 사람 보여주세요
SELECT
    *
FROM
    professor
WHERE
    name LIKE '__';
--문제 4 id에 s or a 글자가 들어가는 사람 찾기
SELECT
    *
FROM
    professor
WHERE
    id LIKE '%s%'
    OR id LIKE '%a%';

--문제 5 전임강사 찾아주세요
SELECT
    *
FROM
    professor
WHERE
    position = '전임강사';
    
--문제 6 학년이 3학년이고 키가 165이상이고 학과코드가 101인 학생 찾기
SELECT
    *
FROM
    student
WHERE
        grade = 3
    AND height >= 165
    AND deptno1 = 201;

desc student;
--문제 7 생일이 77년도 이전인 학생들 찾기
SELECT
    *
FROM
    student
WHERE
    birthday < '77/01/01';

--문제 8 부전공을 가진 학생들만 찾기
SELECT
    *
FROM
    student
WHERE
    deptno2 IS NOT NULL;

--문제 9 담당교수가 1000 ~ 2001 번 사이 학생들 찾기
SELECT
    *
FROM
    student
WHERE
    profno BETWEEN 1000 AND 2001;

--필드 번호는 1번부터 시작한다

--------------------------------------------------------------------------------

/*
ANY Practice
*/

SELECT
    *
FROM
    professor
WHERE
    pay >= ANY ( 300,
                 550,
                 400 );
-- pay가 최솟값인 300 보다 크거나 같은것들 출력 

SELECT
    *
FROM
    student
WHERE
    weight > ANY ( 70,
                   80 );
-- 몸무게가 최솟값인 70보다 큰 것들 출력

SELECT
    *
FROM
    student
WHERE
    weight < ANY ( 70,
                   80 );
-- 몸무게가 최댓값인 80보다 작은 것들 출력

SELECT
    *
FROM
    student
WHERE
    weight < ALL ( 70,
                   80 );
-- 몸무게가 최솟값인 70보다 작은 것들 출력

SELECT
    *
FROM
    student
WHERE
    weight >= ALL ( 70,
                    80 );
-- 몸무게가 최댓값인 80보다 크거나 같은 것들 출력

--함수---------------------------------------------------------------------------
SELECT
    *
FROM
    gift;

SELECT
    SUM(g_start) "최저가합계",
    SUM(g_end)   "최고가 합계"
FROM
    gift;
-- sum 합계

SELECT
    AVG(g_start),
    AVG(g_end)
FROM
    gift;
-- avg 평균

SELECT
    MAX(g_start),
    MAX(g_end)
FROM
    gift;
-- max 최대값

SELECT
    MIN(g_start),
    MIN(g_end)
FROM
    gift;
-- min 최솟값

SELECT
    COUNT(g_start),
    COUNT(g_end)
FROM
    gift;
-- count null을 제외한 레코드 수

SELECT
    SUM(g_start),
    AVG(g_start),
    MAX(g_start),
    MIN(g_start),
    SUM(g_end)
FROM
    gift;

SELECT
    *
FROM
    professor;
    

--6장 따라하기---------------------------------------------------------------------

--INSERT 삽입하기--
INSERT INTO dept2 (
    dcode,
    dname,
    pdept,
    area
) VALUES (
    9000,
    '특판1팀',
    '영업부',
    '임시지역'
);

INSERT INTO dept2 VALUES (
    9001,
    '특판2팀',
    '영업부',
    '임시지역'
);

--특정 칼럼만 입력하기
INSERT INTO dept2 (
    dcode,
    dname,
    pdept
) VALUES (
    9002,
    '특판3팀',
    '영업부'
);

--날짜 데이터 입력하기
INSERT INTO professor (
    profno,
    name,
    id,
    position,
    pay,
    hiredate
) VALUES (
    5001,
    '김설희',
    'Love_me',
    '정교수',
    510,
    '2011-11-14'
);

--null 값 입력시
--값을 안 주면 자동으로 null로 입력
--값을 수동으로 null로 입력

-- professor2 테이블 생성
CREATE TABLE professor2
    AS
        SELECT
            *
        FROM
            professor;

INSERT INTO professor2
    SELECT
        *
    FROM
        professor;
-- 이 방법은 이미 있는 테이블에 대량의 데이터를 복사 할 때 사용한다
--ITAS 라고 부른다

--여러 테이블에 여러행 입력하기
INSERT ALL INTO p_01 (
    no,
    name
) VALUES (
    1,
    'AAA'
) INTO p_02 (
    no,
    name
) VALUES (
    2,
    'BBB'
) SELECT
      *
  FROM
      dual;
-- p_01 테이블과 p_02 테이블에 각각 서로 다른 데이터를
-- 동시에 입력 하는 방법을 보여준다.

--Professor 테이블에서
--교수번호가 1000 번에서 1999번까지 인 교수의 번호와 교수이름은 p_01 테이블에 입력하고
--교수번호가 2000 번에서 2999번까지 인 교수의 번호와 이름은 p_02 테이블에 입력하세요
INSERT
    ALL WHEN profno BETWEEN 1000 AND 1999 THEN
        INTO p_01
        VALUES (
            profno,
            name
        )
        WHEN profno BETWEEN 2000 AND 2999 THEN
            INTO p_02
            VALUES (
                profno,
                name
            )
SELECT
    profno,
    name
FROM
    professor;

--결과 보기
SELECT
    *
FROM
    p_01;

SELECT
    *
FROM
    p_02;

--12장
--다른 테이블에 동시에 같은 데이터 입력하기
--Professor 테이블에서
--교수번호가 3000번 에서 3999 번인 교수들의 교수 번호와 이름을 p_01 테이블과 p_02 테이블에 동시에 입력하세요.

INSERT ALL INTO p_01 VALUES (
    profno,
    name
) INTO p_02 VALUES (
    profno,
    name
) SELECT
        profno,
        name
    FROM
        professor
  WHERE
      profno BETWEEN 3000 AND 3999;
      
-----------------------------------------------
--UPDATE (변경하기) --

/*
UPDATE  table
SET  column = value
WHERE  조건  ;
*/

--Professor 테이블에서 직급이 조교수 인 교수들의 BONUS 를 100 만원으로 인상하세요.
UPDATE professor
SET
    bonus = 100
WHERE
    position = '조교수';
    
--Professor 테이블에서 
--차범철 교수의 직급과 동일한 직급을 가진 교수들 중 현재 급여가 250 만원이 안 되는 교수들의 급여를 15% 인상하세요.
UPDATE professor
SET
    pay = pay * 1.15
WHERE
        position = (
            SELECT
                position
            FROM
                professor
            WHERE
                name = '차범철'
        )
    AND pay < 250;
    
    
------------------------------------------------------
--DELETE ( 데이터 삭제하기)--
/*
DELETE  FROM  table
WHERE  조건  ;
*/

--Dept2 테이블에서 부서번호(DCODE)가 9000 번에서 9100 번 사이인 매장들을 삭제하세요.
DELETE FROM dept2
WHERE
    dcode BETWEEN 9000 AND 9100;

-------------------------------------------------------------------------------
SELECT
    *
FROM
    professor;

desc professor;

SELECT
    COUNT(*)
FROM
    professor;

SELECT
    COUNT(hpage)
FROM
    professor;

SELECT
    *
FROM
    gift;

SELECT
    COUNT(*)
FROM
    gift;

SELECT
    COUNT(gname)
FROM
    gift;

----------------------
--등수가 나온다
SELECT
    RANK(600000) WITHIN GROUP(ORDER BY g_end DESC)
FROM
    gift
WHERE
    g_end IS NOT NULL;
    
--oracle은 null 값이 우선 순위가 높다
--mysql은 null이 우선순위가 낮다

-- where g_end is not null; -- null 값을 제회 해야 한다
--where g_end is not null or g_end = ' ';

-- 문제 키가 168인 사람은 몇번재로 큰지 확인
SELECT
    RANK(168) WITHIN GROUP(ORDER BY height DESC)
FROM
    student;
    
-- 문제 몸무게가 58인 사람은 몇번째인지 등수 구하기
SELECT
    RANK(58) WITHIN GROUP(ORDER BY weight DESC)
FROM
    student;

-- 문제 g_end가 200000, 600000 보다 작은 값 출력 (any 이용)
SELECT
    *
FROM
    gift
WHERE
    g_end < ANY ( 200000,
                  600000 );

-- 문제 학생들의 키의 합과 평균, 가장 키가 큰 친구, 작은 친구 출력하세요
SELECT
    SUM(height),
    AVG(height),
    MAX(height),
    MIN(height)
FROM
    student;

-- 반에서 문제 학생들의 키의 합과 평균, 가장 키가 큰 친구, 작은 친구 출력하세요
-- 집계함수 사용시 Group by : 소계(부분합)
SELECT
    SUM(height),
    AVG(height),
    MAX(height),
    MIN(height)
FROM
    student
GROUP BY
    grade;

SELECT
    *
FROM
    student;
    
-- emp테이블에서 emp_type 별로 pay 합, 평균, 최고 급여, 최하 급여 구하기
SELECT
    *
FROM
    emp2;

SELECT
    emp_type,
    SUM(pay),
    AVG(pay),
    MAX(pay),
    MIN(pay)
FROM
    emp2
GROUP BY
    emp_type;

--조건 : where, having 절 이용한다.께
-- having 은 group과 함
SELECT
    grade,
    SUM(height),
    AVG(height),
    MAX(height),
    MIN(height)
FROM
    student
GROUP BY
    grade
HAVING
    AVG(height) > 172; -- 172 보다 큰애들 만 뽑아줘

SELECT
    emp_type,
    SUM(pay),
    AVG(pay),
    MAX(pay),
    MIN(pay)
FROM
    emp2
GROUP BY
    emp_type
HAVING
    AVG(pay) >= 30000000;
    
-- 숫자함수 --------------------------------------------
SELECT
    round(12.3456789, 0),
    round(12.3456789, 2),
    round(12.5456789, 2)
FROM
    dual;

SELECT
    ceil(12.34),
    ceil(- 12.34)
FROM
    dual;
-- 올림 한 후 정수 반환
SELECT
    floor(12.34),
    floor(- 12.34)
FROM
    dual;
-- 내림 한 후 정수 반환

SELECT
    *
FROM
    dept2;

SELECT
    *
FROM
    dept2,
    emp2;

SELECT
    trunc(12.3456789, 2),
    trunc(12.5456789, 2),
    trunc(12.5456789, 0)
FROM
    dual;
-- 반올림 안 되고 버림

-- 교수테이블에서 월급에 인상률 2%를 한 결과를 출력하시요.(소숫점 0 으로 처리)
SELECT
    name,
    pay * 0.2,
    SUM(pay),
    SUM(pay * 0.2)
FROM
    professor
GROUP BY
    name,
    pay;

UPDATE professor
SET
    pay = pay + pay * 0.2;

ROLLBACK;

-- 문제 교수테이블에서 모든 교수들에게 보너스를 1000원씩 추가 지금하기( 널처리 할 것)
SELECT
    bonus,
    nvl(bonus, 0) + 1000
FROM
    professor;

UPDATE professor
SET
    bonus = nvl(bonus, 0) + 1000;

--  문자함수  --------------------------------------------------------------------
SELECT
    id,
    upper(id)
FROM
    professor; --전체 대문자
SELECT
    id,
    initcap(id)
FROM
    professor; -- 첫 글자만 대문자
SELECT
    id,
    length(id)
FROM
    professor; -- 글자수 
SELECT
    dname,
    length(dname),
    lengthb(dname)
FROM
    dept2;

SELECT
    length('사장실')
FROM
    dual; -- 한글도 한글자마다 1바이트
SELECT
    lengthb('사장실')
FROM
    dual; -- 9바이트 ( 오라클에서 한글 한글자는 3바이트로 저장한다)

SELECT
    *
FROM
    gogak;

SELECT
    substr(jumin, 7, 1)
FROM
    gogak;
--주민 컬럼에서 7번째자리부터 1개 조회해라
SELECT
    instr('abcd', 'b')
FROM
    dual;
-- 'abcd'에서 'b'는 몇번째에 있는지 출력한다
SELECT
    id,
    instr(id, 'b')
FROM
    professor;
-- id에서 'b'가 몇번째에 있는지 출력
SELECT
    instr('abcdefjiwerwesfbssfsjfb', 'b', - 1)
FROM
    dual;

SELECT
    instr('abcdefjiwerwesfbssfsjfb', 'b', - 3)
FROM
    dual;

SELECT
    instr('ab3456b89101112b14151617181920b', 'b', - 1)
FROM
    dual;
-- -1이면 뒤에서 부터 찾는다 , 다른 음수는 의미 없다

SELECT
    lpad('abcd', 20, '#')
FROM
    dual;
-- 오른쪽 정렬 후 나머지를 원하는 문자로 채워준다

SELECT
    rpad('abcd', 20, '@')
FROM
    dual;
-- 왼쪽 정렬 후 나머지를 원하는 문자로 채워준다

SELECT
    dname,
    length(dname),
    lengthb(dname)
FROM
    dept2;

SELECT
    dname,
    substr(dname, 3)
FROM
    dept2;

SELECT
    dname,
    substr(dname, 2, 3)
FROM
    dept2;

SELECT
    rpad(dname,
         10,
         substr('1234567890',
                length(dname) + 1)) "RPAD 연습"
FROM
    dept2;
    
------------------------------------------------
SELECT
    concat(name, position)
    || '님' "교수님"
FROM
    professor;