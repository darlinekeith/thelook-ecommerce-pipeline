with source as (
    select * from {{ source('thelook_ecommerce', 'products') }}
),

staged as (
    select
        id as product_id,
        name,
        category,
        brand,
        retail_price,
        cost
    from source
)

select * from staged
