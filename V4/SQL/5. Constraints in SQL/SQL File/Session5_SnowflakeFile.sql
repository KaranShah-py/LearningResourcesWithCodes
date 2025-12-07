-- Session 5 - Understand the more about tables and the possible constraints 

-- Pre code in SQL 
-- Using the role for the worksheet
USE ROLE ACCOUNTADMIN;

-- Use a compute resource 
USE WAREHOUSE COMPUTE_WH; 

-- Creating a database for this session 
CREATE DATABASE IF NOT EXISTS Session5_Constraints_database;

-- Using the database created 
USE DATABASE Session5_Constraints_database;

-- Creating a schema for this session 
CREATE SCHEMA IF NOT EXISTS Session5_Constraints_Schema;

-- Using the schema created
USE SCHEMA Session5_Constraints_Schema; 

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
CREATE OR REPLACE TABLE LOCATION_INFO ( 
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


-- TABLE 2 - STORE TABLE 
CREATE OR REPLACE TABLE STORE_INFO (
    STORE_ID INT AUTOINCREMENT START 1 INCREMENT 1 ORDER, 
    STORE_POSTAL_CODE INT,
    STORE_START_DATE DATE,
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


-- EMPLOYEES TABLE 
CREATE OR REPLACE TABLE EMPLOYEE_INFO (
    EMPLOYEE_ID INT AUTOINCREMENT START 1 INCREMENT 1 ORDER,
    EMPLOYEE_NAME VARCHAR(100), 
    EMPLOYEE_STORE_ID INT, 
    EMPLOYEE_SALARY INT, 
    EMPLOYEE_AGE INT,
    PRIMARY KEY (EMPLOYEE_ID),
    FOREIGN KEY (EMPLOYEE_STORE_ID) REFERENCES STORE_INFO(STORE_ID)
);


-- INSERTING SOME VALUES INSIDE THE TABLE 
INSERT INTO EMPLOYEE_INFO
(EMPLOYEE_NAME, EMPLOYEE_STORE_ID, EMPLOYEE_SALARY, EMPLOYEE_AGE)
VALUES 
('Karan Shah', 9, 10000, 25),
('Vinod Jaiswal', 9, 15000, 27),
('Rakesh Sahoo', 10, 20000, 29),
('Satish Kumar', 11, 10000, 25),
('Bhaswati Saikia', 12, 10000, 29),
('Aakash Drives', 13, 10400, 21),
('Raj Sharma', 14, 13000, 23),
('Riya Kadam', 15, 12000, 26),
('Shah Rukh Khan', 16, 12000, 25);










































