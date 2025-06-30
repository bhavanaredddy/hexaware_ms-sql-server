from dao.customer_dao import CustomerDAO
from dao.vehicle_dao import VehicleDAO
from dao.reservation_dao import ReservationDAO

def main():
    print("===== Admin Reports Menu =====")
    print("1. View All Customers")
    print("2. View All Vehicles")
    print("3. View All Reservations")
    print("4. Exit")

    choice = input("Enter your choice (1-4): ")

    if choice == '1':
        customers = CustomerDAO().get_all_customers()
        print("\n--- Customers ---")
        for c in customers:
            print(f"{c.customer_id}: {c.first_name} {c.last_name} | {c.email} | {c.phone_number}")
    elif choice == '2':
        vehicles = VehicleDAO().get_all_vehicles()
        print("\n--- Vehicles ---")
        for v in vehicles:
            print(f"{v.vehicle_id}: {v.make} {v.model} ({v.year}) | {v.color} | ₹{v.daily_rate}/day | Available: {'Yes' if v.availability else 'No'}")
    elif choice == '3':
        reservations = ReservationDAO().get_all_reservations()
        print("\n--- Reservations ---")
        for r in reservations:
            print(f"ReservationID: {r.reservation_id} | CustomerID: {r.customer_id} | VehicleID: {r.vehicle_id} | From: {r.start_date.date()} To: {r.end_date.date()} | Total: ₹{r.total_cost} | Status: {r.status}")
    elif choice == '4':
        print("👋 Exiting reports menu.")
    else:
        print("❌ Invalid choice.")

if __name__ == "__main__":
    main()
