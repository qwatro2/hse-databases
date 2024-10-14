create table Student
(
    MatrNr      integer not null primary key,
    Name        varchar(255),
    Semester    integer
);

create table Professor
(
    ProfNr      integer not null primary key,
    Name        varchar(255),
    Room    integer
);

create table Lecture
(
    LectNr      integer not null primary key,
    Title       varchar(255),
    Credit      integer,
    ProfNr    integer
        references Professor
);

create table "check"
(
    MatrNr      integer
        references Student,
    LectNr      integer
        references Lecture,
    ProfNr      integer
        references Professor,
    Note        double precision
);
