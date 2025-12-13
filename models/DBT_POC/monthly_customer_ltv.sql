{{ config(
    materialized='view' 
    ) 
}}

WITH monthly_order_summary AS (
    SELECT
        CUSTOMER_ID,
        DATE_TRUNC('month', ORDER_DATE) AS LTV_MONTH, -- Truncate to the beginning of the month
        SUM(TOTAL_AMOUNT) AS total_lifetime_value_month,
        COUNT(DISTINCT ORDER_ID) AS total_orders_month
    FROM {{ ref('raw_order_data') }} -- <--- CORRECTED: Use source() for raw tables
    GROUP BY
        CUSTOMER_ID,
        LTV_MONTH
),
customer_details AS (
    SELECT
        CUSTOMER_ID,
        FIRST_NAME,
        LAST_NAME,
        EMAIL,
        REGION,
        DATE_JOINED
    FROM {{ ref('raw_customer_data') }} -- <--- CORRECTED: Use source() for raw tables
)
SELECT
    cd.CUSTOMER_ID,
    cd.FIRST_NAME,
    cd.LAST_NAME,
    cd.EMAIL,
    cd.REGION,
    cd.DATE_JOINED,
    mos.LTV_MONTH,
    mos.total_lifetime_value_month,
    mos.total_orders_month,
    CURRENT_TIMESTAMP() AS last_calculated_at
FROM monthly_order_summary mos
JOIN customer_details cd -- Use the CTE for customer details
    ON mos.CUSTOMER_ID = cd.CUSTOMER_ID
ORDER BY
    cd.CUSTOMER_ID,
    mos.LTV_MONTH