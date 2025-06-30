import pyodbc

class DBUtil:
    @staticmethod
    def get_connection():
        try:
            connection = pyodbc.connect(
                'DRIVER={ODBC Driver 17 for SQL Server};'
                'SERVER=SAIBHAVANA\\SQLEXPRESS;'
                'DATABASE=CarConnectDB;'
                'Trusted_Connection=yes;'
            )
            print("✅ Connected to database successfully.")
            return connection
        except Exception as e:
            print("❌ Database connection failed:", e)
            return None
