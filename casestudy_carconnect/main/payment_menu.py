import sys
import os
sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from dao.payment_dao import PaymentDAO

def main():
    try:
        reservation_id = int(input("Enter Reservation ID: "))
        dao = PaymentDAO()
        payment = dao.get_payment_by_reservation_id(reservation_id)
        
        if payment:
            print(f"✅ Payment found for Reservation {reservation_id}")
            print(f"Amount Paid: ₹{payment.amount}")
            print(f"Payment Date: {payment.payment_date}")
            print(f"Payment Method: {payment.method}")
        else:
            print("⚠️ No payment found for that Reservation ID.")
    
    except Exception as e:
        print("❌ Error:", e)

if __name__ == "__main__":
    main()
