class ReservationException(Exception):
    def __init__(self, message="Reservation processing failed"):
        super().__init__(message)
