select
    order_item_id,
    order_id,
    user_id,
    product_id,
    sale_price,
    product_name,
    category,
    brand,
    cost,
    (sale_price - cost) as profit
from {{ ref("int_order_items_enriched") }}
