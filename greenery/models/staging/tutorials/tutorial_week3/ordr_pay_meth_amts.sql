{{
  config(
    materialized='table'
  )
}}

{%- set payment_methods = dbt_utils.get_column_values(
    table=ref('raw_payments'),
    column='payment_method'
) -%}

select
order_id,
{% for payment_method in payment_methods %}
nvl(sum(case when payment_method = '{{payment_method}}' then amount end),0) as {{payment_method}}_amount
{{ "," if not loop.last }}
{% endfor %}
from {{ ref('raw_payments') }}
group by 1

