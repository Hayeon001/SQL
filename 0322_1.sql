--관계형 데이터베이스
--https://www.ibm.com/topics/relational-databases
--https://www.oracle.com/kr/database/what-is-a-relational-database/

--CREATE TABLE
CREATE TABLE dept_TEMP
	AS (SELECT * FROM dept);
	--name is already used by an existing object
--COMMIT;


--CREATE ... AS (SELECT ... FROM ...) 구문
SELECT *
 FROM DEPT_TEMP DT;

--기본구문
--INSERT : 데이터를 입력하는 방식
--INSERT INTO 테이블명 (컬럼명1, 컬럼명2 ...)
--	VALUES (데이터1, 데이터2, ...)	

--단순한 형태

INSERT INTO DEPT_TEMP (DEPTNO, DNAME, LOC)
 VALUES (50, 'DATABASE', 'SEOUL');

INSERT INTO DEPT_TEMP (DEPTNO, DNAME, LOC)
 VALUES (70, 'WEB', NULL);

INSERT INTO DEPT_TEMP (DEPTNO, DNAME, LOC)------------???
 VALUES (70, 'WEB', NULL);   -------------------------PK 같은 값이 들어가면 에러나야 정상..


INSERT INTO DEPT_TEMP (DEPTNO, DNAME, LOC)
 VALUES (80, 'MOBILE', '');

INSERT INTO DEPT_TEMP (DEPTNO, LOC)
 VALUES (90, 'INCHEON');

COMMIT;

SELECT * FROM DEPT_TEMP DT;

-------------------------


-- 컬럼값만 볷해서 새로운 테이블 생성
-- WHERE 조건문에 1<>1

CREATE TABLE EMP_TEMP AS
	SELECT * FROM EMP e
		WHERE 1<>1;
	
COMMIT;

SELECT * FROM EMP_TEMP;  --빈테이블 생성

INSERT INTO EMP_TEMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
	VALUES (9999, '홍길동', 'PRESIDENT', NULL, to_date('2001/01/01','YYYY/MM/DD'), 6000, 500, 10);


INSERT INTO EMP_TEMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
	VALUES (2111, '이순신', 'MANAGER', 9999, to_date('01/01/2001','DD/MM/YYYY'), 4000, NULL, 10);


--INSERT INTO EMP_TEMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
--	VALUES (2111, '이순신', 'MANAGER', 9999, to_date('07/30/2001','DD/MM/YYYY'), 4000, NULL, 10);
                                                  -- not a valid month. 월일 에러 
INSERT INTO EMP_TEMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
	VALUES (3111, '심청이', 'MANAGER', 9999, SYSDATE, 4000, NULL, 30);

--COMMIT;

SELECT *
 FROM EMP_TEMP;

INSERT INTO EMP_TEMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
	SELECT E.EMPNO
		, E.ENAME
		, E.JOB
		, E.MGR
		, E.HIREDATE
		, E.SAL
		, E.COMM
		, E.DEPTNO
	 FROM EMP E, SALGRADE S
	 WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL
	 	AND S.GRADE = 1;


SELECT * FROM EMP_TEMP;


--UPDATE : 필터된 데이터에 대해 레코드 값을 수정

DROP TABLE DEPT_TEMP2;

CREATE TABLE DEPT_TEMP2
	AS (SELECT * FROM DEPT);---테스트 개발을 위한 임시테이블 생성

SELECT* FROM DEPT_TEMP2;  ---테스트 개발을 위한 임시테이블 확인

--UPDATE ...
-- SET ...

UPDATE DEPT_TEMP2
 SET LOC = 'SEOUL';  -- 모든 데이터가 바껴버림
 


UPDATE DEPT_TEMP2
 SET LOC = 'SEOUL'
 WHERE; -----------------------------??

ROLLBACK;

UPDATE DEPT_TEMP2
 SET DNAME = 'DATABASE'
 	, LOC = 'SEOUL'
 WHERE DEPTNO = 40;

--서브쿼리 사용해서 UPDATE
UPDATE DEPT_TEMP2
 SET (DNAME, LOC) = (SELECT DNAME, LOC --튜플 : 데이터 타입 변경 안됨.
 					  FROM DEPT
 					  WHERE DEPTNO = 40) 
 WHERE DEPTNO = 40;  -- 다시 기본테이블로 원복

SELECT* FROM DEPT_TEMP2;

ROLLBACK;

SELECT* FROM DEPT_TEMP2;

COMMIT;  --원복불가 . 사장결재 끝

