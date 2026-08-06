-- Create Database
CREATE DATABASE PharmacyDB;

-- Use Database
USE PharmacyDB;

-- Create Medicines Table
CREATE TABLE Medicines (
    MedicineID INT PRIMARY KEY,
    MedicineName VARCHAR(50),
    Category VARCHAR(30),
    Price DECIMAL(8,2),
    Stock INT
);

-- Create Customers Table
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(50),
    Phone VARCHAR(15),
    City VARCHAR(30)
);

-- Create Sales Table
CREATE TABLE Sales (
    SaleID INT PRIMARY KEY,
    CustomerID INT,
    MedicineID INT,
    Quantity INT,
    SaleDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (MedicineID) REFERENCES Medicines(MedicineID)
);

-- Insert Data into Medicines
INSERT INTO Medicines VALUES
(101,'Paracetamol','Tablet',50.00,100),
(102,'Amoxicillin','Capsule',120.00,80),
(103,'Cetirizine','Tablet',40.00,150),
(104,'Cough Syrup','Syrup',90.00,60),
(105,'Vitamin C','Tablet',70.00,120);

-- Insert Data into Customers
INSERT INTO Customers VALUES
(1,'Rahul','9876543210','Hyderabad'),
(2,'Priya','9876543211','Vijayawada'),
(3,'Kiran','9876543212','Guntur'),
(4,'Anjali','9876543213','Rajahmundry');

-- Insert Data into Sales
INSERT INTO Sales VALUES
(1001,1,101,2,'2026-08-01'),
(1002,2,104,1,'2026-08-02'),
(1003,3,102,3,'2026-08-03'),
(1004,4,105,2,'2026-08-04');

-- Display Medicines
SELECT * FROM Medicines;

-- Display Customers
SELECT * FROM Customers;

-- Display Sales
SELECT * FROM Sales;

-- Medicines with Stock Greater Than 100
SELECT * FROM Medicines
WHERE Stock > 100;

-- Customers from Hyderabad
SELECT * FROM Customers
WHERE City='Hyderabad';

-- Join Query
SELECT
    Sales.SaleID,
    Customers.CustomerName,
    Medicines.MedicineName,
    Sales.Quantity,
    Sales.SaleDate
FROM Sales
JOIN Customers
ON Sales.CustomerID = Customers.CustomerID
JOIN Medicines
ON Sales.MedicineID = Medicines.MedicineID;

-- Total Quantity Sold
SELECT SUM(Quantity) AS Total_Medicines_Sold
FROM Sales;

-- Average Medicine Price
SELECT AVG(Price) AS Average_Price
FROM Medicines;

-- Update Medicine Stock
UPDATE Medicines
SET Stock = 95
WHERE MedicineID = 101;

-- Delete a Customer
DELETE FROM Customers
WHERE CustomerID = 4;