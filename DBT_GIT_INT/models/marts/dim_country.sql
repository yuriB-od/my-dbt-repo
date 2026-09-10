{% if execute %}
    {% set target_relation = adapter.get_relation(
        database = this.database | upper,
        schema = this.schema | upper,
        identifier = this.name | upper
    ) %}
{% endif %}    

{% do log("DEBUG TARGET RELATION VALUE: " ~ target_relation, info=True) %}

{% set dynamic_pk = get_primary_keys(target_relation) %}

{% do log("DEBUG PK VALUE: " ~ dynamic_pk, info=True) %}

{{ config(
    materialized = 'incremental',
    incremental_strategy = 'merge',
    unique_key = dynamic_pk,
    schema = 'FINAL',
    transient = false,
    merge_exclude_columns = ['CREATE_TIME']
) }}

SELECT 
    HEX_DECODE_BINARY(MD5(COUNTRY)) AS country_sk,
    COUNTRY,
    ISO_CURRENCY,
    CURRENT_TIMESTAMP() AS UPDATE_TIME,
    CURRENT_TIMESTAMP() AS CREATE_TIME
FROM {{ ref('raw_country') }}