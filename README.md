# 📦 OnlineRetailDB Project – SQL-Based Retail Management System
## 🧾 Project Overview
This project simulates a fictional online retail company and demonstrates core database design, data manipulation, query writing, indexing, views, triggers, and role-based access control (RBAC) in MySQL.

## 📚 Contents
Database Schema

Sample Data Insertion

Analytical Queries

Performance Optimization (Indexes)

Views

Logging with Triggers

Security & Access Control (RBAC)

## 1. Database Schema
Database Name: OnlineRetailDB

Tables:
Customers: Customer details

Products: Product information

Categories: Product categories

Orders: Customer orders

OrderItems: Items per order

## 2. Sample Data Insertion
Each table is populated with sample data:

Customers from multiple countries

A mix of electronic, apparel, and book products

Multiple orders including multi-item orders

Products with Stock = 0 for inventory queries

## 3. Analytical Queries
More than 40+ queries are implemented, covering:

🔍 Customer order history

📊 Sales by product and category

💵 Average order value

🧑‍💼 Top customers

🛒 Out-of-stock and recent purchases

📈 Monthly sales trends

🚨 Customers with no orders

📦 Product performance

🔁 Most frequent purchases

## 4. Performance Optimization (Indexes)
Indexes are created to improve query performance:

✅ Clustered index on primary keys

🔎 Non-clustered indexes on:

Products: CategoryID, Price

Orders: CustomerID, OrderDate

OrderItems: ProductID, OrderID

Customers: Email, Country

## 5. Views
Logical data abstraction for:
vw_ProductDetails: Products with category names

vw_CustomerOrders: Total orders and spend per customer

vw_RecentOrders: Orders in the last 30 days

These simplify complex queries and secure sensitive columns.

## 6. Logging with Triggers
Triggers are created for Products and Customers tables to track:

INSERT

UPDATE

DELETE

All actions are logged in a dedicated ChangeLog table with:

Table name

Operation type

Record ID

User

Timestamp

## 7. Security & Access Control (RBAC)
Over 20 access scenarios implemented using:

CREATE ROLE

GRANT / REVOKE

Custom views for column-level access

Roles include:

ReadOnlyRole, DataEntryClerk

ProductManagerRole, FinanceManagerRole

SalesAnalystRole, CustomerSupportRole

SecurityAdminRole, DevRole

Column-level permissions are simulated via views.

## 🛠️ Requirements

MySQL 8.0+

User with CREATE, GRANT, TRIGGER privileges

Any SQL client (e.g., MySQL Workbench, DBeaver, CLI)

## 📂 How to Use
Run all table and data creation scripts in order.

Execute queries section by section as needed.

View performance using EXPLAIN and monitor ChangeLog table.

Assign roles and test user access via SHOW GRANTS.
