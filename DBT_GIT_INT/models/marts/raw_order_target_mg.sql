{# {{ config( #}
    -- materialized = 'incremental',
    -- incremental_strategy = 'merge',
    -- unique_key = ['ORDER_ID','LINE_NUMBER'],
    -- schema = 'FINAL',
    -- transient = false
-- ) }}
{% set target_relation = adapter.get_relation(database=this.database, schema=this.schema, identifier=this.name) %}
{% set dynamic_pk = get_primary_keys(target_relation) %}

{{ config(
    materialized = 'incremental',
    incremental_strategy = 'merge',
    unique_key = dynamic_pk ,
    schema = 'FINAL',
    transient = false
) }}

SELECT *, CURRENT_TIMESTAMP() AS UPDATE_TIME   FROM {{ ref('raw_order') }}

-- {% if is_incremental() %}

  -- -- This filter is only applied on incremental runs when the target table already exists.
  -- -- It limits the source data processed to only new or updated records.
  {# where updated_at > (select max(updated_at) from {{ this }}) #}

-- {% endif %}

