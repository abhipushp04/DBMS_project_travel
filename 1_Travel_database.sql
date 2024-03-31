DROP DATABASE IF EXISTS 2000_sql_project;
CREATE DATABASE IF NOT EXISTS 2000_sql_project;
USE 2000_sql_project;

DROP TABLE IF EXISTS Customer;
CREATE TABLE IF NOT EXISTS Customer(
cust_id varchar(10) PRIMARY KEY,
cust_fname varchar(30) NOT NULL,
cust_mname varchar(30) NOT NULL,
cust_lname varchar(30) NOT NULL,
cust_sex varchar(10) NOT NULL,
cust_phone varchar(10),
cust_email varchar(50),
cust_dob date NOT NULL,
cust_city varchar(30) NOT NULL,
cust_country varchar(30) NOT NULL,
cust_address varchar(100) NOT NULL
);

DROP TABLE IF EXISTS Employee;
CREATE TABLE IF NOT EXISTS Employee(
emp_id varchar(10) PRIMARY KEY,
emp_fname varchar(30) NOT NULL,
emp_mname varchar(30) NOT NULL,
emp_lname varchar(30) NOT NULL, 
emp_sex varchar(10) NOT NULL,
emp_phone varchar(10),
emp_email varchar(50),
emp_dob date NOT NULL,
emp_joindate date NOT NULL,
emp_role varchar(30) NOT NULL,
emp_salary float(10,2) NOT NULL,
emp_city varchar(30) NOT NULL,
emp_address varchar(100) NOT NULL
); 

-- Create Agent table
DROP TABLE IF EXISTS Agent;
CREATE TABLE IF NOT EXISTS Agent (
agent_id VARCHAR(10) PRIMARY KEY,
agent_fname VARCHAR(30) NOT NULL,
agent_mname VARCHAR(30) NOT NULL,
agent_lname VARCHAR(30) NOT NULL,
agent_sex VARCHAR(10) NOT NULL,
agent_phone VARCHAR(10),
agent_email VARCHAR(50),
agent_dob DATE NOT NULL,
agent_joindate DATE NOT NULL,
agent_salary FLOAT(10,2) NOT NULL,
agent_city VARCHAR(30) NOT NULL,
agent_address VARCHAR(100) NOT NULL,
FOREIGN KEY (agent_id) REFERENCES Employee(emp_id)
);

-- Create Driver table
DROP TABLE IF EXISTS Driver;
CREATE TABLE IF NOT EXISTS Driver (
driver_id VARCHAR(10) PRIMARY KEY,
driver_licno VARCHAR(30),
driver_fname VARCHAR(30) NOT NULL,
driver_mname VARCHAR(30) NOT NULL,
driver_lname VARCHAR(30) NOT NULL,
driver_sex VARCHAR(10) NOT NULL,
driver_phone VARCHAR(10),
driver_email VARCHAR(50),
driver_dob DATE NOT NULL,
driver_joindate DATE NOT NULL,
driver_salary FLOAT(10,2) NOT NULL,
driver_city VARCHAR(30) NOT NULL,
driver_address VARCHAR(100) NOT NULL,
FOREIGN KEY (driver_id) REFERENCES Employee(emp_id)
);

DROP TABLE IF EXISTS Destination;
CREATE TABLE IF NOT EXISTS Destination(
dest_id varchar(10) PRIMARY KEY,
dest_city varchar(30) NOT NULL,
dest_state varchar(30) NOT NULL,
dest_country varchar(30) NOT NULL
);

DROP TABLE IF EXISTS Stay;
CREATE TABLE IF NOT EXISTS Stay(
stay_id varchar(10) PRIMARY KEY,
stay_name varchar(30) NOT NULL,
stay_phone VARCHAR(10) NOT NULL,
stay_city varchar(30) NOT NULL,
stay_address varchar(100) NOT NULL,
stay_roomtype varchar(30) NOT NULL,
stay_capacity int ,
stay_pricePerDay float(10,2) NOT NULL,
stay_available boolean,
stay_rating float(10,2),
dest_id varchar(10),
FOREIGN KEY (dest_id) REFERENCES Destination(dest_id)
);

DROP TABLE IF EXISTS Vehicle;
CREATE TABLE IF NOT EXISTS Vehicle(
veh_id varchar(10) PRIMARY KEY,
veh_type varchar(30) NOT NULL,
veh_source_loc varchar(30),
veh_current_loc varchar(30),
veh_availability boolean,
veh_capacity int ,
veh_rate float(10, 2),
veh_model varchar(30),
veh_numberplate varchar(20),
driver_id varchar(10),
FOREIGN KEY (driver_id) REFERENCES Driver(driver_id)
);

DROP TABLE IF EXISTS Inquiry;
CREATE TABLE IF NOT EXISTS Inquiry(
inq_id varchar(10) PRIMARY KEY,
inq_category varchar(30) NOT NULL,
inq_fname varchar(30),
inq_mname varchar(30),
inq_lname varchar(30),
inq_detail varchar(100),
inq_status varchar(30),
cust_id varchar(10),
agent_id varchar(10),
FOREIGN KEY (cust_id) REFERENCES Customer(cust_id),
FOREIGN KEY (agent_id) REFERENCES Agent(agent_id)
);

DROP TABLE IF EXISTS Travel;
CREATE TABLE IF NOT EXISTS Travel(
tra_id VARCHAR(10) PRIMARY KEY,
tra_no_ppl INT, -- per seat price
tra_from_time TIME,
tra_from_date DATE,
tra_to_time TIME,
tra_to_date DATE,
tra_type VARCHAR(30),
tra_source VARCHAR(30),
tra_destination VARCHAR(30)
);

ALTER TABLE Travel
ADD COLUMN ticket_price DECIMAL(10, 2) AFTER tra_type,
DROP COLUMN tra_no_ppl;

DROP TABLE IF EXISTS Feedback;
CREATE TABLE IF NOT EXISTS Feedback(
feed_id VARCHAR(10) PRIMARY KEY,
feed_text VARCHAR(200),
feed_rating INT,
feed_category VARCHAR(30),
feed_date DATE,
cust_id VARCHAR(10),
FOREIGN KEY (cust_id) REFERENCES Customer(cust_id)
);

DROP TABLE IF EXISTS Package;
CREATE TABLE IF NOT EXISTS Package(
pac_id varchar(10) PRIMARY KEY,
pac_name varchar(30) NOT NULL,
pac_description varchar(100) NOT NULL,
pac_type varchar(30) NOT NULL,   				-- LIKE ADVENTURE, FAMILY, LIESURE, etc.
pac_price decimal(10,2),
pac_start_date date,
pac_end_date date,
pac_duration int,
tra_id varchar(10),
stay_id varchar(10),
veh_id varchar(10),
FOREIGN KEY (tra_id) REFERENCES Travel(tra_id),
FOREIGN KEY (stay_id) REFERENCES Stay(stay_id),
FOREIGN KEY (veh_id) REFERENCES Vehicle(veh_id)
);

DROP TABLE IF EXISTS Booking;
CREATE TABLE IF NOT EXISTS Booking(
bkn_id VARCHAR(10) PRIMARY KEY,
bkn_status VARCHAR(30),
bkn_no_ppl INT,
bkn_date DATE,
veh_id VARCHAR(10),
stay_id VARCHAR(10),
tra_id VARCHAR(10),
pac_id VARCHAR(10),
cust_id VARCHAR(10),
FOREIGN KEY (veh_id) REFERENCES Vehicle(veh_id),
FOREIGN KEY (stay_id) REFERENCES Stay(stay_id),
FOREIGN KEY (tra_id) REFERENCES Travel(tra_id),
FOREIGN KEY (pac_id) REFERENCES Package(pac_id),
FOREIGN KEY (cust_id) REFERENCES Customer(cust_id)
);

DROP TABLE IF EXISTS Payment;
CREATE TABLE IF NOT EXISTS Payment(
pay_id VARCHAR(10) PRIMARY KEY,
pay_status VARCHAR(30) NOT NULL,
pay_amount FLOAT(10, 2) NOT NULL,
pay_method VARCHAR(30),
pay_time TIME,
pay_date DATE
);


-- SHOW TABLES;


