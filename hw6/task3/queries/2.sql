-- выводит номер профессора, его имя и суммарное количество кредитов

(
  SELECT p.ProfNr, p.Name, sum(lec.Credit)
  FROM Professor p, Lecture lec
  WHERE p.ProfNr = lec.ProfNr
  GROUP BY p.ProfNr, p.Name
)
UNION 
(
  SELECT p.ProfNr, p.Name, 0
  FROM Professor p
  WHERE NOT EXISTS (
    SELECT * 
    FROM Lecture lec 
    WHERE lec.ProfNr = p.ProfNr 
  )
);
