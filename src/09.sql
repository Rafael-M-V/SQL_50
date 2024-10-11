select id as Id from (
    select id,
        recordDate,
        temperature,
        lag(temperature) over (order by recordDate) as prevTemp,
        lag(recordDate) over (order by recordDate) as prevDate
        from Weather
    ) as T where temperature > prevTemp and DATEDIFF(recordDate, prevDate) = 1;
