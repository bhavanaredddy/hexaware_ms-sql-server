from dao.reservation_dao import ReservationDAO
from entity.reservation import Reservation

def main():
    dao = ReservationDAO()

    while True:
        print("\n=== Reservation Menu ===")
        print("1. Add Reservation")
        print("2. Delete Reservation")
        print("3. Exit")
        choice = input("Enter choice: ")

        if choice == "1":
            cust_id = int(input("Enter Customer ID: "))
            vehicle_id = int(input("Enter Vehicle ID: "))
            start = input("Enter Start Date (YYYY-MM-DD): ")
            end = input("Enter End Date (YYYY-MM-DD): ")
            amount = float(input("Enter Total Cost: "))

            reservation = Reservation(
                customer_id=cust_id,
                vehicle_id=vehicle_id,
                start_date=start,
                end_date=end,
                total_cost=amount  # ✅ corrected field name
            )
            dao.create_reservation(reservation)

        elif choice == "2":
            res_id = int(input("Enter Reservation ID to delete: "))
            dao.delete_reservation(res_id)

        elif choice == "3":
            print("Exiting Reservation Menu.")
            break

        else:
            print("❌ Invalid choice.")

if __name__ == "__main__":
    main()
