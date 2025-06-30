from util.db_util import DBUtil
from entity.payment import Payment

class PaymentDAO:
    def get_payment_by_reservation_id(self, reservation_id):
        conn = DBUtil.get_connection()
        payment = None
        try:
            cursor = conn.cursor()
            cursor.execute("SELECT * FROM dbo.Payment WHERE ReservationID = ?", (reservation_id,))
            row = cursor.fetchone()
            if row:
                payment = Payment(*row)
        except Exception as e:
            print("❌ Error fetching payment:", e)
        finally:
            if conn:
                conn.close()
        return payment
