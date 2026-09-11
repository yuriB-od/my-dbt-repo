{% snapshot dim_country_sc %}

{{
    config(
      target_schema='FINAL',
      unique_key='country',
      strategy='check',
      check_cols=['iso_currency'],
      transient=false
    )
}}

SELECT 
    HEX_DECODE_BINARY(MD5(country)) AS country_sk,
    country,
    iso_currency,
    CURRENT_TIMESTAMP() AS update_time
FROM {{ ref('raw_country') }}

{% endsnapshot %}