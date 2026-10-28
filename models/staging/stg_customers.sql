{{ config(materialized='view') }}

SELECT
    customer_id,
    INITCAP(TRIM(first_name)) AS first_name,
    INITCAP(TRIM(last_name)) AS last_name
FROM {{ source('raw', 'customers') }}