-- Create Database
CREATE DATABASE CollegeDB;
USE CollegeDB;

-- Create Faculty Table
CREATE TABLE Faculty (
    Faculty_ID INT PRIMARY KEY,
    Faculty_Name VARCHAR(50),
    Department VARCHAR(50)
);

-- Insert Faculty Records
INSERT INTO Faculty VALUES
(101, 'Ramesh', 'CSE'),
(102, 'Suresh', 'ECE'),
(103, 'Anitha', 'CSE'),
(104, 'Priya', 'IT');

-- Create Course Table
CREATE TABLE Course (
    Course_ID INT PRIMARY KEY,
    Course_Name VARCHAR(50),
    Faculty_ID INT,
    FOREIGN KEY (Faculty_ID) REFERENCES Faculty(Faculty_ID)
);

-- Insert Course Records
INSERT INTO Course VALUES
(201, 'DBMS', 101),
(202, 'Computer Networks', 102),
(203, 'Python', 103),
(204, 'Web Technology', 104);

-- Create Employee Table
CREATE TABLE Employee (
    Employee_ID INT PRIMARY KEY,
    Employee_Name VARCHAR(50),
    Salary INT,
    Department VARCHAR(50)
);

-- Insert Employee Records
INSERT INTO Employee VALUES
(1, 'Rahul', 30000, 'CSE'),
(2, 'Priya', 40000, 'HR'),
(3, 'Kiran', 35000, 'IT'),
(4, 'Anu', 45000, 'Finance');


-- a) Display courses along with corresponding faculty names
SELECT Course.Course_Name, Faculty.Faculty_Name
FROM Course
INNER JOIN Faculty
ON Course.Faculty_ID = Faculty.Faculty_ID;


-- b) SELECT with WHERE clause to retrieve specified employee records
SELECT *
FROM Employee
WHERE Department = 'CSE';


-- c) Implement string functions
SELECT 
    Employee_Name,
    CONCAT(Employee_Name, ' - ', Department) AS Full_Details,
    UPPER(Employee_Name) AS Upper_Name,
    LOWER(Employee_Name) AS Lower_Name,
    LENGTH(Employee_Name) AS Name_Length
FROM Employee;


-- d) INNER JOIN
SELECT Course.Course_Name, Faculty.Faculty_Name
FROM Course
INNER JOIN Faculty
ON Course.Faculty_ID = Faculty.Faculty_ID;


-- LEFT OUTER JOIN
SELECT Course.Course_Name, Faculty.Faculty_Name
FROM Course
LEFT OUTER JOIN Faculty
ON Course.Faculty_ID = Faculty.Faculty_ID;


-- RIGHT OUTER JOIN
SELECT Course.Course_Name, Faculty.Faculty_Name
FROM Course
RIGHT OUTER JOIN Faculty
ON Course.Faculty_ID = Faculty.Faculty_ID;