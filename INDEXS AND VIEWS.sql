USE ONLINERETAILDB;

/*
===============================
Implementing Indexes
===============================

Indexes are crucial for optimizing the performance of your SQL Server database, 
especially for read-heavy operations like SELECT queries. 

Let's create indexes for the OnlineRetailDB database to improve query performance.
*/
-- A. Indexes on Categories Table
-- 1. Clustered Index on CategoryID: Usually created with the primary key.

/*
B. Indexes on Products Table
	1. Clustered Index on ProductID: This is usually created automatically when 
	   the primary key is defined.
	2. Non-Clustered Index on CategoryID: To speed up queries filtering by CategoryID.
	3. Non-Clustered Index on Price: To speed up queries filtering or sorting by Price.
*/
-- Non-Clustered Index on CategoryID: To speed up queries filtering by CategoryID.
CREATE INDEX IDX_Products_CategoryID
ON Products(CategoryID);

-- Non-Clustered Index on Price: To speed up queries filtering or sorting by Price.
CREATE INDEX IDX_Products_Price
ON PRODUCTS(PRICE);

/*
C. Indexes on Orders Table
	1. Clustered Index on OrderID: Usually created with the primary key.
	2. Non-Clustered Index on CustomerID: To speed up queries filtering by CustomerID.
	3. Non-Clustered Index on OrderDate: To speed up queries filtering or sorting by OrderDate.
*/

-- Clustered Index on OrderID: Usually created with the primary key.
CREATE INDEX IDX_ORDERS_ORDERID
ON ORDERS(ORDERID);

-- Non-Clustered Index on CustomerID: To speed up queries filtering by CustomerID.
CREATE INDEX IDX_ORDERS_CUSTOMERID
ON ORDERS(CUSTOMERID);	

-- Non-Clustered Index on OrderDate: To speed up queries filtering or sorting by OrderDate.
CREATE INDEX IDX_ORDERS_ORDERDATE
ON ORDERS(ORDERDATE);

/*
D. Indexes on OrderItems Table
	1. Clustered Index on OrderItemID: Usually created with the primary key.
	2. Non-Clustered Index on OrderID: To speed up queries filtering by OrderID.
	3. Non-Clustered Index on ProductID: To speed up queries filtering by ProductID.
*/

-- Clustered Index on OrderItemID: Usually created with the primary key.
CREATE INDEX IDX_ORDERITEMS_ORDERITEMID
ON ORDERITEMS(ORDERITEMID);

-- Non-Clustered Index on OrderID: To speed up queries filtering by OrderID.
CREATE INDEX IDX_ORDERITEMS_ORDERID
ON ORDERITEMS(ORDERID);

-- Non-Clustered Index on ProductID: To speed up queries filtering by ProductID.
CREATE INDEX IDX_ORDERITEMS_PRODUCTID
ON ORDERITEMS(PRODUCTID);

/*

E. Indexes on Customers Table
	1. Clustered Index on CustomerID: Usually created with the primary key.
	2. Non-Clustered Index on Email: To speed up queries filtering by Email.
	3. Non-Clustered Index on Country: To speed up queries filtering by Country.
*/

-- Clustered Index on CustomerID: Usually created with the primary key.
CREATE INDEX IDX_CUSTOMERS_CUSTOMERID
ON CUSTOMERS(CUSTOMERID);

-- Non-Clustered Index on Email: To speed up queries filtering by Email.
CREATE INDEX IDX_CUSTOMERS_EMAIL
ON CUSTOMERS(EMAIL);

-- Non-Clustered Index on Country: To speed up queries filtering by Country.
CREATE INDEX IDX_CUSTOMERS_COUNTRY
ON CUSTOMERS(COUNTRY);

/*
===============================
Implementing Views
===============================

	Views are virtual tables that represent the result of a query. 
	They can simplify complex queries and enhance security by restricting access to specific data.

*/

-- View for Product Details: A view combining product details with category names.
CREATE VIEW vw_ProductDetails AS
SELECT P.PRODUCTID, P.PRODUCTNAME, P.PRICE, P.STOCK, C.CATEGORYNAME
FROM PRODUCTS P INNER JOIN CATEGORIES C
USING (CATEGORYID);

SELECT*FROM VW_PRODUCTDETAILS;

-- View for Customer Orders : A view to get a summary of orders placed by each customer.
CREATE VIEW vw_CustomerOreders
AS
SELECT C.CUSTOMERID, C.FIRSTNAME, C.LASTNAME, COUNT(O.ORDERID) AS TOTALORDERS,
SUM(OI.QUANTITY * P.PRICE) AS TOTALAMOUNT
FROM CUSTOMERS C
INNER JOIN ORDERS O USING (CUSTOMERID)
INNER JOIN ORDERITEMS OI USING (ORDERID)
INNER JOIN PRODUCTS P USING (PRODUCTID)
GROUP BY C.CUSTOMERID, C.FIRSTNAME, C.LASTNAME;

