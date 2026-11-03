-- Hər polis üzrə ödənişlərin ümumi məbləği
-- mənfi olmamalıdır.
-- Test yalnız qaydanı pozan sətirləri qaytarır.

select
    policy_id,
    sum(amount) as total_amount
from {{ ref('stg_payments') }}
group by policy_id
having sum(amount) < 0