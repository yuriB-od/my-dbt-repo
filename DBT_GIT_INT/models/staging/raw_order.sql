SELECT *
FROM {{ source('tb_src', 'ORDERS') }}