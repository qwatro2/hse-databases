SELECT
    concat_ws(' ', prefix, first, last, suffix) as title
FROM
    names