INSERT INTO Customer (cust_id, cust_fname, cust_mname, cust_lname, cust_sex, cust_phone, cust_email, cust_dob, cust_city, cust_country, cust_address) 
VALUES
('CT001', 'Rahul', 'Kumar', 'Sharma', 'Male', '9876543210', 'rahul.sharma@example.com', '1990-05-15', 'New Delhi', 'India', '12, Connaught Place, New Delhi'),
('CT002', 'Aarti', 'Suresh', 'Kapoor', 'Female', '9087654321', 'aarti.kapoor@example.com', '1985-11-28', 'Mumbai', 'India', 'Flat No. 501, Juhu Tara Road, Mumbai'),
('CT003', 'Vikram', 'Aditya', 'Singh', 'Male', '8765432109', 'vikram.singh@example.com', '1992-03-12', 'Bengaluru', 'India', '24/7, Richmond Road, Bengaluru'),
('CT004', 'Priya', 'Ramesh', 'Rajan', 'Female', '7654321098', 'priya.rajan@example.com', '1988-09-05', 'Chennai', 'India', '8, Cathedral Road, Chennai'),
('CT005', 'Vivek', 'Rajesh', 'Gupta', 'Male', '9012345678', 'vivek.gupta@example.com', '1982-07-22', 'Kolkata', 'India', '3A, Shakespeare Sarani, Kolkata'),
('CT006', 'Sonal', 'Amit', 'Desai', 'Female', '8901234567', 'sonal.desai@example.com', '1995-12-03', 'Ahmedabad', 'India', '10B, C.G. Road, Ahmedabad'),
('CT007', 'Arjun', 'Mohan', 'Reddy', 'Male', '7890123456', 'arjun.reddy@example.com', '1989-04-18', 'Hyderabad', 'India', 'Plot No. 12, Banjara Hills, Hyderabad'),
('CT008', 'Pooja', 'Sunil', 'Mehta', 'Female', '6789012345', 'pooja.mehta@example.com', '1993-08-29', 'Pune', 'India', 'Flat No. 203, Kalyani Nagar, Pune'),
('CT009', 'Rishab', 'Anil', 'Bhatt', 'Male', '5678901234', 'rishab.bhatt@example.com', '1987-02-10', 'Jaipur', 'India', 'B-14, Vaishali Nagar, Jaipur'),
('CT010', 'Anjali', 'Vinod', 'Rajput', 'Female', '4567890123', 'anjali.rajput@example.com', '1991-11-23', 'Lucknow', 'India', '7/A, Hazratganj, Lucknow'),
('CT011', 'Rohan', 'Kishore', 'Malhotra', 'Male', '9876543210', 'rohan.malhotra@example.com', '1992-07-18', 'Delhi', 'India', '21, Connaught Place, New Delhi'),
('CT012', 'Ishita', 'Rajesh', 'Patel', 'Female', '8765432109', 'ishita.patel@example.com', '1988-03-05', 'Ahmedabad', 'India', 'A-12, Navrangpura, Ahmedabad'),
('CT013', 'Aditya', 'Suresh', 'Rao', 'Male', '7654321098', 'aditya.rao@example.com', '1995-11-29', 'Bengaluru', 'India', '5/B, Indiranagar, Bengaluru'),
('CT014', 'Nisha', 'Vinod', 'Sharma', 'Female', '6543210987', 'nisha.sharma@example.com', '1990-09-12', 'Mumbai', 'India', 'Flat 303, Worli Sea Face, Mumbai'),
('CT015', 'Rohit', 'Anil', 'Saxena', 'Male', '5432109876', 'rohit.saxena@example.com', '1985-04-22', 'Lucknow', 'India', '8, Hazratganj, Lucknow'),
('CT016', 'Deepika', 'Rakesh', 'Banerjee', 'Female', '4321098765', 'deepika.banerjee@example.com', '1993-01-07', 'Kolkata', 'India', '12/A, Park Street, Kolkata'),
('CT017', 'Arjun', 'Mohan', 'Singh', 'Male', '3210987654', 'arjun.singh@example.com', '1987-08-31', 'Jaipur', 'India', 'B-14, Vaishali Nagar, Jaipur'),
('CT018', 'Preeti', 'Sunil', 'Gupta', 'Female', '2109876543', 'preeti.gupta@example.com', '1994-06-19', 'Hyderabad', 'India', '9, Banjara Hills, Hyderabad'),
('CT019', 'Nitin', 'Ravi', 'Sharma', 'Male', '1098765432', 'nitin.sharma@example.com', '1991-12-03', 'Chennai', 'India', '25, Anna Salai, Chennai'),
('CT020', 'Sonam', 'Rakesh', 'Kapoor', 'Female', '9087654321', 'sonam.kapoor@example.com', '1989-05-15', 'Pune', 'India', 'Flat 201, Koregaon Park, Pune'),
('CT021', 'Rishab', 'Amit', 'Desai', 'Male', '8976543210', 'rishab.desai@example.com', '1996-10-28', 'Surat', 'India', '3/A, Athwa Lines, Surat'),
('CT022', 'Neha', 'Sanjay', 'Kapoor', 'Female', '7865432109', 'neha.kapoor@example.com', '1993-03-11', 'Indore', 'India', '10B, Vijay Nagar, Indore'),
('CT023', 'Aryan', 'Vivek', 'Sharma', 'Male', '6754321098', 'aryan.sharma@example.com', '1997-08-22', 'Chandigarh', 'India', '12, Sector 17, Chandigarh'),
('CT024', 'Ria', 'Aditya', 'Patel', 'Female', '5643210987', 'ria.patel@example.com', '1986-02-07', 'Vadodara', 'India', '8/A, Alkapuri, Vadodara'),
('CT025', 'Naveen', 'Rohan', 'Singh', 'Male', '4532109876', 'naveen.singh@example.com', '1992-09-30', 'Guwahati', 'India', '21, G.S. Road, Guwahati'),
('CT026', 'Aditi', 'Rahul', 'Rao', 'Female', '3421098765', 'aditi.rao@example.com', '1989-07-14', 'Mysore', 'India', '5, Devaraja Urs Road, Mysore'),
('CT027', 'Siddharth', 'Neeraj', 'Kapoor', 'Male', '2310987654', 'siddharth.kapoor@example.com', '1995-12-25', 'Nagpur', 'India', '3B, Dharampeth, Nagpur'),
('CT028', 'Priya', 'Ajay', 'Gupta', 'Female', '1209876543', 'priya.gupta@example.com', '1990-04-18', 'Visakhapatnam', 'India', 'Flat 501, Beach Road, Visakhapatnam'),
('CT029', 'Ankit', 'Sanjay', 'Sharma', 'Male', '9765432109', 'ankit.sharma@example.com', '1994-11-02', 'Coimbatore', 'India', '7, Cross Cut Road, Coimbatore'),
('CT030','Abhipushp','Pushpkumar','Maurya','Male','1234567348','abhipushp@example.com','2004-01-30','Mumbai','India','5th Avenue park, Mumbai'),
('CT031', 'Priyanka', 'Avinash', 'Rai', 'Female', '8654321098', 'priyanka.rai@example.com', '1991-06-27', 'Bhopal', 'India', '12/B, Arera Colony, Bhopal');


