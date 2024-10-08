SELECT DISTINCT r.surname, r.name
FROM readers r
JOIN book_takings bt ON r.id = bt.reader_id
WHERE bt.copy_id IN (
  SELECT bt2.copy_id
  FROM book_takings bt2
  JOIN readers r2 ON bt2.reader_id = r2.id
  WHERE r2.name = 'Иван' AND r2.surname = 'Иванов'
) AND r.name != 'Иван' AND r.surname != 'Иванов';
