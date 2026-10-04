CREATE DATABASE CollegeDB4;

USE CollegeDB4;

CREATE TABLE Employee (
    Employee_ID INT PRIMARY KEY,
    Employee_Name VARCHAR(50),
    Salary DECIMAL(10,2),
    Department VARCHAR(50)
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

INSERT INTO Employee VALUES
(101, 'David', 60000, 'IT'),
(102, 'Ravi', 45000, 'CSE'),
(103, 'Priya', 50000, 'HR'),
(104, 'Anil', 40000, 'Finance');
INSERT INTO Student VALUES
(1, 'Rahul'),
(2, 'Sneha'),
(3, 'Kiran'),
(4, 'Anu'),
(5, 'Ravi');
INSERT INTO Course VALUES
(201, 'DBMS'),
(202, 'Python'),
(203, 'Java');
INSERT INTO Enrollment VALUES
(1, 1, 201),
(2, 2, 201),
(3, 3, 202),
(4, 4, 203),
(5, 5, 201);

SELECT *
FROM Employee
WHERE Salary < (
    SELECT Salary
    FROM Employee
    WHERE Employee_Name = 'David'
);

CREATE VIEW Employee_View AS
SELECT Employee_ID, Employee_Name, Salary, Department
FROM Employee;
SELECT *
FROM Employee_View;
SELECT Course.Course_ID,
       Course.Course_Name,
       COUNT(Enrollment.Student_ID) AS Student_Count
FROM Course
LEFT JOIN Enrollment
ON Course.Course_ID = Enrollment.Course_ID
GROUP BY Course.Course_ID, Course.Course_Name;
CREATE USER 'college_user'@'localhost' IDENTIFIED BY 'College@123';
GRANT SELECT, INSERT
ON CollegeDB4.*
TO 'college_user'@'localhost';
REVOKE INSERT
ON CollegeDB4.*
FROM 'college_user'@'localhost';