--****PLEASE ENTER YOUR DETAILS BELOW****
--T2-ml-insert.sql


-- 2 (a) Load the BOOK_COPY, LOAN and RESERVE tables with your own


-- book_copy


INSERT INTO book_copy VALUES(
    10,
    1,
    99.99,
    'N',
    (SELECT book_call_no FROM book_detail WHERE book_call_no = '005.74 D691D')
);

INSERT INTO book_copy VALUES(  -- multiple copy of the same book
    10,
    2,
    99.99,
    'N',
    (SELECT book_call_no FROM book_detail WHERE book_call_no = '005.74 D691D')
);


INSERT INTO book_copy VALUES(  -- multiple copy of the same book
    11,
    1,
    9.99,
    'Y', -- counter reserve
    (SELECT book_call_no FROM book_detail WHERE book_call_no = '112.6 S874D')
);


INSERT INTO book_copy VALUES(  -- multiple copy of the same book
    12,
    1,
    4.99,
    'N',
    (SELECT book_call_no FROM book_detail WHERE book_call_no = '823.914 H219A')
);


INSERT INTO book_copy VALUES( 
    12,
    2,
    7.99,
    'N',
    (SELECT book_call_no FROM book_detail WHERE book_call_no = '823.914 A211H')
);


INSERT INTO book_copy VALUES( 
    12,
    3,
    7.99,
    'N',
    (SELECT book_call_no FROM book_detail WHERE book_call_no = '823.914 A211H')
);


INSERT INTO book_copy VALUES(  
    12,
    4,
    7.99,
    'N',
    (SELECT book_call_no FROM book_detail WHERE book_call_no = '823.914 A211H')
);


INSERT INTO book_copy VALUES( 
    12,
    5,
    7.99,
    'N',
    (SELECT book_call_no FROM book_detail WHERE book_call_no = '823.914 A211H')
);
INSERT INTO book_copy VALUES(  
    12,
    6,
    7.99,
    'N',
    (SELECT book_call_no FROM book_detail WHERE book_call_no = '823.914 A211H')
);


INSERT INTO book_copy VALUES( 
    12,
    7,
    7.99,
    'N',
    (SELECT book_call_no FROM book_detail WHERE book_call_no = '823.914 A211H')
);
update branch
set branch_count_books = 2 
where branch_code = 10;

update branch
set branch_count_books = 1 
where branch_code = 11;

update branch
set branch_count_books = 7 
where branch_code = 12;


-- inserting 10 LOANS
INSERT INTO loan VALUES(  
    12,
    4,
    to_date('July 7, 2021, 11:00 A.M.','Month dd, YYYY, HH:MI A.M.'),
    to_date('July 21, 2021, 11:00 A.M.','Month dd, YYYY, HH:MI A.M.'),
    to_date('July 15, 2021, 10:00 P.M.','Month dd, YYYY, HH:MI P.M.'), 
    1 
);
INSERT INTO loan VALUES(  
    12,
    5,
    to_date('June 7, 2021, 11:00 A.M.','Month dd, YYYY, HH:MI A.M.'),
    to_date('June 21, 2021, 11:00 A.M.','Month dd, YYYY, HH:MI A.M.'),
    to_date('August 22, 2020, 03:00 P.M.','Month dd, YYYY, HH:MI P.M.'), --late
    1
);
INSERT INTO loan VALUES(  
    10,
    2,
    to_date('August 3, 2021, 11:00 A.M.','Month dd, YYYY, HH:MI A.M.'),
    to_date('August 17, 2021, 11:00 A.M.','Month dd, YYYY, HH:MI A.M.'),
    null, -- still due and late (incomplete)
    2
);
INSERT INTO loan VALUES(  
    12,
    4,
    to_date('July 5, 2021, 11:00 A.M.','Month dd, YYYY, HH:MI A.M.'),
    to_date('July 19, 2021, 11:00 A.M.','Month dd, YYYY, HH:MI A.M.'),
    to_date('July 17, 2021, 12:00 P.M.','Month dd, YYYY, HH:MI P.M.'),
    3
);

INSERT INTO loan VALUES(  
    12,
    2,
    to_date('August 2, 2020, 11:00 A.M.','Month dd, YYYY, HH:MI A.M.'),
    to_date('August 16, 2020, 11:00 A.M.','Month dd, YYYY, HH:MI A.M.'),
    to_date('August 5, 2020, 10:00 A.M.','Month dd, YYYY, HH:MI A.M.'),
    3
);

INSERT INTO loan VALUES(  
    12,
    4,
    to_date('June 8, 2021, 11:00 A.M.','Month dd, YYYY, HH:MI A.M.'),
    to_date('June 22, 2021, 11:00 A.M.','Month dd, YYYY, HH:MI A.M.'),
    to_date('June 19, 2021, 12:00 P.M.','Month dd, YYYY, HH:MI P.M.'),
    2
);

INSERT INTO loan VALUES(  
    10,
    1,
    to_date('July 5, 2021, 11:00 A.M.','Month dd, YYYY, HH:MI A.M.'),
    to_date('July 19, 2021, 11:00 A.M.','Month dd, YYYY, HH:MI A.M.'),
    to_date('July 17, 2021, 12:00 P.M.','Month dd, YYYY, HH:MI P.M.'),
    2
);

INSERT INTO loan VALUES(  
    10,
    2,
    to_date('August 20, 2021, 11:00 A.M.','Month dd, YYYY, HH:MI A.M.'),
    to_date('September 4, 2021, 11:00 A.M.','Month dd, YYYY, HH:MI A.M.'),
    to_date('September 2, 2021, 12:00 P.M.','Month dd, YYYY, HH:MI P.M.'),
    3 
);

INSERT INTO loan VALUES(  
    12,
    3,
    to_date('August 12, 2021, 11:00 A.M.','Month dd, YYYY, HH:MI A.M.'),
    to_date('August 26, 2021, 11:00 A.M.','Month dd, YYYY, HH:MI A.M.'),
    to_date('August 19, 2021, 12:00 P.M.','Month dd, YYYY, HH:MI P.M.'),
    3 
);

INSERT INTO loan VALUES(  
    12,
    7,
    to_date('August 29, 2021, 11:00 A.M.','Month dd, YYYY, HH:MI A.M.'),
    to_date('September 13, 2021, 11:00 A.M.','Month dd, YYYY, HH:MI A.M.'),
    null, -- still due
    3 
);


-- reserve

INSERT INTO reserve VALUES(  
    1,
    12,
    7,
    to_date('August 7, 2021, 03:00 P.M.','Month dd, YYYY, HH:MI P.M.'),
    1
);

INSERT INTO reserve VALUES(  
    2,
    10,
    2,
    to_date('August 10, 2021, 03:00 P.M.','Month dd, YYYY, HH:MI P.M.'),
    2
);



commit; -- finish transaction






