with
    stg_products as (
        select
            product_id,
            product_name,
            brand,
            category,
            department,
            retail_price,
            cost,
            margin
        from {{ ref("stg_products") }}
    ),
    stg_order_items as (
        select 
            product_id, 
            sale_price, 
            ordered_at 
        from {{ ref("stg_order_items") }}
    ),
    orders_agg as (
        select
            product_id,
            count(*) as lifetime_units_sold,
            round(sum(sale_price), 2) as lifetime_revenue,
            min(ordered_at) as first_sold_at,
            max(ordered_at) as last_sold_at
        from stg_order_items
        group by product_id
    )
select
    p.product_id,
    p.product_name,
    p.brand,
    p.category,
    p.department,
    p.retail_price,
    p.cost,
    p.margin,
    o.lifetime_units_sold,
    o.lifetime_revenue,
    o.first_sold_at,
    o.last_sold_at
from stg_products as p
left join orders_agg as o on p.product_id = o.product_id
