from util.db_util import DBUtil
from entity.customer import Customer
from exceptions.customer_exception import CustomerException

class CustomerDAO:
    def register_customer(self, customer):
        conn = DBUtil.get_connection()
        try:
            cursor = conn.cursor()
            query = '''
                INSERT INTO Customer 
                (FirstName, LastName, Email, PhoneNumber, Address, Username, Password, RegistrationDate)
                VALUES (?, ?, ?, ?, ?, ?, ?, ?)
            '''
            cursor.execute(query, (
                customer.first_name,
                customer.last_name,
                customer.email,
                customer.phone_number,
                customer.address,
                customer.username,
                customer.password,
                customer.registration_date
            ))
            conn.commit()
            print("✅ Customer registered successfully.")
        except Exception as e:
            print("❌ Error registering customer:", e)
        finally:
            if conn:
                conn.close()

    def get_customer_by_username(self, username):
        conn = DBUtil.get_connection()
        customer = None
        try:
            cursor = conn.cursor()
            query = "SELECT * FROM Customer WHERE Username = ?"
            cursor.execute(query, (username,))
            row = cursor.fetchone()
            if row:
                customer = Customer(
                    customer_id=row[0],
                    first_name=row[1],
                    last_name=row[2],
                    email=row[3],
                    phone_number=row[4],
                    address=row[5],
                    username=row[6],
                    password=row[7],
                    registration_date=row[8]
                )
        except Exception as e:
            print("❌ Error fetching customer:", e)
        finally:
            if conn:
                conn.close()
        return customer

    def get_all_customers(self):
        conn = DBUtil.get_connection()
        customers = []
        try:
            cursor = conn.cursor()
            cursor.execute("SELECT * FROM Customer")
            rows = cursor.fetchall()
            for row in rows:
                customers.append(Customer(
                    customer_id=row[0],
                    first_name=row[1],
                    last_name=row[2],
                    email=row[3],
                    phone_number=row[4],
                    address=row[5],
                    username=row[6],
                    password=row[7],
                    registration_date=row[8]
                ))
        except Exception as e:
            print("❌ Error fetching customers:", e)
        finally:
            if conn:
                conn.close()
        return customers
