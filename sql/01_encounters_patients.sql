/*
==========================================================
Healthcare SQL Analytics Portfolio
File: 01_encounters_patients.sql
Author: Esther Akinniyi
Database: Healthcare

Description:
This script analyzes patient encounter activity using a
simulated healthcare database. The analysis focuses on
encounter volumes, distinct patients, encounter classes,
and adult inpatient utilization before January 1, 2020.
==========================================================
*/


/*
----------------------------------------------------------
Query 1
Total encounters before January 1, 2020
----------------------------------------------------------
*/

SELECT
    COUNT(*) AS total_encounters_before_2020
FROM healthcare.encounters
WHERE start < '2020-01-01';


/*
----------------------------------------------------------
Query 2
Distinct patients treated before January 1, 2020
----------------------------------------------------------
*/

SELECT
    COUNT(DISTINCT patient) AS distinct_patients_before_2020
FROM healthcare.encounters
WHERE start < '2020-01-01';


/*
----------------------------------------------------------
Query 3
Encounter classes documented in the encounters table
----------------------------------------------------------
*/

SELECT
    encounterclass,
    COUNT(*) AS encounter_count
FROM healthcare.encounters
GROUP BY
    encounterclass
ORDER BY
    encounter_count DESC;


/*
----------------------------------------------------------
Query 4
Inpatient and ambulatory encounters before January 1, 2020
----------------------------------------------------------
*/

SELECT
    encounterclass,
    COUNT(*) AS encounter_count
FROM healthcare.encounters
WHERE start < '2020-01-01'
  AND encounterclass IN ('Inpatient', 'Ambulatory')
GROUP BY
    encounterclass
ORDER BY
    encounter_count DESC;


/*
----------------------------------------------------------
Query 5
Adult inpatient encounters where the patient was at least
21 years old at the time of the encounter
----------------------------------------------------------
*/

SELECT
    COUNT(*) AS adult_inpatient_encounters
FROM healthcare.encounters AS enc
JOIN healthcare.patients AS pat
    ON enc.patient = pat.id
WHERE FLOOR(DATEDIFF(enc.start, pat.birthdate) / 365.25) >= 21
  AND enc.encounterclass = 'Inpatient';
