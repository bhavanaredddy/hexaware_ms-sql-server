

class Course:
    def __init__(self, course_id, course_name, course_code, instructor=None):
        self.course_id = course_id
        self.course_name = course_name
        self.course_code = course_code
        self.instructor = instructor    # Teacher object
        self.enrollments = []           # List of Enrollment objects

    def assign_teacher(self, teacher):
        self.instructor = teacher

    def update_course_info(self, course_code, course_name, instructor=None):
        self.course_code = course_code
        self.course_name = course_name
        if instructor:
            self.instructor = instructor

    def display_info(self):
        print(f"Course ID: {self.course_id}")
        print(f"Course Name: {self.course_name}")
        print(f"Course Code: {self.course_code}")
        if self.instructor:
            print(f"Instructor: {self.instructor.first_name} {self.instructor.last_name}")
        else:
            print("Instructor: Not Assigned")

    def get_enrollments(self):
        return self.enrollments

    def get_teacher(self):
        return self.instructor
