# dao/enrollment_dao.py

from util.db_conn_util import get_connection

class EnrollmentDAO:
    def __init__(self, db_config_path):
        self.conn = get_connection(db_config_path)

    def insert_enrollment(self, enrollment):
        try:
            cursor = self.conn.cursor()
            sql = '''
                INSERT INTO Enrollments (enrollment_id, student_id, course_id, enrollment_date)
                VALUES (?, ?, ?, ?)
            '''
            cursor.execute(sql, (
                enrollment.enrollment_id,
                enrollment.student.student_id,
                enrollment.course.course_id,
                enrollment.enrollment_date
            ))
            self.conn.commit()
            print("✅ Enrollment recorded successfully.")
        except Exception as e:
            print("❌ Failed to insert enrollment:", e)

    def fetch_enrollments_by_course(self, course_id):
        try:
            cursor = self.conn.cursor()
            sql = '''
                SELECT e.enrollment_id, s.first_name, s.last_name, c.course_name, e.enrollment_date
                FROM Enrollments e
                JOIN Students s ON e.student_id = s.student_id
                JOIN Courses c ON e.course_id = c.course_id
                WHERE e.course_id = ?
            '''
            cursor.execute(sql, (course_id,))
            return cursor.fetchall()
        except Exception as e:
            print("❌ Failed to fetch enrollments:", e)
            return []
