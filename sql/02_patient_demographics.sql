/*
==========================================================
Healthcare SQL Analytics Portfolio
File: 02_patient_demographics.sql
Author: Esther Akinniyi
Database: Healthcare

Description:
This script analyzes patient demographic characteristics
using a simulated healthcare database. The analysis
summarizes gender, race, ethnicity, demographic
combinations, and county-level patient distributions.
==========================================================
*/


/*
----------------------------------------------------------
Query 1
Patient distribution by gender
----------------------------------------------------------
*/

SELECT
    gender,
    COUNT(*) AS total_patients
FROM healthcare.patients
GROUP BY
    gender
ORDER BY
    total_patients DESC;


/*
----------------------------------------------------------
Query 2
Patient distribution by race
----------------------------------------------------------
*/

SELECT
    race,
    COUNT(*) AS total_patients
FROM healthcare.patients
GROUP BY
    race
ORDER BY
    total_patients DESC;


/*
----------------------------------------------------------
Query 3
Patient distribution by ethnicity
----------------------------------------------------------
*/

SELECT
    ethnicity,
    COUNT(*) AS total_patients
FROM healthcare.patients
GROUP BY
    ethnicity
ORDER BY
    total_patients DESC;


/*
----------------------------------------------------------
Query 4
Unique combinations of gender, race, and ethnicity
----------------------------------------------------------
*/

SELECT
    gender,
    race,
    ethnicity,
    COUNT(*) AS patient_count
FROM healthcare.patients
GROUP BY
    gender,
    race,
    ethnicity
ORDER BY
    patient_count DESC;


/*
----------------------------------------------------------
Query 5
Patient distribution by county
----------------------------------------------------------
*/

SELECT
    county,
    COUNT(*) AS total_patients
FROM healthcare.patients
GROUP BY
    county
ORDER BY
    total_patients DESC;
