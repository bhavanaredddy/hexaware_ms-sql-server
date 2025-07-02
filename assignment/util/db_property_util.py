def get_db_properties(file_path):
    props = {}
    with open(file_path, 'r') as f:
        for line in f:
            if '=' in line:
                key, value = line.strip().split('=', 1)
                props[key.strip()] = value.strip()
    return props
