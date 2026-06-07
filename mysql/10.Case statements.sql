-- Case Statements

SELECT first_name,
last_name,
age,
CASE
	WHEN age<=30 THEN 'Young'
    WHEN age between 31 and 50 THEN 'Old'
    WHEN age>=50 THEN 'Legend'
END  as age_bracket
FROM employee_demographics;

-- Pay Increase and Bonus
-- < 50000 =5%
-- > 50000 =7%
-- Finance = 10% bonus

SELECT first_name,last_name,salary,
CASE
	WHEN salary<50000 THEN salary+(salary*0.05)
    WHEN salary>50000 THEN salary+(salary*0.07)
END as new_salary,
CASE
	WHEN dept_id=6 THEN (salary*0.1)
END as Bonus
FROM employee_salary;

SELECT *
FROM employee_salary;
select *
FROM parks_departments;
