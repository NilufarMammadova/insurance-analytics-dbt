{% docs fct_policies_overview %}

# Fact Policies

This model provides policy-level insurance analytics.

## Grain

One row represents one insurance policy.

## Data Sources

- `stg_policies`
- `stg_payments`

## Business Logic

- Includes all policies from `stg_policies`.
- Aggregates payment amounts at policy level.
- Includes only transactions with `payment_status = 'PAID'`.
- Returns zero for policies without paid payments.

## Primary Use Cases

- Policy performance reporting
- Premium analysis
- Paid amount analysis

{% enddocs %}


{% docs dim_customers_overview %}

# Customer Dimension

This model provides customer-level insurance analytics.

## Grain

One row represents one customer.

## Data Sources

- `stg_customers`
- `fct_policies`

## Business Logic

- Includes customer information.
- Calculates the number of policies per customer.
- Calculates the earliest and latest policy start dates.
- Aggregates historical paid amounts across policies.

## Primary Use Cases

- Customer segmentation
- Customer portfolio analysis
- Customer payment analysis

{% enddocs %}