class Vehicle:
    def __init__(self, vehicle_id=None, model='', make='', year=0, color='',
                 registration_number='', availability=True, daily_rate=0.0):
        self.vehicle_id = vehicle_id
        self.model = model
        self.make = make
        self.year = year
        self.color = color
        self.registration_number = registration_number
        self.availability = availability
        self.daily_rate = daily_rate
