# SuperMart-TSQL-Capstone

A Microsoft SQL Server database project demonstrating practical **T-SQL, relational database design, data retrieval, data analysis, and database programming** using a simulated SuperMart retail environment.

## 📌 Project Overview

SuperMart is a fictional retail business preparing to open a new branch in Johannesburg.

The objective of this project was to design and populate a relational database and develop SQL queries and database objects that can support the company's sales, customer relations, marketing, finance, and operations teams.

The project demonstrates practical SQL Server and T-SQL skills, including database design, data manipulation and retrieval, filtering, functions, joins, subqueries, views, CTEs, stored procedures, and business reporting.

## Project Objectives

The main objectives of this project are to:

1. Design a relational database for a retail business.
2. Create and populate customer and order tables.
3. Establish relationships between customers and orders.
4. Retrieve meaningful business information using T-SQL.
5. Analyse customer and order data.
6. Demonstrate different SQL join types.
7. Use subqueries to analyse customer purchasing activity.
8. Create reusable database objects such as views and stored procedures.
9. Apply SQL functions for data transformation and reporting.
10. Write clean, structured, and documented T-SQL code.

## Database Design

The project uses a database named:

```text
SuperMart_Db
```

### Customers Table

The `Customers` table stores customer information.

| Column     | Description                         |
| ---------- | ----------------------------------- |
| CustomerId | Unique identifier for each customer |
| FirstName  | Customer's first name               |
| LastName   | Customer's surname                  |
| City       | Customer's city                     |
| Phone      | Customer's phone number             |
| Email      | Customer's email address            |
| Country    | Customer's country                  |

### Orders Table

The `Orders` table stores customer order information.

| Column      | Description                        |
| ----------- | ---------------------------------- |
| OrderId     | Unique identifier for an order     |
| CustomerId  | Customer associated with the order |
| OrderDate   | Date the order was placed          |
| StatusCode  | Current status of the order        |
| TotalAmount | Total monetary value of the order  |

### Order Status Codes

| Code | Meaning   |
| ---- | --------- |
| P    | Pending   |
| D    | Delivered |
| C    | Canceled  |

### Database Relationship

The database uses a relationship between the `Customers` and `Orders` tables.

```text
Customers
    |
    | CustomerId
    |
    v
Orders
```

A customer can have multiple orders, while each order belongs to a customer.

---

## Technologies Used

* Microsoft SQL Server
* T-SQL
* SQL Server Management Studio (SSMS)

## SQL Concepts Demonstrated

### 1. DDL – Data Definition Language

The project demonstrates database and table modification using:

* `CREATE DATABASE`
* `CREATE TABLE`
* `ALTER TABLE`
* Constraints

Example:

```sql
ALTER TABLE Customers
ADD Country VARCHAR(50);

ALTER TABLE Customers
ADD CONSTRAINT DF_Country
DEFAULT 'South Africa'
FOR Country;
```

### 2. Data Retrieval

Customer and order information can be retrieved using the `SELECT` statement.

```sql
SELECT *
FROM Customers;
```

### 3. Concatenation and Aliases

First and last names are combined into a single customer name.

```sql
SELECT
    FirstName + ' ' + LastName AS [Customer Name]
FROM Customers;
```

### 4. NULL Handling with COALESCE()

The project uses `COALESCE()` to replace missing phone numbers.

```sql
SELECT
    CustomerId,
    FirstName + ' ' + LastName AS [Customer Name],
    Country,
    City,
    COALESCE(Phone, 'No Phone Number') AS Phone
FROM Customers;
```

---

### 5. Filtering Data

The project demonstrates filtering using `WHERE`, `IN`, and `BETWEEN`.

#### Using IN

```sql
SELECT
    FirstName + ' ' + LastName AS [Full Name],
    Email,
    City
FROM Customers
WHERE City IN ('Johannesburg', 'Pretoria');
```

#### Using BETWEEN

