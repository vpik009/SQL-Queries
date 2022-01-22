--****PLEASE ENTER YOUR DETAILS BELOW****
--cgh_queries.sql


/*
    Q1
*/
-- PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE
-- ENSURE that your query is formatted and has a semicolon
-- (;) at the end of this answer

/* doctor title, lname, fname from doctor, And ORTHOP from Doctor speciality */

SELECT
    doctor_title,
    doctor_fname,
    doctor_lname,
    doctor_phone
FROM
         cgh.doctor
    JOIN cgh.doctor_speciality ON cgh.doctor.doctor_id = cgh.doctor_speciality.doctor_id
WHERE
    cgh.doctor_speciality.spec_code = 'ORTHOP'
ORDER BY
    doctor_lname,
    doctor_fname;

COMMIT;

/*
    Q2
*/
-- PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE
-- ENSURE that your query is formatted and has a semicolon (;)
-- at the end of this answer

SELECT
    item_code,
    item_description,
    item_stock,
    cc_title
FROM
         cgh.item
    JOIN cgh.costcentre ON cgh.item.cc_code = cgh.costcentre.cc_code
WHERE
        item_stock > 50
    AND lower(item_description) LIKE ( '%disposable%' )
ORDER BY
    item_code;

COMMIT;

/*
    Q3
*/
-- PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE
-- ENSURE that your query is formatted and has a semicolon (;)
-- at the end of this answer

SELECT
    to_char(patient.patient_id)
    || ' '
    || patient.patient_fname
    || ' '
    || patient.patient_lname     AS "Patient Name",
    admission.adm_date_time,
    doctor.doctor_title
    || ' '
    || doctor.doctor_fname
    || ' '
    || doctor.doctor_lname       AS "Doctor Name"
FROM
    cgh.patient
    LEFT OUTER JOIN cgh.admission ON cgh.patient.patient_id = cgh.admission.patient_id
    LEFT OUTER JOIN cgh.doctor ON cgh.doctor.doctor_id = cgh.admission.doctor_id
WHERE
    adm_date_time BETWEEN TO_DATE('11/SEP/2021  10:00:00 AM', 'DD/MON/YYYY  HH12:MI:SS AM') AND TO_DATE('14/SEP/2021  06:00:00 PM',
    'DD/MON/YYYY  HH12:MI:SS PM')
ORDER BY
    adm_date_time;

COMMIT;
/*
    Q4
*/
-- PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE
-- ENSURE that your query is formatted and has a semicolon (;)
-- at the end of this answer
SELECT
    proc_code,
    proc_name,
    proc_description,
    ltrim(to_char(round(proc_std_cost, 2), '$999999D00')) AS "Standard Cost"
FROM
    cgh.procedure
WHERE
    proc_std_cost < (
        SELECT
            AVG(proc_std_cost)
        FROM
            cgh.procedure
    )
ORDER BY
    proc_std_cost DESC;

COMMIT;
/*
    Q5
*/
-- PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE
-- ENSURE that your query is formatted and has a semicolon (;)
-- at the end of this answer

SELECT
    patient.patient_id,
    patient.patient_lname,
    patient.patient_fname,
    patient.patient_dob,
    COUNT(patient.patient_id) AS "Number of admissions"
FROM
         cgh.patient
    JOIN cgh.admission ON cgh.patient.patient_id = cgh.admission.patient_id
WHERE
    (
        SELECT
            COUNT(admission.patient_id)
        FROM
            cgh.admission
        WHERE
            admission.patient_id = patient.patient_id
        GROUP BY
            admission.patient_id
    ) > 2
GROUP BY
    patient.patient_id,
    patient.patient_lname,
    patient.patient_fname,
    patient.patient_dob
ORDER BY
    "Number of admissions" DESC,
    patient.patient_dob;

