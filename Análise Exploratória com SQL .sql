-- Selecionando

select *
from PortifolioProject..CovidDeaths
order by 3,4

select * 
from PortifolioProject..CovidVaccinations
order by 3,4 

select location,date, total_cases, new_cases, total_deaths, population
from PortifolioProject..CovidDeaths
order by 1,2

-- Total de Mortes vs Total de casos

select location,date, total_cases, total_deaths
from PortifolioProject..CovidDeaths
order by 1,2

-- Total de Mortes vs Total de Casos 
-- Porcentagem de Mortes por Covid

select location,date, total_cases, total_deaths,
try_convert (float,[total_deaths])/try_convert(float,[total_cases])*100 as DeathPercentage
from PortifolioProject..CovidDeaths
order by 1,2


-- Filtrando pelo Brazil

select location,date, total_cases,total_deaths,
try_convert (float,[total_deaths])/try_convert(float,[total_cases])*100 as DeathPercentage
from PortifolioProject..CovidDeaths
where location like 'Brazil' 
order by 1,2


-- Total de Casos vs População
-- Porcentagem da População que testou positivo

select location,date, total_cases,population,
(try_convert (float,[total_cases])/try_convert(float,[population]))*100 as PorcentPopulationInfected
from PortifolioProject..CovidDeaths
where location like 'Brazil' 
order by 1,2


-- Paises com maior porcentagem de infecção por população

select location,population, MAX(total_cases)as HighestInfectionCount,
max(try_convert (float,[total_cases])/try_convert(float,[population]))*100 as PorcentPopulationInfected
from PortifolioProject..CovidDeaths
group by location, population
order by PorcentPopulationInfected desc

-- Paises com maior indice de Mortos por População

select location,max(cast(total_deaths as float)) as TotalDeathCount
from PortifolioProject..CovidDeaths
where continent is not null
group by location
order by TotalDeathCount desc

-- Agrupando por Continente

select continent,max(cast(total_deaths as float)) as TotalDeathCount
from PortifolioProject..CovidDeaths
where continent is not null
group by continent
order by TotalDeathCount desc


-- Vacinação e total de vacinados ordenado por data

select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
sum(convert(float,vac.new_vaccinations)) over (partition by dea.location order by dea.location,dea.date) as total_vaccinations
from PortifolioProject..CovidDeaths dea
join PortifolioProject..CovidVaccinations vac
on dea.location = vac.location
and dea.date = vac.date
where dea.continent is not null
order by 2,3

