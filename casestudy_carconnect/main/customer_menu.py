# main/customer_menu.py

import sys
import os
sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from dao.customer_dao import CustomerDAO
from entity.customer import Customer

def main():
    print("===== Customer Menu =====")
    print("1. Register New Customer")
    print("2. View Customer by Username")
    print("3. Exit")

    dao = CustomerDAO()

    while True:
        choice = input("Enter choice (1-3): ")

        if choice == '1':
            # Simple registration flow
            first = input("First Name: ")
            last = input("Last Name: ")
            email = input("Email: ")
            phone = input("Phone Number: ")
            address = input("Address: ")
            username = input("Username: ")
            password = input("Password: ")

            from datetime import date
            today = date.today()

            customer = Customer(None, first, last, email, phone, address, username, password, today)
            dao.register_customer(customer)

        elif choice == '2':
            uname = input("Enter username: ")
            customer = dao.get_customer_by_username(uname)
            if customer:
                print(f"Customer: {customer.first_name} {customer.last_name}, Email: {customer.email}")
            else:
                print("❌ Customer not found.")
        elif choice == '3':
            print("🔚 Exiting Customer Menu.")
            break
        else:
            print("❌ Invalid choice. Try again.")

if __name__ == "__main__":
    main()
