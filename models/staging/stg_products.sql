with source as (

    select * from {{ source('thelook_ecommerce', 'products') }}

),

renamed as (

    select
        id               as product_id,
        name             as product_name,
        brand,
        category,
        department,
        sku,
        retail_price * 2 as retail_price,
        cost,
        retail_price - cost as margin

    from source

)

select * from renamed
