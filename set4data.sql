DROP DATABASE IF EXISTS UniversityDB;
CREATE DATABASE UniversityDB;
USE UniversityDB;
CREATE TABLE Department (
    Department_ID INT PRIMARY KEY,
    Department_Name VARCHAR(50) NOT NULL
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
    Department_ID INT,
    FOREIGN KEY (Department_ID) REFERENCES Department(Department_ID)
);

CREATE TABLE Course (
    Course_ID INT PRIMARY KEY,
    Course_Name VARCHAR(50) NOT NULL,
    Department_ID INT,
    FOREIGN KEY (Department_ID) REFERENCES Department(Department_ID)
);

CREATE TABLE Enrollment (
    Enrollment_ID INT PRIMARY KEY,
    Student_ID INT,
    Course_ID INT,
    FOREIGN KEY (Student_ID) REFERENCES Student(Student_ID),
    FOREIGN KEY (Course_ID) REFERENCES Course(Course_ID)
);

INSERT INTO Department VALUES
(1, 'Computer Science'),
(2, 'Electronics'),
(3, 'Mechanical'),
(4, 'Civil');

INSERT INTO Employee VALUES
(201, 'Apoorva', 1, 45000),
(202, 'Lucky', 2, 60000),
(203, 'Lokesh', 3, 55000),
(204, 'Kumari', 1, 48000),
(205, 'Prasad', 4, 60000),
(206, 'Apoorva', 2, 52000);

INSERT INTO Student VALUES
(101, 'Apoorva', 1),
(102, 'Lucky', 1),
(103, 'Lokesh', 2),
(104, 'Kumari', 3),
(105, 'Prasad', 4);

INSERT INTO Course VALUES
(301, 'DBMS', 1),
(302, 'Python', 1),
(303, 'Computer Networks', 1),
(304, 'Electronics', 2);

INSERT INTO Enrollment VALUES
(401, 101, 301),
(402, 102, 301),
(403, 103, 304),
(404, 104, 302),
(405, 105, 301);

SELECT *
FROM Employee
WHERE Salary = (
    SELECT MAX(Salary)
    FROM Employee
);
CREATE VIEW Employee_Details AS
SELECT Employee_ID, Employee_Name, Department_ID, Salary
FROM Employee;
SELECT *
FROM Employee_Details;
SELECT S.Student_ID, S.Student_Name, C.Course_Name
FROM Student S
JOIN Enrollment E ON S.Student_ID = E.Student_ID
JOIN Course C ON E.Course_ID = C.Course_ID
WHERE C.Course_Name = 'DBMS';
GRANT SELECT, INSERT ON UniversityDB.Employee TO 'root'@'localhost';
REVOKE INSERT ON UniversityDB.Employee FROM 'root'@'localhost';