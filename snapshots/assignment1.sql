{% snapshot assignment1 %}
    {{
        config(
            target_database="raw",
            target_schema="raw_thryve",
            unique_key="member_id",
            strategy="timestamp",
            updated_at="last_update_ts",
        )
    }}
    select *
    from {{ ref("claim_member") }}
{% endsnapshot %}
