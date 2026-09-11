-- SELECT *
{# FROM {{ source('tb_src', 'COUNTRIES_APP') }} #}

WITH source_data AS (
    SELECT 
        country,
        iso_currency,
        load_time,
        LAG(iso_currency) OVER (
            PARTITION BY country 
            ORDER BY load_time ASC
        ) AS prev_iso_currency
    FROM {{ source('tb_src', 'COUNTRIES_APP') }}
)
SELECT 
    country,
    iso_currency,
    load_time
FROM source_data
-- Keep the initial historic record OR any row where ISO_CURRENCY actually changed
WHERE prev_iso_currency IS NULL 
   OR iso_currency != prev_iso_currency