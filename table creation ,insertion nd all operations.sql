***table creation-----*



CREATE TABLE Screen (
    screen_id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    class_type VARCHAR(10) NOT NULL,
    capacity INT NOT NULL
);

CREATE TABLE Seat (
    seat_id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    seat_number VARCHAR(10) NOT NULL,
    screen_id INT NOT NULL,
    FOREIGN KEY (screen_id) REFERENCES Screen(screen_id)
);
CREATE TABLE Movie (
    movie_id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    genre VARCHAR(50) NOT NULL,
    rating DECIMAL(3,1) NOT NULL,
    status VARCHAR(20) NOT NULL,
    poster_image_url VARCHAR(255) NULL
);
CREATE TABLE MovieCast (
    cast_id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    movie_id INT NOT NULL,
    person_name VARCHAR(100) NOT NULL,
    role VARCHAR(100) NOT NULL,
    FOREIGN KEY (movie_id) REFERENCES Movie(movie_id)
);

CREATE TABLE Review (
    review_id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    movie_id INT NOT NULL,
    content TEXT NOT NULL,
    review_date DATETIME NOT NULL,
    reviewer_name VARCHAR(100) NOT NULL,
    FOREIGN KEY (movie_id) REFERENCES Movie(movie_id)
);
CREATE TABLE Show (
    show_id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    screen_id INT NOT NULL,
    movie_id INT NOT NULL,
    show_datetime DATETIME NOT NULL,
    FOREIGN KEY (screen_id) REFERENCES Screen(screen_id),
    FOREIGN KEY (movie_id) REFERENCES Movie(movie_id)
);

CREATE TABLE ShowSeat (
    show_seat_id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    show_id INT NOT NULL,
    seat_id INT NOT NULL,
    is_available BIT NOT NULL DEFAULT 1,
    FOREIGN KEY (show_id) REFERENCES Show(show_id),
    FOREIGN KEY (seat_id) REFERENCES Seat(seat_id)
);
CREATE TABLE [User] (
    user_id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL,
    phone VARCHAR(15) NULL
);
CREATE TABLE Membership (
    membership_id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    user_id INT NOT NULL,
    current_points INT NOT NULL DEFAULT 0,
    FOREIGN KEY (user_id) REFERENCES [User](user_id)
);
CREATE TABLE Booking (
    booking_id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    user_id INT NOT NULL,
    show_id INT NOT NULL,
    booking_datetime DATETIME NOT NULL,
    total_cost DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES [User](user_id),
    FOREIGN KEY (show_id) REFERENCES Show(show_id)

);

DROP TABLE Ticket;

-- Then recreate it:
CREATE TABLE Ticket (
    ticket_id INT IDENTITY(1,1) PRIMARY KEY,
    booking_id INT NOT NULL,
    show_seat_id INT NOT NULL,
    qr_code VARCHAR(100) NOT NULL,
    delivery_method VARCHAR(50) NOT NULL,
    is_downloaded BIT NOT NULL DEFAULT 0,
    scanned_at DATETIME NULL,
    FOREIGN KEY (booking_id) REFERENCES Booking(booking_id),
    FOREIGN KEY (show_seat_id) REFERENCES ShowSeat(show_seat_id)
);

