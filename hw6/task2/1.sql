-- preparation
INSERT INTO books (isbn, name, author, number_of_pages, year, publishing_house) VALUES
(123456, 'Untitled', 'Untitled', 300, 2024, 'АСТ');

INSERT INTO copies (book_isbn, id, position) VALUES
(123456, 4, 14);

-- query
INSERT INTO book_takings (reader_id, isbn, copy_id, return_date)
VALUES (
    (
        SELECT id
        FROM readers
        WHERE name = 'Василий' AND surname = 'Петров'
    ),
    123456, 4, NULL
);
