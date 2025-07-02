# dao/student_dao.py

from util.db_conn_util import get_connection
from exceptions.StudentException import StudentException  # ✅ NEW

class StudentDAO:
    def __init__(self, db_config_path):
        self.conn = get_connection(db_config_path)

    def insert_student(self, student):
        try:
            cursor = self.conn.cursor()
            sql = '''
                INSERT INTO Students (student_id, first_name, last_name, date_of_birth, email, phone_number)
                VALUES (?, ?, ?, ?, ?, ?)
            '''
            cursor.execute(sql, (
                student.student_id,
                student.first_name,
                student.last_name,
                student.date_of_birth,
                student.email,
                student.phone_number
            ))
            self.conn.commit()
            print("✅ Student inserted successfully.")
        except Exception as e:
            raise StudentException(f"❌ Failed to insert student: {e}")  # ✅ raise instead of print

    def fetch_all_students(self):
        try:
            cursor = self.conn.cursor()
            cursor.execute("SELECT * FROM Students")
            return cursor.fetchall()
        except Exception as e:
            raise StudentException(f"❌ Failed to fetch students: {e}")  # ✅ raise exception
