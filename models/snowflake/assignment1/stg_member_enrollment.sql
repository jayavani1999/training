select
        member_id,
        plan_id,
        enroll_date,
        lower(status) as status,
        cancel_date,
        initcap(region) as region
    from {{ source('raw_thryve', 'MEMBER_ENROLLMENTS') }}
    where status ='cancelled'