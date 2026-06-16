with
    user_src as (
        select
            user_id,
            first_name,
            last_name,
            email,
            country,
            city,
            traffic_source,
            registered_at
        from {{ ref("stg_users") }}
    ),
    orders_src as (
        select
            user_id,
            count(*) as lifetime_orders,
            sum(num_of_item) as lifetime_items,
            min(ordered_at) as first_order_at,
            max(ordered_at) as last_order_at
        from {{ ref("stg_orders") }}
        where status = 'Complete'
        group by user_id
    )

select
    user_src.user_id,
    user_src.first_name,
    user_src.last_name,
    user_src.email,
    user_src.country,
    user_src.city,
    user_src.traffic_source,
    user_src.registered_at,
    coalesce(orders_src.lifetime_orders, 0) as lifetime_orders,
    coalesce(orders_src.lifetime_items, 0) as lifetime_items,
    orders_src.first_order_at,
    orders_src.last_order_at
from user_src
left join orders_src on user_src.user_id = orders_src.user_id
