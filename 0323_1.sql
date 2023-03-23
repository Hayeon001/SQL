SELECT *
 FROM v$version; --현재 사용 중인 오라클 데이터베이스 버전 정보 확인
 
SELECT *
 FROM v$option; --현재 사용 중인 데이터베이스의 옵션 정보를 확인
				--db운영 및 관리에 중요한 정보 제공, 최적화하거나 필요한 옵션 활성화

 SELECT *
 FROM v$database;  --현재 사용 중인 오라클 데이터베이스의 정보 출력
				   --용량이 부족하면, 사용 중인 데이터파일 용량을 확인하고 용량을 늘리는 등

SELECT *
 FROM v$instance;  --현재 사용 중인 데이터베이스 인스턴스의 정보 확인
				   --DB인스턴스의 상태가 이상하다면, 인스턴스 상태를 확인하고 인스턴스를 다시 시작하는 등
 
SELECT *
 FROM v$session;  --현재 데이터베이스에 접속한 모든 세션의 정보
 				  --DB성능 모니터링 및 진단에 유용. DB세션을 모니터링하거나 필요한 경우 세션을 종료

 SELECT *
 FROM v$parameter;  --현재 데이터베이스의 전반적인 구성 정보를 보여주는 뷰
 				    --DB버전, 인스턴스 이름, 메모리 구성, 경로, 세션 및 시스템 파라미터 등 정보제공

 /*
 TRANSACTION
 -데이터베이스에서 수행되는 작업의 단위
 -
 
 */
CREATE TABLE DEPT_TCL
 AS (SELECT * FROM DEPT);
  
SELECT *
 FROM DEPT_TCL;
  
INSERT INTO DEPT_TCL
 VALUES (50,'DATABASE','SEOUL');
  
UPDATE DEPT_TCL
 SET LOC = 'BUSAN'
 WHERE DEPTNO = 40;
  
DELETE FROM DEPT_TCL
 WHERE DNAME = 'RESEARCH';  --레코드 행자체를 날리기에 목적물 표시 필요없음
  
SELECT *
 FROM DEPT_TCL;
 
ROLLBACK;



------------------

INSERT INTO DEPT_TCL
 VALUES (50, 'NEWYORK', 'SEOUL');

UPDATE DEPT_TCL
 SET LOC = 'BUSAN'
 WHERE DEPTNO = 20;

DELETE FROM DEPT_TCL
 WHERE DEPTNO=40;

SELECT *
 FROM DEPT_TCL;

COMMIT;

ROLLBACK; --되돌릴수없음

SELECT *
 FROM DEPT_TCL;

--되돌리려면 UPDATE 하면됨


--LCOK 테스트
--동일한 계정으로 DBeaver에 접속해서 수정
UPDATE DEPT_TCL
 SET LOC = 'DAEGU'
 WHERE DEPTNO = 30;

-- SQL*PLUS에서 실행중인 직원의 UPDATE시도상황을 모를 수 있음.
SELECT *
 FROM DEPT_TCL;  --SQL*PLUS에서는 UPDATE 결과가 안보임

COMMIT;

SELECT *
 FROM DEPT_TCL; --SQLPLUS에서 아직 COMMIT실행전


--TUNING : DB처리속도와 안정성 제고 목적이 대부분
--TUNING 전 후 비교
SELECT *
 FROM EMP
 WHERE SUBSTR(EMPNO,1,2) = 75 --암묵적 형변환
 	AND LENGTH (EMPNO) = 4; --불필요한비교
 
SELECT *
 FROM EMP
 WHERE EMPNO >7499 AND EMPNO < 7600;

--TUNING 전 후 비교
SELECT *
 FROM EMP
 WHERE ENAME || ' ' || JOB = 'WARD SALESMAN';

SELECT *
 FROM EMP
 WHERE ENAME = 'WARD'
 	AND JOB = 'SALESMAN';


--TUNING 전 후 비교
SELECT DISTINCT E.EMPNO
			  , E.ENAME
			  ,D.DEPTNO
 FROM EMP E, DEPT D
 WHERE E.DEPTNO = D.DEPTNO;
 

SELECT *
 FROM EMP
 WHERE DEPTNO = '10'
UNION   ------UNION : 레코드 집합한 후 중복제거
SELECT *
 FROM EMP
 WHERE DEPTNO = '20'; --DEPTNO 10, 20은 상호독립적 집합이므로 중복제거 불필요


--TUNING 전 후 비교
SELECT ENAME
	 , EMPNO
	 , SUM(SAL)
 FROM EMP
 GROUP BY ENAME, EMPNO; 
 
 
 SELECT EMPNO
	 , ENAME
	 , SUM(SAL)
 FROM EMP
 GROUP BY EMPNO, ENAME; --인덱스 설정된 EMPNO를 우선사용하는게 더 빠름
 
 

