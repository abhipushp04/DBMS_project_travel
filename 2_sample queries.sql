use 2000_sql_project;

SELECT emp_fname, emp_lname, emp_role FROM Employee;

SELECT * FROM Booking WHERE cust_id = 'CT005';

SELECT pac_id, COUNT(*) AS total_bookings
FROM Booking
GROUP BY pac_id;

SELECT * FROM Stay WHERE stay_city = 'Mumbai';

SELECT stay_city, AVG(stay_rating) AS avg_rating
FROM Stay
GROUP BY stay_city;

SELECT SUM(pay_amount) AS total_earnings
FROM Payment
WHERE MONTH(pay_date) = 01;

SELECT *
FROM Booking
WHERE bkn_id NOT IN (SELECT bkn_id FROM Feedback);

SELECT dest_id, COUNT(*) AS total_bookings
FROM Booking
JOIN Stay ON Booking.stay_id = Stay.stay_id
GROUP BY dest_id
ORDER BY total_bookings DESC
LIMIT 5;


SELECT *
FROM Customer
WHERE cust_id IN (
    SELECT DISTINCT Booking.cust_id
    FROM Booking
    JOIN Package ON Booking.pac_id = Package.pac_id
    JOIN Stay ON Package.stay_id = Stay.stay_id
    WHERE Package.pac_type = 'ADVENTURE' AND Stay.stay_rating > 4
);

SELECT *
FROM Stay
WHERE stay_pricePerDay < (
    SELECT AVG(stay_pricePerDay) FROM Stay
);

SELECT *
FROM Package
WHERE stay_id IN (
    SELECT stay_id
    FROM Stay
    WHERE stay_rating > (
        SELECT AVG(stay_rating) FROM Stay
    )
);

SELECT cust_id, COUNT(*) AS total_bookings
FROM Booking
GROUP BY cust_id
ORDER BY total_bookings DESC
LIMIT 1;

SELECT *
FROM Stay
WHERE stay_id NOT IN (
    SELECT stay_id FROM Booking
);

SELECT dest_id, COUNT(*) AS total_bookings
FROM Booking
JOIN Stay ON Booking.stay_id = Stay.stay_id
GROUP BY dest_id
ORDER BY total_bookings DESC;

SELECT Package.pac_type, SUM(Package.pac_price) AS total_earnings
FROM Package
JOIN Booking ON Package.pac_id = Booking.pac_id
GROUP BY Package.pac_type;

SELECT *
FROM Package
WHERE stay_id IN (
    SELECT stay_id
    FROM Stay
    WHERE stay_capacity > 3
);

SELECT *
FROM Stay
WHERE stay_id NOT IN (
    SELECT stay_id
    FROM Booking
    WHERE bkn_status = 'BOOKED'
);

SELECT AVG(emp_salary) AS avg_salary
FROM Employee;

SELECT inq_category, COUNT(*) AS total_inquiries
FROM Inquiry
GROUP BY inq_category;

create view v1 as
( select * from driver natural join vehicle
);

select driver from booking join vehicle using(veh_id) join driver using(driver_id);

select count(*) from Travel where tra_from_date >= '2023-01-01' group by tra_source;

-- People traveling from mumbai
select cust_fname, cust_lname, tra_source, tra_destination 
from customer join booking using(cust_id) join travel 
using(tra_id) where tra_source="Mumbai";

-- Number of deluxe room bookings 
select cust_fname, cust_lname, stay_roomtype, dest_city 
from booking natural join stay natural join customer 
natural join destination where stay_roomtype="Deluxe";

-- Inquiry of each customer
select cust_fname, cust_lname, inq_detail from inquiry natural join customer natural join agent;

-- Successful and payed bookings
select * from payment join booking using (bkn_id) where bkn_status="Confirmed" and pay_status="Successful";

-- different people staying at a Hyatt
select cust_fname, cust_lname, stay_name from customer natural join booking natural join stay where stay_name like "%Hyatt%";

-- Average Agent salary
select avg(agent_salary) from agent;

-- average rating for by customer
select cust_fname, cust_lname, avg(feed_rating) from feedback natural join customer group by cust_id;

-- adventure packages where you can stay at a hyatt
select pac_name, pac_type, stay_name, pac_duration from 
package natural join stay 
where pac_type="Adventure" and stay_name like "%Hyatt%";

-- All flights from jan 2023 onwards
select tra_source, tra_destination from travel 
where tra_from_date>="2023-01-01" group by tra_source; 

-- Send payment notice (hafta)
select cust_fname, cust_lname, cust_email, cust_phone, cust_address, pay_status from customer natural join booking natural join payment where pay_status="Failed";


