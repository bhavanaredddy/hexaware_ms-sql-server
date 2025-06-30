from dao.vehicle_dao import VehicleDAO
from entity.vehicle import Vehicle

def show_menu():
    print("\n===== Vehicle Management Menu =====")
    print("1. Add New Vehicle")
    print("2. View All Vehicles")
    print("3. Update Vehicle")
    print("4. Delete Vehicle")
    print("5. Exit")

def main():
    dao = VehicleDAO()

    while True:
        show_menu()
        choice = input("Enter choice (1-5): ")

        if choice == '1':
            model = input("Model: ")
            make = input("Make: ")
            year = int(input("Year: "))
            color = input("Color: ")
            reg_no = input("Registration Number: ")
            rate = float(input("Daily Rate (₹): "))
            availability = True  # Always True for new vehicles

            vehicle = Vehicle(
                model=model,
                make=make,
                year=year,
                color=color,
                registration_number=reg_no,
                availability=availability,
                daily_rate=rate
            )
            dao.add_vehicle(vehicle)

        elif choice == '2':
            vehicles = dao.get_all_vehicles()
            if not vehicles:
                print("⚠️ No vehicles found.")
            else:
                print("\n📋 Vehicle List:")
                for v in vehicles:
                    print(f"ID: {v.vehicle_id}, {v.make} {v.model}, ₹{v.daily_rate}/day, Reg#: {v.registration_number}, Available: {v.availability}")

        elif choice == '3':
            vehicle_id = int(input("Enter Vehicle ID to update: "))
            print("Fields: Model, Make, Year, Color, RegistrationNumber, Availability, DailyRate")
            field = input("Enter field to update: ")
            new_value = input("Enter new value: ")
            # Convert availability or year if needed
            if field.lower() == "availability":
                new_value = 1 if new_value.lower() == "true" else 0
            elif field.lower() in ["year"]:
                new_value = int(new_value)
            elif field.lower() in ["dailyrate"]:
                new_value = float(new_value)
            dao.update_vehicle(vehicle_id, field, new_value)

        elif choice == '4':
            vehicle_id = int(input("Enter Vehicle ID to delete: "))
            dao.delete_vehicle(vehicle_id)

        elif choice == '5':
            print("👋 Exiting vehicle management.")
            break
        else:
            print("❌ Invalid choice. Try again.")

if __name__ == "__main__":
    main()