-- View for Recent Orders: A view to display orders placed in the last 30 days.
CREATE VIEW vw_RecentOreders
AS
SELECT O.ORDERID, O.ORDERDATE, C.CUSTOMERID, C.FIRSTNAME, C.LASTNAME,
SUM(OI.QUANTITY * OI.PRICE) AS ORDERAMOUNT
FROM CUSTOMERS C
INNER JOIN ORDERS O USING (CUSTOMERID)
INNER JOIN ORDERITEMS OI USING (ORDERID)
GROUP BY O.ORDERID, O.ORDERID, C.CUSTOMERID, C.FIRSTNAME, C.LASTNAME;

-- Query 31: Retrieve All Products with Category Names
-- Using the vw_ProductDetails view to get a list of all products along with their category names.
SELECT*FROM VW_PRODUCTDETAILS;

-- Query 32: Retrieve Products within a Specific Price Range
-- Using the vw_ProductDetails view to find products priced between $10 and $30.
SELECT*FROM VW_PRODUCTDETAILS WHERE PRICE BETWEEN 10 AND 30;

-- Query 33: Count the Number of Products in Each Category
-- Using the vw_ProductDetails view to count the number of products in each category
SELECT CATEGORYNAME, COUNT(PRODUCTID) AS PRODUCTCOUNT
FROM VW_PRODUCTDETAILS GROUP BY CATEGORYNAME;

-- Query34: Retrieve Customers with More Than 1 Orders
-- Using the vw_CustomerOrders view to find customers who have placed more than 1 orders.
SELECT*FROM VW_CUSTOMEROREDERS WHERE TOTALORDERS >1;

-- Query 35: Retrieve the Total Amount Spent by Each Customer
-- Using the vw_CustomerOrders view to get the total amount spent by each customer.
SELECT  CUSTOMERID, FIRSTNAME, LASTNAME, SUM(TOTALAMOUNT) AS TOTALSPEND
FROM VW_CUSTOMEROREDERS 
GROUP BY CUSTOMERID, FIRSTNAME, LASTNAME
ORDER BY TOTALSPEND DESC;

-- Query 36: Retrieve Recent Orders Above a Certain Amount
-- Using the vw_RecentOrders view to find recent orders where the total amount is greater than $1000.
SELECT * FROM VW_RECENTOREDERS WHERE ORDERAMOUNT > 1000;

-- Query 37: Retrieve the Latest Order for Each Customer
-- Using the vw_RecentOrders view to find the latest order placed by each customer.
SELECT RO.ORDERID, RO.ORDERDATE, RO.CUSTOMERID, RO.FIRSTNAME, RO.LASTNAME, RO.ORDERAMOUNT
FROM VW_RECENTOREDERS RO
INNER JOIN (
SELECT CUSTOMERID, MAX(ORDERDATE) AS LATESTORDERDATE 
FROM VW_RECENTOREDERS
GROUP BY CUSTOMERID) LATEST
ON RO.CUSTOMERID = LATEST.CUSTOMERID AND RO.ORDERDATE = LATEST.LATESTORDERDATE
ORDER BY RO.ORDERDATE DESC;

-- Query 38: Retrieve Products in a Specific Category
-- Using the vw_ProductDetails view to get all products in a specific category, such as 'Electronics'.
SELECT * FROM VW_PRODUCTDETAILS WHERE CATEGORYNAME = 'ELECTRONICS';

-- Query 39: Retrieve Orders Placed in the Last 7 Days
-- Using the vw_RecentOrders view to find orders placed in the last 7 days.
SELECT * FROM VW_RECENTOREDERS WHERE ORDERDATE >= NOW() - INTERVAL 7 DAY;

-- Query 40: Retrieve Products Sold in the Last Month
SELECT P.PRODUCTID, P.PRODUCTNAME, SUM(OI.QUANTITY) AS TOTALSOLD
FROM VW_RECENTOREDERS RO
INNER JOIN ORDERITEMS OI ON RO.ORDERID = OI.ORDERID
INNER JOIN PRODUCTS P ON OI.PRODUCTID = P.PRODUCTID
WHERE RO.ORDERDATE >= DATE_SUB(NOW(), INTERVAL 1 MONTH)
GROUP BY P.PRODUCTID, P.PRODUCTNAME
ORDER BY TOTALSOLD DESC;







