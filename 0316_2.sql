SELECT *
 FROM emp;

SELECT ENAME
     , DEPTNO
FROM emp a
;

--137
SELECT 100+5
     , 10-3
     , 30*2
     , 10/3
FROM dual;

SELECT dbms_random.value() * 100
FROM dual;

SELECT ENAME AS "employee name" 
FROM EMP employee;

SELECT *
FROM EMP
ORDER BY SAL;

SELECT *
FROM EMP
ORDER BY SAL DESC;

SELECT *
FROM EMP
ORDER BY DEPTNO ASC, SAL DESC;

SELECT * FROM NLS_DATABASE_PARAMETERS;

SELECT * FROM NLS_DATABASE_PARAMETERS WHERE PARAMETER = 'NLS_CHARACTERSET';
