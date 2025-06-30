import sys
import os
sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from dao.admin_dao import AdminDAO
from exceptions.authentication_exception import AuthenticationException

def main():
    try:
        username = input("Enter admin username: ").strip()
        password = input("Enter password: ").strip()

        dao = AdminDAO()
        admin = dao.get_admin_by_username(username)

        if admin:
            # Debug output
            print("🔍 DB Username:", repr(admin.username))
            print("🔍 DB Password:", repr(admin.password))
            print("🔍 Input Username:", repr(username))
            print("🔍 Input Password:", repr(password))

        if admin and admin.authenticate(password):
            print(f"✅ Welcome Admin {admin.first_name}!")
        else:
            raise AuthenticationException()

    except AuthenticationException as ae:
        print("❌", ae)

    except Exception as e:
        print("❌ Unexpected error:", e)

if __name__ == "__main__":
    main()
