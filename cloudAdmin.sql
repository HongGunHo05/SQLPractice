--오라클 데이터베이스 사용자 추

create user bob
IDENTIFIED by xxxxxxAt22cc
default tablespace data
temporary tablespace temp
quota 10G on data;

grant connect, resource to bob;

grant create session, create table, create view, create sequence, create procedure to bob;