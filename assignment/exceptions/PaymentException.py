# exceptions/PaymentException.py

class PaymentException(Exception):
    def __init__(self, message="Payment error occurred"):
        super().__init__(message)
