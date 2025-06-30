class Payment:
    def __init__(self, payment_id=None, reservation_id=None, amount=0.0, payment_date=None, method=''):
        self.payment_id = payment_id
        self.reservation_id = reservation_id
        self.amount = amount
        self.payment_date = payment_date
        self.method = method
