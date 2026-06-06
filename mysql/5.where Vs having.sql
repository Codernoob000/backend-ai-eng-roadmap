-- Having vs Where

select gender, avg(age)
From employee_demographics
group by gender
having avg(age) >40
;

SELECT occupation, AVG(salary)
FROM employee_salary
where occupation LIKE '%manager%'
GROUP By occupation
having avg(salary) >75000
;