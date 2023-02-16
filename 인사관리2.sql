CReate table emp(
emp_id number,
emp_name varchar2 (10),
mgr number,
sal number,
dept_id number,
hire_date Date
);

--1)insert 문 2 가지 형태
-- insert column 쓰지ㅏ 않을 겨우
insert INTO emp Values(1, '김또치' , 100 ,2400, 10);
SELECT *
FROm emp;
--insert column 쓴 경우
insert into emp (emp_id,emp_name, sal)
values(2,'고희동', 3000);

DROP table emp;

DESC emp;
INSERT INTO emp Values(1, '김또치', 100,24000,10, null);

INSERT INTO emp VALUES(2, '고희동', 100,24000,10,sysdate);
SELECT *
FROm emp;

DELETE emp;

DELETE FROM emp
where emp_id=2;
DELETE FROM emp
WHERE emp_id=1;

--DELETE FROM emp
--where emp_id = (내가 지워야할 내용);

--update문
SELECT*
FROM emp;
--UPDATE 문에서 WHERE 활용하였을때

UPDATE emp 
SET emp_name = '도우너'
WHERE emp_id =1;
--UPDATE 문에서 WHERE 활용 안하였을때
UPDATE emp
SET emp_id =1000;

--UPDATE 깜짝 퀴즈
--emp 테이블에서 dept_id 모두 11로 바꾸는데.
--dept_id=11말고 다른 방법으로 update 해보세요
UPDATE emp
SET dept_id = dept_id +1;

--게시판 번호 설정



CREATE TABLE board (
board_no number,
board_content varchar2(200)
);

INSERT INTO board VALUEs(1, '1번게시판');
INSERT INTO board VALUEs(2, '1번게시판');
INSERT INTO board VALUES(3, '1번게시판');
INSERT INTO board VALUES(4, '1번게시판');
INSERT INTO board VALUES(5, '1번게시판');
INSERT INTO board VALUES(6, '1번게시판');
INSERT INTO board VALUES(7, '1번게시판');
INSERT INTO board VALUES(8, '1번게시판');

SELECT*
FROM board;

--게시판 삭제
--게시판 삭제한 내용을 기준으로 번호 재정렬
--게시판 데이터 입력할때 자동으로 번호를 생성

DELETE FROM board
whERE BOARD_NO=3;

UPDATE board
set BOARD_NO= BOARD_NO-1
WHERE BOARD_NO >=4;

--COUNT 함수 적용
SELECT COUNT(*) +1
FROM board;

INSERT INTO board VALUES ((SELECT COUNT(*) +1
                            FROM board),
                            (SELECT COUNT(*) +1
                            FROM board)|| '번게시판'
                            );
                            
SELECT *
FROM board;

COMMIT;


--INSERT 문장을 통한 transaction

INSERT INTO departments 
Values (70, 'Public Relations' ,  100 ,1700);

SELECT*
FROM departments;

COMMIT;


ROLLBACK;

SELECT*
FROM departments;

CREATE TABLE sales_reps
AS
SELECT employee_id id, last_name name, salary, commission_pct
FROM employees;

SELECT *
FROM sales_reps;

INSERT INTO departments (department_id, department_name, location_id)
VALUES (&department_id, '&department_name', &location);

SELECT *
FROM departments;

UPDATE employees
SET salary = 7000;

SELECT *
FROM employees;

ROLLBACK;


UPDATE employees
SET salary = 7000
WHERE employee_id=104;

ROLLBACK;

--서브쿼리를 사용한 update
UPDATE employees
SET job_id = ( SELECT job_id
                FROM employees
                WHERE employee_id =205),
    salary= (  SELECT salary
                FROM employees
                WHERE employee_id =205)
WHERE employee_id=124;

UPDATE employees
SET department_id = (
                      SELECT department_id
                      FROM departments
                      WHERE department_name LIKE '%public%')
WHERE employee_id =206;                      



SELECT*
FROM employees;

ROLLBACK;

