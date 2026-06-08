-- CTE's( common table reference)
-- it is a temporary table , so we need to execute it right after with block

WITH CTE_example as
(
SELECT gender,avg(salary) as avg_sal,max(salary) as max_sal,min(salary) as min_sal,count(salary) as count_sal
FROM employee_demographics dem
JOIN employee_salary sal
	On dem.employee_id=sal.employee_id
GROUP by gender
)
SELECT *
FROM CTE_example
;

-- without cte , it looks complex
select avg(avg_sal)
FROM(
SELECT gender,avg(salary) as avg_sal,max(salary) as max_sal,min(salary) as min_sal,count(salary) as count_sal
FROM employee_demographics dem
JOIN employee_salary sal
	On dem.employee_id=sal.employee_id
GROUP by gender
) example_subquery
;

WITH CTE_example as
(
SELECT employee_id,gender,birth_date
FROM employee_demographics 
where birth_date>'1985-01-01'
),
CTE_example2 as
(
SELECT employee_id,salary
FROM employee_salary 
where salary>50000
)
SELECT *
FROM CTE_example
JOIN CTE_example2
	ON CTE_example.employee_id = CTE_example2.employee_id
;

-- we can overwrite alias names 
WITH CTE_example (Gender ,AVG_SAL,MAX_SAL,MIN_SAL,COUNT_SAL) as
(
SELECT gender,avg(salary) as avg_sal,max(salary) as max_sal,min(salary) as min_sal,count(salary) as count_sal
FROM employee_demographics dem
JOIN employee_salary sal
	On dem.employee_id=sal.employee_id
GROUP by gender
)
SELECT *
FROM CTE_example
;
