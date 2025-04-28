
# Album
| album_id | name                                      | year |
| :------- | :---------------------------------------- | :--- |
| 1        | ...And Justice For All                   | 1988 |
| 2        | Black Album                               | 1991 |
| 13       | Sgt. Pepper's Lonely Hearts Club Band | 1967 |

# Song
| id  | album_id | name                                      | duration |
| :-- | :------- | :---------------------------------------- | :------- |
| 1   | 1        | One                                       | 7.25     |
| 4   | 2        | Sad But True                              | 5.29     |
| 25  | 13       | Sgt. Pepper's Lonely Hearts Club Band | 2.0333   |

# Produto Cartesiano
```
select s.name, a.name, s.album_id, a.album_id from song as s, album as a;
```
| album\_id | album\_name                             | album\_year | s.album\_id | song\_name                              | duration |
| :-------- | :-------------------------------------- | :---------- | :------- | :-------------------------------------- | :------- |
| 1         | ...And Justice For All                 | 1988        | 1        | One                                     | 7.25     |
| 1         | ...And Justice For All                 | 1988        | 2        | Sad But True                            | 5.29     |
| 1         | ...And Justice For All                 | 1988        | 13       | Sgt. Pepper's Lonely Hearts Club Band | 2.0333   |
| 2         | Black Album                             | 1991        | 1        | One                                     | 7.25     |
| 2         | Black Album                             | 1991        | 2        | Sad But True                            | 5.29     |
| 2         | Black Album                             | 1991        | 13       | Sgt. Pepper's Lonely Hearts Club Band | 2.0333   |
| 13        | Sgt. Pepper's Lonely Hearts Club Band | 1967        | 1        | One                                     | 7.25     |
| 13        | Sgt. Pepper's Lonely Hearts Club Band | 1967        | 2        | Sad But True                            | 5.29     |
| 13        | Sgt. Pepper's Lonely Hearts Club Band | 1967        | 13      | Sgt. Pepper's Lonely Hearts Club Band | 2.0333   |

# INNER Join 
```
select s.name, a.name, s.album_id, a.album_id from song as s, album as a
where s.album_id = a.album_id;
```
or
```
select s.name, a.name, s.album_id, a.album_id from song as s join album as
a on s.album_id = a.album_id;
```

| album\_id | album\_name                             | album\_year | s.album\_id | song\_name                              | duration |
| :-------- | :-------------------------------------- | :---------- | :------- | :-------------------------------------- | :------- |
| 1         | ...And Justice For All                 | 1988        | 1        | One                                     | 7.25     |
| 2         | Black Album                             | 1991        | 2       | Sad But True                            | 5.29     |
| 13        | Sgt. Pepper's Lonely Hearts Club Band | 1967        | 13      | Sgt. Pepper's Lonely Hearts Club Band | 2.0333   |
