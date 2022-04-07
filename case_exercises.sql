USE employees;
-- 1. Write a query that returns all employees, their department number, their start date, 
-- their end date, and a new column 'is_current_employee' that is a 1 if the employee is 
-- still with the company and 0 if not.
SELECT emp_no, dept_no, from_date, to_date,
IF (to_date > now(), 1, 0) as 'is_current_employee'
from dept_emp;

-- 2. Write a query that returns all employee names (previous and current), and a new column 
-- 'alpha_group' that returns 'A-H', 'I-Q', or 'R-Z' depending on the first letter of 
-- their last name.
SELECT first_name, last_name,
CASE
WHEN LEFT(last_name, 1) IN('a', 'b', 'c', 'd', 'e', 'f', 'g', 'h') THEN 'A-H'
WHEN LEFT(last_name, 1) IN('i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q') THEN 'I-Q'
	ELSE 'R-Z'
END AS alpha_group
FROM employees;

-- 3. How many employees (current or previous) were born in each decade?
/* 
182886	1950s
117138	1960s */

SELECT COUNT(*),
CASE
WHEN birth_date LIKE '195%-%-%' THEN '1950s'
WHEN birth_date LIKE '196%-%-%' THEN '1960s'
END AS Decade
FROM employees
GROUP BY Decade;

-- 4. What is the current average salary for each of the following department groups: 
-- R&D, Sales & Marketing, Prod & QM, Finance & HR, Customer Service?
SELECT
    CASE
        WHEN d.dept_name IN ('Research', 'Development') THEN 'R&D'
        WHEN d.dept_name IN ('Sales', 'Marketing') THEN 'Sales & Marketing'
        WHEN d.dept_name IN ('Production', 'Quality Management') THEN 'Prod & QM'
        WHEN d.dept_name IN ('Finance', 'Human Resources') THEN 'Finanace & HR'
        ELSE d.dept_name
    END AS dept_group,
    AVG(s.salary) AS avg_salary
FROM departments d
JOIN dept_emp de USING (dept_no)
JOIN salaries s USING (emp_no)
WHERE s.to_date > NOW() AND de.to_date > NOW()
GROUP BY dept_group;




