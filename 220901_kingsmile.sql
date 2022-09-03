-- PL/SQL ( Procedural Language ) -----------------------------
/*
CREATE PROCEDURE 프로시져이름
IS
    [
        변수이름 데이터타입; --프로시져내에서 사용할 변수선언
        변수이름 데이터타입;
        ....
    ]
BEGIN
    기능 구현;
END;
---------------------------------------------
실행 형식>
execute 프로시저명;
exec 프로시저명(값, 값,...);
*/
----------------------------------------------
create or replace PROCEDURE  p_msg
is
BEGIN
    DBMS_OUTPUT.PUT_LINE('오늘 뭐 먹지?');
end;

EXECUTE  p_msg;
-------------------------------------------
----------------------------------------------
create or replace PROCEDURE  p_msg ( name in varchar2 )
is
BEGIN
    DBMS_OUTPUT.PUT_LINE(name || '아(야) 오늘 뭐 먹지?');
end;

EXECUTE  p_msg('도연');
exec p_msg('김연아');
exec p_msg('이순신');
-------------------------------------------
create or replace PROCEDURE p_test    -- 프로시저 생성 
(      
            name in VARCHAR2,
            su in number
) 
is
begin
    DBMS_OUTPUT.PUT_LINE(name || '님 점수는 : ' || su );
end;

exec p_test('김연아', 99);
exec p_test('park', 77);
-------------------------------------------------------
select * from userlist;
drop table userlist;
create table userlist (
    id varchar2(10),
    name varchar2(20),
    age number,
    addr varchar2(50)
);
desc userlist;
    
create or replace PROCEDURE p_userlist(      -- 프로시저 생성 
    id in userlist.id%Type := 'kingsmile',
    name in userlist.name%TYPE default '도연이',
    age in userlist.age%type := 10,
    addr in userlist.addr%type := null
) 
is
begin
    insert into userlist values(id, name, age, addr);
    DBMS_OUTPUT.PUT_LINE('insert 정보는 : ' ||id||' ' ||name||' ' ||age||' '||addr );
end;
--------------------------------------------
exec p_userlist('yuna', '김연아', 30, '군포');
select * from userlist;
exec p_userlist;  -- default value input
exec p_userlist(id=>'박보검', age=>33);  -- 원하는 필드값만 추가 가능

--------------------------------------------------
SELECT * 
    FROM user_objects
    WHERE LOWER(object_type)='procedure';
-----------------------------------------------------
create or replace PROCEDURE  p_sal
is
    v_salary number := 0;    v_dept_id number := 0;
BEGIN
    v_dept_id := round(dbms_random.value(10, 40) , -1);
    
    DBMS_OUTPUT.PUT_LINE('v_dept_id = ' || v_dept_id );
    
    select sal into v_salary from emp where deptno = v_dept_id and rownum = 1;
     DBMS_OUTPUT.PUT_LINE( v_salary );
     
     if v_salary BETWEEN 1 and 3000 then
        DBMS_OUTPUT.PUT_LINE( '보수 적음' );
     ELSIF v_salary BETWEEN 3001 and 6000 then
        DBMS_OUTPUT.PUT_LINE( '시세에 맞춰줌' );
    ELSIF v_salary BETWEEN 6001 and 9000 then
        DBMS_OUTPUT.PUT_LINE( '보수 좋음' );
     else
        DBMS_OUTPUT.PUT_LINE( '완전 좋음' );
    end if;
end;
-----------------------------------------------
exec p_sal;

select * from emp;
-------------------------------------------------------------------
/*
ex) 사용자 입력(단수)를 받아 구구단 출력
[힌트] DECLARE vdan NUMBER(1) :=&dan;
*/
declare
    dan number(1) := &inputDan;
begin
    for i in 1..9 loop
        DBMS_OUTPUT.PUT_LINE(dan ||'*'||i||'='|| i*dan);
    end loop;
end;
----------------------------------------------------
create or replace PROCEDURE  p_wantDan
is        
    dan number(1) := &inputDan;
begin
    for i in 1..9 loop
        DBMS_OUTPUT.PUT_LINE(dan ||'*'||i||'='|| i*dan);
    end loop;
end;
-------------------------------------------
exec p_wantDan;
--------------------------------------------
create or replace PROCEDURE  p_wantDan( v_dan in number  )    
is        
begin
    for i in 1..9 loop
        DBMS_OUTPUT.PUT_LINE(v_dan ||'*'||i||'='|| i* v_dan);
    end loop;
end;
-------------------------------------------
exec p_wantDan(&v_dan); -- 실행부터 입력 받으면서~
--------------------------------------------
----------------------------------------------------------
create or replace procedure p_outTest (
    name out varchar2, age out varchar2
)
is
begin
    name := '이나영3';
    age := 33;
    dbms_output.put_line('out을 이용한 프로시저 완료');
end;
----------------------------------
variable v_name varchar2(20);
variable v_age varchar2(3);

exec p_outTest(:v_name, :v_age);
print v_name;
print v_age;

print (v_name, v_age);  -- ??
---------------------------------------------
create or replace procedure p_out( x in out number )
as
begin
    dbms_output.put_line( 'x = ' || x );
    x := &x;
end;
------------------------------------------------
VARIABLE x VARCHAR2(25);
exec p_out(:&x);
print x;

