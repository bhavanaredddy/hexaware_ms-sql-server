from util.db_conn_util import get_connection

if __name__ == "__main__":
    conn = get_connection("db.properties")
    if conn:
        print("✅ Database connection successful!")
        conn.close()
    else:
        print("❌ Connection failed.")
