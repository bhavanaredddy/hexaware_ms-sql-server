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
