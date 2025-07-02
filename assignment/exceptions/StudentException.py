# exceptions/StudentException.py

class StudentException(Exception):
    def __init__(self, message="Student error occurred"):
        super().__init__(message)
