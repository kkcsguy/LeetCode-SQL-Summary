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
