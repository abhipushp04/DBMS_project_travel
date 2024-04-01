import streamlit as st
from streamlit_option_menu import option_menu
import pandas as pd
import numpy as np
import datetime
from tabulate import tabulate

import mysql.connector

# Function to connect to the database
def connect_to_database():
    return mysql.connector.connect(
        host="localhost",
        user="root",
        password="abhipushp",
        database="2000_sql_project"
    )

# Function to check if the name exists in the database
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

# Function to insert a booking into the database
def insert_booking(bkn_id, bkn_status, bkn_no_ppl, bkn_date, veh_id, stay_id, tra_id, pac_id, cust_id):
    try:
        connection = connect_to_database()
        cursor = connection.cursor()

        # Inserting values into the Booking table
        insert_query = "INSERT INTO Booking (bkn_id, bkn_status, bkn_no_ppl, bkn_date, veh_id, stay_id, tra_id, pac_id, cust_id) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)"
        values = (bkn_id, bkn_status, bkn_no_ppl, bkn_date, veh_id, stay_id, tra_id, pac_id, cust_id)
        cursor.execute(insert_query, values)
        # Commit the transaction
        connection.commit()
        # Display success message
        st.SUCCESS("Booking inserted successfully!")
    except mysql.connector.Error as err:
        # Display error message if the insertion fails
        print(f"Error inserting booking: {err}")
    finally:
        # Close the database connection
        if connection.is_connected():
            cursor.close()
            connection.close()

# Function to book a stay
def book_stay():
    col = st.container()
    with col:
        with st.form('Form1'):
            st.title("Book Stay")
            connection = connect_to_database()
            cursor = connection.cursor()
            cursor.execute("SELECT DISTINCT dest_city FROM Destination")
            city = cursor.fetchall()
            cursor.execute(f"SELECT cust_id FROM Customer")
            cust_id = cursor.fetchall()
            cid = st.selectbox(f"Select a customerID ", [i[0] for i in cust_id])
            source = st.selectbox("Select a Source City", [i[0] for i in city])
            destination = st.selectbox("Select a Destination City", [i[0] for i in city])
            date = st.date_input(label = "Select a date for your trip", format = "DD/MM/YYYY")
            no_ppl = st.number_input(label = "Select the number of people", min_value = 1, max_value = 30, value = 1)
            days = st.number_input(label ="Select the number of days", min_value = 1, max_value = 30, value = 1)
            submit = st.form_submit_button("Submit")
            
            if submit:
                try:
                    # Fetch stay options from the database
                    cursor.execute(f"SELECT stay_name, stay_phone, stay_address, stay_roomtype, stay_capacity, stay_pricePerDay, stay_rating FROM Stay Natural Join Destination WHERE stay_city = '{destination}'")
                    tables = cursor.fetchall()
                    columns = [i[0] for i in cursor.description]  # Get column names
                    df0 = pd.DataFrame(tables, columns=columns)
                    with st.expander("Results "):
                        st.write(df0)
                    selected_option = st.radio("Select Hotel to stay at", df0)
                    book_date = datetime.date.today()
                    cursor.execute(f"SELECT stay_id FROM Stay WHERE stay_name = '{selected_option}'")
                    stay_id = cursor.fetchone()
                    insert_booking("BK030", "Confirmed", no_ppl, "book_date", "","2024-04-01" , "", "", "CT030")
                    cursor.execute(f"SELECT stay_pricePerDay FROM Stay WHERE stay_name = '{selected_option}'")
                    price = cursor.fetchone()[0]
                    st.write("Confirmed Booking")
                    st.markdown("#### Billing Details")
                    billing_data = [
                        ["Customer ID", cid],
                        ["Stay ID", stay_id],
                        ["Stay name", selected_option],
                        ["Destination", destination],
                        ["Number of people", no_ppl],
                        ["Days", days],
                        ["Total amount", days * price ],
                    ]
                    
                    billdf = pd.DataFrame(billing_data)
                    st.write("Confirmed Booking")
                    st.markdown("#### Billing Details")
                    st.write("---")
                    st.write(billdf)
                    total_amt = days*price
                    cursor.execute("INSERT INTO Payment Values (%s,%s,%s,%s,%s,%s)", ("PY021", "Successful", total_amt,"Credit Card","","2024-04-01"))
                    st.write(":green[_Payment Successful!!!_]")
                except Exception as e:
                    st.error(f"Error searching for hotels: {e}")
                finally:
                    if connection.is_connected():
                        cursor.close()
                        connection.close()

