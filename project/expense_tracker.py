import json
import datetime
import math
import os

expenses = []

def load_expenses():
    global expenses
    if os.path.exists("expenses.json"):
        with open("expenses.json", "r") as f:
            raw_data = json.load(f)
            expenses = [
                {"amount": e["amount"], "category": e["category"], "date": datetime.datetime.strptime(e["date"], "%Y-%m-%d").date()}
                for e in raw_data
            ]


def save_expenses():
    with open("expenses.json", "w") as f:
        json.dump(
            [
                {"amount": e["amount"], "category": e["category"], "date": e["date"].strftime("%Y-%m-%d")}
                for e in expenses
            ],
            f,
            indent=4
        )


def add_expense():
    try:
        amount = float(input("Enter amount: ₹"))
        category = input("Enter category: ").strip().lower()
        date_input = input("Enter date (YYYY-MM-DD): ")
        date = datetime.datetime.strptime(date_input, "%Y-%m-%d").date()
        expense = {"amount": amount, "category": category, "date": date}
        expenses.append(expense)
        save_expenses()  # Save every time we add
        print(f"Added: ₹{amount} under '{category}' on {date}")
    except ValueError:
        print(" Invalid input")


def show_monthly_expense(month, year):
    total = sum(e["amount"] for e in expenses if e["date"].month == month and e["date"].year == year)
    print(f" Monthly total for {month}/{year}: ₹{math.ceil(total)}")

def show_yearly_expense(year):
    total = sum(e["amount"] for e in expenses if e["date"].year == year)
    print(f" Yearly total for {year}: ₹{math.ceil(total)}")


def category_summary():
    summary = {}
    for e in expenses:
        cat = e["category"]
        summary[cat] = summary.get(cat, 0) + e["amount"]
    print(" Category Summary:")
    for k, v in summary.items():
        print(f" - {k.title()}: ₹{math.ceil(v)}")


def run_tracker():
    load_expenses()
    while True:
        print("\n=== Expense Tracker ===")
        print("1. Add Expense")
        print("2. View Monthly Expense")
        print("3. View Yearly Expense")
        print("4. Category Summary")
        print("5. Exit")
        choice = input("Enter choice: ")

        if choice == "1":
            add_expense()
        elif choice == "2":
            m = int(input("Month (1–12): "))
            y = int(input("Year: "))
            show_monthly_expense(m, y)
        elif choice == "3":
            y = int(input("Year: "))
            show_yearly_expense(y)
        elif choice == "4":
            category_summary()
        elif choice == "5":
            print("👋 Exiting...")
            break
        else:
            print("❌ Invalid choice.")

if __name__ == "__main__":
    run_tracker()
