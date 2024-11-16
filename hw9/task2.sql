SELECT
    id,
    bit_length(name) as name,
    birthday,
    bit_length(race) as race
FROM
    demographics
