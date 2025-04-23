SELECT
    p.products_id,
    s.date_date,
    s.orders_id,
    s.revenue,
    s.quantity,
    p.purchase_price,
    ROUND(s.quantity * p.purchase_price, 2) AS purchase_cost,
    ROUND(s.revenue - s.quantity * p.purchase_price, 2) AS margin
FROM {{ ref("stg_raw__sales") }} s
LEFT JOIN {{ ref("stg_raw__product") }} p
    ON s.pdt_id = p.products_id