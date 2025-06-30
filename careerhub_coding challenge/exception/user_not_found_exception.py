class UserNotFoundException(Exception):
    def __init__(self, message="User ID not found in the system."):
        super().__init__(message)
