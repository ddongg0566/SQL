CReate table emp(
emp_id number,
emp_name varchar2 (10),
mgr number,
sal number,
dept_id number,
hire_date Date
);

--1)insert �� 2 ���� ����
-- insert column ������ ���� �ܿ�
insert INTO emp Values(1, '���ġ' , 100 ,2400, 10);
SELECT *
FROm emp;
--insert column �� ���
insert into emp (emp_id,emp_name, sal)
values(2,'����', 3000);

DROP table emp;

DESC emp;
INSERT INTO emp Values(1, '���ġ', 100,24000,10, null);

INSERT INTO emp VALUES(2, '����', 100,24000,10,sysdate);
SELECT *
FROm emp;

DELETE emp;

DELETE FROM emp
where emp_id=2;
DELETE FROM emp
WHERE emp_id=1;

--DELETE FROM emp
--where emp_id = (���� �������� ����);

--update��
SELECT*
FROM emp;
--UPDATE ������ WHERE Ȱ���Ͽ�����

UPDATE emp 
SET emp_name = '�����'
WHERE emp_id =1;
--UPDATE ������ WHERE Ȱ�� ���Ͽ�����
UPDATE emp
SET emp_id =1000;

--UPDATE ��¦ ����
--emp ���̺��� dept_id ��� 11�� �ٲٴµ�.
--dept_id=11���� �ٸ� ������� update �غ�����
UPDATE emp
SET dept_id = dept_id +1;

--�Խ��� ��ȣ ����



CREATE TABLE board (
board_no number,
board_content varchar2(200)
);

INSERT INTO board VALUEs(1, '1���Խ���');
INSERT INTO board VALUEs(2, '1���Խ���');
INSERT INTO board VALUES(3, '1���Խ���');
INSERT INTO board VALUES(4, '1���Խ���');
INSERT INTO board VALUES(5, '1���Խ���');
INSERT INTO board VALUES(6, '1���Խ���');
INSERT INTO board VALUES(7, '1���Խ���');
INSERT INTO board VALUES(8, '1���Խ���');

SELECT*
FROM board;

--�Խ��� ����
--�Խ��� ������ ������ �������� ��ȣ ������
--�Խ��� ������ �Է��Ҷ� �ڵ����� ��ȣ�� ����

DELETE FROM board
whERE BOARD_NO=3;

UPDATE board
set BOARD_NO= BOARD_NO-1
WHERE BOARD_NO >=4;

--COUNT �Լ� ����
SELECT COUNT(*) +1
FROM board;

INSERT INTO board VALUES ((SELECT COUNT(*) +1
                            FROM board),
                            (SELECT COUNT(*) +1
                            FROM board)|| '���Խ���'
                            );
                            
SELECT *
FROM board;

COMMIT;


--INSERT ������ ���� transaction

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

--���������� ����� update
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
--TABLE���� DELETE => �����͸� ����
SELECT *
FROM sales_reps;

DELETE FROM sales_reps;
ROLLBACK;
--TABLE ���� truncate => �����Ϳ� ������ �����ϴ� �������� ����
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

--table ����
CREATE TABLE dept(
dept_no number(2),
dname varchar2(14),
loc varchar2(13),
create_date DATE DEFAULT sysdate);

DESC dept;

INSERT INTO dept(dept_no, dname, loc)
values(1, 'ġ' ,'����');

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


--column �߰�
ALTER TABLE dept30
ADD        (JOB VARCHAR2(20));

DESC dept30;

ALTER TABLE dept30
MODIFY      (JOB NUMBER);

INSERT INTO dept30
VALUES(1, '��ġ', 2000, SYSDATE,123);

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

--�⺻��(pk)�⺻���� �����ϴ� ���̺� ����
DROP TABLE board;

CREATE TABLE dept(
                    deptno NUMBER(2) PRIMARY KEY,
                    dname VARCHAR2(14),
                    loc VARCHAR2(13),
                    create_date DATE DEFAULT SYSDATE --�⺻���� ������ ��(column)
                    );
                    
INSERT INTO dept(deptno,dname)
VALUES (10, '��ȹ��'); --�⺻���� ������ ��(column)�� �����Ͱ� �ڵ� �Է�

INSERT INTO dept
VALUES(20, '������', '����' , '23/02/15');

COMMIT;

SELECT *
FROM dept;

--�������� ���������� �����ϴ� ���̺� ����
DROP TABLE emp;

--CREATE TABLE emp(
--empno NUMBER(6)  PRIMARY KEY,  --�⺻Ű ��������
--ename VARCHAR2(25) NOT NULL,  -- NOT NULL ��������
--email VARCHAR2(50)  CONSTRAINT emp_mail_nn NOT NULL --NOT NULL ���� ���� +���� ���� �̸� �ο�
--                    CONSTRAINT emp_mail_uk UNIQUE, -- UNIQUE ���� ���� + ���� ���� �̸� �ο�
--phone_no CHAR(11) NOT NULL,
--job VARCHAR2(20),
--salary NUMBER(8) CHECK(salary>2000), -- check ���� ����, 2000 ���� ū �����Ͱ� ���;� �Է� ����
--deptno NUMBER(4) REFERENCES dept (deptno)); -- foreign key ���� ����, dept table���� deptno ��� column�� �����ؼ� ������ �Է�


SELECT *
FROM emp;

CREATE TABLE emp(
--COLUMN LEVEL CONSTRAINT
empno NUMBER(6)  ,  --�⺻Ű ��������
ename VARCHAR2(25) CONSTRAINT emp_ename_nn NOT NULL,  -- NOT NULL ��������
email VARCHAR2(50) CONSTRAINT emp_email_nn NOT NULL, -- UNIQUE ���� ���� + ���� ���� �̸� �ο�
phone_no CHAR(11),
job VARCHAR2(20),
salary NUMBER(8), -- check ���� ����, 2000 ���� ū �����Ͱ� ���;� �Է� ����
deptno NUMBER(4),
--TABLE LEVEL CONSTRAINT
CONSTRAINT emp_empno_pk PRIMARY KEY(empno),
CONSTRAINT emp_email_uk UNIQUE(email),
CONSTRAINT emp_salary_ck CHECK(salary>2000),
CONSTRAINT emp_deptno_fk FOREIGN KEY (deptdno)
REFERENCES dept(deptno)
); -- foreign key ���� ����, dept table���� deptno ��� column�� �����ؼ� ������ �Է�

--�������� ���� ��ųʸ� ��������
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

-- DML�� �����ϸ� �������� �׽�Ʈ�ϱ�
INSERT INTO emp
VALUES(null, '��ġ', 'ddochikim@naver.com' , '01023456789', 'ȸ���', 3500, 123);

DESC emp;

INSERT INTO emp
VALUES(1234, '��ġ', 'ddochikim@naver.com' , '01023456789', 'ȸ���', 3500, null);

INSERT INTO emp
VALUES(1233,'��','heeedong@naver.com', '010234584', null, 2000, 20);

INSERT INTO emp
VALUES(1233,'��','heeedong@naver.com', '010234584', null, 2001, 10);

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
VALUES(1200,'�浿','heeedong@naver.com', '010234584', '��ġ', 2001, 10);


ALTER TABLE emp
MODIFY(salary number NOT NULL);


INSERT INTO emp
VALUES(1200,'�浿','heeedong@naver.com', '010234584', '��ġ', null, 10);

ALTER TABLE emp
DROP CONSTRAINT emp_job_uk;

INSERT INTO emp
VALUES(1200,'�浿','heeed��ng@naver.com', '010234584', 'ȸ���', 5400, 20);



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