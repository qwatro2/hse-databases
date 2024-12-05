# Задание 1: BRIN индексы и bitmap-сканирование

1. Удалите старую базу данных, если есть:
   ```shell
   docker compose down
   ```

2. Поднимите базу данных из src/docker-compose.yml:
   ```shell
   docker compose down && docker compose up -d
   ```

3. Обновите статистику:
   ```sql
   ANALYZE t_books;
   ```

4. Создайте BRIN индекс по колонке category:
   ```sql
   CREATE INDEX t_books_brin_cat_idx ON t_books USING brin(category);
   ```

5. Найдите книги с NULL значением category:
   ```sql
   EXPLAIN ANALYZE
   SELECT * FROM t_books WHERE category IS NULL;
   ```
   
   *План выполнения:*
   ![](screenshots/task1/5.png)
   
   *Объясните результат:*
   использование `Bitmap Heap Scan` в начале говорит о том, что сначала индекс не был использован, а после речека стал использоваться, т.к. теперь там `Bitmap Index Scan`

6. Создайте BRIN индекс по автору:
   ```sql
   CREATE INDEX t_books_brin_author_idx ON t_books USING brin(author);
   ```

7. Выполните поиск по категории и автору:
   ```sql
   EXPLAIN ANALYZE
   SELECT * FROM t_books 
   WHERE category = 'INDEX' AND author = 'SYSTEM';
   ```
   
   *План выполнения:*
   ![](screenshots/task1/7.png)
   
   *Объясните результат (обратите внимание на bitmap scan):*
   в начале используется `Bitmap Heap Scan`, видимо потому что движок, решил, что это оптимальнее, чем использовать индекс, созданных в п. 6. После того, как он отфильтровал значения по `author`, стал использовать `Bitmap Index Scan`, т.е. категорию искал уже по индексу

8. Получите список уникальных категорий:
   ```sql
   EXPLAIN ANALYZE
   SELECT DISTINCT category 
   FROM t_books 
   ORDER BY category;
   ```
   
   *План выполнения:*
   ![](screenshots/task1/8.png)
   
   *Объясните результат:*
   индекс не отсортировал данные, поэтому пришлось тратить время на сортировку (т.к. запрос содержит `DISTINCT`), а затем использовался самый простой `Seq Scan`, потому что после сортировке это быстрее

9. Подсчитайте книги, где автор начинается на 'S':
   ```sql
   EXPLAIN ANALYZE
   SELECT COUNT(*) 
   FROM t_books 
   WHERE author LIKE 'S%';
   ```
   
   *План выполнения:*
   ![](screenshots/task1/9.png)
   
   *Объясните результат:*
   использован `Seq Scan`, т.к. созданный индекс не позволял выполнить поиск строк с нужным суффиксом

10. Создайте индекс для регистронезависимого поиска:
    ```sql
    CREATE INDEX t_books_lower_title_idx ON t_books(LOWER(title));
    ```

11. Подсчитайте книги, начинающиеся на 'O':
    ```sql
    EXPLAIN ANALYZE
    SELECT COUNT(*) 
    FROM t_books 
    WHERE LOWER(title) LIKE 'o%';
    ```
   
   *План выполнения:*
   ![](screenshots/task1/11.png)
   
   *Объясните результат:*
   ситуация аналогична п. 9, движок выполняет последовательное сканирование

12. Удалите созданные индексы:
    ```sql
    DROP INDEX t_books_brin_cat_idx;
    DROP INDEX t_books_brin_author_idx;
    DROP INDEX t_books_lower_title_idx;
    ```

13. Создайте составной BRIN индекс:
    ```sql
    CREATE INDEX t_books_brin_cat_auth_idx ON t_books 
    USING brin(category, author);
    ```

14. Повторите запрос из шага 7:
    ```sql
    EXPLAIN ANALYZE
    SELECT * FROM t_books 
    WHERE category = 'INDEX' AND author = 'SYSTEM';
    ```
   
   *План выполнения:*
   ![](screenshots/task1/14.png)
   
   *Объясните результат:*
   в итоге используется `Bitmap Index Scan`, потому что в п. 13 был создан составной индекс по интересующим нас колонкам