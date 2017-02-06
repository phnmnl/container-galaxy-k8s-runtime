"""
Creates a new admin user. 

Usage: python create_admin_user.py <Galaxy_API_key> <new_username> <new_user_email> <new_password>
"""
from __future__ import print_function

import sys

import bioblend.galaxy

if len(sys.argv) != 5:
    print("Usage: python create_admin_user.py <Galaxy_API_key> <new_username> <new_user_email> <new_password>", file=sys.stderr)
    sys.exit(1)

galaxy_url = "http://127.0.0.1:8080"
galaxy_api_key = sys.argv[1]
username = sys.argv[2]
email = sys.argv[3]
password = sys.argv[4]

if len(password) < 6:
    print("Password for admin user on Galaxy needs to be of at least 6 characters", file=sys.stderr)
    print("User not added!!!", file=sys.stderr)
    exit(1)

try:
    # Initiating Galaxy connection
    gi = bioblend.galaxy.GalaxyInstance(galaxy_url, galaxy_api_key)
    # Check if user doesn't exist already
    users = gi.users.get_users()
    for user in users:
        if user['email'] == email:
            print("Admin user already exists...")
            sys.exit(0)

    # Create a new user if no user with that email is available.
    new_user = gi.users.create_local_user(username, email, password)
    print("User {} created!".format(new_user['username']))
except (RuntimeError, StandardError):
    print("Something went wrong when trying to create the user", file=sys.stderr)
    sys.exit(1)
