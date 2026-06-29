USE college_db;

-- =============================================
-- HANDS-ON 4
-- Query Optimization and Performance
-- =============================================

-- =============================================
-- Task 48
-- Display all students
-- =============================================

SELECT * FROM students;

-- =============================================
-- Task 49
-- Find student using email
-- =============================================

SELECT *
FROM students
WHERE email='arjun.mehta@college.edu';

-- =============================================
-- Task 50
-- Create index on email
-- =============================================

CREATE INDEX idx_students_email
ON students(email);

-- =============================================
-- Task 51
-- Verify index usage
-- =============================================

EXPLAIN
SELECT *
FROM students
WHERE email='arjun.mehta@college.edu';

-- =============================================
-- Task 52
-- Create composite index
-- =============================================

CREATE INDEX idx_student_department_year
ON students(department_id,enrollment_year);

-- =============================================
-- Task 53
-- Query using composite index
-- =============================================

EXPLAIN
SELECT *
FROM students
WHERE department_id=1
AND enrollment_year=2022;

-- =============================================
-- Task 54
-- Index for courses
-- =============================================

CREATE INDEX idx_course_department
ON courses(department_id);

-- =============================================
-- Task 55
-- Explain Join
-- =============================================

EXPLAIN
SELECT
s.first_name,
c.course_name
FROM students s
JOIN enrollments e
ON s.student_id=e.student_id
JOIN courses c
ON c.course_id=e.course_id;

-- =============================================
-- Task 56
-- Count enrollments by course
-- =============================================

EXPLAIN
SELECT
course_id,
COUNT(*)
FROM enrollments
GROUP BY course_id;

-- =============================================
-- Task 57
-- Show indexes
-- =============================================

SHOW INDEX
FROM students;

SHOW INDEX
FROM courses;

-- =============================================
-- Task 58
-- Drop unused index
-- =============================================

DROP INDEX idx_course_department
ON courses;

-- =============================================
-- Task 59
-- Verify execution plan
-- =============================================

EXPLAIN
SELECT *
FROM students
WHERE department_id=1
AND enrollment_year=2022;