```sql
SELECT
    OrderId,
    CustomerId,
    OrderDate,
    StatusCode AS Status,
    TotalAmount
FROM Orders
WHERE OrderDate BETWEEN '2026-01-01' AND '2026-03-31';
```

##  SQL Joins

The project demonstrates four major SQL join types.

### INNER JOIN

Returns customers who have placed orders.

```sql
SELECT
    C.FirstName + ' ' + C.LastName AS [Customer Name],
    O.OrderId,
    O.OrderDate,
    O.TotalAmount
FROM Customers C
INNER JOIN Orders O
    ON C.CustomerId = O.CustomerId;
```

### LEFT JOIN

Returns all customers, including customers who have not placed an order.

```sql
SELECT
    C.FirstName + ' ' + C.LastName AS [Customer Name],
    O.OrderId,
    O.OrderDate,
    O.TotalAmount
FROM Customers C
LEFT JOIN Orders O
    ON C.CustomerId = O.CustomerId;
```

### RIGHT JOIN

Returns all orders, including orders that may not have matching customer records.

```sql
SELECT
    C.FirstName + ' ' + C.LastName AS [Customer Name],
    O.OrderId,
    O.OrderDate,
    O.TotalAmount
FROM Customers C
RIGHT JOIN Orders O
    ON C.CustomerId = O.CustomerId;
```

### FULL OUTER JOIN

Returns matching and non-matching records from both tables.

```sql
SELECT
    C.FirstName + ' ' + C.LastName AS [Customer Name],
    O.OrderId,
    O.OrderDate,
    O.TotalAmount
FROM Customers C
FULL OUTER JOIN Orders O
    ON C.CustomerId = O.CustomerId;
```

---

## Data Analysis & Aggregation

The project uses aggregate functions including:

* `COUNT()`
* `AVG()`
* `MAX()`
* `MIN()`

Example:

```sql
SELECT
    COUNT(OrderId) AS [Total Number of Orders],
    AVG(TotalAmount) AS [Average Order Amount],
    MAX(TotalAmount) AS [Highest Order Amount],
    MIN(TotalAmount) AS [Lowest Order Amount]
FROM Orders;
```

Customer distribution is analysed using `GROUP BY`.

```sql
SELECT
    Country,
    COUNT(CustomerId) AS [Total Customers]
FROM Customers
GROUP BY Country
ORDER BY [Total Customers] DESC;
```

---

## String Functions

The project demonstrates SQL string functions such as `UPPER()` and `LEN()`.

```sql
SELECT
    UPPER(FirstName + ' ' + LastName) AS [Customer Name],
    Country,
    LEN(FirstName) AS [First Name Length]
FROM Customers
ORDER BY FirstName ASC;
```

---

## 🔎 Subqueries

Two approaches are used to identify customers who have placed at least one order.

### Using IN

```sql
SELECT
    CustomerId,
    FirstName + ' ' + LastName AS [Customer Name],
    Country
FROM Customers
WHERE CustomerId IN (
    SELECT CustomerId
    FROM Orders
);
```

### Using EXISTS

```sql
SELECT
    CustomerId,
    FirstName + ' ' + LastName AS [Customer Name],
    Country
FROM Customers C
WHERE EXISTS (
    SELECT 1
    FROM Orders O
    WHERE O.CustomerId = C.CustomerId
);
```

---

## SQL View

A reusable view called `CustomerOrders` is created to simplify access to customer order information.

```sql
CREATE VIEW CustomerOrders AS
SELECT
    C.FirstName + ' ' + C.LastName AS [Customer Name],
    O.OrderDate,
    O.TotalAmount
FROM Customers C
INNER JOIN Orders O
    ON C.CustomerId = O.CustomerId;
```

The view can be queried using:

```sql
SELECT *
FROM CustomerOrders;
```

---

## Common Table Expression (CTE)

A CTE is used to calculate the number of orders placed by each customer.

```sql
WITH OrderCountCTE AS
(
    SELECT
        C.FirstName + ' ' + C.LastName AS [Customer Name],
        COUNT(O.OrderId) AS [Number of Orders]
    FROM Customers C
    LEFT JOIN Orders O
        ON C.CustomerId = O.CustomerId
    GROUP BY
        C.FirstName,
        C.LastName
)
SELECT
    [Customer Name],
    [Number of Orders]
FROM OrderCountCTE;
```

