{{
  config(
    materialized='view'
  )
}}

SELECT 
    product_id, 
    count(quantity) as item_quantity
FROM {{ ref('stg_order_items') }}
GROUP BY 1