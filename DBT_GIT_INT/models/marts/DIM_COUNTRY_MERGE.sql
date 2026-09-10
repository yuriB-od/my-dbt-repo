{{ config(
    materialized = 'table',
    post_hook = "CALL FINAL.MERGE_DYNAMIC_TABLE('FINAL', 'DIM_COUNTRY', 'LANDING', 'COUNTRIES')"
) }}

SELECT 1 AS status