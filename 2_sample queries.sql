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




