DELETE FROM book_takings
WHERE isbn IN (
    SELECT isbn
    FROM books
    WHERE year > 2000
);

DELETE FROM books_to_categories
WHERE book_isbn in (
    SELECT isbn
    FROM books
    WHERE year > 2000
);

DELETE FROM copies
WHERE book_isbn IN (
    SELECT isbn
    FROM books
    WHERE year > 2000
);

DELETE FROM books
WHERE year > 2000;
