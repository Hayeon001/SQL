SELECT ENAME, JOB, SAL, DEPTNO
 FROM EMP
  WHERE DEPTNO = 10;

SELECT ENAME, JOB, SAL, DEPTNO
 FROM EMP
 WHERE DEPTNO = 20
	AND JOB = 'ANALYST';

SELECT *
FROM EMP
 WHERE SAL > 2500
 ORDER BY SAL;

SELECT *
 FROM EMP
 WHERE ENAME >= 'M'
 ORDER BY ENAME;

SELECT chr(0), chr(65), ascii('a'), ascii('A') FROM dual;

SELECT * FROM EMP WHERE SAL = 5000;

SELECT * FROM EMP WHERE SAL != 5000;

SELECT * FROM EMP WHERE SAL <> 5000;

SELECT * FROM EMP WHERE SAL ^= 5000;

SELECT * FROM EMP WHERE NOT SAL = 5000;

SELECT * FROM EMP
 WHERE SAL = (SELECT MAX(SAL)
 		FROM EMP);

SELECT * FROM EMP WHERE SAL = 5000 AND SAL = 3000;

SELECT * FROM EMP WHERE SAL = 5000 OR SAL = 3000;

SELECT * FROM EMP WHERE SAL IN (3000, 5000);

SELECT * FROM EMP WHERE JOB = 'ANALYST'
 OR JOB = 'KING'
 OR JOB = 'CLERK';
 
SELECT *
 FROM EMP
 WHERE JOB IN('MANAGER','KING','CLERK');

SELECT * FROM EMP WHERE ENAME LIKE 'M%'; -- M% : M으로 시작하는 모든 문자열

SELECT * FROM EMP WHERE ENAME LIKE '_L%'; -- _L% : 2번째 문자가 L인 모든 문자열

SELECT * FROM EMP WHERE ENAME LIKE '%AM%'; -- %AM% :AM이 포함된 문자열

SELECT * FROM EMP WHERE ENAME NOT LIKE '%S'; -- %S : S로 끝나는 문자열

SELECT * FROM EMP WHERE COMM = NULL; -- 오류

SELECT * FROM EMP WHERE COMM IS NULL; -- COMM이 NULL인 경우

SELECT * FROM EMP WHERE MGR = NULL; -- 오류

SELECT * FROM EMP WHERE MGR IS NULL; -- MGR가 NULL인 경우

SELECT EMPNO, ENAME, SAL, DEPTNO, JOB
 FROM EMP WHERE JOB = 'CLERK'
 UNION
 SELECT EMPNO, ENAME, SAL, DEPTNO, JOB
 FROM EMP WHERE JOB = 'SALESMAN';

SELECT EMPNO, ENAME, SAL, DEPTNO, JOB
 FROM EMP WHERE DEPTNO = 10
 UNION
 SELECT EMPNO, ENAME, SAL, DEPTNO, JOB
 FROM EMP WHERE DEPTNO = 20;

SELECT EMPNO, ENAME, SAL, DEPTNO, JOB
 FROM EMP WHERE DEPTNO = 10
 UNION
 SELECT EMPNO, ENAME, SAL, DEPTNO, JOB
 FROM EMP WHERE DEPTNO = 10;