--------------------------------------------
--DELETE : 테이블에서 값을 제거
-- 대부분의 경우 WHERE조건 필요
-- 보통의 경우 UPDATE로 값을 변경
-- 근무/휴직/퇴사 로 상태변경

SELECT *
 FROM EMP_TEMP2;

CREATE TABLE EMP_TEMP2
	AS (SELECT * FROM EMP);

COMMIT;

DELETE FROM EMP_TEMP2
 WHERE JOB = 'MANAGER';  -- 인사팀에서 명령 실행요청
 
ROLLBACK;
COMMIT;


--WHERE조건을 조금 더 복잡하게
--DELETE 실행
DELETE FROM EMP_TEMP2
 WHERE EMPNO IN (SELECT E.EMPNO
 					FROM EMP_TEMP2 E, SALGRADE S
 					WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL
 						AND S.GRADE=3
 						AND DEPTNO = 30);	

DELETE FROM EMP_TEMP2
 WHERE EMPNO IN ();	

 					
SELECT E.EMPNO
 FROM EMP_TEMP2 E, SALGRADE S
 WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL
	AND S.GRADE=3
	AND DEPTNO = 30;



--CREATE : 기존에 없는 테이블 구조 생성
--데이터는 없고, 테이블의 컬럼과 데이터타입, 제약조건 등의 구조를 생성
CREATE TABLE EMP_NEW (
  	  EMPNO 	NUMBER(4)
	, ENAME 	VARCHAR2(10)
	, JOB		VARCHAR(9)
	, MGR		NUMBER(4)
	, HIREDATE	DATE
	, SAL		NUMBER(7,2)
	, COMM		NUMBER(7,2)
	,DEPT		NUMBER(2)
);

SELECT *
 FROM EMP
 WHERE ROWNUM <= 5;

SELECT *
 FROM EMP;


ALTER TABLE EMP_NEW
 ADD HP VARCHAR(20) ;

SELECT *
 FROM EMP_NEW;---------------------------------??


ALTER TABLE EMP_NEW
 RENAME COLUMN HP TO TEL_NO; -------------------??
 
ALTER TABLE EMP_NEW  -- 새로 인수한 회사 직원관리 테이블 수정
 MODIFY EMPNO NUMBER(5);  -- 직원 수가 많아 기존 4자리에서 5자리로 수정
 
--다시 원복
 ALTER TABLE EMP_NEW
  DROP COLUMN TEL_NO;

SELECT *
 FROM EMP_NEW;

---------------------------------------------------------------

--SEQUENCE : 일련번호를 생성하여 테이블 관리를 편리하게 하고자 함

CREATE SEQUENCE seq_deptno
	INCREMENT BY 1
	START WITH 1
	MAXVALUE 999
	MINVALUE 1
	nocycle  ---------------------------------------?
	nocache;
	
	
--100p

	
--229p
INSERT INTO dept_temp2;
	
	
	
	
	
	
	
	
	
--230p
--제약조건
--not null
--unique
--pk
--fk

CREATE TABLE login(
	  log_id 	varchar(20) NOT NULL
	, log_pwd	varchar(20) NOT NULL
	, tel		varchar(20)
);
	
INSERT INTO login (log_id, log_pwd, tel)
 VALUES ('test01', '1234', '010-1234-1234');

INSERT INTO login (log_id, log_pwd)
 VALUES ('test01', '1234');

SELECT *
 FROM login;
	

--tel 컬럼의 중요성을 나중에 인지하고, not null 제약조건을 실행
ALTER TABLE login
 MODIFY tel NOT NULL;

--tel 없는 고객이 발견되어 어렵게 번호 구험
UPDATE login
 SET tel = '010-1234-1234'
 WHERE log_id = 'test01';
	

SELECT owner
	, CONSTRAINT_NAME
	, CONSTRAINT_TYPE
	, TABLE_NAME
 FROM USER_CONSTRAINTS;
 WHERE TABLE_NAME = 'LOGIN';----------??
	

ALTER TABLE LOGIN
 MODIFY ( tel CONSTRINT tel_nn NOT NULL);  ----??
 
	
--ALTER TABLE login
-- MODIFY tel NOT NULL;	
	
--FROM USER_CONSTRAINTS;
ALTER TABLE LOGIN
 DROP CONSTRAINT SYS_C007040  --제약조건에 없는 이름 사용	
	

 
 
-- UNIQUE
CREATE TABLE LOG_UNIQUE(
	  LOG_ID	VARCHAR(20) UNIQUE 
	, LOG_PWD	VARCHAR(20) NOT NULL
	, TEL		VARCHAR(20)
);

SELECT *
 FROM USER_CONSTRAINTS
 WHERE TABLE_NAME = 'LOG_UNIQUE';
 

