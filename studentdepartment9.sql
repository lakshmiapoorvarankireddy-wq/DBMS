CREATE DATABASE CollegeDB5;
USE CollegeDB5;
CREATE TABLE Department (
    Department_ID INT PRIMARY KEY,
    Department_Name VARCHAR(50)
);

CREATE TABLE Student (
    Student_ID INT PRIMARY KEY,
    Student_Name VARCHAR(50),
    Department_ID INT,
    FOREIGN KEY (Department_ID) REFERENCES Department(Department_ID)
);

CREATE TABLE Employee (
    Employee_ID INT PRIMARY KEY,
    Employee_Name VARCHAR(50),
    Salary DECIMAL(10,2),
    Department VARCHAR(50)
);

CREATE TABLE Course_A (
    Student_ID INT
);

CREATE TABLE Course_B (
    Student_ID INT
);

INSERT INTO Department VALUES
(1, 'CSE'),
(2, 'IT'),
(3, 'ECE');

INSERT INTO Student VALUES
(101, 'Ravi', 1),
(102, 'Priya', 1),
(103, 'Anil', 2),
(104, 'Sneha', 2),
(105, 'Kiran', 3);

INSERT INTO Employee VALUES
(201, 'Rahul', 45000, 'CSE'),
(202, 'David', 60000, 'IT'),
(203, 'Anu', 50000, 'HR'),
(204, 'Kiran', 40000, 'CSE');

INSERT INTO Course_A VALUES
(101),
(102),
(103),
(104);

INSERT INTO Course_B VALUES
(103),
(104),
(105);

SELECT Department.Department_Name,
       COUNT(Student.Student_ID) AS Student_Count
FROM Department
LEFT JOIN Student
ON Department.Department_ID = Student.Department_ID
GROUP BY Department.Department_ID, Department.Department_Name;

DELETE FROM Employee
WHERE Employee_ID = 204;

SELECT Department,
       COUNT(*) AS Employee_Count,
       SUM(Salary) AS Total_Salary,
       AVG(Salary) AS Average_Salary,
       MIN(Salary) AS Minimum_Salary,
       MAX(Salary) AS Maximum_Salary
FROM Employee
GROUP BY Department
HAVING AVG(Salary) > 45000;
SELECT Student_ID
FROM Course_A
UNION
SELECT Student_ID
FROM Course_B;
SELECT Course_A.Student_ID
FROM Course_A
INNER JOIN Course_B
ON Course_A.Student_ID = Course_B.Student_ID;
SELECT Student_ID
FROM Course_A
WHERE Student_ID NOT IN (
    SELECT Student_ID
    FROM Course_B
);