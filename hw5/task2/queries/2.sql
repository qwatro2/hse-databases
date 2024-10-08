SELECT DISTINCT
    c1.departure_station_name AS start_station,
    c1.arrival_station_name AS transfer_station,
    c2.arrival_station_name AS final_station,
    c1.departure AS departure_time,
    c2.arrival AS arrival_time
FROM
    connections c1
JOIN
    connections c2 ON c1.arrival_station_name = c2.departure_station_name
WHERE
    c1.departure_station_name = 'Москва-Пасс.'
    AND c2.arrival_station_name = 'Санкт-Петербург-Главный'
    AND DATE(c1.departure) = DATE(c2.arrival)
    AND DATE(c1.departure) = DATE(c1.arrival);
