with orders as (
    select * from {{ ref('stg_orders') }}
),

order_items as (
    select * from {{ ref('stg_order_items') }}
),

joined as (
    select
        DATE_TRUNC(o.created_at, MONTH) as month,
        COUNT(DISTINCT o.order_id) as total_orders,
        ROUND(SUM(oi.sale_price), 2) as total_revenue,
        ROUND(AVG(oi.sale_price), 2) as avg_order_value
    from orders o
    join order_items oi on o.order_id = oi.order_id
    where o.status = 'Complete'
    group by month
    order by month
)

select * from joined
