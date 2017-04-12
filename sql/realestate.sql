CREATE DATABASE  IF NOT EXISTS `realestate` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `realestate`;
-- MySQL dump 10.13  Distrib 5.7.16, for Linux (x86_64)
--
-- Host: localhost    Database: realestate
-- ------------------------------------------------------
-- Server version	5.7.16-0ubuntu0.16.04.1

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
-- Table structure for table `ADDRESS_COMPONENTS`
--

DROP TABLE IF EXISTS `ADDRESS_COMPONENTS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ADDRESS_COMPONENTS` (
  `IDADDRESSCOMPONENT` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `IDPLACE` int(10) unsigned DEFAULT NULL,
  `long_name` varchar(45) DEFAULT NULL,
  `short_name` varchar(45) DEFAULT NULL,
  `types` set('street_address','route','intersection','political','country','administrative_area_level_1','administrative_area_level_2','administrative_area_level_3','administrative_area_level_4','administrative_area_level_5','colloquial_area','locality','ward','sublocality','sublocality_level_1','sublocality_level_2','sublocality_level_3','sublocality_level_4','sublocality_level_5','neighborhood','premise','subpremise','postal_code','natural_feature','airport','park','point_of_interest','floor','establishment','parking','post_box','postal_town','room','street_number','bus_station','train_station','transit_station') NOT NULL,
  PRIMARY KEY (`IDADDRESSCOMPONENT`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ADDRESS_COMPONENTS`
--

LOCK TABLES `ADDRESS_COMPONENTS` WRITE;
/*!40000 ALTER TABLE `ADDRESS_COMPONENTS` DISABLE KEYS */;
INSERT INTO `ADDRESS_COMPONENTS` VALUES (1,1,'24В','24В','street_number'),(2,1,'улица Строителей','ул. Строителей','route'),(3,1,'Пермь','Пермь','political,locality'),(4,1,'город Пермь','г. Пермь','political,administrative_area_level_2'),(5,1,'Пермский край','Пермский край','political,administrative_area_level_1'),(6,1,'Россия','RU','political,country'),(7,1,'614097','614097','postal_code'),(8,2,'33','33','street_number'),(9,2,'улица Строителей','ул. Строителей','route'),(10,2,'Пермь','Пермь','political,locality'),(11,2,'город Пермь','г. Пермь','political,administrative_area_level_2'),(12,2,'Пермский край','Пермский край','political,administrative_area_level_1'),(13,2,'Россия','RU','political,country'),(14,2,'614097','614097','postal_code'),(15,3,'12','12','street_number'),(16,3,'Проспект Парковый','просп. Парковый','route'),(17,3,'Пермь','Пермь','political,locality'),(18,3,'город Пермь','г. Пермь','political,administrative_area_level_2'),(19,3,'Пермский край','Пермский край','political,administrative_area_level_1'),(20,3,'Россия','RU','political,country'),(21,3,'614097','614097','postal_code'),(22,4,'33','33','street_number'),(23,4,'улица Строителей','ул. Строителей','route'),(24,4,'Чернушка','Чернушка','political,locality'),(25,4,'Чернушинский район','Чернушинский р-н','political,administrative_area_level_2'),(26,4,'Пермский край','Пермский край','political,administrative_area_level_1'),(27,4,'Россия','RU','political,country'),(28,4,'617831','617831','postal_code');
/*!40000 ALTER TABLE `ADDRESS_COMPONENTS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `MARKER`
--

DROP TABLE IF EXISTS `MARKER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `MARKER` (
  `IDMARKER` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `IDREALESTATE` int(10) unsigned DEFAULT NULL,
  `NAME` char(45) DEFAULT NULL,
  `LAT` double DEFAULT NULL,
  `LNG` double DEFAULT NULL,
  PRIMARY KEY (`IDMARKER`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `MARKER`
--

LOCK TABLES `MARKER` WRITE;
/*!40000 ALTER TABLE `MARKER` DISABLE KEYS */;
/*!40000 ALTER TABLE `MARKER` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PLACE`
--

DROP TABLE IF EXISTS `PLACE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PLACE` (
  `IDPLACE` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `place_id` text NOT NULL COMMENT 'Type:  string\nA unique identifier for a place.',
  `name` text,
  `lat` double DEFAULT NULL,
  `lng` double DEFAULT NULL,
  `vicinity` varchar(45) DEFAULT NULL,
  `formatted_address` varchar(90) DEFAULT NULL,
  `south` double DEFAULT NULL,
  `west` double DEFAULT NULL,
  `north` double DEFAULT NULL,
  `east` double DEFAULT NULL,
  `utc_offset` int(11) DEFAULT NULL,
  `website` varchar(45) DEFAULT NULL,
  `international_phone_number` varchar(45) DEFAULT NULL,
  `permanently_closed` smallint(1) DEFAULT NULL,
  `price_level` smallint(1) DEFAULT NULL COMMENT 'Type:  number\nThe price level of the Place, on a scale of 0 to 4. Price levels are interpreted as follows:\n\n    0: Free\n    1: Inexpensive\n    2: Moderate\n    3: Expensive\n    4: Very Expensive ',
  `rating` float DEFAULT NULL COMMENT 'Type:  number\nA rating, between 1.0 to 5.0, based on user reviews of this Place.',
  `types` set('street_address','route','intersection','political','country','administrative_area_level_1','administrative_area_level_2','administrative_area_level_3','administrative_area_level_4','administrative_area_level_5','colloquial_area','locality','ward','sublocality','sublocality_level_1','sublocality_level_2','sublocality_level_3','sublocality_level_4','sublocality_level_5','neighborhood','premise','subpremise','postal_code','natural_feature','airport','park','point_of_interest','floor','establishment','parking','post_box','postal_town','room','street_number','bus_station','train_station','transit_station') DEFAULT NULL,
  `location_type` enum('ROOFTOP','RANGE_INTERPOLATED','GEOMETRIC_CENTER','APPROXIMATE') DEFAULT NULL,
  PRIMARY KEY (`IDPLACE`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PLACE`
--

LOCK TABLES `PLACE` WRITE;
/*!40000 ALTER TABLE `PLACE` DISABLE KEYS */;
INSERT INTO `PLACE` VALUES (1,'ChIJwxkFmJ646EMR2vuhpEDQEH8','ул. Строителей, 24В',57.9997018,56.148065299999985,'Пермь','ул. Строителей, 24В, Пермь, Пермский край, Россия, 614097',57.99992964999999,57.99962585000001,56.148002450000035,56.148086250000006,300,NULL,NULL,NULL,NULL,NULL,'street_address',NULL),(2,'ElvRg9C7LiDQodGC0YDQvtC40YLQtdC70LXQuSwgMzMsINCf0LXRgNC80YwsINCf0LXRgNC80YHQutC40Lkg0LrRgNCw0LksINCg0L7RgdGB0LjRjywgNjE0MDk3','ул. Строителей, 33',57.9997707,56.14708150000001,'Пермь','ул. Строителей, 33, Пермь, Пермский край, Россия, 614097',57.99978555000001,57.99976575,56.14707729999998,56.14708289999999,300,NULL,NULL,NULL,NULL,NULL,'street_address,route',NULL),(3,'ChIJqb3XGZm46EMRyniZza8ffaw','просп. Парковый, 12',57.9970913,56.14497600000004,'Пермь','просп. Парковый, 12, Пермь, Пермский край, Россия, 614097',57.99727429999999,57.9970303,56.144930250000016,56.144991249999975,300,NULL,NULL,NULL,NULL,NULL,'street_address',NULL),(4,'ChIJESdk_SB53UMRzhRHy5Ioii4','ул. Строителей, 33',56.48981240000001,56.077705599999945,'Чернушка','ул. Строителей, 33, Чернушка, Пермский край, Россия, 617831',56.4899922,56.48927299999999,56.077423599999975,56.07855159999997,300,NULL,NULL,NULL,NULL,NULL,'street_address',NULL);
/*!40000 ALTER TABLE `PLACE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `POLYGON`
--

DROP TABLE IF EXISTS `POLYGON`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `POLYGON` (
  `IDPOLYGON` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `LAT` double DEFAULT NULL,
  `LNG` double DEFAULT NULL,
  `IDREALESTATE` int(10) unsigned DEFAULT NULL,
  `NUMBER` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`IDPOLYGON`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `POLYGON`
--

LOCK TABLES `POLYGON` WRITE;
/*!40000 ALTER TABLE `POLYGON` DISABLE KEYS */;
/*!40000 ALTER TABLE `POLYGON` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `REALESTATE`
--

DROP TABLE IF EXISTS `REALESTATE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `REALESTATE` (
  `IDREALESTATE` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `IDUSER` int(10) unsigned DEFAULT NULL,
  `IDPLACE` int(10) unsigned DEFAULT NULL,
  `TEXT` char(255) DEFAULT NULL,
  `DEAL` enum('SELL','BUY','EXCHANGE','SELLRENT','BUYRENT') DEFAULT NULL,
  `PROPERTY` enum('APARTMENT','HOUSE','PARCEL','GARAGE','ROOM','HOTEL','OTHER') DEFAULT NULL,
  `DATACREATE` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `DATAUPDATE` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `PRICE` bigint(20) DEFAULT NULL,
  `CURRENCY` enum('₽','$','€','¥') DEFAULT '₽',
  `CADASTRNUMBER` char(20) DEFAULT NULL,
  `NUMBER` int(10) unsigned DEFAULT NULL,
  `CHECKBOXES` set('ISBYAGREEMENT','ISDOCUMENT','ELECTRONMONEY','PREPAYMENT','CARD','CASH','DEALTESTDRIVE','ENGINEERINGELECTRICITY','ENGINEERINGHEATING','ENGINEERINGHOTWATER','ENGINEERINGCOLDWATER','ENGINEERINGGAS','ENGINEERINGVENTILATION','ENGINEERINGSEWERAGE','ENGINEERINGELEVATOR','ENGINEERINGINTERNET','BESIDEPARKINGUNDERGROUND','BESIDEPARKINGLOT','BESIDEPARKINGMULTILEVEL','BESIDEPARKINGCOVERED','BESIDEPARKINGPROTECTION','BESIDEGOODTRANSPORTINTERCHANGE') DEFAULT NULL,
  `SPACETOTAL` float DEFAULT NULL,
  PRIMARY KEY (`IDREALESTATE`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `REALESTATE`
--

LOCK TABLES `REALESTATE` WRITE;
/*!40000 ALTER TABLE `REALESTATE` DISABLE KEYS */;
INSERT INTO `REALESTATE` VALUES (1,1,1,'Хорошая квартира','SELL','APARTMENT','2016-10-27 06:27:31','2016-10-27 12:00:58',2000000,'₽',NULL,1,'CASH',99),(2,1,2,'Превосходный дом у реки','SELL','APARTMENT','2016-10-27 07:07:53','2016-10-27 12:00:58',0,'₽',NULL,2,'ISBYAGREEMENT,CASH',444),(3,1,3,'Удивительная комната в центре города','SELL','APARTMENT','2016-10-27 07:49:16','2016-10-27 11:29:14',1100000,'₽',NULL,3,'CASH,ENGINEERINGELECTRICITY,ENGINEERINGHEATING,ENGINEERINGHOTWATER,ENGINEERINGCOLDWATER',222),(4,1,4,'Изумительная берлога одинокого программиста','SELL','APARTMENT','2016-10-27 09:07:47','2016-10-27 11:29:14',1500000,'₽',NULL,4,'ENGINEERINGCOLDWATER',555);
/*!40000 ALTER TABLE `REALESTATE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `REALESTATEAPARTMENT`
--

DROP TABLE IF EXISTS `REALESTATEAPARTMENT`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `REALESTATEAPARTMENT` (
  `IDREALESTATE` int(10) unsigned NOT NULL,
  `APARTMENTINTEGRITY` enum('APARTMENT','PARTAPARTMENT') DEFAULT 'APARTMENT' COMMENT 'Целостность:\n1. Квартира\n2. Часть квартиры',
  `APARTMENTSTATUS` enum('APARTMENT','HOUSING') DEFAULT 'APARTMENT' COMMENT 'Статус:\n1. Квартира\n2. Жилое помещение\n',
  `APARTMENTQUANTITYROOMS` tinyint(3) unsigned DEFAULT '2' COMMENT 'Всего комнат',
  `APARTMENTOWNEDROOMS` tinyint(3) unsigned DEFAULT NULL COMMENT 'Комнат в собственности',
  `APARTMENTRESIDENTIALSPACE` float unsigned DEFAULT NULL COMMENT 'Жилая площадь',
  `APARTMENTTYPEHOUSE` enum('PANEL','MONOLITHIC','MODULAR','BRICK') DEFAULT NULL COMMENT '1 - Панельный\n2 - Монолитный\n3 - Блочный\n4 - Кирпичный',
  `APARTMENTNUMBEROFSTOREYS` tinyint(3) unsigned DEFAULT NULL COMMENT 'Скольки этажный дом',
  `APARTMENTFLOOR` tinyint(1) unsigned DEFAULT NULL COMMENT 'На каком этаже квартира',
  `APARTMENTCEILINGHEIGHT` float unsigned DEFAULT NULL COMMENT 'Высота этажа',
  `APARTMENTHOUSING` enum('SECONDARY','PRIMARY') DEFAULT 'SECONDARY' COMMENT '1 - Вторичное жилье\n2 - Первичное жилье',
  `CHECKBOXES` set('APARTMENTPLAYGROUND','APARTMENTINTERCOM','APARTMENTSTUDIO','APARTMENTQUIETNEIGHBORS') DEFAULT NULL,
  PRIMARY KEY (`IDREALESTATE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `REALESTATEAPARTMENT`
--

LOCK TABLES `REALESTATEAPARTMENT` WRITE;
/*!40000 ALTER TABLE `REALESTATEAPARTMENT` DISABLE KEYS */;
INSERT INTO `REALESTATEAPARTMENT` VALUES (1,'APARTMENT','APARTMENT',2,NULL,90,'MONOLITHIC',1,1,1,'PRIMARY',''),(2,'APARTMENT','APARTMENT',2,NULL,NULL,'MONOLITHIC',NULL,NULL,NULL,'SECONDARY',''),(3,'APARTMENT','APARTMENT',2,NULL,NULL,NULL,NULL,NULL,NULL,'SECONDARY',NULL);
/*!40000 ALTER TABLE `REALESTATEAPARTMENT` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `REALESTATEAPARTMENTROOM`
--

DROP TABLE IF EXISTS `REALESTATEAPARTMENTROOM`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `REALESTATEAPARTMENTROOM` (
  `IDAPARTMENTROOM` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `IDREALESTATE` int(10) unsigned NOT NULL,
  `APARTMENTNEWNAMEROOM` varchar(20) DEFAULT NULL COMMENT 'Название комнаты',
  `APARTMENTNEWROOMSPACE` float unsigned DEFAULT NULL COMMENT 'Площадь комнаты',
  `APARTMENTLOGGIA` enum('WINDOW','LOGGIA','BALCONY','NOTHING') DEFAULT 'WINDOW' COMMENT '1 - Есть окно\n2 - Есть лоджия\n3 - Есть балкон\n4 - Нет',
  `APARTMENTVIEWFROMTHEWINDOW` varchar(20) DEFAULT NULL COMMENT 'С видом на',
  `APARTMENTWINDOWSIDE` enum('SOUTH','WEST','EAST','NORTH','SOUTHEAST','SOUTHWEST','NORTHEAST','NORTHWEST') DEFAULT NULL COMMENT '0 - Выбрать\r\n1 - Юг\r\n2 - Запад\r\n3 - Восток\r\n4 - Север\r\n5 - Юго-Восток\r\n6 - Юго-Запад\r\n7 - Северо-Восток\r\n8 - Северо-Запад',
  `CHECKBOXES` set('APARTMENTOWNED') DEFAULT NULL COMMENT 'APARTMENTOWNED - в собственности',
  PRIMARY KEY (`IDAPARTMENTROOM`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `REALESTATEAPARTMENTROOM`
--

LOCK TABLES `REALESTATEAPARTMENTROOM` WRITE;
/*!40000 ALTER TABLE `REALESTATEAPARTMENTROOM` DISABLE KEYS */;
/*!40000 ALTER TABLE `REALESTATEAPARTMENTROOM` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `REALESTATEGARAGE`
--

DROP TABLE IF EXISTS `REALESTATEGARAGE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `REALESTATEGARAGE` (
  `IDREALESTATE` int(10) unsigned NOT NULL,
  `GARAGEGARAGEORPARKINGPLACE` enum('ГАРАЖ','МАШИНОМЕСТО') DEFAULT 'ГАРАЖ' COMMENT 'Гараж\nМашиноместо',
  `GARAGETYPEOFPARKING` enum('КРЫТАЯСТОЯНКА','ПОДЗЕМНЫЙПАРКИНГ','МНОГОУРОВНЕВЫЙПАРКИНГ','ОТКРЫТАЯСТОЯНКА') DEFAULT NULL COMMENT '1 Подземный паркинг\n2 Крытая стоянка\n3 Многоуровневый паркинг\n4 Открытая стоянка',
  `GARAGETYPEGARAGE` enum('ЖЕЛЕЗОБЕТОННЫЙ','МЕТАЛЛИЧЕСКИЙ','КИРПИЧНЫЙ') DEFAULT NULL COMMENT '1 Железобетонный\n2 Металлический\n3 Кирпичный',
  `GARAGEFOUNDATION` enum('ЛЕНТОЧНЫЙ','СТОЛБЧАТЫЙ','ПЛИТНЫЙ','КОНТИНУАЛЬНЫЙ') DEFAULT NULL COMMENT '1 Ленточный\n2 Столбчатый\n3 Плитный\n4 Континуальный',
  `GARAGEHOWMANYFLOORS` tinyint(3) unsigned DEFAULT NULL COMMENT 'Сколько этажей',
  `GARAGEFLOOR` tinyint(3) unsigned DEFAULT NULL COMMENT 'На каком этаже',
  `GARAGECOMPLEXNAME` varchar(20) DEFAULT NULL COMMENT 'Название комплекса',
  `GARAGECEILINGHEIGHT` float unsigned DEFAULT NULL COMMENT 'Высота потолков',
  `GARAGEGATEHEIGHT` float unsigned DEFAULT NULL COMMENT 'Высота ворот',
  `CHECKBOXES` set('GARAGEANDPARCELOWNED','GARAGEPROTECTED','GARAGEVIDEOMONITORING','GARAGELIGHTING','GARAGECELLAR','GARAGEBASEMENT','GARAGEPIT','GARAGESHELVES') DEFAULT NULL COMMENT 'GARAGEANDPARCELOWNED Гараж и земля в собственности ### GARAGEPROTECTED Охраняется ### GARAGEVIDEOMONITORING Видеонаблюдение\nGARAGELIGHTING Освещение ### GARAGECELLAR Погреб ### GARAGEBASEMENT Подвал ### GARAGEPIT Яма ### GARAGESHELVES Полки\n',
  PRIMARY KEY (`IDREALESTATE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `REALESTATEGARAGE`
--

LOCK TABLES `REALESTATEGARAGE` WRITE;
/*!40000 ALTER TABLE `REALESTATEGARAGE` DISABLE KEYS */;
/*!40000 ALTER TABLE `REALESTATEGARAGE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `REALESTATEHOTEL`
--

DROP TABLE IF EXISTS `REALESTATEHOTEL`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `REALESTATEHOTEL` (
  `IDREALESTATE` int(10) unsigned NOT NULL,
  `HOTELHOWMANYFLOORS` tinyint(3) unsigned DEFAULT NULL COMMENT 'Сколько этажей',
  `HOTELHOWMANYROOMS` smallint(5) unsigned DEFAULT NULL COMMENT 'Сколько номеров',
  `HOTELHOWMANYSTARS` enum('1','2','3','4','5') DEFAULT '5' COMMENT 'Сколько звезд',
  `HOTELTYPEBUILDING` enum('ПАНЕЛЬНОЕ','МОНОЛИТНОЕ','БЛОЧНОЕ','КИРПИЧНОЕ') DEFAULT NULL COMMENT 'Панельное\nМонолитное\nБлочное\nКирпичное',
  `HOTELFOUNDATION` enum('ЛЕНТОЧНЫЙ','СТОЛБЧАТЫЙ','ПЛИТНЫЙ','КОНТИНУАЛЬНЫЙ') DEFAULT NULL COMMENT 'Ленточный\nСтолбчатый\nПлитный\nКонтинуальный',
  `CHECKBOXES` set('HOTELNONSMOKINGROOMS','HOTELFAMILYROOMS','HOTELINDOORSWIMMINGPOOL','HOTELSPAWELLNESSCENTRE','HOTELRESTAURANTDINING','HOTELFITNESSCENTRE','ОТЕЛЬУДОБСТВАДЛЯГОСТЕЙСОГРАНИЧЕННЫМИФИЗИЧЕСКИМИВОЗМОЖНОСТЯМИ','HOTELMEETINGBANQUET','HOTELFACILITIES','HOTELBAR','HOTELHONEYMOONSUITE','HOTELBARBERBEAUTYSALON','ОТЕЛЬСАУНА','ОТЕЛЬСОЛЯРИЙ','ОТЕЛЬТУРЕЦКАЯБАНЯ','ОТЕЛЬМАССАЖ') DEFAULT NULL COMMENT 'HOTELNONSMOKINGROOMS > Номера для не курящих ### HOTELFAMILYROOMS > Семейные номера ### HOTELINDOORSWIMMINGPOOL > Крытый плавательный бассейн\r\nHOTELSPAWELLNESSCENTRE > Спа и оздоровительный центр ### HOTELRESTAURANTDINING > Ресторан \\ Столовая ### HOTELFITNESSCENTRE > Фитнес-центр\r\nHOTELFITNESSCENTRE > Удобства для гостей с ограниченными физическими возможностями ### HOTELMEETINGBANQUET > Конференц-зал\r\nHOTELFACILITIES > Банкетный зал ### HOTELBAR > Бар ### HOTELHONEYMOONSUITE > Люкс для новобрачных ### HOTELBARBERBEAUTYSALON > Парикмахерская/салон красоты\r\nОТЕЛЬСАУНА > Сауна ### ОТЕЛЬСОЛЯРИЙ > Солярий ### ОТЕЛЬТУРЕЦКАЯБАНЯ > Турецкая баня ### ОТЕЛЬМАССАЖ > Массаж',
  PRIMARY KEY (`IDREALESTATE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `REALESTATEHOTEL`
--

LOCK TABLES `REALESTATEHOTEL` WRITE;
/*!40000 ALTER TABLE `REALESTATEHOTEL` DISABLE KEYS */;
/*!40000 ALTER TABLE `REALESTATEHOTEL` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `REALESTATEHOTELROOM`
--

DROP TABLE IF EXISTS `REALESTATEHOTELROOM`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `REALESTATEHOTELROOM` (
  `IDHOTELROOM` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `IDREALESTATE` int(10) unsigned NOT NULL,
  `HOTELMOREROOMNAME` varchar(20) DEFAULT NULL,
  `HOTELMOREROOMSPACE` float unsigned DEFAULT NULL,
  `HOTELMOREROOMINFO` text,
  PRIMARY KEY (`IDHOTELROOM`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `REALESTATEHOTELROOM`
--

LOCK TABLES `REALESTATEHOTELROOM` WRITE;
/*!40000 ALTER TABLE `REALESTATEHOTELROOM` DISABLE KEYS */;
/*!40000 ALTER TABLE `REALESTATEHOTELROOM` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `REALESTATEHOUSE`
--

DROP TABLE IF EXISTS `REALESTATEHOUSE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `REALESTATEHOUSE` (
  `IDREALESTATE` int(10) unsigned NOT NULL,
  `ISFULLHOUSE` enum('HOUSE','PARTHOUSE') DEFAULT 'HOUSE' COMMENT 'Целостность',
  `HOUSEQUANTITYROOMS` tinyint(3) unsigned DEFAULT '1' COMMENT 'Всего комнат',
  `HOUSEOWNEDROOMS` tinyint(3) unsigned DEFAULT '1' COMMENT 'В собственности',
  `HOUSERESIDENTIALSPACE` float unsigned DEFAULT NULL COMMENT 'Жилая площадь',
  `HOUSEHOWMANYFLOORS` tinyint(3) unsigned DEFAULT NULL COMMENT 'Сколько этажей',
  `HOUSETYPEHOUSE` enum('PANEL','MONOLITHIC','MODULAR','BRICK') DEFAULT NULL COMMENT '1 Панельный\n2 Монолитный\n3 Блочный\n4 Кирпичный',
  `HOUSEHOUSING` enum('SECONDARY','PRIMARY') DEFAULT 'SECONDARY' COMMENT '0 Вторичное жилье\n1 Первичное жилье',
  `HOUSEHEATING` enum('ПЕЧНОЕ','ГАЗОВОЕ','ВОДЯНОЕ','ЭЛЕКТРИЧЕСКОЕ') DEFAULT NULL COMMENT '1 Печное\n2 Газовое\n3 Водяное\n4 Электрическое',
  `HOUSEHOMETOP` enum('МАНСАРДА','ЧЕРДАК') DEFAULT NULL COMMENT '0 Мансарда\n1 Чердак',
  `HOUSECEILINGHEIGHT` float unsigned DEFAULT NULL COMMENT 'Высота потолков',
  `HOUSEFOUNDATION` enum('ЛЕНТОЧНЫЙ','СТОЛБЧАТЫЙ','ПЛИТНЫЙ','КОНТИНУАЛЬНЫЙ') DEFAULT NULL COMMENT 'Фундамент',
  `CHECKBOXES` set('HOUSEPLAYGROUND','HOUSEINTERCOM','HOUSEQUIETNEIGHBORS','HOUSECELLAR','HOUSEBASEMENT') DEFAULT NULL COMMENT 'Детская площадка - ''HOUSEPLAYGROUND''\nЕсть домофон - ''HOUSEINTERCOM''\nНе шумные соседи - ''HOUSEQUIETNEIGHBORS''\nПогреб - ''HOUSECELLAR''\nПодвал - ''HOUSEBASEMENT''',
  PRIMARY KEY (`IDREALESTATE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `REALESTATEHOUSE`
--

LOCK TABLES `REALESTATEHOUSE` WRITE;
/*!40000 ALTER TABLE `REALESTATEHOUSE` DISABLE KEYS */;
/*!40000 ALTER TABLE `REALESTATEHOUSE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `REALESTATEHOUSEROOM`
--

DROP TABLE IF EXISTS `REALESTATEHOUSEROOM`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `REALESTATEHOUSEROOM` (
  `IDHOUSEROOM` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `IDREALESTATE` int(10) unsigned NOT NULL,
  `HOUSENEWROOMNAME` varchar(20) DEFAULT NULL COMMENT 'Название комнаты',
  `HOUSENEWROOMSPACE` float unsigned DEFAULT NULL COMMENT 'Площадь комнаты',
  `HOUSENEWROOMLOGGIA` enum('WINDOW','LOGGIA','BALCONY','NOTHING') DEFAULT NULL COMMENT '1 Есть окно\n2 Есть лоджия\n3 Есть балкон\n4 Нет',
  `HOUSENEWROOMVIEWOFTHE` varchar(20) DEFAULT NULL COMMENT 'С видом на',
  `HOUSENEWROOMSIDE` enum('SOUTH','WEST','EAST','NORTH','SOUTHEAST','SOUTHWEST','NORTHEAST','NORTHWEST') DEFAULT NULL COMMENT '0 - Выбрать\r\n1 - Юг\r\n2 - Запад\r\n3 - Восток\r\n4 - Север\r\n5 - Юго-Восток\r\n6 - Юго-Запад\r\n7 - Северо-Восток\r\n8 - Северо-Запад',
  `CHECKBOXES` set('HOUSENEWROOMOWNED') DEFAULT NULL COMMENT 'HOUSENEWROOMOWNED - в собственности',
  PRIMARY KEY (`IDHOUSEROOM`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `REALESTATEHOUSEROOM`
--

LOCK TABLES `REALESTATEHOUSEROOM` WRITE;
/*!40000 ALTER TABLE `REALESTATEHOUSEROOM` DISABLE KEYS */;
/*!40000 ALTER TABLE `REALESTATEHOUSEROOM` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `REALESTATEOTHER`
--

DROP TABLE IF EXISTS `REALESTATEOTHER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `REALESTATEOTHER` (
  `IDREALESTATE` int(10) unsigned NOT NULL,
  PRIMARY KEY (`IDREALESTATE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `REALESTATEOTHER`
--

LOCK TABLES `REALESTATEOTHER` WRITE;
/*!40000 ALTER TABLE `REALESTATEOTHER` DISABLE KEYS */;
/*!40000 ALTER TABLE `REALESTATEOTHER` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `REALESTATEOTHERBUILDING`
--

DROP TABLE IF EXISTS `REALESTATEOTHERBUILDING`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `REALESTATEOTHERBUILDING` (
  `IDOTHERBUILDING` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `IDREALESTATE` int(10) unsigned NOT NULL,
  `OTHERBUILDINGTEXTAREA` varchar(255) DEFAULT NULL COMMENT 'Дополнительная информация для здания',
  `OTHERNEWBUILDINGNAME` varchar(20) DEFAULT NULL COMMENT 'Название',
  `OTHERNEWBUILDINGSPACE` float unsigned DEFAULT NULL COMMENT 'Площадь',
  `OTHERNEWBUILDINGLOORS` tinyint(3) unsigned DEFAULT NULL COMMENT 'Этажей',
  `OTHERNEWBUILDINGFLOORHEIGHT` float unsigned DEFAULT NULL COMMENT 'Высота этажей',
  `OTHERNEWBUILDINGTYPE` enum('ПАНЕЛЬНОЕ','МОНОЛИТНОЕ','БЛОЧНОЕ','КИРПИЧНОЕ') DEFAULT NULL COMMENT 'Панельное\nМонолитное\nБлочное\nКирпичное',
  `CHECKBOXES` set('OTHERNEWBUILDINGSEPARATEENTRANCE') DEFAULT NULL COMMENT 'Отдельный подъезд',
  PRIMARY KEY (`IDOTHERBUILDING`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `REALESTATEOTHERBUILDING`
--

LOCK TABLES `REALESTATEOTHERBUILDING` WRITE;
/*!40000 ALTER TABLE `REALESTATEOTHERBUILDING` DISABLE KEYS */;
/*!40000 ALTER TABLE `REALESTATEOTHERBUILDING` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `REALESTATEOTHERBUILDINGROOM`
--

DROP TABLE IF EXISTS `REALESTATEOTHERBUILDINGROOM`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `REALESTATEOTHERBUILDINGROOM` (
  `IDOTHERBUILDINGROOM` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `IDOTHERBUILDING` int(10) unsigned DEFAULT NULL,
  `OTHERNEWROOMMOREINFO` varchar(255) DEFAULT NULL,
  `OTHERNEWROOMNAME` varchar(20) DEFAULT NULL,
  `OTHERNEWROOMSPACE` float unsigned DEFAULT NULL,
  PRIMARY KEY (`IDOTHERBUILDINGROOM`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `REALESTATEOTHERBUILDINGROOM`
--

LOCK TABLES `REALESTATEOTHERBUILDINGROOM` WRITE;
/*!40000 ALTER TABLE `REALESTATEOTHERBUILDINGROOM` DISABLE KEYS */;
/*!40000 ALTER TABLE `REALESTATEOTHERBUILDINGROOM` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `REALESTATEPARCEL`
--

DROP TABLE IF EXISTS `REALESTATEPARCEL`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `REALESTATEPARCEL` (
  `IDREALESTATE` int(10) unsigned NOT NULL,
  `PARCELAPIARYSPACE` float unsigned DEFAULT NULL COMMENT 'Площадь пасеки',
  `PARCELQUANTITYHIVES` smallint(5) unsigned DEFAULT NULL COMMENT 'Количество ульев',
  `CHECKBOXES` set('PARCELISAPIARY','PARCELISGARDEN','PARCELISELECTRICITY','PARCELISWATERPIPES','PARCELISGAS','PARCELISINTERNET','PARCELISSEWERAGE','PARCELISHEATING') DEFAULT NULL COMMENT 'PARCELISAPIARY - Есть пасека \\ PARCELISGARDEN - Есть сад \\ PARCELISELECTRICITY - Есть возможность подключить - Электричество\nPARCELISWATERPIPES - Есть возможность подключить - Водопровод \\ PARCELISGAS - Есть возможность подключить - Газ \\ PARCELISINTERNET - Есть возможность подключить - Интернет\nPARCELISSEWERAGE - Есть возможность подключить - Канализация \\ PARCELISHEATING - Есть возможность подключить - Отопление\n',
  PRIMARY KEY (`IDREALESTATE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `REALESTATEPARCEL`
--

LOCK TABLES `REALESTATEPARCEL` WRITE;
/*!40000 ALTER TABLE `REALESTATEPARCEL` DISABLE KEYS */;
/*!40000 ALTER TABLE `REALESTATEPARCEL` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `REALESTATEPARCELHOZBUILDING`
--

DROP TABLE IF EXISTS `REALESTATEPARCELHOZBUILDING`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `REALESTATEPARCELHOZBUILDING` (
  `IDPARCELHOZBUILDING` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `IDREALESTATE` int(10) unsigned NOT NULL,
  `PARCELHOZBUILDINGGNAME` varchar(20) DEFAULT NULL,
  `PARCELHOZBUILDINPLACE` float unsigned DEFAULT NULL,
  PRIMARY KEY (`IDPARCELHOZBUILDING`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `REALESTATEPARCELHOZBUILDING`
--

LOCK TABLES `REALESTATEPARCELHOZBUILDING` WRITE;
/*!40000 ALTER TABLE `REALESTATEPARCELHOZBUILDING` DISABLE KEYS */;
/*!40000 ALTER TABLE `REALESTATEPARCELHOZBUILDING` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `REALESTATEPARCELPLANT`
--

DROP TABLE IF EXISTS `REALESTATEPARCELPLANT`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `REALESTATEPARCELPLANT` (
  `IDPARCELPLANT` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `IDREALESTATE` int(10) unsigned NOT NULL,
  `PARCELNEWPLANT` varchar(20) DEFAULT NULL,
  `PARCELNEWPLANTPLACE` float unsigned DEFAULT NULL,
  PRIMARY KEY (`IDPARCELPLANT`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `REALESTATEPARCELPLANT`
--

LOCK TABLES `REALESTATEPARCELPLANT` WRITE;
/*!40000 ALTER TABLE `REALESTATEPARCELPLANT` DISABLE KEYS */;
/*!40000 ALTER TABLE `REALESTATEPARCELPLANT` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `REALESTATEROOM`
--

DROP TABLE IF EXISTS `REALESTATEROOM`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `REALESTATEROOM` (
  `IDREALESTATE` int(10) unsigned NOT NULL,
  `ROOMTYPEROOM` enum('ОФИСНОЕ','ТОРГОВОЕ','СКЛАДСКОЕ','СВОБОДНОГОНАЗНАЧЕНИЯ','САЛОНКРАСОТЫ','ПРОИЗВОДСТВЕННОГОНАЗНАЧЕНИЯ','ОБЩЕСТВЕННОГОПИТАНИЯ') DEFAULT NULL COMMENT '1 Офисное(контора)\n2 Торговое\n3 Складское\n4 Свободного назначения\n5 Салон красоты, парикмахерская\n6 Производственного назначения\n7 Общественного питания',
  `ROOMTYPEBUILDING` enum('ПАНЕЛЬНОЕ','МОНОЛИТНОЕ','БЛОЧНОЕ','КИРПИЧНОЕ') DEFAULT NULL COMMENT 'Панельное\nМонолитное\nБлочное\nКирпичное',
  `ROOMCEILINGHEIGHT` float unsigned DEFAULT NULL COMMENT 'Высота потолков',
  `ROOMHOWMANYFLOORS` tinyint(3) unsigned DEFAULT NULL COMMENT 'Сколько этажей',
  `ROOMFLOOR` tinyint(3) unsigned DEFAULT NULL COMMENT 'Какой этаж',
  `CHECKBOXES` set('ROOMSEPARATEENTRANCE','ROOMSEPARATEELECTRICALPANEL') DEFAULT NULL COMMENT 'ROOMSEPARATEENTRANCE - Отдельный подъезд\nROOMSEPARATEELECTRICALPANEL - Отдельный электрощиток\n',
  PRIMARY KEY (`IDREALESTATE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `REALESTATEROOM`
--

LOCK TABLES `REALESTATEROOM` WRITE;
/*!40000 ALTER TABLE `REALESTATEROOM` DISABLE KEYS */;
/*!40000 ALTER TABLE `REALESTATEROOM` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `REALESTATEROOMMORE`
--

DROP TABLE IF EXISTS `REALESTATEROOMMORE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `REALESTATEROOMMORE` (
  `IDROOMMORE` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `IDREALESTATE` int(10) unsigned NOT NULL,
  `ROOMMOREROOMNAME` varchar(20) DEFAULT NULL,
  `ROOMMOREROONSPACE` float unsigned DEFAULT NULL,
  PRIMARY KEY (`IDROOMMORE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `REALESTATEROOMMORE`
--

LOCK TABLES `REALESTATEROOMMORE` WRITE;
/*!40000 ALTER TABLE `REALESTATEROOMMORE` DISABLE KEYS */;
/*!40000 ALTER TABLE `REALESTATEROOMMORE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `USER`
--

DROP TABLE IF EXISTS `USER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `USER` (
  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `DATE` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `EMAIL` char(45) NOT NULL,
  `PASSWORD` char(32) NOT NULL,
  `HASH` char(32) DEFAULT NULL,
  `IP` int(12) unsigned DEFAULT NULL,
  `CONFIRMED` enum('YES','NO') DEFAULT NULL,
  `QUANTITY` tinyint(3) unsigned DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `USER`
--

LOCK TABLES `USER` WRITE;
/*!40000 ALTER TABLE `USER` DISABLE KEYS */;
INSERT INTO `USER` VALUES (1,'2016-10-18 09:17:49','asikuo@gmail.com','5b988e9539ca8df1c28c8fcd9b99e163','80aedd8f03d72ef34e4b794d0b4b037a',NULL,NULL,4);
/*!40000 ALTER TABLE `USER` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-10-29 20:50:27
