# dao/course_dao.py

from util.db_conn_util import get_connection
from exceptions.CourseException import CourseException  # ✅ Import custom exception

class CourseDAO:
    def __init__(self, db_config_path):
        self.conn = get_connection(db_config_path)

    def insert_course(self, course):
        try:
            cursor = self.conn.cursor()
            sql = '''
                INSERT INTO Courses (course_id, course_name, course_code, teacher_id)
                VALUES (?, ?, ?, ?)
            '''
            cursor.execute(sql, (
                course.course_id,
                course.course_name,
                course.course_code,
                course.instructor.teacher_id if course.instructor else None
            ))
            self.conn.commit()
            print("✅ Course inserted successfully.")
        except Exception as e:
            raise CourseException(f"❌ Failed to insert course: {e}")  # ✅ Raise exception

    def fetch_all_courses(self):
        try:
            cursor = self.conn.cursor()
            cursor.execute("SELECT * FROM Courses")
            return cursor.fetchall()
        except Exception as e:
            raise CourseException(f"❌ Failed to fetch courses: {e}")  # ✅ Raise exception

    def assign_teacher(self, course_id, teacher_id):
        try:
            cursor = self.conn.cursor()
            sql = "UPDATE Courses SET teacher_id = ? WHERE course_id = ?"
            cursor.execute(sql, (teacher_id, course_id))
            self.conn.commit()
            print("✅ Teacher assigned to course.")
        except Exception as e:
            raise CourseException(f"❌ Failed to assign teacher: {e}")  # ✅ Raise exception
