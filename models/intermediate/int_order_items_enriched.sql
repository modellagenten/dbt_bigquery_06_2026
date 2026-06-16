-- models/intermediate/int_order_items_enriched.sql
{{ config(materialized="ephemeral") }}
with
    items as (
        select order_item_id, order_id, user_id, product_id, sale_price
        from {{ ref("stg_order_items") }}
    ),
    products as (
        select product_id, product_name, category, brand, cost
        from {{ ref("stg_products") }}
    )
select
    order_item_id,
    order_id,
    user_id,
    items.product_id,
    sale_price,
    product_name,
    category,
    brand,
    cost
from items
left join products on items.product_id = products.product_id
