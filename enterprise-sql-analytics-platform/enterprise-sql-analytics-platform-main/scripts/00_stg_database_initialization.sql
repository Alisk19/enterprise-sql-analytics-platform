/*
===============================================================================
 Script Name   : stg_database_initialization.sql
 Layer         : Staging
 Purpose       : Initializes the DataWarehouseAnalytics database by recreating
                 the database, creating core schemas, defining dimension and
                 fact tables, and loading seed data from CSV files.
 WARNING       : Executing this script will DROP and RECREATE the entire
                 DataWarehouseAnalytics database. All existing data will be
                 permanently lost. Ensure proper backups before execution.
===============================================================================
*/

-- ============================================================================
-- Switch to master database for administrative operations
-- ============================================================================
USE master;
GO

-- ============================================================================
-- Drop and recreate database if it already exists
-- ============================================================================
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWarehouseAnalytics')
BEGIN
    ALTER DATABASE DataWarehouseAnalytics
        SET SINGLE_USER WITH ROLLBACK IMMEDIATE;

    DROP DATABASE DataWarehouseAnalytics;
END;
GO

CREATE DATABASE DataWarehouseAnalytics;
GO

-- ============================================================================
-- Switch to newly created database
-- ============================================================================
USE DataWarehouseAnalytics;
GO

-- ============================================================================
-- Create required schemas
-- ============================================================================
CREATE SCHEMA analytics;
GO

-- ============================================================================
-- Create dimension tables
-- ============================================================================
CREATE TABLE analytics.dim_customers (
    customer_key     INT,
    customer_id      INT,
    customer_number  NVARCHAR(50),
    first_name       NVARCHAR(50),
    last_name        NVARCHAR(50),
    country          NVARCHAR(50),
    marital_status   NVARCHAR(50),
    gender           NVARCHAR(50),
    birthdate        DATE,
    create_date      DATE
);
GO

CREATE TABLE analytics.dim_products (
    product_key     INT,
    product_id      INT,
    product_number  NVARCHAR(50),
    product_name    NVARCHAR(50),
    category_id     NVARCHAR(50),
    category        NVARCHAR(50),
    subcategory     NVARCHAR(50),
    maintenance     NVARCHAR(50),
    cost            INT,
    product_line    NVARCHAR(50),
    start_date      DATE
);
GO

-- ============================================================================
-- Create fact tables
-- ============================================================================
CREATE TABLE analytics.fact_sales (
    order_number    NVARCHAR(50),
    product_key     INT,
    customer_key    INT,
    order_date      DATE,
    shipping_date   DATE,
    due_date        DATE,
    sales_amount    INT,
    quantity        TINYINT,
    price           INT
);
GO

-- ============================================================================
-- Load seed data into dimension tables
-- ============================================================================
TRUNCATE TABLE analytics.dim_customers;
GO

BULK INSERT analytics.dim_customers
FROM 'C:\sql\sql-data-analytics-project\datasets\csv-files\gold.dim_customers.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    TABLOCK
);
GO

TRUNCATE TABLE analytics.dim_products;
GO

BULK INSERT analytics.dim_products
FROM 'C:\sql\sql-data-analytics-project\datasets\csv-files\gold.dim_products.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    TABLOCK
);
GO

-- ============================================================================
-- Load seed data into fact tables
-- ============================================================================
TRUNCATE TABLE analytics.fact_sales;
GO

BULK INSERT analytics.fact_sales
FROM 'C:\sql\sql-data-analytics-project\datasets\csv-files\gold.fact_sales.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    TABLOCK
);
GO