INSERT INTO Employee (emp_id, emp_fname, emp_mname, emp_lname, emp_sex, emp_phone, emp_email, emp_dob, emp_joindate, emp_role, emp_salary, emp_city, emp_address)
VALUES
('EM001', 'Raj', 'Kumar', 'Singh', 'Male', '9876543210', 'raj.singh@example.com', '1985-03-12', '2015-06-01', 'Driver', 35000.00, 'Delhi', '12, Chandni Chowk, Delhi'),
('EM002', 'Meera', 'Dheeraj', 'Kapoor', 'Female', '9012345678', 'meera.kapoor@example.com', '1990-11-25', '2018-02-15', 'Agent', 45000.00, 'Mumbai', 'Flat 201, Marine Drive, Mumbai'),
('EM003', 'Arjun', 'Vikram', 'Reddy', 'Male', '8765432109', 'arjun.reddy@example.com', '1988-07-03', '2016-10-01', 'Driver', 38000.00, 'Hyderabad', '5/A, Banjara Hills, Hyderabad'),
('EM004', 'Priya', 'Ramesh', 'Sharma', 'Female', '7890123456', 'priya.sharma@example.com', '1992-04-18', '2020-01-10', 'Agent', 42000.00, 'Bengaluru', '24, MG Road, Bengaluru'),
('EM005', 'Rahul', 'Suresh', 'Gupta', 'Male', '6789012345', 'rahul.gupta@example.com', '1986-09-22', '2017-05-01', 'Manager', 60000.00, 'Kolkata', '3B, Park Street, Kolkata'),
('EM006', 'Sanjana', 'Aditya', 'Patel', 'Female', '5678901234', 'sanjana.patel@example.com', '1994-12-08', '2021-03-15', 'Agent', 40000.00, 'Ahmedabad', '10, CG Road, Ahmedabad'),
('EM007', 'Vikram', 'Anil', 'Ravi', 'Male', '4567890123', 'vikram.ravi@example.com', '1989-06-30', '2019-08-01', 'Driver', 36000.00, 'Chennai', '8, Anna Salai, Chennai'),
('EM008', 'Sneha', 'Vinod', 'Kapoor', 'Female', '3456789012', 'sneha.kapoor@example.com', '1993-02-14', '2022-07-01', 'Agent', 39000.00, 'Pune', '203, Koregaon Park, Pune'),
('EM009', 'Amit', 'Rajesh', 'Sharma', 'Male', '2345678901', 'amit.sharma@example.com', '1987-11-05', '2016-03-01', 'Manager', 65000.00, 'Jaipur', 'B-14, Vaishali Nagar, Jaipur'),
('EM010', 'Rani', 'Prakash', 'Verma', 'Female', '1234567890', 'rani.verma@example.com', '1991-08-18', '2020-09-15', 'Driver', 32000.00, 'Lucknow', '7/A, Hazratganj, Lucknow'),
('EM011', 'Avinash', 'Ramesh', 'Sharma', 'Male', '9876543210', 'avinash.sharma@example.com', '1985-07-12', '2015-03-01', 'Driver', 35000.00, 'Delhi', '21, Laxmi Nagar, New Delhi'),
('EM012', 'Shruti', 'Amit', 'Patel', 'Female', '8765432109', 'shruti.patel@example.com', '1990-11-25', '2018-06-15', 'Agent', 42000.00, 'Surat', '3/B, Athwa Lines, Surat'),
('EM013', 'Nikhil', 'Suresh', 'Rao', 'Male', '7654321098', 'nikhil.rao@example.com', '1988-04-03', '2016-09-01', 'Driver', 38000.00, 'Bengaluru', '8, Indiranagar, Bengaluru'),
('EM014', 'Priya', 'Aditya', 'Kapoor', 'Female', '6543210987', 'priya.kapoor@example.com', '1992-01-18', '2020-02-10', 'Agent', 45000.00, 'Mumbai', 'Flat 202, Worli Sea Face, Mumbai'),
('EM015', 'Rahul', 'Vinod', 'Gupta', 'Male', '5432109876', 'rahul.gupta@example.com', '1986-08-22', '2017-07-01', 'Manager', 65000.00, 'Kolkata', '10/A, Alipore, Kolkata'),
('EM016', 'Deepika', 'Rajesh', 'Singh', 'Female', '4321098765', 'deepika.singh@example.com', '1994-03-08', '2021-04-15', 'Agent', 40000.00, 'Jaipur', 'B-12, Vaishali Nagar, Jaipur'),
('EM017', 'Arjun', 'Mohan', 'Reddy', 'Male', '3210987654', 'arjun.reddy@example.com', '1989-09-30', '2019-10-01', 'Driver', 36000.00, 'Hyderabad', '5, Banjara Hills, Hyderabad'),
('EM018', 'Neha', 'Sanjay', 'Sharma', 'Female', '2109876543', 'neha.sharma@example.com', '1993-06-14', '2022-08-01', 'Agent', 39000.00, 'Pune', 'Flat 301, Koregaon Park, Pune'),
('EM019', 'Rohan', 'Anil', 'Malhotra', 'Male', '1098765432', 'rohan.malhotra@example.com', '1987-12-05', '2016-05-01', 'Manager', 70000.00, 'Chandigarh', '10, Sector 17, Chandigarh'),
('EM020', 'Ishita', 'Prakash', 'Patel', 'Female', '9087654321', 'ishita.patel@example.com', '1991-02-18', '2020-11-15', 'Driver', 32000.00, 'Ahmedabad', 'A-10, Navrangpura, Ahmedabad'),
('EM021', 'Aditya', 'Kishore', 'Rao', 'Male', '8976543210', 'aditya.rao@example.com', '1995-09-28', '2023-01-01', 'Agent', 38000.00, 'Mysore', '3/B, Devaraja Urs Road, Mysore'),
('EM022', 'Nisha', 'Sunil', 'Gupta', 'Female', '7865432109', 'nisha.gupta@example.com', '1993-05-11', '2021-07-15', 'Agent', 41000.00, 'Guwahati', '19, G.S. Road, Guwahati'),
('EM023', 'Rohit', 'Vivek', 'Saxena', 'Male', '6754321098', 'rohit.saxena@example.com', '1997-11-22', '2023-03-01', 'Driver', 34000.00, 'Lucknow', '6, Hazratganj, Lucknow'),
('EM024', 'Preeti', 'Rakesh', 'Banerjee', 'Female', '5643210987', 'preeti.banerjee@example.com', '1986-08-07', '2018-09-01', 'Agent', 46000.00, 'Kolkata', '8/A, Park Street, Kolkata'),
('EM025', 'Nitin', 'Rohan', 'Singh', 'Male', '4532109876', 'nitin.singh@example.com', '1992-04-30', '2019-02-01', 'Driver', 37000.00, 'Indore', '12B, Vijay Nagar, Indore'),
('EM026', 'Sonam', 'Rahul', 'Kapoor', 'Female', '3421098765', 'sonam.kapoor@example.com', '1989-10-14', '2017-11-01', 'Manager', 62000.00, 'Pune', 'Flat 102, Koregaon Park, Pune'),
('EM027', 'Rishab', 'Neeraj', 'Desai', 'Male', '2310987654', 'rishab.desai@example.com', '1995-06-25', '2022-03-15', 'Driver', 35500.00, 'Vadodara', '6/B, Alkapuri, Vadodara'),
('EM028', 'Aditi', 'Ajay', 'Sharma', 'Female', '1209876543', 'aditi.sharma@example.com', '1990-01-18', '2019-06-01', 'Agent', 43000.00, 'Visakhapatnam', 'Flat 301, Beach Road, Visakhapatnam'),
('EM029', 'Siddharth', 'Sanjay', 'Kapoor', 'Male', '9765432109', 'siddharth.kapoor@example.com', '1994-08-02', '2021-10-01', 'Driver', 36500.00, 'Coimbatore', '5, Cross Cut Road, Coimbatore'),
('EM030', 'Priyanka', 'Avinash', 'Rai', 'Female', '8654321098', 'priyanka.rai@example.com', '1991-03-27', '2020-04-15', 'Agent', 44000.00, 'Bhopal', '10/B, Arera Colony, Bhopal');

-- Insert data into Agent table
INSERT INTO Agent (agent_id, agent_fname, agent_mname, agent_lname, agent_sex, agent_phone, agent_email, agent_dob, agent_joindate, agent_salary, agent_city, agent_address)
SELECT emp_id, emp_fname, emp_mname, emp_lname, emp_sex, emp_phone, emp_email, emp_dob, emp_joindate, emp_salary, emp_city, emp_address
FROM Employee
WHERE emp_role = 'Agent';

-- Insert data into Driver table
INSERT INTO Driver (driver_id, driver_fname, driver_mname, driver_lname, driver_sex, driver_phone, driver_email, driver_dob, driver_joindate, driver_salary, driver_city, driver_address, driver_licno)
SELECT emp_id, emp_fname, emp_mname, emp_lname, emp_sex, emp_phone, emp_email, emp_dob, emp_joindate, emp_salary, emp_city, emp_address, '' AS driver_licno
FROM Employee
WHERE emp_role = 'Driver';

