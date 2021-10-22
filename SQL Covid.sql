SELECT *
FROM [Portfolio Project]..CovidDeaths
Where continent is not null 
order by 3,4


--SELECT *
--FROM [Portfolio Project]..CovidVaccinations
--order by 3,4

-- Select Data that we are going to be using 

Select Location, Date, total_cases, new_cases, total_deaths, population
FROM [Portfolio Project]..CovidDeaths
Where continent is not null 
order by 1,2


-- Looking at total cases vs total deaths


Select Location, Date, total_cases,total_deaths, (total_deaths/total_cases)* 100 as DeathPercentage
FROM [Portfolio Project]..CovidDeaths
Where location like '%states%'
order by 1,2


-- Looking at total cases vs population
-- Shows what percentage of population got Covid


Select Location, Date, population, total_cases, (total_cases/population)* 100 as PercentPopulationInfected
FROM [Portfolio Project]..CovidDeaths
Where continent is not null 
order by 1,2

-- Looking at countries with highest infection rate compared to population 

Select Location, population, MAX(total_cases) as HighestInfectionCount, MAX((total_cases/population))* 100 as PercentPopulationInfected
FROM [Portfolio Project]..CovidDeaths
Where continent is not null 
Group by Location, population
order by PercentPopulationInfected desc

-- Showing Countries with Highest Death Count per Population

Select Location, MAX(cast(total_deaths as int)) as TotalDeathCount
FROM [Portfolio Project]..CovidDeaths
Where continent is not null 
Group by Location
order by TotalDeathCount  desc


-- LET'S BREAK THINGS DOWN BY CONTINENT

--Showing continents with the highest death counts per population

Select continent, MAX(cast(total_deaths as int)) as TotalDeathCount
FROM [Portfolio Project]..CovidDeaths
Where continent is not null 
Group by continent
order by TotalDeathCount  desc


--GLOBAL NUMBERS


Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(New_deaths as int))/SUM(New_cases)*100 as DeathPercentage
FROM [Portfolio Project]..CovidDeaths
--Where location like '%states%'
Where continent is not null
--Group By date
order by 1,2

Create View DeathPercenage as
SELECT Location, Date, total_cases,total_deaths, (total_deaths/total_cases)* 100 as DeathPercentage
FROM [Portfolio Project]..CovidDeaths
Where location like '%states%'

SELECT*
From DeathPercenage