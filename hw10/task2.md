# Задание 2: Специальные случаи использования индексов

# Партиционирование и специальные случаи использования индексов

1. Удалите прошлый инстанс PostgreSQL - `docker-compose down` в папке `src` и запустите новый: `docker-compose up -d`.

2. Создайте партиционированную таблицу и заполните её данными:

    ```sql
    -- Создание партиционированной таблицы
    CREATE TABLE t_books_part (
        book_id     INTEGER      NOT NULL,
        title       VARCHAR(100) NOT NULL,
        category    VARCHAR(30),
        author      VARCHAR(100) NOT NULL,
        is_active   BOOLEAN      NOT NULL
    ) PARTITION BY RANGE (book_id);

    -- Создание партиций
    CREATE TABLE t_books_part_1 PARTITION OF t_books_part
        FOR VALUES FROM (MINVALUE) TO (50000);

    CREATE TABLE t_books_part_2 PARTITION OF t_books_part
        FOR VALUES FROM (50000) TO (100000);

    CREATE TABLE t_books_part_3 PARTITION OF t_books_part
        FOR VALUES FROM (100000) TO (MAXVALUE);

    -- Копирование данных из t_books
    INSERT INTO t_books_part 
    SELECT * FROM t_books;
    ```

3. Обновите статистику таблиц:
   ```sql
   ANALYZE t_books;
   ANALYZE t_books_part;
   ```
   
   *Результат:*\
    ![image](./screenshots/task2/3.png)

4. Выполните запрос для поиска книги с id = 18:
   ```sql
   EXPLAIN ANALYZE
   SELECT * FROM t_books_part WHERE book_id = 18;
   ```
   
   *План выполнения:*
    ![image](./screenshots/task2/4.png)
   
   *Объясните результат:*
   система выбрала патрицию, в которой находятся значения `book_id = 18` и выполнила по ней `Seq Scan` вместо поиска по индексу, т.к. `PRIMARY KEY` не "унаследовался" патрициями от своего родителя

5. Выполните поиск по названию книги:
   ```sql
   EXPLAIN ANALYZE
   SELECT * FROM t_books_part 
   WHERE title = 'Expert PostgreSQL Architecture';
   ```
   
   *План выполнения:*
   ![image](./screenshots/task2/5.png)
   
   *Объясните результат:*
   т.к. патрицирование было сделано по `book_id` подходящие под запрос значения могли попасть в каждую патрицию, поэтому происходит `Seq Scan` по каждой патриции

6. Создайте партиционированный индекс:
   ```sql
   CREATE INDEX ON t_books_part(title);
   ```
   
   *Результат:*
   ![image](./screenshots/task2/6.png)

7. Повторите запрос из шага 5:
   ```sql
   EXPLAIN ANALYZE
   SELECT * FROM t_books_part 
   WHERE title = 'Expert PostgreSQL Architecture';
   ```
   
   *План выполнения:*
   ![image](./screenshots/task2/7.png)
      
   *Объясните результат:*
   всё аналогично `п.5`, но используется `Index Scan`, т.к. мы явно создали индекс по `title`. В каждой патриции создался свой индекс.

8. Удалите созданный индекс:
   ```sql
   DROP INDEX t_books_part_title_idx;
   ```
   
   *Результат:*
   ![image](./screenshots/task2/8.png)

9. Создайте индекс для каждой партиции:
   ```sql
   CREATE INDEX ON t_books_part_1(title);
   CREATE INDEX ON t_books_part_2(title);
   CREATE INDEX ON t_books_part_3(title);
   ```
   
   *Результат:*
   ![image](./screenshots/task2/9.png)

10. Повторите запрос из шага 5:
    ```sql
    EXPLAIN ANALYZE
    SELECT * FROM t_books_part 
    WHERE title = 'Expert PostgreSQL Architecture';
    ```
    
    *План выполнения:*
   ![image](./screenshots/task2/10.png)
    
    *Объясните результат:*
    ситуация полностью как в `п.7`, только теперь мы руками создали индексы в отдельных патрициях

11. Удалите созданные индексы:
    ```sql
    DROP INDEX t_books_part_1_title_idx;
    DROP INDEX t_books_part_2_title_idx;
    DROP INDEX t_books_part_3_title_idx;
    ```
    
    *Результат:*
   ![image](./screenshots/task2/11.png)

12. Создайте обычный индекс по book_id:
    ```sql
    CREATE INDEX t_books_part_idx ON t_books_part(book_id);
    ```
    
    *Результат:*
   ![image](./screenshots/task2/12.png)

13. Выполните поиск по book_id:
    ```sql
    EXPLAIN ANALYZE
    SELECT * FROM t_books_part WHERE book_id = 11011;
    ```
    
    *План выполнения:*
   ![image](./screenshots/task2/13.png)
    
    *Объясните результат:*
    произошел поиск по индексу только в патриции, в которой могут находиться строки с `book_id = 11011`

14. Создайте индекс по полю is_active:
    ```sql
    CREATE INDEX t_books_active_idx ON t_books(is_active);
    ```
    
    *Результат:*
   ![image](./screenshots/task2/14.png)

