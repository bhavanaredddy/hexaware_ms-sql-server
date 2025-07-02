

class Teacher:
    def __init__(self, teacher_id, first_name, last_name, email, expertise=None):
        self.teacher_id = teacher_id
        self.first_name = first_name
        self.last_name = last_name
        self.email = email
        self.expertise = expertise
        self.assigned_courses = []  # List of Course objects

    def update_info(self, first_name, last_name, email, expertise=None):
        self.first_name = first_name
        self.last_name = last_name
        self.email = email
        self.expertise = expertise

    def display_info(self):
        print(f"Teacher ID: {self.teacher_id}")
        print(f"Name: {self.first_name} {self.last_name}")
        print(f"Email: {self.email}")
        print(f"Expertise: {self.expertise if self.expertise else 'N/A'}")

    def get_assigned_courses(self):
        return self.assigned_courses

    def assign_course(self, course):
        self.assigned_courses.append(course)
