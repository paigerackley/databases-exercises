USE employees;

-- 1.
SELECT  e.emp_no
FROM employees AS e
JOIN dept_emp AS de ON e.emp_no = de.emp_no
WHERE hire_date = (SELECT hire_date FROM employees WHERE emp_no = '101010')
AND de.to_date >= CURDATE();

-- 2. Find all the titles ever held by all current employees with the first name Aamod.
SELECT title
FROM titles
WHERE emp_no IN 
(SELECT employees.emp_no FROM employees
JOIN dept_emp USING(emp_no)
WHERE first_name = "Aamod"
AND to_date > NOW());

-- 3. How many people in the employees table are no longer working for the company? Give the answer in a comment in your code.
-- 59,900 returned.
select count(*) as "Former Employee Count"
from employees
where emp_no NOT IN ( -- the way to add NOT is to add NOT before the IN
    select emp_no 
    from dept_emp
    where to_date > now());
    -- to_date > now() is current
    
-- 4. Find all the current department managers that are female. List their names in a comment in your code.
-- What we need employees and dept manager table
SELECT *
FROM employees
WHERE emp_no IN 
(SELECT emp_no
FROM dept_manager
WHERE to_date > now())
AND gender = "F";

-- 5. Find all the employees who currently have a higher salary than the companies overall, historical average salary.
-- 154,543 returned.
SELECT emp_no
FROM salaries
JOIN employees USING(emp_no)
WHERE to_date > now()
AND salary > (SELECT avg(salary) FROM salaries);

-- 6. How many current salaries are within 1 standard deviation of the current highest salary? 
-- (Hint: you can use a built in function to calculate the standard deviation.) 
-- Pt 2. What percentage of all salaries is this?
-- # what is the max current salary:
select max(salary) from salaries where to_date > now();

-- # what is the 1 std for current salary;
select stddev(salary) from salaries where to_date > now();

-- Count of current salaries > (Max-1 std). (count = 83)
select count(*)
from salaries
where to_date > now()
and salary > (
(select max(salary) from salaries where to_date > now()) - 
(select std(salary) from salaries where to_date > now())
);

-- Denominator, count of all current salaries (240,124)
select count(*)
from salaries 
where to_date > now();


-- What percentage of all salaries is this?
-- SELECT (Numerator)/ (Denominator)
select((select count(*)
from salaries
where to_date > now()
and salary > (
(select max(salary) from salaries where to_date > now()) - 
(select std(salary) from salaries where to_date > now())
))/(select count(*)
from salaries 
where to_date > now())) * 100 as "percentage of salaries within 1 Stdev of Max";