INSERT INTO Destination (dest_id, dest_city, dest_state, dest_country)
VALUES
('DT001', 'Delhi', 'Delhi', 'India'),
('DT002', 'Mumbai', 'Maharashtra', 'India'),
('DT003', 'Bengaluru', 'Karnataka', 'India'),
('DT004', 'Chennai', 'Tamil Nadu', 'India'),
('DT005', 'Kolkata', 'West Bengal', 'India'),
('DT006', 'Hyderabad', 'Telangana', 'India'),
('DT007', 'Ahmedabad', 'Gujarat', 'India'),
('DT008', 'Pune', 'Maharashtra', 'India'),
('DT009', 'Jaipur', 'Rajasthan', 'India'),
('DT010', 'Lucknow', 'Uttar Pradesh', 'India'),
('DT011', 'Goa', 'Goa', 'India'),
('DT012', 'Shimla', 'Himachal Pradesh', 'India'),
('DT013', 'Srinagar', 'Jammu and Kashmir', 'India'),
('DT014', 'Madurai', 'Tamil Nadu', 'India'),
('DT015', 'Varanasi', 'Uttar Pradesh', 'India'),

('DT016', 'Mumbai', 'Maharashtra', 'India'),
('DT017', 'Delhi', 'Delhi', 'India'),
('DT018', 'Bengaluru', 'Karnataka', 'India'),
('DT019', 'Kolkata', 'West Bengal', 'India'),
('DT020', 'Chennai', 'Tamil Nadu', 'India'),
('DT021', 'Ahmedabad', 'Gujarat', 'India'),
('DT022', 'Hyderabad', 'Telangana', 'India'),
('DT023', 'Pune', 'Maharashtra', 'India'),
('DT024', 'Jaipur', 'Rajasthan', 'India'),
('DT025', 'Srinagar', 'Jammu and Kashmir', 'India'),
('DT026', 'Goa', 'Goa', 'India'),
('DT027', 'Agra', 'Uttar Pradesh', 'India'),
('DT028', 'Udaipur', 'Rajasthan', 'India'),
('DT029', 'Kochi', 'Kerala', 'India'),
('DT030', 'Gangtok', 'Sikkim', 'India');

INSERT INTO Stay (stay_id, stay_name, stay_phone, stay_city, stay_address, stay_roomtype, stay_capacity, stay_pricePerDay, stay_available, stay_rating, dest_id)
VALUES
('ST001', 'Taj Palace', '1234567890', 'Delhi', '2, Diplomatic Enclave, Sardar Patel Marg', 'Deluxe', 4, 10000.00, true, 4.8, 'DT001'),
('ST002', 'Oberoi Trident', '2345678901', 'Mumbai', 'Nariman Point, Mumbai', 'Suite', 2, 15000.00, true, 4.9, 'DT002'),
('ST003', 'ITC Windsor Manor', '3456789012', 'Bengaluru', '25, Windsor Square, Golf Course Road', 'Premium', 3, 8000.00, true, 4.6, 'DT003'),
('ST004', 'Taj Coromandel', '4567890123', 'Chennai', '37, Mahatma Gandhi Road', 'Deluxe', 4, 12000.00, true, 4.7, 'DT004'),
('ST005', 'Oberoi Grand', '5678901234', 'Kolkata', '15, Jawaharlal Nehru Road', 'Suite', 2, 18000.00, true, 4.8, 'DT005'),
('ST006', 'Park Hyatt', '6789012345', 'Hyderabad', 'Road No. 2, Banjara Hills', 'Premium', 3, 9000.00, true, 4.5, 'DT006'),
('ST007', 'Hyatt Regency', '7890123456', 'Ahmedabad', 'Ashram Road, Usmanpura', 'Deluxe', 4, 11000.00, true, 4.6, 'DT007'),
('ST008', 'JW Marriott', '8901234567', 'Pune', 'Senapati Bapat Road, Pune', 'Suite', 2, 14000.00, true, 4.7, 'DT008'),
('ST009', 'Fairmont Jaipur', '9012345678', 'Jaipur', 'C-1, Amer Fort Road', 'Premium', 3, 7000.00, true, 4.4, 'DT009'),
('ST010', 'Piccadily', '1098765432', 'Lucknow', 'Shaheed Path, Lucknow', 'Deluxe', 4, 9000.00, true, 4.3, 'DT010'),
('ST011', 'Grand Hyatt', '2109876543', 'Goa', 'Bambolin, North Goa', 'Suite', 2, 20000.00, true, 4.9, 'DT011'),
('ST012', 'Radisson Blu', '3210987654', 'Shimla', 'Mall Road, Shimla', 'Premium', 3, 6000.00, true, 4.2, 'DT012'),
('ST013', 'Lalit Grand Palace', '4321098765', 'Srinagar', 'Guptkar Road, Srinagar', 'Deluxe', 4, 13000.00, true, 4.7, 'DT013'),
('ST014', 'Heritage Madurai', '5432109876', 'Madurai', '123, West Veli Street, Madurai', 'Suite', 2, 10000.00, true, 4.5, 'DT014'),
('ST015', 'Ramada Plaza', '6543210987', 'Varanasi', 'The Mall, Varanasi', 'Premium', 3, 8500.00, true, 4.4, 'DT015'),
('ST016', 'Leela Palace', '7654321098', 'Delhi', 'Diplomatic Enclave, Chanakyapuri', 'Suite', 2, 22000.00, true, 4.9, 'DT001'),
('ST017', 'Trident Nariman Point', '8765432109', 'Mumbai', 'Nariman Point, Mumbai', 'Deluxe', 4, 16000.00, true, 4.8, 'DT002'),
('ST018', 'Vivanta by Taj', '9876543210', 'Bengaluru', 'Residency Road, Bengaluru', 'Premium', 3, 9500.00, true, 4.6, 'DT003'),
('ST019', 'Park Hyatt', '1234509876', 'Chennai', '39, Velachery Road, Chennai', 'Suite', 2, 18000.00, true, 4.7, 'DT004'),
('ST020', 'ITC Sonar', '2345678909', 'Kolkata', 'JBS Haldane Avenue, Kolkata', 'Deluxe', 4, 14000.00, true, 4.8, 'DT005');

INSERT INTO Vehicle (veh_id, veh_type, veh_source_loc, veh_current_loc, veh_availability, veh_capacity, veh_rate, veh_model, veh_numberplate, driver_id)
VALUES
('VH001', 'Sedan', 'Delhi', 'Delhi', true, 4, 1200.00, 'Honda City', 'DL01AB1234', 'EM001'),
('VH002', 'SUV', 'Mumbai', 'Mumbai', true, 6, 1800.00, 'Toyota Fortuner', 'MH02CD5678', 'EM003'),
('VH003', 'Hatchback', 'Bengaluru', 'Bengaluru', true, 4, 900.00, 'Maruti Swift', 'KA03EF9012', 'EM007'),
('VH004', 'Sedan', 'Chennai', 'Chennai', false, 4, 1100.00, 'Hyundai Verna', 'TN04GH3456', 'EM001'),
('VH005', 'MUV', 'Kolkata', 'Kolkata', true, 8, 2200.00, 'Toyota Innova', 'WB05IJ7890', 'EM003'),
('VH006', 'Hatchback', 'Hyderabad', 'Hyderabad', true, 4, 800.00, 'Tata Tiago', 'TS06KL2345', 'EM007'),
('VH007', 'SUV', 'Ahmedabad', 'Ahmedabad', true, 6, 1700.00, 'Mahindra XUV500', 'GJ07MN6789', 'EM010'),
('VH008', 'Sedan', 'Pune', 'Pune', false, 4, 1000.00, 'Honda Amaze', 'MH08OP0123', 'EM001'),
('VH009', 'Hatchback', 'Jaipur', 'Jaipur', true, 4, 850.00, 'Hyundai Grand i10', 'RJ09QR4567', 'EM007'),
('VH010', 'SUV', 'Lucknow', 'Lucknow', true, 6, 1900.00, 'Ford Endeavour', 'UP10ST8901', 'EM010'),
('VH011', 'Sedan', 'Goa', 'Goa', true, 4, 1300.00, 'Skoda Octavia', 'GA11UV2345', 'EM001'),
('VH012', 'Hatchback', 'Shimla', 'Shimla', true, 4, 950.00, 'Maruti Baleno', 'HP12WX6789', 'EM007'),
('VH013', 'SUV', 'Srinagar', 'Srinagar', true, 6, 2000.00, 'Mahindra Scorpio', 'JK13YZ0123', 'EM010'),
('VH014', 'Sedan', 'Madurai', 'Madurai', false, 4, 1150.00, 'Volkswagen Vento', 'TN14AB4567', 'EM001'),
('VH015', 'MUV', 'Varanasi', 'Varanasi', true, 8, 2100.00, 'Renault Lodgy', 'UP15CD8901', 'EM003'),
('VH016', 'Hatchback', 'Delhi', 'Delhi', true, 4, 950.00, 'Hyundai i20', 'DL16EF2345', 'EM007'),
('VH017', 'SUV', 'Mumbai', 'Mumbai', false, 6, 1950.00, 'Tata Harrier', 'MH17GH6789', 'EM010'),
('VH018', 'Sedan', 'Bengaluru', 'Bengaluru', true, 4, 1250.00, 'Toyota Corolla', 'KA18IJ0123', 'EM001'),
('VH019', 'Hatchback', 'Chennai', 'Chennai', true, 4, 850.00, 'Maruti Celerio', 'TN19KL4567', 'EM007'),
('VH020', 'SUV', 'Kolkata', 'Kolkata', true, 6, 1800.00, 'Hyundai Creta', 'WB20MN8901', 'EM010');

