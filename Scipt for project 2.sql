select * from layoffs_67_2;

## To fetch the companies with 100% laid off

select company, total_laid_off, percentage_laid_off
from layoffs_67_2
where percentage_laid_off >=1
order by total_laid_off desc;

## To fetch the companies with the max total laid off.

select company, max(total_laid_off)
from layoffs_67_2
group by company;

## To find the highest 5 companies, industries and countries in raised funds.

select company,industry, country, max(funds_raised_millions) as max_funds
from layoffs_67_2
group by 1,2,3
having max_funds is not null
order by max_funds desc limit 5;

## To find the companies & countries & years and months with the most total laid off.

select company, sum(total_laid_off) 
from layoffs_67_2
where total_laid_off is not null
group by company
order by sum(total_laid_off) desc;

select country, sum(total_laid_off) 
from layoffs_67_2
where total_laid_off is not null
group by country
order by sum(total_laid_off) desc;

select year(`date`), sum(total_laid_off) 
from layoffs_67_2
where year(`date`) is not null
group by year(`date`)
order by sum(total_laid_off) desc;

select mid(`date`,1,7) as `month`, sum(total_laid_off)
from layoffs_67_2
where mid(`date`,1,7) is not null 
group by `month`
order by 1 asc;

## To find the accumulated laid off over the span of the 3 years month by month.

With Rolling_Total as
(
select mid(`date`,1,7) as `month`, sum(total_laid_off) as laid_off
from layoffs_67_2
where mid(`date`,1,7) is not null 
group by `month`
order by 1 asc
)
select `month`,laid_off, sum(laid_off) over(order by `month`) as rolling_total
from Rolling_Total;

## To find the companies with the most laid offs per year.

with Company_Year (company , the_year, total_laid_off) as 
(
select company, year(`date`), sum(total_laid_off)
from layoffs_67_2
group by company,year(`date`)
)
select * , dense_rank()over(partition by the_year order by total_laid_off desc) as the_rank
from Company_Year
where the_year is not null
order by the_rank asc;


select * from layoffs_67_2;