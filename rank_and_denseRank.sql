select id,
       name,
       department,
       salary,
       rank()
       over(partition by department
            order by salary desc
       ) as rank_,
       dense_rank()
       over(partition by department
            order by salary desc
       ) as dense_rank_
  from employees;