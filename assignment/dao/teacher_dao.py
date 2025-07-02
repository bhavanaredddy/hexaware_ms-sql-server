# dao/teacher_dao.py

from util.db_conn_util import get_connection

class TeacherDAO:
    def __init__(self, db_config_path):
        self.conn = get_connection(db_config_path)

    def insert_teacher(self, teacher):
        try:
            cursor = self.conn.cursor()
            sql = '''
                INSERT INTO Teachers (teacher_id, first_name, last_name, email, expertise)
                VALUES (?, ?, ?, ?, ?)
            '''
            cursor.execute(sql, (
                teacher.teacher_id,
                teacher.first_name,
                teacher.last_name,
                teacher.email,
                teacher.expertise
            ))
            self.conn.commit()
            print("✅ Teacher inserted successfully.")
        except Exception as e:
            print("❌ Failed to insert teacher:", e)

    def fetch_all_teachers(self):
        try:
            cursor = self.conn.cursor()
            cursor.execute("SELECT * FROM Teachers")
            return cursor.fetchall()
        except Exception as e:
            print("❌ Failed to fetch teachers:", e)
            return []
