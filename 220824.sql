CREATE TABLE sampletable (
    num     NUMBER,
    name    VARCHAR2(20),
    phone   VARCHAR2(15),
    address VARCHAR2(50)
);

SELECT
    *
FROM
    sampletable;

SELECT
    name,
    address
FROM
    sampletable;

desc sampletable;

INSERT INTO sampletable VALUES (
    10,
    '손',
    '010-1234-1234',
    '서울'
);

INSERT INTO sampletable VALUES (
    20,
    '손흥',
    '010-4567-4567',
    '경기'
);

INSERT INTO sampletable VALUES (
    30,
    '손흥민',
    '010-7890-7890',
    '부산'
);

DELETE FROM sampletable; -- 레코드만 제거 ( 구조물은 남아 있는다.)
COMMIT; -- 커밋 : 삭제 하기 전 원하는 위치에서 영구 저장을 한다.
ROLLBACK; -- 커밋을 한 시점으로 복구를 한다
SELECT
    *
FROM
    sampletable;

DROP TABLE sampletable; -- 테이블 자체를 제거

SELECT
    sysdate
FROM
    sampletable; --현재날짜와 시간을 가져오는 함수
SELECT
    sysdate AS "오늘 날짜"
FROM
    dual;
-- 오라클은 가상의 테이블을 제공한다
-- 테이블이 없을 경우 등등
-- as "~" 속성명을 이렇게 써주세요

--조회 : select 필드명, 필드명... from 테이블 명;

--CREATE TABLE 테이블이름(
--컬럼명 datatype [ null | not null ] [ constraint 별칭 제약조건 ] ,
--컬럼명 datatype [ null | not null ] [ constraint 별칭 제약조건 ]
--)

CREATE TABLE sampletable (
    num     NUMBER,
    name    VARCHAR2(20),
    phone   VARCHAR2(15),
    address VARCHAR2(50)
);


DESC emp2;


