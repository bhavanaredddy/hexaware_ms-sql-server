from util.db_util import DBUtil

def main():
    connection = DBUtil.get_connection()
    if connection:
        print("✅ Test successful: Connected to CarConnectDB!")
        connection.close()
    else:
        print("❌ Test failed: Could not connect.")

if __name__ == "__main__":
    main()
