DROP DATABASE IF EXISTS UniversityDB;
CREATE DATABASE UniversityDB;
USE UniversityDB;

CREATE TABLE Department (
    Department_ID INT PRIMARY KEY,
    Department_Name VARCHAR(50) NOT NULL,
    Location VARCHAR(50)
);
CREATE TABLE Faculty (
    Faculty_ID INT PRIMARY KEY,
    Faculty_Name VARCHAR(50) NOT NULL,
    Email VARCHAR(100),
    Department_ID INT,
    FOREIGN KEY (Department_ID) REFERENCES Department(Department_ID)
);
CREATE TABLE Student (
    Student_ID INT PRIMARY KEY,
    Student_Name VARCHAR(50) NOT NULL,
    Gender VARCHAR(10),
    Date_of_Birth DATE,
    Department_ID INT,
    FOREIGN KEY (Department_ID) REFERENCES Department(Department_ID)
);
CREATE TABLE Course (
    Course_ID INT PRIMARY KEY,
    Course_Name VARCHAR(100) NOT NULL,
    Credits INT,
    Department_ID INT,
    Faculty_ID INT,
    FOREIGN KEY (Department_ID) REFERENCES Department(Department_ID),
    FOREIGN KEY (Faculty_ID) REFERENCES Faculty(Faculty_ID)
);
CREATE TABLE Enrollment (
    Enrollment_ID INT PRIMARY KEY,
    Student_ID INT,
    Course_ID INT,
    Enrollment_Date DATE,
    Grade VARCHAR(5),
    FOREIGN KEY (Student_ID) REFERENCES Student(Student_ID),
    FOREIGN KEY (Course_ID) REFERENCES Course(Course_ID)
);
CREATE TABLE Employee (
    Employee_ID INT PRIMARY KEY,
    Employee_Name VARCHAR(50) NOT NULL,
    Department_ID INT,
    Salary DECIMAL(10,2),
    Joining_Date DATE,
    FOREIGN KEY (Department_ID) REFERENCES Department(Department_ID)
);
INSERT INTO Department VALUES
(1, 'Computer Science', 'Block A'),
(2, 'Electronics', 'Block B'),
(3, 'Mechanical', 'Block C'),
(4, 'Civil', 'Block D');
INSERT INTO Faculty VALUES
(101, 'Apoorva', 'apoorva@university.com', 1),
(102, 'Lucky', 'lucky@university.com', 2),
(103, 'Lokesh', 'lokesh@university.com', 3),
(104, 'Kumari', 'kumari@university.com', 4);
INSERT INTO Student VALUES
(201, 'Prasad', 'Male', '2007-06-28', 1),
(202, 'Apoorva', 'Female', '2006-04-15', 1),
(203, 'Lucky', 'Male', '2007-09-10', 2),
(204, 'Lokesh', 'Male', '2005-12-20', 3),
(205, 'Kumari', 'Female', '2006-07-05', 4);
INSERT INTO Course VALUES
(301, 'Database Management System', 4, 1, 101),
(302, 'Computer Networks', 3, 1, 101),
(303, 'Digital Electronics', 4, 2, 102),
(304, 'Thermodynamics', 3, 3, 103),
(305, 'Structural Engineering', 4, 4, 104);
INSERT INTO Enrollment VALUES
(401, 201, 301, '2026-06-10', 'A'),
(402, 202, 301, '2026-06-11', 'B'),
(403, 203, 303, '2026-06-12', 'A'),
(404, 204, 304, '2026-06-13', 'B'),
(405, 205, 305, '2026-06-14', 'A');
INSERT INTO Employee VALUES
(501, 'Apoorva', 1, 45000.00, '2023-06-15'),
(502, 'Lucky', 2, 50000.00, '2022-08-20'),
(503, 'Lokesh', 3, 55000.00, '2021-04-10'),
(504, 'Kumari', 1, 48000.00, '2024-01-12'),
(505, 'Prasad', 4, 52000.00, '2020-09-25');
INSERT INTO Employee VALUES
(506, 'Apoorva', 2, 47000.00, '2025-02-18');
SELECT * FROM Employee;
SELECT Employee_ID, Employee_Name, Salary
FROM Employee
WHERE Salary > 48000;
UPDATE Employee
SET Salary = 55000.00
WHERE Employee_ID = 501;
SELECT * FROM Employee
WHERE Employee_ID = 501;
DELETE FROM Employee
WHERE Employee_ID = 506;
SELECT * FROM Employee;
SELECT
    CURRENT_DATE() AS Current_Date,
    CURRENT_TIME() AS Current_Time,
    NOW() AS Current_Date_Time;
SELECT
    Student_Name,
    Date_of_Birth,
    YEAR(Date_of_Birth) AS Birth_Year,
    MONTH(Date_of_Birth) AS Birth_Month,
    DAY(Date_of_Birth) AS Birth_Day
FROM Student;
SELECT
    Employee_Name,
    Joining_Date,
    DATEDIFF(CURRENT_DATE(), Joining_Date) AS Days_Worked
FROM Employee;
SELECT
    Employee_Name,
    Joining_Date,
    DATE_ADD(Joining_Date, INTERVAL 1 YEAR) AS One_Year_Completed
FROM Employee;
SELECT COUNT(*) AS Total_Employees
FROM Employee;
SELECT SUM(Salary) AS Total_Salary
FROM Employee;
SELECT AVG(Salary) AS Average_Salary
FROM Employee;
SELECT MAX(Salary) AS Maximum_Salary
FROM Employee;
SELECT MIN(Salary) AS Minimum_Salary
FROM Employee;
SELECT
    Department_ID,
    COUNT(*) AS Employee_Count,
    AVG(Salary) AS Average_Salary
FROM Employee
GROUP BY Department_ID;

SELECT
    Department_ID,
    SUM(Salary) AS Total_Salary
FROM Employee
GROUP BY Department_ID;
SELECT
    Department.Department_ID,
    Department.Department_Name,
    Faculty.Faculty_ID,
    Faculty.Faculty_Name
FROM Department
NATURAL JOIN Faculty;
SELECT
    Student.Student_ID,
    Student.Student_Name,
    Department.Department_Name
FROM Student
JOIN Department
ON Student.Department_ID = Department.Department_ID;
SELECT
    Course.Course_ID,
    Course.Course_Name,
    Faculty.Faculty_Name
FROM Course
INNER JOIN Faculty
ON Course.Faculty_ID = Faculty.Faculty_ID;
SELECT
    Student.Student_ID,
    Student.Student_Name,
    Enrollment.Course_ID,
    Enrollment.Grade
FROM Student
INNER JOIN Enrollment
ON Student.Student_ID = Enrollment.Student_ID;
SELECT
    Department.Department_Name,
    Faculty.Faculty_Name
FROM Department
LEFT OUTER JOIN Faculty
ON Department.Department_ID = Faculty.Department_ID;
SELECT
    Faculty.Faculty_Name,
    Department.Department_Name
FROM Faculty
RIGHT OUTER JOIN Department
ON Faculty.Department_ID = Department.Department_ID;