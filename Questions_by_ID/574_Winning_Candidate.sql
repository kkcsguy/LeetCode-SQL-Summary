-- Solution 1: Subquery
SELECT Name
FROM Candidate
WHERE id = (
    SELECT CandidateId
    FROM Vote
    GROUP BY CandidateId
    ORDER BY COUNT(*) DESC
    LIMIT 1
);



-- Solution 2: Join
SELECT c.Name
FROM Candidate c
JOIN Vote v
ON c.id = v.CandidateId
GROUP BY c.id, c.Name
ORDER BY COUNT(v.id) DESC
LIMIT 1