INSERT INTO Inquiry (inq_id, inq_category, inq_fname, inq_mname, inq_lname, inq_detail, inq_status, cust_id, agent_id)
VALUES
('IQ001', 'general', 'Rahul', 'Kumar', 'Sharma', 'General inquiry about travel packages', 'Open', 'CT001', (SELECT agent_id FROM Agent LIMIT 1)),
('IQ002', 'booking', 'Aarti', 'Suresh', 'Kapoor', 'Inquiry about booking a package to Goa', 'Open', 'CT002', (SELECT agent_id FROM Agent LIMIT 1 OFFSET 1)),
('IQ003', 'package', 'Vikram', 'Aditya', 'Singh', 'Inquiry about adventure packages', 'Closed', 'CT003', (SELECT agent_id FROM Agent LIMIT 1 OFFSET 2)),
('IQ004', 'travel', 'Priya', 'Ramesh', 'Rajan', 'Inquiry about travel options to Jaipur', 'Open', 'CT004', (SELECT agent_id FROM Agent LIMIT 1 OFFSET 3)),
('IQ005', 'stay', 'Vivek', 'Rajesh', 'Gupta', 'Inquiry about luxury stay options in Kolkata', 'Closed', 'CT005', (SELECT agent_id FROM Agent LIMIT 1 OFFSET 4)),
('IQ006', 'general', 'Sonal', 'Amit', 'Desai', 'General inquiry about available packages', 'Open', 'CT006', (SELECT agent_id FROM Agent LIMIT 1 OFFSET 5)),
('IQ007', 'booking', 'Arjun', 'Mohan', 'Reddy', 'Inquiry about booking a family package', 'Open', 'CT007', (SELECT agent_id FROM Agent LIMIT 1 OFFSET 6)),
('IQ008', 'payment', 'Pooja', 'Sunil', 'Mehta', 'Inquiry about payment options for a booking', 'Closed', 'CT008', (SELECT agent_id FROM Agent LIMIT 1 OFFSET 7)),
('IQ009', 'package', 'Rishab', 'Anil', 'Bhatt', 'Inquiry about adventure packages in Himalayas', 'Open', 'CT009', (SELECT agent_id FROM Agent LIMIT 1 OFFSET 8)),
('IQ010', 'travel', 'Anjali', 'Vinod', 'Rajput', 'Inquiry about travel options to Varanasi', 'Open', 'CT010', (SELECT agent_id FROM Agent LIMIT 1 OFFSET 9)),
('IQ011', 'stay', 'Rohan', 'Kishore', 'Malhotra', 'Inquiry about luxury stay options in Delhi', 'Closed', 'CT011', (SELECT agent_id FROM Agent LIMIT 1)),
('IQ012', 'booking', 'Ishita', 'Rajesh', 'Patel', 'Inquiry about booking a package to Goa', 'Open', 'CT012', (SELECT agent_id FROM Agent LIMIT 1 OFFSET 1)),
('IQ013', 'package', 'Aditya', 'Suresh', 'Rao', 'Inquiry about family packages', 'Open', 'CT013', (SELECT agent_id FROM Agent LIMIT 1 OFFSET 2)),
('IQ014', 'general', 'Nisha', 'Vinod', 'Sharma', 'General inquiry about travel destinations', 'Closed', 'CT014', (SELECT agent_id FROM Agent LIMIT 1 OFFSET 3)),
('IQ015', 'travel', 'Rohit', 'Anil', 'Saxena', 'Inquiry about travel options to Manali', 'Open', 'CT015', (SELECT agent_id FROM Agent LIMIT 1 OFFSET 4)),
('IQ016', 'stay', 'Deepika', 'Rakesh', 'Banerjee', 'Inquiry about luxury stay options in Kolkata', 'Open', 'CT005', (SELECT agent_id FROM Agent LIMIT 1 OFFSET 5)),
('IQ017', 'booking', 'Arjun', 'Mohan', 'Singh', 'Inquiry about booking a package to Kerala', 'Closed', 'CT017', (SELECT agent_id FROM Agent LIMIT 1 OFFSET 6)),
('IQ018', 'payment', 'Preeti', 'Sunil', 'Gupta', 'Inquiry about payment options for a booking', 'Open', 'CT018', (SELECT agent_id FROM Agent LIMIT 1 OFFSET 7)),
('IQ019', 'package', 'Nitin', 'Ravi', 'Sharma', 'Inquiry about adventure packages in Uttarakhand', 'Open', 'CT019', (SELECT agent_id FROM Agent LIMIT 1 OFFSET 8)),
('IQ020', 'general', 'Sonam', 'Rakesh', 'Kapoor', 'General inquiry about travel packages', 'Closed', 'CT020', (SELECT agent_id FROM Agent LIMIT 1 OFFSET 9)),
('IQ021', 'travel', 'Rishab', 'Amit', 'Desai', 'Inquiry about travel options to Leh Ladakh', 'Open', 'CT021', (SELECT agent_id FROM Agent LIMIT 1 OFFSET 10)),
('IQ022', 'stay', 'Neha', 'Sanjay', 'Kapoor', 'Inquiry about stay options in Indore', 'Closed', 'CT022', (SELECT agent_id FROM Agent LIMIT 1 OFFSET 11)),
('IQ023', 'package', 'Aryan', 'Vivek', 'Sharma', 'Inquiry about family packages to Rajasthan', 'Open', 'CT023', (SELECT agent_id FROM Agent LIMIT 1 OFFSET 12)),
('IQ024', 'booking', 'Ria', 'Aditya', 'Patel', 'Inquiry about booking a package to Kerala', 'Open', 'CT024', (SELECT agent_id FROM Agent LIMIT 1 OFFSET 13)),
('IQ025', 'general', 'Naveen', 'Rohan', 'Singh', 'General inquiry about travel packages in Northeast India', 'Closed', 'CT025', (SELECT agent_id FROM Agent LIMIT 1 OFFSET 14)),
('IQ026', 'payment', 'Aditi', 'Rahul', 'Rao', 'Inquiry about payment options for a booking', 'Open', 'CT026', (SELECT agent_id FROM Agent LIMIT 1 OFFSET 15)),
('IQ027', 'package', 'Siddharth', 'Neeraj', 'Kapoor', 'Inquiry about adventure packages in Uttarakhand', 'Open', 'CT027', (SELECT agent_id FROM Agent LIMIT 1 OFFSET 16)),
('IQ028', 'travel', 'Priya', 'Ajay', 'Gupta', 'Inquiry about travel options to Andaman and Nicobar Islands', 'Closed', 'CT028', (SELECT agent_id FROM Agent LIMIT 1 OFFSET 17)),
('IQ029', 'stay', 'Ankit', 'Sanjay', 'Sharma', 'Inquiry about luxury stay options in Coimbatore', 'Open', 'CT029', (SELECT agent_id FROM Agent LIMIT 1 OFFSET 18)),
('IQ030', 'booking', 'Priyanka', 'Avinash', 'Rai', 'Inquiry about booking a package to Goa', 'Open', 'CT030', (SELECT agent_id FROM Agent LIMIT 1 OFFSET 19)),
('IQ031', 'package', 'Rahul', 'Kumar', 'Sharma', 'Inquiry about family packages to Kashmir', 'Closed', 'CT001', (SELECT agent_id FROM Agent LIMIT 1)),
('IQ032', 'general', 'Aarti', 'Suresh', 'Kapoor', 'General inquiry about travel destinations in South India', 'Open', 'CT002', (SELECT agent_id FROM Agent LIMIT 1 OFFSET 1)),
('IQ033', 'travel', 'Vikram', 'Aditya', 'Singh', 'Inquiry about travel options to Amritsar', 'Open', 'CT003', (SELECT agent_id FROM Agent LIMIT 1 OFFSET 2)),
('IQ034', 'stay', 'Priya', 'Ramesh', 'Rajan', 'Inquiry about stay options in Chennai', 'Closed', 'CT004', (SELECT agent_id FROM Agent LIMIT 1 OFFSET 3)),
('IQ035', 'payment', 'Vivek', 'Rajesh', 'Gupta', 'Inquiry about payment options for a booking', 'Open', 'CT005', (SELECT agent_id FROM Agent LIMIT 1 OFFSET 4)),
('IQ036', 'booking', 'Sonal', 'Amit', 'Desai', 'Inquiry about booking a package to Goa', 'Open', 'CT006', (SELECT agent_id FROM Agent LIMIT 1 OFFSET 5)),
('IQ037', 'package', 'Arjun', 'Mohan', 'Reddy', 'Inquiry about adventure packages in Arunachal Pradesh', 'Closed', 'CT007', (SELECT agent_id FROM Agent LIMIT 1 OFFSET 6)),
('IQ038', 'travel', 'Pooja', 'Sunil', 'Mehta', 'Inquiry about travel options to Ranthambore National Park', 'Open', 'CT008', (SELECT agent_id FROM Agent LIMIT 1 OFFSET 7)),
('IQ039', 'stay', 'Rishab', 'Anil', 'Bhatt', 'Inquiry about luxury stay options in Jaipur', 'Open', 'CT009', (SELECT agent_id FROM Agent LIMIT 1 OFFSET 8)),
('IQ040', 'general', 'Anjali', 'Vinod', 'Rajput', 'General inquiry about travel packages to Northeast India', 'Closed', 'CT010', (SELECT agent_id FROM Agent LIMIT 1 OFFSET 9));

