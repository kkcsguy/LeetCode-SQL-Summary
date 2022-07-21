-- Solution: Subquery
(SELECT b.name AS results 
 FROM   (SELECT a.user_id, 
                Count(*) AS cnt 
         FROM   MovieRating a 
         GROUP  BY a.user_id) a 
        INNER JOIN Users b 
               ON a.user_id = b.user_id 
 ORDER  BY a.cnt DESC, 
           b.name ASC 
 LIMIT  1) 
UNION ALL 
(SELECT b.movie_name 
 FROM   (SELECT a.movie_name, 
                Avg(a.rating) AS max_rating 
         FROM   (SELECT a.rating,
                        b.title AS movie_name 
                 FROM   MovieRating a 
                        INNER JOIN Movies b 
                                ON a.movie_id = b.movie_id 
                 WHERE  a.created_at BETWEEN '2020-02-01' AND '2020-02-29') a 
         GROUP  BY a.movie_name) b 
 ORDER  BY b.max_rating DESC, 
           b.movie_name ASC 
 LIMIT  1); 
