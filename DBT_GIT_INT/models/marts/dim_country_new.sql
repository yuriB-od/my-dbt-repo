{{ config(
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