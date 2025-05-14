USE ONLINERETAILDB;

/*
===========================
LOG MAINTENANCE
===========================
Let's create additional queries that involve updating, deleting, and maintaining logs of these operations 
in the OnlineRetailDB database. 

To automatically log changes in the database, you can use triggers in SQL Server. 
Triggers are special types of stored procedures that automatically execute in response 
to certain events on a table, such as INSERT, UPDATE, or DELETE.

Here’s how you can create triggers to log INSERT, UPDATE, and DELETE operations 
for the tables in the OnlineRetailDB.

We'll start by adding a table to keep logs of updates and deletions.

Step 1: Create a Log Table
Step 2: Create Triggers for Each Table
	
	A. Triggers for Products Table
		-- Trigger for INSERT on Products table
		-- Trigger for UPDATE on Products table
		-- Trigger for DELETE on Products table

	B. Triggers for Customers Table
		-- Trigger for INSERT on Customers table
		-- Trigger for UPDATE on Customers table
		-- Trigger for DELETE on Customers table
*/

CREATE TABLE ChangeLog (
	LogID INT AUTO_INCREMENT PRIMARY KEY,
	TableName VARCHAR(50),
	Operation VARCHAR(10),
	RecordID INT,
	ChangeDate DATETIME DEFAULT NOW(),
	ChangedBy VARCHAR(100)
);

-- A. Triggers for Products Table
DELIMITER //

CREATE TRIGGER TRG_Insert_Product
AFTER INSERT ON PRODUCTS
FOR EACH ROW
BEGIN
	INSERT INTO ChangeLog (TableName, Operation, RecordID, ChangedBy)
	VALUES( 'Products', 'INSERT', NEW.ProductID, USER());
END;
//

CREATE TRIGGER trg_Update_Product
AFTER UPDATE ON Products
FOR EACH ROW
BEGIN
  INSERT INTO ChangeLog (TableName, Operation, RecordID, ChangedBy)
  VALUES ('Products', 'UPDATE', NEW.ProductID, USER());
END;
//

CREATE TRIGGER trg_Delete_Product
AFTER DELETE ON Products
FOR EACH ROW
BEGIN
  INSERT INTO ChangeLog (TableName, Operation, RecordID, ChangedBy)
  VALUES ('Products', 'DELETE', OLD.ProductID, USER());
END;
//

DELIMITER ;

-- Try to insert one record into the Products table
INSERT INTO Products(ProductName, CategoryID, Price, Stock)
VALUES ('Wireless Mouse', 1, 4.99, 20);

INSERT INTO Products(ProductName, CategoryID, Price, Stock)
VALUES ('Spiderman Multiverse Comic', 3, 2.50, 150);

-- Display products table
SELECT * FROM Products;

-- Display ChangeLog table
SELECT * FROM ChangeLog;

-- Try to update any record from Products table
UPDATE Products SET Price = Price - 300 WHERE ProductID = 2;

-- Try to delete an existing record to see the effect of Trigger
DELETE FROM Products WHERE ProductID = 11;

-- B. Triggers for Customers Table

DELIMITER //

CREATE TRIGGER trg_Insert_Customers
AFTER INSERT ON Customers
FOR EACH ROW
BEGIN
  INSERT INTO ChangeLog (TableName, Operation, RecordID, ChangedBy)
  VALUES ('Customers', 'INSERT', NEW.CustomerID, USER());
END;
//

CREATE TRIGGER trg_Update_Customers
AFTER UPDATE ON Customers
FOR EACH ROW
BEGIN
  INSERT INTO ChangeLog (TableName, Operation, RecordID, ChangedBy)
  VALUES ('Customers', 'UPDATE', NEW.CustomerID, USER());
END;
//

CREATE TRIGGER trg_Delete_Customers
AFTER DELETE ON Customers
FOR EACH ROW
BEGIN
  INSERT INTO ChangeLog (TableName, Operation, RecordID, ChangedBy)
  VALUES ('Customers', 'DELETE', OLD.CustomerID, USER());
END;
//

DELIMITER ;

-- Example insert
INSERT INTO Customers(FirstName, LastName, Email, Phone, Address, City, State, ZipCode, Country)
VALUES ('Virat', 'Kohli', 'virat.kingkohli@example.com', '123-456-7890', 'South Delhi', 'Delhi', 
'Delhi', '5456665', 'INDIA');

-- Example update
UPDATE Customers SET State = 'Florida' WHERE State = 'IL';

-- Example delete
DELETE FROM Customers WHERE CustomerID = 5;