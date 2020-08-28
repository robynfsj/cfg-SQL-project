CREATE DATABASE retreat;
USE retreat;

---------------------------------------------------------------------------------------
-- 1. Create tables.
---------------------------------------------------------------------------------------

-- Customer data tables.
CREATE TABLE customer_addresses(
	add_id INT NOT NULL AUTO_INCREMENT, 
	line1 VARCHAR(50) NOT NULL, 
	line2 VARCHAR(50), 
	town VARCHAR(50), 
	county VARCHAR(50), 
	p_code VARCHAR(10) NOT NULL, 
	CONSTRAINT pk_cust_add PRIMARY KEY (add_id)
);

CREATE TABLE customers(
	cust_id INT NOT NULL AUTO_INCREMENT, 
	f_name VARCHAR(25), 
	l_name VARCHAR(25), 
	email VARCHAR(100), 
	phone VARCHAR(20), 
	add_id INT, 
	CONSTRAINT pk_customers PRIMARY KEY (cust_id), 
	FOREIGN KEY (add_id) REFERENCES customer_addresses(add_id)
);

-- Tables about the retreat itself.
CREATE TABLE cabins(
	cab_id INT NOT NULL AUTO_INCREMENT, 
	cabin_name VARCHAR(30), 
	night_rate INT, 
	CONSTRAINT pk_cabins PRIMARY KEY (cab_id)
);

CREATE TABLE cabin_facilities(
	cab_id INT NOT NULL AUTO_INCREMENT, 
	capacity INT(2), 
	hot_tub BOOL, 
	lake_view BOOL, 
	forest_view BOOL, 
	CONSTRAINT pk_cab_fac PRIMARY KEY (cab_id), 
	FOREIGN KEY (cab_id) REFERENCES cabins(cab_id)
);

CREATE TABLE extras(
	ex_id INT NOT NULL AUTO_INCREMENT, 
	item VARCHAR(30) NOT NULL, 
	price DECIMAL(4, 2), 
	CONSTRAINT pk_extras PRIMARY KEY (ex_id)
);

-- Tables about bookings.
CREATE TABLE bookings(
	bk_id INT NOT NULL AUTO_INCREMENT, 
	date_booked DATE, 
	cust_id INT, 
	CONSTRAINT pk_bookings PRIMARY KEY (bk_id), 
	FOREIGN KEY (cust_id) REFERENCES customers(cust_id)
);
 
CREATE TABLE cabins_booked(
	cab_bk_id INT NOT NULL AUTO_INCREMENT, 
	cab_id INT NOT NULL, 
	chk_in DATE NOT NULL, 
	chk_out DATE NOT NULL, 
    nights INT,
	bk_id INT NOT NULL, 
	CONSTRAINT pk_cab_bk PRIMARY KEY (cab_bk_id), 
	FOREIGN KEY (cab_id) REFERENCES cabins(cab_id), 
	FOREIGN KEY (bk_id) REFERENCES bookings(bk_id)
);

CREATE TABLE extras_booked(
	ex_bk_id INT NOT NULL AUTO_INCREMENT, 
	ex_id INT NOT NULL, 
	date_of_activity DATE, 
	quantity INT(2) NOT NULL, 
	bk_id INT, 
	CONSTRAINT pk_ex_bk PRIMARY KEY (ex_bk_id), 
	FOREIGN KEY (ex_id) REFERENCES extras(ex_id), 
	FOREIGN KEY (bk_id) REFERENCES bookings(bk_id)
);


---------------------------------------------------------------------------------------
-- 2. Populate tables.
---------------------------------------------------------------------------------------

/*
customer_addresses and customers data can be imported from csv using 
workbench import wizard but included here for completeness and ease 
of just running a script rather than selecting options and finding the
correct files
*/

