SELECT c1.*
FROM connections c1
JOIN stations s1 ON c1.departure_station_name = s1.name
JOIN stations s2 ON c1.arrival_station_name = s2.name
WHERE s1.lies_in_city_name = 'Москва'
AND s2.lies_in_city_name = 'Тверь'
AND c1.train_nr NOT IN (
    SELECT c2.train_nr
    FROM connections c2
    WHERE c2.departure > c1.departure
    AND c2.departure < c1.arrival
);
