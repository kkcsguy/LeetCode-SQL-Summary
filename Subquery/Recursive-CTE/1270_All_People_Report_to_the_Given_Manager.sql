WITH RECURSIVE cte AS (
    SELECT 1 AS id, 1 AS t
    UNION
    SELECT e.employee_id AS id, t+1 AS t
    FROM Employees e
    INNER JOIN cte c
    ON e.manager_id = c.id
    WHERE t < 4
)
SELECT DISTINCT id AS EMPLOYEE_ID
FROM cte
WHERE id != 1
ORDER BY id
