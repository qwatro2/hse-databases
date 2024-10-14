INSERT INTO Student (MatrNr, Name, Semester) VALUES
(101, 'Иван Иванов', 1),
(102, 'Петр Петров', 2),
(103, 'Анна Смирнова', 3),
(104, 'Ольга Сидорова', 1),
(105, 'Сергей Кузнецов', 4),
(106, 'Плохой Студент', 1);

INSERT INTO Professor (ProfNr, Name, Room) VALUES
(201, 'PhD. Николай Федоров', 101),
(202, 'PhD. Мария Петрова', 102),
(203, 'PhD. Алексей Иванов', 103);

INSERT INTO Lecture (LectNr, Title, Credit, ProfNr) VALUES
(301, 'Math', 5, 201),
(302, 'Algorithms', 4, 202),
(303, 'Economics', 6, 203),
(304, 'Databases', 3, 202),
(305, 'Data Science', 2, 201);

INSERT INTO "check" (MatrNr, LectNr, ProfNr, Note) VALUES
(101, 301, 201, 10.0),
(101, 302, 202, 5.0),
(102, 303, 203, 7.0),
(103, 302, 202, 8.0),
(103, 304, 202, 3.0),
(104, 305, 201, 4.0),
(105, 303, 203, 6.0),
(105, 301, 201, 1.0),
(106, 301, 201, 2.0),
(106, 302, 202, 3.4);