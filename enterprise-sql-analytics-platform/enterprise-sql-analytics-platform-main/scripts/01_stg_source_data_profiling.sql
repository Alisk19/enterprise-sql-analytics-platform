/*
===============================================================================
 Script Name   : stg_source_data_profiling.sql
 Layer         : Staging
 Purpose       : Profiles the source database metadata by inspecting available
                 tables, schemas, and column-level attributes. This script is
                 used to understand the structural layout of the database
                 before applying transformations.
 Data Sources  : INFORMATION_SCHEMA.TABLES
                 INFORMATION_SCHEMA.COLUMNS
===============================================================================
*/

-- ============================================================================
-- Retrieve a list of all tables available in the database
-- ============================================================================
SELECT
    TABLE_CATALOG,
    TABLE_SCHEMA,
    TABLE_NAME,
    TABLE_TYPE
FROM INFORMATION_SCHEMA.TABLES;

-- ============================================================================
-- Inspect column metadata for the customer dimension table
-- ============================================================================
SELECT
    COLUMN_NAME,
    DATA_TYPE,
    IS_NULLABLE,
    CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'dim_customers';
