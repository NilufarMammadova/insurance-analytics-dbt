{{ config(materialized='table') }}

SELECT
    policy_id,
    policy_number,
    customer_id,
    premium_amount,
    policy_status,
    premium_quality_status,
    start_date,
    end_date
FROM {{ ref('stg_policies') }}
