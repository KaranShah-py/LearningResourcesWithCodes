-- Session 4 - Keys Session 2  

-- Pre code in SQL 
-- Using the role for the worksheet
USE ROLE ACCOUNTADMIN;

-- Use a compute resource 
USE WAREHOUSE COMPUTE_WH; 

-- Creating a database for this session 
CREATE DATABASE IF NOT EXISTS Session3_Keys_database;

-- Using the database created 
USE DATABASE Session3_Keys_database;

-- Creating a schema for this session 
CREATE SCHEMA IF NOT EXISTS Session3_Keys_Schema;

-- Using the schema created
USE SCHEMA Session3_Keys_Schema; 

-- Use case to understand the concept of keys 
/*
    1. To create tables for the business requirement
    2. Implement the relationships between the table
    3. Insert some records into the table 
*/

-- Use case description 
/*
    Suppose that we have a client and the client has a business of E-commerce website 
    which is focusing on selling multiple products at a regional level. 
    The client is facing issues with the current method of storing the data. 
    The client has requested the team to come up with an idea to store the data efficiently 
    and in a more optimized manner than the current system. 
    We need to propose a solution for the same.
*/

-- Solution proposed approach 
/*
-- 1st step must be analysing the scale of the project
-- 2nd Business requirement from the client 
-- 3rd Step implementing a blue print of the database
-- 4th Review with the clients 
-- 5th UAT with the clients 
-- 6th Handover and User Training with the clients 
-- 7th Support to the client for x period of time 
-- 8th Closure of the project
*/

-- 1st Step - analysing the scale of the project
/*
    We are using snowflake as a tool to implement this
*/

-- 2nd Step - Business Requirement from the client 
/*
    1. Customers 
    2. Products
    3. Product Categories 
    4. LocationInfo
    5. Orders
*/

-- 3rd Step - Implementing the blue print of the requirement
/*
    Creating the required tables 
    syntax - 
    CREATE OR REPLACE TABLE <TABLE_NAME>
    (
        COLUMN_NAME DATATYPE, 
        COLUMN_NAME_N DATATYPE, 
        PRIMARY_KEY (<COLUMNS / COLUMN_NAMES*>)
    );
*/
-- Creating CUSTOMER table 
CREATE OR REPLACE TABLE Blinkit_Customer_2025
(
    CUSTOMER_ID INT AUTOINCREMENT START 1 INCREMENT 1, 
    CUSTOMER_NAME VARCHAR(100), 
    CUSTOMER_PHONE_NUMBER VARCHAR(100), 
    CUSTOMER_LOCATION_ID INT,
    PRIMARY KEY (CUSTOMER_ID)
);

-- Creating PRODUCT_CATEGORY Table
CREATE OR REPLACE TABLE Blinkit_Product_Category_2025
(
    PRODUCT_CATEGORY_ID INT AUTOINCREMENT START 1 INCREMENT 1, 
    PRODUCT_CATEGORY_NAME VARCHAR(100), 
    PRODUCT_START_DATE DATE,
    PRIMARY KEY (PRODUCT_CATEGORY_ID) 
);



-- Creating PRODUCTS Table
CREATE OR REPLACE TABLE Blinkit_Products_2025
(
    PRODUCT_ID INT AUTOINCREMENT START 1 INCREMENT 1, 
    PRODUCT_NAME VARCHAR(100), 
    PRODUCT_BRAND_NAME VARCHAR(100),
    PRODUCT_CATEGORY_NAME VARCHAR(100),
    PRIMARY KEY (PRODUCT_ID)
);

-- Creating LOCATION Table
CREATE OR REPLACE TABLE Blinkit_Location_2025
(
    LOCATION_ID INT AUTOINCREMENT START 1 INCREMENT 1, 
    LOCATION_STATE VARCHAR(100), 
    LOCATION_CITY VARCHAR(100), 
    PRIMARY KEY (LOCATION_ID)
);

-- Creating ORDERS Table
CREATE OR REPLACE TABLE Blinkit_Orders_2025
(
    ORDER_ID INT AUTOINCREMENT START 1 INCREMENT 1, 
    ORDER_CUSTOMER_ID VARCHAR(100), 
    ORDER_LOCATION_CITY VARCHAR(100),
    ORDER_PRODUCT_NAME VARCHAR(100),
    ORDER_VALUE FLOAT,
    PRIMARY KEY (ORDER_ID)
);


-- inserting the records into the customer table 
SELECT *
FROM BLINKIT_CUSTOMER_2025;

-- Without Auto Increment Constraint 
/*
INSERT INTO BLINKIT_CUSTOMER_2025 
VALUES 
(1, 'Karan Shah', '3456789212', 'Pune'), 
(2, 'Anand Jha', '3823672212', 'Mumbai'), 
(3, 'Parth', '3456789212', 'Bhopal'), 
(4, 'Ayoush Paul', '1237873912', 'Ahemdabad');
*/

/*
INSERT INTO BLINKIT_CUSTOMER_2025
VALUES 
(4, 'Tushar', '2319283283', 'Surat');
*/


-- With Auto Increment Constraint
INSERT INTO 
BLINKIT_CUSTOMER_2025 (CUSTOMER_NAME, CUSTOMER_PHONE_NUMBER, CUSTOMER_LOCATION_CITY)
VALUES 
('Karan Shah', '3456789212', 'Pune'), 
('Anand Jha', '3823672212', 'Mumbai'), 
('Parth', '3456789212', 'Bhopal'), 
('Ayoush Paul', '1237873912', 'Ahemdabad');

SELECT * FROM BLINKIT_CUSTOMER_2025;
SELECT * FROM BLINKIT_LOCATION_2025;
SELECT * FROM BLINKIT_ORDERS_2025;
SELECT * FROM BLINKIT_PRODUCTS_2025;
SELECT * FROM BLINKIT_PRODUCT_CATEGORY_2025;


