with
    source as (select * from {{ source("thelook_ecommerce", "products") }}),

    renamed as (

        select
            id as product_id,
            name as product_name,
            brand,
            category,
            department,
            sku,
            round(retail_price, 2) as price,
            round(cost, 2) as cost,
            round(retail_price - cost, 2) as margin

        from source

    )

select *
from renamed
