from util.db_util import DBUtil
from entity.vehicle import Vehicle

class VehicleDAO:
    def add_vehicle(self, vehicle):
        conn = DBUtil.get_connection()
        try:
            cursor = conn.cursor()
            query = '''
                INSERT INTO Vehicle 
                (Model, Make, Year, Color, RegistrationNumber, Availability, DailyRate)
                VALUES (?, ?, ?, ?, ?, ?, ?)
            '''
            cursor.execute(query, (
                vehicle.model,
                vehicle.make,
                vehicle.year,
                vehicle.color,
                vehicle.registration_number,
                int(vehicle.availability),
                vehicle.daily_rate
            ))
            conn.commit()
            print("✅ Vehicle added successfully.")
        except Exception as e:
            print("❌ Error adding vehicle:", e)
        finally:
            if conn:
                conn.close()

    def get_available_vehicles(self):
        conn = DBUtil.get_connection()
        vehicles = []
        try:
            cursor = conn.cursor()
            cursor.execute("SELECT * FROM Vehicle WHERE Availability = 1")
            rows = cursor.fetchall()
            for row in rows:
                vehicles.append(Vehicle(*row))
        except Exception as e:
            print("❌ Error fetching available vehicles:", e)
        finally:
            if conn:
                conn.close()
        return vehicles

    def get_all_vehicles(self):
        conn = DBUtil.get_connection()
        vehicles = []
        try:
            cursor = conn.cursor()
            cursor.execute("SELECT * FROM Vehicle")
            rows = cursor.fetchall()
            for row in rows:
                vehicles.append(Vehicle(*row))
        except Exception as e:
            print("❌ Error fetching all vehicles:", e)
        finally:
            if conn:
                conn.close()
        return vehicles

    def update_vehicle(self, vehicle_id, field, new_value):
        conn = DBUtil.get_connection()
        try:
            cursor = conn.cursor()
            query = f"UPDATE Vehicle SET {field} = ? WHERE VehicleID = ?"
            cursor.execute(query, (new_value, vehicle_id))
            conn.commit()
            print("✅ Vehicle updated successfully.")
        except Exception as e:
            print("❌ Error updating vehicle:", e)
        finally:
            if conn:
                conn.close()

    def delete_vehicle(self, vehicle_id):
        conn = DBUtil.get_connection()
        try:
            cursor = conn.cursor()
            cursor.execute("DELETE FROM Vehicle WHERE VehicleID = ?", (vehicle_id,))
            conn.commit()
            print("✅ Vehicle deleted successfully.")
        except Exception as e:
            print("❌ Error deleting vehicle:", e)
        finally:
            if conn:
                conn.close()

    def search_vehicles(self, keyword):
        conn = DBUtil.get_connection()
        vehicles = []
        try:
            cursor = conn.cursor()
            query = """
                SELECT * FROM Vehicle 
                WHERE Model LIKE ? OR Make LIKE ?
            """
            like_keyword = f"%{keyword}%"
            cursor.execute(query, (like_keyword, like_keyword))
            rows = cursor.fetchall()
            for row in rows:
                vehicles.append(Vehicle(*row))
        except Exception as e:
            print("❌ Error searching vehicles:", e)
        finally:
            if conn:
                conn.close()
        return vehicles

    def filter_vehicles(self, year=None, color=None, available_only=False):
        conn = DBUtil.get_connection()
        vehicles = []
        try:
            cursor = conn.cursor()
            query = "SELECT * FROM Vehicle WHERE 1=1"
            params = []

            if year:
                query += " AND Year = ?"
                params.append(year)
            if color:
                query += " AND Color = ?"
                params.append(color)
            if available_only:
                query += " AND Availability = 1"

            cursor.execute(query, tuple(params))
            rows = cursor.fetchall()
            for row in rows:
                vehicles.append(Vehicle(*row))
        except Exception as e:
            print("❌ Error filtering vehicles:", e)
        finally:
            if conn:
                conn.close()
        return vehicles
