import math
import datetime


students = []
55

def add_student():
    name = input("Enter Student Name: ")
    roll = input("Enter Roll Number: ")
    subjects = ("Math", "Science", "English", "Computer")
    marks = {}

    total = 0
    for sub in subjects:
        score = float(input(f"Enter marks for {sub} (out of 100): "))
        marks[sub] = score
        total += score

    percentage = math.ceil((total / (len(subjects) * 100)) * 100)
    grade = assign_grade(percentage)

    student = {
        "name": name,
        "roll": roll,
        "marks": marks,
        "total": total,
        "percentage": percentage,
        "grade": grade,
        "date": datetime.date.today().strftime("%Y-%m-%d")
    }
    students.append(student)
    print(f" Report card created for {name}!\n")


def assign_grade(percentage):
    if percentage >= 90:
        return "A+"
    elif percentage >= 75:
        return "A"
    elif percentage >= 60:
        return "B"
    elif percentage >= 50:
        return "C"
    else:
        return "Fail"


def view_all():
    if not students:
        print(" No student records found.")
        return

    for stu in students:
        print("\n===== Report Card =====")
        print(f"Name       : {stu['name']}")
        print(f"Roll No.   : {stu['roll']}")
        print(f"Date       : {stu['date']}")
        for subject, score in stu["marks"].items():
            print(f"{subject:<10}: {score}")
        print(f"Total      : {stu['total']} / 400")
        print(f"Percentage : {stu['percentage']}%")
        print(f"Grade      : {stu['grade']}")
        print("=========================")


def search_by_roll():
    roll = input("Enter Roll Number to search: ")
    found = list(filter(lambda s: s["roll"] == roll, students))
    if found:
        stu = found[0]
        print("\n Student Found:")
        print(f"Name: {stu['name']}, Percentage: {stu['percentage']}%, Grade: {stu['grade']}")
    else:
        print(" Student not found.")

def sort_by_percentage():
    sorted_list = sorted(students, key=lambda s: s["percentage"], reverse=True)
    print("\n Students Sorted by Percentage (High to Low):")
    for stu in sorted_list:
        print(f"{stu['name']} - {stu['percentage']}% - Grade: {stu['grade']}")


def main():
    while True:
        print("\n====== Student Report Card System ======")
        print("1. Add Student Marks")
        print("2. View All Report Cards")
        print("3. Search Student by Roll No.")
        print("4. Sort Students by Percentage")
        print("5. Exit")
        choice = input("Enter your choice (1–5): ")

        if choice == "1":
            add_student()
        elif choice == "2":
            view_all()
        elif choice == "3":
            search_by_roll()
        elif choice == "4":
            sort_by_percentage()
        elif choice == "5":
            print(" Exiting system. Bye!")
            break
        else:
            print(" Invalid choice.")
import csv

def export_to_csv():
    with open("report_cards.csv", "w", newline="") as file:
        writer = csv.writer(file)
        writer.writerow(["Name", "Roll No", "Date", "Math", "Science", "English", "Computer", "Total", "Percentage", "Grade"])
        for stu in students:
            writer.writerow([
                stu["name"], stu["roll"], stu["date"],
                stu["marks"]["Math"], stu["marks"]["Science"],
                stu["marks"]["English"], stu["marks"]["Computer"],
                stu["total"], stu["percentage"], stu["grade"]
            ])
    print("Report cards exported to report_cards.csv")
    

if __name__ == "__main__":
    main()


import math

# ➕ Add people and their custom shares
def add_people():
    people = []
    total_share = 0

    n = int(input("How many people? "))
    print("Enter each person's name and share weight (e.g., 1, 2, etc.):")
    for i in range(n):
        name = input(f"Name {i+1}: ")
        share = int(input(f"Share weight for {name}: "))
        people.append({"name": name, "share": share})
        total_share += share

    return people, total_share

# 💰 Split the bill
def split_bill():
    try:
        total_amount = float(input("Enter total bill amount: ₹"))
        people, total_share = add_people()

        print("\n=== Bill Split Summary ===")
        for person in people:
            share_amount = (person["share"] / total_share) * total_amount
            person["amount"] = math.ceil(share_amount * 100) / 100  # rounded to 2 decimal places
            print(f"{person['name']} pays: ₹{person['amount']:.2f}")

        return people
    except ValueError:
        print("❌ Invalid input. Please enter valid numbers.")

# 🧾 Show who pays most/least using lambda
def show_summary(people):
    if not people:
        print("No people to show summary for.")
        return

    highest = max(people, key=lambda x: x["amount"])
    lowest = min(people, key=lambda x: x["amount"])

    print(f"\n💸 {highest['name']} pays the most: ₹{highest['amount']:.2f}")
    print(f"🪙 {lowest['name']} pays the least: ₹{lowest['amount']:.2f}")

# 🧭 Menu
def main():
    while True:
        print("\n=== Bill Splitter App ===")
        print("1. Split Bill")
        print("2. Exit")
        choice = input("Enter your choice: ")

        if choice == "1":
            people = split_bill()
            show_summary(people)
        elif choice == "2":
            print("👋 Exiting. Goodbye!")
            break
        else:
            print("❌ Invalid choice.")

# 🚀 Run the app
if __name__ == "__main__":
    main()
