--****PLEASE ENTER YOUR DETAILS BELOW****
--T1-ml-drop.sql


-- 1.2 Add Drop table statements for ALL table below (not just those created
-- in this script)use ONLY
--      DROP TABLE tblname PURGE
-- syntax DO NOT use CASCADE CONSTRAINTS

DROP TABLE reserve PURGE;
DROP TABLE loan PURGE;
DROP TABLE book_copy PURGE;
DROP TABLE book_detail PURGE;
DROP TABLE borrower PURGE;
DROP TABLE branch PURGE;
DROP TABLE manager PURGE;

COMMIT;


