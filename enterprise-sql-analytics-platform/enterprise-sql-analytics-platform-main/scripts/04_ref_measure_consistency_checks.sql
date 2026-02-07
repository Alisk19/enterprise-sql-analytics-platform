/*
===============================================================================
 Script Name   : ref_measure_consistency_checks.sql
 Layer         : Refine
 Purpose       : Performs high-level validation of core business measures by
                 calculating aggregate metrics such as totals, averages, and
                 counts. This step helps identify anomalies and ensures metric
                 consistency prior to analytics and reporting.
 Data Sources  : analytics.fact_sales
                 analytics.dim_products
                 analytics.dim_customers
===============================================================================
*/

-- ============================================================================
-- Aggregate sales value across all transactions
-- ============================================================================
SELECT
    SUM(sales_amount) AS total_sales
FROM analytics.fact_sales;

-- ============================================================================
-- Aggregate total quantity of items sold
-- ============================================================================
SELECT
    SUM(quantity) AS total_quantity
FROM analytics.fact_sales;

-- ============================================================================
-- Calculate average selling price
-- ============================================================================
SELECT
    AVG(price) AS avg_price
FROM analytics.fact_sales;

-- ============================================================================
-- Count total number of orders
-- ============================================================================
SELECT
    COUNT(order_number) AS total_orders
FROM analytics.fact_sales;

SELECT
    COUNT(DISTINCT order_number) AS total_orders
FROM analytics.fact_sales;

-- ============================================================================
-- Count total number of products
-- ============================================================================
SELECT
    COUNT(product_name) AS total_products
FROM analytics.dim_products;

-- ============================================================================
-- Count total number of customers
-- ============================================================================
SELECT
    COUNT(customer_key) AS total_customers
FROM analytics.dim_customers;

-- ============================================================================
-- Count distinct customers who have placed at least one order
-- ============================================================================
SELECT
    COUNT(DISTINCT customer_key) AS total_customers
FROM analytics.fact_sales;

-- ============================================================================
-- Consolidated business metrics report
-- ============================================================================
SELECT
    'Total Sales' AS measure_name,
    SUM(sales_amount) AS measure_value
FROM analytics.fact_sales

UNION ALL

SELECT
    'Total Quantity',
    SUM(quantity)
FROM analytics.fact_sales

UNION ALL

SELECT
    'Average Price',
    AVG(price)
FROM analytics.fact_sales

UNION ALL

SELECT
    'Total Orders',
    COUNT(DISTINCT order_number)
FROM analytics.fact_sales

UNION ALL

SELECT
    'Total Products',
    COUNT(DISTINCT product_name)
FROM analytics.dim_products

UNION ALL

SELECT
    'Total Customers',
    COUNT(customer_key)
FROM analytics.dim_customers;
