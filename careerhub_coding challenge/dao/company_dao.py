import pyodbc
from util.db_conn_util import get_connection
from entity.company import Company  # ✅ correct

class CompanyDAO:
    def __init__(self):
        self.conn = get_connection("config/db.properties")

    def insert_company(self, company):
        try:
            cursor = self.conn.cursor()
            sql = "INSERT INTO Companies (name, location) VALUES (?, ?)"
            cursor.execute(sql, (company.name, company.location))
            self.conn.commit()
            print("✅ Company inserted successfully")
        except Exception as e:
            print("❌ Error inserting company:", e)

    def get_all_companies(self):
        try:
            cursor = self.conn.cursor()
            cursor.execute("SELECT * FROM Companies")
            rows = cursor.fetchall()
            companies = []
            for row in rows:
                companies.append(Company(row[0], row[1], row[2]))
            return companies
        except Exception as e:
            print("❌ Error fetching companies:", e)
            return []
