from cv2 import add
import streamlit as st
from streamlit_option_menu import option_menu
import pandas as pd
import numpy as np

import mysql.connector

# Function to connect to the database
def connect_to_database():
    return mysql.connector.connect(
        host="localhost",
        user="root",
        password="abhipushp",
        database="2000_sql_project"
    )

# Function to check if a name exists in the database
def check_in_database(fname, mname, lname):
    try:
        connection = connect_to_database()
        cursor = connection.cursor()
        cursor.execute("SELECT COUNT(*) FROM Customer WHERE cust_fname = %s AND cust_mname = %s AND cust_lname = %s", (fname, mname, lname))
        result = cursor.fetchone()
        if result[0] > 0:
            return True
        else:
            return False
    except Exception as e:
        st.error(f"Error checking name in database: {e}")
        return False
    finally:
        if connection.is_connected():
            cursor.close()
            connection.close()

# Set page configuration
st.set_page_config(page_title="Account", page_icon=":fire:", layout="wide")

# Display title and description
st.title("Accounts")
st.write(":grey[_Here you can create an account or check if account exists._]")

# Create input fields for first name, middle name, and last name
col = st.columns((3,3,3))
with col[0]:
    fname = st.text_input("Enter your first name", key="fname")
with col[1]:
    mname = st.text_input("Enter your middle name", key="mname")
with col[2]:
    lname = st.text_input("Enter your last name", key="lname")

# Check if the "Next" button is clicked
if st.button("Next"):

    # Perform a database query to check if the name exists
    if check_in_database(fname, mname, lname):
        st.success(f"Name '{fname, mname, lname}' found in the database!")
        
    else:
        st.error(f"Name '{fname, mname, lname}' not found in the database!")
        st.write("Create new account with name '{fname, mname, lname}")
        
        # Collect additional information for creating a new account
        gender = st.selectbox("Select Gender", ('Male', 'Female'))
        phone = st.number_input("Enter phone number", min_value=0)
        email = st.text_input("Enter email address")
        address = st.text_input("Enter address")
        dob = st.date_input("Enter date of Birth", format="DD/MM/YYYY")            
        city = st.text_input("Enter city name")
        country = st.text_input("Enter country name")
        submit = st.button("Submit")
        
        # Insert the new account into the database
        connection = connect_to_database()
        cursor = connection.cursor()
        cursor.execute(f"INSERT INTO Customer Values ('CT050', {fname}, {mname}, {lname}, {gender}, {phone}, {email}, {dob}, {city}, {country}, {address})")
        connection.commit()
        
        st.success("Account created successfully!")
