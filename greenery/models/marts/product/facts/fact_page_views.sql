{{
  config(
    materialized='view'
  )
}}
 SELECT 
    dpv.page_url,
    dpv.number_of_views as daily_views,
    tpv.number_of_views as total_views,
    pve.name,
    pve.price,
    pve.inventory
 FROM {{ ref('int_daily_page_views') }} dpv
 JOIN {{ ref('int_total_page_views') }} tpv ON tpv.page_url = dpv.page_url 
 JOIN {{ ref('int_page_view_events') }} pve ON pve.page_url = dpv.page_url  