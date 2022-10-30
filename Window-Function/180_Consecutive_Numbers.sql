SELECT DISTINCT num AS ConsecutiveNums  
FROM
(
    select num,lead(num,1)over()AS num1,lead(num,2)over()AS num2 
    from logs
) AS c
WHERE c.num = c.num1 AND c.num1 = c.num2

