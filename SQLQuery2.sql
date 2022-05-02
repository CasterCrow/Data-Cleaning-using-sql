select * from datacleaning..Nashvil


select saledate,convert(date,saledate) from datacleaning..Nashvil

alter table datacleaning..nashvil 
add  SaleDate date

update datacleaning..Nashvil

set SaleDate = SaleDateConverted 

select SaleDateConverted from datacleaning..Nashvil

alter table datacleaning..nashvil
drop  column SaleDateConverted
select * from datacleaning..Nashvil

select PropertyAddress
from datacleaning..Nashvil



select a.ParcelID,a.PropertyAddress,b.ParcelID,b.PropertyAddress
from datacleaning..Nashvil a
join datacleaning..Nashvil b
	on a.ParcelID=b.ParcelID
	and a.[UniqueID ]<>b.[UniqueID ]
where a.PropertyAddress is null

select a.ParcelID,a.PropertyAddress,b.ParcelID,b.PropertyAddress,ISNULL(a.PropertyAddress,b.PropertyAddress)
from datacleaning..Nashvil a
join datacleaning..Nashvil b
	on a.ParcelID=b.ParcelID
	and a.[UniqueID ]<>b.[UniqueID ]
where a.PropertyAddress is null


update a
set PropertyAddress = ISNULL(a.PropertyAddress,b.PropertyAddress)
from datacleaning..Nashvil a
join datacleaning..Nashvil b
	on a.ParcelID=b.ParcelID
	and a.[UniqueID ]<>b.[UniqueID ]
where a.PropertyAddress is null

select a.ParcelID,a.PropertyAddress,b.ParcelID,b.PropertyAddress
from datacleaning..Nashvil a
join datacleaning..Nashvil b
	on a.ParcelID=b.ParcelID
	and a.[UniqueID ]<>b.[UniqueID ]
where a.PropertyAddress is null



select 
SUBSTRING(propertyaddress,1,CHARINDEX(',' , propertyaddress)-1) as address,
SUBSTRING(propertyaddress,CHARINDEX(',' , propertyaddress)  +1 ,len(propertyaddress)) as address
from datacleaning..Nashvil


alter table datacleaning..nashvil
add propertysplitadress nvarchar (255),
 propertysplitCity nvarchar(255)

update datacleaning..Nashvil
set propertysplitadress = SUBSTRING(propertyaddress,1,CHARINDEX(',' , propertyaddress)-1) ,
 propertysplitCity = SUBSTRING(propertyaddress,CHARINDEX(',' , propertyaddress)  +1 ,len(propertyaddress))

select *
from datacleaning..Nashvil

select 
PARSENAME(replace(OwnerAddress,',','.'),1),
PARSENAME(replace(OwnerAddress,',','.'),2),
PARSENAME(replace(OwnerAddress,',','.'),3)
from datacleaning..Nashvil

alter table datacleaning..nashvil
add OwnersplitAddress nvarchar(255),
OwnerSplitCity nvarchar(255),
OwnerSplitState nvarchar(255)

update datacleaning..Nashvil
set OwnersplitAddress = PARSENAME(replace(OwnerAddress,',','.'),3),
OwnerSplitCity = PARSENAME(replace(OwnerAddress,',','.'),2),
OwnerSplitState = PARSENAME(replace(OwnerAddress,',','.'),1)

select * from datacleaning..Nashvil


select SoldAsVacant
,case when SoldAsVacant = 'Y' then 'Yes'
	when SoldAsVacant = 'N' then 'No'
	else SoldAsVacant
	end 
from datacleaning..Nashvil

update datacleaning..Nashvil
set SoldAsVacant = case when SoldAsVacant = 'Y' then 'Yes'
	when SoldAsVacant = 'N' then 'No'
	else SoldAsVacant
	end 

select distinct (soldasvacant)
from datacleaning..Nashvil




select * from datacleaning..Nashvil


select *,
ROW_NUMBER() over (partition by
		parcelid,
		propertyaddress,
		saleprice,
		legalreference
		order by
		uniqueid) row_num
from datacleaning..Nashvil

with RowNumCte as (select *,
ROW_NUMBER() over (partition by
		parcelid,
		propertyaddress,
		saleprice,
		legalreference
		order by
		uniqueid) row_num
from datacleaning..Nashvil)

select * from RowNumCte
where row_num >1
--order by propertyaddress

select * from datacleaning..Nashvil

alter table datacleaning..nashvil
drop column propertyaddress,owneraddress




