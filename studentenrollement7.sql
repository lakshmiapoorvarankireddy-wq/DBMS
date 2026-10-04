CREATE DATABASE CollegeDB3;

USE CollegeDB3;

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
    Grade CHAR(2),
    FOREIGN KEY (Student_ID) REFERENCES Student(Student_ID),
    FOREIGN KEY (Course_ID) REFERENCES Course(Course_ID)
);

CREATE TABLE Department (
    Department_ID INT PRIMARY KEY,
    Department_Name VARCHAR(50)
);

CREATE TABLE Employee (
    Employee_ID INT PRIMARY KEY,
    Employee_Name VARCHAR(50),
    City VARCHAR(50),
    Salary DECIMAL(10,2),
    Department_ID INT,
    FOREIGN KEY (Department_ID) REFERENCES Department(Department_ID)
);

INSERT INTO Student VALUES
(1, 'Ravi'),
(2, 'Priya'),
(3, 'Anil');

INSERT INTO Course VALUES
(101, 'DBMS'),
(102, 'Python'),
(103, 'Java');

INSERT INTO Enrollment VALUES
(1, 1, 101, 'A'),
(2, 2, 102, 'B'),
(3, 3, 103, 'A+');

INSERT INTO Department VALUES
(1, 'CSE'),
(2, 'IT'),
(3, 'Finance');

INSERT INTO Employee VALUES
(201, 'Rahul', 'Hyderabad', 45000, 1),
(202, 'Sneha', 'Vijayawada', 50000, 2),
(203, 'Kiran', 'Chennai', 40000, 3);

SELECT Student.Student_Name, Course.Course_Name, Enrollment.Grade
FROM Enrollment
INNER JOIN Student
ON Enrollment.Student_ID = Student.Student_ID
INNER JOIN Course
ON Enrollment.Course_ID = Course.Course_ID;

UPDATE Employee
SET City = 'Bangalore'
WHERE Employee_ID = 201;

SELECT Employee_Name,
       ROUND(Salary, 0) AS Rounded_Salary,
       ABS(Salary - 50000) AS Salary_Difference,
       MOD(Salary, 10000) AS Salary_Remainder
FROM Employee;

SELECT CURDATE() AS Current_Date,
       CURTIME() AS Current_Time,
       NOW() AS Current_Date_Time;

SELECT Department.Department_Name,
       Employee.Employee_Name,
       Employee.City,
       Employee.Salary
FROM Department
INNER JOIN Employee
ON Department.Department_ID = Employee.Department_ID;

SELECT Department.Department_Name,
       Employee.Employee_Name
FROM Department
LEFT JOIN Employee
ON Department.Department_ID = Employee.Department_ID;