-- Insert the values into the Location Table 
INSERT INTO 
BLINKIT_LOCATION_2025 (LOCATION_STATE, LOCATION_CITY)
VALUES
('Maharashtra', 'Pune'), 
('Maharashtra', 'Mumbai'), 
('Gujarat', 'Ahemdabad'), 
('Gujarat', 'Surat'), 
('Madhya Pradesh', 'Bhopal');


select *
from blinkit_location_2025;




SELECT *
FROM BLINKIT_CUSTOMER_2025;


INSERT INTO 
BLINKIT_CUSTOMER_2025
(CUSTOMER_NAME, CUSTOMER_PHONE_NUMBER, CUSTOMER_LOCATION_CITY)
VALUES 
('Tushar', '7685903456', 'Baroda');


SELECT *
FROM BLINKIT_CUSTOMER_2025;

SELECT *
FROM BLINKIT_LOCATION_2025;


-- If my business is not present in the city of Borada then how come I have customer over there?
-- Data Integrity
-- Foreign key 



-- Creating CUSTOMER table 
CREATE OR REPLACE TABLE Blinkit_Customer_2025
(
    CUSTOMER_ID INT AUTOINCREMENT START 1 INCREMENT 1, 
    CUSTOMER_NAME VARCHAR(100), 
    CUSTOMER_PHONE_NUMBER VARCHAR(100), 
    CUSTOMER_LOCATION_CITY VARCHAR(100), -- Foreign Key
    PRIMARY KEY (CUSTOMER_ID),
    FOREIGN KEY (CUSTOMER_LOCATION_CITY) REFERENCES Blinkit_Location_2025(LOCATION_CITY)
);

-- Creating LOCATION Table
CREATE OR REPLACE TABLE Blinkit_Location_2025
( 
    LOCATION_STATE VARCHAR(100), 
    LOCATION_CITY VARCHAR(100), -- Common Column acting as the reference column
    PRIMARY KEY (LOCATION_CITY)
);


-- INSERTING INTO THE LOCATION TABLE 
INSERT INTO 
BLINKIT_LOCATION_2025 (LOCATION_STATE, LOCATION_CITY)
VALUES
('Maharashtra', 'Pune'), 
('Maharashtra', 'Mumbai'), 
('Gujarat', 'Ahemdabad'), 
('Gujarat', 'Surat'), 
('Madhya Pradesh', 'Bhopal');

SELECT *
FROM BLINKIT_LOCATION_2025;


-- INSERTING INTO THE CUSTOMERS TABLE 
INSERT INTO 
BLINKIT_CUSTOMER_2025 (CUSTOMER_NAME, CUSTOMER_PHONE_NUMBER, CUSTOMER_LOCATION_CITY)
VALUES 
('Karan Shah', '3456789212', 'Pune'), 
('Anand Jha', '3823672212', 'Mumbai'), 
('Parth', '3456789212', 'Bhopal'), 
('Ayoush Paul', '1237873912', 'Ahemdabad');

-- INSERTING ANOTHER RECORD WITH A DIFFERENT CITY 
INSERT INTO 
BLINKIT_CUSTOMER_2025 (CUSTOMER_NAME, CUSTOMER_PHONE_NUMBER, CUSTOMER_LOCATION_CITY)
VALUES 
('Vinod', '8790653426', 'Baroda'); 

SELECT *
FROM BLINKIT_CUSTOMER_2025;



-- Creating PRODUCT_CATEGORY Table
CREATE OR REPLACE TABLE Blinkit_Product_Category_2025
(
    PRODUCT_CATEGORY_ID INT AUTOINCREMENT START 1 INCREMENT 1, 
    PRODUCT_CATEGORY_NAME VARCHAR(100), 
    PRODUCT_START_DATE DATE,
    UNIQUE (PRODUCT_CATEGORY_NAME)
);



-- Creating PRODUCTS Table
CREATE OR REPLACE TABLE Blinkit_Products_2025
(
    PRODUCT_ID INT AUTOINCREMENT START 1 INCREMENT 1, 
    PRODUCT_NAME VARCHAR(100), 
    PRODUCT_BRAND_NAME VARCHAR(100),
    PRODUCT_CATEGORY_NAME VARCHAR(100), -- FOREIGN KEY 
    PRIMARY KEY (PRODUCT_ID),
    FOREIGN KEY (PRODUCT_CATEGORY_NAME) REFERENCES Blinkit_Product_Category_2025(PRODUCT_CATEGORY_NAME)
);

-- inserting into the table Blinkit_Product_Category_2025
INSERT INTO Blinkit_Product_Category_2025
(PRODUCT_CATEGORY_NAME, PRODUCT_START_DATE)
VALUES
('Smart Phones', '2025-01-01'),
('Monitor', '2025-03-01'), 
('Audio Devices', '2025-05-01'), 
('Laptop', '2025-07-01');

SELECT *
FROM BLINKIT_PRODUCT_CATEGORY_2025;

INSERT INTO Blinkit_Products_2025
(PRODUCT_NAME, PRODUCT_BRAND_NAME, PRODUCT_CATEGORY_NAME)
VALUES
('Samsung S23 Ultra', 'Samsung', 'Smart Phones'),
('Apple Iphone 17 Pro Max', 'Apple', 'Smart Phones'), 
('Acer Nitro 5', 'Acer', 'Laptop');

INSERT INTO Blinkit_Products_2025
(PRODUCT_NAME, PRODUCT_BRAND_NAME, PRODUCT_CATEGORY_NAME)
VALUES
('Computer Table', 'IKEA', 'Furniture');

