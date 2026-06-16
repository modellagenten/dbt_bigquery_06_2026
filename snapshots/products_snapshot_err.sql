{% snapshot products_snapshot_err %}
{{
 config(
 target_schema='dbt_t09_dev_snapshots',
 unique_key='product_id',
 strategy='check',
 check_cols=['product_name', 'brand', 'category', 'retail_price']
 )
}}
select
 product_id,
 product_name,
 brand,
 category,
 department,
 retail_price,
 cost, 
 margin
from {{ ref('stg_products') }}
{% endsnapshot %}