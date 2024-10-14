INSERT INTO cities (name, region) VALUES
('Москва', 'Центральный'),
('Санкт-Петербург', 'Северо-Западный'),
('Тверь', 'Центральный'),
('Ярославль', 'Центральный'),
('Вологда', 'Северо-Западный'),
('Архангельск', 'Северо-Западный');

INSERT INTO stations (name, number_of_tracks, lies_in_city_name) VALUES
('Москва-Пасс.', 12, 'Москва'),
('Москва-2', 10, 'Москва'),
('Санкт-Петербург-Главный', 10, 'Санкт-Петербург'),
('Санкт-Петербург-2', 4, 'Санкт-Петербург'),
('Тверь-Пасс.', 6, 'Тверь'),
('Тверь-2', 4, 'Тверь'),
('Ярославль-Главный', 8, 'Ярославль'),
('Архангельск-Пасс.', 5, 'Архангельск');

INSERT INTO trains (train_nr, length, starts_station_name, ends_station_name) VALUES
(101, 1000, 'Москва-Пасс.', 'Санкт-Петербург-Главный'), -- москва -> санкт-петербург
(102, 800, 'Москва-Пасс.', 'Санкт-Петербург-2'), -- москва -> тверь-2 -> санкт-петербург
(103, 600, 'Ярославль-Главный', 'Архангельск-Пасс.'), -- ярославль -> москва -> санкт-петербург -> архангельск
(104, 590, 'Москва-Пасс.', 'Тверь-Пасс.'), -- москва -> тверь
(105, 1024, 'Москва-2', 'Тверь-2'), -- москва -> тверь
(106, 2001, 'Ярославль-Главный', 'Санкт-Петербург-Главный'), -- ярославль -> москва -> санкт-петербург
(107, 332, 'Ярославль-Главный', 'Санкт-Петербург-2'), -- ярославль -> москва -> тверь -> санкт-петербург
(108, 800, 'Москва-Пасс.', 'Санкт-Петербург-2'); -- москва -> тверь-2 -> санкт-петербург (но приезд на след день)


INSERT INTO connections (departure_station_name, arrival_station_name, train_nr, departure, arrival) VALUES
-- 101 поезд (прямой мск-спб)
('Москва-Пасс.', 'Санкт-Петербург-Главный', 101, '2024-03-01 10:00:00', '2024-03-01 16:00:00'),
-- 102 поезд (прямой мск-твр) (непрямой мск-спб)
('Москва-Пасс.', 'Тверь-2', 102, '2024-03-02 11:00:00', '2024-03-02 13:00:00'),
('Тверь-2', 'Санкт-Петербург-2', 102, '2024-03-02 14:00:00', '2024-03-02 17:00:00'),

('Москва-Пасс.', 'Санкт-Петербург-2', 102, '2024-03-02 11:00:00', '2024-03-02 17:00:00'),
-- 103 поезд (прямой мск-спб)
('Ярославль-Главный', 'Москва-2', 103, '2024-03-03 11:00:00', '2024-03-03 13:00:00'),
('Москва-2', 'Санкт-Петербург-Главный', 103, '2024-03-03 13:20:00', '2024-03-03 19:00:00'),
('Санкт-Петербург-Главный', 'Архангельск-Пасс.', 103, '2024-03-03 19:20:00', '2024-03-03 23:00:00'),

('Ярославль-Главный', 'Санкт-Петербург-Главный', 103, '2024-03-03 11:00:00', '2024-03-03 19:00:00'),
('Москва-2', 'Архангельск-Пасс.', 103, '2024-03-03 13:20:00', '2024-03-03 23:00:00'),

('Ярославль-Главный', 'Архангельск-Пасс.', 103, '2024-03-03 11:00:00', '2024-03-03 23:00:00'),
-- 104 поезд (прямой мск-твр)
('Москва-Пасс.', 'Тверь-Пасс.', 104, '2024-03-04 9:00:00', '2024-03-04 13:00:00'),
-- 105 поезд (прямой мск-твр)
('Москва-2', 'Тверь-2', 105, '2024-03-05 9:00:00', '2024-03-05 12:00:00'),
-- 106 поезд (прямой мск-твр) (прямой мск-спб)
('Ярославль-Главный', 'Москва-Пасс.', 106, '2024-03-06 11:00:00', '2024-03-06 13:00:00'),
('Москва-Пасс.', 'Санкт-Петербург-Главный', 106, '2024-03-06 13:30:00', '2024-03-06 20:00:00'),

('Ярославль-Главный', 'Санкт-Петербург-Главный', 106, '2024-03-06 11:00:00', '2024-03-06 20:00:00'),
-- 107 поезд (прямой мск-твр) (непрямой мск-спб)
('Ярославль-Главный', 'Москва-2', 107, '2024-03-07 11:00:00', '2024-03-07 13:00:00'),
('Москва-2', 'Тверь-2', 107, '2024-03-07 13:20:00', '2024-03-07 15:00:00'),
('Тверь-2', 'Санкт-Петербург-2', 107, '2024-03-07 15:20:00', '2024-03-07 23:00:00'),

('Ярославль-Главный', 'Тверь-2', 107, '2024-03-07 11:00:00', '2024-03-07 15:00:00'),
('Москва-2', 'Санкт-Петербург-2', 107, '2024-03-07 13:20:00', '2024-03-07 23:00:00'),

('Ярославль-Главный', 'Санкт-Петербург-2', 107, '2024-03-07 11:00:00', '2024-03-07 23:00:00'),
-- 108 поезд (прямой мск-твр) (непрямой мск-спб) (но приезд на след день)
('Москва-2', 'Тверь-Пасс.', 108, '2024-03-08 20:00:00', '2024-03-08 22:00:00'),
('Тверь-Пасс.', 'Санкт-Петербург-2', 108, '2024-03-08 22:30:00', '2024-03-09 01:00:00'),

('Москва-2', 'Санкт-Петербург-2', 108, '2024-03-08 20:00:00', '2024-03-09 01:00:00');