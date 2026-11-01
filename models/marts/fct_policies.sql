with policies as (
    select *
    from {{ ref('stg_policies') }}
),

payments as (
    select *
    from {{ ref('stg_payments') }}
),

policy_payments as (
    select
        policy_id,
        sum(
            case
                when payment_status = 'PAID'
                then amount
                else 0
            end
        ) as total_paid_amount
    from payments
    group by policy_id
),

final as (
    select
        p.policy_id,
        p.policy_number,
        p.customer_id,
        p.premium_amount,
        p.policy_status,
        p.premium_quality_status,
        p.start_date,
        p.end_date,
        coalesce(pp.total_paid_amount, 0) as total_paid_amount

    from policies p
    left join policy_payments pp
        on p.policy_id = pp.policy_id
)

select *
from final