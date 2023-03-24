
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
UNPIVOT (SAL FOR JOB IN ('CLERK', 'SALESMAN','PRESIDENT', 'MANAGER', 'ANALYST'))----------------------???
ORDER BY DEPTNO, JOB;





-- VIEW 생성(HR스키마)


--JOIN ... ON ... 구문 : 두 개의 테이블의 컬럼을 연결
--INNER JOIN 1:1관계로 테이블간 연결을 통해 추가 정보를 제공하는 목적이 대부분

SELECT *
 FROM EMP E JOIN DEPT D
 	ON E.DEPTNO = D.DEPTNO ;


LEFT OUTER JOIN

ALTER

SEQUENCE








----------------
/*
6조
일하자빚갚자돈벌자
직원이 부서에 공부해서 풀에 배정되는 시스템
업무량 상위 부서 인원확충 어려움
체계적인 프로세스로 공모가 이뤄진다고 보기 어려움
직원조회 -> 플 조회 -> 공모결과 조회
1대1 매칭으로 다 다른 자격증을 하나씩 보유한 것으로 가정

- 아이디어를 떠올리게 된 계기
- 어떤데이터를 넣었는지
- 기존시스템과의 차이, 충돌 가능성
- 구현되었을 경우 발생할 수 있는 문제점
- 

5조
MUSE인력관리시스템
기업요구사항 분석
신입행원 이탈 방지 및 핵심인력 양성


4조
저성과자 걸러내자
부서별 고과 조회기능
부서별 급여조회기능
프리라이더 없애자 분류기능
절대평가 상대평가가 섞여있음으로 생기는 문제
시스템이 도입될 수 있으려면 어떤 문제를 해결해야
임원부터 해고하는 시스템? 전체직원으로 할 경우 직원들이 수긍할 수 있을까


3조
휴가사용률


*/




--DATA TYPE
--성능측명
--자원활용측면 : 설계단계 중요. 비용문제
--장애대응 측면



-- 오라클 DATE 객체 정보를 바탕으로 쿼리 성능을 비교하는 경우 (
-- 쿼리 1 : to_char() 반환 문자열 = ‘1981’ 문자열 비교
SELECT empno, ename
FROM emp 
WHERE to_char(hiredate, ＇YYYY＇) = ＇1981’ -- 동일한 DataType ~ String
AND empno > 7700
;
-- 쿼리 2 : extract() 반환 정수 = 1981 정수 비교
SELECT empno, ename
FROM EMP
WHERE EXTRACT (year FROM hiredate) = 1981 -- 동일한 DataType ~ integer 
AND empno > 7700


class ORACLE {  // 오라클 클래스 구성 예시 (실제 오라클 클래스 구조와 다른 예시에 불과)
	class Schema { // 스카마 객체 (Each user has a single Schema in Oracle)
		class Table; // 스키마 하위 오라클 객체
		class Index;
		class View;
		class Sequence;
		class DATE { // 오라클이 설계한 DATE 객체
		int type;
		int len;
		int Year;
		int Month;
		int Day;
		int Hours;
		int Minutes;
		int Seconds;
		public DATE(void) { // 오라클 DATE 객체 생성자 예시 (SYSDATE 등의 날짜 객체)
		return get_datetime_from_os() // OS로부터 날짜일시 획득
		}
		public str to_char(date dt, string fmt) {
		return str_date //  포맷(fmt)에 따른 날짜일시를 문자열로 반환
		}
		Public int extract(string fmt) {
		return int_date // 포맷(릇)에 따른 날짜일일시의 구성요소를 반환
		}
;

--SCOTT 스키마


