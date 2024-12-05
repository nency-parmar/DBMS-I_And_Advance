-- Part - A

SELECT DISTINCT GENRE FROM SONGS

SELECT TOP 2 * FROM Albums 
WHERE Release_year < 2010

INSERT INTO Songs VALUES (1245, 'Zaroor', 2.55, 'Feel good', 1005);

UPDATE SONGS
SET Song_title = 'HAPPY'
WHERE Song_title = 'ZAROOR';

DELETE Artists
WHERE Artist_name = 'Ed Sheeran'

ALTER TABLE Songs
ADD Rating DECIMAL(3,2);

SELECT * FROM SONGS 
WHERE Song_title LIKE 'S%';

SELECT * FROM SONGS 
WHERE Song_title LIKE '%Everybody%';

SELECT UPPER(ARTIST_NAME) FROM Artists;

SELECT Song_title, SQRT(Duration) AS Duration_Square_Root
FROM Songs
WHERE Song_title = 'Good Luck';

SELECT GETDATE() AS TODAY_DATE;

SELECT A.Artist_name, COUNT(AL.Album_id) AS num_of_albums
FROM Artists A
LEFT JOIN Albums AL 
ON A.Artist_id = AL.Artist_id
GROUP BY A.Artist_name;

SELECT * FROM Albums
SELECT * FROM Artists

SELECT Album_id
FROM Songs
GROUP BY Album_id
HAVING COUNT(Song_id) > 5;

-- SELECT Albums.Album_id
-- FROM Songs
-- INNER JOIN Albums
-- ON Songs.Album_id = Albums.Album_id
-- GROUP BY Albums.Album_id
-- HAVING COUNT(Song_id) > 5;

SELECT Song_id, Song_title
FROM Songs
WHERE Album_id = (SELECT Album_id FROM Albums WHERE Album_title = 'Album1');

SELECT Album_title FROM Albums
WHERE Artist_id = (SELECT Artist_id FROM Artists WHERE Artist_name = 'Aparshakti Khurana');

SELECT S.Song_title , A.Album_title FROM Songs S
JOIN Albums A
ON S.Album_id = A.Album_id;

SELECT S.Song_title , A.Release_year FROM Songs S
JOIN Albums A
ON S.Album_id = A.Album_id
WHERE A.Release_year = 2020;

CREATE VIEW VW_Fav_Songs AS
SELECT *
FROM Songs  
WHERE Song_id BETWEEN 101 AND 105;

SELECT * FROM VW_Fav_Songs

UPDATE VW_Fav_Songs
SET Song_title = 'JANNAT'
WHERE Song_id = 101

SELECT A.Artist_name FROM Artists A
JOIN Albums AL
ON A.Artist_id = AL.Artist_id
WHERE AL.Release_year = 2020

SELECT S.Song_title , S.Duration FROM Songs S
JOIN Albums A
ON S.Album_id = A.Album_id
JOIN Artists AR 
ON A.Artist_id = AR.Artist_id
WHERE AR.Artist_name = 'Shreya Ghoshal'
ORDER BY S.Duration ASC;

-- PART - B

SELECT S.Song_title, A.Album_title, AR.Artist_name
FROM Songs S
JOIN Albums A ON S.Album_id = A.Album_id
JOIN Artists AR ON A.Artist_id = AR.Artist_id
WHERE A.Artist_id IN (
    SELECT Artist_id
    FROM Albums
    GROUP BY Artist_id
    HAVING COUNT(Album_id) > 1
);

SELECT A.Album_id, A.Album_title, COUNT(S.Song_id) AS Total_Songs
FROM Albums A
LEFT JOIN Songs S 
ON A.Album_id = S.Album_id
GROUP BY A.Album_id, A.Album_title, A.Release_year;

SELECT S.Song_title , A.Release_year FROM Songs S
JOIN Albums A
ON S.Album_id = A.Album_id
ORDER BY A.Release_year

SELECT Genre, COUNT(*) AS Total_Songs
FROM Songs
GROUP BY Genre
HAVING COUNT(*) > 2;

SELECT AR.Artist_id, AR.Artist_name
FROM Artists AR
JOIN Albums AL ON AR.Artist_id = AL.Artist_id
JOIN Songs S ON AL.Album_id = S.Album_id
GROUP BY AR.Artist_id, AR.Artist_name
HAVING COUNT(S.Song_id) > 3;

-- PART - C

SELECT Album_id, Album_title, Artist_id, Release_year
FROM Albums
WHERE Release_year = ( SELECT Release_year FROM Albums WHERE Album_title = 'Album4')
AND Album_title != 'Album4';

SELECT S.Song_title, S.Genre, S.Duration
FROM Songs S
WHERE S.Duration = (SELECT MAX(Duration) FROM Songs WHERE Genre = S.Genre);

SELECT S.Song_title
FROM Songs S
JOIN Albums A 
ON S.Album_id = A.Album_id
WHERE A.Album_title LIKE '%Album%';

SELECT AR.Artist_id, AR.Artist_name, SUM(S.Duration) AS Total_Duration FROM Artists AR
JOIN Albums AL 
ON AR.Artist_id = AL.Artist_id
JOIN Songs S 
ON AL.Album_id = S.Album_id
GROUP BY AR.Artist_id, AR.Artist_name
HAVING SUM(S.Duration) > 15;