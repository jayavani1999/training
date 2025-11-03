{{ config(
    materialized='table'
) }}

with member_enrollments as (
    select
       *
    from {{ ref('stg_member_enrollment') }}
),

claims_aggr as (
    select
        member_id,
        count(claim_id) as total_claim_count,
        sum(amount) as total_claim_amount
    from {{ ref('stg_claims') }}
    group by member_id
)

select
    a.member_id,
    a.plan_id,
    a.enroll_date,
    a.status,
    a.cancel_date,
    a.region,
    coalesce(b.total_claim_count, 0) as total_claim_count, 
    coalesce(b.total_claim_amount, 0) as total_claim_amount 
from member_enrollments a
 join claims_aggr b
    on a.member_id = b.member_id