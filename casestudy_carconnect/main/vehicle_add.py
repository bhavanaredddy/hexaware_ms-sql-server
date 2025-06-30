from dao.vehicle_dao import VehicleDAO
from entity.vehicle import Vehicle

def main():
    vehicle = Vehicle(
        model='Swift',
        make='Maruti',
        year=2021,
        color='White',
        registration_number='TS08AB1234',
        availability=True,
        daily_rate=1200.0
    )

    dao = VehicleDAO()
    dao.add_vehicle(vehicle)

if __name__ == "__main__":
    main()
