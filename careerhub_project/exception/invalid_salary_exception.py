class InvalidSalaryException(Exception):
    def __init__(self, message="Salary must be a non-negative number."):
        super().__init__(message)