-- DELETE
DELETE FROM departments
WHERE department_name = 'Fianace';

DELETE FROM employees
WHERE department_id = (
                        SELECT department_id
                        FROM departments
                        WHERE department_name LIKE '%public%');
                        
--TABLE DELETE & TRUNCATE
--TABLE에서 DELETE => 데이터만 삭제
SELECT *
FROM sales_reps;

DELETE FROM sales_reps;
ROLLBACK;
--TABLE 에서 truncate => 데이터와 데이터 보관하는 공간까지 삭제
SELECT *
FROM sales_reps;

TRUNCATE TABLE sales_reps;
ROLLBACK;

INSERT INTO sales_Reps
SELECT employee_id, last_name, salary, commission_pct
FROM employees
WHERE job_id LIKE '%REP%';

ROLLBACK;
COMMIT;


DELETE FROM sales_reps
WHERE id =174;

SAVEPOINT sp1;

DELETE FROM sales_reps
WHERE id =202;

ROLLBACK to sp1;

ROLLBACK;

SELECT table_name
FROM user_tables;

SELECT DISTINCT object_type
FROm user_objects; 

--table 생성
CREATE TABLE dept(
dept_no number(2),
dname varchar2(14),
loc varchar2(13),
create_date DATE DEFAULT sysdate);

DESC dept;

INSERT INTO dept(dept_no, dname, loc)
values(1, '치' ,'예담');

SELECT *
FROM dept;

CREATE TABLE dept30
AS
    SELECT employee_id, last_name, salary*12AS"salary" , hire_date
    FROM employees
    WHERE department_id = 50;
    
SELECT *
FROM dept30;

DESC employees;

DESC dept30;


DROP TABLE dept;
DROP TABLE dept30;


--column 추가
ALTER TABLE dept30
ADD        (JOB VARCHAR2(20));

DESC dept30;

ALTER TABLE dept30
MODIFY      (JOB NUMBER);

INSERT INTO dept30
VALUES(1, '또치', 2000, SYSDATE,123);

ALTER TABLE dept30
MODIFY      (JOB VARCHAR2(40));

DELETE FROM dept30
WHERE employee_id =1 ;


ALTER TABLE dept30
DROP COLUMN job;

DESC dept30;

ALTER TABLE dept30
SET UNUSED (hire_date);

SELECT*
FROM dept30;

ALTER TABLE dept30
DROP UNUSED COLUMNS;

RENAME dept30 TO dept100;

SELECT *
FROM all_col_comments
WHERE table_name = 'DEPT100';

COMMENT ON TABLE dept100
IS 'THIS IS DEPT100';

COMMENT ON COLUMN dept100.employee_id
IS 'THIS IS EMPLOYEEID';

SELECT *
FROM dept100;

TRUNCATE TABLE dept100;

ROLLBACK;
DROP table DEPT100;

SELECT*
FROM employees;

--기본기(pk)기본값을 포함하는 테이블 생성
DROP TABLE board;

CREATE TABLE dept(
                    deptno NUMBER(2) PRIMARY KEY,
                    dname VARCHAR2(14),
                    loc VARCHAR2(13),
                    create_date DATE DEFAULT SYSDATE --기본값을 가지는 열(column)
                    );
                    
INSERT INTO dept(deptno,dname)
VALUES (10, '기획부'); --기본값을 가지는 열(column)에 데이터가 자동 입력

INSERT INTO dept
VALUES(20, '영업부', '서울' , '23/02/15');

COMMIT;

SELECT *
FROM dept;

--여러가지 제약조건을 포함하는 테이블 생성
DROP TABLE emp;

