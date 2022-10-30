-- Solution: Window Function
SELECT DISTINCT num AS ConsecutiveNums  
FROM
(
    select num,lead(num,1)over()AS num1,lead(num,2)over()AS num2 
    from logs
) AS c
WHERE c.num = c.num1 AND c.num1 = c.num2



-- Solution: Join
SELECT DISTINCT l1.num AS ConsecutiveNums
FROM logs l1
JOIN logs l2
    ON l1.id = l2.id-1 AND l1.num = l2.num
JOIN logs l3
    ON l1.id = l3.id-2 AND l2.num = l3.num;
