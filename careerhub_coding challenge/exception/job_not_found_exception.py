class JobNotFoundException(Exception):
    def __init__(self, message="Job ID not found."):
        super().__init__(message)
