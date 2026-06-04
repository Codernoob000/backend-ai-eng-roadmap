-- WHERE CLAUSE --
select *
FROM employee_salary
where salary <=50000
;

SELECT *
FROM employee_demographics
WHERE birth_date > '1985-01-01'
;

-- AND OR NOT -- Logical Operators
SELECT *
FROM employee_demographics
WHERE (first_name ='Tom' AND age=36) OR age>55
;

-- LIKE Statement --
-- %(anything after the given characters) and _ ( only specific character after the specific character)
SELECT *
FROM employee_demographics
WHERE birth_date LIKE '1989%'
;


