

class Payment:
    def __init__(self, payment_id, student, amount, payment_date):
        self.payment_id = payment_id
        self.student = student          # Student object
        self.amount = amount
        self.payment_date = payment_date

    def get_student(self):
        return self.student

    def get_payment_amount(self):
        return self.amount

    def get_payment_date(self):
        return self.payment_date

    def display_info(self):
        print(f"Payment ID: {self.payment_id}")
        print(f"Student: {self.student.first_name} {self.student.last_name}")
        print(f"Amount: {self.amount}")
        print(f"Date: {self.payment_date}")
