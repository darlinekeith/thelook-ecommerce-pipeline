with source as (
    select * from {{ source('thelook_ecommerce', 'users') }}
),

staged as (
    select
        id as user_id,
        first_name,
        last_name,
        email,
        country,
        gender,
        age,
        created_at
    from source
)

select * from staged
