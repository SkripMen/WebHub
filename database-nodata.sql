-- MariaDB dump 10.17  Distrib 10.5.2-MariaDB, for Win32 (AMD64)
--
-- Host: localhost    Database: webhub
-- ------------------------------------------------------
-- Server version	10.5.2-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `access_tokens`
--

DROP TABLE IF EXISTS `access_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `access_tokens` (
  `token` char(32) NOT NULL,
  `user_id` int(11) NOT NULL,
  `expire_time` datetime NOT NULL,
  `client_ip` varchar(20) NOT NULL,
  `user_client` varchar(512) NOT NULL,
  `create_time` datetime NOT NULL,
  PRIMARY KEY (`token`),
  KEY `access_tokens_users_id_fk` (`user_id`),
  CONSTRAINT `access_tokens_users_id_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `files`
--

DROP TABLE IF EXISTS `files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `files` (
  `id` char(32) NOT NULL,
  `file_size` int(11) NOT NULL,
  `file_type` varchar(100) NOT NULL,
  `file_data` longblob NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `forum_messages`
--

DROP TABLE IF EXISTS `forum_messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `forum_messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `forum_theme_id` int(11) NOT NULL,
  `created_by` int(11) DEFAULT NULL,
  `create_time` datetime NOT NULL,
  `text` varchar(2048) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `forum_messages_forum_theme_id_fk` (`forum_theme_id`),
  KEY `forum_messages_users_id_fk` (`created_by`),
  CONSTRAINT `forum_messages_forum_theme_id_fk` FOREIGN KEY (`forum_theme_id`) REFERENCES `forum_themes` (`id`),
  CONSTRAINT `forum_messages_users_id_fk` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `forum_themes`
--

DROP TABLE IF EXISTS `forum_themes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `forum_themes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `create_time` datetime NOT NULL,
  `avatar` char(32) DEFAULT NULL,
  `created_by` int(11) NOT NULL,
  `description` varchar(2048) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `forum_theme_files_id_fk` (`avatar`),
  KEY `forum_theme_users_id_fk` (`created_by`),
  CONSTRAINT `forum_theme_files_id_fk` FOREIGN KEY (`avatar`) REFERENCES `files` (`id`),
  CONSTRAINT `forum_theme_users_id_fk` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `langs`
--

DROP TABLE IF EXISTS `langs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `langs` (
  `id` varchar(10) NOT NULL,
  `title` varchar(50) NOT NULL,
  `background` varchar(255) NOT NULL,
  `avatar` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `langs_files_id_fk` (`avatar`),
  CONSTRAINT `langs_files_id_fk` FOREIGN KEY (`avatar`) REFERENCES `files` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lessons`
--

DROP TABLE IF EXISTS `lessons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lessons` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `lesson_theme_id` int(11) NOT NULL,
  `title` varchar(100) NOT NULL,
  `avatar` char(32) DEFAULT NULL,
  `markdown` text NOT NULL,
  `next_lesson_id` int(11) DEFAULT NULL,
  `prev_lesson_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `lesson_files_id_fk` (`avatar`),
  KEY `lesson_lessons_theme_id_fk` (`lesson_theme_id`),
  CONSTRAINT `lesson_files_id_fk` FOREIGN KEY (`avatar`) REFERENCES `files` (`id`),
  CONSTRAINT `lesson_lessons_theme_id_fk` FOREIGN KEY (`lesson_theme_id`) REFERENCES `lessons_themes` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=929 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lessons_themes`
--

DROP TABLE IF EXISTS `lessons_themes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lessons_themes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `lang` varchar(10) NOT NULL,
  `title` varchar(100) NOT NULL,
  `avatar` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `lessons_theme_files_id_fk` (`avatar`),
  KEY `lessons_theme_langs_id_fk` (`lang`),
  CONSTRAINT `lessons_theme_files_id_fk` FOREIGN KEY (`avatar`) REFERENCES `files` (`id`),
  CONSTRAINT `lessons_theme_langs_id_fk` FOREIGN KEY (`lang`) REFERENCES `langs` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=158 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notifications` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `title` varchar(200) NOT NULL,
  `create_time` datetime NOT NULL,
  `text` varchar(2048) NOT NULL,
  `action_url` varchar(1024) DEFAULT NULL,
  `is_read` tinyint(1) NOT NULL DEFAULT 0,
  `auto_read` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `notifications_users_id_fk` (`user_id`),
  CONSTRAINT `notifications_users_id_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_certificates`
--

DROP TABLE IF EXISTS `user_certificates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_certificates` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `create_date` datetime NOT NULL,
  `image_id` char(32) NOT NULL,
  `reason` varchar(512) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_certificates_files_id_fk` (`image_id`),
  KEY `user_certificates_users_id_fk` (`user_id`),
  CONSTRAINT `user_certificates_files_id_fk` FOREIGN KEY (`image_id`) REFERENCES `files` (`id`),
  CONSTRAINT `user_certificates_users_id_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_lesson_progress`
--

DROP TABLE IF EXISTS `user_lesson_progress`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_lesson_progress` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `lesson_id` int(11) NOT NULL,
  `progress` float NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_lesson_progress_user_id_lesson_id_uindex` (`user_id`,`lesson_id`),
  KEY `user_lesson_progress_lesson_id_fk` (`lesson_id`),
  KEY `user_lesson_progress_users_id_fk` (`user_id`),
  CONSTRAINT `user_lesson_progress_lesson_id_fk` FOREIGN KEY (`lesson_id`) REFERENCES `lessons` (`id`),
  CONSTRAINT `user_lesson_progress_users_id_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_lessons_comments`
--

DROP TABLE IF EXISTS `user_lessons_comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_lessons_comments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` datetime NOT NULL,
  `user_id` int(11) NOT NULL,
  `lesson_id` int(11) NOT NULL,
  `text` varchar(1024) NOT NULL,
  `rating` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_lessons_comments_lesson_id_fk` (`lesson_id`),
  KEY `user_lessons_comments_users_id_fk` (`user_id`),
  CONSTRAINT `user_lessons_comments_lesson_id_fk` FOREIGN KEY (`lesson_id`) REFERENCES `lessons` (`id`),
  CONSTRAINT `user_lessons_comments_users_id_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_theme_progress`
--

DROP TABLE IF EXISTS `user_theme_progress`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_theme_progress` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `lessons_theme_id` int(11) NOT NULL,
  `is_available` tinyint(1) NOT NULL,
  `is_exam_complete` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_theme_progress_lessons_theme_id_fk_2` (`lessons_theme_id`),
  KEY `user_theme_progress_users_id_fk` (`user_id`),
  CONSTRAINT `user_theme_progress_lessons_theme_id_fk_2` FOREIGN KEY (`lessons_theme_id`) REFERENCES `lessons_themes` (`id`),
  CONSTRAINT `user_theme_progress_users_id_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=170 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `login` varchar(100) NOT NULL,
  `password_hash` char(32) NOT NULL,
  `create_time` datetime NOT NULL,
  `sex_is_boy` tinyint(1) NOT NULL,
  `ava_file_id` char(32) DEFAULT NULL,
  `status` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `premium_expire` datetime DEFAULT NULL,
  `coins` int(11) NOT NULL,
  `last_active` datetime DEFAULT NULL,
  `score` int(11) NOT NULL,
  `last_score_update` datetime NOT NULL,
  `is_admin` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_uindex` (`email`),
  KEY `users_files_id_fk` (`ava_file_id`),
  CONSTRAINT `users_files_id_fk` FOREIGN KEY (`ava_file_id`) REFERENCES `files` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-06-21  3:57:57
