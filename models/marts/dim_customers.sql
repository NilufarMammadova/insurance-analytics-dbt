WITH customers AS (

    SELECT *
    FROM {{ ref('stg_customers') }}

),

customer_policies AS (

    SELECT
        customer_id,
        COUNT(*) AS policy_count,
        MIN(start_date) AS first_policy_date,
        MAX(start_date) AS latest_policy_date,
        SUM(total_paid_amount) AS lifetime_paid_amount
    FROM {{ ref('fct_policies') }}
    GROUP BY customer_id

)

SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    CONCAT(c.first_name, ' ', c.last_name) AS full_name,
    COALESCE(p.policy_count, 0) AS policy_count,
    p.first_policy_date,
    p.latest_policy_date,
    COALESCE(p.lifetime_paid_amount, 0) AS lifetime_paid_amount
FROM customers c
LEFT JOIN customer_policies p
    ON c.customer_id = p.customer_id