# SQL Window Functions Tutorial

This repository contains examples and explanations of SQL window functions using Oracle SQL syntax. Window functions are powerful SQL features that perform calculations across a set of table rows related to the current row.

## Overview

Window functions allow you to:

- Compare values between rows
- Calculate rankings
- Access preceding and following rows
- Perform aggregations without collapsing result sets

## Contents

This tutorial covers the following window functions with practical examples:

- LAG and LEAD
- RANK and DENSE_RANK
- ROW_NUMBER
- Aggregate window functions

## Examples with Visualizations

### 1. LAG and LEAD Functions

![LAG and LEAD Functions](/screenshots/1.jpeg)

LAG and LEAD functions access data from previous and subsequent rows without using self-joins. This example shows how to compare each employee's salary with others in the same department.

```sql
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
```

### 2. RANK and DENSE_RANK Functions

![RANK and DENSE_RANK Functions](image2.png)

These functions assign rankings to rows within a partition. RANK leaves gaps in ranking when there are ties, while DENSE_RANK assigns consecutive ranks.

```sql
SELECT
    id,
    name,
    department,
    salary,
    RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS rank_,
    DENSE_RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS dense_rank_
FROM employees;
```

### 3. Top N Per Group

![Top N Per Group](image3.png)

This query finds the top 3 highest-paid employees in each department using the RANK function.

```sql
SELECT *
FROM (
    SELECT
        id, name, department, salary,
        RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS rank_
    FROM employees
)
WHERE rank_ <= 3;
```

### 4. ROW_NUMBER Function

![ROW_NUMBER Function](image4.png)

ROW_NUMBER assigns unique sequential integers to rows within a partition. This example shows how to find the two earliest employees who joined each department.

```sql
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
```

### 5. Window Aggregate Functions

![Window Aggregate Functions](image5.png)

Window functions can perform aggregations without grouping rows together. This query shows each employee's salary alongside the maximum salary in their department and across the entire company.

```sql
SELECT
    id,
    name,
    department,
    salary,
    MAX(salary) OVER (PARTITION BY department) AS dept_max_salary,
    MAX(salary) OVER () AS overall_max_salary
FROM employees;
```

### 6. Data Distribution Overview

![Data Distribution Overview](image6.png)

This visualization provides an overview of the sample employee data used in these examples, showing the distribution of salaries across departments.

## Getting Started

1. Create the employees table using the provided SQL script
2. Insert the sample data
3. Run the example queries to see window functions in action

## Notes

- These examples use Oracle SQL syntax
- Window functions are part of the SQL:2003 standard and are available in most modern RDBMS
- The PARTITION BY clause is optional - if omitted, the window function treats the entire result set as a single partition
