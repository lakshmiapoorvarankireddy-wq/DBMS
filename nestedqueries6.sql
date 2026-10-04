CREATE DATABASE CollegeDB2;
USE CollegeDB2;
CREATE TABLE Department (
    Department_ID INT PRIMARY KEY,
    Department_Name VARCHAR(50)
);
CREATE TABLE Employee (
    Employee_ID INT PRIMARY KEY,
    Employee_Name VARCHAR(50),
    Salary DECIMAL(10,2),
    Department_ID INT,
    FOREIGN KEY (Department_ID) REFERENCES Department(Department_ID)
);

CREATE TABLE Course (
    Course_ID INT PRIMARY KEY,
    Course_Name VARCHAR(50)
);

CREATE TABLE Instructor (
    Instructor_ID INT PRIMARY KEY,
    Instructor_Name VARCHAR(50),
    Course_ID INT,
    FOREIGN KEY (Course_ID) REFERENCES Course(Course_ID)
);

INSERT INTO Department VALUES
(1, 'Finance'),
(2, 'IT'),
(3, 'HR'),
(4, 'CSE');

INSERT INTO Employee VALUES
(101, 'Ravi', 45000, 1),
(102, 'Priya', 55000, 2),
(103, 'Anil', 40000, 3),
(104, 'Sneha', 60000, 2),
(105, 'Kiran', 50000, 4);
INSERT INTO Course VALUES
(201, 'DBMS'),
(202, 'Python'),
(203, 'Computer Networks');
INSERT INTO Instructor VALUES
(301, 'Ramesh', 201),
(302, 'Suresh', 202),
(303, 'Anitha', 201),
(304, 'Kavya', 203);
SELECT *
FROM Employee
WHERE Department_ID IN
(
    SELECT Department_ID
    FROM Department
    WHERE Department_Name IN ('Finance', 'IT')
);

CREATE TABLE Employee_Materialized_View AS
SELECT E.Employee_ID,
       E.Employee_Name,
       E.Salary,
       D.Department_Name
FROM Employee E
JOIN Department D
ON E.Department_ID = D.Department_ID;

SELECT *
FROM Employee_Materialized_View;

SELECT Instructor_Name
FROM Instructor
WHERE Course_ID =
(
    SELECT Course_ID
    FROM Course
    WHERE Course_Name = 'DBMS'
);

START TRANSACTION;
INSERT INTO Employee
VALUES (106, 'Rahul', 48000, 1);
SAVEPOINT sp1;
UPDATE Employee
SET Salary = 52000
WHERE Employee_ID = 106;
ROLLBACK TO SAVEPOINT sp1;
COMMIT;
SELECT *
FROM Employee;