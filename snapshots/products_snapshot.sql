{% snapshot products_snapshot %}
{{
    config(
        target_schema='dbt_t16_dev',
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
-- simulierte Preisänderung für Produkte mit id <= 20:
 case when id <= 20 then retail_price * 1.1 else retail_price end as retail_price, 
 cost
from {{ source('thelook_ecommerce', 'products') }}
{% endsnapshot %}
