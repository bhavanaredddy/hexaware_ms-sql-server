def get_connection_string(file_name):
    try:
        with open(file_name, 'r') as file:
            for line in file:
                if line.strip().startswith("connectionString="):
                    return line.strip().split("=", 1)[1]
    except Exception as e:
        print("Error reading db.properties:", e)
        return None
