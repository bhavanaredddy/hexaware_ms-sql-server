# exceptions/CourseException.py

class CourseException(Exception):
    def __init__(self, message="Course error occurred"):
        super().__init__(message)
