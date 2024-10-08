SELECT c.*
FROM connections c
JOIN stations s1 ON c.departure_station_name = s1.name
JOIN stations s2 ON c.arrival_station_name = s2.name
WHERE s1.lies_in_city_name = 'Москва' 
AND s2.lies_in_city_name = 'Тверь';