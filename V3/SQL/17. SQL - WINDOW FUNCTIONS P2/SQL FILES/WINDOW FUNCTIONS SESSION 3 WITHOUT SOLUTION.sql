-- ASSIGNING THE ACCOUNT TYPE 
USE ROLE ACCOUNTADMIN;

-- USING THE WAREHOUSE AVAILABLE
USE WAREHOUSE COMPUTE_WH;

-- CREATING A DATABASE NAMED AS SUBQUERIES_DATABASE
CREATE DATABASE IF NOT EXISTS WINDOW_FUNCTIONS_SESSION_3_DB;

-- USING THE DATABASE CREATED
USE DATABASE WINDOW_FUNCTIONS_SESSION_3_DB;

-- CREATING A SCHEMA NAMED AS SUBQUERIES_SCHEMA
CREATE SCHEMA IF NOT EXISTS WINDOW_FUNCTIONS_SESSION_3_SCHEMA;

-- USING THE SCHEMA CREATED 
USE SCHEMA WINDOW_FUNCTIONS_SESSION_3_SCHEMA;

-- Practice Question 
-- QUESTION 1
/*
    Tables:
        Students(student_id, student_name)
        Subjects(subject_name)
        Examinations(student_id, subject_name) (may have duplicates)
    Task: 
        Write a query to find how many times each student attended each subject's exam.
    Return:
        student_id, student_name, subject_name, attended_exams
        Sort by student_id, then subject_name.
*/



-- Creating the tables for the question
CREATE OR REPLACE TABLE Students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(50)
);

CREATE OR REPLACE TABLE Subjects (
    subject_name VARCHAR(50) PRIMARY KEY
);

CREATE OR REPLACE TABLE Examinations (
    student_id INT,
    subject_name VARCHAR(50),
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (subject_name) REFERENCES Subjects(subject_name)
);


-- Inserting Data into the tables 
INSERT INTO Students (student_id, student_name) VALUES
(1, 'Alice'),
(2, 'Bob'),
(13, 'John'),
(6, 'Alex');

INSERT INTO Subjects (subject_name) VALUES
('Math'),
('Physics'),
('Programming');

INSERT INTO Examinations (student_id, subject_name) VALUES
(1, 'Math'),
(1, 'Physics'),
(1, 'Programming'),
(2, 'Programming'),
(1, 'Physics'),
(1, 'Math'),
(13, 'Math'),
(13, 'Programming'),
(13, 'Physics'),
(2, 'Math'),
(1, 'Math');




-- Window functions 
-- Creating a table named Sales_order
CREATE OR REPLACE TABLE sales_orders (
    order_id INT,
    customer_name STRING,
    order_date DATE,
    sales_amount DECIMAL(10,2),
    region STRING
);

-- Inserting records into the table Sales_Order 
INSERT INTO sales_orders (order_id, customer_name, order_date, sales_amount, region) VALUES
(101, 'Amit', '2025-01-05', 5000.00, 'North'),
(102, 'Amit', '2025-01-15', 3000.00, 'North'),
(103, 'Amit', '2025-02-01', 4500.00, 'North'),
(104, 'Bhavna', '2025-01-10', 7000.00, 'South'),
(105, 'Bhavna', '2025-02-05', 2000.00, 'South'),
(106, 'Bhavna', '2025-02-20', 8000.00, 'South'),
(107, 'Chetan', '2025-01-07', 6500.00, 'West'),
(108, 'Chetan', '2025-01-25', 4000.00, 'West'),
(109, 'Chetan', '2025-03-01', 7500.00, 'West'),
(110, 'Deepa', '2025-01-12', 6000.00, 'East'),
(111, 'Deepa', '2025-03-15', 9000.00, 'East'),
(112, 'Amit', '2025-03-01', 5500.00, 'North'),
(113, 'Amit', '2025-03-20', 6200.00, 'North'),
(114, 'Bhavna', '2025-03-05', 4000.00, 'South'),
(115, 'Bhavna', '2025-03-18', 9000.00, 'South'),
(116, 'Chetan', '2025-03-15', 5000.00, 'West'),
(117, 'Chetan', '2025-04-02', 6500.00, 'West'),
(118, 'Deepa', '2025-04-01', 7500.00, 'East'),
(119, 'Deepa', '2025-04-20', 8200.00, 'East');




