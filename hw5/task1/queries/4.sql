SELECT DISTINCT r.surname, r.name
FROM readers r
JOIN book_takings bt ON r.id = bt.reader_id
WHERE bt.return_date IS NOT NULL;
