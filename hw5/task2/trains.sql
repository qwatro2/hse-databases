create table if not exists cities
(
    name   varchar(255) not null
        primary key,
    region varchar(255)
);

alter table cities
    owner to student;

create table if not exists stations
(
    name              varchar(255) not null
        primary key,
    number_of_tracks  integer,
    lies_in_city_name varchar(255)
        references cities
);

alter table stations
    owner to student;

create table if not exists trains
(
    train_nr            integer not null
        primary key,
    length              integer,
    starts_station_name varchar(255)
        references stations,
    ends_station_name   varchar(255)
        references stations
);

alter table trains
    owner to student;

create table if not exists connections
(
    departure              timestamp,
    arrival                timestamp,
    departure_station_name varchar(255)
        references stations,
    arrival_station_name   varchar(255)
        references stations,
    train_nr               integer
        references trains
);

alter table connections
    owner to student;

