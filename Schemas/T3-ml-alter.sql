--****PLEASE ENTER YOUR DETAILS BELOW****
--T3-ml-alter.sql

-- 3 (a)

ALTER TABLE book_copy
ADD bc_condition CHAR(1) DEFAULT 'G' NOT NULL;

ALTER TABLE book_copy ADD CONSTRAINT bc_condition_chk CHECK (bc_condition IN ( 'G', 'L', 'D' ));
    
COMMENT ON COLUMN book_copy.bc_condition IS
    'Book copy''s condition. Either G (Good), D (Damaged), or L (Lost)';
    
-- recording a lost book

UPDATE book_copy -- assuming the branch only has a single copy of this book
SET bc_condition = 'L'
WHERE bc_id = (select bc_id from book_copy where branch_code = (select branch_code from branch where branch_contact_no = '0395601655') and book_call_no = '005.74 C824C');

commit;

-- 3 (b)

ALTER TABLE loan
ADD loan_return_branch_code NUMBER(2);

COMMENT ON COLUMN loan.loan_return_branch_code IS
    'the branch code of the branch to which the book was returned to';
    
-- set all booked from to be returned to the same branch
UPDATE loan
SET loan_return_branch_code = branch_code
WHERE (loan_actual_return_date <=  CURRENT_DATE);

commit;

-- 3 (c)

-- add a table
DROP TABLE branch_manager PURGE;
CREATE TABLE branch_manager (
    branch_code             NUMBER(2) NOT NULL,
    man_id                  NUMBER(2) NOT NULL,
    bm_collection           CHAR(1) DEFAULT 'A' NOT NULL
);
 -- primary key and check constraint
ALTER TABLE branch_manager ADD CONSTRAINT branch_manager_pk PRIMARY KEY (branch_code, man_id);
ALTER TABLE branch_manager ADD CONSTRAINT bm_collection_chk CHECK ( bm_collection IN ('A','R','F'));

-- comments
COMMENT ON COLUMN branch_manager.branch_code IS
    'The code of the library branch';
COMMENT ON COLUMN branch_manager.man_id IS
    'A unique manager id';
COMMENT ON COLUMN branch_manager.bm_collection IS
    'Specifies the collection the manager is responsible for managing: A (All), R (Reference), or F (Fiction)';

-- adding foreign keys
ALTER TABLE branch_manager ADD CONSTRAINT branch_manager_man_fk FOREIGN KEY (man_id) references manager (man_id);
ALTER TABLE branch_manager ADD CONSTRAINT branch_manager_branch_fk FOREIGN KEY (branch_code) references branch (branch_code);

--append data to branch_manager table
INSERT INTO branch_manager(
    branch_code,
    man_id
)SELECT branch_code, man_id FROM branch;

-- remove manager from branch table
ALTER TABLE branch DROP COLUMN man_id;

commit;

-- assign managers to the clayton branch (Indiana id:10 and Nathan id:12)

UPDATE branch_manager -- Already managing the clayton branch. So update
SET bm_collection = 'R'
WHERE man_id = 10 and branch_code = (SELECT branch_code from branch WHERE branch_contact_no = '0395413120'); 

INSERT INTO branch_manager VALUES(
    (SELECT branch_code from branch WHERE branch_contact_no = '0395413120'),
    12,
    'F'
);

commit;



