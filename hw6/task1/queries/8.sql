SELECT b.*
FROM books b
WHERE b.isbn in (
    SELECT book_isbn
    FROM copies
    GROUP BY book_isbn
    HAVING COUNT(*) > 1
);
