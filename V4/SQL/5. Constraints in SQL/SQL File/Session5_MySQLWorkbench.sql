-- Session 5 - Understand the more about tables and the possible constraints 
/*
	1. Primay Key - Done
    2. Foreign key - Done 
    3. Unique  - Done 
    4. NOT NULL - Done
    5. CHECK - Done
    6. DEFAULT - Done 
    7. AUTO INCREMENT CONSTRAINT - Done
*/

-- Pre code in SQL 
-- Creating a database for this session 
CREATE DATABASE IF NOT EXISTS Session5_Constraints_database;

-- Using the database created 
USE Session5_Constraints_database;

-- Use Case 
/*
    Suppose you have a client that has multiple retail chain outlet and he / she 
    is facing difficulties to manage and store the data about each and every 
    employee working in the stores. 
    Basis on the client discussion, the client has mentioned that the business
    is spread across multiple regions in India and in the following cities 
    1. Mumbai
    2. Pune
    3. Ahemdabad
    4. Baroda
    Also, the client has mentioned that there are two types of employees that are
    hired contract and permanent
    Lastly, the client wants to build a simple and straight forward database that can 
    store and manage the data. 
*/

-- Proposed Solution to the client 
/*
    How many tables will you create?
    1. Location Table 
    2. OutletStore Table 
    3. Employee Table
*/

-- Creating the tables 
-- Table 1 - location table 
CREATE TABLE IF NOT EXISTS LOCATION_INFO ( 
    LOCATION_CITY VARCHAR(100), 
    LOCATION_STATE VARCHAR(100), 
    LOCATION_POSTAL_CODE INT, 
    PRIMARY KEY (LOCATION_POSTAL_CODE)
);

-- INSERTING THE VALUES INSIDE THE LOCATION TABLE 
INSERT INTO LOCATION_INFO 
(LOCATION_CITY, LOCATION_STATE, LOCATION_POSTAL_CODE)
VALUES
('Mumbai', 'Maharashtra', 400091), 
('Mumbai', 'Maharashtra', 400032), 
('Mumbai', 'Maharashtra', 400022), 
('Pune', 'Maharashtra', 700032),
('Pune', 'Maharashtra', 700055),
('Pune', 'Maharashtra', 700234),
('Ahemdabad', 'Gujarat', 600087),
('Baroda', 'Gujarat', 600067);

-- Displaying the locastion info table
select * from location_info;

-- TABLE 2 - STORE TABLE 
/*
	Client has mentioned that we do not have the exact start date for each and every store id 
    if the start date is not given we need to use the data Jan 1st 2022
    To solve this requirement one needs to use the default constraint
*/
CREATE TABLE IF NOT EXISTS STORE_INFO (
    STORE_ID INT AUTO_INCREMENT, 
    STORE_POSTAL_CODE INT,
    STORE_START_DATE DATE DEFAULT "2022-01-01",
    PRIMARY KEY (STORE_ID), 
    FOREIGN KEY (STORE_POSTAL_CODE) REFERENCES LOCATION_INFO(LOCATION_POSTAL_CODE)
);


-- INSERT VALUES INSIDE THE STORE TABLE
INSERT INTO STORE_INFO 
(STORE_POSTAL_CODE, STORE_START_DATE)
VALUES
(400091, '2025-01-01'),
(400032, '2025-03-01'), 
(400022, '2024-10-01'), 
(700032, '2024-11-01'),
(700055, '2025-10-01'),
(700234, '2023-01-01'),
(600087, '2025-01-01'),
(600067, '2024-10-01');

-- DISPLAYING THE RECORDS
SELECT *
FROM STORE_INFO;

-- Testing the Defualt constraint 
INSERT INTO STORE_INFO 
(STORE_POSTAL_CODE) 
VALUES (400091);


