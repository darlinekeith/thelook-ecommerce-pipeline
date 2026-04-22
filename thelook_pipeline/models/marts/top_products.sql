with order_items as (
    select * from {{ ref('stg_order_items') }}
),

products as (
    select * from {{ ref('stg_products') }}
),

joined as (
    select
        p.name,
        p.category,
        p.brand,
        COUNT(oi.order_item_id) as units_sold,
        ROUND(SUM(oi.sale_price), 2) as total_revenue,
        ROUND(AVG(oi.sale_price), 2) as avg_sale_price
    from order_items oi
    join products p on oi.product_id = p.product_id
    where oi.status = 'Complete'
    group by p.name, p.category, p.brand
    order by total_revenue desc
    limit 50
)

select * from joined
