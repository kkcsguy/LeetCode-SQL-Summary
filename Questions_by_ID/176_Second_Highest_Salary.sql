-- Solution 1: Subquery
SELECT MAX(salary) AS secondhighestsalary
FROM employee
WHERE salary < (SELECT MAX(salary) FROM employee);



-- Solution 1: Window Function
SELECT AVG(salary) SecondHighestSalary
FROM (
    SELECT salary
      ,DENSE_RANK() OVER (ORDER BY salary DESC) r
    FROM employee
    ) tb1
WHERE r = 2;



-- Solution 1: OFFSET FETCH
SELECT
    (SELECT DISTINCT
            Salary
        FROM
            Employee
        ORDER BY Salary DESC
        LIMIT 1 OFFSET 1) AS SecondHighestSalary
;
