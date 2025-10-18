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

1. Initial Exploration
``` MySQL
SELECT * 
FROM us_household_income;

SELECT * 
FROM us_household_income_statistics;
