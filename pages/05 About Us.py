import streamlit as st

# This page will contain information about the project and the contributors.

# Set the title of the page
st.title("About Us :sunglasses:")

# Create a container with a border
with st.container(border=True):
    # Add a markdown section with information about the project
    st.markdown("This Webapp is running on Streamlit and is a part of our final project for the course DBMS(Database management System).")
    st.markdown("The project is about a travel agency that provides services like booking flights, hotels, and rental cars. The project is built using MySQL for the database and Python for the backend. The frontend is built using Streamlit. The project is a group project and is built by 3 students from MBA Tech AI.")
    
    # Add a markdown section with information about the contributors
    st.markdown("#### **Contributors:-**")
    st.markdown("#### R004 - Abhipushp Maurya")
    st.markdown("#### R006 - Amay Doshi")
    st.markdown("#### R007 - Arya Gupte")