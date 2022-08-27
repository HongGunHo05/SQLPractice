--오라클 데이터베이스 사용자 추

create user kimdongshin
IDENTIFIED by xxxxxxAt22cc가
default tablespace data
temporary tablespace temp
quota 10G on data;

grant connect, resource to kimdongshin;