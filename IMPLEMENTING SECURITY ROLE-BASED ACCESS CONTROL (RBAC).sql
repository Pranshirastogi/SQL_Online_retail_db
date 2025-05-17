USE ONLINERETAILDB;

/*
=========================================================
Implementing Security / Role-Based Access Control (RBAC)
=========================================================

To manage access control in SQL Server, you'll need to use a combination of SQL Server's security features, 
such as logins, users, roles, and permissions. 

Here's a step-by-step guide on how to do this:

*/
-- Step 1: Create Users
CREATE USER 'SALESUSER'@'%' IDENTIFIED BY 'strongpassword';

-- Step 2: Create Roles
CREATE ROLE 'SALESROLE';
CREATE ROLE 'MARKETINGROLE';

-- Step 3: Grant Privileges to Roles
GRANT SELECT ON OnlineRetailDB.Customers TO 'SALESROLE';
GRANT INSERT, UPDATE ON OnlineRetailDB.Orders TO 'SALESROLE';
GRANT SELECT ON OnlineRetailDB.Products TO 'SALESROLE';

-- Step 4: Grant Roles to Users
GRANT 'SALESROLE' TO 'SALESUSER'@'%';

-- Step 5: Activate Roles (optional for session use)
-- You can set the default role for a user:
SET DEFAULT ROLE 'SALESROLE' TO 'SALESUSER'@'%';

-- Or a user can activate a role after login using:
-- SET ROLE 'SALESROLE';

-- Step 6: Revoke Permissions (if needed)
REVOKE INSERT ON OnlineRetailDB.Orders FROM 'SALESROLE';

-- Step 7: View User Grants (MySQL does not have fn_my_permissions)
-- Use this to check a user’s grants:
SHOW GRANTS FOR 'SALESUSER'@'%';

/*
=========================================================
MySQL Version: 20 Access Control Scenarios
=========================================================
*/

-- Scenario 1: Read-Only Access to All Tables
CREATE ROLE 'ReadOnlyRole';
GRANT SELECT ON OnlineRetailDB.* TO 'ReadOnlyRole';

-- Scenario 2: Data Entry Clerk (Insert Only on Orders and OrderItems)
CREATE ROLE 'DataEntryClerk';
GRANT INSERT ON OnlineRetailDB.Orders TO 'DataEntryClerk';
GRANT INSERT ON OnlineRetailDB.OrderItems TO 'DataEntryClerk';

-- Scenario 3: Product Manager (Full Access to Products and Categories)
CREATE ROLE 'ProductManagerRole';
GRANT SELECT, INSERT, UPDATE, DELETE ON OnlineRetailDB.Products TO 'ProductManagerRole';
GRANT SELECT, INSERT, UPDATE, DELETE ON OnlineRetailDB.Categories TO 'ProductManagerRole';

-- Scenario 4: Order Processor (Read and Update Orders)
CREATE ROLE 'OrderProcessorRole';
GRANT SELECT, UPDATE ON OnlineRetailDB.Orders TO 'OrderProcessorRole';

-- Scenario 5: Customer Support (Read Access to Customers and Orders)
CREATE ROLE 'CustomerSupportRole';
GRANT SELECT ON OnlineRetailDB.Customers TO 'CustomerSupportRole';
GRANT SELECT ON OnlineRetailDB.Orders TO 'CustomerSupportRole';

-- Scenario 6: Marketing Analyst (Read Access to All Tables, No DML)
CREATE ROLE 'MarketingAnalystRole';
GRANT SELECT ON OnlineRetailDB.* TO 'MarketingAnalystRole';

-- Scenario 7: Sales Analyst (Read Access to Orders and OrderItems)
CREATE ROLE 'SalesAnalystRole';
GRANT SELECT ON OnlineRetailDB.Orders TO 'SalesAnalystRole';
GRANT SELECT ON OnlineRetailDB.OrderItems TO 'SalesAnalystRole';

-- Scenario 8: Inventory Manager (Full Access to Products)
CREATE ROLE 'InventoryManagerRole';
GRANT SELECT, INSERT, UPDATE, DELETE ON OnlineRetailDB.Products TO 'InventoryManagerRole';

-- Scenario 9: Finance Manager (Read and Update Orders)
CREATE ROLE 'FinanceManagerRole';
GRANT SELECT, UPDATE ON OnlineRetailDB.Orders TO 'FinanceManagerRole';

-- Scenario 10: Database Backup Operator (Backup Database)
-- Not directly supported in MySQL, but can simulate with file access or use `mysqlbackup` tool

-- Scenario 11: Database Developer (Full Access to Schema Objects)
CREATE ROLE 'DatabaseDeveloperRole';
GRANT CREATE, ALTER, DROP ON OnlineRetailDB.* TO 'DatabaseDeveloperRole';

-- Scenario 12: Restricted Read Access (Read Only Specific Columns)
-- MySQL does not support column-level GRANT; workaround is to use views
-- Create a view with allowed columns and grant SELECT on that
CREATE VIEW OnlineRetailDB.CustomerPublicView AS 
SELECT FirstName, LastName, Email FROM OnlineRetailDB.Customers;

CREATE ROLE 'RestrictedReadRole';
GRANT SELECT ON OnlineRetailDB.CustomerPublicView TO 'RestrictedReadRole';

-- Scenario 13: Temporary Access (Time-Bound Access)
CREATE ROLE 'TempAccessRole';
GRANT SELECT ON OnlineRetailDB.* TO 'TempAccessRole';
-- Later, revoke access
-- REVOKE SELECT ON OnlineRetailDB.* FROM 'TempAccessRole';

-- Scenario 14: External Auditor (Read Access with No Data Changes)
CREATE ROLE 'AuditorRole';
GRANT SELECT ON OnlineRetailDB.* TO 'AuditorRole';
-- MySQL does not support DENY; ensure not granting INSERT, UPDATE, DELETE

-- Scenario 15: Application Role (Access Based on Application)
-- MySQL does not have true Application Roles; simulate by granting to a user used by the app
CREATE ROLE 'AppRole';
GRANT SELECT, INSERT, UPDATE ON OnlineRetailDB.Orders TO 'AppRole';

-- Scenario 16: RBAC for Multiple Roles (Combine Permissions)
-- MySQL does not support nesting roles; instead, assign multiple roles to users

-- Scenario 17: Sensitive Data Access (Column-Level Permissions)
-- Use view workaround again
CREATE VIEW OnlineRetailDB.SensitiveCustomerData AS 
SELECT Email, Phone FROM OnlineRetailDB.Customers;

CREATE ROLE 'SensitiveDataRole';
GRANT SELECT ON OnlineRetailDB.SensitiveCustomerData TO 'SensitiveDataRole';

-- Scenario 19: Developer Role (Full Access to Development Database)
CREATE ROLE 'DevRole';
GRANT ALL PRIVILEGES ON OnlineRetailDB.* TO 'DevRole';

-- Scenario 20: Security Administrator (Manage Users/Roles)
CREATE ROLE 'SecurityAdminRole';
GRANT CREATE USER, DROP, GRANT OPTION ON *.* TO 'SecurityAdminRole';










