class CustomerException(Exception):
    def __init__(self, message="Customer operation failed"):
        super().__init__(message)
