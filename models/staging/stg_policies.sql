{{ config(materialized='view') }}

SELECT
    policy_id,
    policy_number,
    customer_id,
    premium_amount,
    CASE
        WHEN premium_amount IS NULL THEN 'MISSING_PREMIUM'
        WHEN premium_amount = 0 THEN 'ZERO_PREMIUM'
        WHEN premium_amount < 0 THEN 'NEGATIVE_PREMIUM'
        ELSE 'VALID'
    END AS premium_quality_status,
    UPPER(TRIM(status)) AS policy_status,
    start_date,
    end_date,
    updated_at
FROM {{ source('raw', 'policies') }}

