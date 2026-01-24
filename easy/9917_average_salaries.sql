WITH dept_avg AS (
    SELECT 
        department,
        AVG(salary) AS avg_salary
    FROM employee
    GROUP BY department
),
emp_sal AS (
    SELECT 
        department,
        first_name,
        salary
    FROM employee
)
SELECT 
    e.department,
    e.first_name,
    e.salary,
    d.avg_salary
FROM emp_sal e
JOIN dept_avg d
    ON e.department = d.department
ORDER BY e.department, e.first_name;
