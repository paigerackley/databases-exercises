USE employees;

-- 2. 709 returned. 
SELECT * FROM employees WHERE first_name IN ("Irena" , "Vidya" , "Maya");
-- 3. 709 returned. 
SELECT * FROM employees WHERE (first_name = 'Irena' OR first_name = 'Vidya' OR first_name = 'Maya');
-- 4. 441 returned. 
SELECT * FROM employees WHERE gender = "M" AND (first_name = "Irena" OR first_name = "Vidya" OR first_name = "Maya");
-- 5. 7330 returned. 
SELECT * FROM employees WHERE last_name LIKE "E%";
-- 6. 30,723. 23,393 end with E but do not start with E. 
SELECT * FROM employees WHERE last_name LIKE "%E" OR last_name LIKE "E%";
SELECT * FROM employees WHERE last_name LIKE "%E" AND NOT last_name LIKE "E%" ;
-- for second part of question
-- 7. 899 returned.
SELECT * FROM employees WHERE last_name LIKE 'E%' AND last_name LIKE '%E';
-- 24,492 returned
SELECT * FROM employees WHERE last_name LIKE '%E';
-- 8.135,214 returned.
SELECT * FROM employees WHERE hire_date LIKE '199%';
-- 9. 842 returned.
SELECT * FROM employees WHERE birth_date LIKE '%-12-25';
-- 10. 362 returned.
SELECT * FROM employees WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31' AND birth_date LIKE '%-12-25';
-- 11. 1,873 returned.
SELECT * FROM employees WHERE last_name LIKE '%q%';
-- 12. 547 returned.
SELECT * FROM employees WHERE last_name LIKE '%q%' AND NOT last_name LIKE '%qu%';


