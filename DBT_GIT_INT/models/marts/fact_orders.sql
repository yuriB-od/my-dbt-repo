
WITH SRC AS 
(select
    *
from {{ ref('raw_order_app') }}

{% if is_incremental() %}

  -- This filter is only applied on incremental runs when the target table already exists.
  -- It limits the source data processed to only new or updated records.
  where LOAD_TIME >= (select max(LOAD_TIME) from {{ this }})

{% endif %}),

DEDUP
AS
(
SELECT 
ORDER_ID, TRUCK_ID, ORDER_TS, ORDER_DETAIL_ID, LINE_NUMBER, TRUCK_BRAND_NAME, MENU_TYPE, PRIMARY_CITY, REGION, COUNTRY, FRANCHISE_FLAG, FRANCHISE_ID, FRANCHISEE_FIRST_NAME, FRANCHISEE_LAST_NAME, LOCATION_ID, CUSTOMER_ID, FIRST_NAME, LAST_NAME, E_MAIL, PHONE_NUMBER, CHILDREN_COUNT, GENDER, MARITAL_STATUS, MENU_ITEM_ID, MENU_ITEM_NAME, QUANTITY, UNIT_PRICE, PRICE, ORDER_AMOUNT, ORDER_TAX_AMOUNT, ORDER_DISCOUNT_AMOUNT, ORDER_TOTAL, LOAD_TIME, CURRENT_YN
FROM 
(SELECT *, row_number() over(partition by ORDER_ID,LINE_NUMBER ORDER BY LOAD_TIME DESC) AS RN
FROM SRC

)
WHERE RN =1
)

SELECT *,
    {{ get_audit_columns() }}
FROM  DEDUP

