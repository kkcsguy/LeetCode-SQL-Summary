WITH tb1 AS (
    SELECT *, 
        -- There are cum_num numbers in TABLE numbers less than or equal to number in that record
        -- e.g. There are cum_num = 8 numbers in TABLE numbers less than or equal to 1
        -- so you will see [1,1,8,12] AS [num, Frequency, cum_num, num1]
        SUM(frequency) OVER (ORDER BY num) AS cum_num,
        SUM(frequency) OVER () AS num1
    FROM numbers
)

SELECT AVG(num*1.0) AS median
FROM tb1
WHERE num1 / 2.0 BETWEEN cum_num - frequency AND cum_num;
