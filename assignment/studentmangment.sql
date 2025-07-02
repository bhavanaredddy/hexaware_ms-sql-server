CREATE DATABASE SISDB;
GO

USE SISDB;
GO

CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    date_of_birth DATE,
    email VARCHAR(100),
    phone_number VARCHAR(20)
);

CREATE TABLE Teachers (
    teacher_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100)
);

CREATE TABLE Courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100),
    course_code VARCHAR(20),
    teacher_id INT,
    FOREIGN KEY (teacher_id) REFERENCES Teachers(teacher_id)
);

CREATE TABLE Enrollments (
    enrollment_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    enrollment_date DATE,
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);

CREATE TABLE Payments (
    payment_id INT PRIMARY KEY,
    student_id INT,
    amount DECIMAL(10, 2),
    payment_date DATE,
    FOREIGN KEY (student_id) REFERENCES Students(student_id)
);

INSERT INTO Students VALUES
(1, 'John', 'Doe', '1995-08-15', 'john@example.com', '1234567890'),
(2, 'Jane', 'Smith', '1998-04-10', 'jane@example.com', '1234567891'),
(3, 'Alice', 'Brown', '1997-11-30', 'alice@example.com', '1234567892'),
(4, 'Bob', 'Johnson', '1999-01-05', 'bob@example.com', '1234567893'),
(5, 'Carol', 'Lee', '2000-02-20', 'carol@example.com', '1234567894'),
(6, 'Dave', 'Wilson', '1994-06-17', 'dave@example.com', '1234567895'),
(7, 'Eve', 'Taylor', '1996-12-25', 'eve@example.com', '1234567896'),
(8, 'Frank', 'Anderson', '1993-07-22', 'frank@example.com', '1234567897'),
(9, 'Grace', 'Thomas', '1995-10-08', 'grace@example.com', '1234567898'),
(10, 'Hank', 'White', '1992-03-12', 'hank@example.com', '1234567899');


INSERT INTO Teachers VALUES
(101, 'Sarah', 'Smith', 'sarah.smith@example.com'),
(102, 'Michael', 'Brown', 'michael.brown@example.com'),
(103, 'Emily', 'Davis', 'emily.davis@example.com'),
(104, 'David', 'Johnson', 'david.johnson@example.com'),
(105, 'Laura', 'Wilson', 'laura.wilson@example.com'),
(106, 'James', 'Taylor', 'james.taylor@example.com'),
(107, 'Rachel', 'Moore', 'rachel.moore@example.com'),
(108, 'Daniel', 'Clark', 'daniel.clark@example.com'),
(109, 'Sophia', 'Hall', 'sophia.hall@example.com'),
(110, 'Chris', 'Lewis', 'chris.lewis@example.com');

INSERT INTO Courses VALUES
(201, 'Introduction to Programming', 'CS101', 101),
(202, 'Mathematics 101', 'MA101', 102),
(203, 'Data Structures', 'CS102', 103),
(204, 'English Literature', 'EN101', 104),
(205, 'Physics Fundamentals', 'PH101', 105),
(206, 'Chemistry Basics', 'CH101', 106),
(207, 'Advanced Database Management', 'CS302', 107),
(208, 'Computer Networks', 'CS202', 108),
(209, 'Artificial Intelligence', 'CS401', 109),
(210, 'Operating Systems', 'CS301', 110);


INSERT INTO Enrollments VALUES
(301, 1, 201, '2024-01-10'),
(302, 1, 202, '2024-01-12'),
(303, 2, 203, '2024-01-15'),
(304, 3, 204, '2024-02-01'),
(305, 4, 205, '2024-02-10'),
(306, 5, 206, '2024-03-05'),
(307, 6, 207, '2024-03-10'),
(308, 7, 208, '2024-04-01'),
(309, 8, 209, '2024-04-08'),
(310, 9, 210, '2024-05-01');


INSERT INTO Payments VALUES
(401, 1, 500.00, '2024-01-20'),
(402, 2, 450.00, '2024-01-25'),
(403, 3, 300.00, '2024-02-05'),
(404, 4, 350.00, '2024-02-15'),
(405, 5, 400.00, '2024-03-10'),
(406, 6, 550.00, '2024-03-20'),
(407, 7, 600.00, '2024-04-05'),
(408, 8, 700.00, '2024-04-10'),
(409, 9, 500.00, '2024-05-05'),
(410, 10, 650.00, '2024-05-15');


----insert---
INSERT INTO Students (student_id, first_name, last_name, date_of_birth, email, phone_number)
VALUES (11, 'John', 'Doe', '1995-08-15', 'john.doe@example.com', '1234567890');

----update--
UPDATE Teachers
SET email = 'sarah.updated@example.com'
WHERE teacher_id = 101;


-----delete---
DELETE FROM Enrollments
WHERE student_id = 11 AND course_id = 201;

----updtae paymeny--
UPDATE Payments
SET amount = 550.00
WHERE payment_id = 401;


----joins and aggregations----

SELECT s.first_name, s.last_name, SUM(p.amount) AS total_paid
FROM Students s
JOIN Payments p ON s.student_id = p.student_id
WHERE s.student_id = 1
GROUP BY s.first_name, s.last_name;


SELECT c.course_name, COUNT(e.student_id) AS total_enrolled
FROM Courses c
LEFT JOIN Enrollments e ON c.course_id = e.course_id
GROUP BY c.course_name;


SELECT s.first_name, s.last_name, COUNT(e.course_id) AS courses_enrolled
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
GROUP BY s.student_id, s.first_name, s.last_name
HAVING COUNT(e.course_id) > 1;


----subqueries---

SELECT AVG(student_count) AS avg_enrollments
FROM (
    SELECT course_id, COUNT(student_id) AS student_count
    FROM Enrollments
    GROUP BY course_id
) AS sub;

SELECT s.first_name, s.last_name, p.amount
FROM Payments p
JOIN Students s ON p.student_id = s.student_id
WHERE p.amount = (
    SELECT MAX(amount) FROM Payments
);

SELECT t.first_name, t.last_name, SUM(p.amount) AS total_received
FROM Teachers t
JOIN Courses c ON t.teacher_id = c.teacher_id
JOIN Enrollments e ON c.course_id = e.course_id
JOIN Payments p ON e.student_id = p.student_id
GROUP BY t.first_name, t.last_name;

SELECT course_name
FROM Courses
WHERE course_id NOT IN (
    SELECT DISTINCT course_id FROM Enrollments
);


SELECT s.first_name, s.last_name, COUNT(p.payment_id) AS payment_count
FROM Students s
JOIN Payments p ON s.student_id = p.student_id
GROUP BY s.first_name, s.last_name
HAVING COUNT(p.payment_id) > 1;
