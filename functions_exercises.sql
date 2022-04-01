USE employees;

-- 2.
select concat(first_name, ' ' , last_name) as full_name from employees 
where last_name like 'E%E';

-- 3.
select upper(concat(first_name, ' ' , last_name)) as full_name from employees 
where last_name like 'E%E';

-- 4.
SELECT first_name, last_name, datediff(now(), hire_date) as 'days_with_company'
from employees where hire_date like '199%' and birth_date like '%-12-25';

-- 5.
select min(salary) , max(salary) from salaries where to_date > curdate();

-- 6.
select lower(concat(substr(first_name, 1, 1), substr(last_name, 1, 4),
"_", substr(birth_date, 6, 2), substr(birth_date, 3, 2))) as username, first_name
last_name, birth_date from employees;