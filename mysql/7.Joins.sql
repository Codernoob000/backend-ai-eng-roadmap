-- Joins

SELECT *
from employee_demographics;

select *
from employee_salary;

-- Inner Join
SELECT ed.employee_id,es.salary
from employee_demographics ed
INNER JOIN employee_salary es
	ON ed.employee_id = es.employee_id
;

-- OUTER JOINs

-- LEFT Join
SELECT *
from employee_demographics ed
LEFT JOIN employee_salary es
	ON ed.employee_id = es.employee_id
;


-- RIGHT Join
SELECT *
from employee_demographics ed
RIGHT JOIN employee_salary es
	ON ed.employee_id = es.employee_id
;

-- SELF JOIN
SELECT emp1.employee_id as emp_santa,
emp1.first_name as first_name_santa,
emp1.last_name as last_name_santa,
emp2.employee_id as emp_name,
emp2.first_name as first_emp_name,
emp2.last_name as last_emp_name
from employee_salary emp1
JOIN employee_salary emp2
	ON emp1.employee_id+1=emp2.employee_id
;

-- Joining multiple tables together
SELECT *
from employee_demographics ed
INNER JOIN employee_salary es
	ON ed.employee_id = es.employee_id
inner join parks_departments pd
  on es.dept_id=pd.department_id
;
 
