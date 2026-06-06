-- Limit & Aliasing

select *
FROM employee_demographics
limit 3;


select *
FROM employee_demographics
ORDER BY age desc
limit 4;

select *
FROM employee_demographics
ORDER BY age desc
limit 2,2;

-- Aliasing

select gender , avg(age) as avg_age
from employee_demographics
group by gender
having avg_age >40