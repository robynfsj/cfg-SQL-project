-- MySQL dump 10.13  Distrib 8.0.20, for macos10.15 (x86_64)
--
-- Host: localhost    Database: retreat
-- ------------------------------------------------------
-- Server version	8.0.20

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `bookings`
--

DROP TABLE IF EXISTS `bookings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bookings` (
  `bk_id` int NOT NULL AUTO_INCREMENT,
  `date_booked` date DEFAULT NULL,
  `cust_id` int DEFAULT NULL,
  PRIMARY KEY (`bk_id`),
  KEY `cust_id` (`cust_id`),
  CONSTRAINT `bookings_ibfk_1` FOREIGN KEY (`cust_id`) REFERENCES `customers` (`cust_id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bookings`
--

LOCK TABLES `bookings` WRITE;
/*!40000 ALTER TABLE `bookings` DISABLE KEYS */;
INSERT INTO `bookings` VALUES (1,'2020-05-01',1),(2,'2020-05-03',2),(3,'2020-05-08',3),(4,'2020-05-14',4),(5,'2020-05-14',5),(6,'2020-05-15',5),(7,'2020-05-21',6),(8,'2020-05-21',7),(9,'2020-05-21',8),(10,'2020-05-21',9),(11,'2020-05-25',10),(12,'2020-05-26',11),(13,'2020-06-01',12),(14,'2020-06-02',13),(15,'2020-06-02',14),(16,'2020-06-12',15),(17,'2020-06-19',16),(18,'2020-06-22',17),(19,'2020-06-23',18),(20,'2020-06-29',19),(21,'2020-07-02',20),(22,'2020-07-03',3),(23,'2020-07-03',21),(24,'2020-07-05',22),(25,'2020-07-13',23),(26,'2020-07-27',24),(27,'2020-07-31',25);
/*!40000 ALTER TABLE `bookings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `cabin_details`
--

DROP TABLE IF EXISTS `cabin_details`;
/*!50001 DROP VIEW IF EXISTS `cabin_details`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `cabin_details` AS SELECT 
 1 AS `cab_id`,
 1 AS `cabin_name`,
 1 AS `night_rate`,
 1 AS `capacity`,
 1 AS `hot_tub`,
 1 AS `lake_view`,
 1 AS `forest_view`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `cabin_facilities`
--

DROP TABLE IF EXISTS `cabin_facilities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cabin_facilities` (
  `cab_id` int NOT NULL AUTO_INCREMENT,
  `capacity` int DEFAULT NULL,
  `hot_tub` tinyint(1) DEFAULT NULL,
  `lake_view` tinyint(1) DEFAULT NULL,
  `forest_view` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`cab_id`),
  CONSTRAINT `cabin_facilities_ibfk_1` FOREIGN KEY (`cab_id`) REFERENCES `cabins` (`cab_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cabin_facilities`
--

LOCK TABLES `cabin_facilities` WRITE;
/*!40000 ALTER TABLE `cabin_facilities` DISABLE KEYS */;
INSERT INTO `cabin_facilities` VALUES (1,2,0,0,1),(2,2,0,1,0),(3,2,1,1,0),(4,2,0,0,1),(5,2,0,1,0),(6,2,0,0,1),(7,2,1,0,1),(8,2,0,1,0),(9,2,0,0,1),(10,4,0,1,0),(11,4,1,0,1),(12,6,1,1,0);
/*!40000 ALTER TABLE `cabin_facilities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `cabin_total`
--

DROP TABLE IF EXISTS `cabin_total`;
/*!50001 DROP VIEW IF EXISTS `cabin_total`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `cabin_total` AS SELECT 
 1 AS `bk_id`,
 1 AS `cabin_total`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `cabins`
--

DROP TABLE IF EXISTS `cabins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cabins` (
  `cab_id` int NOT NULL AUTO_INCREMENT,
  `cabin_name` varchar(30) DEFAULT NULL,
  `night_rate` int DEFAULT NULL,
  PRIMARY KEY (`cab_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cabins`
--

LOCK TABLES `cabins` WRITE;
/*!40000 ALTER TABLE `cabins` DISABLE KEYS */;
INSERT INTO `cabins` VALUES (1,'Rabbit Hill',100),(2,'Trout Corner',150),(3,'Goose Hollow',200),(4,'Fox Run',125),(5,'Slipper Slope',170),(6,'Lavender Lodge',100),(7,'Daisy Hideaway',200),(8,'Swollow’s Nest',130),(9,'Wildflower Hutch',100),(10,'Willow Grove',240),(11,'Oak Nook',250),(12,'Sunset End',300);
/*!40000 ALTER TABLE `cabins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cabins_booked`
--

DROP TABLE IF EXISTS `cabins_booked`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cabins_booked` (
  `cab_bk_id` int NOT NULL AUTO_INCREMENT,
  `cab_id` int NOT NULL,
  `chk_in` date NOT NULL,
  `chk_out` date NOT NULL,
  `nights` int DEFAULT NULL,
  `bk_id` int NOT NULL,
  PRIMARY KEY (`cab_bk_id`),
  KEY `cab_id` (`cab_id`),
  KEY `bk_id` (`bk_id`),
  CONSTRAINT `cabins_booked_ibfk_1` FOREIGN KEY (`cab_id`) REFERENCES `cabins` (`cab_id`),
  CONSTRAINT `cabins_booked_ibfk_2` FOREIGN KEY (`bk_id`) REFERENCES `bookings` (`bk_id`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cabins_booked`
--

LOCK TABLES `cabins_booked` WRITE;
/*!40000 ALTER TABLE `cabins_booked` DISABLE KEYS */;
INSERT INTO `cabins_booked` VALUES (1,7,'2020-07-09','2020-07-13',4,1),(2,8,'2020-07-17','2020-07-19',2,2),(3,1,'2020-07-09','2020-07-11',2,3),(4,11,'2020-07-03','2020-07-07',4,4),(5,6,'2020-07-08','2020-07-12',4,5),(6,6,'2020-07-17','2020-07-19',2,6),(7,10,'2020-07-22','2020-07-26',4,7),(8,10,'2020-07-16','2020-07-19',3,8),(9,11,'2020-07-20','2020-07-26',6,9),(10,11,'2020-07-11','2020-07-15',4,10),(11,2,'2020-07-11','2020-07-15',4,10),(12,9,'2020-07-31','2020-08-02',2,11),(13,12,'2020-07-29','2020-08-03',5,12),(14,6,'2020-07-03','2020-07-06',3,13),(15,3,'2020-07-03','2020-07-05',2,14),(16,5,'2020-07-14','2020-07-17',3,15),(17,9,'2020-07-18','2020-07-25',7,16),(18,3,'2020-07-18','2020-07-25',7,16),(19,4,'2020-07-18','2020-07-25',7,16),(20,3,'2020-07-07','2020-07-12',5,17),(21,4,'2020-07-03','2020-07-05',2,18),(22,12,'2020-07-10','2020-07-17',7,19),(23,2,'2020-08-01','2020-08-05',4,20),(24,10,'2020-07-30','2020-08-02',3,21),(25,8,'2020-07-24','2020-07-25',1,22),(26,7,'2020-07-22','2020-07-27',5,23),(27,4,'2020-07-28','2020-07-31',3,24),(28,5,'2020-07-24','2020-07-26',2,25),(29,5,'2020-07-31','2020-08-03',3,26),(30,4,'2020-08-07','2020-08-09',2,27),(42,5,'2020-08-07','2020-08-15',8,27);
/*!40000 ALTER TABLE `cabins_booked` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `nights` BEFORE INSERT ON `cabins_booked` FOR EACH ROW BEGIN
    SET new.nights = DATEDIFF(new.chk_out, new.chk_in);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Temporary view structure for view `cabins_booked_details`
--

DROP TABLE IF EXISTS `cabins_booked_details`;
/*!50001 DROP VIEW IF EXISTS `cabins_booked_details`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `cabins_booked_details` AS SELECT 
 1 AS `cabin_booking_id`,
 1 AS `f_name`,
 1 AS `l_name`,
 1 AS `phone`,
 1 AS `cab_id`,
 1 AS `cabin_name`,
 1 AS `capacity`,
 1 AS `hot_tub`,
 1 AS `lake_view`,
 1 AS `forest_view`,
 1 AS `chk_in`,
 1 AS `chk_out`,
 1 AS `nights`,
 1 AS `night_rate`,
 1 AS `total_price`,
 1 AS `bk_id`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `contact_details`
--

DROP TABLE IF EXISTS `contact_details`;
/*!50001 DROP VIEW IF EXISTS `contact_details`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `contact_details` AS SELECT 
 1 AS `customer_id`,
 1 AS `first_name`,
 1 AS `last_name`,
 1 AS `email`,
 1 AS `phone`,
 1 AS `address_line1`,
 1 AS `address_line2`,
 1 AS `town`,
 1 AS `county`,
 1 AS `postcode`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `cost_of_holiday`
--

DROP TABLE IF EXISTS `cost_of_holiday`;
/*!50001 DROP VIEW IF EXISTS `cost_of_holiday`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `cost_of_holiday` AS SELECT 
 1 AS `bk_id`,
 1 AS `cabin_total`,
 1 AS `extras_total`,
 1 AS `holiday_total`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `customer_addresses`
--

DROP TABLE IF EXISTS `customer_addresses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer_addresses` (
  `add_id` int NOT NULL AUTO_INCREMENT,
  `line1` varchar(50) NOT NULL,
  `line2` varchar(50) DEFAULT NULL,
  `town` varchar(50) DEFAULT NULL,
  `county` varchar(50) DEFAULT NULL,
  `p_code` varchar(10) NOT NULL,
  PRIMARY KEY (`add_id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer_addresses`
--

LOCK TABLES `customer_addresses` WRITE;
/*!40000 ALTER TABLE `customer_addresses` DISABLE KEYS */;
INSERT INTO `customer_addresses` VALUES (1,'5 Fisher Place','','Thirlmere','Cumbria','CA12 4TW'),(2,'18 Muncaster Way','','West Haddon','Northamptonshire','NN6 7DU'),(3,'30 King Edward Street','','Macclesfield','Cheshire','SK10 1AE'),(4,'1 Western Road','','Crediton','Devon','EX17 3LZ'),(5,'Tudorwell','Broad Bush','Blunsdon','Wiltshire','SN26 7DH'),(6,'34 Kerr Close','','Knebworth','Hertfordshire','SG3 6AB'),(7,'7 Station Road','','Hessle','East Riding of Yorkshire','HU13 0BD'),(8,'Penygraig','Quay Road','Goodwick','Pembrokeshire','SA64 0BS'),(9,'31 Redcar Road','','Guisborough','North Yorkshire','TS14 6HR'),(10,'5 Hookstone Grange Court','','Harrogate','North Yorkshire','HG2 7BP'),(11,'35 Elmwood Drive','','Blythe Bridge','Staffordshire','ST11 9NE'),(12,'17 Stanion Lane','','Corby','Northamptonshire','NN18 8ES'),(13,'116 Ketley Park Road','','Ketley','Shropshire','TF1 5FA'),(14,'7 Paradise Road','','Richmond','North Yorkshire','TW9 1RX'),(15,'Highfields House','23 The Kings Gap','Shrewsbury','Shropshire','SY3 9BJ'),(16,'5 Wigeon Close','','Great Notley','Essex','CM77 7WB'),(17,'Brow Edge','','Drigg','Cumbria','CA19 1XS'),(18,'6 Kingsport Close','','Stockton-On-Tees','County Durham','TS18 2LE'),(19,'103 Forest Road','','Northallerton','North Yorkshire','DL6 1LD'),(20,'18 Meadlands','','Corston','Wiltshire','BA2 9AS'),(21,'256 Brantingham Road','Chorlton-Cum-Hardy','Manchester','','M21 0QZ'),(22,'Pod 104 The Overstrand','Boscombe Promenade','Bournemouth','','BH5 1BN'),(23,'8 Malvern Close','','Ottershaw','Surrey','KT16 0NY'),(24,'3 Lindum Way','','Worthing','West Sussex','BN13 1LS'),(25,'22 Leslie Avenue','','Hebburn','Tyne and Wear','NE31 1XN'),(26,'48 Butterslade Grove','','Ynysforgan','Swansea','SA6 6QU');
/*!40000 ALTER TABLE `customer_addresses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customers`
--

DROP TABLE IF EXISTS `customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customers` (
  `cust_id` int NOT NULL AUTO_INCREMENT,
  `f_name` varchar(25) DEFAULT NULL,
  `l_name` varchar(25) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `add_id` int DEFAULT NULL,
  PRIMARY KEY (`cust_id`),
  KEY `add_id` (`add_id`),
  CONSTRAINT `customers_ibfk_1` FOREIGN KEY (`add_id`) REFERENCES `customer_addresses` (`add_id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customers`
--

LOCK TABLES `customers` WRITE;
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
INSERT INTO `customers` VALUES (1,'Hillary','Riley','in.hendrerit.consectetuer@atrisusNunc.co.uk','07768 743633',1),(2,'Mari','Baldwin','ornare.facilisis@eliterat.org','07327 767123',2),(3,'Lysandra','Daniel','malesuada@lorem.edu','07625 131765',3),(4,'Indira','Marquez','non.lorem@consequatpurus.net','(01363) 405417',4),(5,'Jack','Massey','gravida@ametrisus.edu','(01793) 182452',5),(6,'Timon','Frost','molestie@scelerisquescelerisque.ca','(01438) 180844',6),(7,'Ahmed','Gregory','ornare.placerat.orci@pedeacurna.edu','07265 845658',7),(8,'Jemima','Adkins','enim@vulputateduinec.edu','07115 228569',8),(9,'Leah','Snow','a.felis.ullamcorper@feugiatSed.ca','(01348) 355808',8),(10,'Deanna','Simpson','libero.et.tristique@sit.edu','(01423) 561214',9),(11,'Hayfa','Gillespie','tellus.imperdiet.non@CuraePhasellus.net','(01782) 736278',10),(12,'Hu','Sweeney','In.tincidunt.congue@tinciduntorciquis.co.uk','07778 544658',11),(13,'Burton','Glover','dui.augue.eu@risusNuncac.org','07665 592256',12),(14,'Yoko','Sanford','eget.dictum.placerat@natoquepenatibus.com','(01952) 160285',12),(15,'Kane','Brooks','iaculis.quis.pede@fringillapurusmauris.edu','07411 029080',13),(16,'Damon','Welch','porttitor@massa.co.uk','07633 665859',14),(17,'Sybill','Berger','et.magnis@adlitora.ca','(01376) 755648',15),(18,'Gage','Moody','erat@orciDonecnibh.org','(01642) 508634',15),(19,'Darryl','Rollins','eu@Phaselluselit.org','07845 651975',16),(20,'Rama','Jones','Morbi.accumsan@metus.edu','07494 156321',17),(21,'Patricia','Vaughn','luctus.vulputate@Donecvitae.ca','(0161) 351 1123',18),(22,'Jameson','Stuart','nec.mauris.blandit@lacinia.com','(01202) 624754',19),(23,'Pandora','Dillard','sit.amet@eu.co.uk','(01932) 626177',20),(24,'Quyn','Mcmillan','sit.amet@elementumdui.com','07465 215654',21),(25,'Timothy','Barlow','a.mi@eget.edu','07845 262336',22);
/*!40000 ALTER TABLE `customers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `extras`
--

DROP TABLE IF EXISTS `extras`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `extras` (
  `ex_id` int NOT NULL AUTO_INCREMENT,
  `item` varchar(30) NOT NULL,
  `price` decimal(4,2) DEFAULT NULL,
  PRIMARY KEY (`ex_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `extras`
--

LOCK TABLES `extras` WRITE;
/*!40000 ALTER TABLE `extras` DISABLE KEYS */;
INSERT INTO `extras` VALUES (1,'fire logs',5.00),(2,'bicycle hire',18.50),(3,'kayak hire',20.00),(4,'sup hire',22.50),(5,'yoga class am',7.25),(6,'yoga class pm',7.25);
/*!40000 ALTER TABLE `extras` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `extras_booked`
--

DROP TABLE IF EXISTS `extras_booked`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `extras_booked` (
  `ex_bk_id` int NOT NULL AUTO_INCREMENT,
  `ex_id` int NOT NULL,
  `date_of_activity` date DEFAULT NULL,
  `quantity` int NOT NULL,
  `bk_id` int DEFAULT NULL,
  PRIMARY KEY (`ex_bk_id`),
  KEY `ex_id` (`ex_id`),
  KEY `bk_id` (`bk_id`),
  CONSTRAINT `extras_booked_ibfk_1` FOREIGN KEY (`ex_id`) REFERENCES `extras` (`ex_id`),
  CONSTRAINT `extras_booked_ibfk_2` FOREIGN KEY (`bk_id`) REFERENCES `bookings` (`bk_id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `extras_booked`
--

LOCK TABLES `extras_booked` WRITE;
/*!40000 ALTER TABLE `extras_booked` DISABLE KEYS */;
INSERT INTO `extras_booked` VALUES (1,1,NULL,2,1),(2,2,'2020-07-18',2,6),(3,3,'2020-07-21',3,9),(4,5,'2020-07-22',4,9),(5,2,'2020-07-12',2,10),(6,4,'2020-07-14',2,10),(7,6,'2020-08-01',2,11),(8,6,'2020-08-01',6,12),(9,4,'2020-08-02',6,12),(10,5,'2020-07-20',6,16),(11,6,'2020-07-20',6,16),(12,4,'2020-07-22',6,16),(13,2,'2020-07-23',6,16),(14,1,NULL,1,17),(15,6,'2020-07-03',1,18),(16,3,'2020-07-04',2,18),(17,6,'2020-07-11',6,19),(18,5,'2020-07-12',4,19),(19,6,'2020-07-12',6,19),(20,2,'2020-07-13',6,19),(21,6,'2020-07-14',6,19),(22,5,'2020-08-03',2,20),(23,4,'2020-08-03',2,20),(24,5,'2020-08-04',2,20),(25,1,NULL,1,24),(26,6,'2020-07-30',2,24),(27,1,NULL,1,25),(28,6,'2020-07-25',1,25),(29,5,'2020-07-08',1,27),(30,6,'2020-07-08',1,27);
/*!40000 ALTER TABLE `extras_booked` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `extras_booked_details`
--

DROP TABLE IF EXISTS `extras_booked_details`;
/*!50001 DROP VIEW IF EXISTS `extras_booked_details`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `extras_booked_details` AS SELECT 
 1 AS `extra_booking_id`,
 1 AS `f_name`,
 1 AS `l_name`,
 1 AS `phone`,
 1 AS `ex_id`,
 1 AS `item`,
 1 AS `date_of_activity`,
 1 AS `quantity`,
 1 AS `activity_price`,
 1 AS `total_price`,
 1 AS `bk_id`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `extras_total`
--

DROP TABLE IF EXISTS `extras_total`;
/*!50001 DROP VIEW IF EXISTS `extras_total`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `extras_total` AS SELECT 
 1 AS `bk_id`,
 1 AS `extras_total`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `cabin_details`
--

/*!50001 DROP VIEW IF EXISTS `cabin_details`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `cabin_details` AS select `c`.`cab_id` AS `cab_id`,`c`.`cabin_name` AS `cabin_name`,`c`.`night_rate` AS `night_rate`,`f`.`capacity` AS `capacity`,`f`.`hot_tub` AS `hot_tub`,`f`.`lake_view` AS `lake_view`,`f`.`forest_view` AS `forest_view` from (`cabins` `c` join `cabin_facilities` `f` on((`c`.`cab_id` = `f`.`cab_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `cabin_total`
--

/*!50001 DROP VIEW IF EXISTS `cabin_total`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `cabin_total` AS select `cbd`.`bk_id` AS `bk_id`,sum(`cbd`.`total_price`) AS `cabin_total` from `cabins_booked_details` `cbd` group by `cbd`.`bk_id` order by `cbd`.`bk_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `cabins_booked_details`
--

/*!50001 DROP VIEW IF EXISTS `cabins_booked_details`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `cabins_booked_details` AS select `cab_bk`.`cab_bk_id` AS `cabin_booking_id`,`c`.`f_name` AS `f_name`,`c`.`l_name` AS `l_name`,`c`.`phone` AS `phone`,`cd`.`cab_id` AS `cab_id`,`cd`.`cabin_name` AS `cabin_name`,`cd`.`capacity` AS `capacity`,`cd`.`hot_tub` AS `hot_tub`,`cd`.`lake_view` AS `lake_view`,`cd`.`forest_view` AS `forest_view`,`cab_bk`.`chk_in` AS `chk_in`,`cab_bk`.`chk_out` AS `chk_out`,`cab_bk`.`nights` AS `nights`,`cd`.`night_rate` AS `night_rate`,(`cab_bk`.`nights` * `cd`.`night_rate`) AS `total_price`,`cab_bk`.`bk_id` AS `bk_id` from (((`cabins_booked` `cab_bk` join `cabin_details` `cd` on((`cd`.`cab_id` = `cab_bk`.`cab_id`))) join `bookings` `b` on((`b`.`bk_id` = `cab_bk`.`bk_id`))) join `customers` `c` on((`c`.`cust_id` = `b`.`cust_id`))) order by `cab_bk`.`cab_bk_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `contact_details`
--

/*!50001 DROP VIEW IF EXISTS `contact_details`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `contact_details` AS select `c`.`cust_id` AS `customer_id`,`c`.`f_name` AS `first_name`,`c`.`l_name` AS `last_name`,`c`.`email` AS `email`,`c`.`phone` AS `phone`,`a`.`line1` AS `address_line1`,`a`.`line2` AS `address_line2`,`a`.`town` AS `town`,`a`.`county` AS `county`,`a`.`p_code` AS `postcode` from (`customers` `c` left join `customer_addresses` `a` on((`c`.`add_id` = `a`.`add_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `cost_of_holiday`
--

/*!50001 DROP VIEW IF EXISTS `cost_of_holiday`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `cost_of_holiday` AS select `ct`.`bk_id` AS `bk_id`,`ct`.`cabin_total` AS `cabin_total`,`et`.`extras_total` AS `extras_total`,coalesce((`ct`.`cabin_total` + `et`.`extras_total`),`ct`.`cabin_total`,`et`.`extras_total`) AS `holiday_total` from (`cabin_total` `ct` left join `extras_total` `et` on((`ct`.`bk_id` = `et`.`bk_id`))) group by `ct`.`bk_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `extras_booked_details`
--

/*!50001 DROP VIEW IF EXISTS `extras_booked_details`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `extras_booked_details` AS select `ex_bk`.`ex_bk_id` AS `extra_booking_id`,`c`.`f_name` AS `f_name`,`c`.`l_name` AS `l_name`,`c`.`phone` AS `phone`,`e`.`ex_id` AS `ex_id`,`e`.`item` AS `item`,`ex_bk`.`date_of_activity` AS `date_of_activity`,`ex_bk`.`quantity` AS `quantity`,`e`.`price` AS `activity_price`,(`e`.`price` * `ex_bk`.`quantity`) AS `total_price`,`ex_bk`.`bk_id` AS `bk_id` from (((`extras` `e` join `extras_booked` `ex_bk` on((`e`.`ex_id` = `ex_bk`.`ex_id`))) join `bookings` `b` on((`b`.`bk_id` = `ex_bk`.`bk_id`))) join `customers` `c` on((`c`.`cust_id` = `b`.`cust_id`))) order by `ex_bk`.`ex_bk_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `extras_total`
--

/*!50001 DROP VIEW IF EXISTS `extras_total`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `extras_total` AS select `ebd`.`bk_id` AS `bk_id`,sum(`ebd`.`total_price`) AS `extras_total` from `extras_booked_details` `ebd` group by `ebd`.`bk_id` order by `ebd`.`bk_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-08-28 21:52:53
