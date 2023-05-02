{{
  config(
    materialized='view'
  )
}}

SELECT SP.PRODUCT_ID
, PR.NAME
, PR.PRICE
, PR.INVENTORY 
, SP.PURCHASES
, SP.PAGE_VIEWS
, div0(SP.PURCHASES,
 SP.PAGE_VIEWS) AS PRODUCT_CONVERSION_RATE 
  FROM {{ ref('int_product_session_purchases') }} SP
  JOIN {{ ref('stg_products') }} PR on PR.PRODUCT_ID = SP.PRODUCT_ID
  ORDER BY 7 DESC