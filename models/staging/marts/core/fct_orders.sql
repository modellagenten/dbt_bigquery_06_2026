with stage_orders as (

    select * from {{ref ('stg_orders') }}

)
select * from stage_orders