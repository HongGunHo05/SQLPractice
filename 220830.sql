-- SubQuery ------
-- select * from emp where ename = (서브 쿼리 연장)

SELECT
    *
FROM
    emp2;

SELECT
    *
FROM
    emp2
WHERE
    name = '백원만';

SELECT
    *
FROM
    emp2
WHERE
    pay > 5000000000;

SELECT
    *
FROM
    emp2
WHERE
    pay > (
        SELECT
            pay
        FROM
            emp2
        WHERE
            name = '백원만'
    );

SELECT
    AVG(pay)
FROM
    emp2;

SELECT
    *
FROM
    emp2
WHERE
    apy < 43100000;

SELECT
    *
FROM
    emp2
WHERE
    pay < (
        SELECT
            AVG(pay)
        FROM
            emp2
    );

-- 문제 1번 student 테이블과 department 테이블을 사용하여 이윤나 학생과 전공(deptno1)이
-- 동일한 학생들의 이름과 전공 이름을 출력하세요

SELECT
    name,
    dname
FROM
         student s
    JOIN department d ON s.deptno1 = d.deptno
WHERE
    name = '이윤나';

-- 문제 2번 교수테이블에서 입사일 송도권 교수보다 나중에 입사한 사람의 입사일, 학과명을 출력하세요

SELECT
    name,
    hiredate,
    dname
FROM
         professor p
    JOIN department d ON p.deptno = d.deptno
WHERE
    hiredate < (
        SELECT
            hiredate
        FROM
            professor
        WHERE
            name = '송도권'
    );

-- 문제 3번 학생테이블에서 전공1이 101인 학과의 평균 몸무게보다 많이 나가는 학생들의 이름과 몸무게를 출력하세요

SELECT
    name,
    weight
FROM
    student
WHERE
    weight > (
        SELECT
            AVG(weight)
        FROM
            student
        WHERE
            deptno1 = '101'
    );
    
-- 문제 4번 emp2 테이블을 사용하여 전체 직원 중 과장 직급의 최소 연봉자보다 연봉이 높은 사람의 이름과 직급, 연봉을 출력하세요.
-- 단, 연봉 출력 형식은 천 단위 구분기호(,)와 원 표시까지해서 출력하기

SELECT
    *
FROM
    emp2;

SELECT
    name,
    position,
    to_char(pay, '999,999,999')
FROM
    emp2
WHERE
    pay > (
        SELECT
            MIN(pay)
        FROM
            emp2
        WHERE
            position = '과장'
    );
    
-- 문제 5번 student 테이블을 조회하여 전체 학생 중에서 체중이 4학년 학생들의 체중에서 가장 적게 나가는 
-- 학생보다 적은 학생의 이름과 학년과 몸무게를 출력.

SELECT
    name,
    grade,
    weight
FROM
    student
WHERE
    weight < (
        SELECT
            MIN(weight)
        FROM
            student
        WHERE
            grade = 4
    );
    
-- 문제 6번 student 테이블을 조회하여 각 학년별로 최대 키를 가진 학생들의 학년과 이름과 키를 출력.
SELECT
    grade,
    name,
    height
FROM
    student
WHERE
    ( grade, height ) IN (
        SELECT
            grade, MAX(height)
        FROM
            student
        GROUP BY
            grade
    )
ORDER BY
    grade;

--문제 7번 professor 테이블을 조회하여 각 학과별로 입사일이 가장 오래된 교수의 교수번호와 이름, 입사일, 학과명을 출력. 
-- 단, 학과명순으로 오름차순 정렬.

SELECT
    profno,
    name,
    hiredate,
    dname
FROM
         professor p
    JOIN department d ON p.deptno = d.deptno
WHERE
    ( p.deptno, hiredate ) IN (
        SELECT
            deptno, MIN(hiredate)
        FROM
            professor
        GROUP BY
            deptno
    )
ORDER BY
    dname DESC;

-- 문제 8번 Emp2 테이블을 조회하여 직급별로 해당 직급에서 최대 연봉을 받는 직원의 이름과 직급, 연봉을 출력하세요. 
-- 연봉순으로 오름차순 정렬하세요.

SELECT
    name,
    position,
    pay
FROM
    emp2
WHERE
    ( position, pay ) IN (
        SELECT
            position, MAX(pay)
        FROM
            emp2
        GROUP BY
            position
    )
ORDER BY
    pay DESC;

-- 문제 9번 emp2 평균 급여보다 작은 사람 출력하세요.
SELECT
    *
FROM
    emp2
WHERE
    pay < (
        SELECT
            AVG(pay)
        FROM
            emp2
    );