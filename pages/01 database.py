import streamlit as st
from streamlit_option_menu import option_menu
import pandas as pd

import mysql.connector

# Set up the Streamlit app
st.title('_Database_ :blue[Tables] :books:')
st.write(":grey[_Here are the tables in the database._]")

# Connect to the MySQL database
mydb = mysql.connector.connect(
    host="localhost", 
    user="root",
    password="abhipushp",
    database = "2000_sql_project"
)
mycursor = mydb.cursor()
print("Database connected")

# Create a form for the user to enter a query
with st.form(key='my_form'):
    query = st.text_input(label='Enter your Query', placeholder='SELECT * FROM table_name')
    submit = st.form_submit_button(label='Submit')
    if submit:    
        # Execute the user's query
        mycursor.execute(query)
        tables = mycursor.fetchall()
        columns = [i[0] for i in mycursor.description]  # Get column names
        df0 = pd.DataFrame(tables, columns=columns)
        with st.expander("Output"):
            st.write(df0)
    
# Get the tables in the database
mycursor.execute("select * from customer")
tables = mycursor.fetchall()
columns = [i[0] for i in mycursor.description]  # Get column names
df1 = pd.DataFrame(tables, columns=columns)
with st.expander("Customer Table"):
    st.write(df1)
    
mycursor.execute("select * from employee")
tables = mycursor.fetchall()
columns = [i[0] for i in mycursor.description]  # Get column names
df2 = pd.DataFrame(tables, columns=columns)
with st.expander("Employee Table"):
    st.write(df2)
    
mycursor.execute("select * from Agent")
tables = mycursor.fetchall()
columns = [i[0] for i in mycursor.description]  # Get column names
df3 = pd.DataFrame(tables, columns=columns)
with st.expander("Agent Table"):
    st.write(df3)
    
mycursor.execute("select * from Driver")
tables = mycursor.fetchall()
columns = [i[0] for i in mycursor.description]  # Get column names
df4 = pd.DataFrame(tables, columns=columns)
with st.expander("Driver Table"):
    st.write(df4)
    
mycursor.execute("select * from Destination")
tables = mycursor.fetchall()
columns = [i[0] for i in mycursor.description]  # Get column names
df5 = pd.DataFrame(tables, columns=columns)
with st.expander("Destination Table"):
    st.write(df5)
    
mycursor.execute("select * from Stay")
tables = mycursor.fetchall()
columns = [i[0] for i in mycursor.description]  # Get column names
df6 = pd.DataFrame(tables, columns=columns)
with st.expander("Stay Table"):
    st.write(df6)
    
mycursor.execute("select * from Vehicle")
tables = mycursor.fetchall()
columns = [i[0] for i in mycursor.description]  # Get column names
df7 = pd.DataFrame(tables, columns=columns)
with st.expander("Vehicle Table"):
    st.write(df7)
    
mycursor.execute("select * from Inquiry")
tables = mycursor.fetchall()
columns = [i[0] for i in mycursor.description]  # Get column names
df8 = pd.DataFrame(tables, columns=columns)
with st.expander("Inquiry Table"):
    st.write(df8)
    
mycursor.execute("select * from Travel")
tables = mycursor.fetchall()
columns = [i[0] for i in mycursor.description]  # Get column names
df9 = pd.DataFrame(tables, columns=columns)
with st.expander("Travel Table"):
    st.write(df9)
    
mycursor.execute("select * from Feedback")
tables = mycursor.fetchall()
columns = [i[0] for i in mycursor.description]  # Get column names
df10 = pd.DataFrame(tables, columns=columns)
with st.expander("Feedback Table"):
    st.write(df10)
    
mycursor.execute("select * from Package")
tables = mycursor.fetchall()
columns = [i[0] for i in mycursor.description]  # Get column names
df11 = pd.DataFrame(tables, columns=columns)
with st.expander("Package Table"):
    st.write(df11)
    
mycursor.execute("select * from Booking")
tables = mycursor.fetchall()
columns = [i[0] for i in mycursor.description]  # Get column names
df12 = pd.DataFrame(tables, columns=columns)
with st.expander("Booking Table"):
    st.write(df12)
    
# Display the number of values in each table
st.subheader("Number of values in each table")
col = st.columns((2,2))
tables = ['Customer', 'Employee', 'Agent', 'Driver', 'Destination', 'Stay', 'Vehicle', 'Inquiry', 'Travel', 'Feedback', 'Package', 'Booking']
for i, df in enumerate([df1, df2, df3, df4, df5, df6, df7, df8, df9, df10, df11, df12]):
    with col[i % 2]:
        with st.container(border=True):
            st.write(df.shape[0], tables[i], "Table")
