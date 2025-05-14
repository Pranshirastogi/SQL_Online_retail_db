/*
==================================================================================
We'll develop a project for a "Fictional Online Retail Company". 
This project will cover creating a database, tables, and indexes, inserting data,
and writing various queries for reporting and data analysis.
==================================================================================

Project Overview: Fictional Online Retail Company
--------------------------------------
A.	Database Design
	-- Database Name: OnlineRetailDB

B.	Tables:
	-- Customers: Stores customer details.
	-- Products: Stores product details.
	-- Orders: Stores order details.
	-- OrderItems: Stores details of each item in an order.
	-- Categories: Stores product categories.

C.	Insert Sample Data:
	-- Populate each table with sample data.

D. Write Queries:
	-- Retrieve data (e.g., customer orders, popular products).
	-- Perform aggregations (e.g., total sales, average order value).
	-- Join tables for comprehensive reports.
	-- Use subqueries and common table expressions (CTEs).
*/

/* LET'S GET STARTED */

-- Create the database
CREATE DATABASE OnlineRetailDB;

-- Use the database
USE OnlineRetailDB;

-- Create the Customers table
CREATE TABLE Customers (
	CustomerID INT AUTO_INCREMENT PRIMARY KEY  ,
	FirstName VARCHAR(50),
	LastName VARCHAR(50),
	Email VARCHAR(100),
	Phone VARCHAR(50),
	Address VARCHAR(255),
	City VARCHAR(50),
	State VARCHAR(50),
	ZipCode VARCHAR(50),
	Country VARCHAR(50),
	CreatedAt DATETIME DEFAULT NOW()
);

-- Create the Products table
CREATE TABLE Products (
	ProductID INT AUTO_INCREMENT PRIMARY KEY ,
	ProductName VARCHAR(100),
	CategoryID INT,
	Price DECIMAL(10,2),
	Stock INT,
	CreatedAt DATETIME DEFAULT NOW()
);

-- Create the Categories table
CREATE TABLE Categories (
	CategoryID INT AUTO_INCREMENT PRIMARY KEY ,
	CategoryName VARCHAR(100),
	Description VARCHAR(255)
);

-- Create the Orders table
CREATE TABLE Orders (
	OrderId INT AUTO_INCREMENT PRIMARY KEY ,
	CustomerId INT,
	OrderDate DATETIME DEFAULT NOW(),
	TotalAmount DECIMAL(10,2),
	FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

ALTER TABLE Orders 
RENAME COLUMN OrderId TO OrderID;

ALTER TABLE Orders 
RENAME COLUMN CustomerId TO CustomerID;

-- Create the OrderItems table
CREATE TABLE OrderItems (
	OrderItemID INT AUTO_INCREMENT PRIMARY KEY,
	OrderID INT,
	ProductID INT,
	Quantity INT,
	Price DECIMAL(10,2),
	FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
	FOREIGN KEY (OrderId) REFERENCES Orders(OrderID)
);

show tables;
-- Insert sample data into Categories table
INSERT INTO Categories (CategoryName, Description) 
VALUES 
('Electronics', 'Devices and Gadgets'),
('Clothing', 'Apparel and Accessories'),
('Books', 'Printed and Electronic Books');

select*from Categories;

-- Insert sample data into Products table
INSERT INTO Products(ProductName, CategoryID, Price, Stock)
VALUES 
('Smartphone', 1, 699.99, 50),
('Laptop', 1, 999.99, 30),
('T-shirt', 2, 19.99, 100),
('Jeans', 2, 49.99, 60),
('Fiction Novel', 3, 14.99, 200),
('Science Journal', 3, 29.99, 150);

SELECT*FROM PRODUCTS;

-- Insert sample data into Customers table
INSERT INTO Customers(FirstName, LastName, Email, Phone, Address, City, State, ZipCode, Country)
VALUES 
('Sameer', 'Khanna', 'sameer.khanna@example.com', '123-456-7890', '123 Elm St.', 'Springfield', 
'IL', '62701', 'USA'),
('Jane', 'Smith', 'jane.smith@example.com', '234-567-8901', '456 Oak St.', 'Madison', 
'WI', '53703', 'USA'),
('harshad', 'patel', 'harshad.patel@example.com', '345-678-9012', '789 Dalal St.', 'Mumbai', 
'Maharashtra', '41520', 'INDIA');

SELECT*FROM CUSTOMERS;

-- Insert sample data into Orders table
INSERT INTO Orders(CustomerId, OrderDate, TotalAmount)
VALUES 
(1, NOW(), 719.98),
(2, NOW(), 49.99),
(3, NOW(), 44.98);

SELECT*FROM ORDERS;

-- Insert sample data into OrderItems table
INSERT INTO OrderItems(OrderID, ProductID, Quantity, Price)
VALUES 
(1, 1, 1, 699.99),
(1, 3, 1, 19.99),
(2, 4, 1,  49.99),
(3, 5, 1, 14.99),
(3, 6, 1, 29.99);

SELECT*FROM ORDERITEMS;
