{% snapshot products_snapshot %}
{{
 config(
 unique_key='id',
 strategy='check',
 check_cols=['name', 'brand', 'category', 'retail_price']
 )
}}
select
 id,
 name,
 brand,
 category,
 department,
 retail_price,
 cost
from {{ source('thelook_ecommerce', 'products') }}
{% endsnapshot %}


--  target_schema=var('snapshot_schema'),