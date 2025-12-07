-- ASSIGNING THE ACCOUNT TYPE 
USE ROLE ACCOUNTADMIN;

-- USING THE WAREHOUSE AVAILABLE
USE WAREHOUSE COMPUTE_WH;

-- CREATING A DATABASE NAMED AS SUBQUERIES_DATABASE
CREATE DATABASE IF NOT EXISTS WINDOW_FUNCTIONS_DB_2;

-- USING THE DATABASE CREATED
USE DATABASE WINDOW_FUNCTIONS_DB_2;

-- CREATING A SCHEMA NAMED AS SUBQUERIES_SCHEMA
CREATE SCHEMA IF NOT EXISTS WINDOW_FUNCTIONS_SCHEMA_2;

-- USING THE SCHEMA CREATED 
USE SCHEMA WINDOW_FUNCTIONS_SCHEMA_2;

-- QUESTION 
/*
Tables
* `Signups(user_id, time_stamp)`
* `Confirmations(user_id, time_stamp, action)`
Each user may request multiple confirmation messages (either 'confirmed' or 'timeout')
Task:
    Write a query to find the **confirmation rate** for each user, defined as:
    Confirmed messages / total confirmation requests (confirmed + timeout)
    If a user has no requests, their rate is 0.
    Round the result to 2 decimal places
    Return: `user_id` and `confirmation_rate` (in any order).
*/
CREATE OR REPLACE TABLE Signups (
    user_id INT PRIMARY KEY,
    time_stamp DATETIME
);

INSERT INTO Signups (user_id, time_stamp) VALUES
(3, '2020-03-21 10:16:13'),
(7, '2020-01-04 13:57:59'),
(2, '2020-07-29 23:09:44'),
(6, '2020-12-09 10:39:37');



CREATE OR REPLACE TABLE Confirmations (
    user_id INT,
    time_stamp DATETIME,
    action string,
    PRIMARY KEY (user_id, time_stamp),
    FOREIGN KEY (user_id) REFERENCES Signups(user_id)
);

INSERT INTO Confirmations (user_id, time_stamp, action) VALUES
(3, '2021-01-06 03:30:46', 'timeout'),
(3, '2021-07-14 14:00:00', 'timeout'),
(7, '2021-06-12 11:57:29', 'confirmed'),
(7, '2021-06-13 12:58:28', 'confirmed'),
(7, '2021-06-14 13:59:27', 'confirmed'),
(2, '2021-01-22 00:00:00', 'confirmed'),
(2, '2021-02-28 23:59:59', 'timeout');


/*
    Write a query to find the **confirmation rate** for each user, defined as:
    Confirmed messages / total confirmation requests (confirmed + timeout)
    If a user has no requests, their rate is 0.
*/

-- Write your MySQL query statement below
SELECT
    T1.USER_ID, 
    ROUND(
        DIV0
        (
            SUM(CASE WHEN T2.ACTION = 'confirmed' THEN 1 ELSE 0 END),
            COUNT(T2.ACTION)
        ), 2
    ) AS confirmation_rate
FROM SIGNUPS AS T1
LEFT JOIN CONFIRMATIONS AS T2
ON T1.USER_ID = T2.USER_ID
GROUP BY T1.USER_ID;




-- Window Functions 
-- Create the table
CREATE OR REPLACE TABLE SALES_DATA (
    SALE_ID INT,
    SALESPERSON STRING,
    REGION STRING,
    SALE_AMOUNT NUMBER(10,2)
);

-- Insert sample data
INSERT INTO SALES_DATA (SALE_ID, SALESPERSON, REGION, SALE_AMOUNT) VALUES
(1,  'Amit',    'North', 5000),
(2,  'Priya',   'South', 7000),
(3,  'Rohan',   'East',  6000),
(4,  'Anjali',  'North', 5000),
(5,  'Sameer',  'East',  8000),
(6,  'Meera',   'South', 7000),
(7,  'Vikram',  'North', 9000),
(8,  'Kunal',   'East',  6000),
(9,  'Neha',    'South', 8500),
(10, 'Aarav',   'North', 9000),
(11, 'Tanya',   'East',  8000),
(12, 'Rajesh',  'South', 7000),
(13, 'Nikhil',  'North', 5000),
(14, 'Simran',  'East',  6000),
(15, 'Manish',  'South', 8500),
(16, 'Dev',     'North', 9000),
(17, 'Isha',    'East',  8000),
(18, 'Alok',    'South', 8500),
(19, 'Ritu',    'North', 5000),
(20, 'Sneha',   'East',  6000);

