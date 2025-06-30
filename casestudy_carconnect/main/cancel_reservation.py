from dao.reservation_dao import ReservationDAO

def main():
    try:
        reservation_id = int(input("Enter Reservation ID to cancel: "))
        dao = ReservationDAO()
        dao.cancel_reservation(reservation_id)
    except Exception as e:
        print("❌ Error:", e)

if __name__ == "__main__":
    main()
