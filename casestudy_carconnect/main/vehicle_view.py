from dao.vehicle_dao import VehicleDAO

def main():
    dao = VehicleDAO()
    vehicles = dao.get_available_vehicles()

    if vehicles:
        print("✅ Available Vehicles:")
        for v in vehicles:
            print(f"ID: {v.vehicle_id}, {v.make} {v.model}, {v.year}, Color: {v.color}, Rate: ₹{v.daily_rate}/day")
    else:
        print("❌ No vehicles available right now.")

if __name__ == "__main__":
    main()
