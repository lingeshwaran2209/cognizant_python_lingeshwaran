USE college_db;

-- ===========================================
-- HANDS-ON 3
-- Task 1: Subqueries
-- ===========================================

-- ===========================================
-- Task 35
-- Students enrolled in more courses than the
-- average number of enrollments per student
-- ===========================================

SELECT
    s.student_id,
    CONCAT(s.first_name,' ',s.last_name) AS student_name,
    COUNT(e.course_id) AS total_courses
FROM students s
JOIN enrollments e
ON s.student_id = e.student_id
GROUP BY s.student_id, s.first_name, s.last_name
HAVING COUNT(e.course_id) >
(
    SELECT AVG(course_count)
    FROM
    (
        SELECT COUNT(*) AS course_count
        FROM enrollments
        GROUP BY student_id
    ) AS avg_table
);

-- ===========================================
-- Task 36
-- Courses where every student scored A
-- ===========================================

SELECT
    c.course_name,
    c.course_code
FROM courses c
WHERE NOT EXISTS
(
    SELECT *
    FROM enrollments e
    WHERE e.course_id = c.course_id
      AND e.grade <> 'A'
);

-- ===========================================
-- Task 37
-- Highest-paid professor in each department
-- ===========================================

SELECT
    p.prof_name,
    d.dept_name,
    p.salary
FROM professors p
JOIN departments d
ON p.department_id = d.department_id
WHERE p.salary =
(
    SELECT MAX(p2.salary)
    FROM professors p2
    WHERE p2.department_id = p.department_id
);

-- ===========================================
-- Task 38
-- Departments whose average professor salary
-- exceeds 85000
-- ===========================================

SELECT *
FROM
(
    SELECT
        d.dept_name,
        AVG(p.salary) AS avg_salary
    FROM departments d
    JOIN professors p
    ON d.department_id = p.department_id
    GROUP BY d.dept_name
) AS salary_table
WHERE avg_salary > 85000;
-- ===========================================
-- HANDS-ON 3
-- Part 2 : Views
-- ===========================================

-- ===========================================
-- Task 39
-- Create Student Enrollment Summary View
-- ===========================================

DROP VIEW IF EXISTS vw_student_enrollment_summary;

CREATE VIEW vw_student_enrollment_summary AS
SELECT
    s.student_id,
    CONCAT(s.first_name,' ',s.last_name) AS student_name,
    d.dept_name,
    COUNT(e.course_id) AS total_courses,
    ROUND(
        AVG(
            CASE
                WHEN e.grade='A' THEN 4
                WHEN e.grade='B' THEN 3
                WHEN e.grade='C' THEN 2
                WHEN e.grade='D' THEN 1
                WHEN e.grade='F' THEN 0
                ELSE NULL
            END
        ),2
    ) AS gpa
FROM students s
LEFT JOIN departments d
ON s.department_id=d.department_id
LEFT JOIN enrollments e
ON s.student_id=e.student_id
GROUP BY
s.student_id,
student_name,
d.dept_name;

-- View Output
SELECT * FROM vw_student_enrollment_summary;

-- ===========================================
-- Task 40
-- Create Course Statistics View
-- ===========================================

DROP VIEW IF EXISTS vw_course_stats;

CREATE VIEW vw_course_stats AS
SELECT
    c.course_name,
    c.course_code,
    COUNT(e.student_id) AS total_enrollments,
    ROUND(
        AVG(
            CASE
                WHEN e.grade='A' THEN 4
                WHEN e.grade='B' THEN 3
                WHEN e.grade='C' THEN 2
                WHEN e.grade='D' THEN 1
                WHEN e.grade='F' THEN 0
                ELSE NULL
            END
        ),2
    ) AS avg_gpa
FROM courses c
LEFT JOIN enrollments e
ON c.course_id=e.course_id
GROUP BY
c.course_id,
c.course_name,
c.course_code;

-- View Output
SELECT * FROM vw_course_stats;

-- ===========================================
-- Task 41
-- Students having GPA greater than 3
-- ===========================================

SELECT *
FROM vw_student_enrollment_summary
WHERE gpa > 3;

-- ===========================================
-- Task 42
-- Attempt UPDATE through View
-- ===========================================

UPDATE vw_student_enrollment_summary
SET student_name='Test Student'
WHERE student_id=1;

-- Expected:
-- ERROR 1288:
-- The target table of the UPDATE is not updatable
--
-- Reason:
-- This view uses GROUP BY and JOIN.
-- Multi-table aggregated views are not updatable in MySQL.

-- ===========================================
-- Task 43
-- Drop both views
-- ===========================================

DROP VIEW IF EXISTS vw_course_stats;
DROP VIEW IF EXISTS vw_student_enrollment_summary;

-- ===========================================
-- Recreate a Single Table View WITH CHECK OPTION
-- ===========================================

CREATE VIEW vw_student_enrollment_summary AS
SELECT
    student_id,
    first_name,
    last_name,
    enrollment_year
FROM students
WHERE enrollment_year >= 2022
WITH CHECK OPTION;

-- Verify

SELECT *
FROM vw_student_enrollment_summary;
-- ===========================================
-- HANDS-ON 3
-- Part 3 : Stored Procedures & Transactions
-- ===========================================

-- ===========================================
-- Task 44
-- Stored Procedure:
-- Get students by department
-- ===========================================

DROP PROCEDURE IF EXISTS GetStudentsByDepartment;

DELIMITER $$

CREATE PROCEDURE GetStudentsByDepartment(IN deptId INT)
BEGIN
    SELECT
        s.student_id,
        CONCAT(s.first_name,' ',s.last_name) AS student_name,
        d.dept_name,
        s.enrollment_year
    FROM students s
    JOIN departments d
        ON s.department_id = d.department_id
    WHERE s.department_id = deptId;
END $$

DELIMITER ;

-- Execute Procedure

CALL GetStudentsByDepartment(1);

-- ===========================================
-- Task 45
-- Transaction Example
-- ===========================================

START TRANSACTION;

UPDATE professors
SET salary = salary + 5000
WHERE department_id = 1;

UPDATE departments
SET budget = budget - 10000
WHERE department_id = 1;

COMMIT;

-- Verify

SELECT * FROM professors
WHERE department_id = 1;

SELECT * FROM departments
WHERE department_id = 1;

-- ===========================================
-- Task 46
-- Rollback Example
-- ===========================================

START TRANSACTION;

UPDATE professors
SET salary = salary + 10000
WHERE professor_id = 1;

SELECT * FROM professors
WHERE professor_id = 1;

ROLLBACK;

-- Verify rollback

SELECT * FROM professors
WHERE professor_id = 1;

-- ===========================================
-- Task 47
-- Savepoint Example
-- ===========================================

START TRANSACTION;

UPDATE professors
SET salary = salary + 2000
WHERE professor_id = 2;

SAVEPOINT salary_updated;

UPDATE departments
SET budget = budget - 5000
WHERE department_id = 2;

ROLLBACK TO salary_updated;

COMMIT;

-- Verify

SELECT * FROM professors
WHERE professor_id = 2;

SELECT * FROM departments
WHERE department_id = 2;