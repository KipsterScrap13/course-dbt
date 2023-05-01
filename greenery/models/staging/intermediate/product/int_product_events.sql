{{
  config(
    materialized='view'
  )
}}

{%- set event_types = dbt_utils. get_column_values(
    table = ref('stg_events')
    , column = 'event_type'
    )
%}

SELECT
PRODUCT_ID 
{%- for event_type in event_types %}
, sum (case when event_type = '{{ event_type }}' then 1 else 0 end) as {{ event_type }}s
{%- endfor %} 
, min(CREATED_AT) AS first_session_event 
, max(CREATED_AT) AS last_session_event 
  FROM {{ ref('stg_events') }} 
 WHERE PRODUCT_ID IS NOT NULL 
GROUP BY 1