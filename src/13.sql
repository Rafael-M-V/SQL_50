SELECT Employee.name FROM
Employee INNER JOIN
(
    SELECT managerId, COUNT(managerId) AS nm FROM Employee
    GROUP BY managerId
) AS SUBTAB1
ON Employee.id = SUBTAB1.managerId
WHERE SUBTAB1.nm >= 5;
