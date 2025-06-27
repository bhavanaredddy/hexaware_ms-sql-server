class InvalidEmailFormatException(Exception):
    def __init__(self, message="Invalid email format. Must contain '@' and domain."):
        super().__init__(message)
