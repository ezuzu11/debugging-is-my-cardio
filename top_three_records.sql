SELECT *
FROM (
    SELECT
        id, name, department, salary,
        RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS rank_
    FROM employees
)
WHERE rank_ <= 3;