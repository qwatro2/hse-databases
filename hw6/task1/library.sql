create table if not exists readers
(
    id       integer not null
        primary key,
    surname  varchar(255),
    name     varchar(255),
    address  varchar(255),
    birthday date
);

alter table readers
    owner to student;

create table if not exists categories
(
    name            varchar(255)
        unique,
    parent_category varchar(255)
        references categories (name)
);

alter table categories
    owner to student;

create table if not exists publishing_houses
(
    name    varchar(255) not null
        primary key,
    address varchar(255)
);

alter table publishing_houses
    owner to student;

create table if not exists books
(
    isbn             integer not null
        primary key,
    year             integer,
    name             varchar(255),
    author           varchar(255),
    number_of_pages  integer,
    publishing_house varchar(255)
        references publishing_houses
);

alter table books
    owner to student;

create table if not exists copies
(
    id        integer not null
        primary key,
    book_isbn integer
        references books,
    position  integer
);

alter table copies
    owner to student;

create table if not exists book_takings
(
    reader_id   integer
        references readers,
    isbn        integer
        references books,
    copy_id     integer
        references copies,
    return_date date
);

alter table book_takings
    owner to student;

create table if not exists books_to_categories
(
    book_isbn     integer      not null
        references books,
    category_name varchar(255) not null
        references categories (name),
    primary key (book_isbn, category_name)
);

alter table books_to_categories
    owner to student;

