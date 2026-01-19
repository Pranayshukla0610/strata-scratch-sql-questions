WITH date_conversion AS (
    SELECT DATE_TRUNC('month',created_at) AS month,
           country,
           SUM(number_of_comments) AS total_comments
    FROM fb_comments_count a 
    JOIN fb_active_users b ON a.user_id = b.user_id
    WHERE a.created_at BETWEEN '2019-12-01' AND '2020-01-31'
    GROUP BY country, DATE_TRUNC('month',created_at)
),
rank_countries AS (
    SELECT month,
           country,
           DENSE_RANK() OVER (PARTITION BY month ORDER BY total_comments DESC) AS rnk
    FROM date_conversion
),
dec_jan AS (
    SELECT a.country,
           a.month,
           a.rnk AS dec_rank,
           b.rnk AS jan_rank
    FROM rank_countries a 
    JOIN rank_countries b ON a.country = b.country
    WHERE a.month = '2019-12-01'
    AND b.month = '2020-01-01'
)
SELECT country
FROM dec_jan
WHERE  jan_rank < dec_rank