INSERT INTO Travel (tra_id, tra_from_time, tra_from_date, tra_to_time, tra_to_date, tra_type, ticket_price, tra_source, tra_destination)
VALUES
('TR001', '08:00:00', '2023-06-01', '12:00:00', '2023-06-01', 'Flight', 5000.00, 'Delhi', 'Goa'),
('TR002', '10:30:00', '2023-07-10', '18:30:00', '2023-07-10', 'Train', 2500.00, 'Mumbai', 'Jaipur'),
('TR003', '06:00:00', '2023-08-15', '14:00:00', '2023-08-15', 'Bus', 1200.00, 'Bengaluru', 'Ooty'),
('TR004', '13:00:00', '2023-09-20', '21:00:00', '2023-09-20', 'Flight', 6500.00, 'Chennai', 'Srinagar'),
('TR005', '09:00:00', '2023-10-05', '17:00:00', '2023-10-05', 'Train', 3000.00, 'Kolkata', 'Darjeeling'),
('TR006', '11:30:00', '2023-11-12', '19:30:00', '2023-11-12', 'Bus', 1500.00, 'Hyderabad', 'Tirupati'),
('TR007', '07:00:00', '2023-12-25', '15:00:00', '2023-12-25', 'Flight', 7000.00, 'Ahmedabad', 'Leh'),
('TR008', '14:30:00', '2024-01-05', '22:30:00', '2024-01-05', 'Train', 2800.00, 'Pune', 'Agra'),
('TR009', '08:30:00', '2024-02-14', '16:30:00', '2024-02-14', 'Bus', 1800.00, 'Jaipur', 'Udaipur'),
('TR010', '12:00:00', '2024-03-20', '20:00:00', '2024-03-20', 'Flight', 5500.00, 'Lucknow', 'Guwahati'),
('TR011', '10:00:00', '2023-06-10', '18:00:00', '2023-06-10', 'Train', 3500.00, 'Delhi', 'Amritsar'),
('TR012', '07:30:00', '2023-07-15', '15:30:00', '2023-07-15', 'Bus', 1400.00, 'Mumbai', 'Lonavala'),
('TR013', '09:00:00', '2023-08-20', '17:00:00', '2023-08-20', 'Flight', 6000.00, 'Bengaluru', 'Port Blair'),
('TR014', '11:00:00', '2023-09-25', '19:00:00', '2023-09-25', 'Train', 2200.00, 'Chennai', 'Madurai'),
('TR015', '13:30:00', '2023-10-10', '21:30:00', '2023-10-10', 'Bus', 1700.00, 'Kolkata', 'Puri'),
('TR016', '08:30:00', '2023-11-18', '16:30:00', '2023-11-18', 'Flight', 7500.00, 'Hyderabad', 'Manali'),
('TR017', '10:00:00', '2023-12-30', '18:00:00', '2023-12-30', 'Train', 2600.00, 'Ahmedabad', 'Khajuraho'),
('TR018', '12:30:00', '2024-01-10', '20:30:00', '2024-01-10', 'Bus', 1900.00, 'Pune', 'Mahabaleshwar'),
('TR019', '07:00:00', '2024-02-20', '15:00:00', '2024-02-20', 'Flight', 6800.00, 'Jaipur', 'Shillong'),
('TR020', '09:30:00', '2024-03-25', '17:30:00', '2024-03-25', 'Train', 3200.00, 'Lucknow', 'Varanasi'),
('TR021', '14:00:00', '2023-06-05', '22:00:00', '2023-06-05', 'Bus', 1600.00, 'Delhi', 'Rishikesh'),
('TR022', '11:00:00', '2023-07-20', '19:00:00', '2023-07-20', 'Flight', 5800.00, 'Mumbai', 'Kochi'),
('TR023', '08:00:00', '2023-08-25', '16:00:00', '2023-08-25', 'Train', 2400.00, 'Bengaluru', 'Hampi'),
('TR024', '10:30:00', '2023-09-30', '18:30:00', '2023-09-30', 'Bus', 1300.00, 'Chennai', 'Pondicherry'),
('TR025', '12:00:00', '2023-10-15', '20:00:00', '2023-10-15', 'Flight', 6300.00, 'Kolkata', 'Gangtok'),
('TR026', '09:00:00', '2023-11-22', '17:00:00', '2023-11-22', 'Train', 3100.00, 'Hyderabad', 'Vizag'),
('TR027', '13:30:00', '2023-12-05', '21:30:00', '2023-12-05', 'Bus', 1800.00, 'Ahmedabad', 'Dwarka'),
('TR028', '07:30:00', '2024-01-15', '15:30:00', '2024-01-15', 'Flight', 7200.00, 'Pune', 'Andaman'),
('TR029', '11:00:00', '2024-02-25', '19:00:00', '2024-02-25', 'Train', 2700.00, 'Jaipur', 'Jodhpur'),
('TR030', '15:00:00', '2024-03-30', '23:00:00', '2024-03-30', 'Bus', 2000.00, 'Lucknow', 'Nainital');

