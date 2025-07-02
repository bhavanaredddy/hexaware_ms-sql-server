
class Enrollment:
    def __init__(self, enrollment_id, student, course, enrollment_date):
        self.enrollment_id = enrollment_id
        self.student = student          # Student object
        self.course = course            # Course object
        self.enrollment_date = enrollment_date

    def get_student(self):
        return self.student

    def get_course(self):
        return self.course

    def display_info(self):
        print(f"Enrollment ID: {self.enrollment_id}")
        print(f"Student: {self.student.first_name} {self.student.last_name}")
        print(f"Course: {self.course.course_name}")
        print(f"Date: {self.enrollment_date}")
