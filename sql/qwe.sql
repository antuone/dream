-- MySQL dump 10.13  Distrib 5.7.16, for Linux (x86_64)
--
-- Host: localhost    Database: НЕДВИЖИМОСТЬ_СОЛНЕЧНОЙ_СИСТЕМЫ
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
-- Current Database: `НЕДВИЖИМОСТЬ_СОЛНЕЧНОЙ_СИСТЕМЫ`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `НЕДВИЖИМОСТЬ_СОЛНЕЧНОЙ_СИСТЕМЫ` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `НЕДВИЖИМОСТЬ_СОЛНЕЧНОЙ_СИСТЕМЫ`;

--
-- Table structure for table `НЕДВИЖИМОСТЬ`
--

DROP TABLE IF EXISTS `НЕДВИЖИМОСТЬ`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `НЕДВИЖИМОСТЬ` (
  `ИДЕНТИФИКАТОР` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID этой недвижимости',
  `ИД_ПОЛЬЗОВАТЕЛЯ` int(10) unsigned DEFAULT NULL COMMENT 'ID пользователя кому пренадлежит эта недвижимость',
  `ИД_МЕСТА` int(10) unsigned DEFAULT NULL COMMENT 'ID места-адреса этой недвижимости',
  `ТЕКСТ` char(255) DEFAULT NULL COMMENT 'Описание этой недвижимости',
  `СДЕЛКА` enum('ПРОДАЖА','ПОКУПКА','ОБМЕН','ПРОДАЖА_АРЕНДЫ','ПОКУПКА_АРЕНДЫ') DEFAULT NULL COMMENT 'Тип сделки для этой недвижимости',
  `ДАТА_СОЗДАНИЯ` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'дата создания этого обьявления недвижимости',
  `ДАТА_ОБНОВЛЕНИЯ` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'дата обновления этого объявления недвижимости',
  `ЦЕНА` bigint(20) unsigned DEFAULT NULL COMMENT 'Цена этой недвижимости',
  `ВАЛЮТА` enum('₽','$','€','¥') DEFAULT '₽' COMMENT 'Валюта цены для этой недвижимости',
  `НОМЕР_КАДАСТРОВЫЙ` char(20) DEFAULT NULL COMMENT 'кадастровый номер этой недвижимости',
  `НОМЕР_ОБЪЯВЛЕНИЯ` int(10) unsigned DEFAULT NULL COMMENT 'порядковый номер этого объявления для того чтобы знать в какой папке лежат фотки',
  `ОТМЕЧЕННЫЕ_ПУНКТЫ` set('ПО_ДОГОВОРЕННОСТИ','ЕСТЬ_ДОКУМЕНТЫ','ЭЛЕКТРОННЫЕ_ДЕНЬГИ','ПРЕДОПЛАТА','БАНКОВСКАЯ_КАРТА','НАЛИЧКА','DEALTESTDRIVE','ЭЛЕКТРИЧЕСТВО','ОТОПЛЕНИЕ','ГОРЯЧАЯ_ВОДА','ХОЛОДНАЯ_ВОДА','ГАЗ','ВЕНТИЛЯЦИЯ','КАНАЛИЗАЦИЯ','ЛИФТ','ДОМОФОН','ИНТЕРНЕТ','ПОДЗЕМНЫЙ_ПАРКИНГ','ОТКРЫТАЯ_СТОЯНКА','МНОГОУРОВНЕВЫЙ_ПАРКИНГ','КРЫТАЯ_СТОЯНКА','ОХРАНЯЕМАЯ','ХОРОШАЯ_ТРАНСПОРТНАЯ_РАЗВЯЗКА') DEFAULT NULL COMMENT 'Различные чекбоксы для объявления недвижимости',
  `ПЛОЩАДЬ` float unsigned DEFAULT NULL COMMENT 'Общая площадь',
  `КОМНАТ_ВСЕГО` tinyint(3) unsigned DEFAULT NULL COMMENT 'Общее количество комнат',
  `КОМНАТ_ДЛЯ_СДЕЛКИ` tinyint(3) unsigned DEFAULT NULL COMMENT 'Количество комнат для любого вида сделки',
  `ПРИНАДЛЕЖНОСТЬ` enum('ЛИЧНАЯ','ДОЛЕВАЯ','ГОСУДАРСТВЕННАЯ','МУНИЦИПАЛЬНАЯ') DEFAULT 'ЛИЧНАЯ',
  `ДОЛЯ` float unsigned DEFAULT NULL COMMENT 'Комнат в собственности',
  `МАТЕРИАЛ` enum('ПАНЕЛЬНОЕ','МОНОЛИТНОЕ','БЛОЧНОЕ','КИРПИЧНОЕ','ДЕРЕВЯННОЕ','ЖЕЛЕЗОБЕТОННОЕ','МЕТАЛЛИЧЕСКОЕ') DEFAULT NULL COMMENT 'Основной материал недвижимости',
  `ЭТАЖЕЙ_ВСЕГО` tinyint(3) unsigned DEFAULT NULL COMMENT 'Общее количество этажей',
  `ЭТАЖ` tinyint(3) unsigned DEFAULT NULL COMMENT 'Этаж на котором находится недвижимость',
  `ФУНДАМЕНТ` enum('ЛЕНТОЧНЫЙ','СТОЛБЧАТЫЙ','ПЛИТНЫЙ','КОНТИНУАЛЬНЫЙ') DEFAULT NULL COMMENT 'Фундамент',
  `АДРЕС` char(60) DEFAULT NULL COMMENT 'Короткий адрес недвижимости',
  `ВЫСОТА_ПОТОЛКА` float unsigned DEFAULT NULL COMMENT 'Высота этажа \\ потолка',
  `ОТОПЛЕНИЕ` enum('ПЕЧНОЕ','ГАЗОВОЕ','ВОДЯНОЕ','ЭЛЕКТРИЧЕСКОЕ','ВОЗДУШНОЕ') DEFAULT NULL,
  `ЖИЗНЕННЫЙ_ЦЫКЛ` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`ИДЕНТИФИКАТОР`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `НЕДВИЖИМОСТЬ_ГОСТИНИЦА`
--

DROP TABLE IF EXISTS `НЕДВИЖИМОСТЬ_ГОСТИНИЦА`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `НЕДВИЖИМОСТЬ_ГОСТИНИЦА` (
  `ИДЕНТИФИКАТОР` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID этой недвижимости',
  `ИД_ПОЛЬЗОВАТЕЛЯ` int(10) unsigned DEFAULT NULL COMMENT 'ID пользователя кому пренадлежит эта недвижимость',
  `ИД_МЕСТА` int(10) unsigned DEFAULT NULL COMMENT 'ID места-адреса этой недвижимости',
  `ТЕКСТ` char(255) DEFAULT NULL COMMENT 'Описание этой недвижимости',
  `СДЕЛКА` enum('ПРОДАЖА','ПОКУПКА','ОБМЕН','ПРОДАЖА_АРЕНДЫ','ПОКУПКА_АРЕНДЫ') DEFAULT NULL COMMENT 'Тип сделки для этой недвижимости',
  `ДАТА_СОЗДАНИЯ` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'дата создания этого обьявления недвижимости',
  `ДАТА_ОБНОВЛЕНИЯ` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'дата обновления этого объявления недвижимости',
  `ЦЕНА` bigint(20) unsigned DEFAULT NULL COMMENT 'Цена этой недвижимости',
  `ВАЛЮТА` enum('₽','$','€','¥') DEFAULT '₽' COMMENT 'Валюта цены для этой недвижимости',
  `НОМЕР_КАДАСТРОВЫЙ` char(20) DEFAULT NULL COMMENT 'кадастровый номер этой недвижимости',
  `НОМЕР_ОБЪЯВЛЕНИЯ` int(10) unsigned DEFAULT NULL COMMENT 'порядковый номер этого объявления для того чтобы знать в какой папке лежат фотки',
  `ОТМЕЧЕННЫЕ_ПУНКТЫ` set('ПО_ДОГОВОРЕННОСТИ','ЕСТЬ_ДОКУМЕНТЫ','ЭЛЕКТРОННЫЕ_ДЕНЬГИ','ПРЕДОПЛАТА','БАНКОВСКАЯ_КАРТА','НАЛИЧКА','DEALTESTDRIVE','ЭЛЕКТРИЧЕСТВО','ОТОПЛЕНИЕ','ГОРЯЧАЯ_ВОДА','ХОЛОДНАЯ_ВОДА','ГАЗ','ВЕНТИЛЯЦИЯ','КАНАЛИЗАЦИЯ','ЛИФТ','ДОМОФОН','ИНТЕРНЕТ','ПОДЗЕМНЫЙ_ПАРКИНГ','ОТКРЫТАЯ_СТОЯНКА','МНОГОУРОВНЕВЫЙ_ПАРКИНГ','КРЫТАЯ_СТОЯНКА','ОХРАНЯЕМАЯ','ХОРОШАЯ_ТРАНСПОРТНАЯ_РАЗВЯЗКА') DEFAULT NULL COMMENT 'Различные чекбоксы для объявления недвижимости',
  `ПЛОЩАДЬ` float unsigned DEFAULT NULL COMMENT 'Общая площадь',
  `КОМНАТ_ВСЕГО` tinyint(3) unsigned DEFAULT NULL COMMENT 'Общее количество комнат',
  `КОМНАТ_ДЛЯ_СДЕЛКИ` tinyint(3) unsigned DEFAULT NULL COMMENT 'Количество комнат для любого вида сделки',
  `ДОЛЯ` float unsigned DEFAULT NULL COMMENT 'Комнат в собственности',
  `МАТЕРИАЛ` enum('ПАНЕЛЬНОЕ','МОНОЛИТНОЕ','БЛОЧНОЕ','КИРПИЧНОЕ','ДЕРЕВЯННОЕ','ЖЕЛЕЗОБЕТОННОЕ','МЕТАЛЛИЧЕСКОЕ') DEFAULT NULL COMMENT 'Основной материал недвижимости',
  `ЭТАЖЕЙ_ВСЕГО` tinyint(3) unsigned DEFAULT NULL COMMENT 'Общее количество этажей',
  `ЭТАЖ` tinyint(3) unsigned DEFAULT NULL COMMENT 'Этаж на котором находится недвижимость',
  `ФУНДАМЕНТ` enum('ЛЕНТОЧНЫЙ','СТОЛБЧАТЫЙ','ПЛИТНЫЙ','КОНТИНУАЛЬНЫЙ') DEFAULT NULL COMMENT 'Фундамент',
  `АДРЕС` char(60) DEFAULT NULL COMMENT 'Короткий адрес недвижимости',
  `ВЫСОТА_ПОТОЛКА` float unsigned DEFAULT NULL COMMENT 'Высота этажа \\ потолка',
  `ДОЛЕВАЯ_СОБСТВЕННОСТЬ` enum('ЛИЧНАЯ','ДОЛЕВАЯ') DEFAULT 'ЛИЧНАЯ',
  `ОТОПЛЕНИЕ` enum('ПЕЧНОЕ','ГАЗОВОЕ','ВОДЯНОЕ','ЭЛЕКТРИЧЕСКОЕ','ВОЗДУШНОЕ') DEFAULT NULL,
  PRIMARY KEY (`ИДЕНТИФИКАТОР`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `НЕДВИЖИМОСТЬ_ДОМ`
--

DROP TABLE IF EXISTS `НЕДВИЖИМОСТЬ_ДОМ`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `НЕДВИЖИМОСТЬ_ДОМ` (
  `ИДЕНТИФИКАТОР` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID этой недвижимости',
  `ИД_ПОЛЬЗОВАТЕЛЯ` int(10) unsigned DEFAULT NULL COMMENT 'ID пользователя кому пренадлежит эта недвижимость',
  `ИД_МЕСТА` int(10) unsigned DEFAULT NULL COMMENT 'ID места-адреса этой недвижимости',
  `ТЕКСТ` char(255) DEFAULT NULL COMMENT 'Описание этой недвижимости',
  `СДЕЛКА` enum('ПРОДАЖА','ПОКУПКА','ОБМЕН','ПРОДАЖА_АРЕНДЫ','ПОКУПКА_АРЕНДЫ') DEFAULT NULL COMMENT 'Тип сделки для этой недвижимости',
  `ДАТА_СОЗДАНИЯ` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'дата создания этого обьявления недвижимости',
  `ДАТА_ОБНОВЛЕНИЯ` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'дата обновления этого объявления недвижимости',
  `ЦЕНА` bigint(20) unsigned DEFAULT NULL COMMENT 'Цена этой недвижимости',
  `ВАЛЮТА` enum('₽','$','€','¥') DEFAULT '₽' COMMENT 'Валюта цены для этой недвижимости',
  `НОМЕР_КАДАСТРОВЫЙ` char(20) DEFAULT NULL COMMENT 'кадастровый номер этой недвижимости',
  `НОМЕР_ОБЪЯВЛЕНИЯ` int(10) unsigned DEFAULT NULL COMMENT 'порядковый номер этого объявления для того чтобы знать в какой папке лежат фотки',
  `ОТМЕЧЕННЫЕ_ПУНКТЫ` set('ПО_ДОГОВОРЕННОСТИ','ЕСТЬ_ДОКУМЕНТЫ','ЭЛЕКТРОННЫЕ_ДЕНЬГИ','ПРЕДОПЛАТА','БАНКОВСКАЯ_КАРТА','НАЛИЧКА','DEALTESTDRIVE','ЭЛЕКТРИЧЕСТВО','ОТОПЛЕНИЕ','ГОРЯЧАЯ_ВОДА','ХОЛОДНАЯ_ВОДА','ГАЗ','ВЕНТИЛЯЦИЯ','КАНАЛИЗАЦИЯ','ЛИФТ','ДОМОФОН','ИНТЕРНЕТ','ПОДЗЕМНЫЙ_ПАРКИНГ','ОТКРЫТАЯ_СТОЯНКА','МНОГОУРОВНЕВЫЙ_ПАРКИНГ','КРЫТАЯ_СТОЯНКА','ОХРАНЯЕМАЯ','ХОРОШАЯ_ТРАНСПОРТНАЯ_РАЗВЯЗКА') DEFAULT NULL COMMENT 'Различные чекбоксы для объявления недвижимости',
  `ПЛОЩАДЬ` float unsigned DEFAULT NULL COMMENT 'Общая площадь',
  `КОМНАТ_ВСЕГО` tinyint(3) unsigned DEFAULT NULL COMMENT 'Общее количество комнат',
  `КОМНАТ_ДЛЯ_СДЕЛКИ` tinyint(3) unsigned DEFAULT NULL COMMENT 'Количество комнат для любого вида сделки',
  `ДОЛЯ` float unsigned DEFAULT NULL COMMENT 'Комнат в собственности',
  `МАТЕРИАЛ` enum('ПАНЕЛЬНОЕ','МОНОЛИТНОЕ','БЛОЧНОЕ','КИРПИЧНОЕ','ДЕРЕВЯННОЕ','ЖЕЛЕЗОБЕТОННОЕ','МЕТАЛЛИЧЕСКОЕ') DEFAULT NULL COMMENT 'Основной материал недвижимости',
  `ЭТАЖЕЙ_ВСЕГО` tinyint(3) unsigned DEFAULT NULL COMMENT 'Общее количество этажей',
  `ЭТАЖ` tinyint(3) unsigned DEFAULT NULL COMMENT 'Этаж на котором находится недвижимость',
  `ФУНДАМЕНТ` enum('ЛЕНТОЧНЫЙ','СТОЛБЧАТЫЙ','ПЛИТНЫЙ','КОНТИНУАЛЬНЫЙ') DEFAULT NULL COMMENT 'Фундамент',
  `АДРЕС` char(60) DEFAULT NULL COMMENT 'Короткий адрес недвижимости',
  `ВЫСОТА_ПОТОЛКА` float unsigned DEFAULT NULL COMMENT 'Высота этажа \\ потолка',
  `ДОЛЕВАЯ_СОБСТВЕННОСТЬ` enum('ЛИЧНАЯ','ДОЛЕВАЯ') DEFAULT 'ЛИЧНАЯ',
  `ОТОПЛЕНИЕ` enum('ПЕЧНОЕ','ГАЗОВОЕ','ВОДЯНОЕ','ЭЛЕКТРИЧЕСКОЕ','ВОЗДУШНОЕ') DEFAULT NULL,
  PRIMARY KEY (`ИДЕНТИФИКАТОР`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `НЕДВИЖИМОСТЬ_ДРУГОЕ`
--

DROP TABLE IF EXISTS `НЕДВИЖИМОСТЬ_ДРУГОЕ`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `НЕДВИЖИМОСТЬ_ДРУГОЕ` (
  `ИДЕНТИФИКАТОР` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID этой недвижимости',
  `ИД_ПОЛЬЗОВАТЕЛЯ` int(10) unsigned DEFAULT NULL COMMENT 'ID пользователя кому пренадлежит эта недвижимость',
  `ИД_МЕСТА` int(10) unsigned DEFAULT NULL COMMENT 'ID места-адреса этой недвижимости',
  `ТЕКСТ` char(255) DEFAULT NULL COMMENT 'Описание этой недвижимости',
  `СДЕЛКА` enum('ПРОДАЖА','ПОКУПКА','ОБМЕН','ПРОДАЖА_АРЕНДЫ','ПОКУПКА_АРЕНДЫ') DEFAULT NULL COMMENT 'Тип сделки для этой недвижимости',
  `ДАТА_СОЗДАНИЯ` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'дата создания этого обьявления недвижимости',
  `ДАТА_ОБНОВЛЕНИЯ` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'дата обновления этого объявления недвижимости',
  `ЦЕНА` bigint(20) unsigned DEFAULT NULL COMMENT 'Цена этой недвижимости',
  `ВАЛЮТА` enum('₽','$','€','¥') DEFAULT '₽' COMMENT 'Валюта цены для этой недвижимости',
  `НОМЕР_КАДАСТРОВЫЙ` char(20) DEFAULT NULL COMMENT 'кадастровый номер этой недвижимости',
  `НОМЕР_ОБЪЯВЛЕНИЯ` int(10) unsigned DEFAULT NULL COMMENT 'порядковый номер этого объявления для того чтобы знать в какой папке лежат фотки',
  `ОТМЕЧЕННЫЕ_ПУНКТЫ` set('ПО_ДОГОВОРЕННОСТИ','ЕСТЬ_ДОКУМЕНТЫ','ЭЛЕКТРОННЫЕ_ДЕНЬГИ','ПРЕДОПЛАТА','БАНКОВСКАЯ_КАРТА','НАЛИЧКА','DEALTESTDRIVE','ЭЛЕКТРИЧЕСТВО','ОТОПЛЕНИЕ','ГОРЯЧАЯ_ВОДА','ХОЛОДНАЯ_ВОДА','ГАЗ','ВЕНТИЛЯЦИЯ','КАНАЛИЗАЦИЯ','ЛИФТ','ДОМОФОН','ИНТЕРНЕТ','ПОДЗЕМНЫЙ_ПАРКИНГ','ОТКРЫТАЯ_СТОЯНКА','МНОГОУРОВНЕВЫЙ_ПАРКИНГ','КРЫТАЯ_СТОЯНКА','ОХРАНЯЕМАЯ','ХОРОШАЯ_ТРАНСПОРТНАЯ_РАЗВЯЗКА') DEFAULT NULL COMMENT 'Различные чекбоксы для объявления недвижимости',
  `ПЛОЩАДЬ` float unsigned DEFAULT NULL COMMENT 'Общая площадь',
  `КОМНАТ_ВСЕГО` tinyint(3) unsigned DEFAULT NULL COMMENT 'Общее количество комнат',
  `КОМНАТ_ДЛЯ_СДЕЛКИ` tinyint(3) unsigned DEFAULT NULL COMMENT 'Количество комнат для любого вида сделки',
  `ДОЛЯ` float unsigned DEFAULT NULL COMMENT 'Комнат в собственности',
  `МАТЕРИАЛ` enum('ПАНЕЛЬНОЕ','МОНОЛИТНОЕ','БЛОЧНОЕ','КИРПИЧНОЕ','ДЕРЕВЯННОЕ','ЖЕЛЕЗОБЕТОННОЕ','МЕТАЛЛИЧЕСКОЕ') DEFAULT NULL COMMENT 'Основной материал недвижимости',
  `ЭТАЖЕЙ_ВСЕГО` tinyint(3) unsigned DEFAULT NULL COMMENT 'Общее количество этажей',
  `ЭТАЖ` tinyint(3) unsigned DEFAULT NULL COMMENT 'Этаж на котором находится недвижимость',
  `ФУНДАМЕНТ` enum('ЛЕНТОЧНЫЙ','СТОЛБЧАТЫЙ','ПЛИТНЫЙ','КОНТИНУАЛЬНЫЙ') DEFAULT NULL COMMENT 'Фундамент',
  `АДРЕС` char(60) DEFAULT NULL COMMENT 'Короткий адрес недвижимости',
  `ВЫСОТА_ПОТОЛКА` float unsigned DEFAULT NULL COMMENT 'Высота этажа \\ потолка',
  `ДОЛЕВАЯ_СОБСТВЕННОСТЬ` enum('ЛИЧНАЯ','ДОЛЕВАЯ') DEFAULT 'ЛИЧНАЯ',
  `ОТОПЛЕНИЕ` enum('ПЕЧНОЕ','ГАЗОВОЕ','ВОДЯНОЕ','ЭЛЕКТРИЧЕСКОЕ','ВОЗДУШНОЕ') DEFAULT NULL,
  PRIMARY KEY (`ИДЕНТИФИКАТОР`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `НЕДВИЖИМОСТЬ_КВАРТИРА`
--

DROP TABLE IF EXISTS `НЕДВИЖИМОСТЬ_КВАРТИРА`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `НЕДВИЖИМОСТЬ_КВАРТИРА` (
  `ИДЕНТИФИКАТОР` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID этой недвижимости',
  `ИД_ПОЛЬЗОВАТЕЛЯ` int(10) unsigned DEFAULT NULL COMMENT 'ID пользователя кому пренадлежит эта недвижимость',
  `ИД_МЕСТА` int(10) unsigned DEFAULT NULL COMMENT 'ID места-адреса этой недвижимости',
  `ТЕКСТ` char(255) DEFAULT NULL COMMENT 'Описание этой недвижимости',
  `СДЕЛКА` enum('ПРОДАЖА','ПОКУПКА','ОБМЕН','ПРОДАЖА_АРЕНДЫ','ПОКУПКА_АРЕНДЫ') DEFAULT NULL COMMENT 'Тип сделки для этой недвижимости',
  `ДАТА_СОЗДАНИЯ` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'дата создания этого обьявления недвижимости',
  `ДАТА_ОБНОВЛЕНИЯ` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'дата обновления этого объявления недвижимости',
  `ЦЕНА` bigint(20) unsigned DEFAULT NULL COMMENT 'Цена этой недвижимости',
  `ВАЛЮТА` enum('₽','$','€','¥') DEFAULT '₽' COMMENT 'Валюта цены для этой недвижимости',
  `НОМЕР_КАДАСТРОВЫЙ` char(20) DEFAULT NULL COMMENT 'кадастровый номер этой недвижимости',
  `НОМЕР_ОБЪЯВЛЕНИЯ` int(10) unsigned DEFAULT NULL COMMENT 'порядковый номер этого объявления для того чтобы знать в какой папке лежат фотки',
  `ОТМЕЧЕННЫЕ_ПУНКТЫ` set('ПО_ДОГОВОРЕННОСТИ','ЕСТЬ_ДОКУМЕНТЫ','ЭЛЕКТРОННЫЕ_ДЕНЬГИ','ПРЕДОПЛАТА','БАНКОВСКАЯ_КАРТА','НАЛИЧКА','DEALTESTDRIVE','ЭЛЕКТРИЧЕСТВО','ОТОПЛЕНИЕ','ГОРЯЧАЯ_ВОДА','ХОЛОДНАЯ_ВОДА','ГАЗ','ВЕНТИЛЯЦИЯ','КАНАЛИЗАЦИЯ','ЛИФТ','ДОМОФОН','ИНТЕРНЕТ','ПОДЗЕМНЫЙ_ПАРКИНГ','ОТКРЫТАЯ_СТОЯНКА','МНОГОУРОВНЕВЫЙ_ПАРКИНГ','КРЫТАЯ_СТОЯНКА','ОХРАНЯЕМАЯ','ХОРОШАЯ_ТРАНСПОРТНАЯ_РАЗВЯЗКА') DEFAULT NULL COMMENT 'Различные чекбоксы для объявления недвижимости',
  `ПЛОЩАДЬ` float unsigned DEFAULT NULL COMMENT 'Общая площадь',
  `КОМНАТ_ВСЕГО` tinyint(3) unsigned DEFAULT NULL COMMENT 'Общее количество комнат',
  `КОМНАТ_ДЛЯ_СДЕЛКИ` tinyint(3) unsigned DEFAULT NULL COMMENT 'Количество комнат для любого вида сделки',
  `ДОЛЯ` float unsigned DEFAULT NULL COMMENT 'Комнат в собственности',
  `МАТЕРИАЛ` enum('ПАНЕЛЬНОЕ','МОНОЛИТНОЕ','БЛОЧНОЕ','КИРПИЧНОЕ','ДЕРЕВЯННОЕ','ЖЕЛЕЗОБЕТОННОЕ','МЕТАЛЛИЧЕСКОЕ') DEFAULT NULL COMMENT 'Основной материал недвижимости',
  `ЭТАЖЕЙ_ВСЕГО` tinyint(3) unsigned DEFAULT NULL COMMENT 'Общее количество этажей',
  `ЭТАЖ` tinyint(3) unsigned DEFAULT NULL COMMENT 'Этаж на котором находится недвижимость',
  `ФУНДАМЕНТ` enum('ЛЕНТОЧНЫЙ','СТОЛБЧАТЫЙ','ПЛИТНЫЙ','КОНТИНУАЛЬНЫЙ') DEFAULT NULL COMMENT 'Фундамент',
  `АДРЕС` char(60) DEFAULT NULL COMMENT 'Короткий адрес недвижимости',
  `ВЫСОТА_ПОТОЛКА` float unsigned DEFAULT NULL COMMENT 'Высота этажа \\ потолка',
  `ДОЛЕВАЯ_СОБСТВЕННОСТЬ` enum('ЛИЧНАЯ','ДОЛЕВАЯ') DEFAULT 'ЛИЧНАЯ',
  `ОТОПЛЕНИЕ` enum('ПЕЧНОЕ','ГАЗОВОЕ','ВОДЯНОЕ','ЭЛЕКТРИЧЕСКОЕ','ВОЗДУШНОЕ') DEFAULT NULL,
  PRIMARY KEY (`ИДЕНТИФИКАТОР`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `НЕДВИЖИМОСТЬ_МАШИНОМЕСТО`
--

DROP TABLE IF EXISTS `НЕДВИЖИМОСТЬ_МАШИНОМЕСТО`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `НЕДВИЖИМОСТЬ_МАШИНОМЕСТО` (
  `ИДЕНТИФИКАТОР` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID этой недвижимости',
  `ИД_ПОЛЬЗОВАТЕЛЯ` int(10) unsigned DEFAULT NULL COMMENT 'ID пользователя кому пренадлежит эта недвижимость',
  `ИД_МЕСТА` int(10) unsigned DEFAULT NULL COMMENT 'ID места-адреса этой недвижимости',
  `ТЕКСТ` char(255) DEFAULT NULL COMMENT 'Описание этой недвижимости',
  `СДЕЛКА` enum('ПРОДАЖА','ПОКУПКА','ОБМЕН','ПРОДАЖА_АРЕНДЫ','ПОКУПКА_АРЕНДЫ') DEFAULT NULL COMMENT 'Тип сделки для этой недвижимости',
  `ДАТА_СОЗДАНИЯ` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'дата создания этого обьявления недвижимости',
  `ДАТА_ОБНОВЛЕНИЯ` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'дата обновления этого объявления недвижимости',
  `ЦЕНА` bigint(20) unsigned DEFAULT NULL COMMENT 'Цена этой недвижимости',
  `ВАЛЮТА` enum('₽','$','€','¥') DEFAULT '₽' COMMENT 'Валюта цены для этой недвижимости',
  `НОМЕР_КАДАСТРОВЫЙ` char(20) DEFAULT NULL COMMENT 'кадастровый номер этой недвижимости',
  `НОМЕР_ОБЪЯВЛЕНИЯ` int(10) unsigned DEFAULT NULL COMMENT 'порядковый номер этого объявления для того чтобы знать в какой папке лежат фотки',
  `ОТМЕЧЕННЫЕ_ПУНКТЫ` set('ПО_ДОГОВОРЕННОСТИ','ЕСТЬ_ДОКУМЕНТЫ','ЭЛЕКТРОННЫЕ_ДЕНЬГИ','ПРЕДОПЛАТА','БАНКОВСКАЯ_КАРТА','НАЛИЧКА','DEALTESTDRIVE','ЭЛЕКТРИЧЕСТВО','ОТОПЛЕНИЕ','ГОРЯЧАЯ_ВОДА','ХОЛОДНАЯ_ВОДА','ГАЗ','ВЕНТИЛЯЦИЯ','КАНАЛИЗАЦИЯ','ЛИФТ','ДОМОФОН','ИНТЕРНЕТ','ПОДЗЕМНЫЙ_ПАРКИНГ','ОТКРЫТАЯ_СТОЯНКА','МНОГОУРОВНЕВЫЙ_ПАРКИНГ','КРЫТАЯ_СТОЯНКА','ОХРАНЯЕМАЯ','ХОРОШАЯ_ТРАНСПОРТНАЯ_РАЗВЯЗКА') DEFAULT NULL COMMENT 'Различные чекбоксы для объявления недвижимости',
  `ПЛОЩАДЬ` float unsigned DEFAULT NULL COMMENT 'Общая площадь',
  `КОМНАТ_ВСЕГО` tinyint(3) unsigned DEFAULT NULL COMMENT 'Общее количество комнат',
  `КОМНАТ_ДЛЯ_СДЕЛКИ` tinyint(3) unsigned DEFAULT NULL COMMENT 'Количество комнат для любого вида сделки',
  `ДОЛЯ` float unsigned DEFAULT NULL COMMENT 'Комнат в собственности',
  `МАТЕРИАЛ` enum('ПАНЕЛЬНОЕ','МОНОЛИТНОЕ','БЛОЧНОЕ','КИРПИЧНОЕ','ДЕРЕВЯННОЕ','ЖЕЛЕЗОБЕТОННОЕ','МЕТАЛЛИЧЕСКОЕ') DEFAULT NULL COMMENT 'Основной материал недвижимости',
  `ЭТАЖЕЙ_ВСЕГО` tinyint(3) unsigned DEFAULT NULL COMMENT 'Общее количество этажей',
  `ЭТАЖ` tinyint(3) unsigned DEFAULT NULL COMMENT 'Этаж на котором находится недвижимость',
  `ФУНДАМЕНТ` enum('ЛЕНТОЧНЫЙ','СТОЛБЧАТЫЙ','ПЛИТНЫЙ','КОНТИНУАЛЬНЫЙ') DEFAULT NULL COMMENT 'Фундамент',
  `АДРЕС` char(60) DEFAULT NULL COMMENT 'Короткий адрес недвижимости',
  `ВЫСОТА_ПОТОЛКА` float unsigned DEFAULT NULL COMMENT 'Высота этажа \\ потолка',
  `ДОЛЕВАЯ_СОБСТВЕННОСТЬ` enum('ЛИЧНАЯ','ДОЛЕВАЯ') DEFAULT 'ЛИЧНАЯ',
  `ОТОПЛЕНИЕ` enum('ПЕЧНОЕ','ГАЗОВОЕ','ВОДЯНОЕ','ЭЛЕКТРИЧЕСКОЕ','ВОЗДУШНОЕ') DEFAULT NULL,
  PRIMARY KEY (`ИДЕНТИФИКАТОР`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `НЕДВИЖИМОСТЬ_ПОМЕЩЕНИЕ`
--

DROP TABLE IF EXISTS `НЕДВИЖИМОСТЬ_ПОМЕЩЕНИЕ`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `НЕДВИЖИМОСТЬ_ПОМЕЩЕНИЕ` (
  `ИДЕНТИФИКАТОР` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID этой недвижимости',
  `ИД_ПОЛЬЗОВАТЕЛЯ` int(10) unsigned DEFAULT NULL COMMENT 'ID пользователя кому пренадлежит эта недвижимость',
  `ИД_МЕСТА` int(10) unsigned DEFAULT NULL COMMENT 'ID места-адреса этой недвижимости',
  `ТЕКСТ` char(255) DEFAULT NULL COMMENT 'Описание этой недвижимости',
  `СДЕЛКА` enum('ПРОДАЖА','ПОКУПКА','ОБМЕН','ПРОДАЖА_АРЕНДЫ','ПОКУПКА_АРЕНДЫ') DEFAULT NULL COMMENT 'Тип сделки для этой недвижимости',
  `ДАТА_СОЗДАНИЯ` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'дата создания этого обьявления недвижимости',
  `ДАТА_ОБНОВЛЕНИЯ` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'дата обновления этого объявления недвижимости',
  `ЦЕНА` bigint(20) unsigned DEFAULT NULL COMMENT 'Цена этой недвижимости',
  `ВАЛЮТА` enum('₽','$','€','¥') DEFAULT '₽' COMMENT 'Валюта цены для этой недвижимости',
  `НОМЕР_КАДАСТРОВЫЙ` char(20) DEFAULT NULL COMMENT 'кадастровый номер этой недвижимости',
  `НОМЕР_ОБЪЯВЛЕНИЯ` int(10) unsigned DEFAULT NULL COMMENT 'порядковый номер этого объявления для того чтобы знать в какой папке лежат фотки',
  `ОТМЕЧЕННЫЕ_ПУНКТЫ` set('ПО_ДОГОВОРЕННОСТИ','ЕСТЬ_ДОКУМЕНТЫ','ЭЛЕКТРОННЫЕ_ДЕНЬГИ','ПРЕДОПЛАТА','БАНКОВСКАЯ_КАРТА','НАЛИЧКА','DEALTESTDRIVE','ЭЛЕКТРИЧЕСТВО','ОТОПЛЕНИЕ','ГОРЯЧАЯ_ВОДА','ХОЛОДНАЯ_ВОДА','ГАЗ','ВЕНТИЛЯЦИЯ','КАНАЛИЗАЦИЯ','ЛИФТ','ДОМОФОН','ИНТЕРНЕТ','ПОДЗЕМНЫЙ_ПАРКИНГ','ОТКРЫТАЯ_СТОЯНКА','МНОГОУРОВНЕВЫЙ_ПАРКИНГ','КРЫТАЯ_СТОЯНКА','ОХРАНЯЕМАЯ','ХОРОШАЯ_ТРАНСПОРТНАЯ_РАЗВЯЗКА') DEFAULT NULL COMMENT 'Различные чекбоксы для объявления недвижимости',
  `ПЛОЩАДЬ` float unsigned DEFAULT NULL COMMENT 'Общая площадь',
  `КОМНАТ_ВСЕГО` tinyint(3) unsigned DEFAULT NULL COMMENT 'Общее количество комнат',
  `КОМНАТ_ДЛЯ_СДЕЛКИ` tinyint(3) unsigned DEFAULT NULL COMMENT 'Количество комнат для любого вида сделки',
  `ДОЛЯ` float unsigned DEFAULT NULL COMMENT 'Комнат в собственности',
  `МАТЕРИАЛ` enum('ПАНЕЛЬНОЕ','МОНОЛИТНОЕ','БЛОЧНОЕ','КИРПИЧНОЕ','ДЕРЕВЯННОЕ','ЖЕЛЕЗОБЕТОННОЕ','МЕТАЛЛИЧЕСКОЕ') DEFAULT NULL COMMENT 'Основной материал недвижимости',
  `ЭТАЖЕЙ_ВСЕГО` tinyint(3) unsigned DEFAULT NULL COMMENT 'Общее количество этажей',
  `ЭТАЖ` tinyint(3) unsigned DEFAULT NULL COMMENT 'Этаж на котором находится недвижимость',
  `ФУНДАМЕНТ` enum('ЛЕНТОЧНЫЙ','СТОЛБЧАТЫЙ','ПЛИТНЫЙ','КОНТИНУАЛЬНЫЙ') DEFAULT NULL COMMENT 'Фундамент',
  `АДРЕС` char(60) DEFAULT NULL COMMENT 'Короткий адрес недвижимости',
  `ВЫСОТА_ПОТОЛКА` float unsigned DEFAULT NULL COMMENT 'Высота этажа \\ потолка',
  `ДОЛЕВАЯ_СОБСТВЕННОСТЬ` enum('ЛИЧНАЯ','ДОЛЕВАЯ') DEFAULT 'ЛИЧНАЯ',
  `ОТОПЛЕНИЕ` enum('ПЕЧНОЕ','ГАЗОВОЕ','ВОДЯНОЕ','ЭЛЕКТРИЧЕСКОЕ','ВОЗДУШНОЕ') DEFAULT NULL,
  PRIMARY KEY (`ИДЕНТИФИКАТОР`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `НЕДВИЖИМОСТЬ_ПРИРОДНАЯ`
--

DROP TABLE IF EXISTS `НЕДВИЖИМОСТЬ_ПРИРОДНАЯ`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `НЕДВИЖИМОСТЬ_ПРИРОДНАЯ` (
  `ИДЕНТИФИКАТОР` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID этой недвижимости',
  `ИД_ПОЛЬЗОВАТЕЛЯ` int(10) unsigned DEFAULT NULL COMMENT 'ID пользователя кому пренадлежит эта недвижимость',
  `ИД_МЕСТА` int(10) unsigned DEFAULT NULL COMMENT 'ID места-адреса этой недвижимости',
  `ТЕКСТ` char(255) DEFAULT NULL COMMENT 'Описание этой недвижимости',
  `СДЕЛКА` enum('ПРОДАЖА','ПОКУПКА','ОБМЕН','ПРОДАЖА_АРЕНДЫ','ПОКУПКА_АРЕНДЫ') DEFAULT NULL COMMENT 'Тип сделки для этой недвижимости',
  `ДАТА_СОЗДАНИЯ` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'дата создания этого обьявления недвижимости',
  `ДАТА_ОБНОВЛЕНИЯ` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'дата обновления этого объявления недвижимости',
  `ЦЕНА` bigint(20) unsigned DEFAULT NULL COMMENT 'Цена этой недвижимости',
  `ВАЛЮТА` enum('₽','$','€','¥') DEFAULT '₽' COMMENT 'Валюта цены для этой недвижимости',
  `НОМЕР_КАДАСТРОВЫЙ` char(20) DEFAULT NULL COMMENT 'кадастровый номер этой недвижимости',
  `НОМЕР_ОБЪЯВЛЕНИЯ` int(10) unsigned DEFAULT NULL COMMENT 'порядковый номер этого объявления для того чтобы знать в какой папке лежат фотки',
  `ОТМЕЧЕННЫЕ_ПУНКТЫ` set('ПО_ДОГОВОРЕННОСТИ','ЕСТЬ_ДОКУМЕНТЫ','ЭЛЕКТРОННЫЕ_ДЕНЬГИ','ПРЕДОПЛАТА','БАНКОВСКАЯ_КАРТА','НАЛИЧКА','DEALTESTDRIVE','ЭЛЕКТРИЧЕСТВО','ОТОПЛЕНИЕ','ГОРЯЧАЯ_ВОДА','ХОЛОДНАЯ_ВОДА','ГАЗ','ВЕНТИЛЯЦИЯ','КАНАЛИЗАЦИЯ','ЛИФТ','ДОМОФОН','ИНТЕРНЕТ','ПОДЗЕМНЫЙ_ПАРКИНГ','ОТКРЫТАЯ_СТОЯНКА','МНОГОУРОВНЕВЫЙ_ПАРКИНГ','КРЫТАЯ_СТОЯНКА','ОХРАНЯЕМАЯ','ХОРОШАЯ_ТРАНСПОРТНАЯ_РАЗВЯЗКА') DEFAULT NULL COMMENT 'Различные чекбоксы для объявления недвижимости',
  `ПЛОЩАДЬ` float unsigned DEFAULT NULL COMMENT 'Общая площадь',
  `ДОЛЕВАЯ_СОБСТВЕННОСТЬ` enum('ЛИЧНАЯ','ДОЛЕВАЯ') DEFAULT 'ЛИЧНАЯ',
  `ДОЛЯ` float unsigned DEFAULT NULL COMMENT 'Комнат в собственности',
  `АДРЕС` char(60) DEFAULT NULL COMMENT 'Короткий адрес недвижимости',
  `ПРИРОДА` enum('ЗЕМЕЛЬНЫЙ_УЧАСТОК','ВОДНЫЙ_ОБЪЕКТ','ЛЕС','МНОГОЛЕТНИЕ_НАСАЖДЕНИЯ','УЧАСТОК_НЕДР') DEFAULT NULL,
  PRIMARY KEY (`ИДЕНТИФИКАТОР`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping events for database 'НЕДВИЖИМОСТЬ_СОЛНЕЧНОЙ_СИСТЕМЫ'
--

--
-- Dumping routines for database 'НЕДВИЖИМОСТЬ_СОЛНЕЧНОЙ_СИСТЕМЫ'
--

--
-- Current Database: `realestate`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `realestate` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `realestate`;

--
-- Table structure for table `НЕДВИЖИМОСТЬ`
--

DROP TABLE IF EXISTS `НЕДВИЖИМОСТЬ`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `НЕДВИЖИМОСТЬ` (
  `ИДЕНТИФИКАТОР` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID этой недвижимости',
  `ИД_ПОЛЬЗОВАТЕЛЯ` int(10) unsigned DEFAULT NULL COMMENT 'ID пользователя кому пренадлежит эта недвижимость',
  `ИД_МЕСТА` int(10) unsigned DEFAULT NULL COMMENT 'ID места-адреса этой недвижимости',
  `ТЕКСТ` char(255) DEFAULT NULL COMMENT 'Описание этой недвижимости',
  `СДЕЛКА` enum('ПРОДАЖА','ПОКУПКА','ОБМЕН','ПРОДАЖА_АРЕНДЫ','ПОКУПКА_АРЕНДЫ') DEFAULT NULL COMMENT 'Тип сделки для этой недвижимости',
  `ДАТА_СОЗДАНИЯ` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'дата создания этого обьявления недвижимости',
  `ДАТА_ОБНОВЛЕНИЯ` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'дата обновления этого объявления недвижимости',
  `ЦЕНА` bigint(20) unsigned DEFAULT NULL COMMENT 'Цена этой недвижимости',
  `ВАЛЮТА` enum('₽','$','€','¥') DEFAULT '₽' COMMENT 'Валюта цены для этой недвижимости',
  `НОМЕР_КАДАСТРОВЫЙ` char(20) DEFAULT NULL COMMENT 'кадастровый номер этой недвижимости',
  `НОМЕР_ОБЪЯВЛЕНИЯ` int(10) unsigned DEFAULT NULL COMMENT 'порядковый номер этого объявления для того чтобы знать в какой папке лежат фотки',
  `ОТМЕЧЕННЫЕ_ПУНКТЫ` set('ПО_ДОГОВОРЕННОСТИ','ЕСТЬ_ДОКУМЕНТЫ','ЭЛЕКТРОННЫЕ_ДЕНЬГИ','ПРЕДОПЛАТА','БАНКОВСКАЯ_КАРТА','НАЛИЧКА','DEALTESTDRIVE','ЭЛЕКТРИЧЕСТВО','ОТОПЛЕНИЕ','ГОРЯЧАЯ_ВОДА','ХОЛОДНАЯ_ВОДА','ГАЗ','ВЕНТИЛЯЦИЯ','КАНАЛИЗАЦИЯ','ЛИФТ','ДОМОФОН','ИНТЕРНЕТ','ПОДЗЕМНЫЙ_ПАРКИНГ','ОТКРЫТАЯ_СТОЯНКА','МНОГОУРОВНЕВЫЙ_ПАРКИНГ','КРЫТАЯ_СТОЯНКА','ОХРАНЯЕМАЯ','ХОРОШАЯ_ТРАНСПОРТНАЯ_РАЗВЯЗКА') DEFAULT NULL COMMENT 'Различные чекбоксы для объявления недвижимости',
  `ПЛОЩАДЬ` float unsigned DEFAULT NULL COMMENT 'Общая площадь',
  `КОМНАТ_ВСЕГО` tinyint(3) unsigned DEFAULT NULL COMMENT 'Общее количество комнат',
  `КОМНАТ_ДЛЯ_СДЕЛКИ` tinyint(3) unsigned DEFAULT NULL COMMENT 'Количество комнат для любого вида сделки',
  `ДОЛЯ` float unsigned DEFAULT NULL COMMENT 'Комнат в собственности',
  `МАТЕРИАЛ` enum('ПАНЕЛЬНОЕ','МОНОЛИТНОЕ','БЛОЧНОЕ','КИРПИЧНОЕ','ДЕРЕВЯННОЕ','ЖЕЛЕЗОБЕТОННОЕ','МЕТАЛЛИЧЕСКОЕ') DEFAULT NULL COMMENT 'Основной материал недвижимости',
  `ЭТАЖЕЙ_ВСЕГО` tinyint(3) unsigned DEFAULT NULL COMMENT 'Общее количество этажей',
  `ЭТАЖ` tinyint(3) unsigned DEFAULT NULL COMMENT 'Этаж на котором находится недвижимость',
  `ФУНДАМЕНТ` enum('ЛЕНТОЧНЫЙ','СТОЛБЧАТЫЙ','ПЛИТНЫЙ','КОНТИНУАЛЬНЫЙ') DEFAULT NULL COMMENT 'Фундамент',
  `АДРЕС` char(60) DEFAULT NULL COMMENT 'Короткий адрес недвижимости',
  `ВЫСОТА_ПОТОЛКА` float unsigned DEFAULT NULL COMMENT 'Высота этажа \\ потолка',
  `ДОЛЕВАЯ_СОБСТВЕННОСТЬ` enum('ЛИЧНАЯ','ДОЛЕВАЯ') DEFAULT 'ЛИЧНАЯ',
  `ОТОПЛЕНИЕ` enum('ПЕЧНОЕ','ГАЗОВОЕ','ВОДЯНОЕ','ЭЛЕКТРИЧЕСКОЕ','ВОЗДУШНОЕ') DEFAULT NULL,
  PRIMARY KEY (`ИДЕНТИФИКАТОР`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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
  PRIMARY KEY (`IDADDRESSCOMPONENT`),
  KEY `index2` (`long_name`)
) ENGINE=InnoDB AUTO_INCREMENT=97 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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
  `ROOMS_QUANTITY` tinyint(3) unsigned DEFAULT NULL COMMENT 'Общее количество комнат',
  `ROOMS_OWNED` tinyint(3) unsigned DEFAULT NULL COMMENT 'Комнат в собственности',
  `TYPE_HOUSE` enum('ПАНЕЛЬНОЕ','МОНОЛИТНОЕ','БЛОЧНОЕ','КИРПИЧНОЕ','ДЕРЕВЯННОЕ') DEFAULT NULL COMMENT 'Основной материал недвижимости',
  `FLOOR_QUANTITY` tinyint(3) unsigned DEFAULT NULL COMMENT 'Общее количество этажей',
  `FLOOR` tinyint(3) unsigned DEFAULT NULL COMMENT 'Этаж на котором находится недвижимость',
  `FOUNDATION` enum('ЛЕНТОЧНЫЙ','СТОЛБЧАТЫЙ','ПЛИТНЫЙ','КОНТИНУАЛЬНЫЙ') DEFAULT NULL COMMENT 'Фундамент',
  `TYPE` enum('КВАРТИРА','ДОМ','ГАРАЖ','МАШИНОМЕСТО','ГОСТИНИЦА','ДРУГОЕ','ЗЕМЕЛЬНЫЙ_УЧАСТОК','ПОМЕЩЕНИЕ_ОФИСНОЕ','ПОМЕЩЕНИЕ_ТОРГОВОЕ','ПОМЕЩЕНИЕ_СКЛАДСКОЕ','ПОМЕЩЕНИЕ_СВОБОДНОГОНАЗНАЧЕНИЯ','ПОМЕЩЕНИЕ_САЛОНКРАСОТЫ','ПОМЕЩЕНИЕ_ПРОИЗВОДСТВЕННОГОНАЗНАЧЕНИЯ','ПОМЕЩЕНИЕ_ОБЩЕСТВЕННОГОПИТАНИЯ') DEFAULT NULL COMMENT 'Тип недвижимости',
  `ADDRESS` char(60) DEFAULT NULL COMMENT 'Короткий адрес недвижимости',
  `IS_PART` enum('ДА','НЕТ') DEFAULT NULL COMMENT 'Флаг - только часть недвижимости в собственности',
  PRIMARY KEY (`IDREALESTATE`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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
  `HOUSEHEATING` enum('ПЕЧНОЕ','ГАЗОВОЕ','ВОДЯНОЕ','ЭЛЕКТРИЧЕСКОЕ','ВОЗДУШНОЕ') DEFAULT NULL COMMENT '1 Печное\n2 Газовое\n3 Водяное\n4 Электрическое\n5 Воздушное',
  `HOUSEHOMETOP` enum('МАНСАРДА','ЧЕРДАК') DEFAULT NULL COMMENT '0 Мансарда\n1 Чердак',
  `HOUSECEILINGHEIGHT` float unsigned DEFAULT NULL COMMENT 'Высота потолков',
  `HOUSEFOUNDATION` enum('ЛЕНТОЧНЫЙ','СТОЛБЧАТЫЙ','ПЛИТНЫЙ','КОНТИНУАЛЬНЫЙ') DEFAULT NULL COMMENT 'Фундамент',
  `CHECKBOXES` set('HOUSEPLAYGROUND','HOUSEINTERCOM','HOUSEQUIETNEIGHBORS','HOUSECELLAR','HOUSEBASEMENT') DEFAULT NULL COMMENT 'Детская площадка - ''HOUSEPLAYGROUND''\nЕсть домофон - ''HOUSEINTERCOM''\nНе шумные соседи - ''HOUSEQUIETNEIGHBORS''\nПогреб - ''HOUSECELLAR''\nПодвал - ''HOUSEBASEMENT''',
  PRIMARY KEY (`IDREALESTATE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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
-- Dumping events for database 'realestate'
--

--
-- Dumping routines for database 'realestate'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-01-05 18:48:50
