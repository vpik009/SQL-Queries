## Assignment

### Part 1
#### 

The local G Municipality maintains several libraries for its residents across the municipality.
For each branch, MLib assigns a branch code (an incremental number for each branch with the
first branch using a code of 10). The branch name, address and contact phone number are also
recorded. MLib also records the number of books registered at each branch. Each branch has a
unique phone number and is assigned one manager. Due to the small size of some of the
branches, a particular manager may manage several branches. Each manager is assigned a
manager id. MLib Services record a manager's name and contact phone number.
MLib maintains records of current loans of books to borrowers.

Each borrower is identified by a unique borrower number. When a borrower first registers to borrow
books, the branch where they register is recorded as their home branch. The name and address of
each borrower is held so that communications, such as overdue loan reminders, can be sent when
necessary.

The information held about a book includes its Dewey Decimal call no - this call no is used to
identify a particular book's details. The title, classification (Reference or Fiction), number of pages,
publication year and edition, if applicable, are recorded.

Branches hold copies of a book - each copy is the property of a particular branch and is identified
by the branch number and a branch assigned local id number (these id numbers are repeated at
each branch). Some book copies are placed on counter reserve, and are not available for loan -
they may only be used in the library. A flag is added to a book copy to indicate if it is on counter
reserve or not. There may also be other copies of the same title which are available for normal
loan.

When a book copy is borrowed (goes out on loan), the return due date is recorded. A record of all
loans which take place is maintained. When a book is returned from a loan its actual return date is
recorded. Each book copy can be loaned for 14 days and then must be renewed to avoid a fine.
For example, a book borrowed on the 2nd August 2021 at 10:00 AM will be due on the 16th August
2021.

Borrowers may reserve books currently out on loan. A reservation is assigned a reservation id
(these id numbers are unique across all branches). The date and time on which the reservation
was placed are recorded. A given book may be reserved by several borrowers, the book is made
available based on the order in which the reserve was placed by the borrower.
When a borrower returns a book, they may, if they wish, renew their loan and take the book out for
a further loan period provided the book has not been reserved by another borrower, the renewal is
simply treated as a new loan for that borrower. Books must be returned to the branch from which
they were borrowed (the branch owning the book copy).
A model to represent this system has been developed:

