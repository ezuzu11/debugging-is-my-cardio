create table employees (
   id         number primary key,
   name       varchar2(50),
   department varchar2(50),
   salary     number,
   join_date  date
);
-- Inserting sample datas to tables.
insert into employees (
   id,
   name,
   department,
   salary,
   join_date
) values ( 1,
           'Alice',
           'Marketing',
           7500,
           to_date('2022-09-16','YYYY-MM-DD') );
insert into employees (
   id,
   name,
   department,
   salary,
   join_date
) values ( 2,
           'Bob',
           'IT',
           5500,
           to_date('2023-08-12','YYYY-MM-DD') );
insert into employees (
   id,
   name,
   department,
   salary,
   join_date
) values ( 3,
           'Charlie',
           'Sales',
           6500,
           to_date('2019-08-16','YYYY-MM-DD') );
insert into employees (
   id,
   name,
   department,
   salary,
   join_date
) values ( 4,
           'David',
           'IT',
           5000,
           to_date('2021-05-11','YYYY-MM-DD') );
insert into employees (
   id,
   name,
   department,
   salary,
   join_date
) values ( 5,
           'Eve',
           'Sales',
           5000,
           to_date('2019-06-13','YYYY-MM-DD') );
insert into employees (
   id,
   name,
   department,
   salary,
   join_date
) values ( 6,
           'Frank',
           'Marketing',
           8000,
           to_date('2023-06-15','YYYY-MM-DD') );
insert into employees (
   id,
   name,
   department,
   salary,
   join_date
) values ( 7,
           'Grace',
           'Marketing',
           6500,
           to_date('2020-01-28','YYYY-MM-DD') );
insert into employees (
   id,
   name,
   department,
   salary,
   join_date
) values ( 8,
           'Heidi',
           'HR',
           6000,
           to_date('2021-10-12','YYYY-MM-DD') );
insert into employees (
   id,
   name,
   department,
   salary,
   join_date
) values ( 9,
           'Ivan',
           'Sales',
           4500,
           to_date('2018-12-14','YYYY-MM-DD') );
insert into employees (
   id,
   name,
   department,
   salary,
   join_date
) values ( 10,
           'Judy',
           'Sales',
           5000,
           to_date('2023-06-02','YYYY-MM-DD') );
insert into employees (
   id,
   name,
   department,
   salary,
   join_date
) values ( 11,
           'Karl',
           'Sales',
           4500,
           to_date('2022-04-10','YYYY-MM-DD') );
insert into employees (
   id,
   name,
   department,
   s4alary,
   join_date
) values ( 12,
           'Laura',
           'IT',
           5000,
           to_date('2019-10-14','YYYY-MM-DD') );
insert into employees (
   id,
   name,
   department,
   salary,
   join_date
) values ( 13,
           'Mallory',
           'HR',
           6500,
           to_date('2023-02-13','YYYY-MM-DD') );
insert into employees (
   id,
   name,
   department,
   salary,
   join_date
) values ( 14,
           'Niaj',
           'HR',
           5500,
           to_date('2018-12-17','YYYY-MM-DD') );
insert into employees (
   id,
   name,
   department,
   salary,
   join_date
) values ( 15,
           'Olivia',
           'Sales',
           6500,
           to_date('2022-01-25','YYYY-MM-DD') );
insert into employees (
   id,
   name,
   department,
   salary,
   join_date
) values ( 16,
           'Peggy',
           'HR',
           6000,
           to_date('2018-02-12','YYYY-MM-DD') );
insert into employees (
   id,
   name,
   department,
   salary,
   join_date
) values ( 17,
           'Quentin',
           'IT',
           5500,
           to_date('2021-07-19','YYYY-MM-DD') );
insert into employees (
   id,
   name,
   department,
   salary,
   join_date
) values ( 18,
           'Ruth',
           'IT',
           6500,
           to_date('2021-12-08','YYYY-MM-DD') );
insert into employees (
   id,
   name,
   department,
   salary,
   join_date
) values ( 19,
           'Sybil',
           'Marketing',
           4500,
           to_date('2023-08-25','YYYY-MM-DD') );
insert into employees (
   id,
   name,
   department,
   salary,
   join_date
) values ( 20,
           'Trent',
           'IT',
           6500,
           to_date('2021-01-21','YYYY-MM-DD') );


select *
  from employees;

select id,
       name,
       department,
       salary,
       lag(salary)
       over(partition by department
            order by salary
       ) as prev_salary,
       lead(salary)
       over(partition by department
            order by salary
       ) as next_salary,
       case
          when salary > lag(salary)
                        over(partition by department
                             order by salary
          ) then
             'HIGHER'
          when salary < lag(salary)
                        over(partition by department
                             order by salary
          ) then
             'LOWER'
          else
             'EQUAL'
       end as compare_with_prev
  from employees;

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

select *
  from (
   select id,
          name,
          department,
          salary,
          rank()
          over(partition by department
               order by salary desc
          ) as rank_
     from employees
)
 where rank_ <= 3;

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

select id,
       name,
       department,
       salary,
       max(salary)
       over(partition by department) as dept_max_salary,
       max(salary)
       over() as overall_max_salary
  from employees;