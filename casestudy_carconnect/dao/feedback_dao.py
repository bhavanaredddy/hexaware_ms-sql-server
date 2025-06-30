from util.db_util import DBUtil
from entity.feedback import Feedback

class FeedbackDAO:
    def add_feedback(self, feedback):
        conn = DBUtil.get_connection()
        try:
            cursor = conn.cursor()
            query = '''
                INSERT INTO Feedback (CustomerID, VehicleID, Rating, Comment)
                VALUES (?, ?, ?, ?)
            '''
            cursor.execute(query, (
                feedback.customer_id,
                feedback.vehicle_id,
                feedback.rating,
                feedback.comment
            ))
            conn.commit()
            print("✅ Feedback submitted successfully.")
        except Exception as e:
            print("❌ Error submitting feedback:", e)
        finally:
            if conn:
                conn.close()

    def get_feedback_for_vehicle(self, vehicle_id):
        conn = DBUtil.get_connection()
        feedback_list = []
        try:
            cursor = conn.cursor()
            cursor.execute("SELECT * FROM Feedback WHERE VehicleID = ?", (vehicle_id,))
            rows = cursor.fetchall()
            for row in rows:
                feedback_list.append(Feedback(*row))
        except Exception as e:
            print("❌ Error fetching feedback:", e)
        finally:
            if conn:
                conn.close()
        return feedback_list
