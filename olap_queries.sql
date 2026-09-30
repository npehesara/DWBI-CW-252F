-- Task 5.1 - Slice
-- Select one clinic: Colombo

SELECT
    c.clinic_name,
    SUM(f.wait_minutes) AS total_wait_minutes,
    SUM(f.consultation_minutes) AS total_consultation_minutes,
    SUM(f.fee) AS total_fee_income
FROM fact_appointment f
JOIN dim_clinic c
    ON f.clinic_key = c.clinic_key
WHERE c.city = 'Colombo'
GROUP BY c.clinic_name;


-- Task 5.2 - Dice
-- Select two clinics and two quarters

SELECT
    c.city,
    d.quarter,
    SUM(f.wait_minutes) AS total_wait_minutes,
    SUM(f.consultation_minutes) AS total_consultation_minutes,
    SUM(f.fee) AS total_fee_income
FROM fact_appointment f
JOIN dim_clinic c
    ON f.clinic_key = c.clinic_key
JOIN dim_date d
    ON f.date_key = d.date_key
WHERE c.city IN ('Colombo', 'Kandy')
  AND d.quarter IN ('Q1', 'Q2')
GROUP BY
    c.city,
    d.quarter
ORDER BY
    c.city,
    d.quarter;


-- Task 5.3 - Roll-up
-- Doctor -> Specialty -> Grand Total

SELECT
    d.specialty,
    d.doctor_name,
    SUM(f.consultation_minutes) AS total_consultation_minutes,
    SUM(f.fee) AS total_fee_income
FROM fact_appointment f
JOIN dim_doctor d
    ON f.doctor_key = d.doctor_key
GROUP BY ROLLUP (d.specialty, d.doctor_name)
ORDER BY
    d.specialty,
    d.doctor_name;


-- Task 5.4 - Drill-down
-- Quarter -> Month for Q1 2025

SELECT
    d.quarter,
    d.month,
    d.month_name,
    SUM(f.wait_minutes) AS total_wait_minutes,
    SUM(f.consultation_minutes) AS total_consultation_minutes,
    SUM(f.fee) AS total_fee_income
FROM fact_appointment f
JOIN dim_date d
    ON f.date_key = d.date_key
WHERE d.year = 2025
  AND d.quarter = 'Q1'
GROUP BY
    d.quarter,
    d.month,
    d.month_name
ORDER BY
    d.month;


-- Task 5.5 - Pivot
-- Quarter values become columns

SELECT
    c.clinic_name,
    SUM(CASE WHEN d.quarter = 'Q1' THEN f.fee ELSE 0 END) AS q1_fee,
    SUM(CASE WHEN d.quarter = 'Q2' THEN f.fee ELSE 0 END) AS q2_fee,
    SUM(CASE WHEN d.quarter = 'Q3' THEN f.fee ELSE 0 END) AS q3_fee,
    SUM(CASE WHEN d.quarter = 'Q4' THEN f.fee ELSE 0 END) AS q4_fee
FROM fact_appointment f
JOIN dim_clinic c
    ON f.clinic_key = c.clinic_key
JOIN dim_date d
    ON f.date_key = d.date_key
GROUP BY c.clinic_name
ORDER BY c.clinic_name;