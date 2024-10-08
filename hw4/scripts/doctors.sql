create table if not exists stations
(
    stat_nr integer not null
        primary key,
    name    varchar(255)
);

alter table stations
    owner to student;

create table if not exists station_personells
(
    pers_nr                  integer not null
        primary key,
    name                     varchar(255),
    works_for_station_number integer
        references stations
);

alter table station_personells
    owner to student;

create table if not exists rooms
(
    room_nr                   integer not null
        primary key,
    number_of_beds            integer,
    located_in_station_number integer
        references stations
);

alter table rooms
    owner to student;

create table if not exists caregivers
(
    qualification varchar(255),
    personell_nr  integer not null
        primary key
        references station_personells
);

alter table caregivers
    owner to student;

create table if not exists doctors
(
    area         varchar(255),
    rank         varchar(255),
    personell_nr integer not null
        primary key
        references station_personells
);

alter table doctors
    owner to student;

create table if not exists admissions
(
    admission_nr integer not null
        primary key,
    "from"       date,
    "to"         date,
    room_nr      integer
        references rooms
);

alter table admissions
    owner to student;

create table if not exists patients
(
    patient_nr           integer not null,
    name                 varchar(255),
    disease              varchar(255),
    treated_by_doctor_nr integer
        references doctors,
    admission_nr         integer not null
        references admissions,
    primary key (patient_nr, admission_nr)
);

alter table patients
    owner to student;

