--****PLEASE ENTER YOUR DETAILS BELOW****
--T2-ml-dm.sql


-- 2 (b) (i)

-- insert a new book detail
INSERT INTO book_detail VALUES(
    '005.74 C824C',
    'Database Systems: Design, Implementation, and Management',
    'R',
    793,
    to_date('2019','yyyy'),
    '13'
);
-- add into book copy into the three branches

INSERT INTO book_copy VALUES( 
    (SELECT branch_code FROM branch WHERE branch_contact_no = '0395413120'),
    (SELECT COUNT(bc_id) FROM book_copy WHERE branch_code = (SELECT branch_code FROM branch WHERE branch_contact_no = '0395413120'))+1, -- last row + 1 for the branch
    120,
    'N',
    '005.74 C824C'
);
update branch
set branch_count_books = (select branch_count_books from branch where branch_contact_no = '0395413120') + 1 -- assume only one copy ('bought its FIRST 3 copies')
where branch_contact_no = '0395413120';

INSERT INTO book_copy VALUES( 
    (SELECT branch_code FROM branch WHERE branch_contact_no = '0395601655'),
    (SELECT COUNT(bc_id) FROM book_copy WHERE branch_code = (SELECT branch_code FROM branch WHERE branch_contact_no = '0395601655'))+1, -- last row + 1,
    120,
    'N',
    '005.74 C824C'
);
update branch
set branch_count_books = (select branch_count_books from branch where branch_contact_no = '0395601655') + 1 -- assume only one copy ('bought its FIRST 3 copies')
where branch_contact_no = '0395601655';

INSERT INTO book_copy VALUES( 
    (SELECT branch_code FROM branch WHERE branch_contact_no = '0395461253'),
    (SELECT COUNT(bc_id) FROM book_copy WHERE branch_code =  (SELECT branch_code FROM branch WHERE branch_contact_no = '0395461253'))+1, -- last row + 1
    120,
    'N',
    '005.74 C824C'
);

update branch
set branch_count_books = (select branch_count_books from branch where branch_contact_no = '0395461253') + 1 -- assume only one copy ('bought its FIRST 3 copies')
where branch_contact_no = '0395461253';


commit;  -- complete transaction



-- 2 (b) (ii)

-- sequence for borrower primary key
DROP SEQUENCE bor_no_seq;

CREATE SEQUENCE bor_no_seq
START WITH 100
INCREMENT BY 1;

-- sequence for reserve id primary key
DROP SEQUENCE reserve_id_seq;

CREATE SEQUENCE reserve_id_seq
START WITH 100 
INCREMENT BY 1;



commit;

-- 2 (b) (iii)

-- add borrower
INSERT INTO borrower VALUES( 
    bor_no_seq.nextval,
    'Ada',
    'LOVELACE',
    'JALAN',
    'ABERDARE, NSW',
    '1011',
    (SELECT branch_code FROM branch WHERE branch_contact_no = '0395413120')
);

-- place reservation
INSERT INTO reserve VALUES( 
    reserve_id_seq.nextval,
    (SELECT branch_code FROM branch WHERE branch_contact_no = '0395413120'),
    (SELECT bc_id FROM book_copy WHERE branch_code = (select branch_code from branch where branch_contact_no = '0395413120') and book_call_no = '005.74 C824C'), -- assuming only a single copy of this book
    to_date('September 14, 2021, 03:30 P.M.','Month dd, YYYY, HH:MI P.M.'),
    bor_no_seq.currval

);

UPDATE book_copy -- place a reservation on the copy
SET bc_counter_reserve = 'Y' 
WHERE bc_id = (SELECT bc_id FROM book_copy WHERE branch_code = (select branch_code from branch where branch_contact_no = '0395413120') and book_call_no = '005.74 C824C');  -- assuming only a single copy of this book



commit; -- transaction comlete



-- 2 (b) (iv)

INSERT INTO loan VALUES(  -- assuming only one Ada Lovelace
    (SELECT branch_code FROM borrower WHERE bor_fname = 'Ada' and bor_lname = 'LOVELACE'),
    (SELECT bc_id FROM book_copy WHERE branch_code = (SELECT branch_code FROM borrower WHERE bor_fname = 'Ada' and bor_lname = 'LOVELACE')and book_call_no = '005.74 C824C'),
    to_date('September 21, 2021, 12:30 P.M.','Month dd, YYYY, HH:MI P.M.'),
    to_date('October 5, 2021, 12:30 P.M.','Month dd, YYYY, HH:MI P.M.'),
    null, -- not yet returned
    (SELECT bor_no FROM borrower WHERE bor_fname = 'Ada' and bor_lname = 'LOVELACE')
);

-- delete the reservation
DELETE FROM reserve WHERE 
    bor_no = (SELECT bor_no FROM borrower WHERE bor_fname = 'Ada' and bor_lname = 'LOVELACE') -- Assume one ada lovelace in the system
    and
    bc_id = (SELECT bc_id FROM book_copy where branch_code = (SELECT branch_code FROM borrower WHERE bor_fname = 'Ada' and bor_lname = 'LOVELACE') 
    and 
    book_call_no = '005.74 C824C')
    ;


commit;










