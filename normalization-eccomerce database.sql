normalization


USE EcommerceDB;

------------------1NF (First Normal Form)------------

CREATE TABLE Orders (
    order_id INT,
    customer_details VARCHAR(255)  -- 'Alice, alice@example.com'
);


-------------2nf--------------


CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100)
);
CREATE TABLE OrderDetails (
    order_id INT,
    product_id INT,
    quantity INT, -- example of an actual detail related to this combo
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

INSERT INTO Products (product_id, product_name)
VALUES (1, 'Laptop'), (2, 'Phone');

INSERT INTO OrderDetails (order_id, product_id, quantity)
VALUES (101, 1, 2), (101, 2, 1);


DROP TABLE IF EXISTS OrderDetails;
DROP TABLE IF EXISTS Products;

SELECT 
    o.order_id,
    p.product_name,
    o.quantity
FROM OrderDetails o
JOIN Products p ON o.product_id = p.product_id;



----------------3nf-------------



USE EcommerceDB;
GO




-- 1. Create Customers table
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    customer_email VARCHAR(100)
);

-- 2. Create Orders table with only customer_id
CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- 3. Keep OrderDetails table from 2NF
CREATE TABLE OrderDetails (
    order_id INT,
    product_id INT,
    quantity INT,
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

INSERT INTO Customers (customer_id, customer_name, customer_email)
VALUES (1, 'Alice', 'alice@example.com');

INSERT INTO Orders (order_id, customer_id)
VALUES (101, 1);

INSERT INTO OrderDetails (order_id, product_id, quantity)
VALUES (101, 1, 2), (101, 2, 1);



