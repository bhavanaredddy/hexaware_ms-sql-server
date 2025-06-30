import sys
import os
sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from dao.vehicle_dao import VehicleDAO
from entity.vehicle import Vehicle

def main():
    print("🚗 Add New Vehicle")
    model = input("Enter model: ")
    make = input("Enter make: ")
    year = int(input("Enter year: "))
    color = input("Enter color: ")
    reg_no = input("Enter registration number: ")
    availability = input("Is it available? (yes/no): ").strip().lower() == 'yes'
    daily_rate = float(input("Enter daily rate (INR): "))

    vehicle = Vehicle(
        model=model,
        make=make,
        year=year,
        color=color,
        registration_number=reg_no,
        availability=availability,
        daily_rate=daily_rate
    )

    dao = VehicleDAO()
    dao.add_vehicle(vehicle)

if __name__ == "__main__":
    main()
