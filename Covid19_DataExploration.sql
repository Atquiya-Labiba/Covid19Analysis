--Show Table
select * from Portfolio_project.dbo.CovidDeaths

--Total Cases over Total Deaths
select continent,location,date,total_cases,total_deaths,cast(total_deaths as float)/cast(total_cases as float) *100 AS '% Ratio of Deaths' from Portfolio_project.dbo.CovidDeaths 
 where continent is not null order by 3 desc

--Total Cases vs Population 
select continent,location,date,total_cases,population,cast(total_cases as float)/cast(population as float) *100 AS '% Ratio of Total cases' from Portfolio_project.dbo.CovidDeaths
where continent is not null order by 3 desc

--Probability of dying if get in contact in Bangladesh
select location,date,total_cases,total_deaths,cast(total_deaths as float)/cast(total_cases as float) *100 AS '% Ratio of Deaths' from Portfolio_project.dbo.CovidDeaths 
where location='Bangladesh' order by 2 desc

--Total Cases vs Population in Bangladesh
select location,date,total_cases,population,cast(total_cases as float)/cast(population as float) *100 AS '% Ratio of Total cases' from Portfolio_project.dbo.CovidDeaths
where location='Bangladesh' order by 2 desc

--Highest Covid Infected compared to population
select location,max(total_cases) as 'Highest Covid Cases',population,max(cast(total_cases as float)/cast(population as float) *100 )AS '% Ratio of Total cases' from Portfolio_project.dbo.CovidDeaths
group by location,population order by '% Ratio of Total cases' desc

--Countries with Highest Death 
select location,max(total_deaths) as 'Highest Death',population,max(cast(total_deaths as float)/cast(population as float) *100 )AS '% Ratio of Total deaths' from Portfolio_project.dbo.CovidDeaths
where continent is not null group by location,population order by '% Ratio of Total deaths' desc

--Breaking Down by Continents
select continent,max(total_deaths) as 'Highest Death',population,max(cast(total_deaths as float)/cast(population as float) *100 )AS '% Ratio of Total deaths' from Portfolio_project.dbo.CovidDeaths
where continent is not null group by continent,population order by '% Ratio of Total deaths' desc

--Global Numbers
select sum(cast(new_cases as int)) as total_cases, sum(cast(new_deaths as int)) as total_deaths, sum(cast(new_deaths as float))/sum(cast(new_cases as float))*100 as 'Death Percentage'
from Portfolio_project.dbo.CovidDeaths where continent is not null order by 1,2


--Show Covid Vaccines Table
select * from Portfolio_project.dbo.CovidVaccines

--Vaccinations over population
select death.continent, death.location, death.date, death.population, vacc.new_vaccinations
, sum(convert(bigint,vacc.new_vaccinations)) over(Partition by death.location) as RollingPeopleVaccinated
from Portfolio_project.dbo.CovidDeaths death
Join Portfolio_project.dbo.CovidVaccines vacc
	On death.location = vacc.location
	and death.date = vacc.date
where death.continent is not null 

--Create View for data visualization
Create View PopulationVaccinatedPercent as
select death.continent, death.location, death.date, death.population, vacc.new_vaccinations
, sum(convert(bigint,vacc.new_vaccinations)) over(Partition by death.location) as RollingPeopleVaccinated
from Portfolio_project.dbo.CovidDeaths death
Join Portfolio_project.dbo.CovidVaccines vacc
	On death.location = vacc.location
	and death.date = vacc.date
where death.continent is not null 