# Function to book a vehicle
def book_vehicle():
    col = st.container()
    with col:
        with st.form('Form1'):
            st.title("Book Vehicle")
            connection = connect_to_database()
            cursor = connection.cursor()
            cursor.execute("SELECT DISTINCT veh_current_loc FROM Vehicle")
            vehicle = cursor.fetchall()
            vehicle_destination = st.selectbox("Select a Destination City", [i[0] for i in vehicle])
            date = st.date_input(label = "Select a date ", format = "DD/MM/YYYY")
            days = st.number_input(label ="Select the number of days", min_value = 1, max_value = 30, value = 1)
            submit = st.form_submit_button("Submit")
            if submit:
                try:
                    # Fetch vehicle options from the database
                    cursor.execute(f"SELECT veh_model, veh_numberplate, veh_type, veh_capacity, veh_rate FROM Vehicle WHERE veh_current_loc = '{vehicle_destination}'")
                    tables = cursor.fetchall()
                    columns = [i[0] for i in cursor.description]  # Get column names
                    df1 = pd.DataFrame(tables, columns=columns)
                    with st.expander("Results"):
                        st.write(df1)
                    selected_option = st.radio("Select Vehicle to book", df1)
                    cursor.execute(f"SELECT veh_rate FROM vehicle WHERE veh_model ='{selected_option}'")
                    price = cursor.fetchone()[0]
                    cursor.execute(f"SELECT veh_model FROM vehicle WHERE veh_model ='{selected_option}'")
                    veh_model = cursor.fetchone()[0]
                    cursor.execute(f"SELECT veh_numberplate FROM vehicle WHERE veh_model ='{selected_option}'")
                    veh_numberplate = cursor.fetchone()[0]
                    cursor.execute(f"SELECT driver_id FROM Vehicle WHERE veh_model ='{selected_option}'")
                    driver_id = cursor.fetchone()[0]
                    cursor.execute(f"Select * from driver where driver_id = '{driver_id}'")
                    driver = cursor.fetchall()
                    driver = pd.DataFrame(driver)
                    
                    # Generate a bill for this vehicle booking
                    total_amt = days * price
                    st.write(total_amt)

                    billing_data = [
                        ["Vehicle Model", veh_model],
                        ["Vehicle Numberplate", veh_numberplate],
                        ["Destination", vehicle_destination],
                        ["Number of days", days],
                        ["Total amount", total_amt]
                    ]
                    
                    billdf = pd.DataFrame(billing_data, columns=["Description", "Value"])
                    st.write(billdf)
                    st.write("Confirmed Booking")
                    st.markdown("#### Billing Details")
                    st.write("---")
                    st.write(billdf)
                    st.write("---")
                    st.write("Driver details")
                    st.write(driver)
                    cursor.execute("INSERT INTO Payment Values (%s,%s,%s,%s,%s,%s)", ("PY021", "Successful", total_amt,"Credit Card","","2024-04-01"))
                    st.write(":green[_Payment Successful!!!_]")
                except Exception as e:
                    st.error(f"Error searching for vehicles: {e}")
                finally:
                    if connection.is_connected():
                        cursor.close()
                        connection.close()

# Function to book travel
def book_travel():
    col = st.container()
    with col:
        with st.form('Form1'):
            st.title("Book Travel")
            connection = connect_to_database()
            cursor = connection.cursor()
            cursor.execute("SELECT DISTINCT tra_source FROM Travel")
            tra_source = cursor.fetchall()
            cursor.execute("SELECT DISTINCT tra_destination FROM Travel")
            tra_destination = cursor.fetchall()
            source = st.selectbox("Select a Source City", [i[0] for i in tra_source])
            destination = st.selectbox("Select a Destination City", [i[0] for i in tra_destination])
            date = st.date_input(label = "Select a date for your trip", format = "DD/MM/YYYY")
            No_tickets = st.number_input(label ="Select the number of tickets", min_value = 1, max_value = 30, value = 1)
            submit = st.form_submit_button("Submit")
            if submit:
                try:
                    # Fetch travel options from the database
                    cursor.execute(f"SELECT tra_type, ticket_price, tra_from_date, tra_from_time, tra_to_date, tra_to_time  FROM travel WHERE tra_source = '{source}' AND tra_destination = '{destination}' AND tra_from_date >= {date}")
                    tables = cursor.fetchall()
                    columns = [i[0] for i in cursor.description]  # Get column names
                    df2 = pd.DataFrame(tables, columns=columns)
                    with st.expander("Results"):
                        st.write(df2)
                    selected_option = st.radio("Select Mode of Travel", df2)
                    st.write(selected_option)
                    ticket_price = df2['ticket_price'][0]
                    # Calculate total amount
                    total_amt = ticket_price * No_tickets

                    # Generate bill
                    billing_data = [
                        ["Source", source],
                        ["Destination", destination],
                        ["Date", date],
                        ["Number of Tickets", No_tickets],
                        ["Total Amount", total_amt]
                    ]
                    
                    billdf = pd.DataFrame(billing_data, columns=["Description", "Value"])
                    st.write(billdf)
                    st.write("Confirmed Booking")
                    st.markdown("#### Billing Details")
                    st.write("---")
                    st.write(billdf)
                    st.write("---")
                    
                except Exception as e:
                    st.error(f"Error searching for travel options: {e}")
                finally:
                    if connection.is_connected():
                        cursor.close()
                        connection.close()

# Set Streamlit page configuration
st.set_page_config(page_title="Homepage", page_icon=":ticket:", layout="wide")
st.title("_Booking_ :airplane: :hotel: :star:")
st.write(":grey[_Here you can book your tickets and hotels for your trip!_]")

# Get user input for name
col = st.columns((3,3,3))
with col[0]:
    fname = st.text_input("Enter your first name", key="fname")
with col[1]:
    mname = st.text_input("Enter your middle name", key="mname")
with col[2]:
    lname = st.text_input("Enter your last name", key="lname")

if st.button("Next"):
    # Perform a database query to check if the name exists
    if check_in_database(fname, mname, lname):
        st.success(f"Name '{fname, mname, lname}' found in the database!")
    else:
        st.error(f"Name '{fname, mname, lname}' not found in the database.\n Please create an account and try again.")

# Display booking options
selected_option = st.radio("Select Booking Option:", ["Book Stay", "Book Vehicle", "Book Travel"])

# Handle user selection
if selected_option == "Book Stay":
    book_stay()
elif selected_option == "Book Vehicle":
    book_vehicle()
elif selected_option == "Book Travel":
    book_travel()
