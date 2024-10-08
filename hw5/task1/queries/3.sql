SELECT btc.book_isbn
FROM books_to_categories btc
WHERE btc.category_name = 'Горы'
EXCEPT
SELECT btc.book_isbn
FROM books_to_categories btc
WHERE btc.category_name = 'Путешествия';
