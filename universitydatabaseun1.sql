-- UNIVERSITY DATABASE MANAGEMENT SYSTEM
CREATE DATABASE UniversityDB;
USE UniversityDB;
CREATE TABLE Department (
    Department_ID INT PRIMARY KEY,
    Department_Name VARCHAR(100) NOT NULL,
    HOD_Name VARCHAR(100)
);
CREATE TABLE Student (
    Student_ID INT PRIMARY KEY,
    Student_Name VARCHAR(100) NOT NULL,
    DOB DATE,
    Email VARCHAR(100),
    Department_ID INT,
    FOREIGN KEY (Department_ID)
        REFERENCES Department(Department_ID)
);
CREATE TABLE Faculty (
    Faculty_ID INT PRIMARY KEY,
    Faculty_Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100),
    Department_ID INT,
    FOREIGN KEY (Department_ID)
        REFERENCES Department(Department_ID)
);
CREATE TABLE Course (
    Course_ID INT PRIMARY KEY,
    Course_Name VARCHAR(100) NOT NULL,
    Credits INT,
    Department_ID INT,
    Faculty_ID INT,
    FOREIGN KEY (Department_ID)
        REFERENCES Department(Department_ID),
    FOREIGN KEY (Faculty_ID)
        REFERENCES Faculty(Faculty_ID)
);
CREATE TABLE Enrollment (
    Enrollment_ID INT PRIMARY KEY,
    Student_ID INT,
    Course_ID INT,
    Enrollment_Date DATE,
    FOREIGN KEY (Student_ID)
        REFERENCES Student(Student_ID),
    FOREIGN KEY (Course_ID)
        REFERENCES Course(Course_ID)
);
CREATE TABLE Result (
    Result_ID INT PRIMARY KEY,
    Student_ID INT,
    Course_ID INT,
    Marks INT,
    Grade VARCHAR(5),
    FOREIGN KEY (Student_ID)
        REFERENCES Student(Student_ID),
    FOREIGN KEY (Course_ID)
        REFERENCES Course(Course_ID)
);
INSERT INTO Department VALUES
(101, 'Computer Science', 'Dr. Ravi'),
(102, 'Information Technology', 'Dr. Kumar'),
(103, 'Electronics', 'Dr. Priya'),
(104, 'Mechanical Engineering', 'Dr. Suresh');
INSERT INTO Student VALUES
(1, 'Apoorva', '2007-06-28', 'apoorva@gmail.com', 101),
(2, 'Anjali', '2006-08-15', 'anjali@gmail.com', 101),
(3, 'Rahul', '2006-11-20', 'rahul@gmail.com', 102),
(4, 'Kiran', '2007-01-10', 'kiran@gmail.com', 103),
(5, 'Sneha', '2006-05-25', 'sneha@gmail.com', 104);
INSERT INTO Faculty VALUES
(201, 'Dr. Ramesh', 'ramesh@university.com', 101),
(202, 'Dr. Lakshmi', 'lakshmi@university.com', 102),
(203, 'Dr. Arun', 'arun@university.com', 103),
(204, 'Dr. Meena', 'meena@university.com', 104);
INSERT INTO Course VALUES
(301, 'Database Management Systems', 4, 101, 201),
(302, 'Data Structures', 4, 101, 201),
(303, 'Computer Networks', 3, 102, 202),
(304, 'Digital Electronics', 4, 103, 203),
(305, 'Thermodynamics', 4, 104, 204);
INSERT INTO Enrollment VALUES
(401, 1, 301, '2026-07-01'),
(402, 1, 302, '2026-07-01'),
(403, 2, 301, '2026-07-02'),
(404, 3, 303, '2026-07-03'),
(405, 4, 304, '2026-07-04'),
(406, 5, 305, '2026-07-05');
INSERT INTO Result VALUES
(501, 1, 301, 92, 'A+'),
(502, 1, 302, 88, 'A'),
(503, 2, 301, 85, 'A'),
(504, 3, 303, 78, 'B+'),
(505, 4, 304, 90, 'A+'),
(506, 5, 305, 75, 'B');
SELECT * FROM Department;
SELECT * FROM Student;
SELECT * FROM Faculty;
SELECT * FROM Course;
SELECT * FROM Enrollment;
SELECT * FROM Result;
SELECT *
FROM Student
WHERE Department_ID = 101;
SELECT *
FROM Result
WHERE Marks > 80;
SELECT *
FROM Course
WHERE Credits = 4;
SELECT 
    Student.Student_ID,
    Student.Student_Name,
    Department.Department_Name
FROM Student
INNER JOIN Department
ON Student.Department_ID = Department.Department_ID;
SELECT
    Student.Student_Name,
    Course.Course_Name,
    Enrollment.Enrollment_Date
FROM Enrollment
JOIN Student
ON Enrollment.Student_ID = Student.Student_ID
JOIN Course
ON Enrollment.Course_ID = Course.Course_ID;
SELECT
    Student.Student_Name,
    Course.Course_Name,
    Result.Marks,
    Result.Grade
FROM Result
JOIN Student
ON Result.Student_ID = Student.Student_ID
JOIN Course
ON Result.Course_ID = Course.Course_ID;
-- Average marks
SELECT AVG(Marks) AS Average_Marks
FROM Result;

-- Highest marks
SELECT MAX(Marks) AS Highest_Marks
FROM Result;
-- Lowest marks
SELECT MIN(Marks) AS Lowest_Marks
FROM Result;
-- Total number of students
SELECT COUNT(*) AS Total_Students
FROM Student;
SELECT
    Department_ID,
    COUNT(*) AS Number_of_Students
FROM Student
GROUP BY Department_ID;

CREATE VIEW Student_Result_View AS
SELECT
    Student.Student_Name,
    Course.Course_Name,
    Result.Marks,
    Result.Grade
FROM Result
JOIN Student
ON Result.Student_ID = Student.Student_ID
JOIN Course
ON Result.Course_ID = Course.Course_ID;
-- Display View
SELECT * FROM Student_Result_View;
UPDATE Student
SET Email = 'apoorva123@gmail.com'
WHERE Student_ID = 1;
-- Example:
-- DELETE FROM Student
-- WHERE Student_ID = 5;
SELECT *
FROM Result
ORDER BY Marks DESC;
SELECT
    Student.Student_ID,
    Student.Student_Name,
    Department.Department_Name,
    Course.Course_Name,
    Result.Marks,
    Result.Grade
FROM Student
JOIN Department
ON Student.Department_ID = Department.Department_ID
JOIN Result
ON Student.Student_ID = Result.Student_ID
JOIN Course
ON Result.Course_ID = Course.Course_ID
ORDER BY Result.Marks DESC;