INSERT INTO customer_addresses
(line1, line2, town, county, p_code)
VALUES
('5 Fisher Place', '', 'Thirlmere', 'Cumbria', 'CA12 4TW'), 
('18 Muncaster Way', '', 'West Haddon', 'Northamptonshire', 'NN6 7DU'),
('30 King Edward Street', '', 'Macclesfield', 'Cheshire', 'SK10 1AE'),
('1 Western Road', '', 'Crediton', 'Devon', 'EX17 3LZ'),
('Tudorwell', 'Broad Bush', 'Blunsdon', 'Wiltshire', 'SN26 7DH'),
('34 Kerr Close', '', 'Knebworth', 'Hertfordshire', 'SG3 6AB'),
('7 Station Road', '', 'Hessle', 'East Riding of Yorkshire', 'HU13 0BD'),
('Penygraig', 'Quay Road', 'Goodwick', 'Pembrokeshire', 'SA64 0BS'),
('31 Redcar Road', '', 'Guisborough', 'North Yorkshire', 'TS14 6HR'),
('5 Hookstone Grange Court', '', 'Harrogate', 'North Yorkshire', 'HG2 7BP'),
('35 Elmwood Drive', '', 'Blythe Bridge', 'Staffordshire', 'ST11 9NE'),
('17 Stanion Lane', '', 'Corby', 'Northamptonshire', 'NN18 8ES'),
('116 Ketley Park Road', '', 'Ketley', 'Shropshire', 'TF1 5FA'),
('7 Paradise Road', '', 'Richmond', 'North Yorkshire', 'TW9 1RX'),
('Highfields House', '23 The Kings Gap', 'Shrewsbury', 'Shropshire', 'SY3 9BJ'),
('5 Wigeon Close', '', 'Great Notley', 'Essex', 'CM77 7WB'),
('Brow Edge', '', 'Drigg', 'Cumbria', 'CA19 1XS'),
('6 Kingsport Close', '', 'Stockton-On-Tees', 'County Durham', 'TS18 2LE'),
('103 Forest Road', '', 'Northallerton', 'North Yorkshire', 'DL6 1LD'),
('18 Meadlands', '', 'Corston', 'Wiltshire', 'BA2 9AS'),
('256 Brantingham Road', 'Chorlton-Cum-Hardy', 'Manchester', '', 'M21 0QZ'),
('Pod 104 The Overstrand', 'Boscombe Promenade', 'Bournemouth', '', 'BH5 1BN'),
('8 Malvern Close', '', 'Ottershaw', 'Surrey', 'KT16 0NY'),
('3 Lindum Way', '', 'Worthing', 'West Sussex', 'BN13 1LS'),
('22 Leslie Avenue', '', 'Hebburn', 'Tyne and Wear', 'NE31 1XN'),
('48 Butterslade Grove', '', 'Ynysforgan', 'Swansea', 'SA6 6QU');

