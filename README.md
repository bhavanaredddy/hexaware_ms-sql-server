This repository contains two major database projects built using MS SQL Server as part of hands-on database development practice. The aim was to design, implement, and optimize relational databases using SQL best practices, covering a wide range of real-world operations.

🔍 Overview
The repository includes:

✅ A Movie Booking System database

✅ An E-commerce System database

Both projects focus on real-time applications and showcase skills in:

📐 Database Design (ER Diagrams)

🔄 Normalization up to 3rd Normal Form (3NF)

🧩 JOIN operations (INNER, LEFT, RIGHT, FULL)

📑 SQL Queries (CREATE, INSERT, UPDATE, DELETE, SELECT)

🎯 Constraints, Foreign Keys, and Primary Keys

⚙️ Stored Procedures, Transactions, and ACID Properties (optional but recommended)

🎬 1. Movie Booking System
This system simulates the backend of an online movie ticket booking application.

Key Tables:
Movie

Show

Screen

Seat

User

Membership

Ticket

Review

ShowSeat

MovieCast

Features:
Tracks users, shows, and seat availability

Uses complex JOINs to fetch consolidated data (e.g., movie reviews, user bookings)

Implements data integrity with constraints

Demonstrates normalized structure for better query performance

🛒 2. E-commerce Database System
This project models a simplified e-commerce platform backend.

Key Tables:
Orders

Products

OrderDetails

Features:
Demonstrates Normalization from 1NF to 3NF

Splits unstructured customer_details into multiple tables

Includes relational joins to view full order/product breakdown

Handles multiple products per order with quantity tracking

📌 Learning Outcomes
Through these projects, the following concepts were implemented and practiced:

Relational Database Modeling

Converting ER Diagrams into SQL Tables

Applying Normal Forms (1NF, 2NF, 3NF)

Writing efficient SQL queries using JOINs

Ensuring data consistency and referential integrity

🛠️ Tech Stack
Database: Microsoft SQL Server

Tools: SQL Server Management Studio (SSMS), Git & GitHub

Language: SQL (T-SQL)
