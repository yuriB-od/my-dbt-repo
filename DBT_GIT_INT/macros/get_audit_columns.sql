{% macro get_audit_columns() %}
    current_timestamp() as dbt_updated_at,
    current_timestamp() as dbt_created_at,
    current_user()      as dbt_updated_by,
    '{{ invocation_id }}' as dbt_invocation_id
{% endmacro %}