--CREATE TABLE emp(
--empno NUMBER(6)  PRIMARY KEY,  --기본키 제약조건
--ename VARCHAR2(25) NOT NULL,  -- NOT NULL 제약조건
--email VARCHAR2(50)  CONSTRAINT emp_mail_nn NOT NULL --NOT NULL 제약 조건 +제약 조건 이름 부여
--                    CONSTRAINT emp_mail_uk UNIQUE, -- UNIQUE 제약 조건 + 제약 조건 이름 부여
--phone_no CHAR(11) NOT NULL,
--job VARCHAR2(20),
--salary NUMBER(8) CHECK(salary>2000), -- check 제약 조건, 2000 보다 큰 데이터가 들어와야 입력 가능
--deptno NUMBER(4) REFERENCES dept (deptno)); -- foreign key 제약 조건, dept table에서 deptno 라는 column을 참조해서 데이터 입력


SELECT *
FROM emp;

CREATE TABLE emp(
--COLUMN LEVEL CONSTRAINT
empno NUMBER(6)  ,  --기본키 제약조건
ename VARCHAR2(25) CONSTRAINT emp_ename_nn NOT NULL,  -- NOT NULL 제약조건
email VARCHAR2(50) CONSTRAINT emp_email_nn NOT NULL, -- UNIQUE 제약 조건 + 제약 조건 이름 부여
phone_no CHAR(11),
job VARCHAR2(20),
salary NUMBER(8), -- check 제약 조건, 2000 보다 큰 데이터가 들어와야 입력 가능
deptno NUMBER(4),
--TABLE LEVEL CONSTRAINT
CONSTRAINT emp_empno_pk PRIMARY KEY(empno),
CONSTRAINT emp_email_uk UNIQUE(email),
CONSTRAINT emp_salary_ck CHECK(salary>2000),
CONSTRAINT emp_deptno_fk FOREIGN KEY (deptdno)
REFERENCES dept(deptno)
); -- foreign key 제약 조건, dept table에서 deptno 라는 column을 참조해서 데이터 입력

--제약조건 관련 딕셔너리 정보보기
SELECT constraint_name, constraint_type, search_condition
FROM  user_constraints
WHERE table_name='EMP';

SELECT cc.column_name, c.constraint_name
FROM user_constraints c JOIN user_cons_columns cc
ON (c.constraint_name = cc.constraint_name)
WHERE c.table_name = 'EMP';

SELECT table_name , index_name
FROM user_indexes
WHERE table_name IN('DEPT', 'EMP');

-- DML을 수행하며 제약조건 테스트하기
INSERT INTO emp
VALUES(null, '또치', 'ddochikim@naver.com' , '01023456789', '회사원', 3500, 123);

DESC emp;

INSERT INTO emp
VALUES(1234, '또치', 'ddochikim@naver.com' , '01023456789', '회사원', 3500, null);

INSERT INTO emp
VALUES(1233,'희동','heeedong@naver.com', '010234584', null, 2000, 20);

INSERT INTO emp
VALUES(1233,'희동','heeedong@naver.com', '010234584', null, 2001, 10);

SELECT *
FROM emp;

SELECT *
FROM dept;


--update 

UPDATE emp
SET deptno=10
WHERE empno =1234;

ALTER TABLE emp
ADD CONSTRAINT emp_job_uk UNIQUE(job);


INSERT INTO emp
VALUES(1200,'길동','heeedong@naver.com', '010234584', '김치', 2001, 10);


ALTER TABLE emp
MODIFY(salary number NOT NULL);


INSERT INTO emp
VALUES(1200,'길동','heeedong@naver.com', '010234584', '김치', null, 10);

ALTER TABLE emp
DROP CONSTRAINT emp_job_uk;

INSERT INTO emp
VALUES(1200,'길동','heeedㅁng@naver.com', '010234584', '회사원', 5400, 20);



CREATE TABLE super(
store_num NUMBER(5),
store_name CHAR(10),
store_add VARCHAR2(50) NOT NULL,
store_phone CHAR(13),
store_sales NUMBER(6) CHECK(store_sales>1000));


CREATE TABLE product(
product_num NUMBER(4) constraint product_product_num_uk UNIQUE,
product_name VARCHAR2(10),
product_price NUMBER(5) CHECK(product_price>100),
product_save VARCHAR2(2) CHECK(product_save = 'F' or product_save ='C'));