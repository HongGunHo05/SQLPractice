CREATE TABLE userlist (
    id   VARCHAR2(10)
        CONSTRAINT id_pk PRIMARY KEY,
    name VARCHAR2(10) --not null
);
/*
제약조건명
    테이블명_필드명_성격(pk,fk,ck...)
    
CREATE TABLE userlist(
id VARCHAR2(10),  
name varchar2(10) --not null
CONSTRAINT id_pk PRIMARY key
)
*/

SELECT
    *
FROM
    userlist;

INSERT INTO userlist VALUES (
    'kingsmile',
    'doyeon'
);

INSERT INTO userlist (
    name,
    id
) VALUES (
    'kang',
    'aaa'
);

INSERT INTO userlist ( id ) VALUES ( 'gildong' );

DROP TABLE userlist; -- 테이블 삭제

INSERT INTO userlist ( name ) VALUES ( 'hong' ); -- pk는 (기본키) 중복안되고 not null임
INSERT INTO userlist ( id ) VALUES ( 'gildong' ); -- 중복허용 안됨
------------------------------------------------
CREATE TABLE fk_member (
    code NUMBER(2) NOT NULL,
    id   VARCHAR2(20) NOT NULL
        CONSTRAINT id_fk
            REFERENCES member ( id ),
    etc  VARCHAR2(10)
);

SELECT
    *
FROM
    fk_member;

------------------------------------------------

CREATE TABLE userlist_uq (
    id    VARCHAR2(10)
        CONSTRAINT userlist_id_pk PRIMARY KEY,
    jumin CHAR(13)
        CONSTRAINT jumin_un UNIQUE
);

SELECT
    *
FROM
    userlist;

SELECT
    *
FROM
    userlist_uq;

INSERT INTO userlist_uq VALUES (
    'doyeon',
    '111111'
);

INSERT INTO userlist_uq VALUES (
    '김연아',
    '222222'
);

INSERT INTO userlist_uq VALUES (
    '김동신',
    '333333'
);    

------------------------------------------------

CREATE TABLE ck_test (
    name VARCHAR2(10) NOT NULL,
    age  NUMBER(2) NOT NULL CHECK ( age BETWEEN 20 AND 30 ) 
    --age컬럼의 값은 20~30사이만 허용
);

SELECT
    *
FROM
    ck_test;

INSERT INTO ck_test VALUES (
    'doyeon',
    22
);

INSERT INTO ck_test VALUES (
    'doyeon',
    45
);   -- 체크 제약조건(ADMIN.SYS_C0031665)이 위배되었습니다

------------------------------------------------

CREATE TABLE de_test (
    name VARCHAR2(10) NOT NULL,
    addr VARCHAR2(10) DEFAULT '서울'
);

SELECT
    *
FROM
    de_test;

INSERT INTO de_test VALUES (
    'yuna',
    'jeju'
);

INSERT INTO de_test VALUES (
    'yuna', DEFAULT
);

INSERT INTO de_test VALUES (
    'yuna',
    '강원'
);

------------------------------------------------

CREATE TABLE test (
    no      NUMBER NOT NULL, -- primary key, number: 4byte(-9000~9999)
    name    VARCHAR2(10) NOT NULL,
    birdate DATE, -- 생년월일 : '년-월-일' or 년/월/일
    age     NUMBER,
    CONSTRAINT no_pk PRIMARY KEY ( no )
);

SELECT
    *
FROM
    test;

SELECT
    *
FROM
    userlist;

--① 컬럼추가
--alter table 테이블이름 add 
--(컬럼명 자료형 [제약조건] , 컬럼명 자료형 [제약조건] , ....)

ALTER TABLE userlist ADD phone VARCHAR2(15);

ALTER TABLE userlist ADD (
    no     NUMBER(2),
    gender CHAR(2)
);

SELECT
    *
FROM
    userlist;

UPDATE userlist
SET
    no = 1; -- 전체 수정
UPDATE userlist
SET
    phone = '111-222';

UPDATE userlist
SET
    gender = 'F',
    phone = '333-555'
WHERE
    id = 'gildong';

COMMIT;

ROLLBACK; -- 실행취소 - DML(select, insert, update, delete)

--② 컬럼삭제
--alter table 테이블이름 drop column 컬럼이름

SELECT
    *
FROM
    userlist;

ALTER TABLE userlist DROP COLUMN no;

ALTER TABLE userlist DROP ( name,
                            gender ); -- 2개 이상 괄호

--③ datatype변경
--alter table 테이블이름 modify 컬럼이름 변경자료형
--안에 아무것도 없어야지 가능함
desc userlist;

SELECT
    *
FROM
    userlist;

ALTER TABLE userlist MODIFY
    phone NUMBER; -- 데이터 유형을 변경할 열은 비어 있어야 합니다. 해당 컬럼의 데이터들이 비어있어야 됨
ALTER TABLE userlist MODIFY
    no DATE;

-- delete from userlist where phone = '111-222';
UPDATE userlist
SET
    phone = NULL;

--④ 컬럼이름 변경
--alter table 테이블이름 rename column 기존컬럼명 to 변경컬럼명
ALTER TABLE userlist RENAME COLUMN phone TO tel;

--⑤ 테이블 삭제
--drop table 테이블이름
DELETE FROM userlist;

desc userlist;

DROP TABLE userlist;

-- 삭제된 테이블 목록 보기
show recyclebin;
desc recyclebin;

-- 복구(삭제된 테이블)
FLASHBACK TABLE userlist TO BEFORE DROP;

SELECT
    *
FROM
    userlist;

-- 휴지통 비우기
PURGE RECYCLEBIN;

SELECT
    *
FROM
    userlist;

DROP TABLE userlist PURGE; -- 휴지통에 넣지 않고 완전 제거

-- insert into 테이블이름(컬럼명, 컬럼명,...) values(값, 값, ...)
-- insert into 테이블이름 values(값, 값, ...)
-- =>모든 컬럼에 모두 값을 넣을 때 사용

--  update 테이블이름
--  set 컬럼명=변경값 , 컬럼명=변경값 , 컬럼명=변경값 , .....
--  [ where 조건식 ]

-- Delete table이름 [ where 조건식 ]
-- truncate table 테이블이름 ; => 모든 레코드 삭제

SELECT
    *
FROM
    emp2;

DELETE emp2;    -- delete from emp2;
DELETE emp2
WHERE
    hobby = '독서';

DELETE emp2
WHERE
    emp_type = '정규직'; -- 조건에 맞는 것만 제거
ROLLBACK;

TRUNCATE TABLE emp2; -- where emp_type = '인턴직'; where 절 사용 못함, rollback 안 됨 테이블 컬럼은 유지하되 데이터만 날리고 싶은 경우

SELECT
    *
FROM
    emp2;

SELECT DISTINCT
    name,
    emp_type,
    tel
FROM
    emp2;

SELECT
    name
    || '님은 '
    || emp_type
FROM
    emp2;

SELECT
    name
    || '의 키는'
    || height
    || ' cm, '
    || weight
    || ' kg 입니다.'
FROM
    student;

SELECT
    name
    || '('
    || position
    || '), '
    || name
    || ''
    || position
    || ''
FROM
    professor;