-- Window Functions

SELECT gender,avg(salary) as avg_salary
FROM employee_demographics dem
JOIN employee_salary sal
	On dem.employee_id=sal.employee_id
GROUP by gender;


SELECT dem.first_name,dem.last_name,
avg(salary) OVER(partition by gender) as avg_salary
FROM employee_demographics dem
JOIN employee_salary sal
	On dem.employee_id=sal.employee_id
;

SELECT dem.first_name,dem.last_name,gender,salary,
sum(salary) OVER(partition by gender order by dem.employee_id) as Rolling_total
FROM employee_demographics dem
JOIN employee_salary sal
	On dem.employee_id=sal.employee_id
;

SELECT dem.first_name,dem.last_name,gender,salary,
row_number() over(partition by gender order by salary DESC) as row_num,
rank() over(partition by gender order by salary DESC) as rank_num,
dense_rank() over(partition by gender order by salary DESC) as dense_rank_num
FROM employee_demographics dem
JOIN employee_salary sal
	On dem.employee_id=sal.employee_id
;

