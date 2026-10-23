-- Create Customers with data types
CREATE TABLE Customers ( 
    CustomerId INT PRIMARY KEY NOT NULL,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    City VARCHAR(50) NOT NULL,
    Phone VARCHAR(15),
    Email VARCHAR(50) NOT NULL
);

-- Create Orders with datatypes and FK
CREATE TABLE Orders (
    OrderId INT PRIMARY KEY NOT NULL,
    CustomerId INT NOT NULL,
    TotalAmount DECIMAL(10, 2) NOT NULL, 
    StatusCode VARCHAR(1) NOT NULL,
    OrderDate DATE NOT NULL,
    CONSTRAINT fk_Customers
    FOREIGN KEY(CustomerId)
    REFERENCES Customers (CustomerId)
);

-- Insert data (Phone numbers and IDs now handled as strings/proper values)
INSERT INTO Customers (CustomerId, FirstName, LastName, City, Phone, Email)
VALUES
(1, 'Nathan', 'Raidoo', 'Pretoria', '0729321267', 'nathan.raidoo@gmail.com'),
(2, 'Bradley', 'Cross', 'Johannesburg', NULL, 'bcross@outlook.com'),
(3, 'Justin', 'Gaethjie', 'Cape Town', '0734567890', 'jgaethjie@gmail.com'),
(4, 'Winston', 'Churchill', 'Johannesburg', '0745678901', 'wchurchill@gmail.com'),
(5, 'Stacey', 'Chance', 'Pretoria', NULL, 'stacey.chance@yahoo.com'),
(6, 'Vanessa', 'Rodgers', 'Cape Town', '0789012345', 'vrodgers@gmail.com'),
(7, 'Janet', 'Whitey', 'Pretoria', NULL, 'jwhitey@icloud.com');

INSERT INTO Orders (OrderId, CustomerId, TotalAmount, StatusCode, OrderDate)
VALUES
(101, 1, 1500.00, 'D', '2026-01-12'),
(102, 6, 850.00, 'P', '2026-05-20'),
(103, 5, 3200.00, 'D', '2026-02-14'),
(104, 4, 450.00, 'C', '2026-11-02'),
(105, 1, 95.00, 'D', '2026-07-04'),
(106, 3, 1200.00, 'P', '2026-12-15'),
(107, 4, 2100.00, 'D', '2026-03-22'),
(108, 3, 500.00, 'C', '2026-09-10'),
(109, 5, 750.00, 'P', '2026-06-18'),
(110, 3, 110.00, 'D', '2026-10-31');

SELECT* FROM Orders;
SELECT* FROM Customers;

