from util.db_util import DBUtil

class ReportGenerator:

    def show_all_reservations(self):
        conn = DBUtil.get_connection()
        try:
            cursor = conn.cursor()
            cursor.execute("SELECT * FROM Reservation")
            rows = cursor.fetchall()
            print("\n📄 All Reservations:")
            for row in rows:
                print(f"ID: {row[0]} | CustomerID: {row[1]} | VehicleID: {row[2]} | "
                      f"From: {row[3].date()} To: {row[4].date()} | ₹{row[5]} | Status: {row[6]}")
        except Exception as e:
            print("❌ Failed to retrieve reservations:", e)
        finally:
            conn.close()

    def vehicle_utilization_report(self):
        conn = DBUtil.get_connection()
        try:
            cursor = conn.cursor()
            cursor.execute('''
                SELECT V.VehicleID, V.Model, COUNT(R.ReservationID) AS TotalBookings
                FROM Vehicle V
                LEFT JOIN Reservation R ON V.VehicleID = R.VehicleID
                GROUP BY V.VehicleID, V.Model
            ''')
            rows = cursor.fetchall()
            print("\n🚗 Vehicle Utilization Report:")
            for row in rows:
                print(f"VehicleID: {row[0]}, Model: {row[1]}, Total Bookings: {row[2]}")
        except Exception as e:
            print("❌ Failed to retrieve utilization report:", e)
        finally:
            conn.close()

    def revenue_report(self):
        conn = DBUtil.get_connection()
        try:
            cursor = conn.cursor()
            cursor.execute('''
                SELECT SUM(TotalCost) FROM Reservation WHERE Status = 'confirmed'
            ''')
            total = cursor.fetchone()[0]
            print("\n💰 Total Revenue (Confirmed Bookings Only): ₹", total if total else 0.0)
        except Exception as e:
            print("❌ Failed to retrieve revenue:", e)
        finally:
            conn.close()
