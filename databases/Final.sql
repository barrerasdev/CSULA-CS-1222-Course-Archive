-- Diego Barreras
-- Final Exam

-- Q1 [5pt]: Report the names of the professor whose office phone numbers end with 21.

SELECT prof_name
FROM Professors
WHERE SUBSTRING(officephone, - 2) = '21';

-- Q2 [5pt]: Report the names of the professors who supervise more than 2 students. Use Inner Join method.

SELECT p.prof_name
FROM Professors p
INNER JOIN Supervise s ON p.prof_id = s.prof_id
GROUP BY p.prof_id , p.prof_name
HAVING COUNT(s.student_id) > 2;

-- Q3 [5pt]: Report the number of students who entered in the same year, and the total number of students at the last row.

SELECT EntryDate, COUNT(*) AS num_students
FROM Students
GROUP BY EntryDate 
UNION SELECT 'Total' AS EntryDate, COUNT(*) AS num_students
FROM Students;

-- Q4 [6pt]: Report the department with the least number of professors, and the number of professors.

SELECT dept, COUNT(*) AS num_professors
FROM Professors
GROUP BY dept
ORDER BY num_professors
LIMIT 1;

-- Q5 [5pt]: For each project, list the project name, the names of the professors and students who work on the project. 
-- Sort the results by project name.

SELECT  s.project, p.prof_name, s.student_id, st.student_name
FROM Supervise s
INNER JOIN Professors p ON s.prof_id = p.prof_id
INNER JOIN Students st ON s.student_id = st.student_id
ORDER BY s.project;

-- Q6 [5pt]: Find the names of professors who do NOT supervise any student.

SELECT p.prof_name
FROM Professors p
LEFT JOIN Supervise s ON p.prof_id = s.prof_id
WHERE s.prof_id IS NULL;

-- Q7 [5pt]: Find the name(s) of the professor who has the longest name.

SELECT prof_name
FROM Professors
ORDER BY LENGTH(prof_name) DESC
LIMIT 1;

-- Q8 [6pt]: Report the names of all students (only once) and whether they have a supervisor or not.

SELECT student_name,
    CASE
        WHEN supervisor_count > 0 THEN 'Yes'
		ELSE 'No'
    END AS Supervisor
FROM Students
LEFT JOIN (SELECT student_id, COUNT(*) AS supervisor_count
			FROM Supervise
GROUP BY student_id) AS SuperviseCount ON Students.student_id = SuperviseCount.student_id;

-- Q9 [6pt]: For each professor, display the name of the professor, the name of the student the professor supervises, 
-- followed on the next line by the total number of students the professor supervises.

(SELECT p.prof_name, st.student_name
FROM Professors p
INNER JOIN Supervise s ON p.prof_id = s.prof_id
INNER JOIN Students st ON s.student_id = st.student_id
ORDER BY p.prof_name , st.student_name) UNION ALL (SELECT  p.prof_name, CONCAT('Total: ', COUNT(s.student_id)) AS student_name
FROM Professors p
INNER JOIN Supervise s ON p.prof_id = s.prof_id
GROUP BY p.prof_name
ORDER BY p.prof_name);

-- Q10 [5pt]: List the names of all students and projects they work on (if any).

SELECT St.student_name, S.project
FROM Students St 
LEFT JOIN Supervise S ON St.student_id = S.student_id;

-- Q11 [5pt]: Add a new attribute cellphone to the Students table. The attribute is a string with 10 letters.

ALTER TABLE Students 
ADD cellphone VARCHAR(10);

-- Q12 [6pt]: Professor Charlie agrees to supervise student 0008 on the project 'project07' starting on 2023-08-21. 
-- Insert a new row into the Supervise table. Note: you can NOT use professor Charlie's prof_id directly in your query.

INSERT INTO Supervise (prof_id, student_id, project, startdate)
VALUES ((SELECT prof_id FROM Professors WHERE prof_name = 'Charlie'), 0008, 'project07', '2023-08-21');

-- Q13 [5pt]: Add a primary key constraint to the Supervise table. The primary key is the combination of prof_id, 
-- student_id, and project. Please use the proper naming conventions.

ALTER TABLE Supervise 
ADD PRIMARY KEY (prof_id, student_id, project);

-- Q14 [5pt]: Add a foreign key constraint to the Supervise table. The prof_id in the Supervise table refers to prof_id 
-- in the Professors table. Use the proper naming conventions. Note: you should make prof_id the primary key of the Professors 
-- table before you create the foreign key constraint. 

ALTER TABLE Professors 
ADD PRIMARY KEY (prof_id);

ALTER TABLE Supervise 
ADD FOREIGN KEY (prof_id) REFERENCES Professors(prof_id);

-- Q15 [6pt]: Create an updatable view that reports the department of CE and the professor names of the department. 
-- Make sure that no other department than CE can be inserted into the Professors table through the view.

CREATE VIEW CE_Professors AS
    SELECT prof_name, dept
    FROM Professors
    WHERE dept = 'CE' WITH CHECK OPTION;

-- Q16 [10pt]: Create a trigger called before_supervise_update. Before any row in the Supervise table is updated, 
-- the trigger should insert a tuple into the Supervise_Audit table to keep the prof_id, student_id, project, startdate, and the timestamp of the update.  The following is the definition of the Supervise_Audit table.

DELIMITER //

CREATE TRIGGER before_supervise_update
BEFORE UPDATE ON Supervise
FOR EACH ROW 
BEGIN
    INSERT INTO Supervise_Audit(prof_id, student_id, project, startdate, changedate, action)
    VALUES (OLD.prof_id, OLD.student_id, OLD.project, OLD.startdate, NOW(), 'UPDATE');
END//

DELIMITER ;

-- Q17 [10pt]: Create a trigger called before_supervise_insert. Before a new row is inserted into the Supervise table,
--  the Supervise_Total table is updated to reflect the total number of students the corresponding supervisor has. 
-- Note: If the supervisor is NOT in the Supervise table, you should insert a new tuple into the Supervise_Total table. 
-- Otherwise, just update the Supervise_Total table. The following is the definition of the Supervise_Total table.

DELIMITER //

CREATE TRIGGER before_supervise_insert
BEFORE INSERT ON Supervise
FOR EACH ROW
BEGIN
    INSERT INTO Supervise_Total(prof_id, total)
    VALUES (NEW.prof_id, (SELECT COUNT(*) FROM Supervise WHERE prof_id = NEW.prof_id) + 1)
    ON DUPLICATE KEY UPDATE total = total + 1;
END//

DELIMITER ;