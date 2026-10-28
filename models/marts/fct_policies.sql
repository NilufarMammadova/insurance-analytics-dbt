WITH policies AS (

    SELECT *
    FROM {{ ref('stg_policies') }}

),

paid_payments AS (

    SELECT
        policy_id,
        SUM(amount) AS total_paid_amount
    FROM {{ ref('stg_payments') }}
    WHERE payment_status = 'PAID'
    GROUP BY policy_id

)

SELECT
    p.policy_id,
    p.policy_number,
    p.customer_id,
    p.premium_amount,
    p.policy_status,
    p.premium_quality_status,
    p.start_date,
    p.end_date,
    COALESCE(pay.total_paid_amount, 0) AS total_paid_amount
FROM policies p
LEFT JOIN paid_payments pay
    ON p.policy_id = pay.policy_id
    