{{ config(materialized="view") }}

select *
from {{ ref("snap_assignment1check") }}
where dbt_valid_to is null
