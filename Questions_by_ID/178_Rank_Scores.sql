-- Solution: Window Function
SELECT score,
     DENSE_RANK() over (order by score desc) as `rank`
FROM Scores
