SELECT *
FROM {{ source('tb_src', 'COUNTRIES') }}