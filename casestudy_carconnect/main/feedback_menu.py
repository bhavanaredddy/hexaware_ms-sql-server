from dao.feedback_dao import FeedbackDAO
from entity.feedback import Feedback

def main():
    dao = FeedbackDAO()
    while True:
        print("\n===== Feedback Menu =====")
        print("1. Submit Feedback")
        print("2. View Feedback for Vehicle")
        print("3. Exit")
        choice = input("Enter your choice: ")

        if choice == '1':
            customer_id = int(input("Enter Customer ID: "))
            vehicle_id = int(input("Enter Vehicle ID: "))
            rating = int(input("Enter Rating (1-5): "))
            comment = input("Enter your comment: ")

            feedback = Feedback(None, customer_id, vehicle_id, rating, comment)
            dao.add_feedback(feedback)

        elif choice == '2':
            vehicle_id = int(input("Enter Vehicle ID to view feedback: "))
            feedbacks = dao.get_feedback_for_vehicle(vehicle_id)
            if feedbacks:
                for f in feedbacks:
                    print(f"Rating: {f.rating}, Comment: {f.comment} (Customer ID: {f.customer_id})")
            else:
                print("⚠️ No feedback found for this vehicle.")

        elif choice == '3':
            print("🔚 Exiting Feedback Menu.")
            break

        else:
            print("❌ Invalid choice. Try again.")

if __name__ == "__main__":
    main()
