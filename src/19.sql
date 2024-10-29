SELECT Tab1.query_name,
       Tab1.quality,
       CASE WHEN Tab2.n_poor_ratings IS NOT NULL THEN
       ROUND(100*Tab2.n_poor_ratings/Tab1.n_ratings, 2)
       ELSE 0
       END AS poor_query_percentage
FROM
(
    SELECT Queries.query_name,
           ROUND(AVG(Queries.rating/Queries.position), 2) AS quality,
           COUNT(rating) AS n_ratings
    FROM Queries
    GROUP BY query_name
) AS Tab1
LEFT JOIN
(
    SELECT query_name,
           COUNT(rating) AS n_poor_ratings
    FROM Queries WHERE rating < 3
    GROUP BY query_name
) AS Tab2
ON Tab1.query_name = Tab2.query_name
WHERE Tab1.query_name IS NOT NULL;
