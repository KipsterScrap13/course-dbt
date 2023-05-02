{{
  config(
    materialized='view'
  )
}}

SELECT
SO.PRODUCT_ID 
, COUNT(DISTINCT SE.SESSION_ID) AS PAGE_VIEWS   
, COUNT(DISTINCT SO.ORDER_ID) AS PURCHASES 
   FROM {{ ref('stg_events') }} SE
   JOIN {{ ref('stg_order_items') }} SO on SO.PRODUCT_ID = SE.PRODUCT_ID
  WHERE SE.EVENT_TYPE = 'page_view'
GROUP BY 1 
ORDER BY 1