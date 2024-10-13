SELECT product_id,
       CASE WHEN n_units IS NOT NULL THEN
       ROUND(total_price/n_units, 2)
       ELSE
       0
       END AS average_price
FROM
(
    SELECT product_id,
           SUM(units*price) AS total_price,
           SUM(units) AS n_units
    FROM
    (
        SELECT Prices.product_id,
            UnitsSold.purchase_date,
            UnitsSold.units,
            Prices.price
        FROM UnitsSold RIGHT JOIN Prices
        ON UnitsSold.product_id = Prices.product_id AND
        UnitsSold.purchase_date >= Prices.start_date AND
        UnitsSold.purchase_date <= Prices.end_date
    ) AS SUBTAB1
    GROUP BY product_id
) AS SUBTAB2;
