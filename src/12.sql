SELECT P1.student_id, P1.student_name, P1.subject_name, COUNT(Examinations.student_id) as attended_exams FROM
(
    SELECT Students.student_id, Students.student_name, Subjects.subject_name FROM
    Students JOIN Subjects
) AS P1
LEFT JOIN Examinations 
ON P1.student_id = Examinations.student_id AND P1.subject_name = Examinations.subject_name
GROUP BY P1.student_id, P1.subject_name
ORDER BY Students.student_id, Subjects.subject_name
