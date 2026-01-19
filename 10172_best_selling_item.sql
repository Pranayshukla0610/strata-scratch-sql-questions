WITH extract_month AS (
    SELECT EXTRACT(month FROM invoicedate) AS month,
           SUM(unitprice*quantity) AS total_paid,
           description
    FROM online_retail
    GROUP BY EXTRACT(month FROM invoicedate), description
),
max_paid AS (
    SELECT month,
           MAX(total_paid) AS total_paid
    FROM extract_month
    GROUP BY month
)
SELECT a.month, a.description, b.total_paid
FROM extract_month a 
JOIN max_paid b ON a.month = b.month AND a.total_paid = b.total_paid
ORDER BY month ASC