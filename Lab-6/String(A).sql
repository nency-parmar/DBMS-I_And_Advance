SELECT LEN('NULL') , LEN(' HELLO ') , LEN('BLANK');

SELECT LOWER('NENCY') , UPPER('NENCY');

SELECT LEFT('NENCY',3);

SELECT SUBSTRING('NENCY PARMAR',3,10);

SELECT REPLACE('abc123efg','123','XYZ') , REPLACE('abcabcabc','C','5');

SELECT ASCII('A'),ASCII('a'),ASCII('z'),ASCII('Z'),ASCII(0),ASCII('9');

SELECT CHAR(97),CHAR(65),CHAR(122),CHAR(90),CHAR(48),CHAR(57);

SELECT LTRIM('HELLO WORLD ');

SELECT RTRIM(' HELLO WORLD ');

SELECT LEFT('SQL SERVER',4) , RIGHT('SQL SERVER',5);

SELECT CAST('1234.56' AS DECIMAL(8,2));

SELECT CONVERT(DECIMAL(8,2) , '1234.56');

SELECT CAST(10.58 AS INT);

SELECT CONVERT(INT , 10.58);

SELECT SPACE(10) + 'NENCY';

SELECT 'DARSHAN '+'UNIVERSITY' AS RESULT;

SELECT CONCAT('DARSHAN',' ','UNIVERSITY');

SELECT REVERSE('DARSHAN');

SELECT REPLICATE('NENCY ',3);