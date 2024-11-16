CREATE TABLE IF NOT EXISTS demographics (
    id integer primary key,
    name varchar(255),
    birthday date,
    race varchar(255)
);

INSERT INTO demographics VALUES
(1, 'Nikita', '2004-01-01', 'raceNikita'),
(2, 'Stas', '2004-01-01', 'raceStas'),
(3, 'Gena', '2004-01-01', 'raceGena'),
(4, 'Vlad', '2004-01-01', 'raceVlad'),
(5, 'Sasha', '2004-01-01', 'raceSasha');

CREATE TABLE IF NOT EXISTS names (
    id integer primary key,
    prefix varchar(255),
    first varchar(255),
    last varchar(255),
    suffix varchar(255)
);

INSERT INTO names VALUES
(1, 'Sir', 'John', 'Down', 'Jr'),
(2, 'Mr', 'Alex', 'Up', ''),
(3, 'Mrs', 'Kate', 'Left', ''),
(4, '', 'Sam', 'Right', 'the Great'),
(5, 'Cotton-Eyed', 'Joe', 'Best', 'the Second');

CREATE TABLE IF NOT EXISTS encription (
    md5 varchar(32),
    sha1 varchar(40),
    sha256 varchar(64)
);

INSERT INTO encription VALUES
('d41d8cd98f00b204e9800998ecf8427e', 'da39a3ee5e6b4b0d3255bfef95601890afd80709', 'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855'),
('098f6bcd4621d373cade4e832627b4f6', 'a94a8fe5ccb19ba61c4c0873d391e987982fbbd3', '9e107d9d372bb6826bd81d3542a419d6b44567f8ef3fbbbd7a12c2c14c0a18a6'),
('5d41402abc4b2a76b9719d911017c592', '40bd001563085fc35165329ea1ff5c5ecbdbbeef', 'a12f6b8459b64f319921a516d3b0e11dc5e03b128f264d1eb8c1d55a01412cfa'),
('202cb962ac59075b964b07152d234b70', 'd3486ae9136e7856bc42212385ea797094475802', '90a5a75d1d2e8c6a11fa5e74d177be19e6bfc2f134b81a27ec11f613cb5f29a0'),
('81dc9bdb52d04dc20036dbd8313ed055', '7c222fb2927d828af22f592134e8932480637c0d', '3a6eb083cc6c05e4dcb417e5ee2c3f752924d37d5baf465d9edc7a4b1f835b9b');

CREATE TABLE repositories (
    project varchar(255) primary key,
    commits integer,
    contributors integer,
    address varchar(255)
);

INSERT INTO repositories VALUES
('Project Alpha', 150, 10, 'https://github.com/user/project-alpha'),
('Project Beta', 300, 25, 'https://github.com/user/project-beta'),
('Project Gamma', 75, 5, 'https://gitlab.com/user/project-gamma'),
('Project Delta', 120, 8, 'https://bitbucket.org/user/project-delta'),
('Project Omega', 500, 50, 'https://github.com/org/project-omega'),
('Project Amogus', 3, 5, 'papkanagibator228.com/project-amogus-v.1.3.37');

CREATE TABLE products (
    id integer primary key,
    name varchar(255),
    price float,
    stock integer,
    weight float,
    producer varchar(255),
    country varchar(255)
);

INSERT INTO products VALUES
(1, 'Apple', 3.50, 100, 500, 'Fresh Farms', 'USA'),
(2, 'Orange Juice', 4.00, 50, 1000, 'Citrus Co', 'Brazil'),
(3, 'Packaged Rice', 2.00, 200, 250, 'Rice World', 'India'),
(4, 'Chocolate Bar', 1.20, 300, 100, 'Sweet Treats', 'Belgium'),
(5, 'Olive Oil', 10.00, 40, 750, 'Healthy Eats', 'Spain');
