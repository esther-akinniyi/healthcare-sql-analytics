# Data Dictionary

The project uses a simulated healthcare database consisting of multiple relational tables.

---

## Patients

Stores demographic information for each patient.

Examples:

- Patient ID
- Gender
- Race
- Ethnicity
- Birthdate
- County

---

## Encounters

Stores information about patient visits.

Examples:

- Encounter ID
- Patient ID
- Encounter Class
- Start Date
- Stop Date
- Organization
- Total Claim Cost
- Payer Coverage

---

## Procedures

Contains clinical procedures performed during encounters.

Examples:

- Procedure Description
- Procedure Date
- Patient
- Encounter

---

## Conditions

Contains documented diagnoses and clinical conditions associated with encounters.

---

## Observations

Stores clinical observations such as:

- Blood Pressure
- Height
- Weight
- Laboratory Values

---

## Medications

Contains medication prescribing information.

Examples:

- Medication Name
- Start Date
- Patient

---

## Payers

Contains insurance payer information.

Examples:

- Payer ID
- Insurance Name

---

## Organizations

Contains healthcare organization information.

Examples:

- Organization ID
- Organization Name
