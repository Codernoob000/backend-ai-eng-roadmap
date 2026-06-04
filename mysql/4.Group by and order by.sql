Select *
From employee_demographics;

-- Group by--
Select gender, avg(age),max(age),min(age),count(age)
From employee_demographics
GROUP BY gender
;


Select occupation,salary
From employee_salary
group by occupation,salary
;

-- ORDER BY--
Select *
From employee_demographics
ORDER BY first_name ASC;

Select *
From employee_demographics
ORDER BY first_name DESC;

Select *
From employee_demographics
ORDER BY gender,age ;

-- use can use as a basis of column numbers but better to avoid it
Select *
From employee_demographics
ORDER BY 5,4
;
