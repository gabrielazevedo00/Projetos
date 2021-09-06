-- Visualizando Dataset
select *
from PortifolioProject..NashvilleHousing

-- Convertendo a coluna SaleDate para o Formato Date, add uma coluna com o novo formato.
select SaleDate, convert(date,SaleDate)
from PortifolioProject..NashvilleHousing 

update NashvilleHousing
set SaleDate = convert(date,SaleDate)

-- Nova Coluna 

alter table NashvilleHousing
add SaleDateConverted Date;

update NashvilleHousing
set SaleDateConverted = convert(date,SaleDate)

-- Vizualizando
select SaleDateConverted, convert(date,SaleDate)
from PortifolioProject..NashvilleHousing 

-- Procurando por valores null

select ParcelID, PropertyAddress
from PortifolioProject..NashvilleHousing 
where PropertyAddress is null 
order by ParcelID

select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, isnull(a.PropertyAddress,b.PropertyAddress)
from PortifolioProject..NashvilleHousing a 
join PortifolioProject..NashvilleHousing b
	on a.ParcelID = b.ParcelID
	and a.[UniqueID ] <> b.[UniqueID ]
where a.PropertyAddress is null

-- Preenchendo valores nulos 

update a
set PropertyAddress = isnull(a.PropertyAddress,b.PropertyAddress)
from PortifolioProject..NashvilleHousing a 
join PortifolioProject..NashvilleHousing b
	on a.ParcelID = b.ParcelID
	and a.[UniqueID ] <> b.[UniqueID ]
where a.PropertyAddress is null

-- Vizualizando
select ParcelID, PropertyAddress
from PortifolioProject..NashvilleHousing 
order by ParcelID

