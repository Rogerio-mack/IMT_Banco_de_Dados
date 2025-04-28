-- Online SQL Editor to Run SQL Online.
-- Use the editor to create new tables, insert data and all other SQL operations.
-- https://nextleap.app/online-compiler/sql-programming
DROP TABLE album;
CREATE TABLE album (
album_id char PRIMARY KEY not null,
name varchar(50) not null,
year int not null
);

INSERT INTO album VALUES(1,'The Dark Side of the Moon',1973);
INSERT INTO album VALUES(5,'Let It Be',1970);
SELECT * FROM album;

DROP TABLE song;
CREATE TABLE song (
id int not null,
album_id int null,
name varchar(50) not null,
PRIMARY KEY (id),
FOREIGN KEY (album_id) REFERENCES album (album_id)
);

-- Song data
INSERT INTO song VALUES(1,5,'Get Back');
INSERT INTO song VALUES(2,5,'Let It Be');
INSERT INTO song VALUES(10,1,'Time');
SELECT * FROM song;

-- CROSS JOIN | CARTESIAN PRODUCT
-- SELECT * FROM album, song;
SELECT * FROM album JOIN song;

-- ADICIONANDO JOIN CONDITION
-- SELECT * FROM album, song;
-- WHERE album.album_id = song.album_id;
SELECT * FROM album JOIN song
ON album.album_id = song.album_id;

-- ADICIONANDO UMA CONDIÇÃO/SELEÇÃO (WHERE)
-- SELECT * FROM album, song;
-- WHERE album.album_id = song.album_id
-- AND year = 1970;
SELECT * FROM album JOIN song
ON album.album_id = song.album_id
WHERE year = 1970;

-- LEFT JOIN
INSERT INTO album VALUES(13,'Sgt. Pepper''s Lonely Hearts Club Band', 1967);
SELECT * FROM album LEFT JOIN song
ON album.album_id = song.album_id;

-- RIGHT JOIN
INSERT INTO song VALUES(21,NULL,'Stairway to Heaven');
SELECT * FROM album RIGHT JOIN song
ON album.album_id = song.album_id;

-- FULL OUTER JOIN
SELECT * FROM album LEFT JOIN song
ON album.album_id = song.album_id
UNION
SELECT * FROM album RIGHT JOIN song
ON album.album_id = song.album_id;
