WITH distinct_activity AS (
    SELECT DISTINCT user_id,
           record_date
    FROM sf_events
),
cons_days AS (
    SELECT user_id,
           record_date,
           LEAD(record_date,1) OVER (PARTITION BY user_id
           ORDER BY record_date) AS next_day_1,
           LEAD(record_date,2) OVER (PARTITION BY user_id
           ORDER BY record_date) AS next_day_2
    FROM distinct_activity
)
SELECT user_id
FROM cons_days
WHERE next_day_1 = record_date + INTERVAL '1 day'
AND next_day_2 = record_date + INTERVAL '2 day'