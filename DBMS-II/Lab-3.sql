CREATE TABLE Departments (
DepartmentID INT PRIMARY KEY,
DepartmentName VARCHAR(100) NOT NULL UNIQUE,
ManagerID INT NOT NULL,
Location VARCHAR(100) NOT NULL
);

CREATE TABLE Employee (
EmployeeID INT PRIMARY KEY,
FirstName VARCHAR(100) NOT NULL,
LastName VARCHAR(100) NOT NULL,
DoB DATETIME NOT NULL,
Gender VARCHAR(50) NOT NULL,
HireDate DATETIME NOT NULL,
DepartmentID INT NOT NULL,
Salary DECIMAL(10, 2) NOT NULL,
FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

-- Create Projects Table
CREATE TABLE Projects (
ProjectID INT PRIMARY KEY,
ProjectName VARCHAR(100) NOT NULL,
StartDate DATETIME NOT NULL,
EndDate DATETIME NOT NULL,
DepartmentID INT NOT NULL,
FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

INSERT INTO Departments (DepartmentID, DepartmentName, ManagerID, Location)
VALUES
(1, 'IT', 101, 'New York'),
(2, 'HR', 102, 'San Francisco'),
(3, 'Finance', 103, 'Los Angeles'),
(4, 'Admin', 104, 'Chicago'),
(5, 'Marketing', 105, 'Miami');

INSERT INTO Employee (EmployeeID, FirstName, LastName, DoB, Gender, HireDate, DepartmentID,
Salary)
VALUES
(101, 'John', 'Doe', '1985-04-12', 'Male', '2010-06-15', 1, 75000.00),
(102, 'Jane', 'Smith', '1990-08-24', 'Female', '2015-03-10', 2, 60000.00),
(103, 'Robert', 'Brown', '1982-12-05', 'Male', '2008-09-25', 3, 82000.00),
(104, 'Emily', 'Davis', '1988-11-11', 'Female', '2012-07-18', 4, 58000.00),
(105, 'Michael', 'Wilson', '1992-02-02', 'Male', '2018-11-30', 5, 67000.00);

INSERT INTO Projects (ProjectID, ProjectName, StartDate, EndDate, DepartmentID)
VALUES
(201, 'Project Alpha', '2022-01-01', '2022-12-31', 1),
(202, 'Project Beta', '2023-03-15', '2024-03-14', 2),
(203, 'Project Gamma', '2021-06-01', '2022-05-31', 3),
(204, 'Project Delta', '2020-10-10', '2021-10-09', 4),
(205, 'Project Epsilon', '2024-04-01', '2025-03-31', 5);

SELECT * FROM Departments;
SELECT * FROM Employee;
SELECT * FROM Projects;

-- PART - A

CREATE OR ALTER PROCEDURE PR_Get_Employee_Details
    @FirstName VARCHAR(100) = NULL,
    @LastName VARCHAR(100) = NULL
AS
BEGIN
    SELECT FirstName, LastName, DOB, Gender, HireDate
    FROM 
        Employee
    WHERE FirstName = @FirstName 
    OR LastName = @LastName
END;

EXEC PR_Get_Employee_Details @FirstName='john';
EXEC PR_Get_Employee_Details 'Robert';
EXEC PR_Get_Employee_Details @LastName = 'Brown';

CREATE OR ALTER PROCEDURE PR_Get_Department
    @DepartmentName VARCHAR(100)
AS
BEGIN
    SELECT E.EmployeeID, E.FirstName, E.LastName, E.DOB, E.Gender, E.HireDate, D.DepartmentName
    FROM Employee E
    INNER JOIN DepartmentS D 
    ON E.DepartmentID = D.DepartmentID
    WHERE D.DepartmentName = @DepartmentName;
END;

EXEC PR_Get_Department 'ADMIN';

ALTER OR CREATE PROCEDURE PR_GET_PROJECT_DETAILS
    @ProjectName VARCHAR(100),
    @DepartmentName VARCHAR(100)
AS
BEGIN
    SELECT P.ProjectID, P.ProjectName, P.StartDate, P.EndDate, D.DepartmentName
    FROM Projects P
    INNER JOIN Departments D 
    ON P.DepartmentID = D.DepartmentID
    WHERE P.ProjectName = @ProjectName
    AND D.DepartmentName = @DepartmentName
END;

EXEC PR_GET_PROJECT_DETAILS 'Project Alpha ' , 'IT';

CREATE OR ALTER PROCEDURE PR_GET_EMPLOYEE_BY_SALARY
    @MIN_SALARY INT,
    @MAX_SALARY INT
AS
BEGIN
    SELECT * FROM Employee 
    WHERE Salary > @MIN_SALARY
    AND Salary < @MAX_SALARY
END

EXEC PR_GET_EMPLOYEE_BY_SALARY 60000 , 80000;

-- BY IF - ELSE 

CREATE OR ALTER PROC PR_SelectEmpBySalary_1
	@Random_Salary INT
AS
BEGIN
	if @Random_Salary < 50000
		SELECT 'Please enter valid salary'
		
	else
		select *from Employee
		where
			Salary between
			@Random_Salary
			AND
			@Random_Salary + 50000
END

EXEC PR_SelectEmpBySalary_1 40000
EXEC PR_SelectEmpBySalary_1 130000

CREATE OR ALTER PROCEDURE PR_GET_EMPLOYEE_BY_DATE
   @HireDate DATETIME
AS
BEGIN
    SELECT * FROM Employee 
    WHERE HireDate = @HireDate
END

EXEC PR_GET_EMPLOYEE_BY_DATE '2008-09-25'


-- PART - B

CREATE OR ALTER PROCEDURE PR_GENDER
	@GENDER VARCHAR(100)
AS
BEGIN
	SELECT * FROM Employee 
    WHERE Gender LIKE @GENDER+'%'
END

EXEC PR_GENDER 'F'

CREATE OR ALTER PROCEDURE PR_DEPARTMENTS_WITH_EMPLOYEE
	@FirstName VARCHAR(100) = NULL,
    @DepartmentName VARCHAR(100) = NULL
AS
BEGIN
	SELECT * FROM Employee E
    JOIN Departments D
		ON E.DepartmentID = D.DepartmentID
		WHERE E.FirstName = @Firstname
        OR D.DepartmentName = @DepartmentName
END

EXEC PR_DEPARTMENTS_WITH_EMPLOYEE 'JOHN'
EXEC PR_DEPARTMENTS_WITH_EMPLOYEE @DepartmentName = 'Finance'

CREATE OR ALTER PROCEDURE PR_GET_DEPARTMENTS_BY_LOCATION
    @LOCATION VARCHAR(100)
AS
BEGIN
    SELECT * FROM Departments
    WHERE Location LIKE '%'+@LOCATION+'%'
END

EXEC PR_GET_DEPARTMENTS_BY_LOCATION 'EW'

-- PART - C

CREATE OR ALTER PROCEDURE PR_GET_PROJECT_BY_DATE
    @FROMDATE DATE,
    @TODATE DATE
AS
BEGIN
    SELECT * FROM Projects
    WHERE StartDate = @FROMDATE
    AND EndDate = @TODATE
END

EXEC PR_GET_PROJECT_BY_DATE '2022-01-01','2022-12-31'

CREATE OR ALTER PROCEDURE PR_GET_ALL_BY_PROJECTNAME_LOCATION
    @PROJECTNAME VARCHAR(100),
    @LOCATION VARCHAR(100)
AS
BEGIN
    SELECT D.DepartmentName , E.FirstName AS MANAGER_NAME,
           P.ProjectName , P.StartDate , P.EndDate FROM Projects P
    JOIN Departments D
    ON P.DepartmentID = D.DepartmentID
    JOIN Employee E
    ON E.EmployeeID = D.ManagerID
    WHERE P.ProjectName = @PROJECTNAME
    AND Location = @LOCATION
END

EXEC PR_GET_ALL_BY_PROJECTNAME_LOCATION 'Project Alpha' , 'New York'