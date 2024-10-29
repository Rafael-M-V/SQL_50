SELECT Tab1.`month`, 
       Tab1.country,
       trans_count,
       CASE WHEN approved_count IS NOT NULL THEN approved_count ELSE 0 END AS approved_count, 
       trans_total_amount, 
       CASE WHEN approved_total_amount IS NOT NULL THEN approved_total_amount ELSE 0 END AS approved_total_amount
FROM
(
    SELECT DATE_FORMAT(trans_date, "%Y-%m") AS `month`,
           country,
           COUNT(id) AS trans_count,
           SUM(amount) AS trans_total_amount
    FROM Transactions
    GROUP BY YEAR(trans_date), MONTH(trans_date), country
) AS Tab1
LEFT JOIN
(
    SELECT DATE_FORMAT(trans_date, "%Y-%m") AS `month`,
           country,
           COUNT(id) AS approved_count,
           SUM(amount) AS approved_total_amount
    FROM Transactions
    WHERE state = "approved"
    GROUP BY YEAR(trans_date), MONTH(trans_date), country
) AS Tab2
ON Tab1.`month` = Tab2.`month` AND
   ((Tab1.country IS NULL AND Tab2.country IS NULL) OR Tab1.country = Tab2.country);
