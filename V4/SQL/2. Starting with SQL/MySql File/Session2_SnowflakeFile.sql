-- SQL Session 2 - Exploring the basic data objects
/*
    1. Main Concept of starting a script
    2. Creation Database using SQL
    3. Understanding the data by learning syntax
*/

-- Use a particular role that is assigned to you 
USE ROLE ACCOUNTADMIN; -- SNOWFLAKE, NOT IN SQL WORKBENCH 

/*
    Press CTRL + Enter to run the statement which is highlighted 
*/

-- Creating a database in SQL
/*
    Syntax - CREATE DATABASE IF NOT EXISTS <DATABASE_NAME>;
*/
-- Method 1 - Without using the IF EXISTS Keywords
    /*
        CREATE DATABASE Session2_V4_Database;
    */

-- Method 2 - With Using the IF EXISTS Keywords
CREATE DATABASE IF NOT EXISTS Session2_V4_Database; -- This statement will create database


-- Whenever database which will be used 
USE Session2_V4_Database; -- This statement will tell my sql to use the database 



-- Schema
/*
    This is nothing but it can be considered as a sub folder, inside a database
*/

-- CREATE SCHEMA Session2_V4_Students_Schema;

CREATE SCHEMA IF NOT EXISTS Session2_V4_Students_Schema;

CREATE SCHEMA IF NOT EXISTS Session2_V4_Trainers_Schema;


USE SCHEMA Session2_V4_Students_Schema;









