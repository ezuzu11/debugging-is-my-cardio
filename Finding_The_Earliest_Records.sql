select *
  from (
   select id,
          name,
          department,
          join_date,
          row_number()
          over(partition by department
               order by join_date
          ) as rn
     from employees
)
 where rn <= 2;