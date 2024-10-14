WITH RECURSIVE pc AS (
    SELECT *
    FROM categories
    WHERE parent_category = 'Спорт'

    UNION ALL (
        SELECT sc.*
        FROM categories sc
        JOIN pc ON sc.parent_category = pc.name
    )
)
SELECT DISTINCT pc.*
FROM pc;