-- EMPLOYEES TABLE 
/*
	1. Name cannot be a blank / null value -- NOT NULL CONSTRAINT 
    2. Age must be always greater than 18 -- CHECK CONSTRAINT 
    3. Employee Salary must be greater than or equal to 10000 (provided by client) -- CHECK CONSTRAINT
*/
CREATE TABLE IF NOT EXISTS EMPLOYEE_INFO (
    EMPLOYEE_ID INT AUTO_INCREMENT,
    EMPLOYEE_NAME VARCHAR(100) NOT NULL, -- NOT NULL CONSTRAINT  
    EMPLOYEE_STORE_ID INT, 
    EMPLOYEE_SALARY INT, 
    EMPLOYEE_AGE INT,
    PRIMARY KEY (EMPLOYEE_ID),
    FOREIGN KEY (EMPLOYEE_STORE_ID) REFERENCES STORE_INFO(STORE_ID),
    CHECK (EMPLOYEE_SALARY >= 10000), -- IF IT IS LESS THAN 10000 THE RECORD MUST NOT BE INSERTED
    CHECK (EMPLOYEE_AGE > 18) -- IF IT IS LESS THAN 0 THAT IS NEGATIVE, IT MUST BE NOT ALLOWED
);


-- INSERTING SOME VALUES INSIDE THE TABLE 
INSERT INTO EMPLOYEE_INFO
(EMPLOYEE_NAME, EMPLOYEE_STORE_ID, EMPLOYEE_SALARY, EMPLOYEE_AGE)
VALUES 
('Karan Shah', 1, 10000, 25),
('Vinod Jaiswal', 1, 15000, 27),
('Rakesh Sahoo', 2, 20000, 29),
('Satish Kumar', 3, 10000, 25),
('Bhaswati Saikia', 4, 10000, 29),
('Aakash Drives', 5, 10400, 21),
('Raj Sharma', 6, 13000, 23),
('Riya Kadam', 7, 12000, 26),
('Shah Rukh Khan', 8, 12000, 25);


# Disaplying the table 
SELECT *
FROM EMPLOYEE_INFO;


# Testing the constraints 
/*
INSERT INTO EMPLOYEE_INFO
(EMPLOYEE_NAME, EMPLOYEE_STORE_ID, EMPLOYEE_SALARY, EMPLOYEE_AGE)
VALUES 
(NULL, 8, 10000, 25); -- not null constraint is working fine
*/

/*
INSERT INTO EMPLOYEE_INFO
(EMPLOYEE_NAME, EMPLOYEE_STORE_ID, EMPLOYEE_SALARY, EMPLOYEE_AGE)
VALUES 
('Salman Khan', 8, 9999, 25); -- Salary Check constraint is also working fine
*/

/*
INSERT INTO EMPLOYEE_INFO
(EMPLOYEE_NAME, EMPLOYEE_STORE_ID, EMPLOYEE_SALARY, EMPLOYEE_AGE)
VALUES 
('Salman Khan', 8, 12000, 15); -- Age Check Constraint is also working fine
*/


-- UNIQUE CONSTRAINT 
CREATE TABLE IF NOT EXISTS STUDENT_INFO (
    EMPLOYEE_ID INT AUTO_INCREMENT,
    EMPLOYEE_NAME VARCHAR(100) NOT NULL, -- NOT NULL CONSTRAINT  
    EMPLOYEE_STUDENT_EID VARCHAR(100),
    EMPLOYEE_TYPE VARCHAR(100), 
    PRIMARY KEY (EMPLOYEE_ID), 
    UNIQUE (EMPLOYEE_STUDENT_EID) -- UNIQUE KEY CONSTRAINT
);

-- 1 NULL VALUE INSIDE IT 
INSERT INTO STUDENT_INFO 
(EMPLOYEE_NAME, EMPLOYEE_STUDENT_EID, EMPLOYEE_TYPE)
VALUES
('Karan Shah', 'karan.shah@gmail.com', 'student');


-- DISPLAYING THE INFO 
SELECT * FROM STUDENT_INFO;

-- TESTING THE CONSTRAINT 
INSERT INTO STUDENT_INFO 
(EMPLOYEE_NAME, EMPLOYEE_STUDENT_EID, EMPLOYEE_TYPE)
VALUES
('Rajesh', null, 'Teacher'),
('Rakesh', null, 'Teacher'); -- unique key and that is the reason it has allowed one null value inside the table 


Error Code: 1062. Duplicate entry 'karan.shah@gmail.com' for key 'student_info.EMPLOYEE_STUDENT_EID'

