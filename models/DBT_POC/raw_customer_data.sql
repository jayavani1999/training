SELECT
        *
    FROM {{ source('dbt_poc', 'raw_customer_data') }}
    
