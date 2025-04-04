-- Diego Barreras
-- CS 1222-01
-- Midterm 1
-- Part 1

-- Q1: Report the student name, email, and entry date of all male students.  
-- The output format is as follows:      'Student ID'       'Student Name'       'Email Address'       'Entry Date'

	SELECT student_id AS 'Student ID', student_name AS 'Student Name', EMail AS 'Email Address',EntryDate AS 'Entry Date'
    FROM Students
    WHERE gender = 'M';
    
-- Q2: Report all information of the students who entered in January 2004 and are older than 20.

	SELECT *
	FROM Students
	WHERE EntryDate >= '2004-01-01' AND age > 20;

-- Q3: For each professor, report the professor id and the number of students supervised by this professor.

	SELECT P.prof_id, COUNT(S.prof_id) AS num_students_supervised
	FROM Professors P
	LEFT JOIN Supervise S ON P.prof_id = S.prof_id
	GROUP BY P.prof_id;
    
-- Q4: Report the name of the student who has the latest entry date.

	SELECT student_name
	FROM Students
	WHERE EntryDate = (SELECT MAX(EntryDate)
					   FROM Students);
                       
-- Q5: Report the student names and age of all students who have a "calstatela" email address. Sort the results by age.

	SELECT student_name, age
	FROM Students
	WHERE EMail LIKE '%calstatela%'
	ORDER BY age;
    
-- Q6: Report the names of the professors who work on 'project04' or 'project05'.

	SELECT DISTINCT P.prof_name
	FROM Professors P
	INNER JOIN Supervise S 
    ON P.prof_id = S.prof_id
	WHERE S.project IN ('project04', 'project05');

-- Q7: Report the names of the students who need a supervisor.

	SELECT student_name
	FROM Students
	WHERE student_id NOT IN (SELECT DISTINCT student_id 
							 FROM Supervise);
                             
-- Q8: Report the names of the female students who are younger than all male students.

	SELECT S.student_name
	FROM Students S
	WHERE gender = 'F' AND age < ALL (SELECT age 
									  FROM Students 
									  WHERE gender = 'M');

-- Q9: Report the number of professors for each department. 

	SELECT dept, COUNT(*) AS 'Number of Professors'
	FROM Professors
	GROUP BY dept;

-- Q10: Report the department that has the most number of professors and the number of professors. 


	SELECT dept, COUNT(*) AS num_professors
	FROM Professors
	GROUP BY dept
	HAVING COUNT(*) = ( SELECT MAX(num_professors)
						FROM (	SELECT dept, COUNT(*) AS num_professors 
								FROM Professors 
								GROUP BY dept) AS subquery);

-- Q11: Report the professor id and name who supervises more than one student. 

	SELECT P.prof_id, P.prof_name
	FROM Professors P
	INNER JOIN Supervise S ON P.prof_id = S.prof_id
	GROUP BY P.prof_id, P.prof_name
	HAVING COUNT(*) > 1;

-- Q12: Report the professor id, professor name, and the student names they supervised. Sort the results by professor id and student name (in ascending order). 
-- List the results only once (No duplicates).

	SELECT DISTINCT P.prof_id, P.prof_name, S.student_name
	FROM Professors P
	JOIN Supervise SV 
	ON P.prof_id = SV.prof_id
	JOIN Students AS S 
	ON SV.student_id = S.student_id
	ORDER BY P.prof_id ASC, S.student_name ASC;

-- Q13: Report the names of the students who work on more than 1 project, the age of the students, and the number of projects. 

	SELECT S.student_name, S.age, COUNT(Supervise.project) AS num_projects
	FROM Students S
	INNER JOIN Supervise 
	ON S.student_id = Supervise.student_id
	GROUP BY S.student_name, S.age
	HAVING COUNT(Supervise.project) > 1;

-- Q14: Report the names of the professors who work on the most number of projects, and the number of projects. 

	SELECT P.prof_name, COUNT(S.project) AS num_projects
	FROM Professors P
	INNER JOIN Supervise S 
	ON P.prof_id = S.prof_id
	GROUP BY P.prof_name
	HAVING COUNT(S.project) = ( SELECT MAX(project_count)
								FROM ( SELECT prof_id, COUNT(project) AS project_count
								FROM Supervise
								GROUP BY prof_id) AS project_counts);

-- Q15: Report each project name, and the professor's contact info (name, office phone number, email) who work on the project.
-- Sort the results by project name.
 
	SELECT DISTINCT S.project, P.prof_name, P.officephone, P.EMail
	FROM Supervise S
	INNER JOIN Professors P ON S.prof_id = P.prof_id
	ORDER BY S.project;
 



