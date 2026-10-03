DROP DATABASE IF EXISTS UniversityDB;
CREATE DATABASE UniversityDB;
USE UniversityDB;

CREATE TABLE Department (
    Department_ID INT PRIMARY KEY,
    Department_Name VARCHAR(50) NOT NULL,
    Location VARCHAR(50)
);

CREATE TABLE Employee (
    Employee_ID INT PRIMARY KEY,
    Employee_Name VARCHAR(50) NOT NULL,
    Department_ID INT,
    Salary DECIMAL(10,2),
    FOREIGN KEY (Department_ID) REFERENCES Department(Department_ID)
);

CREATE TABLE Student (
    Student_ID INT PRIMARY KEY,
    Student_Name VARCHAR(50) NOT NULL,
    Major VARCHAR(50),
    Department_ID INT,
    FOREIGN KEY (Department_ID) REFERENCES Department(Department_ID)
);
INSERT INTO Department VALUES
(1, 'Computer Science', 'Block A'),
(2, 'Electronics', 'Block B'),
(3, 'Mechanical', 'Block C'),
(4, 'Civil', 'Block D');
INSERT INTO Employee VALUES
(101, 'Apoorva', 1, 45000.00),
(102, 'Lucky', 2, 50000.00),
(103, 'Lokesh', 3, 55000.00),
(104, 'Kumari', 1, 48000.00),
(105, 'Prasad', 4, 60000.00);

INSERT INTO Student VALUES
(201, 'Apoorva', 'Computer Science', 1),
(202, 'Lucky', 'Electronics', 2),
(203, 'Lokesh', 'Mechanical', 3),
(204, 'Kumari', 'Computer Science', 1),
(205, 'Prasad', 'Civil', 4);

SELECT *
FROM Employee
WHERE Salary > (
    SELECT AVG(Salary)
    FROM Employee
);

SELECT *
FROM Employee E
WHERE Salary > (
    SELECT AVG(E2.Salary)
    FROM Employee E2
    WHERE E2.Department_ID = E.Department_ID
);

CREATE VIEW Employee_View AS
SELECT
    E.Employee_ID,
    E.Employee_Name,
    D.Department_Name,
    E.Salary
FROM Employee E
JOIN Department D
ON E.Department_ID = D.Department_ID;

SELECT * FROM Employee_View;

CREATE TABLE Employee_Materialized_View AS
SELECT
    E.Employee_ID,
    E.Employee_Name,
    D.Department_Name,
    E.Salary
FROM Employee E
JOIN Department D
ON E.Department_ID = D.Department_ID;

SELECT * FROM Employee_Materialized_View;

SELECT
    S.Student_ID,
    S.Student_Name,
    S.Major,
    D.Department_Name
FROM Student S
JOIN Department D
ON S.Department_ID = D.Department_ID;

START TRANSACTION;

UPDATE Employee
SET Salary = Salary + 2000
WHERE Employee_ID = 101;

SAVEPOINT salary_update;

UPDATE Employee
SET Salary = Salary + 3000
WHERE Employee_ID = 102;
ROLLBACK TO SAVEPOINT salary_update;
COMMIT;
START TRANSACTION;
UPDATE Employee
SET Salary = Salary + 5000
WHERE Employee_ID = 103;
ROLLBACK;
SELECT * FROM Employee_View;
SELECT * FROM Employee_Materialized_View;
GRANT SELECT ON UniversityDB.Employee TO 'root'@'localhost';
GRANT SELECT, INSERT, UPDATE
ON UniversityDB.Student
TO 'root'@'localhost';
REVOKE INSERT, UPDATE
ON UniversityDB.Student
FROM 'root'@'localhost';