INSERT INTO Feedback (feed_id, feed_text, feed_rating, feed_category, feed_date, cust_id)
VALUES
('FB001', 'The travel package was well-organized and enjoyable.', 4, 'travel', '2023-03-15', 'CT001'),
('FB002', 'The hotel room was spacious and clean, but the service could be better.', 3, 'stay', '2023-02-20', 'CT002'),
('FB003', 'The booking process was smooth, and the agent was very helpful.', 5, 'booking', '2023-04-01', 'CT003'),
('FB004', 'The vehicle provided for our trip was comfortable and well-maintained.', 4, 'vehicle', '2023-01-10', 'CT004'),
('FB005', 'Overall, it was a great experience, but the food could have been better.', 4, 'general', '2023-03-25', 'CT005'),
('FB006', 'The hotel staff was friendly and accommodating.', 5, 'stay', '2023-02-28', 'CT006'),
('FB007', 'The booking process was a bit confusing, and the agent could have been more informative.', 3, 'booking', '2023-04-12', 'CT007'),
('FB008', 'The travel arrangements were well-coordinated, and we had a seamless journey.', 4, 'travel', '2023-01-18', 'CT008'),
('FB009', 'The vehicle provided was old and not well-maintained.', 2, 'vehicle', '2023-03-10', 'CT009'),
('FB010', 'I had an amazing overall experience with this travel agency.', 5, 'general', '2023-04-05', 'CT010'),
('FB011', 'The hotel room was small, but the location was excellent.', 4, 'stay', '2023-02-12', 'CT011'),
('FB012', 'The booking process could have been more streamlined.', 3, 'booking', '2023-03-28', 'CT012'),
('FB013', 'The travel arrangements were well-planned, and the guides were knowledgeable.', 5, 'travel', '2023-01-22', 'CT013'),
('FB014', 'The vehicle provided was comfortable, but the driver was not very friendly.', 3, 'vehicle', '2023-04-08', 'CT014'),
('FB015', 'Overall, it was a satisfactory experience, but there is room for improvement.', 4, 'general', '2023-03-02', 'CT015'),
('FB016', 'The hotel room was luxurious, and the amenities were top-notch.', 5, 'stay', '2023-02-25', 'CT016'),
('FB017', 'The booking process was efficient, and the agent was responsive.', 4, 'booking', '2023-04-10', 'CT017'),
('FB018', 'The travel arrangements were well-coordinated, but the transportation was a bit uncomfortable.', 3, 'travel', '2023-01-05', 'CT018'),
('FB019', 'The vehicle provided was modern and well-equipped.', 5, 'vehicle', '2023-03-18', 'CT019'),
('FB020', 'I had a wonderful overall experience, and I would definitely recommend this agency.', 5, 'general', '2023-04-15', 'CT020'),
('FB021', 'The hotel room was clean, but the amenities were basic.', 3, 'stay', '2023-02-08', 'CT021'),
('FB022', 'The booking process was smooth, but the agent could have provided more information.', 4, 'booking', '2023-03-22', 'CT022'),
('FB023', 'The travel arrangements were well-organized, but the destinations were crowded.', 4, 'travel', '2023-01-28', 'CT023'),
('FB024', 'The vehicle provided was spacious and comfortable.', 5, 'vehicle', '2023-04-03', 'CT024'),
('FB025', 'Overall, it was an average experience, nothing exceptional.', 3, 'general', '2023-03-12', 'CT025'),
('FB026', 'The hotel room was clean and modern, but the staff was not very friendly.', 4, 'stay', '2023-02-18', 'CT026'),
('FB027', 'The booking process was straightforward, and the agent was knowledgeable.', 5, 'booking', '2023-04-06', 'CT027'),
('FB028', 'The travel arrangements were well-planned, but some of the attractions were closed.', 4, 'travel', '2023-01-15', 'CT028'),
('FB029', 'The vehicle provided was old and not well-maintained.', 2, 'vehicle', '2023-03-30', 'CT029'),
('FB030', 'I had a fantastic overall experience, and I would definitely use this agency again.', 5, 'general', '2023-04-20', 'CT030');

INSERT INTO Package (pac_id, pac_name, pac_description, pac_type, pac_price, pac_start_date, pac_end_date, pac_duration, tra_id, stay_id, veh_id) VALUES
('PK001', 'Golden Triangle', 'Explore Delhi, Agra and Jaipur', 'Cultural', 25000.00, '2024-04-01', '2024-04-10', 10, 'TR001', 'ST001', 'VH001'),
('PK002', 'Kerala Backwaters', 'Houseboat experience in Kerala', 'Leisure', 18000.00, '2024-05-01', '2024-05-07', 7, 'TR002', 'ST002', 'VH002'),
('PK003', 'Himachal Trekking', 'Trekking in the Himalayas', 'Adventure', 30000.00, '2024-06-01', '2024-06-10', 10, 'TR003', 'ST003', 'VH003'),
('PK004', 'Rajasthan Royals', 'Cultural tour of Rajasthan', 'Cultural', 22000.00, '2024-07-01', '2024-07-08', 8, 'TR004', 'ST004', 'VH004'),
('PK005', 'Goa Beaches', 'Beach holiday in Goa', 'Leisure', 15000.00, '2024-08-01', '2024-08-07', 7, 'TR005', 'ST005', 'VH005'),
('PK006', 'Kashmir Valley', 'Explore the Kashmir Valley', 'Leisure', 28000.00, '2024-09-01', '2024-09-10', 10, 'TR006', 'ST006', 'VH006'),
('PK007', 'Ladakh Adventure', 'Trekking and camping in Ladakh', 'Adventure', 35000.00, '2024-10-01', '2024-10-12', 12, 'TR007', 'ST007', 'VH007'),
('PK008', 'Taj Mahal Visit', 'Visit the Taj Mahal in Agra', 'Cultural', 10000.00, '2024-11-01', '2024-11-04', 4, 'TR008', 'ST008', 'VH008'),
('PK009', 'Kerala Ayurveda', 'Ayurvedic wellness in Kerala', 'Leisure', 20000.00, '2024-12-01', '2024-12-10', 10, 'TR009', 'ST009', 'VH009'),
('PK010', 'Rajasthan Forts', 'Explore forts of Rajasthan', 'Cultural', 25000.00, '2025-01-01', '2025-01-10', 10, 'TR010', 'ST010', 'VH010'),
('PK011', 'Andaman Islands', 'Beach and adventure in Andamans', 'Adventure', 30000.00, '2025-02-01', '2025-02-10', 10, 'TR011', 'ST011', 'VH011'),
('PK012', 'Varanasi Ghats', 'Spiritual tour of Varanasi', 'Cultural', 18000.00, '2025-03-01', '2025-03-07', 7, 'TR012', 'ST012', 'VH012'),
('PK013', 'Mumbai City Tour', 'Explore the city of Mumbai', 'Cultural', 12000.00, '2025-04-01', '2025-04-05', 5, 'TR013', 'ST013', 'VH013'),
('PK014', 'Rishikesh Yoga', 'Yoga and meditation in Rishikesh', 'Leisure', 16000.00, '2025-05-01', '2025-05-08', 8, 'TR014', 'ST014', 'VH014'),
('PK015', 'Thar Desert Safari', 'Desert safari in Thar Desert', 'Adventure', 22000.00, '2025-06-01', '2025-06-07', 7, 'TR015', 'ST015', 'VH015'),
('PK016', 'Darjeeling Tea Tour', 'Tea plantation tour in Darjeeling', 'Cultural', 20000.00, '2025-07-01', '2025-07-08', 8, 'TR016', 'ST016', 'VH016'),
('PK017', 'Sikkim Monasteries', 'Visit monasteries in Sikkim', 'Cultural', 18000.00, '2025-08-01', '2025-08-07', 7, 'TR017', 'ST017', 'VH017'),
('PK018', 'Goa Beach Party', 'Beach party and nightlife in Goa', 'Leisure', 15000.00, '2025-09-01', '2025-09-07', 7, 'TR018', 'ST018', 'VH018'),
('PK019', 'Hampi Ruins', 'Explore the Hampi ruins', 'Cultural', 16000.00, '2025-10-01', '2025-10-07', 7, 'TR019', 'ST019', 'VH019'),
('PK020', 'Uttarakhand Trekking', 'Trekking in Uttarakhand', 'Adventure', 25000.00, '2025-11-01', '2025-11-10', 10, 'TR020', 'ST020', 'VH020');
-- ('PK021', 'Khajuraho Temples', 'Visit the Khajuraho temples', 'Cultural', 18000.00, '2025-12-01', '2025-12-07', 7, 'TR021', 'ST021', 'VH021'),
-- ('PK022', 'Kerala Backwaters Cruise', 'Houseboat cruise in Kerala', 'Leisure', 22000.00, '2026-01-01', '2026-01-08', 8, 'TR022', 'ST022', 'VH022'),
-- ('PK023', 'Amritsar Golden Temple', 'Visit the Golden Temple in Amritsar', 'Cultural', 14000.00, '2026-02-01', '2026-02-05', 5, 'TR023', 'ST023', 'VH023'),
-- ('PK024', 'Coorg Coffee Tour', 'Coffee plantation tour in Coorg', 'Cultural', 18000.00, '2026-03-01', '2026-03-07', 7, 'TR024', 'ST024', 'VH024'),
-- ('PK025', 'Manali Skiing', 'Skiing in Manali', 'Adventure', 28000.00, '2026-04-01', '2026-04-10', 10, 'TR025', 'ST025', 'VH025'),
-- ('PK026', 'Rajasthan Desert Safari', 'Desert safari in Rajasthan', 'Adventure', 20000.00, '2026-05-01', '2026-05-07', 7, 'TR026', 'ST026', 'VH026'),
-- ('PK027', 'Mysore Palace Tour', 'Visit the Mysore Palace', 'Cultural', 12000.00, '2026-06-01', '2026-06-05', 5, 'TR027', 'ST027', 'VH027'),
-- ('PK028', 'Kodaikanal Hill Station', 'Explore Kodaikanal hill station', 'Leisure', 16000.00, '2026-07-01', '2026-07-07', 7, 'TR028', 'ST028', 'VH028'),
-- ('PK029', 'Mumbai Bollywood Tour', 'Bollywood tour in Mumbai', 'Cultural', 14000.00, '2026-08-01', '2026-08-05', 5, 'TR029', 'ST029', 'VH029'),
-- ('PK030', 'Alleppey Houseboat', 'Houseboat experience in Alleppey', 'Leisure', 20000.00, '2026-09-01', '2026-09-07', 7, 'TR030', 'ST030', 'VH030');