INSERT INTO customers
(f_name, l_name, email, phone, add_id)
VALUES
('Hillary', 'Riley', 'in.hendrerit.consectetuer@atrisusNunc.co.uk', '07768 743633', 1), 
('Mari', 'Baldwin', 'ornare.facilisis@eliterat.org', '07327 767123', 2), 
('Lysandra', 'Daniel', 'malesuada@lorem.edu', '07625 131765', 3), 
('Indira', 'Marquez', 'non.lorem@consequatpurus.net', '(01363) 405417', 4), 
('Jack', 'Massey', 'gravida@ametrisus.edu', '(01793) 182452', 5), 
('Timon', 'Frost', 'molestie@scelerisquescelerisque.ca', '(01438) 180844', 6), 
('Ahmed', 'Gregory', 'ornare.placerat.orci@pedeacurna.edu', '07265 845658', 7), 
('Jemima', 'Adkins', 'enim@vulputateduinec.edu', '07115 228569', 8), 
('Leah', 'Snow', 'a.felis.ullamcorper@feugiatSed.ca', '(01348) 355808', 8), 
('Deanna', 'Simpson', 'libero.et.tristique@sit.edu', '(01423) 561214', 9), 
('Hayfa', 'Gillespie', 'tellus.imperdiet.non@CuraePhasellus.net', '(01782) 736278', 10), 
('Hu', 'Sweeney', 'In.tincidunt.congue@tinciduntorciquis.co.uk', '07778 544658', 11), 
('Burton', 'Glover', 'dui.augue.eu@risusNuncac.org', '07665 592256', 12), 
('Yoko', 'Sanford', 'eget.dictum.placerat@natoquepenatibus.com', '(01952) 160285', 12), 
('Kane', 'Brooks', 'iaculis.quis.pede@fringillapurusmauris.edu', '07411 029080', 13), 
('Damon', 'Welch', 'porttitor@massa.co.uk', '07633 665859', 14), 
('Sybill', 'Berger', 'et.magnis@adlitora.ca', '(01376) 755648', 15), 
('Gage', 'Moody', 'erat@orciDonecnibh.org', '(01642) 508634', 15), 
('Darryl', 'Rollins', 'eu@Phaselluselit.org', '07845 651975', 16), 
('Rama', 'Jones', 'Morbi.accumsan@metus.edu', '07494 156321', 17), 
('Patricia', 'Vaughn', 'luctus.vulputate@Donecvitae.ca', '(0161) 351 1123', 18), 
('Jameson', 'Stuart', 'nec.mauris.blandit@lacinia.com', '(01202) 624754', 19), 
('Pandora', 'Dillard', 'sit.amet@eu.co.uk', '(01932) 626177', 20), 
('Quyn', 'Mcmillan', 'sit.amet@elementumdui.com', '07465 215654', 21), 
('Timothy', 'Barlow', 'a.mi@eget.edu', '07845 262336', 22);

INSERT INTO cabins
(cabin_name, night_rate)
VALUES
('Rabbit Hill', 100), 
('Trout Corner', 150), 
('Goose Hollow', 200), 
('Fox Run', 125), 
('Slipper Slope', 170), 
('Lavender Lodge', 100), 
('Daisy Hideaway', 200), 
('Swollow’s Nest', 130), 
('Wildflower Hutch', 100), 
('Willow Grove', 240), 
('Oak Nook', 250), 
('Sunset End', 300);

INSERT INTO cabin_facilities
(capacity, hot_tub, lake_view, forest_view)
VALUES
(2, 0, 0, 1), 
(2, 0, 1, 0), 
(2, 1, 1, 0), 
(2, 0, 0, 1), 
(2, 0, 1, 0), 
(2, 0, 0, 1), 
(2, 1, 0, 1), 
(2, 0, 1, 0), 
(2, 0, 0, 1), 
(4, 0, 1, 0), 
(4, 1, 0, 1), 
(6, 1, 1, 0);

INSERT INTO extras
(item, price)
VALUES
('fire logs', 5),
('bicycle hire', 18.50),
('kayak hire', 20),
('sup hire', 22.50),
('yoga class am', 7.25),
('yoga class pm', 7.25);

INSERT INTO bookings
(date_booked, cust_id)
VALUES
('2020-05-01', 1),
('2020-05-03', 2),
('2020-05-08', 3),
('2020-05-14', 4),
('2020-05-14', 5),
('2020-05-15', 5),
('2020-05-21', 6),
('2020-05-21', 7),
('2020-05-21', 8),
('2020-05-21', 9),
('2020-05-25', 10),
('2020-05-26', 11),
('2020-06-01', 12),
('2020-06-02', 13),
('2020-06-02', 14),
('2020-06-12', 15),
('2020-06-19', 16),
('2020-06-22', 17),
('2020-06-23', 18),
('2020-06-29', 19),
('2020-07-02', 20),
('2020-07-03', 3),
('2020-07-03', 21),
('2020-07-05', 22),
('2020-07-13', 23),
('2020-07-27', 24),
('2020-07-31', 25);

