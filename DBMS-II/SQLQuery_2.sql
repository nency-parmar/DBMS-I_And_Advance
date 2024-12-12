-- Create Department Table
CREATE TABLE Department (
DepartmentID INT PRIMARY KEY,
DepartmentName VARCHAR(100) NOT NULL UNIQUE
);

-- Create Designation Table
CREATE TABLE Designation (
DesignationID INT PRIMARY KEY,
DesignationName VARCHAR(100) NOT NULL UNIQUE
);

-- Create Person Table
CREATE TABLE Person (
PersonID INT PRIMARY KEY IDENTITY(101,1),
FirstName VARCHAR(100) NOT NULL,
LastName VARCHAR(100) NOT NULL,
Salary DECIMAL(8, 2) NOT NULL,
JoiningDate DATETIME NOT NULL,
DepartmentID INT NULL,
DesignationID INT NULL,
FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID),
FOREIGN KEY (DesignationID) REFERENCES Designation(DesignationID)
);

-- PART - A

-- 1st Proce.
CREATE PROCEDURE PR_Department_Insert
    @DepartmentID INT,
    @DepartmentName VARCHAR(100)
AS
BEGIN
    INSERT INTO Department
    (
        DepartmentID,
        DepartmentName
    )
    VALUES
    (
        @DepartmentID,
        @DepartmentName
    )
END

EXEC PR_Department_Insert 1,'Admin'
EXEC PR_Department_Insert 2,'IT'
EXEC PR_Department_Insert 3,'HR'
EXEC PR_Department_Insert 4,'Account'

SELECT * FROM Department


-- 2nd Proce.
CREATE PROCEDURE PR_Designation_Insert
    @DesignationID INT,
    @DesignationName VARCHAR(100)
AS
BEGIN
    INSERT INTO Designation
    (
        DesignationID,
        DesignationName
    )
    VALUES
    (
        @DesignationID,
        @DesignationName
    )
END

EXEC PR_Designation_Insert 11,'Jobber'
EXEC PR_Designation_Insert 12,'Welder'
EXEC PR_Designation_Insert 13,'Clerk'
EXEC PR_Designation_Insert 14,'Manager'
EXEC PR_Designation_Insert 15,'CEO'

SELECT * FROM Designation

-- 3rd Proce.

CREATE PROCEDURE PR_Person_Insert
    @FirstName VARCHAR(100),
    @LastName VARCHAR(100),
    @Salary DECIMAL(8,2),
    @JoiningDate DATETIME,
    @DepartmentID INT,
    @DesignationID INT
AS
BEGIN
    INSERT INTO Person
    (
        FirstName,
        LastName,
        Salary,
        JoiningDate,
        DepartmentID,
        DesignationID
    )
    VALUES
    (
        @FirstName,
        @LastName,
        @Salary,
        @JoiningDate,
        @DepartmentID,
        @DesignationID
    )
END

EXEC PR_Person_Insert 'Rahul','Anshu',56000,'1990-01-01',1, 12
EXEC PR_Person_Insert 'Hardik','Hinsu',18000,'1990-09-25',2,11 
EXEC PR_Person_Insert 'Bhavin','Kamani',25000,'1991-05-14',NULL,11 
EXEC PR_Person_Insert 'Bhoomi','Patel',39000,'2014-02-20',1,13
EXEC PR_Person_Insert 'Rohit','Rajgor',17000,'1990-07-23',2,15
EXEC PR_Person_Insert 'Priya','Mehta',25000,'1990-10-18',2,NULL
EXEC PR_Person_Insert 'Neha','Trivedi',18000,'2014-02-20',3,15

SELECT * FROM Person

CREATE OR ALTER PROCEDURE PR_Department_UPDATE
    @DepartmentID INT,
    @DepartmentName VARCHAR(100)
AS
BEGIN
    UPDATE Department
    SET DepartmentName = @DepartmentName
    WHERE DepartmentID = @DepartmentID
END

EXEC PR_Department_UPDATE 1 , 'SENIOR MANAGER';
SELECT * FROM Department


CREATE OR ALTER PROCEDURE PR_DESIGNATION_UPDATE
    @DesignationID INT,
    @DesignationName VARCHAR(100)
AS
BEGIN
    UPDATE Designation
    SET DesignationName = @DesignationName
    WHERE DesignationID = @DesignationID
END

EXEC PR_Designation_UPDATE 13 , 'PEON';
SELECT * FROM Designation

CREATE PROCEDURE PR_PERSON_UPDATE
    @PersonID INT,
    @FirstName VARCHAR(100),
    @LastName VARCHAR(100)
AS
BEGIN
    UPDATE Person
    SET FirstName = @FirstName,
        LastName = @LastName
    WHERE PersonID = @PersonID
