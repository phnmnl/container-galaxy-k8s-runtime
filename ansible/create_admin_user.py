"""
Creates a new admin user. 

Usage: python create_admin_user.py <Galaxy_API_key> <new_username> <new_user_email> <new_password>
"""
from __future__ import print_function

import sys

import bioblend.galaxy

if len(sys.argv) != 5:
    print("Usage: python create_admin_user.py <Galaxy_API_key> <new_username> <new_user_email> <new_password>")
    sys.exit(1)

galaxy_url = "http://127.0.0.1:8080"
galaxy_api_key = sys.argv[1]
username = sys.argv[2]
email = sys.argv[3]
password = sys.argv[4]

if len(password) < 6:
    print("Pasword for admin user on Galaxy needs to be of at least 6 characters")
    print("User not added!!!")
    exit(1)

# Initiating Galaxy connection
gi = bioblend.galaxy.GalaxyInstance(galaxy_url, galaxy_api_key)

# Create a new user
new_user = gi.users.create_local_user(username, email, password)
print("User created!")
