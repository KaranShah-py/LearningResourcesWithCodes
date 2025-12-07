# STARTING WITH THE PRACTICAL SESSION 

# CREATING A DATABASE NAMED AS GLOBALSTOREDATA
CREATE DATABASE GLOBALSTOREDATA;

# USING THE RECENTLY CREATED DATABASE
USE GLOBALSTOREDATA;

# CREATING THE FIRST TABLE CUSTOMERS
/*
	Syntax: - 
    CREATE TABLE IF NOT EXISTS TABLE_NAME(
		COLUMN_NAME1 DATATYPE,
        COLUMN_NAME2 DATATYPE,
        COLUMN_NAME3 DATATYPE
    );
*/
CREATE TABLE IF NOT EXISTS CUSTOMERS (
	customer_code VARCHAR(20) PRIMARY KEY,
    customer_name VARCHAR(100),
    customer_type VARCHAR(50)
);

# INSERTING VALUES MANUALLY INTO CUSTOMERS TABLE 
/*
	Syntax: - 
    INSERT INTO TABLE_NAME (COLUMN_NAME1, COLUMN_NAME2, ....., COLUMN_NAMEn) VALUES(VALUE1, VALUE2,....., VALUEn)
    OR 
    INSERT INTO TABLE_NAME VALUES(VALUE1, VALUE2, VALUE3, ......, VALUEn)
*/
INSERT INTO CUSTOMERS (customer_code, customer_name, customer_type) VALUES ("cus002", "Elon Musk", "Twitter"); # When we do not want to insert values into all the columns 
INSERT INTO CUSTOMERS (customer_code, customer_name) VALUES ("cus003", "Salman Khan", "Bircks and Mortar"); # This will give an error
INSERT INTO CUSTOMERS (customer_code, customer_name) VALUES ("cus003", "Salman Khan"); # This will not give an error
# OR
INSERT INTO CUSTOMERS VALUES ("cus001", "Karan Shah", "BRICKS AND Mortar"); # When we want to insert into all the columns

# INSERTING VALUES ALL AT ONCE INTO CUSTOMERS;
LOAD DATA INFILE "C:\\zzTeaching Content\\SQL Content\\2. Starting with SQL\\Sales Dataset\\Customers.csv"
INTO TABLE CUSTOMERS
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS; 



