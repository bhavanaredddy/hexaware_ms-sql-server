from dao.reservation_dao import ReservationDAO
from entity.reservation import Reservation
from datetime import datetime

def book_reservation():
    try:
        customer_id = int(input("Enter your Customer ID: "))
        vehicle_id = int(input("Enter Vehicle ID to reserve: "))

        start_date_str = input("Enter Start Date (YYYY-MM-DD): ")
        end_date_str = input("Enter End Date (YYYY-MM-DD): ")

        start_date = datetime.strptime(start_date_str, "%Y-%m-%d")
        end_date = datetime.strptime(end_date_str, "%Y-%m-%d")

        daily_rate = float(input("Enter Daily Rate (₹): "))
        days = (end_date - start_date).days + 1
        total_cost = days * daily_rate

        reservation = Reservation(
            customer_id=customer_id,
            vehicle_id=vehicle_id,
            start_date=start_date,
            end_date=end_date,
            total_cost=total_cost,
            status="confirmed"
        )

        dao = ReservationDAO()
        dao.create_reservation(reservation)

    except Exception as e:
        print("❌ Something went wrong:", e)

def view_reservations():
    try:
        customer_id = int(input("Enter your Customer ID: "))
        dao = ReservationDAO()
        reservations = dao.get_reservations_by_customer_id(customer_id)

        if reservations:
            print(f"\n✅ Reservations for Customer ID {customer_id}:")
            for r in reservations:
                print(f"ReservationID: {r.reservation_id}, VehicleID: {r.vehicle_id}, "
                      f"From: {r.start_date.date()} To: {r.end_date.date()}, "
                      f"Total: ₹{r.total_cost}, Status: {r.status}")
        else:
            print("❌ No reservations found.")
    except Exception as e:
        print("❌ Error:", e)

def main():
    while True:
        print("\n===== Reservation Menu =====")
        print("1. Book a Vehicle")
        print("2. View My Reservations")
        print("3. Exit")
        choice = input("Choose an option: ")

        if choice == "1":
            book_reservation()
        elif choice == "2":
            view_reservations()
        elif choice == "3":
            print("Goodbye!")
            break
        else:
            print("Invalid option. Try again.")

if __name__ == "__main__":
    main()
