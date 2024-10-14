-- выводит имя студента и его лучшую оценку, если эта оценка не меньше 4.0

SELECT s.Name, c.Note
FROM Student s, Lecture lec, "check" c
WHERE s.MatrNr = c.MatrNr 
AND lec.LectNr = c.LectNr 
AND c.Note >= 4
AND c.Note >= ALL (
  SELECT c1.Note 
  FROM "check" c1 
  WHERE c1.MatrNr = c.MatrNr 
);
