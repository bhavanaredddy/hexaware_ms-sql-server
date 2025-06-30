from entity.admin import Admin
from util.db_util import DBUtil

class AdminDAO:
    def get_admin_by_username(self, username):
        conn = DBUtil.get_connection()
        admin = None
        try:
            cursor = conn.cursor()
            cursor.execute("SELECT * FROM Admin WHERE Username = ?", (username,))
            row = cursor.fetchone()
            print("🔍 DB Row:", row)  # Debug print to verify DB values
            if row:
                admin = Admin(
                    admin_id=row[0],
                    first_name=row[1],
                    last_name=row[2],
                    email=row[3],
                    phone=row[4],
                    username=row[5],
                    password=row[6]
                )
        except Exception as e:
            print("❌ Error fetching admin:", e)
        finally:
            if conn:
                conn.close()
        return admin
