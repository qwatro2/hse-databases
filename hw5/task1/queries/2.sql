SELECT b.author, b.name
FROM readers r
JOIN book_takings bt ON r.id = bt.reader_id
JOIN copies c ON bt.copy_id = c.id
JOIN books b ON c.book_isbn = b.isbn
WHERE r.name = 'Иван' AND r.surname = 'Иванов';
