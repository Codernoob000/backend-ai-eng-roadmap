-- Subqueries

select *
from employee_demographics
where employee_id IN(
			select employee_id
            from employee_salary
            where dept_id=1
);

select first_name,last_name, salary,
(select avg(salary)
from employee_salary) 
from employee_salary; 

select gender, avg(age),min(age),max(age),count(age)
from employee_demographics
group by gender;

select gender,avg(`MAX(age)`)
from 
(select gender, avg(age),min(age),max(age),count(age)
from employee_demographics
group by gender) as agg_table
;