SELECT project_id,
       ROUND(AVG(experience_years), 2) AS average_years
FROM
(
    SELECT Project.project_id,
           Project.employee_id,
           Employee.experience_years
    FROM Project INNER JOIN Employee
    ON Project.employee_id = Employee.employee_id
) SUBTAB
GROUP BY project_id;
