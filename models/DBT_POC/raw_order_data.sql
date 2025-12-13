SELECT
        *
    FROM {{ source('dbt_poc', 'raw_order_data') }}
    
