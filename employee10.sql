CREATE DATABASE CollegeDB6;

USE CollegeDB6;

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

CREATE TABLE Student (
    Student_ID INT PRIMARY KEY,
    Student_Name VARCHAR(50)
);

CREATE TABLE Course (
    Course_ID INT PRIMARY KEY,
    Course_Name VARCHAR(50)
);

CREATE TABLE Enrollment (
    Enrollment_ID INT PRIMARY KEY,
    Student_ID INT,
    Course_ID INT,
    FOREIGN KEY (Student_ID) REFERENCES Student(Student_ID),
    FOREIGN KEY (Course_ID) REFERENCES Course(Course_ID)
);

INSERT INTO Department VALUES
(1, 'CSE'),
(2, 'IT'),
(3, 'ECE'),
(4, 'Finance');

INSERT INTO Employee VALUES
(101, 'Ravi', 55000, 1),
(102, 'Priya', 75000, 2),
(103, 'Anil', 65000, 2),
(104, 'Sneha', 50000, 3),
(105, 'Kiran', 45000, 4);

INSERT INTO Student VALUES
(1, 'Rahul'),
(2, 'Anu'),
(3, 'Kiran'),
(4, 'Sneha'),
(5, 'Ravi');

INSERT INTO Course VALUES
(201, 'DBMS'),
(202, 'Python'),
(203, 'Java');

INSERT INTO Enrollment VALUES
(1, 1, 201),
(2, 2, 202),
(3, 3, 201);

SELECT Department_Name
FROM Department D
WHERE EXISTS (
    SELECT 1
    FROM Employee E
    WHERE E.Department_ID = D.Department_ID
    AND E.Salary > 60000
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

SELECT Student_ID,
       Student_Name
FROM Student
WHERE Student_ID NOT IN (
    SELECT Student_ID
    FROM Enrollment
);

START TRANSACTION;

UPDATE Employee
SET Salary = Salary + 5000
WHERE Employee_ID = 101;

ROLLBACK;

SELECT *
FROM Employee
WHERE Employee_ID = 101;