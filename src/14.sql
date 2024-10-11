SELECT user_id,
       CASE WHEN conf + timeouts != 0 THEN
       ROUND(conf/(conf+timeouts), 2)
       ELSE
       0
       END AS confirmation_rate
FROM
(
    SELECT user_id,
        COUNT(CASE WHEN action = 'confirmed' THEN 1 END) AS conf,
        COUNT(CASE WHEN action = 'timeout' THEN 1 END) AS timeouts
    FROM
    (
        SELECT Signups.user_id, Confirmations.action FROM 
        Signups LEFT JOIN Confirmations 
        ON Signups.user_id = Confirmations.user_id
    ) AS SUBSUBTAB1
    GROUP BY user_id
) AS SUBTAB1;
