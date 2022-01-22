## Assignment

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
