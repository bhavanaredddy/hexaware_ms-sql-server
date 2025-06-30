from dao.reservation_dao import ReservationDAO

def main():
    customer_id = int(input("Enter Customer ID: "))
    dao = ReservationDAO()
    reservations = dao.get_reservations_by_customer_id(customer_id)

    if reservations:
        print(f"✅ Reservations for Customer ID {customer_id}:")
        for r in reservations:
            print(f"ReservationID: {r.reservation_id}, VehicleID: {r.vehicle_id}, "
                  f"From: {r.start_date.date()} To: {r.end_date.date()}, "
                  f"Total: ₹{r.total_cost}, Status: {r.status}")
    else:
        print("❌ No reservations found.")

if __name__ == "__main__":
    main()
