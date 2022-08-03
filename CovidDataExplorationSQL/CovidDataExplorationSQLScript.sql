
/*Covid-19 Data Exploration using MS SQL Server


-- GUIDING QUESTIONS
-- 1. How lethal is COVID-19 -- what percentage of cases result in death? How does the U.S. compare to global numbers?
-- 2. What does the death count look like at a continent level? Globally?
-- 3. What percentage of the population (by country) has contracted COVID by this point in time? (i.e., infection rate)
-- 4. How has the U.S. infection rate progressed over time since the onset of the pandemic?
-- 5. What is the rate of vaccination and boosters in the U.S.? What does the timeline look like?


Skills Used: Joins, CTE's, Temp Tables, Window Functions, Aggregate Functions, Creating Views, Converting Data Types

*/

Select *
From PortfolioProject..CovidDeaths
Where continent is not null
ORDER BY 3,4

--Selecting the data that we are starting with

Select location, date, total_cases, new_cases, total_deaths, population
From PortfolioProject..CovidDeaths
Where continent is not null
Order by 1,2


-- Total Cases vs. Total Deaths
-- Shows the likelihood of dying if you contract COVID in your country

Select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
From PortfolioProject..CovidDeaths
Where continent is not null --and location = 'United States'
Order by 1,2


-- Total Cases as Compared to Country Population
-- Shows what percentage of country population has contracted COVID

Select location, date, population, total_cases, (total_cases/population)*100 as InfectedPercentage
From PortfolioProject..CovidDeaths
Where continent is not null --and location = 'United States'
Order by 1,2


-- Countries with Highest Infection Rates Compared to Population

Select location, population, MAX(total_cases) as HighestInfectedCount, Max((total_cases/population))*100 as InfectedPercentage
From PortfolioProject..CovidDeaths
Where continent is not null
Group by population, location
Order by InfectedPercentage Desc


-- Countries with Highest Death Count per Population

Select location, MAX(cast(total_deaths as int)) as HighestDeathCount
From PortfolioProject..CovidDeaths
Where continent is not null --and location = 'United States'
Group by location
Order by HighestDeathCount Desc


-- BY CONTINENT

Select location, MAX(cast(total_deaths as int)) as HighestDeathCount
From PortfolioProject..CovidDeaths
Where continent is null and location in ('Europe', 'North America', 'Asia', 'South America', 'Africa', 'Oceania')
Group by location
Order by HighestDeathCount Desc


-- GLOBAL NUMBERS

--Daily cases, deaths, and % of cases resulting in death
Select date, SUM(new_cases) as TotalCases, SUM(cast(new_deaths as int)) as TotalDeaths, SUM(cast(new_deaths as int))/SUM(new_cases)*100 as GlobalDeathPercentage
From PortfolioProject..CovidDeaths
Where continent is not null --and location = 'United States'
Group by date
Order by 1,2


--Overall cases, deaths, and % of cases resulting in death
Select SUM(new_cases) as TotalCases, SUM(cast(new_deaths as int)) as TotalDeaths, SUM(cast(new_deaths as int))/SUM(new_cases)*100 as GlobalDeathPercentage
From PortfolioProject..CovidDeaths
Where continent is not null --and location = 'United States'
Order by 1,2


-- Total Vaccinations compared to Population with a Rolling Count of Vaccinations

Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
SUM(convert(bigint, vac.new_vaccinations)) OVER (Partition by dea.location Order by dea.location, 
dea.date) as RollingVaccinatedCount
From PortfolioProject..CovidDeaths as dea
Join PortfolioProject..CovidVaccinations as vac
	On dea.location = vac.location
	and dea.date = vac.date
Where dea.continent is not null
order by 2,3


-- Using CTE with the Partition By in the previous query to calculate Rolling Percentage of Population Vaccinated

With PopvsVac (Continent, Location, Date, Population, New_vaccinations, RollingVaccinatedCount)
as
(
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
SUM(convert(bigint, vac.new_vaccinations)) OVER (Partition by dea.location Order by dea.location, 
dea.date) as RollingVaccinatedCount
From PortfolioProject..CovidDeaths as dea
Join PortfolioProject..CovidVaccinations as vac
	On dea.location = vac.location
	and dea.date = vac.date
Where dea.continent is not null
)
Select *, (RollingVaccinatedCount/Population)*100 as RollingVaccinatedPercent
From PopvsVac


-- Using Temp Table to perform the same calculation on Partition By in previous query, as an alternative approach

DROP Table if exists #PercentPopulationVaccinated
Create Table #PercentPopulationVaccinated
(Continent nvarchar(255), 
Location nvarchar(255),
Date datetime, 
Population numeric, 
New_vaccinations numeric,
RollingVaccinatedCount numeric)

Insert into #PercentPopulationVaccinated
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
SUM(convert(bigint, vac.new_vaccinations)) OVER (Partition by dea.location Order by dea.location, 
dea.date) as RollingVaccinatedCount
From PortfolioProject..CovidDeaths as dea
Join PortfolioProject..CovidVaccinations as vac
	On dea.location = vac.location
	and dea.date = vac.date
Where dea.continent is not null

Select *, (RollingVaccinatedCount/Population)*100 as RollingVaccinatedPercent
From #PercentPopulationVaccinated


-- Percentage of Country Population Fully Vaccinated 
--(Where a 'Fully Vaccinated' individual is defined as one who has finished their vaccine, whether 1 or 2 doses, and two weeks have passed)

Select dea.continent, dea.location, dea.date, dea.population, vac.people_fully_vaccinated, vac.total_boosters, 
(cast(vac.people_fully_vaccinated as int)/dea.population)*100 as PercentPopFullyVaccinated
From PortfolioProject..CovidDeaths as dea
Join PortfolioProject..CovidVaccinations as vac
	On dea.location = vac.location
	and dea.date = vac.date
