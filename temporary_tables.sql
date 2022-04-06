USE jemison_1752;
-- 1. Using the example from the lesson, create a temporary table called 
-- employees_with_departments that contains first_name, last_name, and dept_name for employees 
CREATE TEMPORARY TABLE employees_with_departments AS (SELECT first_name , last_name, dept_name
FROM employees.employees
JOIN employees.dept_emp on employees.dept_emp.emp_no = employees.employees.emp_no
JOIN employees.departments on employees.dept_emp.dept_no = employees.departments.dept_no);

SELECT * FROM employees_with_departments;
-- 1a. Add a column named full_name to this table. It should be a VARCHAR whose length is the 
-- sum of the lengths of the first name and last name columns. first_name (14) + last_name(16) " " = 31
ALTER TABLE employees_with_departments ADD full_name VARCHAR(31);

-- 1b. Update the table so that full name column contains the correct data
UPDATE employees_with_departments SET full_name = concat(first_name, ' ' , last_name);

-- 1c. Remove the first_name and last_name columns from the table.
ALTER TABLE employees_with_departments DROP COLUMN first_name;
ALTER TABLE employees_with_departments DROP COLUMN last_name;

-- 2. Create a temporary table based on the payment table from the sakila database.
CREATE TEMPORARY TABLE payments AS SELECT payment_id, customer_id, 
staff_id, rental_id, amount * 100 AS amount_in_pennies,
payment_date FROM sakila.payment;

ALTER TABLE sakila_payment MODIFY amount_in_pennies int NOT NULL;

-- 3. Find out how the current average pay in each department compares to the overall, 
-- historical average pay. In order to make the comparison easier, 
-- you should use the Z-score for salaries. In terms of salary, what is the best department 
-- right now to work for? The worst? 

-- 1st part. 63,810 historic avg, 16,904 historic standard dev
SELECT AVG(salary), std(salary) FROM employees.salaries;

CREATE TEMPORARY TABLE historic_aggregates AS
(SELECT AVG(salary) AS avg_salary, std(salary) AS
std_salary FROM employees.salaries);

SELECT dept_name, AVG(salary) AS department_current_average
FROM employees.salaries
JOIN employees.dept_emp USING(emp_no)
JOIN employees.departments USING(dept_no)
WHERE employees.dept_emp.to_date > CURDATE()
AND employees.salaries.to_date > CURDATE()
GROUP BY dept_name;

SELECT * FROM current_info;

-- Add all columns
ALTER TABLE current_info ADD historic_avg FLOAT(10,2);
ALTER TABLE current_info ADD historic_std FLOAT(10,2);
ALTER TABLE current_info ADD zscore FLOAT(10,2);

SELECT * FROM current_info;

-- set avg and std
UPDATE current_info SET historic_avg = (SELECT avg_salary FROM historic_aggregates);
UPDATE current_info SET historic_std = (SELECT std_salary FROM historic_aggregates);

-- UPDATE ZScore to hold the calculated zscores

UPDATE current_info
SET zscore = (department_current_average - historic_avg) / historic_std;

SELECT * FROM current_info
ORDER BY zscore DESC;






