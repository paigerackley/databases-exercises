-- 2. 7 rows returned. 
SELECT DISTINCT title from titles;

-- 3.
SELECT
	last_name, COUNT(last_name)
FROM employees
WHERE last_name LIKE 'E%E'
GROUP BY last_name;

-- 4. 846 returned.
SELECT DISTINCT first_name, last_name FROM employees where last_name LIKE 'E%E'
GROUP BY first_name, last_name;

-- .5 Chleq, Lindqvist, Qiwen
SELECT last_name FROM employees WHERE last_name
LIKE '%q%' AND NOT last_name LIKE '%qu%'
GROUP BY last_name;

-- 6. 
SELECT last_name, COUNT(*) FROM employees WHERE last_name
LIKE '%q%' AND NOT last_name LIKE '%qu%'
GROUP BY last_name;

-- 7. 
SELECT gender, first_name, COUNT(gender) FROM employees 
WHERE first_name IN ('Irena' , 'Vidya' , 'Maya')
GROUP BY gender, first_name;

-- 8. 
SELECT 
lower(concat(substr(first_name, 1, 1), substr(last_name, 1, 4),
"_", 
substr(birth_date, 6, 2), 
substr(birth_date, 3, 2))) 
AS username,
COUNT(*) AS count_of_users
from employees
GROUP BY username;

-- 8B.
SELECT lower(concat(substr(first_name, 1, 1), substr(last_name, 1, 4),
"_", 
substr(birth_date, 6, 2), 
substr(birth_date, 3, 2))) 
AS username,
COUNT(*) AS count_of_users
from employees
GROUP BY username
HAVING count_of_users > 1;

