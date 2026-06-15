with stage_orders as (
    select * from {{ref("stg_orders")}}
),

stage_order_items as (
    select * from {{ref("stg_order_items")}}
),

stage_products as (
    select * from {{ref("stg_products")}}
),

mart_orders as (
    select 
        order_id,
        user_id,
        status,
        ordered_at,
        shipped_at,
        delivered_at,
        returned_at,
        timestamp_diff(delivered_at, ordered_at, day) as days_to_delivery
    from stage_orders
),

orders_aggregate as (
    select 
        order_id as order_id_agg,
        count(*) as n_item,
        sum(sale_price) as revenue,
        sum(sale_price - cost) as profit
    from stage_order_items
    join stage_products on stage_order_items.product_id = stage_products.product_id
    group by order_id

),

marts_orders_joined as (
    select *
    from mart_orders 
    join orders_aggregate on mart_orders.order_id = orders_aggregate.order_id_agg
)

select * from marts_orders_joined


