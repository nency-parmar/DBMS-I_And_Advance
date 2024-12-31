-- PART - A

CREATE OR ALTER FUNCTION FN_HELLO()
RETURNS VARCHAR(100)
AS
BEGIN
    RETURN 'HELLO WORLD'
END

SELECT dbo.FN_HELLO();

CREATE OR ALTER FUNCTION FN_ADD_TWO(@NUM1 INT , @NUM2 INT)
RETURNS INT
AS
BEGIN
    RETURN (@NUM1 + @NUM2)
END

SELECT dbo.FN_ADD_TWO(2,3);

CREATE OR ALTER FUNCTION FN_ODD_EVEN(@NUM INT)
RETURNS VARCHAR(100)
AS
BEGIN
    DECLARE @ANS VARCHAR(100)
    IF(@NUM % 2 = 0)
        SET @ANS = 'NUMBER IS EVEN'
    ELSE
        SET @ANS = 'NUMBER IS ODD' 
    RETURN @ANS
END


SELECT dbo.FN_ODD_EVEN(58)

CREATE OR ALTER FUNCTION FN_GET_PERSONS_FNAME_WITH_B()
RETURNS TABLE
AS
    RETURN
    (
        SELECT * FROM Person
        WHERE FirstName LIKE 'B%'
    )

SELECT * FROM DBO.FN_GET_PERSONS_FNAME_WITH_B()

CREATE OR ALTER FUNCTION FN_GET_PERSONS_UNIQUE()
RETURNS TABLE
AS
    RETURN
    (
        SELECT DISTINCT FirstName FROM Person
    )

SELECT * FROM DBO.FN_GET_PERSONS_UNIQUE()

CREATE OR ALTER FUNCTION FN_GET_1_TO_N(@NUM INT)
RETURNS VARCHAR(MAX)
AS
BEGIN
    DECLARE @NUMBERS VARCHAR(MAX)
    SET @NUMBERS = ''
    DECLARE @I INT
    SET @I = 1
    WHILE(@I <= @NUM)
    BEGIN
        SET @NUMBERS = @NUMBERS + CAST(@I AS VARCHAR) + ' '
        SET @I = @I + 1
    END
    RETURN @NUMBERS
END

SELECT DBO.FN_GET_1_TO_N(5);

CREATE OR ALTER FUNCTION FN_FIND_FACTORIAL(@NUM INT)
RETURNS INT
AS
BEGIN
    DECLARE @NUMBERS INT
    SET @NUMBERS = 1
    DECLARE @I INT
    SET @I = 1
    WHILE(@I <= @NUM)
    BEGIN
        SET @NUMBERS = @NUMBERS * @I
        SET @I = @I + 1
    END
    RETURN @NUMBERS
END

SELECT DBO.FN_FIND_FACTORIAL(3)

-- PART - B

CREATE OR ALTER FUNCTION FN_COMPARE_TWO_NUM(@NUM1 INT , @NUM2 INT)
RETURNS VARCHAR(100)
AS 
BEGIN
    DECLARE @ANS VARCHAR(100)
    -- IF(@NUM1 > @NUM2)
    --     @ANS = CAST(@NUM1 AS VARCHAR) + ' IS GRATER'
    -- ELSE
    --     @ANS = CAST(@NUM2 AS VARCHAR) + ' IS GRATER'
    -- RETURN @ANS

    RETURN CASE
        WHEN @NUM1 > @NUM2 THEN 'NUMBER 1 IS GRATER'
        WHEN @NUM2 > @NUM1 THEN 'NUMBER 2 IS GRATER'
    END
END

SELECT DBO.FN_COMPARE_TWO_NUM(4,2)

CREATE OR ALTER FUNCTION FN_SUM_OF_1_TO_20()
RETURNS INT
AS
BEGIN
    DECLARE @SUM INT
    SET @SUM = 0
    DECLARE @I INT
    SET @I = 1
    WHILE(@I <= 20)
    BEGIN
        IF(@I % 2 = 0)
            SET @SUM = @SUM + @I
        SET @I = @I + 1
    END
    RETURN @SUM
END

SELECT DBO.FN_SUM_OF_1_TO_20();

CREATE OR ALTER FUNCTION FN_STRING_PALINDROM_OR_NOT(@STRING VARCHAR(MAX))
RETURNS VARCHAR(100)
AS
BEGIN
    DECLARE @TEMP VARCHAR(100)

    -- IF(@STRING = REVERSE(@STRING))
    --     SET @TEMP = 'GIVEN STRING IS PALINDROM.'
    -- ELSE
    --     SET @TEMP = 'GIVEN STRING IS NOT PALINDROM.'
    -- RETURN @TEMP
    DECLARE @I = 0
    WHILE(@I <= LENGTH(@STRING))
    BEGIN
        IF(@I = )
            @SUM = @SUM + @I
        SET @I = @I + 
    END
    RETURN @SUM
END

SELECT DBO.FN_STRING_PALINDROM_OR_NOT('AABBAA');

-- PART - C

CREATE OR ALTER FUNCTION FN_PRIME_OR_NOT(@NUM INT)
RETURNS VARCHAR(100)
AS
BEGIN
    DECLARE @ANS VARCHAR(100);
    DECLARE @TEMP INT = 0;
    DECLARE @I INT = 1;

    WHILE(@I <= @NUM)
    BEGIN
        IF(@NUM % @I = 0)
        BEGIN
            SET @TEMP = @TEMP + 1;
        END
        SET @I = @I + 1;
    END
    
    IF(@TEMP = 2)
        SET @ANS = 'NUMBER IS PRIME.';
    ELSE
        SET @ANS = 'NUMBER IS NOT PRIME.';
    
    RETURN @ANS;
END;

SELECT DBO.FN_PRIME_OR_NOT(5)
SELECT DBO.FN_PRIME_OR_NOT(4)

CREATE OR ALTER FUNCTION FN_DATE_DIFFERENCE(
    @START_DATE DATE,
    @END_DATE DATE
)
RETURNS INT
AS
BEGIN
    DECLARE @DAY_DIFF INT;
    SET @DAY_DIFF = DATEDIFF(DAY, @START_DATE, @END_DATE);
    RETURN @DAY_DIFF;
END;

SELECT dbo.FN_DATE_DIFFERENCE('2024-12-01','2024-12-23')

CREATE OR ALTER FUNCTION FN_DAYS_IN_MONTH(
    @YEAR INT,
    @MONTH INT
)
RETURNS INT
AS
BEGIN
    RETURN DAY(EOMONTH(DATEFROMPARTS(@YEAR, @MONTH, 1)));
END;

SELECT dbo.FN_DAYS_IN_MONTH(2024, 6);
SELECT dbo.FN_DAYS_IN_MONTH(2023, 4);

CREATE OR ALTER FUNCTION FN_GET_PERSON_DETAILS(@DeptID INT)
RETURNS TABLE
AS
    RETURN
    (
        SELECT * FROM Person 
        WHERE DepartmentID = @DeptID
    );

SELECT * FROM dbo.FN_GET_PERSON_DETAILS(1);

CREATE OR ALTER FUNCTION FN_PERSONS_JOINED_AFTER_1991()
RETURNS TABLE
AS
RETURN
    (
        SELECT * FROM Person
        WHERE JoiningDate > '1991-01-01'
    );

SELECT * FROM dbo.FN_PERSONS_JOINED_AFTER_1991();