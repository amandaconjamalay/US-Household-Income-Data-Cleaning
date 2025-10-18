# US-Household-Income-Data-Cleaning
Cleaning the Household income dataset. 

Files: 
Both of these tables were loaded into an a SQL database for cleaning. 
* USHouseholdIncome (1).csv - contains geographic and demographic data for U.S households. 
* USHouseholdIncome_Statistics (1).csv - contains income statistics and related measures. 

Objectives:
* Identify and remove duplicates.
* Correcting incosistent or messy column names.
* Standardise categorical data such as State_Name and Type.
* Fill in missing values in key fields like Place
* Ensure land and water area columns (ALand, AWater) contain valid data.

Tools Used:
* DBMS: MySQL Workbench

1. Fixed Column Name Encoding Issue
Renamed a messy column name caused by encoding artifacts:
```MySQL
ALTER TABLE us_household_income_statistics RENAME COLUMN `ï»¿id` TO `id`;
```
2. Checked for Duplicates
Counted and located duplicate IDs:
```MySQL
SELECT id, COUNT(id)
FROM us_household_income
GROUP BY id 
HAVING COUNT(id) > 1;
```
3. Removed Duplicates
Deleted duplicate rows while retaining one record per ID:
```MySQL
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
```
4. Standardising State Names
Corrected capitilisation inconsistencies:
```MySQL
UPDATE us_household_income
SET State_Name = 'Alabama'
WHERE State_Name = 'alabama';
```
