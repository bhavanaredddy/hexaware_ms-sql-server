import pyodbc
from util.db_conn_util import get_connection
from entity.application import Application

class ApplicationDAO:
    def __init__(self):
        self.conn = get_connection("config/db.properties")

    def apply_for_job(self, application):
        try:
            cursor = self.conn.cursor()
            sql = "INSERT INTO Applications (user_id, job_id, application_date, status) VALUES (?, ?, ?, ?)"
            cursor.execute(sql, (application.user_id, application.job_id, application.application_date, application.status))
            self.conn.commit()
            print("✅ Application submitted successfully")
        except Exception as e:
            print("❌ Error applying for job:", e)

    def get_all_applications(self):
        try:
            cursor = self.conn.cursor()
            cursor.execute("SELECT * FROM Applications")
            rows = cursor.fetchall()
            applications = []
            for row in rows:
                applications.append(Application(row[0], row[1], row[2], row[3], row[4]))
            return applications
        except Exception as e:
            print("❌ Error fetching applications:", e)
            return []
