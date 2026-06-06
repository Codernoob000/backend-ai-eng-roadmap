-- Unions

SELECT first_name,last_name
from employee_demographics
UNION
SELECT first_name,last_name
from employee_salary 
;


SELECT first_name,last_name
from employee_demographics
UNION distinct
SELECT first_name,last_name
from employee_salary 
;
-- both produce same results

SELECT first_name,last_name
from employee_demographics
UNION ALL
SELECT first_name,last_name
from employee_salary 
;

SELECT first_name,last_name , 'oldman' as label
from employee_demographics
where age>40 AND gender ='Male'
UNION
SELECT first_name,last_name , 'oldlady' as label
from employee_demographics
where age>40 AND gender ='Female'
UNION
SELECT first_name,last_name , 'highly paid' as label
from employee_salary
where salary>70000
order by first_name,last_name
;