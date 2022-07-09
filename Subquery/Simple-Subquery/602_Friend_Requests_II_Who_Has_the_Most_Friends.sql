WITH tb1 AS (
    SELECT requester_id AS id
    FROM RequestAccepted
    UNION ALL
    SELECT accepter_id
    FROM RequestAccepted
)

SELECT TOP 1 id, COUNT(*) AS num
FROM tb1
GROUP BY id
ORDER BY COUNT(*) DESC;
