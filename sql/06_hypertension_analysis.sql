/*
==========================================================
Healthcare SQL Analytics Portfolio
File: 06_hypertension_analysis.sql
Author: Esther Akinniyi
Database: Healthcare

Description:
This script analyzes blood pressure observations using a
simulated healthcare database. The analysis identifies
patients with elevated blood pressure, evaluates medication
patterns, and summarizes hypertension-related trends by
patient race before January 1, 2020.
==========================================================
*/


/*
----------------------------------------------------------
Query 1
Patients with elevated blood pressure using a 135/85 cutoff
during 2018 and 2019
----------------------------------------------------------
*/

SELECT
    COUNT(DISTINCT patient) AS patients_with_elevated_bp_135_85
FROM healthcare.observations
WHERE (
        (description = 'Diastolic Blood Pressure' AND value > 85)
        OR
        (description = 'Systolic Blood Pressure' AND value > 135)
      )
  AND date >= '2018-01-01'
  AND date < '2020-01-01';


/*
----------------------------------------------------------
Query 2
Patients with elevated blood pressure using a 140/90 cutoff
during 2018 and 2019
----------------------------------------------------------
*/

SELECT
    COUNT(DISTINCT patient) AS patients_with_elevated_bp_140_90
FROM healthcare.observations
WHERE (
        (description = 'Diastolic Blood Pressure' AND value > 90)
        OR
        (description = 'Systolic Blood Pressure' AND value > 140)
      )
  AND date >= '2018-01-01'
  AND date < '2020-01-01';


/*
----------------------------------------------------------
Query 3
Most commonly prescribed medications for patients with
blood pressure above 140/90 during 2018 and 2019
----------------------------------------------------------
*/

SELECT
    med.description AS medication,
    COUNT(*) AS medication_count
FROM healthcare.observations AS bp
JOIN healthcare.medications AS med
    ON bp.patient = med.patient
    AND med.start >= bp.date
WHERE (
        (bp.description = 'Diastolic Blood Pressure' AND bp.value > 90)
        OR
        (bp.description = 'Systolic Blood Pressure' AND bp.value > 140)
      )
  AND bp.date >= '2018-01-01'
  AND bp.date < '2020-01-01'
GROUP BY
    med.description
ORDER BY
    medication_count DESC;


/*
----------------------------------------------------------
Query 4
Distinct patients with blood pressure above 140/90
before January 1, 2020 by race
----------------------------------------------------------
*/

SELECT
    pat.race,
    COUNT(DISTINCT pat.id) AS distinct_patients
FROM healthcare.observations AS bp
JOIN healthcare.patients AS pat
    ON bp.patient = pat.id
WHERE (
        (bp.description = 'Diastolic Blood Pressure' AND bp.value > 90)
        OR
        (bp.description = 'Systolic Blood Pressure' AND bp.value > 140)
      )
  AND bp.date < '2020-01-01'
GROUP BY
    pat.race
ORDER BY
    distinct_patients DESC;


/*
----------------------------------------------------------
Query 5
Total blood pressure readings before 2020 by race

Note:
Each blood pressure reading is represented by two rows in
the observations table: one systolic and one diastolic value.
Therefore, COUNT(*) is divided by 2.
----------------------------------------------------------
*/

SELECT
    pat.race,
    COUNT(*) / 2 AS total_bp_readings
FROM healthcare.observations AS bp
JOIN healthcare.patients AS pat
    ON bp.patient = pat.id
WHERE bp.description IN (
        'Diastolic Blood Pressure',
        'Systolic Blood Pressure'
      )
  AND bp.date < '2020-01-01'
GROUP BY
    pat.race
ORDER BY
    total_bp_readings DESC;


/*
----------------------------------------------------------
Query 6
High blood pressure readings before 2020 by race
using a 140/90 cutoff

Note:
Each blood pressure reading is represented by two rows in
the observations table: one systolic and one diastolic value.
Therefore, COUNT(*) is divided by 2.
----------------------------------------------------------
*/

SELECT
    pat.race,
    COUNT(*) / 2 AS high_bp_readings
FROM healthcare.observations AS bp
JOIN healthcare.patients AS pat
    ON bp.patient = pat.id
WHERE (
        (bp.description = 'Diastolic Blood Pressure' AND bp.value > 90)
        OR
        (bp.description = 'Systolic Blood Pressure' AND bp.value > 140)
      )
  AND bp.date < '2020-01-01'
GROUP BY
    pat.race
ORDER BY
    high_bp_readings DESC;


/*
----------------------------------------------------------
Query 7
Percentage of blood pressure readings above 140/90
before 2020 by race
----------------------------------------------------------
*/

SELECT
    total_bps.race,
    total_bps.total_bp_readings,
    high_bps.high_bp_readings,
    ROUND(
        100 * high_bps.high_bp_readings /
        NULLIF(total_bps.total_bp_readings, 0),
        2
    ) AS percent_high_bp_readings
FROM (
    SELECT
        pat.race,
        COUNT(*) / 2 AS total_bp_readings
    FROM healthcare.observations AS bp
    JOIN healthcare.patients AS pat
        ON bp.patient = pat.id
    WHERE bp.description IN (
            'Diastolic Blood Pressure',
            'Systolic Blood Pressure'
          )
      AND bp.date < '2020-01-01'
    GROUP BY
        pat.race
) AS total_bps
LEFT JOIN (
    SELECT
        pat.race,
        COUNT(*) / 2 AS high_bp_readings
    FROM healthcare.observations AS bp
    JOIN healthcare.patients AS pat
        ON bp.patient = pat.id
    WHERE (
            (bp.description = 'Diastolic Blood Pressure' AND bp.value > 90)
            OR
            (bp.description = 'Systolic Blood Pressure' AND bp.value > 140)
          )
      AND bp.date < '2020-01-01'
    GROUP BY
        pat.race
) AS high_bps
    ON total_bps.race = high_bps.race
ORDER BY
    percent_high_bp_readings DESC;
