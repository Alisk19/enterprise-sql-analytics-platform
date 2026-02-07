/*
===============================================================================
 Script Name   : anl_volume_and_scale_metrics.sql
 Layer         : Analytics
 Purpose       : Quantifies data volume and scale across key business dimensions
                 to understand distribution patterns, customer concentration,
                 product mix, and revenue contribution.
 Data Sources  : analytics.dim_customers
                 analytics.dim_products
                 analytics.fact_sales
===============================================================================
*/

-- ============================================================================
-- Customer distribution by country
-- ============================================================================
SELECT
    country,
    COUNT(customer_key) AS total_customers
FROM analytics.dim_customers
GROUP BY country
ORDER BY total_customers DESC;

-- ============================================================================
-- Customer distribution by gender
-- ============================================================================
SELECT
    gender,
    COUNT(customer_key) AS total_customers
FROM analytics.dim_customers
GROUP BY gender
ORDER BY total_customers DESC;

-- ============================================================================
-- Product distribution by category
-- ============================================================================
SELECT
    category,
    COUNT(product_key) AS total_products
FROM analytics.dim_products
GROUP BY category
ORDER BY total_products DESC;

-- ============================================================================
-- Average product cost by category
-- ============================================================================
SELECT
    category,
    AVG(cost) AS avg_cost
FROM analytics.dim_products
GROUP BY category
ORDER BY avg_cost DESC;

-- ============================================================================
-- Revenue contribution by product category
-- ============================================================================
SELECT
    p.category,
    SUM(f.sales_amount) AS total_revenue
FROM analytics.fact_sales AS f
LEFT JOIN analytics.dim_products AS p
    ON p.product_key = f.product_key
GROUP BY p.category
ORDER BY total_revenue DESC;

-- ============================================================================
-- Revenue contribution by customer
-- ============================================================================
SELECT
    c.customer_key,
    c.first_name,
    c.last_name,
    SUM(f.sales_amount) AS total_revenue
FROM analytics.fact_sales AS f
LEFT JOIN analytics.dim_customers AS c
    ON c.customer_key = f.customer_key
GROUP BY
    c.customer_key,
    c.first_name,
    c.last_name
ORDER BY total_revenue DESC;

-- ============================================================================
-- Distribution of sold items across customer countries
-- ============================================================================
SELECT
    c.country,
    SUM(f.quantity) AS total_sold_items
FROM analytics.fact_sales AS f
LEFT JOIN analytics.dim_customers AS c
    ON c.customer_key = f.customer_key
GROUP BY c.country
ORDER BY total_sold_items DESC;
