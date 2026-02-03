WITH date_rge AS (
    SELECT first_name,
           SUM(total_order_cost) AS total_cost,
           order_date
    FROM customers  c
    JOIN orders o ON c.id = o.cust_id
    WHERE order_date BETWEEN '2019-02-01' AND '2019-05-01'
    GROUP BY first_name, order_date
),
max_daily_cost AS (
    SELECT first_name,
           order_date,
           total_cost,
           MAX(total_cost) OVER (PARTITION BY order_date) AS max_cost
    FROM date_rge
)
SELECT first_name, order_date, max_cost
FROM max_daily_cost
WHERE total_cost = max_cost
ORDER BY order_date, first_name;