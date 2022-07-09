# Write your MySQL query statement below
SELECT ROUND(SUM(TIV_2016),2) AS TIV_2016
FROM (
    SELECT TIV_2016,
        COUNT(*) OVER (PARTITION BY TIV_2015) AS count_2015,
        COUNT(*) OVER (PARTITION BY LAT, LON) AS count_loc
    FROM insurance
) tb1
WHERE count_2015 > 1 AND count_loc = 1;
