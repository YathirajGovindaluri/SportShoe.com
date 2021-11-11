/*
SQLyog Community v9.30 
MySQL - 5.6.25-log : Database - sportstore
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`sportstore` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `sportstore`;

/*Table structure for table `s_bookproduct` */

DROP TABLE IF EXISTS `s_bookproduct`;

CREATE TABLE `s_bookproduct` (
  `ID` bigint(20) NOT NULL,
  `productId` bigint(20) DEFAULT NULL,
  `productName` varchar(225) DEFAULT NULL,
  `name` varchar(225) DEFAULT NULL,
  `emailId` varchar(225) DEFAULT NULL,
  `mobileNo` varchar(225) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `pinCode` varchar(225) DEFAULT NULL,
  `landMark` varchar(225) DEFAULT NULL,
  `address` varchar(225) DEFAULT NULL,
  `quantity` bigint(20) DEFAULT NULL,
  `price` bigint(20) DEFAULT NULL,
  `finalPrice` bigint(20) DEFAULT NULL,
  `createdBy` varchar(225) DEFAULT NULL,
  `modifiedBy` varchar(225) DEFAULT NULL,
  `createdDatetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `modifiedDatetime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `s_bookproduct` */

insert  into `s_bookproduct`(`ID`,`productId`,`productName`,`name`,`emailId`,`mobileNo`,`date`,`pinCode`,`landMark`,`address`,`quantity`,`price`,`finalPrice`,`createdBy`,`modifiedBy`,`createdDatetime`,`modifiedDatetime`) values (1,1,'Addidas','Demo Demo','Demo@gmail.com','8585859685','2020-05-15','8585','dcwc','ververv',1,1000,1000,'Demo@gmail.com','Demo@gmail.com','2020-05-15 20:04:59','2020-05-15 20:04:59');

/*Table structure for table `s_cart` */

DROP TABLE IF EXISTS `s_cart`;

CREATE TABLE `s_cart` (
  `ID` bigint(20) NOT NULL,
  `userId` bigint(20) DEFAULT NULL,
  `productId` bigint(20) DEFAULT NULL,
  `createdBy` varchar(225) DEFAULT NULL,
  `modifiedBy` varchar(225) DEFAULT NULL,
  `createdDatetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `modifiedDatetime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`ID`),
  KEY `FK_s_cart` (`productId`),
  CONSTRAINT `FK_s_cart` FOREIGN KEY (`productId`) REFERENCES `s_product` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `s_cart` */

insert  into `s_cart`(`ID`,`userId`,`productId`,`createdBy`,`modifiedBy`,`createdDatetime`,`modifiedDatetime`) values (2,2,1,NULL,NULL,'2020-05-15 19:56:44','2020-05-15 19:56:44');

/*Table structure for table `s_category` */

DROP TABLE IF EXISTS `s_category`;

CREATE TABLE `s_category` (
  `ID` bigint(20) NOT NULL,
  `Name` varchar(225) DEFAULT NULL,
  `description` varchar(225) DEFAULT NULL,
  `image` varchar(225) DEFAULT NULL,
  `createdBy` varchar(225) DEFAULT NULL,
  `modifiedBy` varchar(225) DEFAULT NULL,
  `createdDatetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `modifiedDatetime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `s_category` */

insert  into `s_category`(`ID`,`Name`,`description`,`image`,`createdBy`,`modifiedBy`,`createdDatetime`,`modifiedDatetime`) values (1,'Football Sports','sdverovie','Football SportsdownloadFootball.jpg','Admin@gmail.com','Admin@gmail.com','2020-05-15 19:36:35','2020-05-15 19:37:04'),(2,'Cycling Sports','nmfgndng','Cycling Sports6ATyUC.jpg','Admin@gmail.com','Admin@gmail.com','2020-05-15 20:09:37','2020-05-15 20:09:37'),(3,'Hockey','sdvsdv','HockeydownloadHockey.png','Admin@gmail.com','Admin@gmail.com','2020-05-15 20:15:04','2020-05-15 20:15:04');

/*Table structure for table `s_product` */

DROP TABLE IF EXISTS `s_product`;

CREATE TABLE `s_product` (
  `ID` bigint(20) NOT NULL,
  `categoryId` bigint(20) DEFAULT NULL,
  `CategoryName` varchar(225) DEFAULT NULL,
  `name` varchar(225) DEFAULT NULL,
  `price` bigint(20) DEFAULT NULL,
  `description` varchar(755) DEFAULT NULL,
  `image` varchar(225) DEFAULT NULL,
  `createdBy` varchar(225) DEFAULT NULL,
  `modifiedBy` varchar(225) DEFAULT NULL,
  `createdDatetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `modifiedDatetime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`ID`),
  KEY `FK_s_product` (`categoryId`),
  CONSTRAINT `FK_f_product` FOREIGN KEY (`categoryId`) REFERENCES `s_category` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `s_product` */

insert  into `s_product`(`ID`,`categoryId`,`CategoryName`,`name`,`price`,`description`,`image`,`createdBy`,`modifiedBy`,`createdDatetime`,`modifiedDatetime`) values (1,1,'Football Sports','Addidas',1000,'adcw','Addidas6-60786_football-wallpapers-hd-wallpaper-cave-hd-photos-of.jpg','Admin@gmail.com','Admin@gmail.com','2020-05-15 19:40:44','2020-05-15 19:45:25'),(2,2,'Cycling Sports','Cycle',25000,'sdcvsdvsdv','Cyclecycling-wallpaper-6314325-cycling-wallpaper.jpg','Admin@gmail.com','Admin@gmail.com','2020-05-15 20:15:36','2020-05-15 20:15:36'),(3,3,'Hockey','Hockey',1500,'xcv xvsdf','Hockey172-1724676_download-hockey-free-png-photo-images-and-clipart.png','Admin@gmail.com','Admin@gmail.com','2020-05-15 20:16:01','2020-05-15 20:16:01');

/*Table structure for table `s_user` */

DROP TABLE IF EXISTS `s_user`;

CREATE TABLE `s_user` (
  `ID` bigint(20) NOT NULL,
  `firstName` varchar(225) DEFAULT NULL,
  `lastName` varchar(225) DEFAULT NULL,
  `login` varchar(225) DEFAULT NULL,
  `password` varchar(225) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `mobileNo` varchar(225) DEFAULT NULL,
  `roleId` bigint(20) DEFAULT NULL,
  `gender` varchar(225) DEFAULT NULL,
  `createdBy` varchar(225) DEFAULT NULL,
  `modifiedBy` varchar(225) DEFAULT NULL,
  `createdDatetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `modifiedDatetime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `s_user` */

insert  into `s_user`(`ID`,`firstName`,`lastName`,`login`,`password`,`dob`,`mobileNo`,`roleId`,`gender`,`createdBy`,`modifiedBy`,`createdDatetime`,`modifiedDatetime`) values (1,'Admin','Admin','Admin@gmail.com','Admin@123','1997-10-06','8596859685',1,'Male','root','root','2020-05-15 19:33:01','2020-05-15 19:32:40'),(2,'Demo','Demo','Demo@gmail.com','Demo@123','1997-10-06','8585859685',2,'Male','root','root','2020-05-15 19:50:47','2020-05-15 19:50:47');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