CREATE TABLE PaymentGateway (
    gateway_id INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE Payment (
    payment_id INT IDENTITY(1,1) PRIMARY KEY,
    booking_id INT NOT NULL,
    gateway_id INT NOT NULL,
    transaction_amount DECIMAL(10,2) NOT NULL,
    transaction_datetime DATETIME NOT NULL,
    status VARCHAR(20) NOT NULL,
    failure_reason TEXT NULL,
    credit_card_name VARCHAR(100) NULL,
    credit_card_number VARCHAR(20) NULL,
    expiry_date DATE NULL,
    cvv VARCHAR(4) NULL,
    FOREIGN KEY (booking_id) REFERENCES Booking(booking_id),
    FOREIGN KEY (gateway_id) REFERENCES PaymentGateway(gateway_id)
);

CREATE TABLE FoodItem (
    item_id INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT NULL,
    is_combo BIT NOT NULL DEFAULT 0
);

CREATE TABLE FoodItemSize (
    size_id INT IDENTITY(1,1) PRIMARY KEY,
    item_id INT NOT NULL,
    size_name VARCHAR(50) NOT NULL,
    rate DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (item_id) REFERENCES FoodItem(item_id)
);

CREATE TABLE FoodOrder (
    order_id INT IDENTITY(1,1) PRIMARY KEY,
    booking_id INT NOT NULL,
    screen_id INT NOT NULL,
    seat_id INT NOT NULL,
    order_datetime DATETIME NOT NULL,
    total_cost DECIMAL(10,2) NOT NULL,
    delivery_method VARCHAR(50) NOT NULL,
    FOREIGN KEY (booking_id) REFERENCES Booking(booking_id),
    FOREIGN KEY (screen_id) REFERENCES Screen(screen_id),
    FOREIGN KEY (seat_id) REFERENCES Seat(seat_id)
);

CREATE TABLE FoodOrderItem (
    order_item_id INT IDENTITY(1,1) PRIMARY KEY,
    order_id INT NOT NULL,
    item_id INT NOT NULL,
    size_id INT NOT NULL,
    quantity INT NOT NULL,
    price_at_time DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES FoodOrder(order_id),
    FOREIGN KEY (item_id) REFERENCES FoodItem(item_id),
    FOREIGN KEY (size_id) REFERENCES FoodItemSize(size_id)
);

CREATE TABLE PointsTransaction (
    transaction_id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    points_earned INT NOT NULL,
    transaction_datetime DATETIME NOT NULL,
    transaction_type VARCHAR(20) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES [User](user_id)
);



-- Drop dependent tables first (child → parent order)
DROP TABLE IF EXISTS PointsTransaction;
DROP TABLE IF EXISTS FoodOrderItem;
DROP TABLE IF EXISTS FoodOrder;
DROP TABLE IF EXISTS FoodItemSize;
DROP TABLE IF EXISTS FoodItem;
DROP TABLE IF EXISTS Payment;
DROP TABLE IF EXISTS PaymentGateway;
DROP TABLE IF EXISTS Ticket;




CREATE TABLE Ticket (
    ticket_id INT IDENTITY(1,1) PRIMARY KEY,
    booking_id INT NOT NULL,
    show_seat_id INT NOT NULL,
    qr_code VARCHAR(100) NOT NULL,
    delivery_method VARCHAR(50) NOT NULL,
    is_downloaded BIT NOT NULL DEFAULT 0,
    scanned_at DATETIME NULL,
    FOREIGN KEY (booking_id) REFERENCES Booking(booking_id),
    FOREIGN KEY (show_seat_id) REFERENCES ShowSeat(show_seat_id)
);

INSERT INTO Ticket (booking_id, show_seat_id, qr_code, delivery_method, is_downloaded, scanned_at)
VALUES 
(2, 1, 'QR123456789', 'WhatsApp', 0, NULL),
(3, 2, 'QR987654321', 'App', 1, '2025-06-11 10:30:00'),
(4, 3, 'QR112233445', 'App', 0, NULL);

CREATE TABLE PaymentGateway (
    gateway_id INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

INSERT INTO PaymentGateway (name)
VALUES 
('PayPal'),
('Bill Desk'),
('Stripe'),
('PhonePe'),
('Google Pay');

CREATE TABLE Payment (
    payment_id INT IDENTITY(1,1) PRIMARY KEY,
    booking_id INT NOT NULL,
    gateway_id INT NOT NULL,
    transaction_amount DECIMAL(10,2) NOT NULL,
    transaction_datetime DATETIME NOT NULL,
    status VARCHAR(20) NOT NULL,
    failure_reason TEXT NULL,
    credit_card_name VARCHAR(100) NULL,
    credit_card_number VARCHAR(20) NULL,
    expiry_date DATE NULL,
    cvv VARCHAR(4) NULL,
    FOREIGN KEY (booking_id) REFERENCES Booking(booking_id),
    FOREIGN KEY (gateway_id) REFERENCES PaymentGateway(gateway_id)
);

INSERT INTO Payment (
    booking_id, gateway_id, transaction_amount, transaction_datetime,
    status, failure_reason, credit_card_name, credit_card_number, expiry_date, cvv
)
VALUES 
(2, 1, 499.99, GETDATE(), 'Completed', NULL, 'John Doe', '4111111111111111', '2026-08-31', '123'),
(3, 2, 299.50, GETDATE(), 'Failed', 'Insufficient funds', 'Jane Smith', '5500000000000004', '2025-12-31', '456'),
(4, 3, 150.00, GETDATE(), 'Completed', NULL, 'Alex Kumar', '340000000000009', '2027-04-30', '789');


CREATE TABLE FoodItem (
    item_id INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT NULL,
    is_combo BIT NOT NULL DEFAULT 0
);
CREATE TABLE FoodItemSize (
    size_id INT IDENTITY(1,1) PRIMARY KEY,
    item_id INT NOT NULL,
    size_name VARCHAR(50) NOT NULL,
    rate DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (item_id) REFERENCES FoodItem(item_id)
);
CREATE TABLE FoodOrder (
    order_id INT IDENTITY(1,1) PRIMARY KEY,
    booking_id INT NOT NULL,
    screen_id INT NOT NULL,
    seat_id INT NOT NULL,
    order_datetime DATETIME NOT NULL,
    total_cost DECIMAL(10,2) NOT NULL,
    delivery_method VARCHAR(50) NOT NULL,
    FOREIGN KEY (booking_id) REFERENCES Booking(booking_id),
    FOREIGN KEY (screen_id) REFERENCES Screen(screen_id),
    FOREIGN KEY (seat_id) REFERENCES Seat(seat_id)
);

CREATE TABLE FoodOrderItem (
    order_item_id INT IDENTITY(1,1) PRIMARY KEY,
    order_id INT NOT NULL,
    item_id INT NOT NULL,
    size_id INT NOT NULL,
    quantity INT NOT NULL,
    price_at_time DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES FoodOrder(order_id),
    FOREIGN KEY (item_id) REFERENCES FoodItem(item_id),
    FOREIGN KEY (size_id) REFERENCES FoodItemSize(size_id)
);

CREATE TABLE PointsTransaction (
    transaction_id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    points_earned INT NOT NULL,
    transaction_datetime DATETIME NOT NULL,
    transaction_type VARCHAR(20) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES [User](user_id)
);










****===data insertion+***

INSERT INTO Screen (name, class_type, capacity) VALUES
('Screen 1', 'Gold', 100),
('Screen 2', 'Silver', 80);


INSERT INTO Seat (seat_number, screen_id) VALUES
('A1', 1), ('A2', 1), ('A3', 1),
('B1', 2), ('B2', 2);

INSERT INTO Movie (title, genre, rating, status, poster_image_url) VALUES
('Inception', 'Sci-Fi', 8.8, 'Running', 'https://img.com/inception.jpg'),
('Avengers', 'Action', 9.0, 'Running', 'https://img.com/avengers.jpg');

INSERT INTO MovieCast (movie_id, person_name, role) VALUES
(1, 'Leonardo DiCaprio', 'Actor'),
(1, 'Christopher Nolan', 'Director'),
(2, 'Robert Downey Jr.', 'Actor');

INSERT INTO Review (movie_id, content, review_date, reviewer_name) VALUES
(1, 'Amazing movie with great plot!', GETDATE(), 'Alice'),
(2, 'Loved the action scenes!', GETDATE(), 'Bob');

INSERT INTO Show (screen_id, movie_id, show_datetime) VALUES
(1, 1, '2025-06-11 10:00:00'),
(2, 2, '2025-06-11 13:00:00');

INSERT INTO ShowSeat (show_id, seat_id, is_available) VALUES
(1, 1, 1), (1, 2, 0), (2, 4, 1);

INSERT INTO [User] (name, email, phone) VALUES
('John Doe', 'john@example.com', '9999999999'),
('Jane Smith', 'jane@example.com', '8888888888');

INSERT INTO Membership (user_id, current_points) VALUES
(1, 100),
(2, 50);



INSERT INTO Booking (user_id, show_id, booking_datetime, total_cost) VALUES
(1, 1, GETDATE(), 300.00),
(2, 2, GETDATE(), 250.00);

INSERT INTO Ticket (booking_id, show_seat_id, qr_code, delivery_method, is_downloaded, scanned_at)
VALUES 
(1, 1, 'QR123456', 'WhatsApp', 1, GETDATE()),
(2, 2, 'QR654321', 'App', 0, NULL);

SELECT booking_id FROM Booking;




SELECT * FROM Ticket;

INSERT INTO PaymentGateway (name)
VALUES 
('PayPal'),
('Bill Desk');

INSERT INTO Payment (booking_id, gateway_id, transaction_amount, transaction_datetime, status, failure_reason, credit_card_name, credit_card_number, expiry_date, cvv)
VALUES 
(1, 1, 299.99, GETDATE(), 'Completed', NULL, 'John Doe', '1234567890123456', '2026-12-01', '123'),
(2, 2, 250.00, GETDATE(), 'Failed', 'Card declined', 'Jane Smith', '9876543210987654', '2025-08-01', '321');

INSERT INTO FoodItem (name, description, is_combo)
VALUES 
('Popcorn', 'Classic salted popcorn', 0),
('Combo Meal', 'Popcorn + Soft Drink Combo', 1),
('Soft Drink', 'Cold beverage', 0);

INSERT INTO FoodItemSize (item_id, size_name, rate)
VALUES 
(1, 'Small', 100.00),
(1, 'Large', 150.00),
(2, 'Standard', 200.00),
(3, 'Medium', 80.00);

INSERT INTO FoodOrder (booking_id, screen_id, seat_id, order_datetime, total_cost, delivery_method)
VALUES 
(2, 1, 1, GETDATE(), 180.00, 'QR'),
(3, 1, 1, GETDATE(), 250.00, 'Manual'),
(4, 1, 1, GETDATE(), 300.00, 'QR');

INSERT INTO FoodOrderItem (order_id, item_id, size_id, quantity, price_at_time)
VALUES 
(1, 1, 1, 2, 200.00),
(2, 2, 3, 1, 200.00),
(3, 3, 4, 3, 240.00);



INSERT INTO PointsTransaction (
    user_id, amount, points_earned, transaction_datetime, transaction_type
)

VALUES 
(2, 500.00, 50, GETDATE(), 'Booking');

SELECT user_id, name FROM [User];

INSERT INTO PointsTransaction (
    user_id, amount, points_earned, transaction_datetime, transaction_type
)
VALUES 
(9, 500.00, 50, GETDATE(), 'Booking'),
(10, 250.00, 25, GETDATE(), 'Food'),
(11, 100.00, 10, GETDATE(), 'Redemption');


SELECT * FROM Screen;
SELECT * FROM Seat;
SELECT * FROM Movie;
SELECT * FROM moviecast;
SELECT * FROM review;
SELECT * FROM SHOW;
SELECT * FROM SHOWSEAT;
SELECT * FROM [USER];
SELECT * FROM MEMBERSHIP;
SELECT * FROM BOOKING;
SELECT * FROM fooditem;
SELECT * FROM foodorder item;

*** insert**

INSERT INTO Movie (title, genre, rating, status)
VALUES ('Interstellar', 'Sci-Fi', 8.6, 'Running');

SELECT * FROM  MOVIE;

INSERT INTO [User] (name, email, phone)
VALUES ('Alice Cooper', 'alice@xyz.com', '7777777777');


INSERT INTO [User] (name, email, phone)
VALUES ('Alice Cooper', 'alice@xyz.com', '7777777777');
SELECT * FROM [USER]

     ***where clause***


SELECT * FROM Movie
WHERE status = 'Running';

SELECT * FROM [User]
WHERE name = 'John Doe';



****update***

UPDATE Movie
SET rating = 9.2
WHERE title = 'Avengers';

UPDATE ShowSeat
SET is_available = 0
WHERE seat_id = 1 AND show_id = 1;
SELECT * FROM ShowSeat;


**___delete__*


DELETE FROM Booking
WHERE booking_id = 1;

SELECT * FROM BOOKING;


DELETE FROM [User]
WHERE user_id = 3;

SELECT * FROM BOOKING;




*____drop****

DROP TABLE Membership;
SELECT * FROM MEMBERSHIP;


**----order by, offset---**

SELECT * FROM Movie
ORDER BY movie_id
OFFSET 0 ROWS FETCH NEXT 2 ROWS ONLY;



SELECT * FROM Movie
ORDER BY movie_id
OFFSET 2 ROWS FETCH NEXT 2 ROWS ONLY;

SELECT * FROM Movie ORDER BY movie_id OFFSET 0 ROWS FETCH NEXT 2 ROWS ONLY;


SELECT * FROM Movie ORDER BY movie_id OFFSET 2 ROWS FETCH NEXT 2 ROWS ONLY;


SELECT * FROM Movie ORDER BY movie_id OFFSET 4 ROWS FETCH NEXT 2 ROWS ONLY;
   USE MovieBookingSystem;
GO



SELECT title, genre, rating
FROM Movie
ORDER BY genre ASC, rating DESC;

  SELECT user_id, name
FROM [User]
ORDER BY name ASC;


  **----null**
  
   SELECT * FROM [User]
WHERE phone IS NULL;

** -----not null**

SELECT * FROM [User]
WHERE phone IS NOT NULL;


-----order by -----

SELECT * FROM Movie
ORDER BY rating DESC;

sELECT title, genre, rating
FROM Movie
ORDER BY genre ASC, rating DESC;



_____where+and__

SELECT * FROM Movie
WHERE status = 'Running' AND rating > 8;

----where+or--
SELECT * FROM Movie
WHERE status = 'Running' OR rating > 9;

***not***
SELECT * FROM Movie
WHERE NOT status = 'Released';


----WHERE with datetime)----

SELECT * FROM Show
WHERE show_datetime > '2025-06-10 12:00:00';



--between
SELECT * FROM Booking
WHERE total_cost BETWEEN 200 AND 300;

---0r-----
SELECT * FROM [User]
WHERE name = 'John Doe' OR name = 'Jane Smith';


---is null-----


sELECT * FROM Movie
WHERE poster_image_url IS NULL;

----ascending/desc---

SELECT * 
FROM Movie
ORDER BY genre ASC, rating DESC;

SELECT * 
FROM [User]
ORDER BY name ASC, email DESC;

SELECT * 
FROM Show
ORDER BY show_datetime DESC, screen_id ASC;

-----orderby offset fetch----

SELECT * 
FROM Movie
ORDER BY movie_id
OFFSET 1ROWS 
FETCH NEXT 3ROWS ONLY;


SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Movie'
ORDER BY COLUMN_NAME
OFFSET 2 ROWS 
FETCH NEXT 2 ROWS ONLY;


---groupby----

SELECT genre, COUNT(*) AS movie_count
FROM Movie
WHERE rating > 3.0
GROUP BY genre;
 select*from movie;

SELECT genre, AVG(rating) AS avg_rating
FROM Movie
GROUP BY genre;


SELECT department_id, 
       AVG(salary) AS average_salary
FROM employees
GROUP BY department_id;




--joints----
--inner---

SELECT u.name, b.booking_id 
FROM [User] u
INNER JOIN Booking b ON u.user_id = b.user_id;

select * from [user];
select * from booking;

SELECT u.name, se.seat_number, t.qr_code
FROM [User] u
INNER JOIN Booking b ON u.user_id = b.user_id
INNER JOIN Ticket t ON b.booking_id = t.booking_id
INNER JOIN ShowSeat ss ON t.show_seat_id = ss.show_seat_id
INNER JOIN Seat se ON ss.seat_id = se.seat_id
WHERE t.is_downloaded = 1;

SELECT m.title, r.rating, r.comment
FROM Movie m
INNER JOIN Review r ON m.movie_id = r.movie_id;


----left join--

SELECT u.name, b.booking_id 
FROM [User] u
LEFT JOIN Booking b ON u.user_id = b.user_id;

SELECT m.title, r.review_date, r.reviewer_name
FROM Movie m
LEFT JOIN Review r ON m.movie_id = r.movie_id;


---right join---

SELECT u.name, b.booking_id 
FROM [User] u
RIGHT JOIN Booking b ON u.user_id = b.user_id;


SELECT t.ticket_id, ss.show_seat_id, ss.is_available
FROM Ticket t
RIGHT JOIN ShowSeat ss ON t.show_seat_id = ss.show_seat_id;


----outer join--
SELECT u.name, b.booking_id 
FROM [User] u
FULL OUTER JOIN Booking b ON u.user_id = b.user_id;

SELECT fo.order_id, b.booking_id, fo.total_cost
FROM FoodOrder fo
FULL OUTER JOIN Booking b ON fo.booking_id = b.booking_id;


----checking null----

SELECT u.name, b.booking_id
FROM [User] u
LEFT JOIN Booking b ON u.user_id = b.user_id
WHERE b.booking_id IS NULL; 



select * from [user];
select * from booking;







String Functions-----------

SELECT name, LEN(name) AS name_length 
FROM [User];

SELECT UPPER(name) AS upper_name, LOWER(name) AS lower_name 
FROM [User];


SELECT name, SUBSTRING(name, 1, 6) AS short_name 
FROM [User];


SELECT name, CHARINDEX('o', name) AS position_of_a 
FROM [User];
SELECT CONCAT(name, ' <', email, '>') AS full_contact
FROM [User];

SELECT name,
       LEFT(name, 3) AS first_three,
       RIGHT(name, 3) AS last_three
FROM [User];




--agregate functions--


SELECT 
    COUNT(*) AS total_bookings,
    SUM(total_cost) AS total_revenue,
    AVG(total_cost) AS average_booking_cost
FROM Booking;

-----sum--
SELECT SUM(total_cost) AS total_revenue FROM Booking;

SELECT user_id, SUM(points_earned) AS total_points
FROM PointsTransaction
GROUP BY user_id;

select*from pointstransaction;

 ---avg==

SELECT AVG(total_cost) AS average_booking_cost FROM Booking;
SELECT gateway_id, AVG(transaction_amount) AS avg_transaction
FROM Payment
GROUP BY gateway_id;



--min--

SELECT MIN(booking_datetime) AS earliest_booking FROM Booking;
SELECT MIN(transaction_amount) AS lowest_payment FROM Payment;

select * from payment;



----max----
SELECT MAX(booking_datetime) AS latest_booking FROM Booking;


---group by clause /having-----------


SELECT user_id, COUNT(*) AS booking_count
FROM Booking
WHERE booking_datetime >= '2024-01-01'
GROUP BY user_id
HAVING COUNT(*) > 1;



select* from booking;


----date functions---


SELECT GETDATE() AS current_datetime;

SELECT 
  user_id, 
  DATEPART(YEAR, booking_datetime) AS booking_year,
  DATEPART(MONTH, booking_datetime) AS booking_month
FROM Booking;



SELECT * 
FROM Booking 
WHERE booking_datetime BETWEEN '2024-01-01' AND '2024-12-31';

SELECT 
  booking_id,
  DATEDIFF(DAY, booking_datetime, GETDATE()) AS days_since_booking
FROM Booking;


-----mathmatical function-----

SELECT transaction_id, amount, ABS(amount) AS absolute_amount
FROM PointsTransaction;


SELECT payment_id, transaction_amount,
       CEILING(transaction_amount) AS rounded_up
FROM Payment;


SELECT payement_id, transaction_amount,
       FLOOR(transaction_amount) AS rounded_down
FROM Payment;

SELECT payment_id, transaction_amount,
       SQRT(transaction_amount) AS sqrt_amount
FROM Payment;



USE MovieBookingSystem;
GO



-------ordrby in subqueries-----



SELECT name
FROM [User]
WHERE user_id = (
    SELECT user_id
    FROM Booking
    ORDER BY total_cost DESC
);






SELECT name
FROM [User]
WHERE user_id = (
    SELECT TOP 1 user_id
    FROM Booking
    ORDER BY total_cost DESC
);


-----grant -
GRANT SELECT ON Booking TO report_user;
GRANT SELECT ON [User] TO report_user;
GRANT SELECT ON Payment TO report_user;


-- Create server-level login
CREATE LOGIN report_user WITH PASSWORD = 'StrongPass@123';

-- Create database-level user in your current DB
CREATE USER report_user FOR LOGIN report_user;



-- Give permission to read Booking and User tables---

GRANT SELECT ON Booking TO report_user;
GRANT SELECT ON [User] TO report_user;

SELECT * FROM Booking;

GRANT SELECT ON Movie TO report_user;
GRANT SELECT ON Booking TO report_user;

GRANT INSERT ON Review TO report_user;
GRANT INSERT ON Payment TO report_user;

 GRANT UPDATE ON ShowSeat TO report_user;
GRANT UPDATE ON FoodOrder TO report_user;

GRANT DELETE ON Ticket TO report_user;




------revoke---
REVOKE SELECT ON Booking FROM report_user;
REVOKE SELECT ON [User] FROM report_user;


REVOKE SELECT ON Movie FROM report_user;


REVOKE INSERT ON Review FROM report_user;
REVOKE UPDATE ON FoodOrder FROM report_user;
REVOKE DELETE ON Ticket FROM report_user;



----at once--

REVOKE SELECT, INSERT, UPDATE, DELETE ON PointsTransaction FROM report_user;

   
     ---case statments----------

   SELECT 
    title,
    rating,
    CASE 
        WHEN rating >= 8 THEN 'Hit'
        WHEN rating >= 5 THEN 'Average'
        ELSE 'Flop'

    END AS MovieStatus
FROM Movie;


SELECT * 
FROM Show
WHERE 
    show_datetime >= 
    CASE 
        WHEN DATEPART(HOUR, GETDATE()) < 28 THEN GETDATE()
        ELSE DATEADD(DAY, 1, GETDATE())
    END;


    SELECT * 
FROM Screen
ORDER BY 
    CASE 
        WHEN class_type = 'Premium' THEN 1
        WHEN class_type = 'Standard' THEN 2
        ELSE 3
    END;


    UPDATE ShowSeat
SET is_available = 
    CASE 
        WHEN is_available = 1 THEN 0
        ELSE 1
    END
WHERE show_id = 1;




-----subquerie---

SELECT name 
FROM [User]
WHERE user_id IN (
    SELECT DISTINCT user_id 
    FROM Booking
);

SELECT name 
FROM [User]
WHERE user_id = (
    SELECT TOP 1 user_id
    FROM Booking
    ORDER BY total_cost DESC
);

