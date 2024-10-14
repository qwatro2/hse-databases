UPDATE book_takings bt
SET return_date = bt.return_date + 30
WHERE bt.isbn IN (
    SELECT b.isbn
    FROM books b
    JOIN books_to_categories btc ON b.isbn = btc.book_isbn
    WHERE btc.category_name = 'Базы данных'
)
AND bt.return_date >= '2016-01-01';
