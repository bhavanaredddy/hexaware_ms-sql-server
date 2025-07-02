# entity/student.py

from datetime import date

class Student:
    def __init__(self, student_id, first_name, last_name, date_of_birth, email, phone_number):
        self.student_id = student_id
        self.first_name = first_name
        self.last_name = last_name
        self.date_of_birth = date_of_birth
        self.email = email
        self.phone_number = phone_number
        self.enrollments = []      # list of Enrollment objects
        self.payments = []         # list of Payment objects

    def enroll_in_course(self, enrollment):
        self.enrollments.append(enrollment)

    def make_payment(self, payment):
        self.payments.append(payment)

    def update_info(self, first_name, last_name, date_of_birth, email, phone_number):
        self.first_name = first_name
        self.last_name = last_name
        self.date_of_birth = date_of_birth
        self.email = email
        self.phone_number = phone_number

    def display_info(self):
        print(f"ID: {self.student_id}")
        print(f"Name: {self.first_name} {self.last_name}")
        print(f"DOB: {self.date_of_birth}")
        print(f"Email: {self.email}")
        print(f"Phone: {self.phone_number}")

    def get_enrolled_courses(self):
        return [en.course for en in self.enrollments]

    def get_payment_history(self):
        return self.payments