--TUNING 전 후 비교
SELECT EMPNO
	 , ENAME
 FROM EMP
 WHERE TO_CHAR(HIREDATE, 'YYYYMMDD') LIKE '1981%'
 	AND EMPNO > 7700 ;


SELECT EMPNO
	 , ENAME
 FROM EMP
 WHERE EXTRACT (YEAR, 'YYYYMMDD') LIKE 1981
 	AND EMPNO > 7700 ;


 --튜닝추가
 --1.INDEX활용 - GROUP BY 집계함수
 --2.오라클 DATA 객체함수 비교
 
 SELECT JOB
 	, COUNT(SAL)
  FROM EMP
  GROUP BY JOB;
 
 SELECT JOB
 	, SUM(SAL)
  FROM EMP
  GROUP BY JOB;
 
SELECT *
 FROM USER_INDEXES
 WHERE TABLE_NAME LIKE 'EMP';--------?
 
 
 	ON EMP(JOB);


 SELECT JOB, SUM(SAL) AS SUM_OF_SAL
  FROM EMP
  GROUP BY JOB
  ORDER BY SUM_OF_SAL DESC;
 
 
 
 ------------------------------
 

-- GROUP BY : 집계함수
-- JOIN
 
 SELECT DEPTNO, FLOOR(AVG(SAL)) AS AVG_SAL
  FROM EMP
  GROUP BY DEPTNO;  -------------------------------?

  
SELECT DEPTNO
	, JOB 
	, FLOOR(AVG(SAL)) AS AVG_SAL
 FROM EMP
 GROUP BY JOB, DEPTNO
 ORDER BY JOB, DEPTNO; 
 
 
 SELECT *
  FROM USER_INDEX 
  WHERE TABLE_NAME = 'EMP'; -------------TABLE_NAME
  
  
SELECT DEPTNO
	, JOB 
	, FLOOR(AVG(SAL)) AS AVG_SAL
 FROM EMP
 GROUP BY JOB, DEPTNO
 HAVING AVG(SAL) >=2000
 ORDER BY JOB, DEPTNO; 
  
SELECT DEPTNO
	, JOB 
	, FLOOR(AVG(SAL)) AS AVG_SAL
	, MAX (SAL) AS MAX_SAL
	, MIN (SAL) AS MIN_SAL
 FROM EMP
 GROUP BY JOB, DEPTNO
 HAVING AVG(SAL) >=2000
 ORDER BY JOB, DEPTNO; 
 


-- LISTAGG / PIVOT / ROLLUP / CUBE / GROUPING SET
SELECT DEPTNO
	, LISTAGG(ENAME, ',')
		WITHIN GROUP(ORDER BY SAL DESC) AS ENAME_LIST
 FROM EMP
 GROUP BY DEPTNO;


SELECT DEPTNO, JOB, MAX(SAL)
 FROM EMP
 GROUP BY DEPTNO, JOB 
 ORDER BY DEPTNO, JOB;


SELECT *
 FROM (SELECT DEPTNO, JOB, SAL
 		FROM EMP)
 PIVOT (MAX(SAL) FOR DEPTNO IN (10, 20, 30))
 ORDER BY JOB;

SELECT DEPTNO
	, MAX(DECODE(JOB, 'CLERK', SAL)) AS "CLERK"
	, MAX(DECODE(JOB, 'SALESMAN', SAL)) AS "SALESMAN"
	, MAX(DECODE(JOB, 'PRESIDENT', SAL)) AS "PRESIDENT"
	, MAX(DECODE(JOB, 'MANAGER', SAL)) AS "MANAGER"
	, MAX(DECODE(JOB, 'ANALYST', SAL)) AS "ANALYST"
 FROM EMP
 GROUP BY DEPTNO
 ORDER BY DEPTNO;


SELECT *
FROM (SELECT DEPTNO
	, MAX(DECODE(JOB, 'CLERK', SAL)) AS "CLERK"
	, MAX(DECODE(JOB, 'SALESMAN', SAL)) AS "SALESMAN"
	, MAX(DECODE(JOB, 'PRESIDENT', SAL)) AS "PRESIDENT"
	, MAX(DECODE(JOB, 'MANAGER', SAL)) AS "MANAGER"
	, MAX(DECODE(JOB, 'ANALYST', SAL)) AS "ANALYST"
 FROM EMP
 GROUP BY DEPTNO
 ORDER BY DEPTNO)
UNPIVOT FOR JOB IN ('CLERK', 'SALESMAN','PRESIDENT', 'MANAGER', 'ANALYST');         ------------------------????

















 