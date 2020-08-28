USE retreat;
SET SQL_mode='';

-- TABLES
SELECT * FROM customer_addresses;
SELECT * FROM customers;
SELECT * FROM cabins;
SELECT * FROM cabin_facilities;
SELECT * FROM extras;
SELECT * FROM bookings;
SELECT * FROM cabins_booked;
SELECT * FROM extras_booked;

-- VIEWS
SELECT * FROM contact_details;
SELECT * FROM cabin_details;
SELECT * FROM cabins_booked_details;
SELECT * FROM extras_booked_details;
SELECT * FROM extras_total;
SELECT * FROM cabin_total;
SELECT * FROM cost_of_holiday;



---------------------------------------------------------------------------------------
-- TASK 1 - VIEW WITH JOINS
-- Using any type of the joins, create a view that combines multiple tables in a 
-- logical way.
---------------------------------------------------------------------------------------

-- VIEW 1
-- Some customers live at the same address so addresses had to be kept separate from
-- names and moved into a separate table to reduce data redundancy and keep the table 
-- in 3NF. A view has been created to see all of their contact details, including their 
-- addresses, in one place. A left join is used here in case there are random addresses 
-- listed in the customer_addresses table that aren't associated with a customer.

CREATE VIEW contact_details AS
	SELECT
		c.cust_id AS customer_id,
		c.f_name AS first_name,
		c.l_name AS last_name,
		c.email AS email,
		c.phone AS phone,
		a.line1 AS address_line1,
		a.line2 AS address_line2,
		a.town AS town,
		a.county AS county,
		a.p_code AS postcode
	FROM
		customers AS c
	LEFT JOIN
		customer_addresses AS a ON c.add_id = a.add_id;

SELECT * FROM contact_details;



-- VIEW 2
-- To ensure the database was in 3NF, cabin facilities had to be kept in a separate table 
-- from cabin nightly rates. This is because the nightly rate is dependent on the cabin
-- facilities (e.g. if a cabin gets a hot tub then the nightly rate will increase). 3NF 
-- requires that there are no such situations (known as transitive functional dependencies)
-- in a table. The following view shows all the information we have about a cabin all in
-- one place.

CREATE VIEW cabin_details AS
	SELECT
		c.cab_id,
		c.cabin_name, 
		c.night_rate, 
		f.capacity,
		f.hot_tub,
		f.lake_view,
		f.forest_view
	FROM
		cabins AS c
	INNER JOIN
		cabin_facilities AS f
		ON c.cab_id = f.cab_id;

SELECT * FROM cabin_details;



-- VIEW 3
-- Adds cabin details onto cabin bookings.

CREATE VIEW cabins_booked_details AS
	SELECT
		cab_bk.cab_bk_id AS cabin_booking_id,
		c.f_name,
		c.l_name,
		c.phone,
		cd.cab_id,
		cd.cabin_name,
		cd.capacity,
		cd.hot_tub,
		cd.lake_view,
		cd.forest_view,
		cab_bk.chk_in,
		cab_bk.chk_out,
		cab_bk.nights AS nights,
		cd.night_rate,
		cab_bk.nights * cd.night_rate AS total_price,
		cab_bk.bk_id
	FROM
		cabins_booked AS cab_bk
	INNER JOIN
		cabin_details AS cd
		ON cd.cab_id = cab_bk.cab_id
	INNER JOIN
		bookings AS b
		ON b.bk_id = cab_bk.bk_id
	INNER JOIN
		customers AS c
		ON c.cust_id = b.cust_id
	ORDER BY
		cab_bk_id;


SELECT * FROM cabins_booked_details;



-- VIEW 4
-- Adds extra activity details onto extra activity bookings.

CREATE VIEW extras_booked_details AS
	SELECT
		ex_bk_id AS extra_booking_id,
		c.f_name,
		c.l_name,
		c.phone,
		e.ex_id,
		e.item,
		ex_bk.date_of_activity,
		ex_bk.quantity,
		e.price AS activity_price,
		e.price * ex_bk.quantity AS total_price,
		ex_bk.bk_id
	FROM
		extras AS e
	INNER JOIN
		extras_booked AS ex_bk
		ON e.ex_id = ex_bk.ex_id
	INNER JOIN
		bookings AS b
		ON b.bk_id = ex_bk.bk_id
	INNER JOIN
		customers AS c
		ON c.cust_id = b.cust_id
	ORDER BY
		extra_booking_id;

SELECT * FROM extras_booked_details;



-- VIEW 5, 6 & 7
-- Find the total price for bookings (using views already made). I had trouble with this
-- as some people didn't book any extra activities. This meant that they had null values
-- in the total price of extras booked. I managed to get around this using COALESCE. A 
-- left join is required here.

CREATE VIEW cabin_total AS
	SELECT
		cbd.bk_id,
		SUM(cbd.total_price) AS cabin_total
	FROM 
		cabins_booked_details AS cbd
	GROUP BY 
		cbd.bk_id
	ORDER BY
		cbd.bk_id;

