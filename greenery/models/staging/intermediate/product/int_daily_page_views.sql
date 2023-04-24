{{
  config(
    materialized='view'
  )
}}
SELECT 
    page_url, 
    count(event_id) as number_of_views, 
    to_char (CREATED_AT, 'dd-mm-yyyy') as date_viewed 
  FROM {{ source('stage', 'stg_events') }}
 WHERE EVENT_TYPE = 'page_view' 
GROUP BY 1, 3
ORDER BY 3 ASC