COMMIT;
/*
    Q6
*/
-- PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE
-- ENSURE that your query is formatted and has a semicolon (;)
-- at the end of this answer
SELECT
    admission.adm_no,
    patient.patient_id,
    patient.patient_fname,
    patient.patient_lname,
    ltrim(to_char(floor(abs(admission.adm_discharge - admission.adm_date_time)), '999990'))
    || ' days '
    || ltrim(to_char(round(abs(abs(admission.adm_discharge - admission.adm_date_time) - floor(abs(admission.adm_discharge - admission.adm_date_time))) * 24, 1), '999990D0'))
    || ' hrs' AS "Length of stay"
FROM
         cgh.patient
    JOIN cgh.admission ON patient.patient_id = admission.patient_id
WHERE
    admission.adm_discharge IS NOT NULL
    AND ( admission.adm_discharge - admission.adm_date_time ) > (
        SELECT
            AVG(admission.adm_discharge - admission.adm_date_time)
        FROM
            cgh.admission
    )
ORDER BY
    admission.adm_no;

COMMIT;
/*
    Q7
*/
-- PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE
-- ENSURE that your query is formatted and has a semicolon (;)
-- at the end of this answer

SELECT
    procedure.proc_code,
    procedure.proc_name,
    procedure.proc_description,
    procedure.proc_time,
    procedure.proc_std_cost,
    round(AVG(adm_prc.adprc_pat_cost)-procedure.proc_std_cost, 2) AS "Procedure Price Differential"
FROM
         cgh.procedure
    JOIN cgh.adm_prc ON procedure.proc_code = adm_prc.proc_code
GROUP BY
    procedure.proc_code,
    procedure.proc_name,
    procedure.proc_description,
    procedure.proc_time,
    procedure.proc_std_cost
ORDER BY
    procedure.proc_code;

COMMIT;
/*
    Q8
*/
-- PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE
-- ENSURE that your query is formatted and has a semicolon (;)
-- at the end of this answer

SELECT
    procedure.proc_code,
    procedure.proc_name,
    nvl(to_char(item.item_code), '---')                               AS "Item code",
    nvl(to_char(item.item_description), '---')                        AS "Item description",
    nvl(to_char(MAX(item_treatment.it_qty_used)), '---')              AS "Quantity of the item used"
FROM
    cgh.procedure
    LEFT OUTER JOIN cgh.adm_prc ON procedure.proc_code = adm_prc.proc_code -- include those without adm_prc
    LEFT OUTER JOIN cgh.item_treatment ON adm_prc.adprc_no = item_treatment.adprc_no
    LEFT OUTER JOIN cgh.item ON item_treatment.item_code = item.item_code
GROUP BY
    procedure.proc_code,
    procedure.proc_name,
    item.item_code,
    item.item_description
ORDER BY
    procedure.proc_name,
    item.item_code;

COMMIT;
/*
    Q9a (FIT2094 only) or Q9b (FIT3171 only)
*/
-- PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE
-- ENSURE that your query is formatted and has a semicolon (;)
-- at the end of this answer
SELECT
    e1.adprc_no,
    procedure.proc_code,
    e2.adm_no,
    e3.patient_id,
    to_char(e1.adprc_date_time, 'DD/MON/YYYY HH24:MI:SS')        AS "Date and time of the procedure",
    e1.adprc_pat_cost + e1.adprc_items_cost                      AS totalcost
FROM
         cgh.procedure
    JOIN cgh.adm_prc      e1 ON procedure.proc_code = e1.proc_code
    JOIN cgh.admission    e2 ON e1.adm_no = e2.adm_no
    JOIN cgh.patient      e3 ON e2.patient_id = e3.patient_id
WHERE
    9 = ( -- find how many distinct costs are higher than the current, and give when there are 8 (0 exclusive)
        SELECT
            COUNT(DISTINCT(e4.adprc_pat_cost + e4.adprc_items_cost))
        FROM
            cgh.adm_prc e4
        WHERE
            ( e4.adprc_pat_cost + e4.adprc_items_cost ) >= ( e1.adprc_pat_cost + e1.adprc_items_cost )
    )
ORDER BY
    e1.adprc_no;

COMMIT;