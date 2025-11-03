{{ config(
    materialized='table',
    unique_key='plan_id' 
) }}

select
    *
from {{ ref('stg_plan') }}