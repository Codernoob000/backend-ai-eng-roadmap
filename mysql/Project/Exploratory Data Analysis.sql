-- Exploratory Data Aalysis

SELECT *
FROM layoffs_staging2;


SELECT MAX(total_laid_off),MAX(percentage_laid_off)
FROM layoffs_staging2;


ALTER TABLE layoffs_staging2
MODIFY COLUMN total_laid_off INT;

ALTER TABLE layoffs_staging2
MODIFY COLUMN funds_raised_millions INT;

ALTER TABLE layoffs_staging2
MODIFY COLUMN percentage_laid_off DECIMAL(5,2);

SELECT *
FROM layoffs_staging2
WHERE percentage_laid_off=1
order by funds_raised_millions DESC;


SELECT company, sum(total_laid_off)
FROM layoffs_staging2
group by company
order by 2 desc;

select min(`date`),max(`date`)
FROM layoffs_staging2
;


SELECT industry, sum(total_laid_off)
FROM layoffs_staging2
group by industry
order by 2 desc;


SELECT *
FROM layoffs_staging2;

SELECT country, sum(total_laid_off)
FROM layoffs_staging2
group by country
order by 2 desc;


SELECT YEAR(`date`), sum(total_laid_off)
FROM layoffs_staging2
group by YEAR(`date`)
order by 1 desc;

SELECT stage, sum(total_laid_off)
FROM layoffs_staging2
group by stage
order by 2 desc;

SELECT company, sum(percentage_laid_off)
FROM layoffs_staging2
group by company
order by 2 desc;

SELECT substring(`date`,1,7) AS `MONTH`, sum(total_laid_off)
FROM layoffs_staging2
where substring(`date`,1,7) IS NOT NULL
group by `month`
order by 1 asc;

WITH Rolling_Total AS
(
SELECT substring(`date`,1,7) AS `MONTH`, sum(total_laid_off) AS total_off
FROM layoffs_staging2
where substring(`date`,1,7) IS NOT NULL
group by `month`
order by 1 asc
)

SELECT `MONTH`,total_off,
SUM(total_off) OVER(ORDER BY `MONTH`) AS rolling_total
FROM Rolling_Total;

SELECT company, sum(total_laid_off)
FROM layoffs_staging2
group by company
order by 2 desc;

SELECT company,YEAR(`date`), sum(total_laid_off)
FROM layoffs_staging2
group by company,YEAR(`date`)
order by 3 desc;

WITH Company_year (company,years,total_laid_off) AS
(
SELECT company,YEAR(`date`), sum(total_laid_off)
FROM layoffs_staging2
group by company,YEAR(`date`)
), Company_year_rank as
(
SELECT *, dense_rank() over(partition by years order by total_laid_off desc) as ranking
From Company_year
where years is not null
)
select *
from Company_year_rank
where ranking <=5;