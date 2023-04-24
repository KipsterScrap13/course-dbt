{{
  config(
    materialized='view'
  )
}}

SELECT 
    user_id, 
    count(distinct order_id) as order_quantity
FROM {{ source('postgres', 'orders') }}
GROUP BY 1