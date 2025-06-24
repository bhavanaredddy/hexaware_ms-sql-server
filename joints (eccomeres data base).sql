USE EcommerceDB;


joints------------
-----------inner joints------------


SELECT o.order_id, c.name AS customer_name, p.name AS product_name
FROM Orderstable o
JOIN Customerstable c ON o.customer_id = c.customer_id
JOIN Products p ON o.product_id = p.product_id;


SELECT py.payment_id, o.order_id, c.name AS customer_name, py.payment_status
FROM Payments py
JOIN Orderstable o ON py.order_id = o.order_id
JOIN Customerstable c ON o.customer_id = c.customer_id;

SELECT pr.review_id, c.name AS customer_name, p.name AS product_name, pr.rating
FROM ProductReviews pr
JOIN Customerstable c ON pr.customer_id = c.customer_id
JOIN Products p ON pr.product_id = p.product_id;

----------left joins----------
SELECT c.customer_id, c.name, o.order_id, o.total_price
FROM Customerstable c
LEFT JOIN Orderstable o ON c.customer_id = o.customer_id;

SELECT o.order_id, s.delivery_status
FROM Orderstable o
LEFT JOIN ShippingDetails s ON o.order_id = s.order_id;

SELECT p.product_id, p.name, pr.rating
FROM Products p
LEFT JOIN ProductReviews pr ON p.product_id = pr.product_id;

-----right joints---



SELECT py.payment_id, o.order_id, o.total_price
FROM Orderstable o
RIGHT JOIN Payments py ON py.order_id = o.order_id;



SELECT pr.review_id, p.name, pr.rating
FROM ProductReviews pr
RIGHT JOIN Products p ON pr.product_id = p.product_id;



SELECT s.shipping_id, o.order_id, s.delivery_status
FROM ShippingDetails s
RIGHT JOIN Orderstable o ON s.order_id = o.order_id;





------------full outer join--------


SELECT c.name, o.order_id, o.total_price
FROM Customerstable c
FULL OUTER JOIN Orderstable o ON c.customer_id = o.customer_id;



