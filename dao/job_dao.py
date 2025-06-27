import pyodbc
from util.db_conn_util import get_connection
from entity.job import Job

class JobDAO:
    def __init__(self):
        self.conn = get_connection("config/db.properties")

    def insert_job(self, job):
        try:
            cursor = self.conn.cursor()
            sql = """
                INSERT INTO Jobs (title, description, company_id, posted_date, salary)
                VALUES (?, ?, ?, ?, ?)
            """
            cursor.execute(sql, (
                job.title,
                job.description,
                job.company_id,
                job.posted_date,
                job.salary
            ))
            self.conn.commit()
            print("✅ Job posted successfully")
        except Exception as e:
            print("❌ Error posting job:", e)

    def get_all_jobs(self):
        try:
            cursor = self.conn.cursor()
            cursor.execute("SELECT * FROM Jobs")
            rows = cursor.fetchall()
            jobs = []
            for row in rows:
                jobs.append(Job(
                    job_id=row[0],
                    title=row[1],
                    description=row[2],
                    company_id=row[3],
                    salary=row[5],
                    posted_date=row[4]
                ))
            return jobs
        except Exception as e:
            print("❌ Error fetching jobs:", e)
            return []