-- OPEN MYSQL WORKBENCH TO SEE THE DIFFERENCE
/*
                CREATE DATABASE IF NOT EXISTS window_functions_session_3;
                
                USE window_functions_session_3;
                
                CREATE TABLE IF NOT EXISTS sales_orders (
                    order_id INT,
                    customer_name VARCHAR(100),
                    order_date DATE,
                    sales_amount DECIMAL(10,2),
                    region VARCHAR(100)
                );
                
                -- Inserting records into the table Sales_Order 
                INSERT INTO sales_orders (order_id, customer_name, order_date, sales_amount, region) VALUES
                (101, 'Amit', '2025-01-05', 5000.00, 'North'),
                (102, 'Amit', '2025-01-15', 3000.00, 'North'),
                (103, 'Amit', '2025-02-01', 4500.00, 'North'),
                (104, 'Bhavna', '2025-01-10', 7000.00, 'South'),
                (105, 'Bhavna', '2025-02-05', 2000.00, 'South'),
                (106, 'Bhavna', '2025-02-20', 8000.00, 'South'),
                (107, 'Chetan', '2025-01-07', 6500.00, 'West'),
                (108, 'Chetan', '2025-01-25', 4000.00, 'West'),
                (109, 'Chetan', '2025-03-01', 7500.00, 'West'),
                (110, 'Deepa', '2025-01-12', 6000.00, 'East'),
                (111, 'Deepa', '2025-03-15', 9000.00, 'East'),
                (112, 'Amit', '2025-03-01', 5500.00, 'North'),
                (113, 'Amit', '2025-03-20', 6200.00, 'North'),
                (114, 'Bhavna', '2025-03-05', 4000.00, 'South'),
                (115, 'Bhavna', '2025-03-18', 9000.00, 'South'),
                (116, 'Chetan', '2025-03-15', 5000.00, 'West'),
                (117, 'Chetan', '2025-04-02', 6500.00, 'West'),
                (118, 'Deepa', '2025-04-01', 7500.00, 'East'),
                (119, 'Deepa', '2025-04-20', 8200.00, 'East');
*/





-- PRACTICE QUESTIONS
-- CREATING TABLE
CREATE OR REPLACE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    department VARCHAR(50),
    age INT,
    salary DECIMAL(10, 2)
);


-- INSERTING VALUES 
INSERT INTO employees (id, name, department, age, salary) VALUES
(1, 'John Doe', 'HR', 30, 50000.00),
(2, 'Jane Smith', 'IT', 25, 70000.00),
(3, 'Michael Brown', 'Finance', 40, 85000.00),
(4, 'Emily Davis', 'IT', 35, 75000.00),
(5, 'Chris Johnson', 'HR', 28, 55000.00),
(6, 'Anna Wilson', 'Finance', 50, 90000.00),
(7, 'David Lee', 'IT', 45, 80000.00),
(8, 'Sophia King', 'HR', 26, 53000.00),
(9, 'James White', 'Finance', 38, 88000.00),
(10, 'Olivia Green', 'IT', 32, 72000.00),
(11, 'Robert Hall', 'Finance', 29, 76000.00),
(12, 'Linda Young', 'HR', 41, 60000.00),
(13, 'William Scott', 'IT', 27, 69000.00),
(14, 'Patricia Adams', 'Finance', 33, 82000.00),
(15, 'Charles Baker', 'HR', 48, 64000.00),
(16, 'Barbara Turner', 'IT', 36, 77000.00),
(17, 'Daniel Harris', 'Finance', 42, 88000.00),
(18, 'Nancy Martin', 'IT', 31, 71000.00),
(19, 'Thomas Thompson', 'HR', 37, 59000.00),
(20, 'Karen Rodriguez', 'Finance', 46, 93000.00);


-- LEAD() FUNCTION
-- Q1 – Simple LEAD() Example
/*
    Find each employee’s salary along with the next employee’s salary based on salary order (whole company, no department grouping).
*/



-- Q2 – LEAD() with PARTITION BY
/*
    Find each employee’s salary and the salary of the next employee in the same department based on salary order.
*/




-- LAG()
-- Q1 – Simple LAG() Example
/*
    Find each employee’s salary along with the previous employee’s salary based on salary order (whole company, no department grouping).
*/



-- Q2 – LAG() with PARTITION BY 
/*
    Find each employee’s salary and the salary of the previous employee in the same department based on salary order.
*/