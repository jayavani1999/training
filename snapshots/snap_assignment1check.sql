{% snapshot snap_assignment1check %}
    {{
        config(
            target_database="raw",
            target_schema="raw_thryve",
            unique_key="CLAIM_ID",
            strategy="check",
            ---updated_at="last_update_ts",
            check_cols=["member_id", "enroll_date", "status", "cancel_date"],
            invalidate_hard_deletes=True,
        )
    }}
    select *
    from {{ ref("claim_member") }}
{% endsnapshot %}
