# US Household Income Data Cleaning

SELECT * 
FROM us_household_income;

SELECT * 
FROM us_household_income_statistics;

# Changing messy title.
ALTER TABLE us_household_income_statistics RENAME COLUMN `ï»¿id` TO `id`;

# Counting number of ids in the us_household_income table.
SELECT COUNT(id)
FROM us_household_income;

# Counting number of ids in the us_household_income_statatics
SELECT COUNT(id) 
FROM us_household_income_statistics;

# Filter down based off id having account of.
-- Identifying duplicates to remove.
SELECT id, COUNT(id)
FROM us_household_income
GROUP BY id 
HAVING COUNT(id) > 1;

# Finding the duplicate ids.
SELECT *
FROM (
SELECT row_id,
id,
ROW_NUMBER() OVER(PARTITION BY id ORDER BY id) AS row_num
FROM us_household_income) AS duplicates
WHERE row_num > 1 
;

# Deleting the duplicate ids.
DELETE FROM us_household_income
WHERE row_id IN (
	SELECT row_id
	FROM (
		SELECT row_id,
		id,
		ROW_NUMBER() OVER(PARTITION BY id ORDER BY id) AS row_num
		FROM us_household_income) AS duplicates
	WHERE row_num > 1 )
;

# No duplicates to remove from the statistics table
SELECT id, COUNT(id)
FROM us_household_income_statistics
GROUP BY id 
HAVING COUNT(id) > 1;

# Checking distinct state names to find any misspellings.
SELECT DISTINCT State_name
FROM us_household_income
GROUP BY State_Name;

# Changing the incorrect names, when the a is lower case change it to an uppercase. 
UPDATE us_household_income
SET State_Name = 'Alabama'
WHERE State_Name = 'alabama';

# Filling in blanks or missing values in the place column. 
SELECT *
FROM us_household_income
WHERE County = 'Autauga County'
ORDER BY 1
;

# Filling in blank spaces.
UPDATE us_household_income
SET Place = 'Autaugaville'
WHERE County = 'Autauga County'
AND City = 'Vinemont';

# Checking type column.
SELECT Type, COUNT(Type)
FROM us_household_income
GROUP BY Type
#ORDER BY 1
;

UPDATE us_household_income
SET Type = replace(Type, "CDP", "CPD")
WHERE Type LIKE '%CDP%';

# Correcting misspellings.
UPDATE us_household_income
SET Type = 'Borough'
WHERE Type = 'Boroughs';

# Don't have any data that is zero for both columns 
SELECT ALand, AWater
FROM us_household_income
WHERE (AWater = 0 OR AWater = '' OR AWater IS NULL)
AND (ALand = 0 OR ALand = '' OR ALand IS NULL);
