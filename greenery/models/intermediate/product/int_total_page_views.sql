{{
  config(
    materialized='view'
  )
}}
SELECT 
    page_url, 
    product_id , 
    count(event_id) as number_of_views 
  FROM {{ ref('stg_events') }}
 WHERE EVENT_TYPE = 'page_view' 
GROUP BY 1, 2
