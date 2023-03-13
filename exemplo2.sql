--
-- Create database
--
CREATE DATABASE alunos;

--
-- Change database
--
USE alunos;

--
-- Create Table
--
CREATE TABLE Persons (
    ID int NOT NULL,
    LastName varchar(255) NOT NULL,
    FirstName varchar(255),
    Age int,
    PRIMARY KEY (ID)
);

--
-- Populate Table
--
INSERT INTO Persons (ID, LastName, FirstName, Age) 
VALUES ('1', 'Einstein', 'Albert', 65);

INSERT INTO Persons (ID, LastName, FirstName, Age) 
VALUES ('2', 'Joyce', 'James', 60);

--
-- Select Table
--
SELECT * FROM Persons;

--
-- Alter Table
--
ALTER TABLE Persons
ADD Origen char(10);

--
-- Select Table
--
SELECT * FROM Persons;

--
-- Drop Table
--
DROP TABLE Persons;

--
-- Show Tables
--
SHOW TABLES;

