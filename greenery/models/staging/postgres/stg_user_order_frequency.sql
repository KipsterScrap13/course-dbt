{{
  config(
    materialized='view'
  )
}}

SELECT 
 (
 select count(distinct user_id) 
  from {{ ref('stg_user_order_qty') }}
 where order_quantity = 1
 ) as one_purchase
 , (
 select count(distinct user_id) 
  from {{ ref('stg_user_order_qty') }}
 where order_quantity = 2
 ) as two_purchases
 , (
 select count(distinct user_id) 
  from {{ ref('stg_user_order_qty') }}
 where order_quantity = 3
 ) as three_purchases
 , (
 select count(distinct user_id) 
  from {{ ref('stg_user_order_qty') }}
 where order_quantity >= 2
 ) as two_plus_purchases
 , (
 select count(distinct user_id) 
  from {{ ref('stg_user_order_qty') }}
 ) as purchase_users
 , (
 select div0((select count(distinct user_id) 
  from {{ ref('stg_user_order_qty') }}
 where order_quantity >= 2), 
 (select count(distinct user_id) 
  from {{ ref('stg_user_order_qty') }}))) as purchase_repeat_rate
FROM {{ ref('stg_user_order_qty') }} 
LIMIT 1