## Assignment

Your task for this assignment is to design a model for a database which can be used to
support the activities of a fitness center business called G Movement.
G Movement operates a number of fitness centres located in towns and cities
across the country. People can join up and become a member of G Movement to
make use of the facilities and classes which are available.

Each fitness centre is identified by a centre id. The data which is to be recorded about a
centre is the centre’s name, address and phone number. Each centre employs a number
of staff to help it carry out its various activities. Each staff member is identified by a staff id.
The staff member’s first (or given) name, last (or family) name, mobile number, the date
they started at the centre and role (the type of job they carry out) are recorded. One of the
appointed staff members of the centre, manages the centre (a center is required to have a
manager assigned before it can operate).

Each centre has a number of facilities such as Gymnasium, Spin Room, Swimming Pool,
Aerobic Exercise Room, etc. Each of these facilities is identified by a facility room number.
These room numbers are not unique across G Movement, room numbers are
reused within each centre, they are however unique within each centre. For a facility we
wish to record the facility name, a description of the facility and its capacity (the number of
participants it can accommodate). Each centre has at least one facility.
As part of its business activities, each centre runs paid formal classes which members can
sign up for. A class, within a centre, is identified by a unique numeric centre assigned class
number (these class numbers are not unique across G Movement - for example
every centre will have a class number, say 10 ). The class description (eg. HIT), the start
date and time, and the maximum number of participants are recorded. The number of
Page 1 of 7

sessions for each class and the class cost are also recorded. Some classes only run one
session, others run several sessions in which each session will be run on the same day
and time each week. Only the start date and time of the first session in each class is
recorded. Each class makes use of a particular facility within the centre. If the class
repeats, it always uses the same facility. Classes are run by qualified staff members of the
centre. A given class may be run by a single staff member or by several staff members.
For each member signed up, G Movement identifies the member with a unique
member number, these member numbers are unique across G Movement. They
also wish to record the member's name, their address, their phone number and the date
which they joined G Movement. G Movement is interested in recording
whether a new member was referred (recommended to join) by a current member. G
Movement members are required to nominate a particular centre as their home centre.
Although they have a home centre, members are entitled to enrol for the classes run at
any of the G Movement centres.

GMovement wishes to record which members sign up for which classes. Members
who have enrolled in a particular class are required to pay for the class before the class
actually begins, the date the member paid is recorded. Payment is a once off payment for
the class, covering all sessions. If a class has more than one session and a member does
not attend some sessions, the cost of the class does not change.

Qualified staff at each centre offer fitness assessments to members - these are optional, a
member may not complete any assessments or they may complete several. The date the
assessment was completed and the staff member who ran the assessment are recorded
(only one assessment per member can be completed on any one day). The fitness
assessment records the members weight, blood pressure, BMI and VO2Max.
