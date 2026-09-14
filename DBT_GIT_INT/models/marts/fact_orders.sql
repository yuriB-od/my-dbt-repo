select
    *,
    {{ get_audit_columns() }}
from {{ ref('raw_order_app') }}

-- {% if is_incremental() %}

  -- -- This filter is only applied on incremental runs when the target table already exists.
  -- -- It limits the source data processed to only new or updated records.
  {# where updated_at > (select max(updated_at) from {{ this }}) #}

-- {% endif %}

