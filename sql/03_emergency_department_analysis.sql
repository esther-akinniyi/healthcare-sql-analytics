/*
==========================================================
Healthcare SQL Analytics Portfolio
File: 03_emergency_department_analysis.sql
Author: Esther Akinniyi
Database: Healthcare

Description:
This script analyzes emergency department encounters
using a simulated healthcare database. The analysis
evaluates encounter volumes, documented conditions,
and emergency department throughput to support
healthcare operational reporting.
==========================================================
*/


/*
----------------------------------------------------------
Query 1
Total emergency department encounters before January 1, 2020
----------------------------------------------------------
*/

SELECT
    COUNT(*) AS emergency_encounters_before_2020
FROM healthcare.encounters
WHERE start < '2020-01-01'
  AND encounterclass = 'Emergency';


/*
----------------------------------------------------------
Query 2
Most frequently documented conditions for emergency
department encounters before January 1, 2020
----------------------------------------------------------
*/

SELECT
    con.description,
    COUNT(*) AS total_occurrences
FROM healthcare.encounters AS enc
LEFT JOIN healthcare.conditions AS con
    ON enc.id = con.encounter
WHERE enc.start < '2020-01-01'
  AND enc.encounterclass = 'Emergency'
  AND con.description IS NOT NULL
GROUP BY
    con.description
ORDER BY
    total_occurrences DESC;


/*
----------------------------------------------------------
Query 3
Emergency department throughput (minutes)
for each encounter
----------------------------------------------------------
*/

SELECT
    enc.id,
    TIMESTAMPDIFF(MINUTE, enc.start, enc.stop) AS throughput_minutes
FROM healthcare.encounters AS enc
WHERE enc.start < '2020-01-01'
  AND enc.encounterclass = 'Emergency';


/*
----------------------------------------------------------
Query 4
Average emergency department throughput
----------------------------------------------------------
*/

SELECT
    AVG(TIMESTAMPDIFF(MINUTE, start, stop)) AS average_throughput_minutes
FROM healthcare.encounters
WHERE start < '2020-01-01'
  AND encounterclass = 'Emergency';


/*
----------------------------------------------------------
Query 5
Clinical conditions with an average emergency department
throughput greater than 100 minutes
----------------------------------------------------------
*/

SELECT
    con.description,
    AVG(TIMESTAMPDIFF(MINUTE, enc.start, enc.stop)) AS average_throughput_minutes
FROM healthcare.encounters AS enc
LEFT JOIN healthcare.conditions AS con
    ON enc.id = con.encounter
WHERE enc.start < '2020-01-01'
  AND enc.encounterclass = 'Emergency'
  AND con.description IS NOT NULL
GROUP BY
    con.description
HAVING
    AVG(TIMESTAMPDIFF(MINUTE, enc.start, enc.stop)) > 100
ORDER BY
    average_throughput_minutes DESC;
