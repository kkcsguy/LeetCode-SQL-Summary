-- Solution: Subquery, Join
WITH max_salary AS (
    SELECT departmentid, max(salary) AS max_salary
    FROM employee
    GROUP BY departmentid
)

SELECT d.name department, e.name employee, e.salary
FROM max_salary ms
JOIN employee e
    ON ms.departmentid = e.departmentid AND ms.max_salary = e.salary
JOIN department d
  ON e.departmentid = d.id;
  
  
2.
SELECT d.name AS Department,e.name AS employee,e.salary AS Salary
FROM Employee e 
LEFT JOIN Department d
ON e.departmentId = d.id
WHERE (e.departmentId, e.salary) in (
    SELECT e2.departmentId, MAX(e2.salary) FROM Employee e2 GROUP BY e2.departmentId)


-- Solution: Subquery, Window Function
SELECT department, employee, salary
FROM (
    SELECT d.name department, e.name employee ,salary,
        -- ranking salaries in each department
        -- the employee with highest salary will get r = 1
        DENSE_RANK() OVER (
            PARTITION BY departmentid 
            ORDER BY salary DESC) r
    FROM employee e
    JOIN department d
        ON e.departmentid = d.id
    ) AS tb1
WHERE r = 1;
