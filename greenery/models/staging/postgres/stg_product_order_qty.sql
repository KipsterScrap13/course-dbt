{{
  config(
    materialized='view'
  )
}}

SELECT 
    product_id, 
    count(quantity) as item_quantity
FROM {{ source('postgres', 'order_items') }}
GROUP BY 1