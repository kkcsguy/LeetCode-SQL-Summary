SELECT DISTINCT customer_id,
                count(*) AS count_no_trans
FROM visits v
LEFT JOIN transactions t ON v.visit_id = t.visit_id
WHERE transaction_id IS NULL
GROUP BY 1
ORDER BY NULL;
