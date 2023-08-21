WITH AggregatedData AS (
    SELECT
        oi.order_id,
        oi.item_id,
        oi.product_id,
        oi.quantity,
        oi.list_price,
        oi.discount,
        (oi.list_price * oi.quantity) AS total_price,  -- Calculating total price
        (oi.list_price * oi.quantity * (1 - oi.discount)) AS discounted_total,  -- Calculating discounted total
        (oi.list_price - (oi.list_price * oi.discount)) AS discounted_price_per_unit  -- Calculating discounted price per unit
    FROM
        Sales.order_items oi
)

SELECT
    ad.*,
    (SELECT SUM(quantity) FROM AggregatedData WHERE order_id = ad.order_id) AS total_quantity_per_order,  -- Calculating total quantity per order
    (SELECT SUM(total_price) FROM AggregatedData WHERE order_id = ad.order_id) AS total_price_per_order,  -- Calculating total price per order
    (SELECT SUM(discounted_total) FROM AggregatedData WHERE order_id = ad.order_id) AS total_discounted_price_per_order  -- Calculating total discounted price per order
FROM
    AggregatedData ad;
