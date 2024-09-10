SELECT PersonName , DepartmentName , DepartmentCode FROM PERSON
JOIN DEPT ON PERSON.DepartmentID = DEPT.DepartmentID;

SELECT PersonName , LOCATION FROM PERSON
JOIN DEPT ON PERSON.DepartmentID = DEPT.DepartmentID WHERE LOCATION='C-BLOCK';

SELECT PersonName , SALARY , DepartmentName FROM PERSON
JOIN DEPT ON PERSON.DepartmentID = DEPT.DepartmentID WHERE CITY='JAMNAGAR';

SELECT PersonName , SALARY , DepartmentName FROM PERSON
JOIN DEPT ON PERSON.DepartmentID = DEPT.DepartmentID WHERE CITY<>'RAJKOT';

SELECT PersonName FROM PERSON
JOIN DEPT ON PERSON.DepartmentID = DEPT.DepartmentID WHERE DepartmentName='CIVIL' AND JoiningDate>'2001-08-01';

SELECT * FROM PERSON
JOIN DEPT ON PERSON.DepartmentID = DEPT.DepartmentID WHERE DepartmentName='COMPUTER';

SELECT PersonName , DepartmentName FROM PERSON
JOIN DEPT ON PERSON.DepartmentID = DEPT.DepartmentID WHERE DATEDIFF(GETDATE(),JoiningDate)>365;

SELECT COUNT(PersonID) , DepartmentName FROM PERSON
JOIN DEPT ON PERSON.DepartmentID = DEPT.DepartmentID 
GROUP BY DepartmentName;

SELECT MAX(SALARY) AS MAX_SALARY , MIN(SALARY) AS MIN_SALARY , DEPARTMENTNAME FROM PERSON
JOIN DEPT ON PERSON.DepartmentID = DEPT.DepartmentID
GROUP BY DepartmentName;

SELECT SUM(SALARY) AS TOTAL_SALARY , AVG(SALARY) AS AVG_SALARY , MAX(SALARY) AS MAX_SALARY , MIN(SALARY) AS MIN_SALARY , CITY FROM PERSON
JOIN DEPT ON PERSON.DepartmentID = DEPT.DepartmentID
GROUP BY CITY;

SELECT AVG(SALARY) AS AVG_SALARY FROM PERSON
JOIN DEPT ON PERSON.DepartmentID = DEPT.DepartmentID
WHERE CITY='AHMEDABAD';

SELECT PersonName + ' LIVES IN ' + City + ' AND WORKS IN ' + DepartmentName + ' DEPARTMENT.' FROM PERSON
JOIN DEPT ON PERSON.DepartmentID = DEPT.DepartmentID;