
# 🛒 OnlineRetailDB Project – A Complete SQL Retail Database Simulation

## 📌 Project Overview

The **OnlineRetailDB** project is a comprehensive simulation of a **fictional e-commerce company’s database system**, created using **MySQL**. It covers the full spectrum of database development and operations, including:

- Schema design  
- Data population  
- Real-world reporting queries  
- Views and indexing  
- Trigger-based auditing  
- Role-based access control (RBAC) for data security

This project is ideal for learning, interviews, academic submissions, or demonstrations of SQL skills in real-world scenarios.

---

## 🧱 1. Database Design

**Database Name**: `OnlineRetailDB`

### 🔹 Core Tables

| Table Name   | Description                                      |
|--------------|--------------------------------------------------|
| `Customers`  | Stores customer personal and contact information |
| `Products`   | Holds product listings, prices, and stock data   |
| `Categories` | Product categories like Electronics, etc.        |
| `Orders`     | Customer orders (order header)                   |
| `OrderItems` | Line-level order details (order body)            |

---

## 📥 2. Sample Data Insertion

Sample data is inserted for each table using realistic values. Includes:

- Customers from both USA and India
- Products across 3 categories: **Electronics**, **Clothing**, **Books**
- Orders placed with multiple items
- Products with `Stock = 0` for inventory queries
- A customer who hasn't placed any orders

---

## 📊 3. Query Bank (40+ Queries)

### 🔎 Data Retrieval & Reporting

- Retrieve orders by customer
- Top-selling products by revenue
- Average order value
- Top customers by spend
- Recent orders and customers

### 📈 Aggregation Queries

- Monthly sales trend
- Revenue by category
- Average price by category

### 🔗 Joins & Subqueries

- Multi-table joins
- Row ranking (`ROW_NUMBER()`, `RANK()`)
- CTEs and subqueries

Example:
```sql
SELECT P.ProductName, SUM(OI.Quantity * OI.Price) AS TotalSales
FROM OrderItems OI
JOIN Products P ON OI.ProductID = P.ProductID
GROUP BY P.ProductName
ORDER BY TotalSales DESC;
```

---

## ⚡ 4. Performance Optimization – Indexing

Indexes are added to improve query performance:

- Products: `CategoryID`, `Price`
- Orders: `CustomerID`, `OrderDate`
- OrderItems: `ProductID`, `OrderID`
- Customers: `Email`, `Country`

---

## 👁️ 5. Views

| View Name            | Description                               |
|----------------------|-------------------------------------------|
| `vw_ProductDetails`  | Products + Category names                 |
| `vw_CustomerOrders`  | Total orders and spend per customer       |
| `vw_RecentOrders`    | Orders in the last 30 days                |
| `CustomerPublicView` | Basic customer info for restricted access |

---

## 🔐 6. Auditing with Triggers

Trigger-based logging using a `ChangeLog` table:

| Column     | Description              |
|------------|--------------------------|
| LogID      | Unique entry             |
| TableName  | Affected table           |
| Operation  | INSERT, UPDATE, DELETE   |
| RecordID   | Primary key              |
| ChangedBy  | User who made the change |
| ChangeDate | Timestamp                |

Triggers implemented for `Products` and `Customers` (Insert/Update/Delete)

---

## 👮 7. Role-Based Access Control (RBAC)

Roles created and granted permissions using `GRANT` / `REVOKE`.

| Role Name            | Access Type                                   |
|----------------------|-----------------------------------------------|
| `ReadOnlyRole`       | SELECT on all tables                          |
| `ProductManagerRole` | Full access to products and categories         |
| `DataEntryClerk`     | INSERT on `Orders`, `OrderItems`             |
| `CustomerSupportRole`| Read-only access to `Customers`, `Orders`     |
| `SensitiveDataRole`  | Limited column access via views               |

---

## 💻 Tech Stack

- MySQL 8.0+
- MySQL Workbench, CLI, or DBeaver

---

## 📦 How to Use

1. Run table and data scripts
2. Execute queries for insights
3. Use `EXPLAIN` to monitor performance
4. Simulate RBAC using users and roles
5. Audit changes via `ChangeLog` table

---

## 🧠 Learning Outcomes

- Schema design & normalization
- Real-world SQL query writing
- Performance tuning via indexes
- Trigger-based audit logs
- RBAC and security enforcement

---
