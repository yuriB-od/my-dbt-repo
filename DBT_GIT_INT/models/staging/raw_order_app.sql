SELECT *
FROM {{ source('tb_src', 'ORDERS_APP') }}