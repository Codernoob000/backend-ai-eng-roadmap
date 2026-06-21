select *from layoffs;

-- 1. Remove duplicates
-- 2. Standardize the data
-- 3. Null Values or blank canvas
-- 4. Remove any columns



-- copy the table into another table. Don't work on raw data , always create a table for working
create table layoffs_staging
like layoffs;

select *
from layoffs_staging;

Insert layoffs_staging
select *
from layoffs;

select *,
ROW_NUMBER() OVER(
PARTITION BY company, industry,total_laid_off,percentage_laid_off,`date`) as row_num
from layoffs_staging;

WITH  duplicate_cte AS
(
select *,
ROW_NUMBER() OVER(
PARTITION BY company, industry,total_laid_off,percentage_laid_off,`date`,stage,country,funds_raised_millions) as row_num
from layoffs_staging
) 

SELECT *
FROM duplicate_cte
WHERE row_num>1;

select *
from layoffs_staging
WHERE company='Casper';



WITH  duplicate_cte AS
(
select *,
ROW_NUMBER() OVER(
PARTITION BY company, industry,total_laid_off,percentage_laid_off,`date`,stage,country,funds_raised_millions) as row_num
from layoffs_staging
) 
DELETE
FROM duplicate_cte
WHERE row_num>1;


CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` text,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` text ,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


select *
from layoffs_staging2;

Insert INTO layoffs_staging2
select *,
ROW_NUMBER() OVER(
PARTITION BY company, industry,total_laid_off,percentage_laid_off,`date`,stage,country,funds_raised_millions) as row_num
from layoffs_staging;


DELETE
from layoffs_staging2
where row_num>1;

select *
from layoffs_staging2;


-- Standardizing data

select company,TRIM(company)
from layoffs_staging2;

UPDATE layoffs_staging2
SET company=TRIM(company);

select *
from layoffs_staging2
WHERE industry LIKE 'Crypto%';


Update layoffs_staging2
SET industry ='Crypto'
WHERE industry LIKE 'Crypto%';

select distinct industry
from layoffs_staging2
ORDER by 1;


select distinct country, TRIM(TRAILING '.' FROM country)
from layoffs_staging2
order by 1;

UPDATE layoffs_staging2
SET country =TRIM(TRAILING '.' FROM country)
WHERE country LIKE 'United States%'
;

SELECT `date`,
str_to_date(`date`,'%m/%d/%Y')
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET `date`=str_to_date(`date`,'%m/%d/%Y')
;

ALTER TABLE layoffs_staging2
MODIFY COLUMN `date` DATE;

SELECT `date`
FROM layoffs_staging2
WHERE `date` LIKE '%-%';

UPDATE layoffs_staging2
SET `date` = REPLACE(`date`, '-', '/')
WHERE `date` LIKE '%-%';


select *
from layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off is NULL;

UPDATE layoffs_staging2
SET industry = NULL
WHERE industry='';

SELECT DISTINCT industry
from layoffs_staging2;

SELECT *
from layoffs_staging2
where industry is NULL
OR industry ='';


SELECT *
from layoffs_staging2
where company LIKE 'Bally%';


SELECT t1.industry,t2.industry
from layoffs_staging2 t1
JOIN layoffs_staging2 t2
	ON t1.company=t2.company 
WHERE (t1.industry IS NULL OR t1.industry ='')
AND t2.industry IS NOT NULL;


UPDATE layoffs_staging2 t1
JOIN layoffs_staging2 t2
	 ON t1.company=t2.company
SET t1.industry=t2.industry
WHERE t1.industry IS NULL
AND t2.industry IS NOT NULL
;



SELECT *
from layoffs_staging2;


select *
from layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off is NULL;

DELETE
from layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off is NULL;


ALTER TABLE layoffs_staging2
DROP COLUMN row_num;