-- Window functions  - concept of ranking window functions 
SELECT *
FROM SALES_DATA;


-- RANK 
/*
    Write a SQL query to return the sales person who did the most sales from our dataset.
*/
-- Query 
SELECT 
    SALESPERSON,
    SALE_AMOUNT
FROM SALES_DATA
ORDER BY SALE_AMOUNT DESC
LIMIT 1;


-- ROW_NUMBER()
   /*
        Row Number is nothing but a ranking window function which assigns a unique row number value based on the order by column we have mentioned. 
        1, 2, 3, 4, 5, 6, 7, ........, 99, 100.
   */
-- RANK()
-- DENSE_RANK()

SELECT
    SALESPERSON, 
    REGION,
    SALE_AMOUNT, 
    ROW_NUMBER() OVER(ORDER BY SALE_AMOUNT DESC) AS RANK_GIVEN
FROM SALES_DATA;

/*
    Write a SQL query to return the top 3 sales person based on their sale_amount
*/
WITH CTE AS (
SELECT
    SALESPERSON, 
    SALE_AMOUNT, 
    ROW_NUMBER() OVER(ORDER BY SALE_AMOUNT DESC) AS RANK_GIVEN_USING_ROW_NUMBER
FROM SALES_DATA ) 
SELECT *
FROM CTE 
WHERE RANK_GIVEN_USING_ROW_NUMBER < 4;


-- RANK()
/*
    Rank is the function which assigns the rank based on the order by logic given to the function in the over clause. 
    The ranking is based on the factor two same ranks will be given to the row where the logic is same. 
    Rank function skips the number of same rank given to the next ranking number.
    RANK + NUMBER_OF_REP_IN_SAME_RANK
    EXAMPLE 
    9000 - 1ST RANK - 3 
    8500 - 2ND RANK - 1 + 3 = 4
*/
SELECT
    SALESPERSON, 
    SALE_AMOUNT, 
    ROW_NUMBER() OVER(ORDER BY SALE_AMOUNT DESC) AS RANK_GIVEN_USING_ROW_NUMBER,
    RANK() OVER(ORDER BY SALE_AMOUNT DESC) AS RANK_USING_RANK_FUNCTION
FROM SALES_DATA;


-- DENSE_RANK() 
/*
    Give the rank based on the logic given to the over clause and the order by part. 
    But it is also the function which does not skip the rank even if it was given more than 1 time. 
*/
SELECT
    SALESPERSON, 
    SALE_AMOUNT, 
    DENSE_RANK() OVER(ORDER BY SALE_AMOUNT DESC) AS RANK_GIVEN_USING_DENSE_RANK
FROM SALES_DATA;


SELECT
    SALESPERSON, 
    SALE_AMOUNT, 
    ROW_NUMBER() OVER(ORDER BY SALE_AMOUNT DESC) AS RANK_GIVEN_USING_RN_RANK,
    RANK() OVER(ORDER BY SALE_AMOUNT DESC) AS RANK_GIVEN_USING_RANK,
    DENSE_RANK() OVER(ORDER BY SALE_AMOUNT DESC) AS RANK_GIVEN_USING_DENSE_RANK
FROM SALES_DATA;

SELECT
    SALESPERSON, 
    REGION, 
    SALE_AMOUNT, 
    ROW_NUMBER() OVER(PARTITION BY REGION ORDER BY SALE_AMOUNT DESC) AS RANK_GIVEN_USING_RN_RANK
FROM SALES_DATA;

SELECT *
FROM SALES_DATA
WHERE SALE_AMOUNT = 9000;