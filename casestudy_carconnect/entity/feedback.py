class Feedback:
    def __init__(self, feedback_id=None, customer_id=None, vehicle_id=None, rating=0, comment=""):
        self.feedback_id = feedback_id
        self.customer_id = customer_id
        self.vehicle_id = vehicle_id
        self.rating = rating
        self.comment = comment
