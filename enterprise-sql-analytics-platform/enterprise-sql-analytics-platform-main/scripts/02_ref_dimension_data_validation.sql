/*
===============================================================================
 Script Name   : ref_dimension_data_validation.sql
 Layer         : Refine
 Purpose       : Validates and profiles key dimension attributes by reviewing
                 distinct values across customer and product dimensions. This
                 step helps ensure dimensional consistency before analytics
                 consumption.
 Data Sources  : analytics.dim_customers
                 analytics.dim_products
===============================================================================
*/

-- ============================================================================
-- Validate customer geography by reviewing distinct country values
-- ============================================================================
SELECT DISTINCT
    country
FROM analytics.dim_customers
ORDER BY country;

-- ============================================================================
-- Validate product hierarchy by reviewing category and subcategory mappings
-- ============================================================================
SELECT DISTINCT
    category,
    subcategory,
    product_name
FROM analytics.dim_products
ORDER BY
    category,
    subcategory,
    product_name;
