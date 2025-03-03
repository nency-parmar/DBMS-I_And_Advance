-- CURSOR Part - A


-- Create the Products table
CREATE TABLE Products (
 Product_id INT PRIMARY KEY,
 Product_Name VARCHAR(250) NOT NULL,
 Price DECIMAL(10, 2) NOT NULL
);
-- Insert data into the Products table
INSERT INTO Products (Product_id, Product_Name, Price) VALUES
(1, 'Smartphone', 35000),
(2, 'Laptop', 65000),
(3, 'Headphones', 5500),
(4, 'Television', 85000),
(5, 'Gaming Console', 32000);

SELECT * FROM Products;
-- 1. Create a cursor Product_Cursor to fetch all the rows from a products table.

DECLARE Product_Cursor CURSOR
FOR
    SELECT * FROM Products

OPEN Product_Cursor

FETCH NEXT FROM Product_Cursor

WHILE @@FETCH_STATUS = 0 
    BEGIN
        FETCH NEXT FROM Product_Cursor
    END

CLOSE Product_Cursor

DEALLOCATE Product_Cursor

-- 2. Create a cursor Product_Cursor_Fetch to fetch the records in form of ProductID_ProductName.(Example: 1_Smartphone)

DECLARE @PRODUCTID INT,
        @PRODUCTNAME VARCHAR(100)

DECLARE Product_Cursor_Fetch CURSOR
FOR
    SELECT Product_id , Product_Name FROM Products;

OPEN Product_Cursor_Fetch

FETCH NEXT FROM Product_Cursor_Fetch
INTO @PRODUCTID , @PRODUCTNAME

WHILE @@FETCH_STATUS = 0 
    BEGIN
        SELECT (CAST(@PRODUCTID AS varchar(100))+'_'+@PRODUCTNAME)

        FETCH NEXT FROM Product_Cursor_Fetch    
        INTO @PRODUCTID , @PRODUCTNAME
    END

CLOSE Product_Cursor_Fetch

DEALLOCATE Product_Cursor_Fetch

-- 3. Create a Cursor to Find and Display Products Above Price 30,000.

DECLARE @PRODUCTNAME VARCHAR(250),
        @PRICE DECIMAL(10,2)

DECLARE CURSOR_PRICE_FETCH CURSOR
FOR
    SELECT Product_Name , Price FROM Products;

OPEN CURSOR_PRICE_FETCH

FETCH NEXT FROM CURSOR_PRICE_FETCH
INTO @PRODUCTNAME , @PRICE

WHILE @@FETCH_STATUS = 0 
    BEGIN
        IF(@PRICE > 30000)
            PRINT(@PRODUCTNAME +' = '+CAST(@PRICE AS VARCHAR(100)))

        FETCH NEXT FROM CURSOR_PRICE_FETCH
        INTO @PRODUCTNAME , @PRICE
    END

CLOSE CURSOR_PRICE_FETCH

DEALLOCATE CURSOR_PRICE_FETCH

-- 4. Create a cursor Product_CursorDelete that deletes all the data from the Products table.

DECLARE @PRODUCTID INT

DECLARE Product_CursorDelete CURSOR
FOR
	SELECT Product_id FROM Products

OPEN Product_CursorDelete

FETCH NEXT FROM Product_CursorDelete
INTO @PRODUCTID

WHILE @@FETCH_STATUS = 0
	BEGIN
		DELETE FROM Products
		WHERE Product_id = @PRODUCTID

		FETCH NEXT FROM Product_CursorDelete
		INTO @PRODUCTID
	END

CLOSE Product_CursorDelete

DEALLOCATE Product_CursorDelete

-- CURSOR PART - B

-- 5. Create a cursor Product_CursorUpdate that retrieves all the data from the products table and increases the price by 10%.

DECLARE @PRODUCTID INT,
        @PRODUCTNAME VARCHAR(50),
        @PRICE DECIMAL(8,2)

DECLARE Product_CursorUpdate CURSOR
FOR 
    SELECT * FROM Products

OPEN Product_CursorUpdate

FETCH NEXT FROM Product_CursorUpdate
INTO @PRODUCTID , @PRODUCTNAME , @PRICE

WHILE @@FETCH_STATUS = 0
    BEGIN 
        UPDATE Products
        SET Price = (@Price + @Price*0.10)
        WHERE Product_id = @PRODUCTID

        FETCH NEXT FROM Product_CursorUpdate
        INTO @PRODUCTID , @PRODUCTNAME , @PRICE
    END

CLOSE Product_CursorUpdate

DEALLOCATE Product_CursorUpdate;

SELECT * FROM Products

-- 6. Create a cursor Product_CursorDelete that deletes all the data from the Products table.

DECLARE @PRICE DECIMAL(10,2)

DECLARE CURSOR_PRICE_ROUND CURSOR
FOR 
    SELECT Price FROM Products

OPEN CURSOR_PRICE_ROUND

FETCH NEXT FROM CURSOR_PRICE_ROUND
INTO @PRICE

WHILE @@FETCH_STATUS = 0
    BEGIN
        UPDATE Products
        SET PRICE = ROUND(PRICE,0)

        FETCH NEXT FROM CURSOR_PRICE_ROUND
        INTO @PRICE
    END

CLOSE CURSOR_PRICE_ROUND

DEALLOCATE CURSOR_PRICE_ROUND

SELECT * FROM Products