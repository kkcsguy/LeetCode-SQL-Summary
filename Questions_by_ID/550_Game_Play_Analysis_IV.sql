-- Solution 1: Subquery, Join
SELECT ROUND(
    -- using DISTINCT to avoid double counting
    COUNT(DISTINCT a2.player_id)*1.0/COUNT(DISTINCT a1.player_id),2) AS fraction
FROM (
    -- get the first-logged-in date of each player
    SELECT player_id, MIN(event_date) AS first_login
    FROM Activity
    GROUP BY player_id
) a1
-- if a player logged back in on the day right after the first-logged-in date, 
-- he/she would get a matched record from table a2
LEFT JOIN Activity a2
ON a1.player_id = a2.player_id AND DATE_ADD(a1.first_login,INTERVAL 1 DAY) = a2.event_date;
    
 
 
-- Solution 2: Subquery, Window Function
WITH tb2 as (
    SELECT player_id 
    FROM (
        SELECT player_id, 
            -- the first-logged-in date
            MIN(event_date) OVER (PARTITION BY player_id) AS first_login,
            -- the next-logged-in date after first-logged-in date
            LEAD(event_date) OVER (PARTITION BY player_id ORDER BY event_date) AS next_login
        FROM activity
        ) tb1
    -- only keep users the next-logged-in date after first-logged-in date is the day after first-logged in date
    WHERE DATE_ADD(first_login,INTERVAL 1 DAY) = next_login
)

SELECT ROUND(
    COUNT(DISTINCT player_id)*1.0/(SELECT COUNT(DISTINCT player_id) FROM activity),2) AS fraction
FROM tb2;
