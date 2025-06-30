from util.db_util import DBUtil
from entity.reservation import Reservation
from exceptions.reservation_exception import ReservationException

class ReservationDAO:

    def create_reservation(self, reservation):
        conn = DBUtil.get_connection()
        try:
            cursor = conn.cursor()
            query = '''
                INSERT INTO Reservation
                (CustomerID, VehicleID, StartDate, EndDate, TotalCost, Status)
                VALUES (?, ?, ?, ?, ?, ?)
            '''
            cursor.execute(query, (
                reservation.customer_id,
                reservation.vehicle_id,
                reservation.start_date,
                reservation.end_date,
                reservation.total_cost,
                reservation.status
            ))
            cursor.execute(
                "UPDATE Vehicle SET Availability = 0 WHERE VehicleID = ?",
                (reservation.vehicle_id,)
            )
            conn.commit()
            print("✅ Reservation successful.")
        except Exception as e:
            raise ReservationException(f"Reservation failed: {e}")
        finally:
            if conn:
                conn.close()

    def get_reservations_by_customer_id(self, customer_id):
        conn = DBUtil.get_connection()
        reservations = []
        try:
            cursor = conn.cursor()
            query = '''
                SELECT * FROM Reservation WHERE CustomerID = ?
            '''
            cursor.execute(query, (customer_id,))
            rows = cursor.fetchall()
            for row in rows:
                reservation = Reservation(
                    reservation_id=row[0],
                    customer_id=row[1],
                    vehicle_id=row[2],
                    start_date=row[3],
                    end_date=row[4],
                    total_cost=row[5],
                    status=row[6]
                )
                reservations.append(reservation)
        except Exception as e:
            print("❌ Error retrieving reservations:", e)
        finally:
            if conn:
                conn.close()
        return reservations

    def cancel_reservation(self, reservation_id):
        conn = DBUtil.get_connection()
        try:
            cursor = conn.cursor()
            cursor.execute("SELECT VehicleID FROM Reservation WHERE ReservationID = ?", (reservation_id,))
            row = cursor.fetchone()
            if not row:
                print("❌ Reservation not found.")
                return

            vehicle_id = row[0]
            cursor.execute("UPDATE Reservation SET Status = 'cancelled' WHERE ReservationID = ?", (reservation_id,))
            cursor.execute("UPDATE Vehicle SET Availability = 1 WHERE VehicleID = ?", (vehicle_id,))
            conn.commit()
            print("✅ Reservation cancelled and vehicle marked as available.")
        except Exception as e:
            raise ReservationException(f"Error cancelling reservation: {e}")
        finally:
            if conn:
                conn.close()

    def get_all_reservations(self):
        conn = DBUtil.get_connection()
        reservations = []
        try:
            cursor = conn.cursor()
            cursor.execute("SELECT * FROM Reservation")
            rows = cursor.fetchall()
            for row in rows:
                reservations.append(Reservation(*row))
        except Exception as e:
            print("❌ Error fetching reservations:", e)
        finally:
            if conn:
                conn.close()
        return reservations
