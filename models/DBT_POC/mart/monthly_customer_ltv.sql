{{ config(
    materialized='view'

) }}

WITH monthly_order_summary AS (
    SELECT
        *
    FROM {{ ref('raw_order_data') }}
    )
SELECT
    c.CUSTOMER_ID,
    c.FIRST_NAME,
    c.LAST_NAME,
    c.EMAIL,
    c.REGION,
    c.DATE_JOINED,
    mos.LTV_MONTH,
    mos.total_lifetime_value_month,
    mos.total_orders_month,
    CURRENT_TIMESTAMP() AS last_calculated_at
FROM monthly_order_summary mos
JOIN {{ ref('raw_customer_data') }} c
    ON mos.CUSTOMER_ID = c.CUSTOMER_ID
ORDER BY
    c.CUSTOMER_ID,
    mos.LTV_MONTH