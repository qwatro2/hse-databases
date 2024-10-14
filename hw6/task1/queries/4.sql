SELECT *
FROM books
WHERE number_of_pages > (
    SELECT AVG(number_of_pages) * 2 
    FROM books
);
