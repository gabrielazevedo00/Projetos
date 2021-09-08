-- Visualizando Dataset
SELECT *
FROM PortifolioProject..NashvilleHousing

-- Convertendo a coluna SaleDate para o Formato Date, add uma coluna com o novo formato.
SELECT SaleDate, CONVERT(date,SaleDate)
FROM PortifolioProject..NashvilleHousing 

UPDATE NashvilleHousing
SET SaleDate = CONVERT(date,SaleDate)

-- Nova Coluna 

ALTER TABLE NashvilleHousing
ADD SaleDateCONVERTed Date;

UPDATE NashvilleHousing
SET SaleDateCONVERTed = CONVERT(date,SaleDate)

-- Vizualizando
SELECT SaleDateCONVERTed, CONVERT(date,SaleDate)
FROM PortifolioProject..NashvilleHousing 

-- Procurando por valores null

SELECT ParcelID, PropertyAddress
FROM PortifolioProject..NashvilleHousing 
WHERE PropertyAddress IS NULL 
ORDER BY ParcelID

SELECT a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress,b.PropertyAddress)
FROM PortifolioProject..NashvilleHousing a 
JOIN PortifolioProject..NashvilleHousing b
	ON a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
WHERE a.PropertyAddress IS NULL

-- Preenchendo valores nulos 

UPDATE a
SET PropertyAddress = ISNULL(a.PropertyAddress,b.PropertyAddress)
FROM PortifolioProject..NashvilleHousing a 
JOIN PortifolioProject..NashvilleHousing b
	ON a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
WHERE a.PropertyAddress IS NULL

-- Vizualizando
SELECT ParcelID, PropertyAddress
FROM PortifolioProject..NashvilleHousing 
ORDER BY ParcelID

-- Separando A coluna endereço 

SELECT
SUBSTRING(PropertyAddress,1,CHARINDEX(',',PropertyAddress) -1) as Address,
SUBSTRING(PropertyAddress,CHARINDEX(',',PropertyAddress) +1, LEN(PropertyAddress)) as Address 
FROM PortifolioProject..NashvilleHousing


-- Adicionando 2 novas colunas

ALTER TABLE NashvilleHousing
ADD PropertySplitAddress Nvarchar(255)

UPDATE NashvilleHousing
SET PropertySplitAddress = SUBSTRING(PropertyAddress,1,CHARINDEX(',',PropertyAddress) -1)


ALTER TABLE NashvilleHousing
ADD PropertySplitCity Nvarchar(255)

UPDATE NashvilleHousing
SET PropertySplitCity = SUBSTRING(PropertyAddress,CHARINDEX(',',PropertyAddress) +1, LEN(PropertyAddress))

-- Vizualizando

SELECT * 
from NashvilleHousing

-- Separando a coluna OwnerAddress em 3 partes (Address, City, State)

SELECT OwnerAddress
from NashvilleHousing

SELECT 
PARSENAME(REPLACE(OwnerAddress,',','.'),3)
,PARSENAME(REPLACE(OwnerAddress,',','.'),2)
,PARSENAME(REPLACE(OwnerAddress,',','.'),1)
from NashvilleHousing

--
ALTER TABLE NashvilleHousing
ADD OwnerSplitAddress Nvarchar(255)

UPDATE NashvilleHousing
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress,',','.'),3)

--
ALTER TABLE NashvilleHousing
ADD OwnerSplitCity Nvarchar(255)

UPDATE NashvilleHousing
SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress,',','.'),2)

--
ALTER TABLE NashvilleHousing
ADD OwnerSplitState Nvarchar(255)

UPDATE NashvilleHousing
SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress,',','.'),1)


-- Vizualizando

SELECT * 
FROM NashvilleHousing

-- Mudando 'Y' e 'N' for 'Yes' e 'No'


SELECT DISTINCT(SoldAsVacant), COUNT(SoldAsVacant)
FROM PortifolioProject..NashvilleHousing
GROUP BY SoldAsVacant
ORDER BY 2 


SELECT SoldAsVacant,
CASE WHEN SoldAsVacant = 'Y' THEN 'Yes'
	 WHEN SoldAsVacant = 'N' THEN 'No'
	 ELSE SoldAsVacant
	 END 
FROM PortifolioProject..NashvilleHousing


UPDATE NashvilleHousing
SET SoldAsVacant = CASE 
WHEN SoldAsVacant = 'Y' THEN 'Yes'
WHEN SoldAsVacant = 'N' THEN 'No'
ELSE SoldAsVacant
END 

-- Removendo Duplicatas

WITH RowNumCTE as (
SELECT *,
	ROW_NUMBER() OVER (
	PARTITION BY ParcelID,
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 ORDER BY
					UniqueID
					) row_num 
FROM PortifolioProject..NashvilleHousing
)

DELETE
FROM RowNumCTE
WHERE row_num > 1


-- 

SELECT * 
FROM PortifolioProject..NashvilleHousing

ALTER TABLE PortifolioProject..NashvilleHousing
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress

