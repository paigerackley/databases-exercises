-- 1. 
USE join_example_db;
SELECT * FROM users;
SELECT * FROM roles;

-- 2.
SELECT * FROM users JOIN roles ON users.role_id = roles.id;
SELECT * FROM users LEFT JOIN roles ON users.role_id = roles.id;
SELECT * FROM users RIGHT JOIN roles ON users.role_id = roles.id;

-- 3.
SELECT roles.name AS role_name, COUNT(users.name) AS number_of_employees FROM users
RIGHT JOIN roles ON users.role_id = roles.id GROUP BY roles_name;

-- PART 2
USE employees;
SELECT * FROM departments;
SELECT * FROM dept_manager;
SELECT * FROM employees;
-- 2.
SELECT dept_name AS "Department Name", concat(first_name, " ", last_name) 
as "Manager Name" FROM employees
JOIN dept_manager ON dept_manager.emp_no = employees.emp_no
JOIN departments ON departments.dept_no = dept_manager.dept_no
WHERE dept_manager.to_date = '9999-01-01' ;

-- 3.
SELECT dept_name AS "Department Name", concat(first_name, " ", last_name) 
as "Manager Name" FROM employees
JOIN dept_manager ON dept_manager.emp_no = employees.emp_no
JOIN departments ON departments.dept_no = dept_manager.dept_no
WHERE employees.gender = "F" AND dept_manager.to_date = '9999-01-01'
ORDER BY dept_name;

-- 4. 
SELECT t.title, COUNT(de.emp_no) AS count
FROM dept_emp AS de JOIN titles as d ON d.dept_no = t.emp_no
AND t.to_date > CURDATE()
AND de.t_date > CURDATE()
JOIN departments AS d on d.dept_no = de.dept_no
AND dept_name = 'Customer Service'
GROUP BY t.title;


-- 5.
SELECT
	d.dept_name,
	CONCAT(e.first_name, ' ', e.last_name) AS current_department_manager,
	s.salary
FROM employees AS e
JOIN salaries AS s ON e.emp_no = s.emp_no
	AND s.to_date > CURDATE()
JOIN dept_manager AS dm ON dm.emp_no = e.emp_no
	AND dm.to_date > CURDATE()
JOIN departments AS d USING(dept_no)
ORDER BY dept_name;


-- 6.
SELECT d.dept_no, d.dept_name, COUNT(emp_no) AS num_employees
FROM dept_emp AS de JOIN departments AS d ON de.dept_no = d.dept_no
AND de.to_date > CURDATE()
GROUP BY dept_no, dept_name;

-- 7.
SELECT d.dept_name, ROUND(AVG(salary), 2) AS average_salary
FROM dept_emp AS de JOIN salaries AS s ON de.emp_no = s.emp_no
AND de.to_date > CURDATE () AND s.to_date > CURDATE()
JOIN departments AS d ON de.dept_no = d.dept_no
GROUP BY d.dept_name ORDER BY average_salary DESC LIMIT 1;

-- 8.
SELECT
	e.first_name,
	e.last_name
FROM employees AS e
JOIN dept_emp AS de ON e.emp_no = de.emp_no
	AND de.to_date > CURDATE()
JOIN salaries AS s ON e.emp_no = s.emp_no
	AND s.to_date > CURDATE()
JOIN departments AS d ON de.dept_no = d.dept_no
	AND d.dept_name = 'Marketing'
ORDER BY s.salary DESC
LIMIT 1;

-- 9.
SELECT
	e.first_name,
	e.last_name,
	s.salary,
	d.dept_name
FROM employees AS e
JOIN dept_manager AS dm ON e.emp_no = dm.emp_no
	AND to_date > CURDATE()
JOIN salaries AS s ON e.emp_no = s.emp_no
	AND s.to_date > CURDATE()
JOIN departments AS d USING(dept_no)
ORDER BY s.salary DESC
LIMIT 1;

-- 10.
SELECT d.dept_name, ROUND(AVG(s.salary),0) AS avg_dept_salary
FROM departments d
JOIN dept_emp de ON d.dept_no = de.dept_no
JOIN employees e ON e.emp_no = de.emp_no
JOIN salaries s ON e.emp_no = s.emp_no
GROUP BY d.dept_name
ORDER BY avg_dept_salary DESC;






