DROP DATABASE IF EXISTS UniversityDB;
CREATE DATABASE UniversityDB;
USE UniversityDB;

CREATE TABLE Department (
    Department_ID INT PRIMARY KEY,
    Department_Name VARCHAR(50) NOT NULL
);

CREATE TABLE Student (
    Student_ID INT PRIMARY KEY,
    Student_Name VARCHAR(50) NOT NULL,
    Department_ID INT,
    FOREIGN KEY (Department_ID) REFERENCES Department(Department_ID)
);

CREATE TABLE Employee (
    Employee_ID INT PRIMARY KEY,
    Employee_Name VARCHAR(50) NOT NULL,
    Department_ID INT,
    Salary DECIMAL(10,2),
    FOREIGN KEY (Department_ID) REFERENCES Department(Department_ID)
);

INSERT INTO Department VALUES
(1, 'Computer Science'),
(2, 'Electronics'),
(3, 'Mechanical'),
(4, 'Civil');

INSERT INTO Student VALUES
(101, 'Apoorva', 1),
(102, 'Lucky', 1),
(103, 'Lokesh', 2),
(104, 'Kumari', 3),
(105, 'Prasad', 4),
(106, 'Anjali', 1);

SELECT *
FROM Student
WHERE Department_ID = 1;

INSERT INTO Employee VALUES
(201, 'Apoorva', 1, 45000),
(202, 'Lucky', 2, 50000),
(203, 'Lokesh', 3, 55000),
(204, 'Kumari', 1, 48000),
(205, 'Prasad', 4, 60000),
(206, 'Anjali', 2, 52000);

SELECT * FROM Employee;

SELECT
    Department_ID,
    SUM(Salary) AS Total_Salary,
    AVG(Salary) AS Average_Salary,
    MIN(Salary) AS Minimum_Salary,
    MAX(Salary) AS Maximum_Salary,
    COUNT(*) AS Employee_Count
FROM Employee
GROUP BY Department_ID;

SELECT
    Department_ID,
    SUM(Salary) AS Total_Salary,
    AVG(Salary) AS Average_Salary,
    MIN(Salary) AS Minimum_Salary,
    MAX(Salary) AS Maximum_Salary,
    COUNT(*) AS Employee_Count
FROM Employee
GROUP BY Department_ID
HAVING AVG(Salary) > 50000;

SELECT Student_Name
FROM Student
WHERE Department_ID = 1

UNION

SELECT Employee_Name
FROM Employee
WHERE Department_ID = 1;

SELECT S.Student_Name
FROM Student S
WHERE EXISTS (
    SELECT 1
    FROM Employee E
    WHERE E.Employee_Name = S.Student_Name
);

SELECT S.Student_Name
FROM Student S
WHERE S.Department_ID = 1
AND NOT EXISTS (
    SELECT 1
    FROM Employee E
    WHERE E.Employee_Name = S.Student_Name
);