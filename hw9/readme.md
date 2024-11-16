# БД ДЗ 9

## Подготовка
```bash
docker-compose up -d
```

## Задание 1
Скрипт в файле `task1.sql`
```sql
SELECT 
    bit_length(name) + length(race) AS calculation
FROM 
    demographics;
```

## Задание 2
Скрипт в файле `task2.sql`
```sql
SELECT
    id,
    bit_length(name) as name,
    birthday,
    bit_length(race) as race
FROM
    demographics
```

## Задание 3
Скрипт в файле `task3.sql`
```sql
SELECT
    id,
    ascii(name) as name,
    birthday,
    ascii(race) as race
FROM
    demographics
```

## Задание 4
Скрипт в файле `task4.sql`
```sql
SELECT
    concat_ws(' ', prefix, first, last, suffix) as title
FROM
    names
```

## Задание 5
Скрипт в файле `task5.sql`
```sql
SELECT
    rpad(md5, length(sha256), '1') as md5,
    lpad(sha1, length(sha256), '0') as sha1,
    sha256
FROM
    encription;
```

## Задание 6
Скрипт в файле `task6.sql`
```sql
SELECT
    left(project, commits) as project,
    right(address, contributors) as address
FROM
    repositories
```

## Задание 7
Скрипт в файле `task7.sql`
```sql
SELECT 
    project,
    commits,
    contributors,
    regexp_replace(address, '\d', '!', 'g') AS address
FROM 
    repositories
```

## Задание 8
Скрипт в файле `task8.sql`
```sql
SELECT 
    name,
    weight,
    price,
    round(cast(price / (weight / 1000.0) as numeric), 2) as price_per_kg
FROM 
    products
ORDER BY 
    price_per_kg asc,
    name asc;
```

# Завершение
```bash
docker-compose down
```