INSERT INTO LOG_UNIQUE (LOG_ID, LOG_PWD, TEL)
 VALUES ('test_ID_01', 'pwd001', '010-1111-1111');

INSERT INTO LOG_UNIQUE (LOG_ID, LOG_PWD, TEL)
 VALUES ('test_ID_02', 'pwd002', '010-2222-2222');

INSERT INTO LOG_UNIQUE (LOG_ID, LOG_PWD, TEL)
 VALUES ('test_ID_03', 'pwd003', '010-3333-3333');

INSERT INTO LOG_UNIQUE (LOG_ID, LOG_PWD, TEL)
 VALUES (NULL, 'pwd004', '010-4444-4444');

SELECT *
 FROM LOG_UNIQUE;

UPDATE UNIQUE
 SET LOG_ID = 'TEST_ID_NEW'
 WHERE LOG_ID IS NULL;


ALTER TABLE UNIQUE
 MODIFY (TEL UNIQUE);-------------??

 
--PK(주키, PRIMARY KEY) : 테이블을 설명하는 가장 중요한 키
--NOT NULL+UNIQUE+INDEX

 CREATE TABLE LOG_PK(
 	  LOG_ID	VARCHAR(20) PRIMARY KEY
 	, LOG_PWD	VARCHAR(20) NOT NULL
 	, TEL		VARCHAR(20)
);
 
INSERT INTO LOG_UNIQUE (LOG_ID, LOG_PWD, TEL)
 VALUES ('PK01','PWD01','010-1');

--기존ID와 동일하게 입력하는 경우(PK제약조건 위반)
INSERT INTO LOG_UNIQUE (LOG_ID, LOG_PWD, TEL)
 VALUES ('PK01','PWD02','010-2');
 
INSERT INTO LOG_UNIQUE (LOG_ID, LOG_PWD, TEL)
 VALUES (NULL,'PWD03','010-3');
 



SELECT *
 FROM EMP_TEMP;
--존재하지 않는 부서번호를 EMP_TEMP 테이블에 입력 시도 
INSERT INTO EMP_TEMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
 VALUES (3333, 'GHOST', 'SERPRISE',9999, SYSDATE, 1200,NULL,90);   --FK제약조건이 없어짐
 
 
INSERT INTO EMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
 VALUES (3333, 'GHOST', 'SERPRISE',9999, SYSDATE, 1200,NULL,90);


--INDEX : 빠른 검색을 위한 색인
--장점 : 빨리 찾을수 있다
--단점 : 입력과 출력이 잦은경우, 인덱스 설정된 테이블 속도가 저하된다

--특정 직군에 해당하는 직원을 빠르게 찾기위한 색인 지정
CREATE INDEX IDX_EMP_JOB
 ON EMP(JOB);

--설정한 인덱스 리스트 출력
SELECT *
 FROM CTXSYS.CTX_USER_INDEXES
 WHERE TABLE_NAME IN ('EMP','DEPT'); -----??
 
 
GRANT CREATE VIEW TO SCOTT;

CREATE VIEW VW_EMP
 AS (SELECT EMPNO, ENAME, JOB, DEPTNO
 		FROM EMP
 		WHERE DEPTNO = 10);
 	
SELECT *
 FROM VW_EMP;
 
SELECT *
 FROM USER_VIEWS
 WHERE VIEW_NAME = 'VW_EMP'; --테이블명은 대문자로 표기
 

 
--ROWNUM사용 : 상위 N개를 출력하기위해 사용
--SAL DESC 순서와 무관하게 EMP테이블에서 가져오는 방법
 SELECT ROWNUM
	, E.*
 FROM EMP E
 ORDER BY SAL DESC;

-- 오름차순 ROWNUM 출력
SELECT ROWNUM
	, E.*
 FROM(SELECT *
 		FROM EMP
 		ORDER BY SAL DESC) E;
 
 	
SELECT ROWNUM
	, E.*
 FROM(SELECT *
 		FROM EMP
 		ORDER BY SAL DESC) E
 WHERE ROWNUM <= 5;
 

--오라클DBMS에서 관리하는 테이블리스트 출력
SELECT *
 FROM DICT;


SELECT *
 FROM DICT
 WHERE TABLE_NAME LIKE 'USER_'; --와일드카드  -------?권한문제
 
 
SELECT *
 FROM DBA_TABLES;

SELECT *
 FROM DBA_TABLES
 WHERE TABLE_NAME LIKE 'EMP';
 
SELECT *
 FROM DBA_USERS
 WHERE USERNAME = 'SCOTT';
 
