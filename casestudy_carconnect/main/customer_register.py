from dao.customer_dao import CustomerDAO
from entity.customer import Customer
from datetime import datetime
from util.db_util import DBUtil

def main():
    try:
        customer = Customer(
            first_name=input("First Name: "),
            last_name=input("Last Name: "),
            email=input("Email: "),
            phone_number=input("Phone Number: "),
            address=input("Address: "),
            username=input("Username (must be unique): "),
            password=input("Password: "),
            registration_date=datetime.now()
        )

        dao = CustomerDAO()
        dao.register_customer(customer)

    except Exception as e:
        print("❌ Error registering customer:", e)

if __name__ == "__main__":
    main()
