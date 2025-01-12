SELECT 
   DISTINCT 
    D.name AS "Department", 
    E.name AS "Employee", 
    E.salary AS "Salary"
FROM 
    Employee E
JOIN 
    Department D ON E.departmentId = D.id
JOIN (
    SELECT 
        departmentId,
        salary,
        DENSE_RANK() OVER (PARTITION BY departmentId ORDER BY salary DESC) AS rank
    FROM 
        Employee
) ranked_employee ON E.departmentId = ranked_employee.departmentId AND E.salary = ranked_employee.salary
WHERE 
    ranked_employee.rank <= 3;