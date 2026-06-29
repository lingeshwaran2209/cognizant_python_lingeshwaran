USE college_db;

-- ===================================================
-- HANDS-ON 2
-- Writing SQL Queries – DML, Joins & Aggregations
-- ===================================================

/*====================================================
TASK 15
Insert Sample Data
Run ONLY if the tables are empty.
If you already inserted the data, SKIP this section.
====================================================*/

-- Departments
INSERT INTO departments (dept_name, head_of_dept, budget)
SELECT * FROM (
SELECT 'Computer Science','Dr. Ramesh Kumar',850000.00
UNION ALL
SELECT 'Electronics','Dr. Priya Nair',620000.00
UNION ALL
SELECT 'Mechanical','Dr. Suresh Iyer',540000.00
UNION ALL
SELECT 'Civil','Dr. Ananya Sharma',430000.00
) AS x
WHERE NOT EXISTS (SELECT 1 FROM departments);

-- Students
INSERT INTO students
(first_name,last_name,email,date_of_birth,department_id,enrollment_year)
SELECT * FROM (
SELECT 'Arjun','Mehta','arjun.mehta@college.edu','2003-04-12',1,2022
UNION ALL
SELECT 'Priya','Suresh','priya.suresh@college.edu','2003-07-25',1,2022
UNION ALL
SELECT 'Rohan','Verma','rohan.verma@college.edu','2002-11-08',2,2021
UNION ALL
SELECT 'Sneha','Patel','sneha.patel@college.edu','2004-01-30',3,2023
UNION ALL
SELECT 'Vikram','Das','vikram.das@college.edu','2003-09-14',1,2022
UNION ALL
SELECT 'Kavya','Menon','kavya.menon@college.edu','2002-05-17',2,2021
UNION ALL
SELECT 'Aditya','Singh','aditya.singh@college.edu','2004-03-22',4,2023
UNION ALL
SELECT 'Deepika','Rao','deepika.rao@college.edu','2003-08-09',1,2022
) AS s
WHERE NOT EXISTS (SELECT 1 FROM students);

-- Courses
INSERT INTO courses(course_name,course_code,credits,department_id)
SELECT * FROM (
SELECT 'Data Structures & Algorithms','CS101',4,1
UNION ALL
SELECT 'Database Management Systems','CS102',3,1
UNION ALL
SELECT 'Object Oriented Programming','CS103',4,1
UNION ALL
SELECT 'Circuit Theory','EC101',3,2
UNION ALL
SELECT 'Thermodynamics','ME101',3,3
) AS c
WHERE NOT EXISTS (SELECT 1 FROM courses);

-- Professors
INSERT INTO professors(prof_name,email,department_id,salary)
SELECT * FROM (
SELECT 'Dr. Anand Krishnan','anand.k@college.edu',1,95000
UNION ALL
SELECT 'Dr. Meena Pillai','meena.p@college.edu',1,88000
UNION ALL
SELECT 'Dr. Sunil Rajan','sunil.r@college.edu',2,82000
UNION ALL
SELECT 'Dr. Latha Gopal','latha.g@college.edu',3,79000
UNION ALL
SELECT 'Dr. Kartik Bose','kartik.b@college.edu',4,76000
) AS p
WHERE NOT EXISTS (SELECT 1 FROM professors);

-- Enrollments
INSERT INTO enrollments(student_id,course_id,enrollment_date,grade)
SELECT * FROM (
SELECT 1,1,'2022-07-01','A'
UNION ALL
SELECT 1,2,'2022-07-01','B'
UNION ALL
SELECT 2,1,'2022-07-01','B'
UNION ALL
SELECT 2,3,'2022-07-01','A'
UNION ALL
SELECT 3,4,'2021-07-01','A'
UNION ALL
SELECT 4,5,'2023-07-01',NULL
UNION ALL
SELECT 5,1,'2022-07-01','C'
UNION ALL
SELECT 5,2,'2022-07-01','A'
UNION ALL
SELECT 6,4,'2021-07-01','B'
UNION ALL
SELECT 7,5,'2023-07-01',NULL
UNION ALL
SELECT 8,1,'2022-07-01','A'
UNION ALL
SELECT 8,3,'2022-07-01','B'
) e
WHERE NOT EXISTS (SELECT 1 FROM enrollments);

-- ===================================================
-- TASK 16
-- ===================================================