END;

EXEC PR_PERSON_UPDATE 101 , 'JOHN' , 'DOE';
SELECT * FROM PERSON

-- Delete from Department
CREATE PROCEDURE PR_Department_DELETE
    @DepartmentID INT
AS
BEGIN
    DELETE FROM Department
    WHERE DepartmentID = @DepartmentID;
END;

EXEC PR_PERSON_DELETE 2;
SELECT *  FROM Department

-- Delete from Designation
CREATE PROCEDURE PR_Designation_DELETE
    @DesignationID INT
AS
BEGIN
    DELETE FROM Designation
    WHERE DesignationID = @DesignationID;
END;

-- Delete from Person
CREATE PROCEDURE PR_Person_DELETE
    @PersonID INT
AS
BEGIN
    DELETE FROM Person
    WHERE PersonID = @PersonID
END;

EXEC PR_PERSON_DELETE 104;
SELECT * FROM PERSON;

-- SELECT BY PRIMARY KEY DEPARTMENT
CREATE PROCEDURE PR_Department_By_PrimaryKey
    @DepartmentID INT
AS
BEGIN
    SELECT DepartmentID, DepartmentName
    FROM Department
    WHERE DepartmentID = @DepartmentID
END;

EXEC PR_Department_By_PrimaryKey 1;

-- SELECT BY PRIMARY KEY DESIGNATION
CREATE PROCEDURE PR_Designation_By_PrimaryKey
    @DesignationID INT
AS
BEGIN
    SELECT *
    FROM Designation
    WHERE DesignationID = @DesignationID
END;

EXEC PR_Designation_By_PrimaryKey 13;

-- SELECT BY PRIMARY KEY PERSON
CREATE PROCEDURE PR_Person_By_PrimaryKey
    @PersonID INT
AS
BEGIN
    SELECT *
    FROM Person
    WHERE PersonID = @PersonID
END;

EXEC PR_Person_By_PrimaryKey 101;

-- JOIN ALL TABLES
CREATE OR ALTER PROCEDURE PR_JOIN_ALL_TABLES
AS
BEGIN
    SELECT * FROM Person P
    JOIN Department D
    ON P.DepartmentID = D.DepartmentID
    JOIN Designation DS
    ON P.DesignationID = DS.DesignationID
END

EXEC PR_JOIN_ALL_TABLES

CREATE PROCEDURE PR_GetFirstThreePersons
AS
BEGIN
    SELECT TOP 3 *
    FROM Person
    ORDER BY PersonID;
END;

EXEC PR_GetFirstThreePersons

SELECT * FROM Person

-- PART - B

CREATE PROCEDURE PR_Workers_WITH_Department
    @DepartmentName VARCHAR(100)
AS
BEGIN
    SELECT 
        P.PersonID , P.FirstName , P.LastName , P.DepartmentID , D.DepartmentName , P.DesignationID
    FROM Person P
    INNER JOIN Department D 
    ON P.DepartmentID = D.DepartmentID
    WHERE D.DepartmentName = @DepartmentName
END;

EXEC PR_Workers_WITH_Department 'HR';

CREATE PROCEDURE PR_Workers_Dept_Desg
    @DepartmentName VARCHAR(100),
    @DesignationName VARCHAR(100)
AS
BEGIN
    SELECT 
        P.FirstName , P.LastName , P.Salary , P.JoiningDate , D.DepartmentName
    FROM Person P
    INNER JOIN Department D 
    ON P.DepartmentID = D.DepartmentID
    INNER JOIN Designation DS 
    ON P.DesignationID = DS.DesignationID
    WHERE  D.DepartmentName = @DepartmentName 
    AND DS.DesignationName = @DesignationName
END;

EXEC PR_Workers_Dept_Desg 'HR', 'CEO';

CREATE PROCEDURE PR_Workers_WITH_Department_BY_FNAME
    @FirstName VARCHAR(100)
AS
BEGIN
    SELECT 
        P.PersonID , P.FirstName , P.LastName , P.Salary , P.JoiningDate , D.DepartmentName , DS.DesignationName
    FROM Person P
    INNER JOIN Department D 
    ON P.DepartmentID = D.DepartmentID
    INNER JOIN DESIGNATION DS
    ON P.DesignationID = DS.DesignationID
    WHERE P.FirstName = @FirstName
END;

EXEC PR_Workers_WITH_Department_BY_FNAME 'NEHA';

CREATE OR ALTER PROCEDURE PR_AGGRIGATION_PERSON
AS
BEGIN
    SELECT D.DepartmentName , MAX(SALARY) AS MAX_SALARY,
                              MIN(SALARY) AS MIN_SALARY,
                              AVG(SALARY) AS AVG_SALARY,
                              SUM(SALARY) AS TOTAL_SALARY
    FROM PERSON P
    JOIN Department D
    ON P.DepartmentID = D.DepartmentID
    GROUP BY DepartmentName