![alt text](https://github.com/vpik009/SQL-Queries/blob/main/Schemas/model.PNG)



### Part 2

County General Hospital treats patients who are identified by a unique patient id. When a patient is
admitted to the hospital, the hospital records the patient's first and last name, address, date of birth
and emergency contact number (if they are not already on the system). They also record the date
and time of admission. The system needs to maintain a record of all admissions for a particular
patient. When a patient is discharged, the date and time of their discharge for this admission is
recorded.

While in the hospital each patient is assigned one doctor (identified by a doctor id) as their
supervising doctor. A patient's supervising doctor may be in charge of many admissions. The
hospital records each doctor's title, first and last names and phone number. A doctor may have one
or more specialisations (eg. Orthopaedic, Renal, etc), but not all doctors who work at the hospital
have a specialisation.

During their admission, patients are prescribed procedures as part of their care by doctors.
Procedures consist of tests such as "X-Rays", "Blood Tests" etc, they also include medical
procedures which might be required such as "Shoulder Replacement". A patient may have
procedures prescribed by their supervising doctor or any other doctor working in the hospital.
A procedure is identified by a procedure code. Each procedure has a name (such as "Wrist X-Ray")
and includes a description of what the procedure involves, the time required for the procedure and
the current standard patient cost for this procedure. When a particular procedure is prescribed
during a patient’s admission, the date and time when the procedure is carried out is also recorded. A
particular procedure is completed before any further procedures are run (two procedures cannot
occur simultaneously). Some procedures, such as blood tests are carried out by technicians, more
complex procedures may require a doctor to perform the procedure.

If a procedure is carried out by a technician the hospital does not record the details of the technician
who completed the procedure.

If a doctor carries out the procedure, the doctor who completes the procedure is recorded (the
doctor who completes the procedure may be different from the doctor who prescribes it). Even if a
team of doctors is involved in the procedure, only one doctor (the doctor in charge) is recorded as
completing the procedure.

County General Hospital only records the details of a procedure carried out on an admission after
the procedure has been completed.

Not all admissions require a procedure to be carried out.

Procedures may require "extra" items such as syringes or swabs. Each item held in stock is
assigned an item code. The item description, current stock and price are recorded. For accounting
purposes, each item is assigned to a unique cost centre, such as Pharmacy, Radiography or Patient
Aids. A cost centre is identified by a cost centre code and has recorded the cost centre title and
manager's name. The quantity of each item used in a particular procedure is recorded.
Patients are billed for the cost for the procedure itself and also any "extra" items which are used as
part of a procedure. The billed charge is based on the procedure/item cost at the date and time of
the procedure.

Current existing model:
![alt text](https://github.com/vpik009/SQL-Queries/blob/main/Schemas/model2.PNG)

### Queries to complete:

1. List the doctor title, first name, last name and contact phone number for all doctors who specialise
in the area of "ORTHOPEDIC SURGERY" (this is the specialisation description). Order the list by
the doctors' last name and within this, if two doctors have the same last name, order them by their
respective first names.

2. List the item code, item description, item stock and the cost centre title which provides these items
for all items which have a stock greater than 50 items and include the word 'disposable' in their item
description. Order the output by the item code.

3. List the patient id, patient's full name as a single column called 'Patient Name', admission date
and time and the supervising doctor's full name (including title) as a single column called 'Doctor
Name' for all those patients admitted between 10 AM on 11th of September and 6 PM on the 14th of
September 2021 (inclusive). Order the output by the admission time with the earliest admission first.

4. List the procedure code, name, description, and standard cost where the procedure is less
expensive than the average procedure standard cost. The output must show the most expensive
procedure first. The procedure standard cost must be displayed with two decimal points and a
leading $ symbol, for example as $120.54

5. List the patient id, last name, first name, date of birth and the number of times the patient has
been admitted to the hospital where the number of admissions is greater than 2. The output should
show patients with the most number of admissions first and for patients with the same number of
admissions, show the patients in their date of birth order.

6. List the admission number, patient id, first name, last name and the length of their stay in the
hospital for all patients who have been discharged and who were in the hospital longer than the
average stay for all discharged patients. The length of stay must be shown in the form 10 days 2.0
hrs where hours are rounded to one decimal digit. The output must be ordered by admission
number.

7. Given a doctor may charge more or less than the standard charge for a procedure carried out
during an admission procedure, the hospital administration is interested in finding out what variations
on the standard price have been charged. The hospital terms the difference between the average
actual charged procedure cost which has been charged to patients for all such procedures which
have been carried out the procedure standard cost as the "Procedure Price Differential". For all
procedures which have been carried out on an admission determine the procedure price differential.
The list should show the procedure code, name, description, standard time, standard cost and the
procedure price differential in procedure code order.
For example procedure 15509 "X-ray, Right knee" has a standard cost of $70.00, it may have been
charged to admissions on average across all procedures carried out for $75.00 - the price differential
here will be 75 - 70 that is a price differential +5.00 If the average charge had been say 63.10 the
price differential will be -6.90.

8. For every procedure, list the items which have been used and the maximum number of those
items used when the procedure was carried out on an admission. Your list must show the procedure
code, procedure name, item code and item description and the maximum quantity of this item used
for the given procedure.
For example, Vascular Surgery may require one standard anaesthetic pack, and then a number of
Bupivacaine injections; sometimes one has been used sometimes two - the required listing will
show:

|     43556         |     Vascular surgery      |     AN002        |       Std Anaesthetic Pack                  |    1    |
|:------------------|:-------------------------:|:----------------:|:-------------------------------------------:|--------:|
|     43556         |     Vascular surgery      |     BI500        |       Bupivacaine Inj .5% 10ml Steriamp     |    2    |


If the procedure has not been carried out on any admission or has not used any items then the item
code, item description and maximum quantity columns must show "---". The output must be in
procedure name order and within a procedure in item code order.


Find the ninth most expensive procedure/s for a procedure carried out on an admission.
As an example, say we have the following "dummy" data (note these are just representative
numbers, they do not reflect the data you have access to):
The fifth most expensive procedure/s here are those identified by adprc_nos 1240 and 1201 in this
"dummy" data.

Your report must show the admission procedure number, the procedure code, the admission
number, the patient id who this procedure was carried out on, the date and time (time in 24 hour
format) that the procedure was carried out and the total cost for the procedure. The total cost will be
the cost charged to this patient for this procedure plus the cost for extra items required. The output
should be in admission procedure number order

