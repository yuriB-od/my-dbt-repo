{% snapshot dim_country_sc_app %}

{{
    config(
      target_schema='FINAL',
      unique_key='country',
      strategy='check',
      check_cols=['iso_currency'],
      updated_at='load_time',
      invalidate_hard_deletes=True,
      
      transient=false
    )
}}

SELECT 
    HEX_DECODE_BINARY(MD5(country)) AS country_sk,
    country,
    iso_currency,
    LOAD_TIME,
    
    CURRENT_TIMESTAMP() AS update_time
FROM {{ ref('raw_country_app') }}

{% endsnapshot %}