-- выводит имя и номер всех студентов, у которых все оценки ниже, чем 4.0

SELECT s.Name, s.MatrNr
FROM Student s
WHERE NOT EXISTS (
  SELECT * 
  FROM "check" c 
  WHERE c.MatrNr = s.MatrNr 
  AND c.Note >= 4.0
);
