"""
Hands-On 6
Task 87-90 (N+1 Problem)

Without joinedload():
- SQLAlchemy executes multiple queries (N+1 problem).

With joinedload():
- SQLAlchemy fetches Enrollment, Student and Course
  in a single SQL query using JOIN.
"""

from datetime import date
from sqlalchemy import create_engine
from sqlalchemy.engine import URL
from sqlalchemy.orm import sessionmaker, joinedload

from models import Department, Student, Course, Enrollment

# Database Connection
url = URL.create(
    drivername="mysql+mysqlconnector",
    username="root",
    password="Lingesh22@",
    host="localhost",
    port=3306,
    database="college_db_orm"
)

engine = create_engine(url, echo=True)

Session = sessionmaker(bind=engine)
session = Session()

# -----------------------------
# Task 81 - Insert Departments
# -----------------------------
dept1 = Department(
    dept_name="Computer Science",
    head_of_dept="Dr. Ramesh Kumar",
    budget=850000
)

dept2 = Department(
    dept_name="Electronics",
    head_of_dept="Dr. Priya Nair",
    budget=620000
)

dept3 = Department(
    dept_name="Mechanical",
    head_of_dept="Dr. Suresh Iyer",
    budget=540000
)

session.add_all([dept1, dept2, dept3])
session.commit()

print("Departments Inserted")

# -----------------------------
# Task 81 - Insert Students
# -----------------------------
students = [

Student(
first_name="Arjun",
last_name="Mehta",
email="arjun@gmail.com",
date_of_birth=date(2003,4,12),
department=dept1,
enrollment_year=2022
),

Student(
first_name="Priya",
last_name="Suresh",
email="priya@gmail.com",
date_of_birth=date(2003,7,25),
department=dept1,
enrollment_year=2022
),

Student(
first_name="Rohan",
last_name="Verma",
email="rohan@gmail.com",
date_of_birth=date(2002,11,8),
department=dept2,
enrollment_year=2021
),

Student(
first_name="Sneha",
last_name="Patel",
email="sneha@gmail.com",
date_of_birth=date(2004,1,30),
department=dept3,
enrollment_year=2023
),

Student(
first_name="Vikram",
last_name="Das",
email="vikram@gmail.com",
date_of_birth=date(2003,9,14),
department=dept1,
enrollment_year=2022
)

]

session.add_all(students)
session.commit()

print("Students Inserted")

# -----------------------------
# Task 82 - Insert Courses
# -----------------------------
course1 = Course(
course_name="Database Systems",
course_code="CS101",
credits=4,
department_id=1
)

course2 = Course(
course_name="Python Programming",
course_code="CS102",
credits=3,
department_id=1
)

course3 = Course(
course_name="Operating Systems",
course_code="CS103",
credits=4,
department_id=1
)

session.add_all([course1,course2,course3])
session.commit()

print("Courses Inserted")

# -----------------------------
# Task 82 - Insert Enrollments
# -----------------------------
enrollments=[

Enrollment(
student_id=1,
course_id=1,
enrollment_date=date.today(),
grade="A"
),

Enrollment(
student_id=2,
course_id=2,
enrollment_date=date.today(),
grade="B"
),

Enrollment(
student_id=3,
course_id=3,
enrollment_date=date.today(),
grade="A"
),

Enrollment(
student_id=4,
course_id=1,
enrollment_date=date.today(),
grade="C"
)

]

session.add_all(enrollments)
session.commit()

print("Enrollments Inserted")

# -----------------------------
# Task 83
# -----------------------------
print("\nStudents in Computer Science")

result=session.query(Student)\
.join(Department)\
.filter(
Department.dept_name=="Computer Science"
).all()

for s in result:
    print(s.first_name,s.last_name)

# -----------------------------
# Task 84
# -----------------------------
print("\nEnrollment Details")

enrollments=session.query(Enrollment).all()

for e in enrollments:
    print(
        e.student.first_name,
        "->",
        e.course.course_name
    )

# -----------------------------
# Task 85
# -----------------------------
student=session.query(Student)\
.filter_by(email="arjun@gmail.com")\
.first()

student.enrollment_year=2024

session.commit()

print("Student Updated")

# -----------------------------
# Task 86
# -----------------------------
record=session.query(Enrollment).first()

session.delete(record)

session.commit()

print("Enrollment Deleted")

# -----------------------------
# Task 88-90
# -----------------------------
print("\nUsing joinedload")

records=session.query(Enrollment).options(

joinedload(Enrollment.student),
joinedload(Enrollment.course)

).all()

for r in records:

    print(
        r.student.first_name,
        r.course.course_name,
        r.grade
    )

session.close()

print("\nHands-On 6 Completed Successfully")