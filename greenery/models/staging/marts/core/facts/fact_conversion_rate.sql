{{
  config(
    materialized='view'
  )
}}

with checkout as (SELECT COUNT('X') as checkouts
  FROM {{ ref('stg_events') }} 
 WHERE EVENT_TYPE = 'checkout')

, all_sessions as (SELECT COUNT(DISTINCT SESSION_ID) as sessions 
  FROM {{ ref('stg_events') }})

SELECT div0((select checkouts from checkout), (select sessions from all_sessions)) AS CONVERSION_RATE 
  FROM {{ ref('stg_events') }}
LIMIT 1