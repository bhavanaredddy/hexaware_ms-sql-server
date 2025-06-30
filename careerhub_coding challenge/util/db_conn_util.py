import pyodbc
from util.db_property_util import get_connection_string

def get_connection(file_path):
    try:
        conn_str = get_connection_string(file_path)
        if not conn_str:
            raise Exception("Connection string not found.")
        conn = pyodbc.connect(conn_str)
        return conn
    except Exception as e:
        print("❌ Database connection error:", e)
        return None
