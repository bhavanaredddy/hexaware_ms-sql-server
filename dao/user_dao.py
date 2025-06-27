import pyodbc
from util.db_conn_util import get_connection
from entity.user import User

class UserDAO:
    def __init__(self):
        self.conn = get_connection("config/db.properties")

    def insert_user(self, user):
        try:
            cursor = self.conn.cursor()

            # ✅ Check if the email already exists
            cursor.execute("SELECT COUNT(*) FROM Users WHERE email = ?", (user.email,))
            count = cursor.fetchone()[0]

            if count > 0:
                print(f"⚠️ Email '{user.email}' already exists. User not inserted.")
                return

            # ✅ Insert the user if email is unique
            sql = "INSERT INTO Users (name, email, resume) VALUES (?, ?, ?)"
            cursor.execute(sql, (user.name, user.email, user.resume))
            self.conn.commit()
            print("✅ User inserted successfully")

        except Exception as e:
            print("❌ Error inserting user:", e)

    def get_all_users(self):
        try:
            cursor = self.conn.cursor()
            cursor.execute("SELECT * FROM Users")
            rows = cursor.fetchall()
            users = []
            for row in rows:
                users.append(User(row[0], row[1], row[2], row[3]))
            return users
        except Exception as e:
            print("❌ Error fetching users:", e)
            return []
