SELECT
    id,
    name,
    department,
    salary,
    MAX(salary) OVER (PARTITION BY department) AS dept_max_salary,
    MAX(salary) OVER () AS overall_max_salary
FROM employees;