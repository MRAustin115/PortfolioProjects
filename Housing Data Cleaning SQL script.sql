/*

Cleaning Housing Data in SQL Queries

Skills Used: Joins, CTEs, Window Functions, Converting Data Types

*/

SELECT *
FROM PortfolioProject.dbo.NashvilleHousing


-----------------------------------------------------------------------------------------------------------------------
-- Changing Date Format (Removing unnecessary time)


ALTER TABLE NashvilleHousing
ALTER COLUMN SaleDate DATE

-- Could also use...
--UPDATE NashvilleHousing
--SET SaleDate = CONVERT(Date, SaleDate)


-----------------------------------------------------------------------------------------------------------------------
-- Populating Property Address Data

/* 
There is missing property address data for some observations, but these observations have ParcelID values 
that match other observations with the correct property address info. Using a self-join to show this and 
populate those missing property addresses
*/

SELECT *
FROM PortfolioProject.dbo.NashvilleHousing
--Where PropertyAddress is null
ORDER BY ParcelID

-- ISNULL replaces null column values in the original with the corresponding column values from the joined copy
SELECT orig.ParcelID, orig.PropertyAddress, copy.ParcelID, copy.PropertyAddress, 
	ISNULL(orig.PropertyAddress, copy.PropertyAddress)
FROM PortfolioProject.dbo.NashvilleHousing AS orig
JOIN PortfolioProject.dbo.NashvilleHousing AS copy
	ON orig.ParcelID = copy.ParcelID
	AND orig.[UniqueID ] <> copy.[UniqueID ]
WHERE orig.PropertyAddress is null

-- Updating the dataset with the previous query
UPDATE orig
SET PropertyAddress = ISNULL(orig.PropertyAddress, copy.PropertyAddress)
FROM PortfolioProject.dbo.NashvilleHousing AS orig
JOIN PortfolioProject.dbo.NashvilleHousing AS copy
	ON orig.ParcelID = copy.ParcelID
	AND orig.[UniqueID ] <> copy.[UniqueID ]
WHERE orig.PropertyAddress is null


-----------------------------------------------------------------------------------------------------------------------
-- Separating Address Pieces into Individual Columns (Address, City, State)

SELECT PropertyAddress
FROM PortfolioProject.dbo.NashvilleHousing


/* 
Using Charindex to find the location of the delimiter (comma in this case) and Substring to separate based on that 
location. The '-1' and '+1' are used to leave the comma out of the returned values
*/

SELECT
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1 ) AS Address,
SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1, LEN(PropertyAddress)) AS City
FROM PortfolioProject.dbo.NashvilleHousing

-- Adding columns for the new split variables and updating them using the previous query
ALTER TABLE NashvilleHousing
ADD PropertySplitAddress NVARCHAR(255),
	PropertySplitCity NVARCHAR(255);

UPDATE NashvilleHousing
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1 ),
	PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1, LEN(PropertyAddress))


-- Realized that a blank space was left leading the new Property City column after the split, so trimming that out
-- Should probably just use +2 next time in CHARINDEX -- > Hindsight 20/20
UPDATE NashvilleHousing
SET PropertySplitCity = LTRIM(PropertySplitCity)


-- Separating out column values, like above, with OwnerAddress, but using the Parsename function
SELECT OwnerAddress
FROM PortfolioProject.dbo.NashvilleHousing


-- Splitting the 3 parts of the Address
-- Also replacing commas with periods, because Parsename only works with periods
SELECT
PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3),
PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2),
PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1)
FROM PortfolioProject.dbo.NashvilleHousing

-- Adding columns for the new split variables and updating them using the previous query
ALTER TABLE NashvilleHousing
ADD OwnerSplitAddress NVARCHAR(255),
	OwnerSplitCity NVARCHAR(255),
	OwnerSplitState NVARCHAR(255);

UPDATE NashvilleHousing
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3),
	OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2),
	OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1)


-----------------------------------------------------------------------------------------------------------------------
-- Changing Y and N to 'Yes' and 'No' in "Sold as Vacant" field

-- Viewing the unique values and their respective counts
SELECT DISTINCT(SoldAsVacant), COUNT(SoldAsVacant)
FROM PortfolioProject.dbo.NashvilleHousing
GROUP BY SoldasVacant
ORDER BY 2

-- Checking code to make sure replaces correctly
SELECT SoldAsVacant,
 CASE WHEN SoldAsVacant = 'Y' THEN 'Yes'
	WHEN SoldAsVacant = 'N' THEN 'No'
	ELSE SoldAsVacant
	END
FROM PortfolioProject.dbo.NashvilleHousing

-- Updating column in dataset
UPDATE NashvilleHousing
SET SoldAsVacant = CASE WHEN SoldAsVacant = 'Y' THEN 'Yes'
	WHEN SoldAsVacant = 'N' THEN 'No'
	ELSE SoldAsVacant
	END


-----------------------------------------------------------------------------------------------------------------------
-- Changing 'VACANT RES LAND' and 'VACANT RESIENTIAL LAND' to 'VACANT RESIDENTIAL LAND' for consistency
-- Also correcting for a typo in 'Restaurant/Cafeteria'

SELECT DISTINCT(LandUse), COUNT(LandUse)
FROM PortfolioProject.dbo.NashvilleHousing
GROUP BY LandUse
ORDER BY 2 DESC

SELECT LandUse,
CASE WHEN LandUse = 'VACANT RES LAND' THEN 'VACANT RESIDENTIAL LAND'
	 WHEN LandUse = 'VACANT RESIENTIAL LAND' THEN 'VACANT RESIDENTIAL LAND'
	 ELSE LandUse
	 END
FROM PortfolioProject.dbo.NashvilleHousing

UPDATE NashvilleHousing
SET LandUse = CASE 
		WHEN LandUse = 'VACANT RES LAND' THEN 'VACANT RESIDENTIAL LAND'
		WHEN LandUse = 'VACANT RESIENTIAL LAND' THEN 'VACANT RESIDENTIAL LAND'
		WHEN LandUse = 'RESTURANT/CAFETERIA' THEN 'RESTAURANT/CAFETERIA'
		ELSE LandUse
		END


-----------------------------------------------------------------------------------------------------------------------
-- Removing Duplicates (Just Practice - Usually do not delete data from dataset without approval to do so)

-- Need the CTE (or a temp table) to follow-up after Windows function
WITH RowNumCTE AS(
SELECT *,
	ROW_NUMBER() OVER (
	PARTITION BY ParcelID,
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 ORDER BY
					UniqueID
					) AS row_num
FROM PortfolioProject.dbo.NashvilleHousing
)
DELETE --Select *
FROM RowNumCTE
WHERE row_num > 1
--Order by PropertyAddress


-----------------------------------------------------------------------------------------------------------------------
-- Deleting Unused Columns (Just Practice - Do this with Views normally NOT the actual datasets)

SELECT *
FROM PortfolioProject.dbo.NashvilleHousing

ALTER TABLE PortfolioProject.dbo.NashvilleHousing
DROP COLUMN OwnerAddress, PropertyAddress


-----------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------