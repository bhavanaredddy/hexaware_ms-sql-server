class AuthenticationException(Exception):
    def __init__(self, message="Invalid username or password."):
        self.message = message
        super().__init__(self.message)
