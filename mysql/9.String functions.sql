-- String Functions

select length('skyfall');

SELECT first_name,length(first_name)
FROM employee_demographics
order by 2;

select upper('sky');
select lower('SKY');


SELECT first_name,UPPER(first_name)
FROM employee_demographics
;

SELECT TRIM('              sky       ');
SELECT LTRIM('              sky       ');
SELECT RTRIM('              sky       ');

SELECT first_name,LEFT(first_name,4),RIGHT(first_name,4)
from employee_demographics;

-- SUBSTRINGS
SELECT first_name,
LEFT(first_name,4),
RIGHT(first_name,4),
substring(first_name,3,2),
birth_date,
substring(birth_date,6,2) as birth_month
from employee_demographics;

select first_name,REPLACE(first_name,'a','z')
from employee_demographics;

select LOCATE('v','Rithvik');

select first_name,LOCATE('An',first_name)
from employee_demographics;


select first_name,last_name,
CONCAT(first_name,' ',last_name) as FULL_NAME
from employee_demographics;