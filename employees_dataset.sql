
CREATE TABLE employees (
    id NUMBER PRIMARY KEY,
    name VARCHAR2(50),
    department VARCHAR2(50),
    salary NUMBER,
    join_date DATE
);
INSERT INTO employees (id, name, department, salary, join_date) VALUES (1, 'Alice', 'Marketing', 7500, TO_DATE('2022-09-16', 'YYYY-MM-DD'));
INSERT INTO employees (id, name, department, salary, join_date) VALUES (2, 'Bob', 'IT', 5500, TO_DATE('2023-08-12', 'YYYY-MM-DD'));
INSERT INTO employees (id, name, department, salary, join_date) VALUES (3, 'Charlie', 'Sales', 6500, TO_DATE('2019-08-16', 'YYYY-MM-DD'));
INSERT INTO employees (id, name, department, salary, join_date) VALUES (4, 'David', 'IT', 5000, TO_DATE('2021-05-11', 'YYYY-MM-DD'));
INSERT INTO employees (id, name, department, salary, join_date) VALUES (5, 'Eve', 'Sales', 5000, TO_DATE('2019-06-13', 'YYYY-MM-DD'));
INSERT INTO employees (id, name, department, salary, join_date) VALUES (6, 'Frank', 'Marketing', 8000, TO_DATE('2023-06-15', 'YYYY-MM-DD'));
INSERT INTO employees (id, name, department, salary, join_date) VALUES (7, 'Grace', 'Marketing', 6500, TO_DATE('2020-01-28', 'YYYY-MM-DD'));
INSERT INTO employees (id, name, department, salary, join_date) VALUES (8, 'Heidi', 'HR', 6000, TO_DATE('2021-10-12', 'YYYY-MM-DD'));
INSERT INTO employees (id, name, department, salary, join_date) VALUES (9, 'Ivan', 'Sales', 4500, TO_DATE('2018-12-14', 'YYYY-MM-DD'));
INSERT INTO employees (id, name, department, salary, join_date) VALUES (10, 'Judy', 'Sales', 5000, TO_DATE('2023-06-02', 'YYYY-MM-DD'));
INSERT INTO employees (id, name, department, salary, join_date) VALUES (11, 'Karl', 'Sales', 4500, TO_DATE('2022-04-10', 'YYYY-MM-DD'));
INSERT INTO employees (id, name, department, s4alary, join_date) VALUES (12, 'Laura', 'IT', 5000, TO_DATE('2019-10-14', 'YYYY-MM-DD'));
INSERT INTO employees (id, name, department, salary, join_date) VALUES (13, 'Mallory', 'HR', 6500, TO_DATE('2023-02-13', 'YYYY-MM-DD'));
INSERT INTO employees (id, name, department, salary, join_date) VALUES (14, 'Niaj', 'HR', 5500, TO_DATE('2018-12-17', 'YYYY-MM-DD'));
INSERT INTO employees (id, name, department, salary, join_date) VALUES (15, 'Olivia', 'Sales', 6500, TO_DATE('2022-01-25', 'YYYY-MM-DD'));
INSERT INTO employees (id, name, department, salary, join_date) VALUES (16, 'Peggy', 'HR', 6000, TO_DATE('2018-02-12', 'YYYY-MM-DD'));
INSERT INTO employees (id, name, department, salary, join_date) VALUES (17, 'Quentin', 'IT', 5500, TO_DATE('2021-07-19', 'YYYY-MM-DD'));
INSERT INTO employees (id, name, department, salary, join_date) VALUES (18, 'Ruth', 'IT', 6500, TO_DATE('2021-12-08', 'YYYY-MM-DD'));
INSERT INTO employees (id, name, department, salary, join_date) VALUES (19, 'Sybil', 'Marketing', 4500, TO_DATE('2023-08-25', 'YYYY-MM-DD'));
INSERT INTO employees (id, name, department, salary, join_date) VALUES (20, 'Trent', 'IT', 6500, TO_DATE('2021-01-21', 'YYYY-MM-DD'));


select * from employees;

SELECT 
    id,
    name,
    department,
    salary,
    LAG(salary) OVER (PARTITION BY department ORDER BY salary) AS prev_salary,
    LEAD(salary) OVER (PARTITION BY department ORDER BY salary) AS next_salary,
    CASE 
        WHEN salary > LAG(salary) OVER (PARTITION BY department ORDER BY salary) THEN 'HIGHER'
        WHEN salary < LAG(salary) OVER (PARTITION BY department ORDER BY salary) THEN 'LOWER'
        ELSE 'EQUAL'
    END AS compare_with_prev
FROM employees;

SELECT 
    id,
    name,
    department,
    salary,
    RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS rank_,
    DENSE_RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS dense_rank_
FROM employees;

SELECT *
FROM (
    SELECT 
        id, name, department, salary,
        RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS rank_
    FROM employees
)
WHERE rank_ <= 3;

SELECT *
FROM (
    SELECT 
        id,
        name,
        department,
        join_date,
        ROW_NUMBER() OVER (PARTITION BY department ORDER BY join_date) AS rn
    FROM employees
)
WHERE rn <= 2;

SELECT 
    id,
    name,
    department,
    salary,
    MAX(salary) OVER (PARTITION BY department) AS dept_max_salary,
    MAX(salary) OVER () AS overall_max_salary
FROM employees;




