class CompanyNotFoundException(Exception):
    def __init__(self, message="Company ID not found."):
        super().__init__(message)
