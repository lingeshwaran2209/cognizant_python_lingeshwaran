CREATE DATABASE college_db;
USE college_db;

-- =====================================
-- HANDS-ON 1 : SCHEMA DESIGN & CORE SQL
-- =====================================

CREATE TABLE departments (
    department_id INT AUTO_INCREMENT PRIMARY KEY,
    hod_name VARCHAR(100),
    dept_name VARCHAR(100) NOT NULL,
    budget DECIMAL(12,2)
);
CREATE TABLE students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    date_of_birth DATE,
    department_id INT,
    enrollment_year INT,
    FOREIGN KEY (department_id)
    REFERENCES departments(department_id)
);
CREATE TABLE courses (
    course_id INT AUTO_INCREMENT PRIMARY KEY,
    course_name VARCHAR(150) NOT NULL,
    course_code VARCHAR(20) UNIQUE,
    credits INT,
    department_id INT,
    FOREIGN KEY (department_id)
    REFERENCES departments(department_id)
);
CREATE TABLE enrollments (
    enrollment_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    course_id INT,
    enrollment_date DATE,
    grade CHAR(2),
    FOREIGN KEY (student_id)
    REFERENCES students(student_id),
    FOREIGN KEY (course_id)
    REFERENCES courses(course_id)
);
CREATE TABLE professors (
    professor_id INT AUTO_INCREMENT PRIMARY KEY,
    prof_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    department_id INT,
    salary DECIMAL(10,2),
    FOREIGN KEY (department_id)
    REFERENCES departments(department_id)
);
-- =====================================
-- Task 2: Normalization Analysis
-- =====================================


-- 1NF Analysis
-- All columns contain atomic values.
-- No column stores multiple values in a single field.
-- Example violation: storing multiple phone numbers in one column.

-- 2NF Analysis
-- All non-key attributes depend on the entire primary key.
-- In enrollments, enrollment_date and grade depend on the student-course enrollment.

-- 3NF Analysis
-- No transitive dependencies exist.
-- Department details are stored in departments table.
-- Students reference departments using department_id.
-- Therefore the schema satisfies 3NF.

-- =====================================
-- Task 3: ALTER TABLE Operations
-- =====================================
ALTER TABLE students
ADD phone_number VARCHAR(15);

ALTER TABLE courses
ADD max_seats INT DEFAULT 60;

ALTER TABLE enrollments
ADD CONSTRAINT chk_grade
CHECK (grade IN ('A','B','C','D','F') OR grade IS NULL);

ALTER TABLE departments
RENAME COLUMN hod_name TO head_of_dept;

ALTER TABLE students
DROP COLUMN phone_number;

-- =====================================
-- Verification Queries
-- =====================================
SHOW TABLES;
DESCRIBE departments;
DESCRIBE students;
DESCRIBE courses;
DESCRIBE enrollments;
DESCRIBE professors;