The `LEFT JOIN` ensures that customers who have not placed orders can also be included in the results.

---

## Stored Procedure

The project includes a stored procedure called `GetCustomerOrders`.

The procedure accepts a customer ID and returns all orders belonging to that customer.

```sql
CREATE PROCEDURE GetCustomerOrders
    @InputCustomerId INT
AS
BEGIN

    SELECT
        OrderId,
        OrderDate,
        StatusCode AS [Order Status],
        TotalAmount
    FROM Orders
    WHERE CustomerId = @InputCustomerId;

END;
```

The procedure can be executed using:

```sql
EXEC GetCustomerOrders
    @InputCustomerId = 1;
```

---

## Business Questions Answered

The project demonstrates how SQL can be used to answer practical business questions.

### Sales

* Which customers have placed orders?
* Which orders were placed during Q1 2026?
* What is the average order amount?
* What is the highest order amount?
* What is the lowest order amount?
* How many orders exist?

### Customer Relations

* Which customers have not placed orders?
* What are the customer's contact details?
* How many orders has each customer placed?

### Marketing

* Which customers are located in Johannesburg or Pretoria?
* How are customers distributed by country?

### Operations

* What orders exist in the system?
* Which orders are associated with customers?
* Are there orders without matching customer records?

### Finance

* What is the total number of orders?
* What is the average order amount?
* What is the highest order amount?
* What is the lowest order amount?

---

## Repository Structure

```text
SuperMart-TSQL-Capstone/
│
├── README.md
│
├── SuperMart_TSQL_Capstone.sql
│
└── Execution-Report/
    └── SuperMart_TSQL_Execution_Report.docx
```

### `SuperMart_TSQL_Capstone.sql`

Contains:

* **Database Setup:** Database, tables, constraints, and sample data.
* **Data Queries:** Retrieval, filtering, sorting, joins, and aggregation.
* **SQL Functions:** String functions, date functions, and NULL handling.
* **Advanced T-SQL:** Subqueries, views, CTEs, and stored procedures.


### `Execution-Report/`

Contains screenshots demonstrating successful execution of the different project sections in SQL Server Management Studio.

---

## How to Run the Project

### Prerequisites

You will need:

* Microsoft SQL Server
* SQL Server Management Studio (SSMS)
* Git

### 1. Clone the Repository

```bash
git clone https://github.com/YOUR-USERNAME/SuperMart-TSQL-Capstone.git
```

### 2. Open the SQL Script

Open:

```text
SuperMart_TSQL_Capstone.sql
```

in SQL Server Management Studio.

### 3. Execute the Script

Run the script in SQL Server Management Studio.

### 4. Verify the Database

```sql
USE SuperMart_Db;

SELECT *
FROM Customers;

SELECT *
FROM Orders;
```

### 5. Test the View

```sql
SELECT *
FROM CustomerOrders;
```

### 6. Test the Stored Procedure

```sql
EXEC GetCustomerOrders
    @InputCustomerId = 1;
```

---

## Learning Outcomes

This project helped demonstrate practical experience with:

* SQL Server
* T-SQL
* Database creation
* Table design
* keys
* Constraints
* Date functions
* JOIN
* Subqueries

## 💡 Key Takeaway

This project demonstrates how T-SQL can be used to transform raw relational data into meaningful business information.

By combining **database design, data retrieval, filtering, joins, aggregation, subqueries, views, CTEs, and stored procedures**, the SuperMart database provides a foundation for supporting real-world business reporting and decision-making.


## Project Information

* **Project:** SuperMart T-SQL Capstone
* **Database:** `SuperMart_Db`
* **Language:** T-SQL
* **Platform:** Microsoft SQL Server
* **IDE:** SQL Server Management Studio
* **Repository:** `SuperMart-TSQL-Capstone`
