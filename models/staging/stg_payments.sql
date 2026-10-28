SELECT
    payment_id,
    policy_id,
    amount,
    payment_date,
    UPPER(TRIM(payment_status)) AS payment_status
FROM {{ source('raw', 'payments') }}