CREATE VIEW extras_total AS
	SELECT
		ebd.bk_id,
		SUM(ebd.total_price) AS extras_total
	FROM 
		extras_booked_details AS ebd
	GROUP BY
		ebd.bk_id
	ORDER BY
		bk_id;

CREATE VIEW cost_of_holiday AS
	SELECT DISTINCT
		ct.bk_id, 
		ct.cabin_total,
		et.extras_total,
		COALESCE(ct.cabin_total + et.extras_total, ct.cabin_total, et.extras_total) AS holiday_total
	FROM
		cabin_total AS ct
	LEFT JOIN
		extras_total AS et
		ON ct.bk_id = et.bk_id
	GROUP BY
		ct.bk_id;

-- NOTE: requires SET SQL_mode='';
SELECT * FROM cost_of_holiday;



---------------------------------------------------------------------------------------
-- TASK 2 - STORED FUNCTIONS
-- In your database, create a stored function that can be applied to a
-- query in your DB.
---------------------------------------------------------------------------------------

-- SCENARIO:
-- Every now and again I run a sale. This gives people 5% off the total cost of their
-- holiday. The following function can be run during the sale to find the final price
-- the customer needs to pay.

DELIMITER //
CREATE FUNCTION discounted_price(input_amount DECIMAL(7,2))
RETURNS DECIMAL(7,2)
DETERMINISTIC
BEGIN
	DECLARE output_amount DECIMAL(7,2);
	SET output_amount = input_amount - 5 / 100 * input_amount;
	RETURN output_amount;
END//
DELIMITER ;

-- Example:
SELECT
	cst.bk_id,
	cst.holiday_total,
	discounted_price(cst.holiday_total) AS total_after_discount
FROM 
	cost_of_holiday AS cst;



---------------------------------------------------------------------------------------
-- TASK 3 - SUBQUERY
-- Prepare an example query with a subquery to demonstrate how to
-- extract data from your DB for analysis.
---------------------------------------------------------------------------------------

-- SCENARIO 1:
-- Patricia Vaughn has phoned up to check if the cabin she has booked has a hot tub.
-- To find this information out, we can use the following query.

SELECT f.hot_tub
FROM cabin_facilities AS f
WHERE cab_id IN(
	SELECT cab_bk.cab_id
	FROM cabins_booked AS cab_bk
	WHERE bk_id IN(
		SELECT b.bk_id
		FROM bookings AS b
		WHERE cust_id IN(
			SELECT c.cust_id
			FROM customers AS c
			WHERE f_name = 'Patricia'
			AND l_name = 'Vaughn'
			)
		)
	)
;

-- The results return a "1", meaning that Patricia Vaughn has booked one cabin and it 
-- does have a hot tub! This was a bit long-winded. Would be better to have a view with 
-- more info in one place and query that instead.



-- SCENARIO 2:
-- Find out where the customers are visiting from in July.

SELECT a.county
FROM customer_addresses AS a
WHERE add_id IN(
	SELECT c.add_id
	FROM customers AS c
	WHERE cust_id IN(
		SELECT b.cust_id
		FROM bookings AS b
			WHERE bk_id IN(
			SELECT cab_bk.bk_id
			FROM cabins_booked AS cab_bk
			WHERE month(cab_bk.chk_in) = 07
			)
		)
	)
GROUP BY a.county
;

-- Data exported as csv file to explore with Tableau.



---------------------------------------------------------------------------------------
-- TASK 4 - STORED PROCEDURE
-- In your database, create a stored procedure and demonstrate how it runs.
---------------------------------------------------------------------------------------

-- SCENARIO 1:
-- The staff need to know how many bikes, kayaks and SUPs to get out of the shed each
-- morning in order to have them ready for when the customers arrive.

DELIMITER //
CREATE PROCEDURE bikes_needed(on_date DATE)
BEGIN
	SELECT 
		SUM(ex_bk.quantity) AS total_bikes_required
	FROM 
		extras_booked AS ex_bk
	WHERE ex_id IN (
		SELECT e.ex_id
		FROM extras AS e
		WHERE e.item = 'bicycle hire')
		AND ex_bk.date_of_activity = on_date;
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE kayaks_needed(on_date DATE)
BEGIN
	SELECT 
		SUM(ex_bk.quantity) AS total_kayaks_required
	FROM 
		extras_booked AS ex_bk
	WHERE ex_id IN (
		SELECT e.ex_id
		FROM extras AS e
		WHERE e.item = 'kayak hire')
		AND ex_bk.date_of_activity = on_date;
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sups_needed(on_date DATE)
BEGIN
	SELECT 
		SUM(ex_bk.quantity) AS total_sups_required
	FROM 
		extras_booked AS ex_bk
	WHERE ex_id IN (
		SELECT e.ex_id
		FROM extras AS e
		WHERE e.item = 'sup hire')
		AND ex_bk.date_of_activity = on_date;
END//
DELIMITER ;

-- Examples:
CALL bikes_needed('2020-07-18');
CALL kayaks_needed('2020-07-04');
CALL sups_needed('2020-07-22');



-- SCENARIO 2:
-- Find all bookings that are checking in today.

