-- Solution 1: Window Function, Subquery, IFF
WITH tb1 AS (
    -- Numbering student from each continent separately by their name alphabetically
    SELECT ROW_NUMBER() OVER (PARTITION BY continent ORDER BY name) AS r,
        IF(continent = 'America', name, NULL) AS America,
        IF(continent = 'Asia', name, NULL) AS Asia,
        IF(continent = 'Europe', name, NULL) AS Europe
    FROM student
)
                                                  
-- Since numbering is unique in each continent, 
-- in each numbering group (1-3 rows), there ia only one cell contained student name in each column (e.g. America, Asia, Europe) 
SELECT MIN(America) AS America, MIN(Asia) AS Asia, MIN(Europe) AS Europe
FROM tb1
GROUP BY r;
