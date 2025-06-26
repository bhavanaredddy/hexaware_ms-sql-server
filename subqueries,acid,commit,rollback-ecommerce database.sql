
CREATE DATABASE EcommerceDB;
USE EcommerceDB;


CREATE TABLE Customerstable (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    city VARCHAR(50),
    created_at DATE
);

CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10, 2),
    stock INT
);


CREATE TABLE Orderstable (
    order_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    quantity INT,
    order_date DATE,
    total_price DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES Customerstable(customer_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

CREATE TABLE Payments (
    payment_id INT PRIMARY KEY,
    order_id INT,
    payment_date DATE,
    payment_method VARCHAR(50),
    payment_status VARCHAR(20),
    FOREIGN KEY (order_id) REFERENCES Orderstable(order_id)
);

CREATE TABLE ProductReviews (
    review_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    review_text TEXT,
    review_date DATE,
    FOREIGN KEY (customer_id) REFERENCES Customerstable(customer_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);


CREATE TABLE ShippingDetails (
    shipping_id INT PRIMARY KEY,
    order_id INT,
    shipping_address TEXT,
    city VARCHAR(50),
    shipped_date DATE,
    delivery_status VARCHAR(30),
    FOREIGN KEY (order_id) REFERENCES Orderstable(order_id)
);



INSERT INTO Customerstable (customer_id, name, email, city, created_at)
VALUES 
(1, 'Alice', 'alice@example.com', 'New York', '2023-01-01'),
(2, 'Bob', 'bob@example.com', 'Los Angeles', '2023-02-15'),
(3, 'Charlie', 'charlie@example.com', 'Chicago', '2023-03-20'),
(4, 'David', 'david@example.com', 'Houston', '2023-04-10'),
(5, 'Eva', 'eva@example.com', 'Miami', '2023-05-05');

INSERT INTO Products (product_id, name, category, price, stock)
VALUES
(1, 'Laptop', 'Electronics', 999.99, 50),
(2, 'Phone', 'Electronics', 499.99, 100),
(3, 'Desk', 'Furniture', 199.99, 20),
(4, 'Chair', 'Furniture', 89.99, 15),
(5, 'Headphones', 'Electronics', 59.99, 200);

INSERT INTO Orderstable (order_id, customer_id, product_id, quantity, order_date, total_price)
VALUES
(1, 1, 1, 2, '2023-04-01', 1999.98),
(2, 2, 2, 1, '2023-05-01', 499.99),
(3, 3, 3, 1, '2023-06-01', 199.99),
(4, 4, 4, 2, '2023-06-10', 179.98),
(5, 5, 5, 3, '2023-07-01', 179.97);




INSERT INTO Payments (payment_id, order_id, payment_date, payment_method, payment_status)
VALUES
(1, 1, '2023-04-02', 'Credit Card', 'Completed'),
(2, 2, '2023-05-02', 'UPI', 'Completed'),
(3, 3, '2023-06-02', 'Cash on Delivery', 'Pending'),
(4, 4, '2023-06-11', 'Debit Card', 'Completed'),
(5, 5, '2023-07-02', 'Credit Card', 'Completed');

INSERT INTO ProductReviews (review_id, customer_id, product_id, rating, review_text, review_date)
VALUES
(1, 1, 1, 5, 'Excellent laptop!', '2023-04-05'),
(2, 2, 2, 4, 'Good phone for the price.', '2023-05-03'),
(3, 3, 3, 3, 'Desk is decent but had a scratch.', '2023-06-05'),
(4, 4, 4, 5, 'Very comfortable chair.', '2023-06-12'),
(5, 5, 5, 4, 'Nice sound quality.', '2023-07-03');


INSERT INTO ShippingDetails (shipping_id, order_id, shipping_address, city, shipped_date, delivery_status)
VALUES
(1, 1, '123 Main St, Apt 1', 'New York', '2023-04-03', 'Delivered'),
(2, 2, '456 Sunset Blvd', 'Los Angeles', '2023-05-03', 'Delivered'),
(3, 3, '789 Lakeview Dr', 'Chicago', '2023-06-03', 'Shipped'),
(4, 4, '321 Oak Ln', 'Houston', '2023-06-12', 'Delivered'),
(5, 5, '654 Ocean Ave', 'Miami', '2023-07-04', 'Delivered');





SELECT 
    o.order_id, 
    c.name AS customer_name, 
    o.total_price 
FROM Orderstable o
JOIN Customerstable c ON o.customer_id = c.customer_id;

---------Customers who placed orders in the year 2023


SELECT DISTINCT c.name
FROM Customerstable c
JOIN Orderstable o ON c.customer_id = o.customer_id
WHERE YEAR(o.order_date) = 2023;

-----------Total quantity sold and revenue generated per product
SELECT 
    p.name AS product_name, 
    SUM(o.quantity) AS total_sold, 
    SUM(o.total_price) AS total_revenue
FROM Orderstable o
JOIN Products p ON o.product_id = p.product_id
GROUP BY p.name;
---------------pr with highest revenue
SELECT 
    p.name AS product_name, 
    SUM(o.total_price) AS revenue
FROM Orderstable o
JOIN Products p ON o.product_id = p.product_id
GROUP BY p.name
ORDER BY revenue DESC
LIMIT 1;



-------Average order value per customer-----
SELECT 
    c.name AS customer_name, 
    AVG(o.total_price) AS avg_order_value
FROM Customerstable c
JOIN Orderstable o ON c.customer_id = o.customer_id
GROUP BY c.name;


-----------Customers who ordered low-stock products (stock < 3----------
SELECT DISTINCT c.name
FROM Customerstable c
JOIN Orderstable o ON c.customer_id = o.customer_id
JOIN Products p ON o.product_id = p.product_id
WHERE p.stock < 30;



------adding colm---
ALTER TABLE Customerstable
ADD referrer_id INT;

-- First customer has no referrer
UPDATE Customerstable SET referrer_id = NULL WHERE customer_id = 1;

-- Alice referred Bob and Charlie
UPDATE Customerstable SET referrer_id = 1 WHERE customer_id IN (2, 3);

-- Bob referred David
UPDATE Customerstable SET referrer_id = 2 WHERE customer_id = 4;

-- Charlie referred Eva
UPDATE Customerstable SET referrer_id = 3 WHERE customer_id = 5;

------------------recursive query------------

WITH referral_tree AS (
    SELECT 
        customer_id, 
        name, 
        referrer_id, 
        0 AS level
    FROM Customerstable
    WHERE referrer_id IS NULL

    UNION ALL

    SELECT 
        c.customer_id, 
        c.name, 
        c.referrer_id, 
        rt.level + 1 AS level
    FROM Customerstable c
    JOIN referral_tree rt ON c.referrer_id = rt.customer_id
)
SELECT 
    customer_id, 
    name, 
    referrer_id, 
    level
FROM referral_tree
ORDER BY level, customer_id;




-----------------------------------------------------------------------
CREATE PROCEDURE GetCustomersByCity
    @City NVARCHAR(50)
AS
BEGIN
    SELECT customer_id, name, email, city, created_at
    FROM Customerstable
    WHERE city = @City;
END;

-- Usage:
EXEC GetCustomersByCity @City = 'New York';


----------------
CREATE PROCEDURE GetCustomerOrderCount
    @CustomerID INT,
    @OrderCount INT OUTPUT
AS
BEGIN
    SELECT @OrderCount = COUNT(*)
    FROM Orderstable
    WHERE customer_id = @CustomerID;
END;

-- Usage:
DECLARE @Count INT;
EXEC GetCustomerOrderCount @CustomerID = 1, @OrderCount = @Count OUTPUT;
PRINT @Count;

----------------subqueries=-----------


-----------customer > 500--------
SELECT name, email
FROM Customerstable
WHERE customer_id IN (
    SELECT customer_id
    FROM Orderstable
    WHERE total_price > 500
);


------------customer with total number of orders------------
SELECT 
    c.customer_id, 
    c.name, 
    c.email, 
    (SELECT COUNT(*)
     FROM Orderstable o
     WHERE o.customer_id = c.customer_id) AS total_orders
FROM Customerstable c;



---------------product that never has ordrerd------
SELECT name AS product_name
FROM Products
WHERE product_id NOT IN (
    SELECT DISTINCT product_id
    FROM Orderstable
);




-------------------spent more than average-------
SsELECT name, email
FROM Customerstable
WHERE customer_id IN (
    SELECT customer_id
    FROM Orderstable
    GROUP BY customer_id
    HAVING SUM(total_price) > (
        SELECT AVG(total_price)
        FROM Orderstable
    )
);

---------------c with total spendings---
SELECT name, email
FROM Customerstable
WHERE customer_id IN (
    SELECT customer_id
    FROM Orderstable
    GROUP BY customer_id
    HAVING SUM(total_price) > (
        SELECT AVG(total_price)
        FROM Orderstable
    )
);
-----------c with most expensive order------

SELECT c.customer_id, c.name, o.order_id, p.name AS product_name
FROM Orderstable o
JOIN Products p ON o.product_id = p.product_id
JOIN Customerstable c ON o.customer_id = c.customer_id
WHERE o.product_id = (
    SELECT product_id
    FROM Products
    WHERE price = (SELECT MAX(price) FROM Products)
);

---------------cus with order greter than average quantity----------
SELECT customer_id, COUNT(order_id) AS total_orders
FROM Orderstable
GROUP BY customer_id
HAVING COUNT(order_id) > (
    SELECT AVG(order_count)
    FROM (
        SELECT customer_id, COUNT(order_id) AS order_count
        FROM Orderstable
        GROUP BY customer_id
    ) sub
);

--------------product never prder by any c------------
SELECT product_id, name
FROM Products
WHERE product_id NOT IN (
    SELECT DISTINCT product_id
    FROM Orderstable
);


-----------dupilicate c id----
SELECT customer_id, COUNT(*)
FROM Customerstable
GROUP BY customer_id
HAVING COUNT(*) > 1;

---------------------------------------------------------------------------------------------------------

---------atomicity-------
BEGIN TRANSACTION;

-- Customer 1 places an order (debit)
INSERT INTO Orderstable (order_id, customer_id, product_id, quantity, order_date, total_price)
VALUES (100, 1, 1, 1, '2023-07-15', 999.99);

-- Customer 2 gets credited as a referrer bonus in payment record
INSERT INTO Payments (payment_id, order_id, payment_date, payment_method, payment_status)
VALUES (100, 1, '2023-07-15', 'Referral Credit', 'Completed');

-- Rollback this to simulate error OR commit to complete
-- ROLLBACK;
COMMIT;



-- Use order_id = 9999 and payment_id = 9999 (or any other unused values)

BEGIN TRANSACTION;

INSERT INTO Orderstable (order_id, customer_id, product_id, quantity, order_date, total_price)
VALUES (9999, 1, 1, 1, '2023-07-18', 1999.99);

INSERT INTO Payments (payment_id, order_id, payment_date, payment_method, payment_status)
VALUES (9999, 9999, '2023-07-18', 'Credit Card', 'Completed');

COMMIT;


SELECT * FROM Orderstable WHERE order_id = 100;
SELECT * FROM Payments WHERE payment_id = 100;

-- WARNING: Only do this if it's okay to delete
DELETE FROM Orderstable WHERE order_id = 100;
DELETE FROM Payments WHERE payment_id = 100;






-----------consitency------
BEGIN TRANSACTION;

-- Insert new order
INSERT INTO Orderstable (order_id, customer_id, product_id, quantity, order_date, total_price)
VALUES (101, 2, 2, 1, '2025-06-16', 499.99);

-- Insert valid payment linked to that order
INSERT INTO Payments (payment_id, order_id, payment_date, payment_method, payment_status)
VALUES (101, 101, '2025-06-16', 'Credit Card', 'Completed');

COMMIT;


-- This will fail because order_id = 999 doesn't exist in Orderstable
INSERT INTO Payments (payment_id, order_id, payment_date, payment_method, payment_status)
VALUES (102, 999, '2025-06-16', 'UPI', 'Completed');



-------------isolation-------------
 -------------------transaction a-------


BEGIN TRANSACTION;

UPDATE Products
SET stock = stock - 1
WHERE product_id = 1;

-- Don’t commit yet – simulate waiting for Transaction B to read
-- COMMIT;


----------------tranction 2--
SELECT stock
FROM Products
WHERE product_id = 1;
-- It won’t see the uncommitted update from Transaction A (in READ COMMITTED isolation level)



--------------------------commit--------------

COMMIT;


--------------------------durablity---------------

-- Insert a log to verify durability
BEGIN TRANSACTION;

INSERT INTO ProductReviews (review_id, customer_id, product_id, rating, review_text, review_date)
VALUES (100, 1, 1, 5, 'Excellent durability test!', '2025-06-16');

COMMIT;

-- Even if the DB crashes now, this row stays.
SELECT * FROM ProductReviews WHERE review_id = 100;




BEGIN TRANSACTION;

-- Check stock before order
IF (SELECT stock FROM Products WHERE product_id = 1) >= 2
BEGIN
    -- Insert Order
    INSERT INTO Orderstable (order_id, customer_id, product_id, quantity, order_date, total_price)
    VALUES (1234, 1, 1, 2, '2023-07-18', 1999.98);

    -- Decrease stock
    UPDATE Products SET stock = stock - 2 WHERE product_id = 1;

    COMMIT;
END
ELSE
BEGIN
    ROLLBACK;
END;












