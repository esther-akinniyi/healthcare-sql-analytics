/*
==========================================================
Healthcare SQL Analytics Portfolio
File: 07_healthcare_financial_analysis.sql
Author: Esther Akinniyi
Database: Healthcare

Description:
This script performs financial and operational analysis
using a simulated healthcare database. The analysis
summarizes healthcare costs, payer performance,
encounter reimbursement, and organizational financial
metrics commonly used in healthcare reporting.
==========================================================
*/


/*
----------------------------------------------------------
Query 1
Total claim cost before January 1, 2020
----------------------------------------------------------
*/

SELECT
    ROUND(SUM(total_claim_cost),2) AS total_claim_cost
FROM healthcare.encounters
WHERE start < '2020-01-01';


/*
----------------------------------------------------------
Query 2
Total payer coverage before January 1, 2020
----------------------------------------------------------
*/

SELECT
    ROUND(SUM(payer_coverage),2) AS total_payer_coverage
FROM healthcare.encounters
WHERE start < '2020-01-01';


/*
----------------------------------------------------------
Query 3
Total patient responsibility before January 1, 2020
----------------------------------------------------------
*/

SELECT
    ROUND(SUM(total_claim_cost - payer_coverage),2)
        AS patient_responsibility
FROM healthcare.encounters
WHERE start < '2020-01-01';


/*
----------------------------------------------------------
Query 4
Average claim cost by encounter class
----------------------------------------------------------
*/

SELECT
    encounterclass,
    ROUND(AVG(total_claim_cost),2) AS average_claim_cost
FROM healthcare.encounters
GROUP BY
    encounterclass
ORDER BY
    average_claim_cost DESC;


/*
----------------------------------------------------------
Query 5
Average payer coverage by encounter class
----------------------------------------------------------
*/

SELECT
    encounterclass,
    ROUND(AVG(payer_coverage),2) AS average_payer_coverage
FROM healthcare.encounters
GROUP BY
    encounterclass
ORDER BY
    average_payer_coverage DESC;


/*
----------------------------------------------------------
Query 6
Top organizations by total claim cost
----------------------------------------------------------
*/

SELECT
    org.name AS organization,
    ROUND(SUM(enc.total_claim_cost),2) AS total_claim_cost
FROM healthcare.encounters AS enc
JOIN healthcare.organizations AS org
    ON enc.organization = org.id
GROUP BY
    org.name
ORDER BY
    total_claim_cost DESC
LIMIT 10;


/*
----------------------------------------------------------
Query 7
Top organizations by payer coverage
----------------------------------------------------------
*/

SELECT
    org.name AS organization,
    ROUND(SUM(enc.payer_coverage),2) AS total_payer_coverage
FROM healthcare.encounters AS enc
JOIN healthcare.organizations AS org
    ON enc.organization = org.id
GROUP BY
    org.name
ORDER BY
    total_payer_coverage DESC
LIMIT 10;


/*
----------------------------------------------------------
Query 8
Average encounter throughput by encounter class
----------------------------------------------------------
*/

SELECT
    encounterclass,
    ROUND(AVG(TIMESTAMPDIFF(MINUTE,start,stop)),2)
        AS average_throughput_minutes
FROM healthcare.encounters
GROUP BY
    encounterclass
ORDER BY
    average_throughput_minutes DESC;


/*
----------------------------------------------------------
Query 9
Average claim cost by payer
----------------------------------------------------------
*/

SELECT
    pay.name AS payer,
    ROUND(AVG(enc.total_claim_cost),2)
        AS average_claim_cost
FROM healthcare.encounters AS enc
JOIN healthcare.payers AS pay
    ON enc.payer = pay.id
GROUP BY
    pay.name
ORDER BY
    average_claim_cost DESC;


/*
----------------------------------------------------------
Query 10
Average payer coverage percentage by payer
----------------------------------------------------------
*/

SELECT
    pay.name AS payer,
    ROUND(
        100 * SUM(enc.payer_coverage) /
        SUM(enc.total_claim_cost),
        2
    ) AS coverage_percentage
FROM healthcare.encounters AS enc
JOIN healthcare.payers AS pay
    ON enc.payer = pay.id
GROUP BY
    pay.name
ORDER BY
    coverage_percentage DESC;
