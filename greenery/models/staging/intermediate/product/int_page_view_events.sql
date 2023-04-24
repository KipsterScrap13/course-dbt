{{
  config(
    materialized='view'
  )
}}
 SELECT DISTINCT
    pv.page_url,
    pv.product_id,
    pr.name,
    pr.price,
    pr.inventory
 FROM {{ source('stage', 'stg_events') }} pv
 JOIN {{ source('stage', 'stg_products') }} pr ON pr.product_id = pv.product_id 
WHERE pv.EVENT_TYPE = 'page_view' 