INSERT INTO cabins_booked
(cab_id, chk_in, chk_out, bk_id)
VALUES
(7, '2020-07-09', '2020-07-13', 1),
(8, '2020-07-17', '2020-07-19', 2),  
(1, '2020-07-09', '2020-07-11', 3),
(11, '2020-07-03', '2020-07-07', 4), 
(6, '2020-07-08', '2020-07-12', 5),
(6, '2020-07-17', '2020-07-19', 6), 
(10, '2020-07-22', '2020-07-26', 7), 
(10, '2020-07-16', '2020-07-19', 8),
(11, '2020-07-20', '2020-07-26', 9), 
(11, '2020-07-11', '2020-07-15', 10),
(2, '2020-07-11', '2020-07-15', 10),
(9, '2020-07-31', '2020-08-02', 11), 
(12, '2020-07-29', '2020-08-03', 12), 
(6, '2020-07-03', '2020-07-06', 13), 
(3, '2020-07-03', '2020-07-05', 14),
(5, '2020-07-14', '2020-07-17', 15),  
(9, '2020-07-18', '2020-07-25', 16), 
(3, '2020-07-18', '2020-07-25', 16), 
(4, '2020-07-18', '2020-07-25', 16),
(3, '2020-07-07', '2020-07-12', 17), 
(4, '2020-07-03', '2020-07-05', 18), 
(12, '2020-07-10', '2020-07-17', 19),
(2, '2020-08-01', '2020-08-05', 20), 
(10, '2020-07-30', '2020-08-02', 21), 
(8, '2020-07-24', '2020-07-25', 22),
(7, '2020-07-22', '2020-07-27', 23), 
(4, '2020-07-28', '2020-07-31', 24), 
(5, '2020-07-24', '2020-07-26', 25), 
(5, '2020-07-31', '2020-08-03', 26), 
(4, '2020-08-07', '2020-08-09', 27); 

-- calculate total nights in cabins_booked
UPDATE cabins_booked
SET nights = DATEDIFF(chk_out, chk_in);

INSERT INTO extras_booked
(ex_id, date_of_activity, quantity, bk_id)
VALUES
( 1, null, 2, 1),
( 2, '2020-07-18', 2, 6),
( 3, '2020-07-21', 3, 9),
( 5, '2020-07-22', 4, 9),
( 2, '2020-07-12', 2, 10),
( 4, '2020-07-14', 2, 10),
( 6, '2020-08-01', 2, 11),
( 6, '2020-08-01', 6, 12),
( 4, '2020-08-02', 6, 12),
( 5, '2020-07-20', 6, 16),
( 6, '2020-07-20', 6, 16),
( 4, '2020-07-22', 6, 16),
( 2, '2020-07-23', 6, 16),
( 1, null, 1, 17),
( 6, '2020-07-03', 1, 18),
( 3, '2020-07-04', 2, 18),
( 6, '2020-07-11', 6, 19),
( 5, '2020-07-12', 4, 19),
( 6, '2020-07-12', 6, 19),
( 2, '2020-07-13', 6, 19),
( 6, '2020-07-14', 6, 19),
( 5, '2020-08-03', 2, 20),
( 4, '2020-08-03', 2, 20),
( 5, '2020-08-04', 2, 20),
( 1, null, 1, 24),
( 6, '2020-07-30', 2, 24),
( 1, null, 1, 25),
( 6, '2020-07-25', 1, 25),
( 5, '2020-07-08', 1, 27),
( 6, '2020-07-08', 1, 27);

-- Check tables:
SELECT * FROM customer_addresses;
SELECT * FROM customers;
SELECT * FROM cabins;
SELECT * FROM cabin_facilities;
SELECT * FROM extras;
SELECT * FROM bookings;
SELECT * FROM cabins_booked;
SELECT * FROM extras_booked;
