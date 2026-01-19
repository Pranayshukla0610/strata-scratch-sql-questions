WITH sent_requests AS (
    SELECT
        user_id_sender,
        user_id_receiver,
        date AS sent_date
    FROM fb_friend_requests
    WHERE action = 'sent'
),
accepted_requests AS (
    SELECT
        user_id_sender,
        user_id_receiver
    FROM fb_friend_requests
    WHERE action = 'accepted'
)
SELECT
    s.sent_date AS date,
    ROUND(
        COUNT(a.user_id_sender) * 1.0 / COUNT(s.user_id_sender),
        2
    ) AS percentage_acceptance
FROM sent_requests s
LEFT JOIN accepted_requests a
    ON s.user_id_sender = a.user_id_sender
   AND s.user_id_receiver = a.user_id_receiver
GROUP BY s.sent_date
HAVING COUNT(a.user_id_sender) > 0
ORDER BY s.sent_date;