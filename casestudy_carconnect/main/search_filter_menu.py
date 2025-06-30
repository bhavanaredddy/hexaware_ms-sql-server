from dao.vehicle_dao import VehicleDAO
from entity.vehicle import Vehicle  # Optional if you're using Vehicle object internally

def display_vehicles(vehicles):
    if not vehicles:
        print("⚠️  No vehicles found.")
        return
    for v in vehicles:
        print(f"{v.vehicle_id}: {v.make} {v.model} ({v.year}) - ₹{v.daily_rate}/day - {v.color} - {'Available' if v.availability else 'Not Available'}")

def main():
    print("🚗 Welcome to Vehicle Search & Filter Menu!")  # Add visual startup prompt
    dao = VehicleDAO()

    while True:
        print("\n====== Vehicle Search & Filter Menu ======")
        print("1. Search by Model or Make")
        print("2. Filter by Year, Color, Availability")
        print("3. Exit")
        choice = input("Enter your choice: ")

        if choice == "1":
            keyword = input("Enter make or model to search: ")
            results = dao.search_vehicles(keyword)
            display_vehicles(results)

        elif choice == "2":
            year = input("Enter year (press Enter to skip): ")
            color = input("Enter color (press Enter to skip): ")
            availability_input = input("Available only? (yes/no): ").lower()
            available_only = availability_input == 'yes'

            results = dao.filter_vehicles(
                year=int(year) if year else None,
                color=color if color else None,
                available_only=available_only
            )
            display_vehicles(results)

        elif choice == "3":
            print("🔚 Exiting Search & Filter Menu.")
            break

        else:
            print("❌ Invalid choice. Try again.")

if __name__ == "__main__":
    main()