DELIMITER //
CREATE PROCEDURE checking_in(check_in_date DATE)
BEGIN
	SELECT
		cbd.f_name AS first_name,
		cbd.l_name AS last_name,
		cbd.phone,
		cbd.cab_id AS cabin_id,
		cbd.cabin_name,
		cbd.chk_in AS check_in_date,
		cbd.chk_out AS check_out_date
	FROM 
		cabins_booked_details AS cbd
	WHERE
		cbd.chk_in = check_in_date;
END//
DELIMITER ;

CALL checking_in('2020-07-03');



-- SCENARIO 4:
-- Find out who is checking out today so I know where to send housekeeping.

DELIMITER //
CREATE PROCEDURE checking_out(check_out_date DATE)
BEGIN
	SELECT
		cbd.f_name AS first_name,
		cbd.l_name AS last_name,
		cbd.phone,
		cbd.cab_id AS cabin_id,
		cbd.cabin_name,
		cbd.chk_in AS check_in_date,
		cbd.chk_out AS check_out_date
	FROM 
		cabins_booked_details AS cbd
	WHERE
		cbd.chk_out = check_out_date;
END//
DELIMITER ;

CALL checking_out('2020-07-19');



---------------------------------------------------------------------------------------
-- TASK 5 - TRIGGERS
-- In your database, create a trigger and demonstrate how it runs.
---------------------------------------------------------------------------------------

-- SCENARIO:
-- I've created a column in the cabins_booked tables that contains the number of nights
-- calculated from the check in and check out dates. However, if I insert a new cabin
-- booking, it doesn't automatically calculate the number of nights. I have written a
-- trigger that will do just that:

DELIMITER //
CREATE TRIGGER nights
BEFORE INSERT ON cabins_booked
FOR EACH ROW
BEGIN
	SET new.nights = DATEDIFF(new.chk_out, new.chk_in);
END//
DELIMITER ;

-- Insert a cabin booking to check it worked:
INSERT INTO cabins_booked
(cab_id, chk_in, chk_out, bk_id)
VALUES
(5, '2020-08-07', '2020-08-15', 27);

-- We can see it has calulated that this new booking is 8 nights long:
SELECT * FROM cabins_booked;



---------------------------------------------------------------------------------------
-- TASK 6 - COMPLEX VIEW
-- Create a view that uses at least 3-4 base tables. Prepare and demonstrate a query 
-- that uses the view to produce a logically arranged result set for analysis.
---------------------------------------------------------------------------------------

-- I have already created such views above. I will use one of them to query.

-- SCENARIO:
-- My yoga teacher has decided to go travelling in August. I want to find out who has 
-- booked a yoga class in August and phone them up to let them know I have to cancel.
-- I will use the following view, here is a recap of what it contains:
SELECT * FROM extras_booked_details;

SELECT DISTINCT
	eb.f_name AS first_name,
	eb.l_name AS last_name,
	eb.phone
FROM
	extras_booked_details AS eb
WHERE
	item LIKE 'yoga%'
	AND
	month(date_of_activity) = 08;

-- There are three customers who are going to be very disappointed - Darryl, Deanna
-- and Hayfa.



---------------------------------------------------------------------------------------
-- TASK 7 - QUERIES WITH GROUP BY
-- Prepare an example query with group by and having to demonstrate how to extract data 
-- from your DB for analysis.
---------------------------------------------------------------------------------------

-- SCENARIO 1:
-- There has been a leak in cabin 11 so I will need to move all the bookings to another
-- cabin that will sleep the same number of people. Therefore, I want to find a list of 
-- cabins that would be suitable.

-- A quick query shows that cabin 11 has a capacity of 4 people:
SELECT capacity FROM cabin_facilities
WHERE cab_id = 11;

SELECT
	cd.cab_id,
	cd.cabin_name,
	cd.capacity,
	cd.hot_tub,
	cd.lake_view,
	cd.forest_view
FROM 
	cabins_booked_details AS cd
GROUP BY 
	cd.cab_id
HAVING
	cd.capacity >= 4
	AND
	cab_id <> 11;



-- SCENARIO 2:
-- I want to get an idea of which hot tubs are getting the most use so that I can plan 
-- which ones will need maintance first. Therefore I need to find out which are the most
-- popular cabins with hot tubs, i.e. which cabins with hot tubs have the most bookings.

SELECT 
	cd.cab_id AS cabin_id,
	cd.cabin_name,
	cd.hot_tub,
	COUNT(cd.cab_id)
FROM 
	cabins_booked_details AS cd
GROUP BY
	cd.cab_id
HAVING 
	hot_tub = 1
ORDER BY
	COUNT(cd.cab_id) DESC;



-- SCENARIO 3:
-- The retreat is opening up in July after COVID. I want to see when the first booking
-- is for each cabin.

SELECT DISTINCT
	cbd.cab_id AS cabin_id,
	cbd.cabin_name ,
	cbd.chk_in
FROM
	cabins_booked_details AS cbd
GROUP BY
	cbd.cab_id
HAVING
	month(cbd.chk_in) = 07
ORDER BY
	cbd.chk_in;
