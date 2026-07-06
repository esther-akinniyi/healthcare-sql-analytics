/*
==========================================================
Healthcare SQL Analytics Portfolio
File: 04_cost_of_care_and_payers.sql
Author: Esther Akinniyi
Database: Healthcare

Description:
This script analyzes healthcare costs and payer performance
using a simulated healthcare database. The analysis
evaluates total claim costs, payer coverage, and insurance
coverage percentages before January 1, 2020.
==========================================================
*/


/*
----------------------------------------------------------
Query 1
Total claim cost before January 1, 2020
----------------------------------------------------------
*/

SELECT
    CONCAT('$', FORMAT(CEIL(SUM(total_claim_cost)), 0))
        AS total_claim_cost_before_2020
FROM healthcare.encounters
WHERE start < '2020-01-01';


/*
----------------------------------------------------------
Query 2
Total payer coverage before January 1, 2020
----------------------------------------------------------
*/

SELECT
    CONCAT('$', FORMAT(CEIL(SUM(payer_coverage)), 0))
        AS total_payer_coverage_before_2020
FROM healthcare.encounters
WHERE start < '2020-01-01';


/*
----------------------------------------------------------
Query 3
Overall payer coverage percentage before January 1, 2020
----------------------------------------------------------
*/

SELECT
    ROUND(
        100 * SUM(payer_coverage) /
        SUM(total_claim_cost),2
    ) AS overall_payer_coverage_percentage
FROM healthcare.encounters
WHERE start < '2020-01-01';


/*
----------------------------------------------------------
Query 4
Payer coverage percentage by insurance provider
----------------------------------------------------------
*/

SELECT
    pay.name AS payer_name,
    ROUND(
        100 * SUM(enc.payer_coverage) /
        SUM(enc.total_claim_cost),2
    ) AS payer_coverage_percentage
FROM healthcare.encounters AS enc
JOIN healthcare.payers AS pay
    ON enc.payer = pay.id
WHERE enc.start < '2020-01-01'
GROUP BY
    pay.name
ORDER BY
    payer_coverage_percentage DESC;


/*
----------------------------------------------------------
Query 5
Payer coverage percentage for ambulatory encounters
----------------------------------------------------------
*/

SELECT
    pay.name AS payer_name,
    ROUND(
        100 * SUM(enc.payer_coverage) /
        SUM(enc.total_claim_cost),2
    ) AS ambulatory_coverage_percentage
FROM healthcare.encounters AS enc
JOIN healthcare.payers AS pay
    ON enc.payer = pay.id
WHERE enc.start < '2020-01-01'
  AND enc.encounterclass = 'Ambulatory'
GROUP BY
    pay.name
ORDER BY
    ambulatory_coverage_percentage DESC;


/*
----------------------------------------------------------
Query 6
Top 10 payers by total claim cost
----------------------------------------------------------
*/

SELECT
    pay.name AS payer_name,
    CONCAT('$', FORMAT(SUM(enc.total_claim_cost),0))
        AS total_claim_cost
FROM healthcare.encounters AS enc
JOIN healthcare.payers AS pay
    ON enc.payer = pay.id
WHERE enc.start < '2020-01-01'
GROUP BY
    pay.name
ORDER BY
    SUM(enc.total_claim_cost) DESC
LIMIT 10;


/*
----------------------------------------------------------
Query 7
Top 10 payers by total payer coverage
----------------------------------------------------------
*/

SELECT
    pay.name AS payer_name,
    CONCAT('$', FORMAT(SUM(enc.payer_coverage),0))
        AS total_payer_coverage
FROM healthcare.encounters AS enc
JOIN healthcare.payers AS pay
    ON enc.payer = pay.id
WHERE enc.start < '2020-01-01'
GROUP BY
    pay.name
ORDER BY
    SUM(enc.payer_coverage) DESC
LIMIT 10;
