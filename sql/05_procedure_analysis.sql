/*
==========================================================
Healthcare SQL Analytics Portfolio
File: 05_procedure_analysis.sql
Author: Esther Akinniyi
Database: Healthcare

Description:
This script analyzes healthcare procedures using a
simulated healthcare database. The analysis evaluates
procedure utilization, year-over-year trends, provider
organizations, and patient demographic distributions.
==========================================================
*/


/*
----------------------------------------------------------
Query 1
Total Colonoscopy procedures performed before 2020
----------------------------------------------------------
*/

SELECT
    description,
    COUNT(*) AS total_colonoscopy_procedures
FROM healthcare.procedures
WHERE date < '2020-01-01'
    AND description = 'COLONOSCOPY'
GROUP BY
    description;


/*
----------------------------------------------------------
Query 2
Total procedures performed during 2018
----------------------------------------------------------
*/

SELECT
    COUNT(*) AS total_procedures_2018
FROM healthcare.procedures
WHERE date >= '2018-01-01'
    AND date < '2019-01-01';


/*
----------------------------------------------------------
Query 3
Total procedures performed during 2019
----------------------------------------------------------
*/

SELECT
    COUNT(*) AS total_procedures_2019
FROM healthcare.procedures
WHERE date >= '2019-01-01'
    AND date < '2020-01-01';


/*
----------------------------------------------------------
Query 4
Compare procedure volumes between 2018 and 2019
----------------------------------------------------------
*/

SELECT
    YEAR(date) AS procedure_year,
    COUNT(*) AS total_procedures
FROM healthcare.procedures
WHERE date >= '2018-01-01'
    AND date < '2020-01-01'
GROUP BY
    YEAR(date)
ORDER BY
    procedure_year;


/*
----------------------------------------------------------
Query 5
Organizations performing the highest number of
Auscultation of the fetal heart procedures before 2020
----------------------------------------------------------
*/

SELECT
    enc.organization,
    org.name AS organization_name,
    COUNT(*) AS total_procedures
FROM healthcare.procedures AS procs
JOIN healthcare.encounters AS enc
    ON procs.encounter = enc.id
JOIN healthcare.organizations AS org
    ON enc.organization = org.id
WHERE procs.description = 'Auscultation of the fetal heart'
    AND procs.date < '2020-01-01'
GROUP BY
    enc.organization,
    org.name
ORDER BY
    total_procedures DESC;


/*
----------------------------------------------------------
Query 6
Procedure volume by patient race during 2019
----------------------------------------------------------
*/

SELECT
    pat.race,
    COUNT(*) AS total_procedures
FROM healthcare.procedures AS procs
JOIN healthcare.patients AS pat
    ON procs.patient = pat.id
WHERE procs.date >= '2019-01-01'
    AND procs.date < '2020-01-01'
GROUP BY
    pat.race
ORDER BY
    total_procedures DESC;


/*
----------------------------------------------------------
Query 7
Colonoscopy procedures by patient race before 2020
----------------------------------------------------------
*/

SELECT
    pat.race,
    COUNT(*) AS total_colonoscopy_procedures
FROM healthcare.procedures AS procs
JOIN healthcare.patients AS pat
    ON procs.patient = pat.id
WHERE procs.date < '2020-01-01'
    AND procs.description = 'COLONOSCOPY'
GROUP BY
    pat.race
ORDER BY
    total_colonoscopy_procedures DESC;


/*
----------------------------------------------------------
Query 8
Top 10 most frequently performed procedures
before January 1, 2020
----------------------------------------------------------
*/

SELECT
    description,
    COUNT(*) AS total_procedures
FROM healthcare.procedures
WHERE date < '2020-01-01'
GROUP BY
    description
ORDER BY
    total_procedures DESC
LIMIT 10;


/*
----------------------------------------------------------
Query 9
Procedure utilization by encounter class
----------------------------------------------------------
*/

SELECT
    enc.encounterclass,
    COUNT(*) AS total_procedures
FROM healthcare.procedures AS procs
JOIN healthcare.encounters AS enc
    ON procs.encounter = enc.id
GROUP BY
    enc.encounterclass
ORDER BY
    total_procedures DESC;