exec p_out(:x);

VARIABLE y VARCHAR2(25);
exec p_out(:y);
print y;
------------------------------------------------
select * from emp;
-----------------------------------------------
------------------------------------------------
create or replace procedure p_emp_job( v_job in emp.job%type )
is
    name emp.ename%type;
    empno emp.empno%type;
    sal emp.sal%type;
--  cursor c_name is select empno, ename, sal from emp where job=upper(v_job) or job=lower(v_job);   -- 1.커서선언
    cursor c_name is select empno, ename, sal from emp where job in(upper(v_job), lower(v_job));   -- 1.커서선언
begin
    open c_name;   -- 2.커서열기
    dbms_output.put_line('------------------------------');
    loop
        fetch c_name into empno, name, sal;  -- 3.커서로부터 데이터 읽기
        exit when c_name%NOTFOUND; -- 찾을 데이터가 없으면 반복문 탈출한다.
        dbms_output.put_line(name ||' '||empno||' '||sal||' ' ||v_job);
    end loop;
    dbms_output.put_line('result recode count ==> ' || c_name%rowcount);
     
    close c_name;  -- 4.커서닫기
end;
--------------------------------------------------------------
exec p_emp_job('manager');  -- 레코드 대소문자 구분함
exec p_emp_job(upper('manager'));

select * from emp where job ='manager';

exec p_emp_job('SALESMAN');
---------------------------------------------------
DECLARE
    v_emprow  emp%rowtype;
begin
    for i in 1..5 loop
        select * into v_emprow
            from ( select *
                        from (select * from emp order by sal desc )
                        where rownum <= i ) 
            where rownum <=5;
          dbms_output.put_line(v_emprow.empno || '  ' || v_emprow.ename ||'  '|| v_emprow.sal );
    end loop;
end;
----------------------------------------------------
  select sal, rownum
            from ( select *
                        from (select * from emp order by sal desc )
                        where rownum <= 1 ) 
            where rownum <=5;
--------------------------------------------------------------------
DECLARE
    v_emprow  emp%rowtype;
begin
    for i in 1..5 loop
        select * into v_emprow
            from ( select * from (select * from emp order by sal desc )
                        where rownum <= i  order by sal, ename ) 
            where rownum =1 order by sal asc ;
          dbms_output.put_line(v_emprow.empno || '  ' || v_emprow.ename ||'  '|| v_emprow.sal );
    end loop;
end;
-----------------------------------------------------------------------
create or replace PROCEDURE p_empMaxSal
is
    v_emprow  emp%rowtype;
begin
    for i in 1..5 loop
        select * into v_emprow
            from ( select * from (select * from emp order by sal desc )
                        where rownum <= i  order by sal, ename ) 
            where rownum =1 order by sal asc ;
          dbms_output.put_line(v_emprow.empno || '  ' || v_emprow.ename ||'  '|| v_emprow.sal );
    end loop;
end;
--------------------------------------------------
exec p_empMaxSal;
------------------------------------------------
insert into emp(empno, ename, sal) values(3456, 'kingsmile', 8000);

-- 학생 테이블에서 키가 제일 큰 순서로 3명 출력하는 프로시저 만들기
select * from student;
create or replace procedure p_stdMaxHeight
is
    v_stdrow    student%rowtype;
    begin
        for i in 1..3 loop
            select * into v_stdrow 
            from ( select * 
                    from (select * from student order by height desc )
                     where rownum <= i  order by height, name ) where rownum = 1 order by height desc; 
             DBMS_OUTPUT.PUT_LINE(v_stdrow.studno||' '||v_stdrow.name||' '||v_stdrow.height);   
        end loop;
    end;
---------------------------------------------------------------   
exec p_stdMaxHeight;    
---------------------------------------------------------------   
select name, height from student order by height desc;
-----------------------------------------------------------------
노정호	184
박동호	182
일지매	182
------------------------------------------------------------------
create or replace PROCEDURE p_stdMaxHeight
is
    v_stdrow  student%rowtype;
begin
    for i in 1..5 loop
        select * into  v_stdrow
            from ( select * from (select * from student order by height desc )
                        where rownum <= i  order by height, name desc) 
            where rownum =1 order by height desc ;
          dbms_output.put_line(v_stdrow.studno || '  ' || v_stdrow.name ||'  '|| v_stdrow.height );
    end loop;
end;
--------------------------------------------------
exec p_stdMaxHeight;
---------------------------------------------------------
create or replace procedure p_join
is
    v_join  student%rowtype;

begin
    select  p.PROFNO, p.name, p.position,
               s.studno, s.name, s.grade , d.dname  into v_join
            from professor p  join  student s  
            on p.PROFNO = s.PROFNO join DEPARTMENT d 
            on s.DEPTNO1= d.DEPTNO;
end;
-----------------------------------------------------------------
 select  p.PROFNO, p.name, p.position,
               s.studno, s.name, s.grade , d.dname
            from professor p  join  student s  
            on p.PROFNO = s.PROFNO join DEPARTMENT d 
            on s.DEPTNO1= d.DEPTNO;


-- 참고 사이트
--https://docs.oracle.com/en/database/oracle/oracle-database/19/lnpls/overview.html#GUID-14ABA325-6475-4F86-95ED-1C0632F30459