INSERT INTO Booking (bkn_id, bkn_status, bkn_no_ppl, bkn_date, veh_id, stay_id, tra_id, pac_id, cust_id) VALUES
('BK001', 'Confirmed', 4, '2024-03-15', 'VH001', 'ST001', 'TR001', 'PK001', 'CT001'),
('BK002', 'Confirmed', 2, '2024-04-01', 'VH002', 'ST002', 'TR002', 'PK002', 'CT002'),
('BK003', 'Cancelled', 6, '2024-05-10', 'VH003', 'ST003', 'TR003', 'PK003', 'CT003'),
('BK004', 'Confirmed', 3, '2024-06-15', 'VH004', 'ST004', 'TR004', 'PK004', 'CT004'),
('BK005', 'Confirmed', 2, '2024-07-01', 'VH005', 'ST005', 'TR005', 'PK005', 'CT005'),
('BK006', 'Confirmed', 4, '2024-08-10', 'VH006', 'ST006', 'TR006', 'PK006', 'CT006'),
('BK007', 'Confirmed', 6, '2024-09-20', 'VH007', 'ST007', 'TR007', 'PK007', 'CT007'),
('BK008', 'Confirmed', 2, '2024-10-01', 'VH008', 'ST008', 'TR008', 'PK008', 'CT008'),
('BK009', 'Confirmed', 4, '2024-11-15', 'VH009', 'ST009', 'TR009', 'PK009', 'CT009'),
('BK010', 'Confirmed', 3, '2025-01-05', 'VH010', 'ST010', 'TR010', 'PK010', 'CT010');

-- ('BK011', 'Confirmed', 2, '2025-02-01', 'VH011', 'ST011', 'TR011', 'PK011', 'CT001'),
-- ('BK012', 'Confirmed', 4, '2025-03-10', 'VH012', 'ST012', 'TR012', 'PK012', 'CT011'),
-- ('BK013', 'Confirmed', 6, '2025-04-20', 'VH013', 'ST013', 'TR013', 'PK013', 'CT012'),
-- ('BK014', 'Cancelled', 2, '2025-05-01', 'VH014', 'ST014', 'TR014', 'PK014', 'CT013'),
-- ('BK015', 'Confirmed', 4, '2025-06-10', 'VH015', 'ST015', 'TR015', 'PK015', 'CT014'),
-- ('BK016', 'Confirmed', 3, '2025-07-15', 'VH016', 'ST016', 'TR016', 'PK016', 'CT015'),
-- ('BK017', 'Confirmed', 2, '2025-08-01', 'VH017', 'ST017', 'TR017', 'PK017', 'CT016'),
-- ('BK018', 'Confirmed', 4, '2025-09-10', 'VH018', 'ST018', 'TR018', 'PK018', 'CT017'),
-- ('BK019', 'Confirmed', 6, '2025-10-20', 'VH019', 'ST019', 'TR019', 'PK019', 'CT018'),
-- ('BK020', 'Confirmed', 2, '2025-11-01', 'VH020', 'ST020', 'TR020', 'PK020', 'CT019'),
-- ('BK021', 'Confirmed', 4, '2025-12-15', 'VH021', 'ST021', 'TR021', 'PK021', 'CT020'),
-- ('BK022', 'Confirmed', 3, '2026-01-05', 'VH022', 'ST022', 'TR022', 'PK022', 'CT001'),
-- ('BK023', 'Confirmed', 2, '2026-02-01', 'VH023', 'ST023', 'TR023', 'PK023', 'CT021'),
-- ('BK024', 'Confirmed', 4, '2026-03-10', 'VH024', 'ST024', 'TR024', 'PK024', 'CT022'),
-- ('BK025', 'Confirmed', 6, '2026-04-20', 'VH025', 'ST025', 'TR025', 'PK025', 'CT023'),
-- ('BK026', 'Confirmed', 2, '2026-05-01', 'VH026', 'ST026', 'TR026', 'PK026', 'CT024'),
-- ('BK027', 'Confirmed', 4, '2026-06-10', 'VH027', 'ST027', 'TR027', 'PK027', 'CT025'),
-- ('BK028', 'Confirmed', 3, '2026-07-15', 'VH028', 'ST028', 'TR028', 'PK028', 'CT026'),
-- ('BK029', 'Confirmed', 2, '2026-08-01', 'VH029', 'ST029', 'TR029', 'PK029', 'CT001'),
-- ('BK030', 'Confirmed', 4, '2026-09-10', 'VH030', 'ST030', 'TR030', 'PK030', 'CT027');

INSERT INTO Payment (pay_id, pay_status, pay_amount, pay_method, pay_time, pay_date) VALUES
('PY001', 'Successful', 25000.00, 'Credit Card', '10:30:00', '2024-03-15'),
('PY002', 'Failed', 18000.00, 'Net Banking', '14:15:00', '2024-04-01'),
('PY003', 'Successful', 30000.00, 'Debit Card', '09:00:00', '2024-05-10'),
('PY004', 'Successful', 22000.00, 'UPI', '11:45:00', '2024-06-15'),
('PY005', 'Successful', 15000.00, 'Cash', '16:20:00', '2024-07-01'),
('PY006', 'Successful', 28000.00, 'Credit Card', '13:10:00', '2024-08-10'),
('PY007', 'Successful', 35000.00, 'Net Banking', '10:00:00', '2024-09-20'),
('PY008', 'Successful', 10000.00, 'Debit Card', '15:30:00', '2024-10-01'),
('PY009', 'Successful', 20000.00, 'UPI', '12:00:00', '2024-11-15'),
('PY010', 'Successful', 25000.00, 'Credit Card', '09:45:00', '2025-01-05'),
('PY011', 'Failed', 30000.00, 'Net Banking', '14:20:00', '2025-02-01'),
('PY012', 'Successful', 18000.00, 'Debit Card', '11:10:00', '2025-03-10'),
('PY013', 'Successful', 12000.00, 'UPI', '16:30:00', '2025-04-20'),
('PY014', 'Successful', 16000.00, 'Cash', '10:00:00', '2025-05-01'),
('PY015', 'Successful', 22000.00, 'Credit Card', '13:45:00', '2025-06-10'),
('PY016', 'Successful', 20000.00, 'Net Banking', '09:15:00', '2025-07-15'),
('PY017', 'Successful', 18000.00, 'Debit Card', '12:30:00', '2025-08-01'),
('PY018', 'Successful', 15000.00, 'UPI', '15:00:00', '2025-09-10'),
('PY019', 'Successful', 16000.00, 'Credit Card', '10:45:00', '2025-10-20'),
('PY020', 'Successful', 25000.00, 'Net Banking', '14:15:00', '2025-11-01');

-- SELECT * FROM customer;
-- SELECT * FROM Employee;
-- SELECT * FROM Agent;
-- SELECT * FROM Driver;
-- SELECT * FROM destination;
-- SELECT * FROM stay;
-- SELECT * FROM vehicle;
-- SELECT * FROM inquiry;
-- SELECT * FROM Travel;
-- SELECT * FROM Feedback;
-- SELECT * FROM Package;
-- SELECT * FROM Booking;
-- SELECT * FROM Customer_History;
-- SELECT * FROM Payment; 

