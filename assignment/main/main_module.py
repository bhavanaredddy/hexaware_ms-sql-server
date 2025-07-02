# main/main_module.py

from dao.student_dao import StudentDAO
from dao.course_dao import CourseDAO
from dao.teacher_dao import TeacherDAO
from dao.enrollment_dao import EnrollmentDAO
from dao.payment_dao import PaymentDAO

from entity.student import Student
from entity.teacher import Teacher
from entity.course import Course
from entity.enrollment import Enrollment
from entity.payment import Payment

from exceptions.StudentException import StudentException  # ✅ Imported

def main():
    db_path = "db.properties"

    student_dao = StudentDAO(db_path)
    teacher_dao = TeacherDAO(db_path)
    course_dao = CourseDAO(db_path)
    enrollment_dao = EnrollmentDAO(db_path)
    payment_dao = PaymentDAO(db_path)

    while True:
        print("\n===== Student Information System =====")
        print("1. Add Student")
        print("2. Add Teacher")
        print("3. Add Course")
        print("4. Enroll Student in Course")
        print("5. Record Payment")
        print("6. Show All Students")
        print("7. Show All Courses")
        print("8. Show Enrollments for Course")
        print("9. Show Payments for Student")
        print("0. Exit")

        choice = input("Enter your choice: ")

        if choice == '1':
            sid = int(input("Student ID: "))
            fname = input("First Name: ")
            lname = input("Last Name: ")
            dob = input("Date of Birth (YYYY-MM-DD): ")
            email = input("Email: ")
            phone = input("Phone: ")
            student = Student(sid, fname, lname, dob, email, phone)
            try:
                student_dao.insert_student(student)
            except StudentException as e:
                print(e)

        elif choice == '2':
            tid = int(input("Teacher ID: "))
            fname = input("First Name: ")
            lname = input("Last Name: ")
            email = input("Email: ")
            expertise = input("Expertise: ")
            teacher = Teacher(tid, fname, lname, email, expertise)
            teacher_dao.insert_teacher(teacher)

        elif choice == '3':
            cid = int(input("Course ID: "))
            cname = input("Course Name: ")
            ccode = input("Course Code: ")
            tid = int(input("Teacher ID (optional, enter 0 if none): "))
            teacher = Teacher(tid, "", "", "", "") if tid != 0 else None
            course = Course(cid, cname, ccode, teacher)
            course_dao.insert_course(course)

        elif choice == '4':
            eid = int(input("Enrollment ID: "))
            sid = int(input("Student ID: "))
            cid = int(input("Course ID: "))
            date = input("Enrollment Date (YYYY-MM-DD): ")
            student = Student(sid, "", "", "", "", "")
            course = Course(cid, "", "", None)
            enrollment = Enrollment(eid, student, course, date)
            enrollment_dao.insert_enrollment(enrollment)

        elif choice == '5':
            pid = int(input("Payment ID: "))
            sid = int(input("Student ID: "))
            amount = float(input("Amount: "))
            date = input("Payment Date (YYYY-MM-DD): ")
            student = Student(sid, "", "", "", "", "")
            payment = Payment(pid, student, amount, date)
            payment_dao.insert_payment(payment)

        elif choice == '6':
            try:
                for row in student_dao.fetch_all_students():
                    print(row)
            except StudentException as e:
                print(e)

        elif choice == '7':
            for row in course_dao.fetch_all_courses():
                print(row)

        elif choice == '8':
            cid = int(input("Enter Course ID: "))
            for row in enrollment_dao.fetch_enrollments_by_course(cid):
                print(row)

        elif choice == '9':
            sid = int(input("Enter Student ID: "))
            for row in payment_dao.fetch_payments_by_student(sid):
                print(row)

        elif choice == '0':
            print("Exiting program.")
            break

        else:
            print("❌ Invalid choice, try again.")

if __name__ == "__main__":
    main()
