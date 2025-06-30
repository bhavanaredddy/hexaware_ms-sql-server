from dao.customer_dao import CustomerDAO

def main():
    username = input("Enter username: ")
    password = input("Enter password: ")

    dao = CustomerDAO()
    customer = dao.get_customer_by_username(username)

    if customer and customer.authenticate(password):
        print(f"✅ Welcome, {customer.first_name}!")
    else:
        print("❌ Invalid username or password.")

if __name__ == "__main__":
    main()
