class Reservation:
    def __init__(self, reservation_id=None, customer_id=None, vehicle_id=None,
                 start_date=None, end_date=None, total_cost=0.0, status='pending'):
        self.reservation_id = reservation_id
        self.customer_id = customer_id
        self.vehicle_id = vehicle_id
        self.start_date = start_date
        self.end_date = end_date
        self.total_cost = total_cost
        self.status = status

    def calculate_total_cost(self, daily_rate):
        if self.start_date and self.end_date:
            days = (self.end_date - self.start_date).days + 1
            self.total_cost = days * daily_rate
            return self.total_cost
        return 0
