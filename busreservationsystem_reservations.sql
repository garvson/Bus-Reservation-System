CREATE DATABASE  IF NOT EXISTS `busreservationsystem` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `busreservationsystem`;
-- MySQL dump 10.13  Distrib 5.7.17, for Win64 (x86_64)
--
-- Host: localhost    Database: busreservationsystem
-- ------------------------------------------------------
-- Server version	5.7.19-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `reservations`
--

DROP TABLE IF EXISTS `reservations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reservations` (
  `BookingID` int(11) NOT NULL,
  `BookingDate` date DEFAULT NULL,
  `DepartureDate` date DEFAULT NULL,
  `Type` bit(1) DEFAULT NULL,
  `TotalFare` int(11) DEFAULT NULL,
  `Customer` int(11) DEFAULT NULL,
  `Bus` int(11) DEFAULT NULL,
  `Employee` int(11) DEFAULT NULL,
  `Penaltyy` int(11) DEFAULT NULL,
  `Discount` int(11) DEFAULT NULL,
  PRIMARY KEY (`BookingID`),
  KEY `fk_Customer` (`Customer`),
  KEY `fk_Bus` (`Bus`),
  KEY `fk_Employee` (`Employee`),
  KEY `fk_Penalty` (`Penaltyy`),
  KEY `fk_Discount` (`Discount`),
  CONSTRAINT `fk_Bus` FOREIGN KEY (`Bus`) REFERENCES `busschedule` (`SchedID`),
  CONSTRAINT `fk_Customer` FOREIGN KEY (`Customer`) REFERENCES `customers` (`CustID`),
  CONSTRAINT `fk_Discount` FOREIGN KEY (`Discount`) REFERENCES `discounts` (`DiscountID`),
  CONSTRAINT `fk_Employee` FOREIGN KEY (`Employee`) REFERENCES `employee` (`EmpID`),
  CONSTRAINT `fk_Penalty` FOREIGN KEY (`Penaltyy`) REFERENCES `penalty` (`PenaltyID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reservations`
--

LOCK TABLES `reservations` WRITE;
/*!40000 ALTER TABLE `reservations` DISABLE KEYS */;
INSERT INTO `reservations` VALUES (1234,'2017-11-12','2017-12-16','',219,23,141,34,NULL,12),(1235,'2017-11-11','2017-12-17','',189,24,141,36,14,NULL),(1236,'2017-12-15','2017-12-23','\0',193,25,142,37,14,NULL);
/*!40000 ALTER TABLE `reservations` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 trigger tr before insert on reservations
for each row
begin

if(new.discount is not null) then
set new.totalfare=((select b.BusFare from busfare b, busschedule bs where bs.SchedID=new.bus and bs.NetBusFare=b.Fareid)-
(select amount from discounts where Discountid=new.discount));
end if;
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 trigger tr_cancel before insert on reservations
for each row
begin

if(new.penaltyy is not null) then
set new.totalfare=((select b.BusFare from busfare b, busschedule bs where bs.SchedID=new.bus and bs.NetBusFare=b.Fareid)-
(select Amt from penalty where PenaltyID=new.penaltyy));
end if;
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-12-12  0:20:14
