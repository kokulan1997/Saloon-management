-- phpMyAdmin SQL Dump
-- version 4.9.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Oct 01, 2020 at 04:20 AM
-- Server version: 10.4.10-MariaDB
-- PHP Version: 7.3.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `bigusarani_salon`
--
CREATE DATABASE IF NOT EXISTS `bigusarani_salon` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `bigusarani_salon`;

-- --------------------------------------------------------

--
-- Table structure for table `appointments`
--

DROP TABLE IF EXISTS `appointments`;
CREATE TABLE IF NOT EXISTS `appointments` (
  `appointment_id` int(16) NOT NULL AUTO_INCREMENT,
  `customer_id` int(10) NOT NULL,
  `branch_id` int(2) NOT NULL,
  `service_id` int(5) NOT NULL,
  `user_id` int(5) DEFAULT NULL,
  PRIMARY KEY (`appointment_id`),
  KEY `customer_id` (`customer_id`),
  KEY `branch_id` (`branch_id`),
  KEY `service_id` (`service_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `contact_numbers`
--

DROP TABLE IF EXISTS `contact_numbers`;
CREATE TABLE IF NOT EXISTS `contact_numbers` (
  `customer_id` int(5) NOT NULL,
  `contact_no` int(13) NOT NULL,
  PRIMARY KEY (`customer_id`,`contact_no`),
  KEY `customer_id` (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

DROP TABLE IF EXISTS `customers`;
CREATE TABLE IF NOT EXISTS `customers` (
  `customer_id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `special_notes` varchar(500) DEFAULT NULL,
  `preferences` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `experts`
--

DROP TABLE IF EXISTS `experts`;
CREATE TABLE IF NOT EXISTS `experts` (
  `user_id` int(5) NOT NULL,
  `service_id` int(5) NOT NULL,
  PRIMARY KEY (`user_id`,`service_id`),
  KEY `service_id` (`service_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `message_in`
--

DROP TABLE IF EXISTS `message_in`;
CREATE TABLE IF NOT EXISTS `message_in` (
  `message_id` int(16) NOT NULL AUTO_INCREMENT,
  `customer_id` int(10) NOT NULL,
  `phone_no` int(14) NOT NULL,
  `content` varchar(500) NOT NULL,
  `timestamp` varchar(100) NOT NULL,
  PRIMARY KEY (`message_id`),
  KEY `customer_id` (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
CREATE TABLE IF NOT EXISTS `notifications` (
  `notification_id` int(20) NOT NULL AUTO_INCREMENT,
  `type` int(5) NOT NULL,
  `status` int(1) NOT NULL,
  `result` varchar(50) NOT NULL,
  PRIMARY KEY (`notification_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `services`
--

DROP TABLE IF EXISTS `services`;
CREATE TABLE IF NOT EXISTS `services` (
  `service_id` int(5) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `estimated_time` int(10) NOT NULL,
  `price` int(10) NOT NULL,
  PRIMARY KEY (`service_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `service_branch`
--

DROP TABLE IF EXISTS `service_branch`;
CREATE TABLE IF NOT EXISTS `service_branch` (
  `branch_id` int(2) NOT NULL AUTO_INCREMENT,
  `location` varchar(100) NOT NULL,
  `branch_manager` int(5) NOT NULL,
  PRIMARY KEY (`branch_id`),
  KEY `branch_manager` (`branch_manager`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `user_id` int(5) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `access_level` int(1) UNSIGNED NOT NULL,
  `password` varchar(50) NOT NULL,
  `joined_date` varchar(100) NOT NULL,
  `branch_id` int(2) NOT NULL,
  PRIMARY KEY (`user_id`),
  KEY `branch_id` (`branch_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `appointments`
--
ALTER TABLE `appointments`
  ADD CONSTRAINT `appointments_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`),
  ADD CONSTRAINT `appointments_ibfk_2` FOREIGN KEY (`service_id`) REFERENCES `services` (`service_id`),
  ADD CONSTRAINT `appointments_ibfk_3` FOREIGN KEY (`branch_id`) REFERENCES `service_branch` (`branch_id`),
  ADD CONSTRAINT `appointments_ibfk_4` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `contact_numbers`
--
ALTER TABLE `contact_numbers`
  ADD CONSTRAINT `contact_numbers_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`);

--
-- Constraints for table `experts`
--
ALTER TABLE `experts`
  ADD CONSTRAINT `experts_ibfk_1` FOREIGN KEY (`service_id`) REFERENCES `services` (`service_id`),
  ADD CONSTRAINT `experts_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `message_in`
--
ALTER TABLE `message_in`
  ADD CONSTRAINT `message_in_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`);

--
-- Constraints for table `service_branch`
--
ALTER TABLE `service_branch`
  ADD CONSTRAINT `service_branch_ibfk_1` FOREIGN KEY (`branch_manager`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`branch_id`) REFERENCES `service_branch` (`branch_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
