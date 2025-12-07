USE ROLE ACCOUNTADMIN;

USE WAREHOUSE;

CREATE DATABASE POWERBI_DATA;

CREATE SCHEMA POWERBI_DATA_SCHEMA;

USE DATABASE POWERBI_DATA;

USE SCHEMA POWERBI_DATA_SCHEMA;


-- Creating table for Orders Payments Data
CREATE TABLE IF NOT EXISTS Orders_Payments_Data(
    order_id VARCHAR(100),
    payment_sequential NUMBER,
    patment_type VARCHAR(50),
    payment_installments NUMBER,
    payment_value NUMBER
);

-- Creating table for Orders Item Data
CREATE TABLE IF NOT EXISTS Orders_Item_Data(
    order_id VARCHAR(100),
    order_item_id NUMBER,
    product_id VARCHAR(100),
    seller_id VARCHAR(100),
    shipping_limit_data DATE,
    price NUMBER,
    freight_value NUMBER
);

-- Creating table for Orders Reviews Table
CREATE TABLE IF NOT EXISTS Orders_Review_Data(
    review_id VARCHAR(100),
    order_id VARCHAR(100),
    review_score NUMBER,
    review_comment_title VARCHAR(50),
    review_comment_message VARCHAR(500),
    review_creation_date DATE,
    review_answer_timestamp DATE
);


-- Creating table for Product Category Data
CREATE TABLE IF NOT EXISTS Product_Category_Data(
    product_category_name VARCHAR(100),
    product_category_name_english VARCHAR(100)
);


-- LOADING THE DATA INTO ALL THE TABLES USING UI


