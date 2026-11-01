with customers as (
    select *
    from {{ ref('stg_customers') }}
),

policies as (
    select *
    from {{ ref('fct_policies') }}
),

customer_policies as (
    select
        customer_id,
        min(start_date) as first_policy_date,
        max(start_date) as latest_policy_date,
        count(policy_id) as policy_count,
        sum(total_paid_amount) as lifetime_paid_amount

    from policies
    group by customer_id
),

final as (
    select
        c.customer_id,
        c.first_name,
        c.last_name,
        concat(c.first_name, ' ', c.last_name) as full_name,

        cp.first_policy_date,
        cp.latest_policy_date,

        coalesce(cp.policy_count, 0) as policy_count,
        coalesce(cp.lifetime_paid_amount, 0) as lifetime_paid_amount

    from customers c
    left join customer_policies cp
        on c.customer_id = cp.customer_id
)

select *
from final