import pyodbc
from util.db_property_util import get_db_properties

def get_connection(file_path):
    props = get_db_properties(file_path)

    if props.get("trusted_connection", "no").lower() == "yes":
        conn_str = (
            f"DRIVER={props['driver']};"
            f"SERVER={props['server']};"
            f"DATABASE={props['database']};"
            f"Trusted_Connection=yes;"
        )
    else:
        conn_str = (
            f"DRIVER={props['driver']};"
            f"SERVER={props['server']};"
            f"DATABASE={props['database']};"
            f"UID={props['uid']};"
            f"PWD={props['pwd']}"
        )

    try:
        return pyodbc.connect(conn_str)
    except Exception as e:
        print("❌ Connection failed:", e)
        return None
