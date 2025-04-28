drop database music_short;
CREATE DATABASE IF NOT EXISTS music_short DEFAULT CHARACTER SET utf8;
use music_short;

-- Album Table
CREATE TABLE album (
album_id char not null,
artist_id int not null,
name varchar(50) not null,
year int not null
);
describe album;
ALTER TABLE album MODIFY COLUMN album_id int;
describe album;
ALTER TABLE album DROP COLUMN artist_id;
describe album;
ALTER TABLE album ADD CONSTRAINT PRIMARY KEY(album_id);
describe album;

-- Album data
INSERT INTO album VALUES(1,'...And Justice For All',1988);
INSERT INTO album VALUES(2,'Black Album',1991);
INSERT INTO album VALUES(13,'Sgt. Pepper''s Lonely Hearts Club Band',
1967);

-- Song table
CREATE TABLE song (
id int not null,
album_id int not null,
name varchar(50) not null,
duration real not null,
PRIMARY KEY (id),
KEY fk_album_in_song (album_id),
CONSTRAINT fk_album_in_song FOREIGN KEY (album_id) REFERENCES album
(album_id)
);

-- Song data
INSERT INTO song VALUES(1,1,'One',7.25);
INSERT INTO song VALUES(4,2,'Sad But True',5.29);
INSERT INTO song VALUES(25,13,'Sgt. Pepper''s Lonely Hearts Club Band',
2.0333);

show tables;
select * from album;
select * from song;

-- OLD STYLE, WHERE JOINS
-- CROSS JOIN, PRODUTO CARTESIANO

select s.name, a.name, s.album_id, a.album_id from song as s, album as a;
-- retorna todas as combinações possíveis

-- ADICIONANDO JOIN CONDITION

select s.name, a.name, s.album_id, a.album_id from song as s, album as a
where s.album_id = a.album_id;
-- retorna somente as combinações válidas, isto é o album_id corresponde
ao id do album daquele song

-- MODERN STYLE, JOIN CLAUSE
-- CROSS JOIN, INNER | NATURAL JOIN, FULL OUTER JOIN, LEFT JOIN, RIGHT JOIN

select s.name, a.name, s.album_id, a.album_id from song as s join album as
a on s.album_id = a.album_id;
select s.name, a.name, s.album_id, a.album_id from song as s join album as
a on s.album_id = a.album_id
where s.name like 'S%';

-- RIGHT JOIN
INSERT INTO album VALUES(7, 'Reptile',2001);
select s.name, a.name, s.album_id, a.album_id from song as s right join
album as a on s.album_id = a.album_id;

-- LEFT JOIN
select s.name, a.name, s.album_id, a.album_id from album as a left join
song as s on s.album_id = a.album_id;
select s.name as "Song name", a.name as "Album name",
s.album_id as "Song's Album id", a.album_id as "Album id"
from album as a left join song as s
on s.album_id = a.album_id;