INSERT IGNORE INTO students
(first_name,last_name,email,date_of_birth,department_id,enrollment_year)
VALUES
('Rahul','Sharma','rahul.sharma@college.edu','2004-05-12',2,2023),
('Anjali','Reddy','anjali.reddy@college.edu','2003-12-08',1,2022);

-- ===================================================
-- TASK 17
-- ===================================================

UPDATE enrollments
SET grade='B'
WHERE student_id=5
AND course_id=1;

-- ===================================================
-- TASK 18
-- ===================================================

SET SQL_SAFE_UPDATES=0;

DELETE FROM enrollments
WHERE grade IS NULL;

SET SQL_SAFE_UPDATES=1;

-- ===================================================
-- TASK 19
-- ===================================================

SELECT COUNT(*) AS departments FROM departments;

SELECT COUNT(*) AS students FROM students;

SELECT COUNT(*) AS courses FROM courses;

SELECT COUNT(*) AS enrollments FROM enrollments;

SELECT COUNT(*) AS professors FROM professors;

-- ===================================================
-- TASK 20
-- ===================================================

SELECT *
FROM students
WHERE enrollment_year=2022
ORDER BY last_name;

-- ===================================================
-- TASK 21
-- ===================================================

SELECT *
FROM courses
WHERE credits>3
ORDER BY credits DESC;

-- ===================================================
-- TASK 22
-- ===================================================

SELECT *
FROM professors
WHERE salary BETWEEN 80000 AND 95000;

-- ===================================================
-- TASK 23
-- ===================================================

SELECT *
FROM students
WHERE email LIKE '%@college.edu';

-- ===================================================
-- TASK 24
-- ===================================================

SELECT enrollment_year,
COUNT(*) total_students
FROM students
GROUP BY enrollment_year;

-- ===================================================
-- TASK 25
-- ===================================================

SELECT
CONCAT(s.first_name,' ',s.last_name) Student_Name,
d.dept_name
FROM students s
JOIN departments d
ON s.department_id=d.department_id;

-- ===================================================
-- TASK 26
-- ===================================================

SELECT
CONCAT(s.first_name,' ',s.last_name) Student_Name,
c.course_name,
e.grade
FROM enrollments e
JOIN students s
ON e.student_id=s.student_id
JOIN courses c
ON e.course_id=c.course_id;

-- ===================================================
-- TASK 27
-- ===================================================

SELECT
s.student_id,
CONCAT(s.first_name,' ',s.last_name) Student_Name
FROM students s
LEFT JOIN enrollments e
ON s.student_id=e.student_id
WHERE e.student_id IS NULL;

-- ===================================================
-- TASK 28
-- ===================================================

SELECT
c.course_name,
COUNT(e.student_id) total_students
FROM courses c
LEFT JOIN enrollments e
ON c.course_id=e.course_id
GROUP BY c.course_id,c.course_name;

-- ===================================================
-- TASK 29
-- ===================================================

SELECT
d.dept_name,
p.prof_name,
p.salary
FROM departments d
LEFT JOIN professors p
ON d.department_id=p.department_id;

-- ===================================================
-- TASK 30
-- ===================================================

SELECT
c.course_name,
COUNT(e.student_id) enrollment_count
FROM courses c
LEFT JOIN enrollments e
ON c.course_id=e.course_id
GROUP BY c.course_name;

-- ===================================================
-- TASK 31
-- ===================================================

SELECT
d.dept_name,
ROUND(AVG(p.salary),2) average_salary
FROM departments d
LEFT JOIN professors p
ON d.department_id=p.department_id
GROUP BY d.dept_name;

-- ===================================================
-- TASK 32
-- ===================================================

SELECT
dept_name,
budget
FROM departments
WHERE budget>600000;

-- ===================================================
-- TASK 33
-- ===================================================

SELECT
grade,
COUNT(*) grade_count
FROM enrollments e
JOIN courses c
ON e.course_id=c.course_id
WHERE c.course_code='CS101'
GROUP BY grade;

-- ===================================================
-- TASK 34
-- ===================================================

SELECT
d.dept_name,
COUNT(e.student_id) total_enrollments
FROM departments d
JOIN courses c
ON d.department_id=c.department_id
JOIN enrollments e
ON c.course_id=e.course_id
GROUP BY d.dept_name
HAVING COUNT(e.student_id)>2;