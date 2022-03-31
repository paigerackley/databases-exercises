USE employees;
SELECT DISTINCT title FROM titles LIMIT 10;

-- 2. Zykh , Zyda , Zwicker , Zweizig , Zumaque , Zultner , Zucker , Zuberek , Zschoche , Zongker.
SELECT DISTINCT last_name FROM employees ORDER BY last_name DESC;

/* 3. # emp_no	birth_date	first_name	last_name	gender	hire_date
243297	1962-12-25	Alselm	Cappello	F	1990-01-01
34335	1960-12-25	Utz	Mandell	M	1990-01-03
400710	1963-12-25	Bouchung	Schreiter	M	1990-01-04
465730	1959-12-25	Baocai	Kushner	F	1990-01-05
490744	1959-12-25	Petter	Stroustrup	M	1990-01-10
*/
SELECT * FROM employees WHERE hire_date LIKE "199%"
AND birth_date LIKE '%-12-25' 
ORDER by hire_date ASC LIMIT 5;

/*4.# emp_no	birth_date	first_name	last_name	gender	hire_date
463558	1963-12-25	Pranay	Narwekar	F	1990-07-18
444269	1963-12-25	Marjo	Farrow	F	1990-07-18
291662	1962-12-25	Ennio	Karcich	M	1990-08-05
413687	1954-12-25	Dines	Lubachevsky	F	1990-08-06
416525	1952-12-25	Ipke	Fontan	M	1990-08-06;*/
SELECT * FROM employees WHERE hire_date BETWEEN '1990-01-01' 
AND '1999-12-31' AND birth_date LIKE '%-12-25' 
ORDER by hire_date LIMIT 5 OFFSET 45;