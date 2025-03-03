-- PART - A

-- Create the Customers table 
CREATE TABLE Customers ( 
Customer_id INT PRIMARY KEY,                 
Customer_Name VARCHAR(250) NOT NULL,         
Email VARCHAR(50) UNIQUE                     
); 


-- Create the Orders table 
CREATE TABLE Orders ( 
Order_id INT PRIMARY KEY,                    
Customer_id INT,                             
Order_date DATE NOT NULL,                    
FOREIGN KEY (Customer_id) REFERENCES Customers(Customer_id)  
);


select * from Customers

select * from Orders

BEGIN TRY 
    DECLARE @NUM1 INT = 10
    DECLARE @NUM2 INT = 0
    DECLARE @RESULT INT
    SET @RESULT = @NUM1 / @NUM2
END TRY
BEGIN CATCH
    PRINT 'ERROR OCCURES THAT IS - DIVIDE BY ZERO ERROR'
END CATCH;

BEGIN TRY  
    DECLARE @VAR1 INT = 10
    DECLARE @VAR2 VARCHAR(50) = '1'
    SET @VAR2 = CAST(@VAR2 AS INT)
    DECLARE @ANS INT
    SET @ANS = @VAR1 + @VAR2
END TRY
BEGIN CATCH
    PRINT 'ERROR OCCURES THAT IS - CANNOT CONVERT STRING TO INTEGER'
END CATCH


--3. Create a procedure that prints the sum of two numbers: take both numbers as integer & handle
-- exception with all error functions if any one enters string value in numbers otherwise print result.

CREATE OR ALTER PROCEDURE PR_SUM_OF_TWO_NUMBER
    @N1 NVARCHAR(20),
    @N2 NVARCHAR(10)
AS BEGIN
    BEGIN TRY
        DECLARE @NUM1 INT = CAST(@N1 AS INT)
        DECLARE @NUM2 INT = CAST(@N2 AS INT)
        PRINT @NUM1 + @NUM2
    END TRY
    BEGIN CATCH
        PRINT 'ERROR OCCURES THAT IS - STRING IS NOT AN INT'
    END CATCH
END

EXEC PR_SUM_OF_TWO_NUMBER 10,'ABC'

--4. Handle a Primary Key Violation while inserting data into customers table and print the error details
-- such as the error message, error number, severity, and state.

BEGIN TRY
    INSERT INTO Customers VALUES(101,'ABC' ,'ABC@GMAIL.COM')
END TRY
BEGIN CATCH
    -- IF NOT EXSIST(SELECT * FROM Customers)
    PRINT 'ERROR MESSAGE : '+ ERROR_MESSAGE()
    PRINT 'ERROR NUMBER : '+ CAST(ERROR_NUMBER() AS VARCHAR(50)) 
    PRINT 'ERROR STATE : '+CAST(ERROR_STATE() AS VARCHAR(100))
    PRINT 'ERROR SEVERITY : '+CAST(ERROR_SEVERITY() AS VARCHAR(100))
END CATCH

SELECT * FROM Customers

--5. Throw custom exception using stored procedure which accepts Customer_id as input & that throws
-- Error like no Customer_id is available in database.

CREATE OR ALTER PROCEDURE PR_CUSTOMER_ID_EXISTS_OR_NOT
@CUSTOMER_ID INT
AS
BEGIN

    IF NOT EXISTS (SELECT Customer_id FROM Customers WHERE Customer_id = @CUSTOMER_ID)
    BEGIN 
        THROW 50001, 'ERROR LIKE NO CUSTOMER_ID IS AVAILABLE IN DATABASE.',1
    END

    ELSE
    BEGIN
        PRINT 'CUSTOMER ID IS ALREADY EXISTS'
    END

END

EXEC PR_CUSTOMER_ID_EXISTS_OR_NOT 102

-- PART - B

--6. Handle a Foreign Key Violation while inserting data into Orders table and print appropriate error message.

BEGIN TRY
    INSERT INTO Orders VALUES(1,101,GETDATE())
END TRY
BEGIN CATCH
    PRINT 'FORIGN KEY VIOLATION ERROR OCCURED : INVALID CUSTOMER id.'
END CATCH

SELECT * FROM Customers
SELECT * FROM Orders

--7. Throw custom exception that throws error if the data is invalid.

CREATE OR ALTER PROCEDURE PR_CUSTOMER_EXECEPTION
@AGE INT
AS
BEGIN
    IF @AGE < 18
    BEGIN
        THROW 50002 , 'AGE MUST BE GRATER THAN 18',1
    END

    ELSE
    BEGIN
        PRINT 'AGE : '+CAST(@AGE AS VARCHAR(100))
    END
END

EXEC PR_CUSTOMER_EXECEPTION 19
EXEC PR_CUSTOMER_EXECEPTION 11

-- 8. Create a Procedure to Update Customer’s Email with Error Handling

CREATE OR ALTER PROCEDURE PR_UPDATE_CUSTOM_EMAIL
@AGE INT
AS
BEGIN
    IF @AGE < 18
    BEGIN
        THROW 50002 , 'AGE MUST BE GRATER THAN 18',1
    END

    ELSE
    BEGIN
        PRINT 'AGE : '+CAST(@AGE AS VARCHAR(100))
    END
END