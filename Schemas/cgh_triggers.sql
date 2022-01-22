--****PLEASE ENTER YOUR DETAILS BELOW****
--cgh_triggers.sql

*/

/*
    Trigger1
*/
/*Please copy your trigger code with a slash(/) followed by an empty line after this line*/

CREATE OR REPLACE TRIGGER cost_charged_cas BEFORE
    INSERT OR UPDATE OF adprc_pat_cost ON adm_prc
    FOR EACH ROW
DECLARE
    std_cost NUMBER := 0;
BEGIN
    SELECT
        proc_std_cost
    INTO std_cost
    FROM
        procedure
    WHERE
        procedure.proc_code = :new.proc_code;

    IF :new.adprc_pat_cost > std_cost * 1.2 OR :new.adprc_pat_cost < std_cost * 0.8 THEN
        raise_application_error(-20000, 'The cost of charging the patient exceeds the 20% limit');
    END IF;

END;
/

COMMIT; -- commit the trigger



/*Test Harness for Trigger1*/
/*Please copy SQL statements for Test Harness after this line*/
INSERT INTO adm_prc (
    adprc_no,
    adprc_date_time,
    adprc_pat_cost,
    adprc_items_cost,
    adm_no,
    proc_code
) VALUES (
    1234,
    TO_DATE('15/OCT/2021  05:00:00 PM', 'DD/MON/YYYY  HH12:MI:SS AM'),
    92,
    0,
    100280,
    32266
); -- out of range

INSERT INTO adm_prc (
    adprc_no,
    adprc_date_time,
    adprc_pat_cost,
    adprc_items_cost,
    adm_no,
    proc_code
) VALUES (
    1234,
    TO_DATE('15/OCT/2021  05:00:00 PM', 'DD/MON/YYYY  HH12:MI:SS AM'),
    60,
    0,
    100280,
    32266
); -- out of range



/*
    Trigger2
*/
/*Please copy your trigger code with a slash(/) followed by an empty line after this line*/

CREATE OR REPLACE TRIGGER discharge_cas BEFORE
    INSERT OR UPDATE OF adm_discharge ON admission
    FOR EACH ROW
DECLARE
    last_admission_proc_start  DATE;
    admission_totalcost        NUMBER := 0;
BEGIN
    -- get last admission procedure start date time

    SELECT -- select the last procedure's date and time of the person who is being discharged.
        MAX(adprc_date_time)
    INTO last_admission_proc_start
    FROM
        adm_prc
    WHERE
        adm_no = :new.adm_no;
    
    
    -- validate discharge date
    IF :new.adm_discharge < :new.adm_date_time OR :new.adm_discharge < last_admission_proc_start THEN
        raise_application_error(-20000,
                               'Date and time of discharge cannot be before the admission date and time and/or before the patient''s last scheduled procedure');
    END IF;
    
    -- get admission's total cost
    SELECT
        nvl(SUM(adprc_pat_cost + adprc_items_cost), 0)
    INTO admission_totalcost
    FROM
        adm_prc
    WHERE
        adm_prc.adm_no = :new.adm_no;

    admission_totalcost := admission_totalcost + 50;
    :new.adm_total_cost := admission_totalcost; -- set the 

END;
/

/*Test Harness for Trigger2*/
/*Please copy SQL statements for Test Harness after this line*/

-- incorrect since discharge date is before admission date
UPDATE admission
SET
    adm_discharge = TO_DATE('02/JUN/2021  08:00:00 AM', 'DD/MON/YYYY  HH12:MI:SS AM')
WHERE
    adm_no = 100010;
    
-- incorrect since discharge date = last admissions procedure date time 
UPDATE admission
SET
    adm_discharge = TO_DATE('04/JUL/2021  07:00:00 AM', 'DD/MON/YYYY  HH12:MI:SS AM')
WHERE
    adm_no = 100010;
    

-- Updating cost for patient with no procedure
SELECT
    *
FROM
    admission;  -- total cost should be null

--Updating the admission : discharging a patient
UPDATE admission
SET
    adm_discharge = TO_DATE('15/OCT/2021  11:00:00 AM', 'DD/MON/YYYY  HH12:MI:SS AM')
WHERE
    adm_no = 100280;

--Post state
SELECT
    *
FROM
    admission;  -- total cost should be 50

ROLLBACK; -- rollback the changes made

-- check the total cost of a patient who has had procedures
INSERT INTO adm_prc (
    adprc_no,
    adprc_date_time,
    adprc_pat_cost,
    adprc_items_cost,
    adm_no,
    proc_code
) VALUES (
    1030,
    TO_DATE('05/JUL/2021  08:00:00 AM', 'DD/MON/YYYY  HH12:MI:SS AM'),
    250,
    547.81,
    100280,
    43556
);

-- Updating cost for patient with procedure
SELECT
    *
FROM
    admission; 

--Updating the admission: discharging a patient
UPDATE admission
SET
    adm_discharge = TO_DATE('15/OCT/2021  11:00:00 AM', 'DD/MON/YYYY  HH12:MI:SS AM')
WHERE
    adm_no = 100280;

--Post state
SELECT
    *
FROM
    admission;  -- total cost should be 847.81

ROLLBACK;