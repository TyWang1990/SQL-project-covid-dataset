# SQL Project: COVID Dataset

This project focuses on utilizing various data manipulation commands in SQL to query a relational database containing tables with COVID death and vaccination information. The project is referenced from the content on the YouTube channel "Alex The Analyst."

## Queries

The project includes the following SQL queries:

1. **Query 1**: Show all columns from the `CovidDeaths$` table and order by values in column 3 and 4.
   - SQL functions: `SELECT`, `ORDER BY`

2. **Query 2**: Show all columns from the `CovidVaccinations$` table and order by values in column 3 and 4.
   - SQL functions: `SELECT`, `ORDER BY`

3. **Query 3**: Show selected columns of location, date, total_cases, new_cases, total_deaths, and population from the `CovidDeaths$` table and order by values in column 1 and 2.
   - SQL functions: `SELECT`, `ORDER BY`

4. **Query 4**: Show selected columns of location, date, total_cases, total_deaths, and calculate and name a new column called `death_rate` by dividing total_deaths with total_cases from the `CovidDeaths$` table. Filter the records by searching for location values containing 'zea' using a wildcard. Then order the results by values in column 1 and 2.
   - SQL functions: `SELECT`, `WHERE`, `LIKE`, `ORDER BY`

5. **Query 5**: Show selected columns of location, date, total_cases, and population. Calculate and name a new column called `infection_rate` by dividing total_cases with population from the `CovidDeaths$` table. Filter the records by searching for location values containing 'zea' using a wildcard. Then order the results by values in column 1 and 2.
   - SQL functions: `SELECT`, `WHERE`, `LIKE`, `ORDER BY`

6. **Query 6**: Show location and the maximum population difference of each location in the `CovidDeaths$` table.
   - SQL functions: `SELECT`, `MAX`, `MIN`, `GROUP BY`

7. **Query 7**: Show location, population, and the maximum total_cases as `Max_Total_Cases` of each location and population from the `CovidDeaths$` table. Store the query results into a new table called `infection_rate_summary$_2`.
   - SQL functions: `SELECT`, `MAX`, `INTO`, `GROUP BY`

8. **Query 8**: Show location and calculate a new column called `infection_rate` by dividing `Max_Total_cases` with population from the `infection_rate_summary$` table. Order the results by `infection_rate` in descending order.
   - SQL functions: `SELECT`, `ORDER BY`, `DESC`

9. **Query 9**: Show location, population, find the maximum total_cases per location and population. Calculate a column called `HIR` by dividing total_cases with population from the `CovidDeaths$` table. Order the query results based on `HIR` in descending order.
   - SQL functions: `SELECT`, `MAX`, `GROUP BY`, `ORDER BY`, `DESC`

10. **Query 10**: Show location, population. Convert the data type of `total_deaths` to int and find the maximum number of `total_deaths` with the name `MDC`. Calculate death rate by dividing `total_deaths` with population and name it as `HDR` from the `CovidDeaths$` table where continent is not null (include only countries). Order the results by `MDC` in descending order.
   

 - SQL functions: `SELECT`, `MAX`, `CAST(XXX AS XXX)`, `WHERE`, `GROUP BY`, `ORDER BY`, `DESC`

11. **Query 11**: Show location and the maximum total death with the column name `TotalDeathCount` (after converting the data type of `total_deaths`) from the `CovidDeaths$` table where continent is not null (include only countries). Order the results by `TotalDeathCount` in descending order.
    - SQL functions: `SELECT`, `MAX`, `CAST()`, `WHERE`, `GROUP BY`, `ORDER BY`, `DESC`

12. **Query 12**: Show the total number of new cases as `sum_cases`, total number of new deaths as `sum_deaths` (after converting the `new_deaths` column to int data type), and calculate death rate by date from `CovidDeaths` (include only countries).
    - SQL functions: `SELECT`, `SUM`, `CAST()`, `WHERE`, `GROUP BY`, `ORDER BY`

13. **Query 13**: Show the cumulative new vaccinations number over date by countries and several selected columns including continent, location, date, population, and new_vaccinations from the `CovidDeaths$` and `CovidVaccinations$` tables. Join them on location and date. The query results should only show the continent where it is not null (include only countries). Order the results by columns 2 and 3.
    - SQL functions: `SELECT`, `SUM`, `OVER(PARTITION BY XXX ORDER BY XXX)`, `JOIN XXX ON XXX AND XXX`, `WHERE`, `ORDER BY`

14. **Query 14**: Write a CTE table based on the query results from Query 13. Calculate the rolling vaccination rate by dividing the rolling vaccination with the total population and order the results by location and date.
    - SQL functions: All functions from Query 13 and `WITH CTE (XXX, XXX, XXX, ...) AS ()`

15. **Query 15**: Create a view based on the query results from Query 13.
    - SQL function: `CREATE VIEW XXX AS`
