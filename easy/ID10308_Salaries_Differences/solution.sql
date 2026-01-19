WITH department_selection AS (
    SELECT a.id,
           a.salary,
           b.department
    FROM db_employee a 
    JOIN db_dept b ON a.department_id = b.id
    WHERE b.department IN ('marketing','engineering')
),
highest_salary AS (
    SELECT department,
           MAX(salary) AS max_salary
    FROM department_selection
    GROUP BY department
)
SELECT 
    ABS(
        MAX(CASE WHEN department='marketing' THEN max_salary END) - 
        MAX(CASE WHEN department='engineering' THEN max_salary END)
        ) AS salary_difference
FROM highest_salary