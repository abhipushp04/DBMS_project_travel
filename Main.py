import streamlit as st  # Importing the Streamlit library
from streamlit_option_menu import option_menu  # Importing a custom module called "streamlit_option_menu"
import streamlit_authenticator as sta  # Importing a custom module called "streamlit_authenticator"
import pandas as pd  # Importing the Pandas library
from streamlit_carousel import carousel  # Importing a custom module called "streamlit_carousel"

# st.title("Login Page")
# # Define username and password
# username = st.text_input("Username")
# password = st.text_input("Password", type="password")
# st.button("Login")
# # Check if username and password are correct
# if username == "admin" and password == "password":
#     st.success("Logged in as {}".format(username))
#     # Add your content here for when the user is logged in

# Connect to MySQL database
import mysql.connector  # Importing the MySQL Connector library

mydb = mysql.connector.connect(
    host="localhost",  # MySQL server host
    user="root",  # MySQL username
    password="abhipushp",  # MySQL password
    database="2000_sql_project"  # MySQL database name
)
mycursor = mydb.cursor()
print("Database connected")  # Printing a message to indicate successful database connection

st.set_page_config(page_title="Homepage", page_icon=":fire:", layout="wide")  # Setting the page configuration
st.title("Travel :blue[Database] Management :mountain:")  # Displaying a title on the page
st.write(":grey[_Services offered include booking packages, managing accounts, and viewing database tables, etc._]")  # Displaying a message on the page

test_items = [
    dict(
        title="Hawa Mahal",  # Title of the item
        text="A palace in Jaipur, India",  # Description of the item
        interval=None,  # Interval for automatic carousel rotation (None means no rotation)
        img="https://e1.pxfuel.com/desktop-wallpaper/273/671/desktop-wallpaper-india-s-most-amazing-places-30-to-enchant-you-indian-palace.jpg",  # Image URL for the item
    ),
    dict(
        title="The Golden Temple",  # Title of the item
        text="Gurdwara located in the city of Amritsar, Punjab, India.",  # Description of the item
        img="https://miro.medium.com/v2/resize:fit:2000/1*jN5OXdbxDaNXlrzWfmZIig.jpeg",  # Image URL for the item
    ),
    dict(
        title="Banaras",  # Title of the item
        text="A city in the northern Indian state of Uttar Pradesh",  # Description of the item
        img="https://wallpaperaccess.com/full/211126.jpg",  # Image URL for the item
    ),
    dict(
        title="Sun Temple",  # Title of the item
        text="A 13th-century CE Sun Temple at Konark in Odisha, India.",  # Description of the item
        img="https://vajiram-prod.s3.ap-south-1.amazonaws.com/Konark_Sun_Temple_13e71cbb6e.jpg",  # Image URL for the item
    ),
]

carousel(items=test_items, height=450)  # Displaying a carousel with the specified items and height
