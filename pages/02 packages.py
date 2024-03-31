import streamlit as st
from streamlit_option_menu import option_menu
import pandas as pd

# This page will contain information about packages and the user can even create custom packages using the form.
import mysql.connector

# Function to connect to the MySQL database
def connect_to_database():
    return mysql.connector.connect(
        host="localhost",
        user="root",
        password="abhipushp",
        database="2000_sql_project"
    )

# Function to fetch available packages from the database
def fetch_packages():
    try:
        connection = connect_to_database()
        cursor = connection.cursor()
        cursor.execute("SELECT pac_id, pac_name, pac_description, pac_type, pac_price, pac_duration, pac_start_date, pac_end_date  FROM package")
        packages = cursor.fetchall() 
        df = pd.DataFrame(packages, columns=[i[0] for i in cursor.description])
        return df
    except Exception as e:
        st.error(f"Error fetching packages: {e}")
    finally:
        if connection.is_connected():
            cursor.close()
            connection.close()

# Function to insert a custom package into the database
def search_custom_package(type, lowerprice, upperprice, lowerdur, upperdur):
    try:
        connection = connect_to_database()
        cursor = connection.cursor()
        if type == 'None':
            cursor.execute("SELECT pac_id, pac_name, pac_description, pac_type, pac_price, pac_duration, pac_start_date, pac_end_date  FROM package WHERE  pac_price BETWEEN %s AND %s AND pac_duration BETWEEN %s AND %s", (lowerprice, upperprice, lowerdur, upperdur))
        else:
            cursor.execute("SELECT pac_id, pac_name, pac_description, pac_type, pac_price, pac_duration, pac_start_date, pac_end_date  FROM package WHERE pac_type = %s AND pac_price BETWEEN %s AND %s AND pac_duration BETWEEN %s AND %s", (type,lowerprice, upperprice, lowerdur, upperdur))
        tables = cursor.fetchall()
        columns = [i[0] for i in cursor.description]  # Get column names
        df0 = pd.DataFrame(tables, columns=columns)
        with st.expander("Results "):
            st.write(df0)
    
    except Exception as e:
        st.error(f"Error searching for package: {e}")
    finally:
        if connection.is_connected():
            cursor.close()
            connection.close()

def visualize_packages():
    pass 

# Main function to render the webpage
def main():
    st.title("Packages :gift:")
    st.write("Here you can view available packages and search for them by applying a filter.")

    # Fetch and display available packages
    with st.expander("Available Packages"):
        packages = fetch_packages()
        st.write(packages)

    # Fetch and display available packages
    col = st.container()
    with col:
        with st.form('Form1'):
            st.markdown("🔍 _Search for available packages_")
            type = st.selectbox('Select type', ['None','Cultural', 'Leisure', 'Adventure'], key=1)
            st.markdown('---')
            st.markdown('Select Price range')
            lowerprice = st.slider(label='Min', min_value=10000, max_value=40000)
            upperprice = st.slider(label='Max', min_value=10000, max_value=40000)
            st.markdown('---')
            st.markdown('Select Duration range')
            lowerdur = st.slider(label='Min', min_value=1, max_value=15)
            upperdur = st.slider(label='Max', min_value=1, max_value=15)
            
            # Adjust the layout for button placement
            col1, col2 = st.columns([2, 2])  # Split the layout into two columns
            # Submit button
            with col1:
                submitted = st.form_submit_button('Submit')
                
            # Reset button
            with col2:
                if st.form_submit_button('Reset'):
                    # Reset all values to default
                    type = 'None'
                    lowerprice, upperprice = 10000, 40000
                    lowerdur, upperdur = 1, 15
                    st.experimental_rerun()  # Rerun the script to apply the reset
            
            if submitted:
                search_custom_package(type, lowerprice, upperprice, lowerdur, upperdur)
                
if __name__ == "__main__":
    main()
