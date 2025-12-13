SELECT
        CUSTOMER_ID,
        DATE_TRUNC('month', ORDER_DATE) AS LTV_MONTH, -- Truncate to the beginning of the month
        SUM(TOTAL_AMOUNT) AS total_lifetime_value_month,
        COUNT(DISTINCT ORDER_ID) AS total_orders_month
    FROM {{ source('dbt_poc', 'raw_order_data') }}
    GROUP BY
        CUSTOMER_ID,
        LTV_MONTH
