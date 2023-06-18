--1
SELECT *
FROM [SQL_covid dataset].[dbo].[CovidDeaths$]
ORDER BY 3,4

--2
SELECT *
FROM dbo.CovidVaccinations$
ORDER BY 3,4

--3
SELECT location, date, total_cases, new_cases, total_deaths, population
FROM dbo.CovidDeaths$
ORDER BY 1,2

--4
SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 AS death_rate
FROM dbo.CovidDeaths$
WHERE location LIKE '%zea%' --find location of new zealand
ORDER BY 1,2

--5
SELECT location, date, total_cases, population, (total_cases/population)*100 AS infection_rate
FROM dbo.CovidDeaths$
WHERE location LIKE '%zea%' 
ORDER BY 1,2

--6
SELECT location, MAX(population) - MIN(population) AS Population_Difference
FROM dbo.CovidDeaths$
GROUP BY location

--7
SELECT 
location, 
MAX(total_Cases) AS Max_Total_Cases, 
population
INTO infection_rate_summary$_2
FROM dbo.CovidDeaths$
GROUP BY location, population

SELECT * FROM infection_rate_summary$_2;

--8
SELECT location, (Max_Total_Cases/population)*100 AS infection_rate
FROM
dbo.infection_rate_summary$
ORDER BY infection_rate DESC

--9
SELECT location, population, MAX(total_cases), MAX(total_cases/population)*100 AS HIR
FROM dbo.CovidDeaths$
GROUP BY location, population
ORDER BY HIR DESC

--10
SELECT location, population, MAX(CAST(total_deaths AS FLOAT)) AS	MDC, MAX(total_deaths/population)*100 AS HDR
FROM dbo.CovidDeaths$
WHERE continent IS NOT Null
GROUP BY location, population
ORDER BY MDC DESC

--11
SELECT location, MAX(CAST(total_deaths AS INT)) AS TotalDeathCount
FROM [SQL_covid dataset].[dbo].[CovidDeaths$]
WHERE continent IS null
GROUP BY location
ORDER BY TotalDeathCount DESC

--12
SELECT date, SUM(new_cases) AS sum_cases, SUM(CAST(new_deaths AS INT)) AS sum_deaths, (SUM(CAST(new_deaths AS INT))/SUM(new_cases))*100 AS GDR
FROM [SQL_covid dataset].[dbo].[CovidDeaths$]
WHERE continent IS NOT null
GROUP BY date
ORDER BY 1,2

--13
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(CAST(vac.new_vaccinations AS INT)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS RollingVac --start over with a new sum for a new location, rolling sum by adding ORDER BY date, otherwise only calculating sum for each country
FROM [SQL_covid dataset].[dbo].[CovidDeaths$] dea
JOIN
[SQL_covid dataset].[dbo].[CovidVaccinations$] vac
ON
dea.location=vac.location
AND
dea.date=vac.date
WHERE dea.continent IS NOT null
ORDER BY 2,3

--14
With PopVsVac (continent, location, data, population, new_vaccinations, RollingVac)
AS
(
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(CAST(vac.new_vaccinations AS INT)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS RollingVac --start over with a new sum for a new location
FROM [SQL_covid dataset].[dbo].[CovidDeaths$] dea
JOIN
[SQL_covid dataset].[dbo].[CovidVaccinations$] vac
ON
dea.location=vac.location
AND
dea.date=vac.date
WHERE dea.continent IS NOT null
--ORDER BY 2,3
)
SELECT *, (RollingVac/population)*100 AS VacPercentage
FROM PopVsVac
ORDER BY location, data


DROP TABLE IF exists #PctPoPVac
CREATE TABLE #PctPoPVac
(
continent nvarchar(255),
location nvarchar(255),
date datetime,
population numeric,
new_vaccinations numeric,
RollingVac numeric
)


INSERT INTO #PctPoPVac
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(CAST(vac.new_vaccinations AS INT)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS RollingVac --start over with a new sum for a new location
FROM [SQL_covid dataset].[dbo].[CovidDeaths$] dea
JOIN
[SQL_covid dataset].[dbo].[CovidVaccinations$] vac
ON
dea.location=vac.location
AND
dea.date=vac.date
WHERE dea.continent IS NOT null

SELECT *, (RollingVac/population)*100 AS VacPercentage
FROM #PctPoPVac
ORDER BY location, date

--15
USE [SQL_covid dataset]
GO
CREATE VIEW PercentPopulationVaccinated AS
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(CAST(vac.new_vaccinations AS INT)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS RollingVac --start over with a new sum for a new location
FROM [SQL_covid dataset].[dbo].[CovidDeaths$] dea
JOIN
[SQL_covid dataset].[dbo].[CovidVaccinations$] vac
ON
dea.location=vac.location
AND
dea.date=vac.date
WHERE dea.continent IS NOT null


SELECT * FROM PercentPopulationVaccinated




