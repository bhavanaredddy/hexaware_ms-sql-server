import datetime
import json
import os

# 📦 Question bank
quiz_questions = [
    {
        "question": "What is the capital of France?",
        "options": ("A. Paris", "B. Berlin", "C. Madrid", "D. Rome"),
        "answer": "A"
    },
    {
        "question": "Which language is primarily used for AI?",
        "options": ("A. Java", "B. C++", "C. Python", "D. PHP"),
        "answer": "C"
    },
    {
        "question": "What is the value of 5 * 6?",
        "options": ("A. 11", "B. 30", "C. 60", "D. 56"),
        "answer": "B"
    },
    {
        "question": "Who is the founder of Microsoft?",
        "options": ("A. Steve Jobs", "B. Elon Musk", "C. Bill Gates", "D. Mark Zuckerberg"),
        "answer": "C"
    }
]

# 🗃️ Scores list
scores = []

# 📂 Load scores from JSON file
def load_scores():
    global scores
    if os.path.exists("quiz_scores.json"):
        with open("quiz_scores.json", "r") as f:
            scores = json.load(f)

# 💾 Save scores to JSON file
def save_scores():
    with open("quiz_scores.json", "w") as f:
        json.dump(scores, f, indent=4)

# ➕ Start quiz
def start_quiz():
    name = input("Enter your name: ")
    score = 0

    for idx, q in enumerate(quiz_questions, 1):
        print(f"\nQ{idx}: {q['question']}")
        for opt in q["options"]:
            print(opt)
        user_ans = input("Your answer (A/B/C/D): ").strip().upper()
        if user_ans == q["answer"]:
            print("✅ Correct!")
            score += 1
        else:
            print(f"❌ Wrong! Correct answer is {q['answer']}")

    percentage = (score / len(quiz_questions)) * 100
    print(f"\n{name}, your score: {score}/{len(quiz_questions)} ({percentage:.2f}%)")

    entry = {
        "name": name,
        "score": score,
        "percentage": round(percentage, 2),
        "date": datetime.date.today().strftime("%Y-%m-%d")
    }
    scores.append(entry)
    save_scores()
    print("📁 Score saved!")

# 🧾 View leaderboard
def view_scores():
    if not scores:
        print("❌ No quiz attempts yet.")
        return

    print("\n=== Leaderboard (Sorted by Score) ===")
    sorted_scores = sorted(scores, key=lambda x: x["score"], reverse=True)
    for s in sorted_scores:
        print(f"{s['name']} - {s['score']}/{len(quiz_questions)} - {s['percentage']}% on {s['date']}")

# 🧭 Main menu
def main():
    load_scores()
    while True:
        print("\n=== Quiz App ===")
        print("1. Start Quiz")
        print("2. View Leaderboard")
        print("3. Exit")
        choice = input("Enter your choice: ")

        if choice == "1":
            start_quiz()
        elif choice == "2":
            view_scores()
        elif choice == "3":
            print("👋 Thanks for playing. Goodbye!")
            break
        else:
            print("❌ Invalid choice.")

# 🚀 Start app
if __name__ == "__main__":
    main()
