CREATE DATABASE  IF NOT EXISTS `furniture_store` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `furniture_store`;
-- MySQL dump 10.13  Distrib 8.0.28, for Win64 (x86_64)
--
-- Host: localhost    Database: furniture_store
-- ------------------------------------------------------
-- Server version	8.0.28

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Temporary view structure for view `all_default_builds`
--

DROP TABLE IF EXISTS `all_default_builds`;
/*!50001 DROP VIEW IF EXISTS `all_default_builds`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `all_default_builds` AS SELECT 
 1 AS `build_id`,
 1 AS `item_name`,
 1 AS `part_name`,
 1 AS `material_name`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `all_items`
--

DROP TABLE IF EXISTS `all_items`;
/*!50001 DROP VIEW IF EXISTS `all_items`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `all_items` AS SELECT 
 1 AS `item_id`,
 1 AS `item_name`,
 1 AS `price`,
 1 AS `part_id`,
 1 AS `part_name`,
 1 AS `material_id`,
 1 AS `material_name`,
 1 AS `added_price`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `all_non_default_user_cart_builds`
--

DROP TABLE IF EXISTS `all_non_default_user_cart_builds`;
/*!50001 DROP VIEW IF EXISTS `all_non_default_user_cart_builds`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `all_non_default_user_cart_builds` AS SELECT 
 1 AS `user_id`,
 1 AS `build_id`,
 1 AS `item_name`,
 1 AS `part_name`,
 1 AS `material_name`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `build_parts`
--

DROP TABLE IF EXISTS `build_parts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `build_parts` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `build_id` int unsigned DEFAULT NULL,
  `part_id` int unsigned NOT NULL,
  `material_id` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `build_id` (`build_id`),
  KEY `part_id` (`part_id`),
  KEY `material_id` (`material_id`),
  CONSTRAINT `build_parts_ibfk_1` FOREIGN KEY (`build_id`) REFERENCES `builds` (`id`),
  CONSTRAINT `build_parts_ibfk_2` FOREIGN KEY (`part_id`) REFERENCES `parts` (`id`),
  CONSTRAINT `build_parts_ibfk_3` FOREIGN KEY (`material_id`) REFERENCES `part_materials` (`material_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `build_parts`
--

LOCK TABLES `build_parts` WRITE;
/*!40000 ALTER TABLE `build_parts` DISABLE KEYS */;
INSERT INTO `build_parts` VALUES (1,1,1,1),(2,1,2,7),(3,1,3,1),(4,2,4,13),(5,2,5,6),(6,3,6,4),(7,3,7,4),(8,4,8,1),(9,4,9,1),(10,5,10,1),(11,5,11,1),(12,5,12,1);
/*!40000 ALTER TABLE `build_parts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `builds`
--

DROP TABLE IF EXISTS `builds`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `builds` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `item_id` int unsigned NOT NULL,
  `is_default` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `item_id` (`item_id`),
  CONSTRAINT `builds_ibfk_1` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `builds`
--

LOCK TABLES `builds` WRITE;
/*!40000 ALTER TABLE `builds` DISABLE KEYS */;
INSERT INTO `builds` VALUES (1,1,1),(2,2,1),(3,3,1),(4,4,1),(5,5,1);
/*!40000 ALTER TABLE `builds` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart`
--

DROP TABLE IF EXISTS `cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL,
  `build_id` int unsigned NOT NULL,
  `quantity` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `build_id` (`build_id`),
  CONSTRAINT `cart_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `cart_ibfk_2` FOREIGN KEY (`build_id`) REFERENCES `builds` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart`
--

LOCK TABLES `cart` WRITE;
/*!40000 ALTER TABLE `cart` DISABLE KEYS */;
INSERT INTO `cart` VALUES (1,2,1,1),(2,2,2,4),(3,2,3,4);
/*!40000 ALTER TABLE `cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `items`
--

DROP TABLE IF EXISTS `items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `items` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `_name` varchar(100) DEFAULT NULL,
  `price` decimal(6,2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `items`
--

LOCK TABLES `items` WRITE;
/*!40000 ALTER TABLE `items` DISABLE KEYS */;
INSERT INTO `items` VALUES (1,'Papentable',200.99),(2,'Schlupenseaten',50.99),(3,'Atabenche',150.99),(4,'Bunkschlef',100.99),(5,'Bettabel',80.99);
/*!40000 ALTER TABLE `items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `materials`
--

DROP TABLE IF EXISTS `materials`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `materials` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `_name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `materials`
--

LOCK TABLES `materials` WRITE;
/*!40000 ALTER TABLE `materials` DISABLE KEYS */;
INSERT INTO `materials` VALUES (1,'Wood 1'),(2,'Wood 2'),(3,'Wood 3'),(4,'Wood 4'),(5,'Wood 5'),(6,'Aluminium'),(7,'Gold'),(8,'Steel'),(9,'White marble'),(10,'Black marble'),(11,'Beige marble'),(12,'Leather'),(13,'Fabric');
/*!40000 ALTER TABLE `materials` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_statuses`
--

DROP TABLE IF EXISTS `order_statuses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_statuses` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `_name` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_statuses`
--

LOCK TABLES `order_statuses` WRITE;
/*!40000 ALTER TABLE `order_statuses` DISABLE KEYS */;
INSERT INTO `order_statuses` VALUES (1,'Pending'),(2,'Accepted'),(3,'Rejected'),(4,'Cancelled'),(5,'Dispatched'),(6,'Delivered');
/*!40000 ALTER TABLE `order_statuses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL,
  `status_id` int unsigned NOT NULL,
  `content` json DEFAULT NULL,
  `placed` timestamp NULL DEFAULT NULL,
  `due` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `status_id` (`status_id`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`status_id`) REFERENCES `order_statuses` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,2,6,'{}','2023-01-07 19:31:00','2023-02-11 03:23:00'),(2,2,5,'{}','2023-03-04 11:24:00',NULL);
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `part_materials`
--

DROP TABLE IF EXISTS `part_materials`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `part_materials` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `part_id` int unsigned NOT NULL,
  `material_id` int unsigned NOT NULL,
  `added_price` decimal(6,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `part_id` (`part_id`),
  KEY `material_id` (`material_id`),
  CONSTRAINT `part_materials_ibfk_1` FOREIGN KEY (`part_id`) REFERENCES `parts` (`id`),
  CONSTRAINT `part_materials_ibfk_2` FOREIGN KEY (`material_id`) REFERENCES `materials` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `part_materials`
--

LOCK TABLES `part_materials` WRITE;
/*!40000 ALTER TABLE `part_materials` DISABLE KEYS */;
INSERT INTO `part_materials` VALUES (1,1,1,0.00),(2,2,1,0.00),(3,2,7,49.99),(4,3,1,0.00),(5,4,1,0.00),(6,4,13,0.00),(7,5,1,0.00),(8,5,6,10.99),(9,6,1,0.00),(10,6,2,0.00),(11,6,3,0.00),(12,6,4,0.00),(13,6,13,0.00),(14,7,1,0.00),(15,7,2,0.00),(16,7,3,0.00),(17,7,4,0.00),(18,7,6,10.99),(19,8,1,0.00),(20,9,1,0.00),(21,10,1,0.00),(22,11,1,0.00),(23,12,1,0.00);
/*!40000 ALTER TABLE `part_materials` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `parts`
--

DROP TABLE IF EXISTS `parts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `parts` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `item_id` int unsigned NOT NULL,
  `_name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `item_id` (`item_id`),
  CONSTRAINT `parts_ibfk_1` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `parts`
--

LOCK TABLES `parts` WRITE;
/*!40000 ALTER TABLE `parts` DISABLE KEYS */;
INSERT INTO `parts` VALUES (1,1,'Surface'),(2,1,'Accent'),(3,1,'Legs'),(4,2,'Seat'),(5,2,'Legs'),(6,3,'Seat'),(7,3,'Legs'),(8,4,'Body'),(9,4,'Shelves'),(10,5,'Body'),(11,5,'Surface'),(12,5,'Drawer');
/*!40000 ALTER TABLE `parts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(50) DEFAULT NULL,
  `_password` varchar(50) DEFAULT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `phone_number` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'admin','admin','','',''),(2,'test','test','Firstname','Lastname','0123456789'),(3,'carl_marks','commulists','Carl','Marks','0952678123');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'furniture_store'
--

--
-- Dumping routines for database 'furniture_store'
--
/*!50003 DROP FUNCTION IF EXISTS `serialize_build` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `serialize_build`(i_build_id int unsigned) RETURNS json
    READS SQL DATA
begin
	declare current_part_id int unsigned;
	declare current_material_id int unsigned;
    declare done int default false;
	declare build_parts_cursor cursor for 
		select part_id, material_id from build_parts where build_id = i_build_id;
	declare continue handler for not found 
		set done = true;
        
	set @parts = json_array();
        
	open build_parts_cursor;
	_loop: loop
		fetch build_parts_cursor into current_part_id, current_material_id;
		if done then
			leave _loop;
		end if;
		set @parts = json_merge_preserve(@parts, json_array(json_object("part_id", current_part_id, "material_id", current_material_id)));
	end loop;
    close build_parts_cursor;
    
    return json_object("item_id", (select item_id from builds where id = i_build_id), "parts", cast(@parts as json));
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_build` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_build`(
	in i_item_id int unsigned, 
    in i_is_default int unsigned
)
begin 
	insert into builds(item_id, is_default) values (i_item_id, i_is_default);
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_build_part` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_build_part`(
	in i_build_id int unsigned, 
    in i_part_id int unsigned, 
    in i_material_id int unsigned
)
begin
	insert into build_parts(build_id, part_id, material_id) values (i_build_id, i_part_id, i_material_id);
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_item` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_item`(
	in i_name varchar(100), 
    in i_price decimal(6,2)
)
begin 
	insert into items (_name, price) values (i_name, i_price);
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_material` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_material`(
	in i_name varchar(50)
)
begin 
	insert into materials(_name) values (i_name);
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_order` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_order`(
	in i_user_id int unsigned,
    in i_status_id int unsigned,
    in i_content json,
	in i_placed timestamp,
	in i_due timestamp
)
begin
	insert into orders(user_id, status_id, content, placed, due) 
    values (i_user_id, i_status_id, i_content, i_placed, i_due);
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_order_status` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_order_status`(
	in i_name varchar(15)
)
begin
	insert into order_statuses(_name) values (i_name);
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_part` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_part`(
	in i_item_id int unsigned, 
    in i_name varchar(50)
)
begin 
	insert into parts(item_id, _name) values (i_item_id, i_name);
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_part_materials` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_part_materials`(
	in i_part_id int unsigned, 
    in i_material_id int unsigned, 
    in i_added_price decimal(6,2)
)
begin 
	insert into part_materials(part_id, material_id, added_price) values (i_part_id, i_material_id, i_added_price);
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_to_cart` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_to_cart`(
	in i_user_id int unsigned,
    in i_build_id int unsigned,
    in i_quantity int unsigned
)
begin
	if ((select count(build_id) from cart where user_id = i_user_id and build_id = i_build_id) > 0) then
        update cart set quantity = quantity + i_quantity where id = (select id from (select * from cart) as _cart where user_id = i_user_id and build_id = i_build_id limit 1);
	else
		insert into cart(user_id, build_id, quantity) values (i_user_id, i_build_id, i_quantity);
	end if;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_user` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_user`(
	in i_username varchar(50), 
    in i_password varchar(50),
    in i_first_name varchar(50), 
    in i_last_name varchar(50), 
    in i_phone_number varchar(50)
)
begin
	if ((select count(id) from users where username = i_username) = 0) then
		insert into users(username, _password, first_name, last_name, phone_number) values (i_username, i_password, i_first_name, i_last_name, i_phone_number);
	end if;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `create_order_from_cart` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `create_order_from_cart`(
	in i_user_id int unsigned,
    out o_order_id int unsigned
)
begin       
	declare current_build_id int unsigned;
	declare current_quantity int unsigned;
    declare done int default false;
	declare cart_cursor cursor for 
		select build_id, quantity from cart where user_id = i_user_id;
	declare continue handler for not found 
		set done = true;
	
    start transaction;
		if((select count(id) from cart where user_id = i_user_id) > 0) then
			set @builds = json_array();
				
			open cart_cursor;
			_loop: loop
				fetch cart_cursor into current_build_id, current_quantity;
				if done then
					leave _loop;
				end if;
				set @builds = json_merge_preserve(@builds, json_array(json_object("quantity", current_quantity, "build", serialize_build(current_build_id))));
                if ((select is_default from builds where id = current_build_id limit 1) = false) then
					call delete_build(current_build_id);
				else
					delete from cart where build_id = current_build_id;
					if ((select count(id) from cart where build_id = current_build_id) = 0 and !(select is_default from builds where id = current_build_id)) then
						call delete_build(current_build_id);
					end if;
				end if;
			end loop;
			close cart_cursor;
			
			insert into orders(user_id, status_id, content) values (i_user_id, 1, @builds);
            set o_order_id = LAST_INSERT_ID();
		end if;
    commit;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_build` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_build`(
	in i_id int unsigned
)
begin 
	declare done int default false;
    declare current_id int unsigned;
    declare current_is_deleted bool;
    declare cart_cursor cursor for 
		select id from cart where build_id = i_id;
	declare build_parts_cursor cursor for 
		select id from build_parts where build_id = i_id;
	declare continue handler for not found 
		set done = true;
        
	open cart_cursor;
	_loop: loop
		fetch cart_cursor into current_id;
		if done then
			leave _loop;
		end if;
		delete from cart where id = current_id;
	end loop;
	close cart_cursor;
	
    set done = false;
	open build_parts_cursor;
	_loop: loop
		fetch build_parts_cursor into current_id;
		if done then
			leave _loop;
		end if;
		call delete_build_part(current_id);
	end loop;
	close build_parts_cursor;

	delete from builds where id = i_id;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_build_part` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_build_part`(
	in i_id int unsigned
)
begin
	delete from build_parts where id = i_id;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `edit_in_cart` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `edit_in_cart`(
	in i_user_id int unsigned,
    in i_build_id int unsigned,
    in i_new_quantity int unsigned
)
begin
	if ((select count(build_id) from cart where user_id = i_user_id and build_id = i_build_id) > 0) then
		set @existing_id = (select id from (select * from cart) as _cart where user_id = i_user_id and build_id = i_build_id limit 1);
        set @quantity = (select quantity from cart where id = @existing_id);
        if (@quantity > 0) then
			if (i_new_quantity <= 0) then
				delete from cart where id = @existing_id;
                if ((select count(id) from cart where build_id = i_build_id) = 0 and !(select is_default from builds where id = i_build_id)) then
					call delete_build(i_build_id);
                end if;
			else
				update cart set quantity = i_new_quantity where id = @existing_id;
			end if;
		end if;
	end if;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `remove_from_cart` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `remove_from_cart`(
	in i_user_id int unsigned,
    in i_build_id int unsigned,
    in i_quantity int unsigned
)
begin
	if ((select count(build_id) from cart where user_id = i_user_id and build_id = i_build_id) > 0) then
		set @existing_id = (select id from (select * from cart) as _cart where user_id = i_user_id and build_id = i_build_id limit 1);
        set @quantity = (select quantity from cart where id = @existing_id);
        if (@quantity > 0) then
			if (@quantity - i_quantity <= 0) then
				delete from cart where id = @existing_id;
                if ((select count(id) from cart where build_id = i_build_id) = 0 and !(select is_default from builds where id = i_build_id)) then
					call delete_build(i_build_id);
                end if;
			else
				update cart set quantity = @quantity- i_quantity where id = @existing_id;
			end if;
		end if;
	end if;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `all_default_builds`
--

/*!50001 DROP VIEW IF EXISTS `all_default_builds`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `all_default_builds` AS select `_builds`.`id` AS `build_id`,`items`.`_name` AS `item_name`,`parts`.`_name` AS `part_name`,`materials`.`_name` AS `material_name` from (((((select `builds`.`id` AS `id`,`builds`.`item_id` AS `item_id`,`builds`.`is_default` AS `is_default` from `builds` where (0 <> `builds`.`is_default`)) `_builds` left join `items` on((`items`.`id` = `_builds`.`item_id`))) left join `build_parts` on((`build_parts`.`build_id` = `_builds`.`id`))) left join `parts` on((`parts`.`id` = `build_parts`.`part_id`))) left join `materials` on((`materials`.`id` = `build_parts`.`material_id`))) order by `_builds`.`id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `all_items`
--

/*!50001 DROP VIEW IF EXISTS `all_items`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `all_items` AS select `items`.`id` AS `item_id`,`items`.`_name` AS `item_name`,`items`.`price` AS `price`,`parts`.`id` AS `part_id`,`parts`.`_name` AS `part_name`,`materials`.`id` AS `material_id`,`materials`.`_name` AS `material_name`,`part_materials`.`added_price` AS `added_price` from (((`items` left join `parts` on((`parts`.`item_id` = `items`.`id`))) left join `part_materials` on((`part_materials`.`part_id` = `parts`.`id`))) left join `materials` on((`materials`.`id` = `part_materials`.`material_id`))) order by `items`.`id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `all_non_default_user_cart_builds`
--

/*!50001 DROP VIEW IF EXISTS `all_non_default_user_cart_builds`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `all_non_default_user_cart_builds` AS select `cart`.`user_id` AS `user_id`,`_builds`.`id` AS `build_id`,`items`.`_name` AS `item_name`,`parts`.`_name` AS `part_name`,`materials`.`_name` AS `material_name` from ((((((select `builds`.`id` AS `id`,`builds`.`item_id` AS `item_id`,`builds`.`is_default` AS `is_default` from `builds` where (0 = `builds`.`is_default`)) `_builds` left join `items` on((`items`.`id` = `_builds`.`item_id`))) left join `build_parts` on((`build_parts`.`build_id` = `_builds`.`id`))) left join `parts` on((`parts`.`id` = `build_parts`.`part_id`))) left join `materials` on((`materials`.`id` = `build_parts`.`material_id`))) left join `cart` on((`cart`.`build_id` = `_builds`.`id`))) order by `_builds`.`id` */;
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

-- Dump completed on 2023-06-15 13:12:02
