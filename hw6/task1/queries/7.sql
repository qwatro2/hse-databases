SELECT r.*
FROM readers r
WHERE r.id in (
    SELECT reader_id
    FROM book_takings bt
    JOIN books b ON bt.isbn = b.isbn
    WHERE b.author = 'Марк Твен' AND bt.copy_id IS NULL
    GROUP BY bt.reader_id
    HAVING COUNT(DISTINCT bt.isbn) = (
        SELECT COUNT(DISTINCT isbn)
        FROM books
        WHERE author = 'Марк Твен'
    )
);