END

EXEC PR_AGGRIGATION_PERSON

CREATE OR ALTER PROCEDURE PR_AGGRIGATION_PERSON_BY_DESIGNATION
AS
BEGIN
    SELECT D.DesignationName , AVG(SALARY) AS AVG_SALARY,
                              SUM(SALARY) AS TOTAL_SALARY
    FROM PERSON P
    JOIN Designation D
    ON P.DesignationID = D.DesignationID
    GROUP BY DesignationName
END

EXEC PR_AGGRIGATION_PERSON_BY_DESIGNATION

-- PART - C

CREATE OR ALTER PROCEDURE PR_COUNT_PERSON
    @DepartmentName VARCHAR(100)
AS
BEGIN
    SELECT COUNT(P.PERSONID) , D.DepartmentName FROM Person P
    JOIN Department D 
    ON P.DepartmentID = P.DepartmentID
    WHERE DepartmentName = @DepartmentName
    GROUP BY DepartmentName
END

EXEC PR_COUNT_PERSON 'IT';
EXEC PR_COUNT_PERSON 'HR'

CREATE OR ALTER PROCEDURE PR_PERSON_SALARY
    @SALARY INT
AS
BEGIN
    SELECT * FROM PERSON P
    JOIN Department D
    ON P.DepartmentID = D.DepartmentID
    WHERE Salary > @SALARY
END

SELECT * FROM Person
EXEC PR_PERSON_SALARY 40000
EXEC PR_PERSON_SALARY 17000

CREATE OR ALTER PROCEDURE PR_PERSON_TOTAL_HIGHEST
AS 
BEGIN
	SELECT DepartmentName FROM person
	JOIN Department 
    ON person.DepartmentID = department.DepartmentID
	GROUP BY DepartmentName
	HAVING SUM(Salary) = (
	    SELECT TOP 1 SUM(Salary) FROM person
		GROUP BY DepartmentID
		ORDER BY SUM(Salary) DESC )
END

EXEC PR_PERSON_TOTAL_HIGHEST

CREATE OR ALTER PROCEDURE PR_GET_BY_DESIGNATION
    @DesignationName VARCHAR(100)
AS
BEGIN
    SELECT P.FirstName , P.LastName , D.DesignationName , DE.DepartmentName , P.JoiningDate FROM Person P
    JOIN Designation D 
    ON P.DesignationID = D.DesignationID
    JOIN Department DE
    ON P.DepartmentID = DE.DepartmentID
    WHERE DesignationName = @DesignationName
    AND DATEDIFF(YEAR, P.JoiningDate, GETDATE()) <= 10;
END

EXEC PR_GET_BY_DESIGNATION 'CEO'
-- IF WE WANT GRATER OR EQUAL 10....
CREATE OR ALTER PROCEDURE PR_GET_BY_DESIGNATION1
    @DesignationName VARCHAR(100)
AS
BEGIN
    SELECT P.FirstName , P.LastName , D.DesignationName , DE.DepartmentName , P.JoiningDate FROM Person P
    JOIN Designation D 
    ON P.DesignationID = D.DesignationID
    JOIN Department DE
    ON P.DepartmentID = DE.DepartmentID
    WHERE DesignationName = @DesignationName
    AND DATEDIFF(YEAR, P.JoiningDate, GETDATE()) >= 10;
END
EXEC PR_GET_BY_DESIGNATION1 'CEO'

CREATE OR ALTER PROCEDURE PR_WORKERS_WITHOUT_DESIGNATION
AS
BEGIN
    SELECT DE.DepartmentName, COUNT(P.PersonID) AS WorkerCount FROM Person P
    JOIN Department DE 
    ON P.DepartmentID = DE.DepartmentID
    WHERE P.DesignationID IS NULL
    GROUP BY DE.DepartmentName;
END;

EXEC PR_WORKERS_WITHOUT_DESIGNATION

CREATE OR ALTER PROCEDURE PR_WORKERS_IN_HIGH_SALARY_DEPARTMENTS
AS
BEGIN
    SELECT P.PersonID, P.FirstName, P.LastName, P.Salary, DE.DepartmentName FROM Person P
    JOIN Department DE
    ON P.DepartmentID = DE.DepartmentID
    WHERE P.DepartmentID IN (
            SELECT DepartmentID FROM Person
            GROUP BY DepartmentID
            HAVING AVG(Salary) > 12000 );
END;

EXEC PR_WORKERS_IN_HIGH_SALARY_DEPARTMENTS