## Solution 1:
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


## Solution 2:

SELECT e1.employee_id 
FROM   employees e1 
       LEFT JOIN employees e2 
              ON e1.manager_id = e2.employee_id 
       LEFT JOIN employees e3 
              ON e2.manager_id = e3.employee_id 
WHERE  e3.manager_id = 1 
       AND e1.employee_id != 1 
