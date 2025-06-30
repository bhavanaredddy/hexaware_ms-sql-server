from dao.user_dao import UserDAO
from dao.company_dao import CompanyDAO
from dao.job_dao import JobDAO
from dao.application_dao import ApplicationDAO

from entity.user import User
from entity.company import Company
from entity.job import Job
from entity.application import Application

from exception.invalid_email_exception import InvalidEmailFormatException
from exception.invalid_salary_exception import InvalidSalaryException
from exception.user_not_found_exception import UserNotFoundException
from exception.company_not_found_exception import CompanyNotFoundException
from exception.job_not_found_exception import JobNotFoundException

from datetime import datetime

def main():
    user_dao = UserDAO()
    company_dao = CompanyDAO()
    job_dao = JobDAO()
    application_dao = ApplicationDAO()

    while True:
        print("\n===== CareerHub Menu =====")
        print("1. Register New User")
        print("2. View All Users")
        print("3. Add Company")
        print("4. View All Companies")
        print("5. Post Job")
        print("6. View All Jobs")
        print("7. Apply for a Job")
        print("8. View All Applications")
        print("0. Exit")

        choice = input("Enter your choice: ")

        if choice == '1':
            name = input("Enter user name: ")
            email = input("Enter email: ")
            try:
                if '@' not in email or '.' not in email.split('@')[-1]:
                    raise InvalidEmailFormatException()
                resume = input("Enter resume summary: ")
                user = User(None, name, email, resume)
                user_dao.insert_user(user)
            except InvalidEmailFormatException as e:
                print(f"❌ {e}")

        elif choice == '2':
            users = user_dao.get_all_users()
            print("\n--- All Users ---")
            for u in users:
                print(f"{u.user_id} | {u.name} | {u.email} | {u.resume}")

        elif choice == '3':
            name = input("Enter company name: ")
            location = input("Enter company location: ")
            company = Company(None, name, location)
            company_dao.insert_company(company)

        elif choice == '4':
            companies = company_dao.get_all_companies()
            print("\n--- All Companies ---")
            for c in companies:
                print(f"{c.company_id} | {c.name} | {c.location}")

        elif choice == '5':
            title = input("Enter job title: ")
            description = input("Enter job description: ")
            company_id = int(input("Enter company ID: "))

            try:
                companies = company_dao.get_all_companies()
                if not any(c.company_id == company_id for c in companies):
                    raise CompanyNotFoundException()

                salary = float(input("Enter salary offered: "))
                if salary < 0:
                    raise InvalidSalaryException()

                posted_date = datetime.now()
                job = Job(None, title, description, company_id, salary, posted_date)
                job_dao.insert_job(job)

            except CompanyNotFoundException as e:
                print(f"❌ {e}")
            except InvalidSalaryException as e:
                print(f"❌ {e}")
            except ValueError:
                print("❌ Please enter a valid numeric salary.")

        elif choice == '6':
            jobs = job_dao.get_all_jobs()
            print("\n--- All Jobs ---")
            for j in jobs:
                print(f"{j.job_id} | {j.title} | {j.description} | Company ID: {j.company_id} | Salary: {j.salary} | Posted: {j.posted_date}")

        elif choice == '7':
            try:
                user_id = int(input("Enter your User ID: "))
                job_id = int(input("Enter the Job ID to apply: "))

                users = user_dao.get_all_users()
                if not any(u.user_id == user_id for u in users):
                    raise UserNotFoundException()

                jobs = job_dao.get_all_jobs()
                if not any(j.job_id == job_id for j in jobs):
                    raise JobNotFoundException()

                application_date = datetime.now()
                status = "Pending"
                app = Application(None, user_id, job_id, application_date, status)
                application_dao.apply_for_job(app)

            except UserNotFoundException as e:
                print(f"❌ {e}")
            except JobNotFoundException as e:
                print(f"❌ {e}")
            except ValueError:
                print("❌ Please enter valid numeric IDs.")

        elif choice == '8':
            apps = application_dao.get_all_applications()
            print("\n--- All Applications ---")
            for a in apps:
                print(f"{a.application_id} | User ID: {a.user_id} | Job ID: {a.job_id} | Date: {a.application_date} | Status: {a.status}")

        elif choice == '0':
            print("👋 Exiting CareerHub. Goodbye!")
            break

        else:
            print("❌ Invalid choice. Try again.")

if __name__ == "__main__":
    main()
