# dao/payment_dao.py

from util.db_conn_util import get_connection
from exceptions.PaymentException import PaymentException  # ✅ Import custom exception

class PaymentDAO:
    def __init__(self, db_config_path):
        self.conn = get_connection(db_config_path)

    def insert_payment(self, payment):
        try:
            cursor = self.conn.cursor()
            sql = '''
                INSERT INTO Payments (payment_id, student_id, amount, payment_date)
                VALUES (?, ?, ?, ?)
            '''
            cursor.execute(sql, (
                payment.payment_id,
                payment.student.student_id,
                payment.amount,
                payment.payment_date
            ))
            self.conn.commit()
            print("✅ Payment recorded successfully.")
        except Exception as e:
            raise PaymentException(f"❌ Failed to insert payment: {e}")  # ✅ Raise exception

    def fetch_payments_by_student(self, student_id):
        try:
            cursor = self.conn.cursor()
            sql = '''
                SELECT payment_id, amount, payment_date
                FROM Payments
                WHERE student_id = ?
            '''
            cursor.execute(sql, (student_id,))
            return cursor.fetchall()
        except Exception as e:
            raise PaymentException(f"❌ Failed to fetch payments: {e}")  # ✅ Raise exception
