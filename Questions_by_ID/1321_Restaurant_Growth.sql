-- Solution 1: Window Function
WITH total_cte AS
(
  SELECT DISTINCT visited_on, 
         SUM(amount) OVER (ORDER BY visited_on
                           RANGE BETWEEN INTERVAL 6 DAY PRECEDING
                           AND CURRENT ROW) AS amount
  FROM Customer
)

SELECT visited_on, amount, ROUND(amount/7, 2) AS average_amount
FROM total_cte AS a
INNER JOIN
(SELECT MIN(visited_on) AS min_visited_on FROM total_cte) AS b
ON DATEDIFF(visited_on, min_visited_on) >= 6;



-- Solution 2: Subquery, Join
WITH total AS (
    SELECT visited_on, SUM(amount) AS amount
    FROM Customer
    GROUP BY visited_on
)

SELECT t1.visited_on, 
    SUM(t2.amount) AS amount,
    CAST(AVG(t2.amount*1.0) AS DECIMAL(10,2)) AS average_amount
FROM total t1
JOIN total t2
ON t1.visited_on >= t2.visited_on AND t1.visited_on <= DATEADD(day,6,t2.visited_on)
GROUP BY t1.visited_on
HAVING COUNT(t2.visited_on) = 7
ORDER BY t1.visited_on;
