import mysql.connector

conn = mysql.connector.connect(
    host="localhost",
    user="root",
    password="Lingesh22@",
    database="college_db"
)

cursor = conn.cursor(dictionary=True)

print("------ N+1 Query Example ------")

cursor.execute("SELECT student_id, first_name FROM students")

students = cursor.fetchall()

for student in students:
    cursor.execute("""
        SELECT c.course_name
        FROM enrollments e
        JOIN courses c
        ON e.course_id=c.course_id
        WHERE e.student_id=%s
    """,(student["student_id"],))

    courses = cursor.fetchall()

    print(student["first_name"], courses)

print("\n------ Optimized JOIN ------")

cursor.execute("""
SELECT
s.first_name,
c.course_name
FROM students s
JOIN enrollments e
ON s.student_id=e.student_id
JOIN courses c
ON c.course_id=e.course_id
ORDER BY s.student_id
""")

rows=cursor.fetchall()

for row in rows:
    print(row)

cursor.close()
conn.close()