Where dea.continent is not null


-- Comparing Highest Fully Vaccinated Rates

Select dea.location,  
Max(cast(vac.people_fully_vaccinated as int)/dea.population)*100 as PercentPopFullyVaccinated
From PortfolioProject..CovidDeaths as dea
Join PortfolioProject..CovidVaccinations as vac
	On dea.location = vac.location
	and dea.date = vac.date
Where dea.continent is not null
Group by dea.location
Order by 2 desc


-- WITHIN JUST THE US

-- Percentage of People Fully Vaccinated and Boosted within the US
-- Problem: some people have received second boosters (meaning our percentages based on the total number of boosters given are inaccurate -- slightly inflated)
-- Solution: Import new CDC dataset ('BoostersUS') with information about second booster administrations, then join that table and deduct those numbers


DROP table if exists #PercentPopFullyVaccinated
Create Table #PercentPopFullyVaccinated
(continent nvarchar(255),
location nvarchar(255),
date datetime,
population numeric,
people_fully_vaccinated numeric,
total_boosters numeric,
Second_Booster float,
PercentPopFullyVaccinated float,
PercentPopFullyVaccinatedAndBoosted float,
PercentOfVaccBoosted float)

Insert into #PercentPopFullyVaccinated
Select dea.continent, dea.location, dea.date, dea.population, vac.people_fully_vaccinated, vac.total_boosters, 
replace(boo.Second_Booster,',',''),
(cast(vac.people_fully_vaccinated as int)/dea.population)*100 as PercentPopFullyVaccinated,
(cast(vac.total_boosters as int) - convert(int, replace(boo.Second_Booster, ',','')))/dea.population*100 as PercentPopFullyVaccinatedAndBoosted,
(cast(vac.total_boosters as int) - convert(int, replace(boo.Second_Booster, ',','')))/cast(vac.people_fully_vaccinated as float)*100 as PercentofVaccBoosted
From PortfolioProject..CovidDeaths as dea
Join PortfolioProject..CovidVaccinations as vac
	On dea.location = vac.location
	and dea.date = vac.date
Left Outer Join PortfolioProject..BoostersUS as boo
	On dea.location = boo.location
	and dea.date = boo.date
Where dea.continent is not null and dea.location = 'United States'

Select *
From #PercentPopFullyVaccinated


-- Most Recent Numbers Only

Select *
From #PercentPopFullyVaccinated
Where date = '2022-07-06'



-- Creating Views to store data for later visualizations

Create View PercentPopulationVaccinated as
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
SUM(convert(bigint, vac.new_vaccinations)) OVER (Partition by dea.location Order by dea.location, 
dea.date) as RollingVaccinatedCount
From PortfolioProject..CovidDeaths as dea
Join PortfolioProject..CovidVaccinations as vac
	On dea.location = vac.location
	and dea.date = vac.date
Where dea.continent is not null


Create View USVaccinationsAndBoosters as
Select dea.continent, dea.location, dea.date, dea.population, vac.people_fully_vaccinated, vac.total_boosters, 
replace(boo.Second_Booster,',','') as Second_Booster,
(cast(vac.people_fully_vaccinated as int)/dea.population)*100 as PercentPopFullyVaccinated,
(cast(vac.total_boosters as int) - convert(int, replace(boo.Second_Booster, ',','')))/dea.population*100 as PercentPopFullyVaccinatedAndBoosted,
(cast(vac.total_boosters as int) - convert(int, replace(boo.Second_Booster, ',','')))/cast(vac.people_fully_vaccinated as float)*100 as PercentofVaccBoosted
From PortfolioProject..CovidDeaths as dea
Join PortfolioProject..CovidVaccinations as vac
	On dea.location = vac.location
	and dea.date = vac.date
Left Outer Join PortfolioProject..BoostersUS as boo
	On dea.location = boo.location
	and dea.date = boo.date
Where dea.continent is not null and dea.location = 'United States'



-- Creating Tables specifically for Tableau Vizzes

-- 1.
Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
From PortfolioProject..CovidDeaths
where continent is not null 
order by 1,2

-- 2.
Select location, SUM(cast(new_deaths as int)) as TotalDeathCount
-- , SUM(new_cases) as total_cases, SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
From PortfolioProject..CovidDeaths
Where continent is null 
and location in ('Europe', 'North America', 'South America', 'Asia', 'Oceania', 'Africa')
Group by location
order by TotalDeathCount desc

-- 3.
Select location, population, MAX(total_cases) as HighestInfectedCount, Max((total_cases/population))*100 as InfectedPercentage
From PortfolioProject..CovidDeaths
Where continent is not null
Group by population, location
Order by InfectedPercentage Desc

-- 4.
Select Location, Population,date, MAX(total_cases) as HighestInfectedCount,  Max((total_cases/population))*100 as InfectedPercentage
From PortfolioProject..CovidDeaths
--Where location like '%states%'
Group by Location, Population, date
order by InfectedPercentage desc

-- 5.
Select *
From #PercentPopFullyVaccinated
Where date = '2022-07-06'


-- 6.
Select dea.date, dea.new_cases, dea.hosp_patients, dea.new_deaths,  vac.new_tests, vac.new_vaccinations
From PortfolioProject..CovidDeaths as dea
Join PortfolioProject..CovidVaccinations as vac
	On dea.location = vac.location
	and dea.date = vac.date
Where dea.continent is not null
and dea.location = 'United States'
Order by dea.date

-- 7.
Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
From PortfolioProject..CovidDeaths
where location = 'United States'
order by 1,2