15. Выполните поиск активных книг с отключенным последовательным сканированием:
    ```sql
    SET enable_seqscan = off;
    EXPLAIN ANALYZE
    SELECT * FROM t_books WHERE is_active = true;
    SET enable_seqscan = on;
    ```
    
    *План выполнения:*
    ![image](./screenshots/task2/15.png)
    
    *Объясните результат:*
    используется `Bitmap Heap Scan` с последующим `Bitmap Index Scan` по созданному индексу

16. Создайте составной индекс:
    ```sql
    CREATE INDEX t_books_author_title_index ON t_books(author, title);
    ```
    
    *Результат:*
    ![image](./screenshots/task2/16.png)

17. Найдите максимальное название для каждого автора:
    ```sql
    EXPLAIN ANALYZE
    SELECT author, MAX(title) 
    FROM t_books 
    GROUP BY author;
    ```
    
    *План выполнения:*
    ![image](./screenshots/task2/17.png)
    
    *Объясните результат:*
    индекс не используется, т.к. он не покрывает агрегацию, т.е. функцию `MAX(title)`, он был бы полезен для запросов с `... WHERE author = $1 AND title = $2`

18. Выберите первых 10 авторов:
    ```sql
    EXPLAIN ANALYZE
    SELECT DISTINCT author 
    FROM t_books 
    ORDER BY author 
    LIMIT 10;
    ```
    
    *План выполнения:*
    ![image](./screenshots/task2/18.png)
    
    *Объясните результат:*
    здесь индекс как раз помогает, т.к. предоставляет сортировку по парам `(author, title)`

19. Выполните поиск и сортировку:
    ```sql
    EXPLAIN ANALYZE
    SELECT author, title 
    FROM t_books 
    WHERE author LIKE 'T%'
    ORDER BY author, title;
    ```
    
    *План выполнения:*
    ![image](./screenshots/task2/19.png)
    
    *Объясните результат:*
    здесь индекс не помогает, т.к. сначала отобрались строки, подходящие под условие `LIKE`

20. Добавьте новую книгу:
    ```sql
    INSERT INTO t_books (book_id, title, author, category, is_active)
    VALUES (150001, 'Cookbook', 'Mr. Hide', NULL, true);
    COMMIT;
    ```
    
    *Результат:*
    ![image](./screenshots/task2/20.png)

21. Создайте индекс по категории:
    ```sql
    CREATE INDEX t_books_cat_idx ON t_books(category);
    ```
    
    *Результат:*
    ![image](./screenshots/task2/21.png)

22. Найдите книги без категории:
    ```sql
    EXPLAIN ANALYZE
    SELECT author, title 
    FROM t_books 
    WHERE category IS NULL;
    ```
    
    *План выполнения:*
    ![image](./screenshots/task2/22.png)
    
    *Объясните результат:*
    использован индекс по категориям. Категорий всего 6 штук + `NULL`, поэтому индекс эффективно помогает ускорить выполнение запроса

23. Создайте частичные индексы:
    ```sql
    DROP INDEX t_books_cat_idx;
    CREATE INDEX t_books_cat_null_idx ON t_books(category) WHERE category IS NULL;
    ```
    
    *Результат:*
    ![image](./screenshots/task2/23.png)

24. Повторите запрос из шага 22:
    ```sql
    EXPLAIN ANALYZE
    SELECT author, title 
    FROM t_books 
    WHERE category IS NULL;
    ```
    
    *План выполнения:* \
    ![image](./screenshots/task2/24.png)
    
    *Объясните результат:*
    частичный индекс хранит как раз все строки, которые находит запрос, и только их, поэтому эффективно просто возвращается индекс

25. Создайте частичный уникальный индекс:
    ```sql
    CREATE UNIQUE INDEX t_books_selective_unique_idx 
    ON t_books(title) 
    WHERE category = 'Science';
    
    -- Протестируйте его
    INSERT INTO t_books (book_id, title, author, category, is_active)
    VALUES (150002, 'Unique Science Book', 'Author 1', 'Science', true);
    
    -- Попробуйте вставить дубликат
    INSERT INTO t_books (book_id, title, author, category, is_active)
    VALUES (150003, 'Unique Science Book', 'Author 2', 'Science', true);
    
    -- Но можно вставить такое же название для другой категории
    INSERT INTO t_books (book_id, title, author, category, is_active)
    VALUES (150004, 'Unique Science Book', 'Author 3', 'History', true);
    ```
    
    *Результат:*
    ![image](./screenshots/task2/25/1.png)
    ![image](./screenshots/task2/25/2.png)
    ![image](./screenshots/task2/25/3.png)
    ![image](./screenshots/task2/25/4.png)
    
    *Объясните результат:*
    индекс обеспечивает уникальность значений только для строк, где `category = 'Science'`. Первая вставка прошла успещно, потому что книги с таким названием в категории `'Science'` еще не было. Дубликат нам вставить не дали, т.к. книга с таким названием в категории `'Science'` уже есть, и такая вставка нарушила бы уникальность. Третья вставка прошла успешно, т.к. несмотря на то, что книга с таким названием уже есть, мы вставляем книгу другой категории, а индекс нам этого не запрещает
