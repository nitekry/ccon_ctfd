/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19  Distrib 10.11.16-MariaDB, for debian-linux-gnu (aarch64)
--
-- Host: localhost    Database: ctfd
-- ------------------------------------------------------
-- Server version	10.11.16-MariaDB-ubu2204

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
-- Table structure for table `alembic_version`
--

DROP TABLE IF EXISTS `alembic_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `alembic_version` (
  `version_num` varchar(32) NOT NULL,
  PRIMARY KEY (`version_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alembic_version`
--

LOCK TABLES `alembic_version` WRITE;
/*!40000 ALTER TABLE `alembic_version` DISABLE KEYS */;
INSERT INTO `alembic_version` VALUES
('48d8250d19bd');
/*!40000 ALTER TABLE `alembic_version` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `awards`
--

DROP TABLE IF EXISTS `awards`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `awards` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `team_id` int(11) DEFAULT NULL,
  `name` varchar(80) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `date` datetime(6) DEFAULT NULL,
  `value` int(11) DEFAULT NULL,
  `category` varchar(80) DEFAULT NULL,
  `icon` text DEFAULT NULL,
  `requirements` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`requirements`)),
  `type` varchar(80) DEFAULT 'standard',
  PRIMARY KEY (`id`),
  KEY `awards_ibfk_1` (`team_id`),
  KEY `awards_ibfk_2` (`user_id`),
  CONSTRAINT `awards_ibfk_1` FOREIGN KEY (`team_id`) REFERENCES `teams` (`id`) ON DELETE CASCADE,
  CONSTRAINT `awards_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `awards`
--

LOCK TABLES `awards` WRITE;
/*!40000 ALTER TABLE `awards` DISABLE KEYS */;
INSERT INTO `awards` VALUES
(2,1,NULL,'Hint 2','Hint for VPN Who?','2026-02-26 06:27:01.093381',0,'hints',NULL,NULL,'standard'),
(3,1,NULL,'n00b',NULL,'2026-02-26 07:25:25.703123',0,'warm-up',NULL,NULL,'standard');
/*!40000 ALTER TABLE `awards` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `brackets`
--

DROP TABLE IF EXISTS `brackets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `brackets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `type` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `brackets`
--

LOCK TABLES `brackets` WRITE;
/*!40000 ALTER TABLE `brackets` DISABLE KEYS */;
INSERT INTO `brackets` VALUES
(1,'n00bs','start here','users'),
(2,'Level 1','Welcome','users');
/*!40000 ALTER TABLE `brackets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `challenge_topics`
--

DROP TABLE IF EXISTS `challenge_topics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `challenge_topics` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `challenge_id` int(11) DEFAULT NULL,
  `topic_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `challenge_id` (`challenge_id`),
  KEY `topic_id` (`topic_id`),
  CONSTRAINT `challenge_topics_ibfk_1` FOREIGN KEY (`challenge_id`) REFERENCES `challenges` (`id`) ON DELETE CASCADE,
  CONSTRAINT `challenge_topics_ibfk_2` FOREIGN KEY (`topic_id`) REFERENCES `topics` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `challenge_topics`
--

LOCK TABLES `challenge_topics` WRITE;
/*!40000 ALTER TABLE `challenge_topics` DISABLE KEYS */;
/*!40000 ALTER TABLE `challenge_topics` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `challenges`
--

DROP TABLE IF EXISTS `challenges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `challenges` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `max_attempts` int(11) DEFAULT NULL,
  `value` int(11) DEFAULT NULL,
  `category` varchar(80) DEFAULT NULL,
  `type` varchar(80) DEFAULT NULL,
  `state` varchar(80) NOT NULL,
  `requirements` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`requirements`)),
  `connection_info` text DEFAULT NULL,
  `next_id` int(11) DEFAULT NULL,
  `attribution` text DEFAULT NULL,
  `logic` varchar(80) NOT NULL,
  `initial` int(11) DEFAULT NULL,
  `minimum` int(11) DEFAULT NULL,
  `decay` int(11) DEFAULT NULL,
  `function` varchar(32) DEFAULT NULL,
  `position` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `next_id` (`next_id`),
  CONSTRAINT `challenges_ibfk_1` FOREIGN KEY (`next_id`) REFERENCES `challenges` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `challenges`
--

LOCK TABLES `challenges` WRITE;
/*!40000 ALTER TABLE `challenges` DISABLE KEYS */;
INSERT INTO `challenges` VALUES
(1,'Hello World!!!','I told a joke about UDP… but I’m not sure if you’ll get it.',0,1,'Start Here','standard','visible',NULL,NULL,2,NULL,'any',NULL,NULL,NULL,'static',0),
(2,'Quotes','Shall We Play a Game?\r\n![wargames.jpg](/files/3ca8bcc3eae48ac77f39efa61afb3c88/wargames.jpg)',0,1,'Movie','standard','visible','{\"prerequisites\": [1]}',NULL,NULL,NULL,'any',NULL,NULL,NULL,'static',0),
(3,'Who the heck is that?','\"That\'s _ _ _ _. He fights for the Users.![tron.jpg](/files/16f8a6874604159febf19545a8d31445/tron.jpg)',0,1,'Movie','standard','visible','{\"prerequisites\": [1]}',NULL,8,NULL,'any',NULL,NULL,NULL,'static',0),
(4,'Threat Type?','Defeating Cyber Security is not always defeated by computers or social engineering. The movie \"Sneakers\" remindes us of \"This Threat\"![sneakers.jpg](/files/9598ed56b9c5beaefd1d82ca43223690/sneakers.jpg)',0,1,'Movie','standard','visible','{\"prerequisites\": [1]}',NULL,NULL,NULL,'any',NULL,NULL,NULL,'static',0),
(5,'Threat Type?','When life gets overwhelming, I call it stress. When the internet gets overwhelming its _ _ _ _!![DDoS.jpg](/files/941a82b76b3507442c810547a4f707c5/DDoS.jpg)',0,1,'Is this a Joke?','standard','visible','{\"prerequisites\": [1]}',NULL,NULL,NULL,'any',NULL,NULL,NULL,'static',0),
(6,'Punch Line','Why did the modem needed to do cardio workouts? \r\n![modem.png](/files/4f2099bed9debab04b94e29c92e86218/modem.png)\r\nTo increase its __ rate.',0,1,'Is this a Joke?','standard','visible','{\"prerequisites\": [1]}',NULL,NULL,NULL,'any',NULL,NULL,NULL,'static',0),
(7,'Full Send!!! \"OK\"','Just click \"OK\" to continue\r\n![computer-virus-1392134575.jpg](/files/e862f47da97cc18e02012570e403dcae/computer-virus-1392134575.jpg)\r\nYour computer is begging for adult supervision. If you were the Captain of a Starship, would you go to warp with your console looking like this? ',0,1,'n00bs','standard','visible','{\"prerequisites\": [1]}',NULL,NULL,NULL,'any',NULL,NULL,NULL,'static',0),
(8,'Why?','Why does he fight for the users?!![tron.jpg](/files/16f8a6874604159febf19545a8d31445/tron.jpg)',0,5,'Movie','standard','visible','{\"prerequisites\": [3]}',NULL,NULL,NULL,'any',NULL,NULL,NULL,'static',0),
(9,'VPN Who?','![cloud.jpg](/files/af34e9e206d54daab5aecee711b4b9ab/cloud.jpg)\r\nGet behind a VPN they said, Hide your footprints from digital Karens. But there are some problems to consider with using many VPNs You should always verify before you trust.  \r\nData: Retained, Sold, Logged, Shared?\r\nWhere is the company based?\r\nLocal Laws?\r\nWhat is another concers you might consider?    _ _ _\r\n',0,1,'n00bs','standard','visible','{\"prerequisites\": []}',NULL,NULL,NULL,'any',NULL,NULL,NULL,'static',0),
(10,'Where did he go?','Why did the hacker cross the road?\r\n![hacker-away.jpg](/files/a00236ea5174d67ad323369c555aa415/hacker-away.jpg)\r\nJust before they kicked in his door, the hacker ____',0,1,'Is this a Joke?','standard','visible',NULL,NULL,NULL,NULL,'any',NULL,NULL,NULL,'static',0),
(11,'The Raven','Raven Adler\r\nProbably the smartest human to ever emerge from Mississippi gain notoriety after speaking at Defcon.\r\n![raven.jpg](/files/898bb26812640b82829e500dc1e91a39/raven.jpg)\r\nWhat was the well known term coined by her?',0,1,'Hacker Trivia','standard','visible',NULL,NULL,NULL,NULL,'any',NULL,NULL,NULL,'static',0),
(12,'Opsec Time','Use your skills to search the Ccon area for clues.\r\n![dumpster.jpg](/files/87b334f96353a9b2528eb97f28cb0efb/dumpster.jpg)',0,3,'n00bs','standard','visible','{\"prerequisites\": [4]}',NULL,NULL,NULL,'any',NULL,NULL,NULL,'static',0),
(13,'Ransomware','![crying.gif](/files/a400e3fdcfe54d3e0300cdeec672df79/crying.gif)\r\nIn 2017 this ransomware attack made thousands of people across the world cry.',0,1,'Hacker Trivia','standard','visible',NULL,NULL,NULL,NULL,'any',NULL,NULL,NULL,'static',0),
(14,'Its a trap','Dirty Tricks\r\n![pooh.gif](/files/a54bb2b0bcf90876f158df36bcafdb02/pooh.gif)\r\nThis hacker trap is not only is used to catch criminals. Modern cyber security firms even use them to catch companies accessing \"risky\" websites. Then ask for payment to help resolve the hits on their cyberhygine score.',0,1,'Hacker Trivia','standard','visible',NULL,NULL,NULL,NULL,'any',NULL,NULL,NULL,'static',0),
(15,'Gratz!','Congratulations n00b! time to jump to the next level\r\n\r\nhttp://10.242.242.40:8000/l1',0,0,'Level Up','standard','visible','{\"prerequisites\": [1, 10, 11, 12, 13, 14, 2, 3, 4, 5, 6, 7, 8, 9]}',NULL,NULL,NULL,'any',NULL,NULL,NULL,'static',0);
/*!40000 ALTER TABLE `challenges` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comments`
--

DROP TABLE IF EXISTS `comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `comments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(80) DEFAULT NULL,
  `content` text DEFAULT NULL,
  `date` datetime(6) DEFAULT NULL,
  `author_id` int(11) DEFAULT NULL,
  `challenge_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `team_id` int(11) DEFAULT NULL,
  `page_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `author_id` (`author_id`),
  KEY `challenge_id` (`challenge_id`),
  KEY `page_id` (`page_id`),
  KEY `team_id` (`team_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `comments_ibfk_1` FOREIGN KEY (`author_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `comments_ibfk_2` FOREIGN KEY (`challenge_id`) REFERENCES `challenges` (`id`) ON DELETE CASCADE,
  CONSTRAINT `comments_ibfk_3` FOREIGN KEY (`page_id`) REFERENCES `pages` (`id`) ON DELETE CASCADE,
  CONSTRAINT `comments_ibfk_4` FOREIGN KEY (`team_id`) REFERENCES `teams` (`id`) ON DELETE CASCADE,
  CONSTRAINT `comments_ibfk_5` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comments`
--

LOCK TABLES `comments` WRITE;
/*!40000 ALTER TABLE `comments` DISABLE KEYS */;
/*!40000 ALTER TABLE `comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `config`
--

DROP TABLE IF EXISTS `config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `config` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `key` text DEFAULT NULL,
  `value` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `config`
--

LOCK TABLES `config` WRITE;
/*!40000 ALTER TABLE `config` DISABLE KEYS */;
INSERT INTO `config` VALUES
(1,'ctf_version','3.8.2'),
(2,'dynamic_challenges_alembic_version','93284ed9c099'),
(3,'ctf_name','Hack Yourself'),
(4,'ctf_description','A CTF for every skill level — come play, share, learn, and level up. From “what’s a flag?” to “hold my coffee” — all welcome.'),
(5,'user_mode','users'),
(6,'ctf_logo',NULL),
(7,'ctf_theme','terminal-theme'),
(8,'theme_header','<style id=\"theme-color\">\r\n:root {--theme-color: #000000;}\r\n.navbar{background-color: var(--theme-color) !important;}\r\n.jumbotron{background-color: var(--theme-color) !important;}\r\n</style>\r\n'),
(9,'start','1767247200'),
(10,'end','1793336400'),
(11,'freeze',NULL),
(12,'challenge_visibility','private'),
(13,'registration_visibility','public'),
(14,'score_visibility','public'),
(15,'account_visibility','public'),
(16,'verify_emails','false'),
(17,'social_shares','false'),
(18,'team_size',''),
(19,'mail_server',NULL),
(20,'mail_port',NULL),
(21,'mail_tls',NULL),
(22,'mail_ssl',NULL),
(23,'mail_username',NULL),
(24,'mail_password',NULL),
(25,'mail_useauth',NULL),
(26,'setup','1'),
(27,'version_latest',NULL),
(28,'next_update_check','1774628045'),
(29,'view_self_submissions','0'),
(30,'max_attempts_behavior','lockout'),
(31,'max_attempts_timeout','300'),
(32,'hints_free_public_access','1'),
(33,'challenge_ratings','public'),
(34,'default_locale','en'),
(35,'theme_footer',''),
(36,'theme_settings','{\r\n  \"challenge_window_size\": \"norm\",\r\n  \"challenge_category_order\": \"\",\r\n  \"challenge_order\": \"\",\r\n  \"use_builtin_code_highlighter\": true\r\n}');
/*!40000 ALTER TABLE `config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dynamic_challenge`
--

DROP TABLE IF EXISTS `dynamic_challenge`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `dynamic_challenge` (
  `id` int(11) NOT NULL,
  `dynamic_initial` int(11) DEFAULT NULL,
  `dynamic_minimum` int(11) DEFAULT NULL,
  `dynamic_decay` int(11) DEFAULT NULL,
  `dynamic_function` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `dynamic_challenge_ibfk_1` FOREIGN KEY (`id`) REFERENCES `challenges` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dynamic_challenge`
--

LOCK TABLES `dynamic_challenge` WRITE;
/*!40000 ALTER TABLE `dynamic_challenge` DISABLE KEYS */;
/*!40000 ALTER TABLE `dynamic_challenge` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_entries`
--

DROP TABLE IF EXISTS `field_entries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `field_entries` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(80) DEFAULT NULL,
  `value` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`value`)),
  `field_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `team_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `field_id` (`field_id`),
  KEY `team_id` (`team_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `field_entries_ibfk_1` FOREIGN KEY (`field_id`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `field_entries_ibfk_2` FOREIGN KEY (`team_id`) REFERENCES `teams` (`id`) ON DELETE CASCADE,
  CONSTRAINT `field_entries_ibfk_3` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_entries`
--

LOCK TABLES `field_entries` WRITE;
/*!40000 ALTER TABLE `field_entries` DISABLE KEYS */;
/*!40000 ALTER TABLE `field_entries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fields`
--

DROP TABLE IF EXISTS `fields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `fields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` text DEFAULT NULL,
  `type` varchar(80) DEFAULT NULL,
  `field_type` varchar(80) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `required` tinyint(1) DEFAULT NULL,
  `public` tinyint(1) DEFAULT NULL,
  `editable` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fields`
--

LOCK TABLES `fields` WRITE;
/*!40000 ALTER TABLE `fields` DISABLE KEYS */;
/*!40000 ALTER TABLE `fields` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `files`
--

DROP TABLE IF EXISTS `files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `files` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(80) DEFAULT NULL,
  `location` text DEFAULT NULL,
  `challenge_id` int(11) DEFAULT NULL,
  `page_id` int(11) DEFAULT NULL,
  `sha1sum` varchar(40) DEFAULT NULL,
  `solution_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `page_id` (`page_id`),
  KEY `files_ibfk_1` (`challenge_id`),
  KEY `solution_id` (`solution_id`),
  CONSTRAINT `files_ibfk_1` FOREIGN KEY (`challenge_id`) REFERENCES `challenges` (`id`) ON DELETE CASCADE,
  CONSTRAINT `files_ibfk_2` FOREIGN KEY (`page_id`) REFERENCES `pages` (`id`),
  CONSTRAINT `files_ibfk_3` FOREIGN KEY (`solution_id`) REFERENCES `solutions` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `files`
--

LOCK TABLES `files` WRITE;
/*!40000 ALTER TABLE `files` DISABLE KEYS */;
INSERT INTO `files` VALUES
(1,'standard','c6f0e6778fd3fa84b8879a67f14278f4/HFW6-BG.png',NULL,NULL,'8e6eb86599f64208801e6321ba3453b9cb1a4521',NULL),
(8,'page','af34e9e206d54daab5aecee711b4b9ab/cloud.jpg',NULL,NULL,'3a95915dcfb8c11dd3dfb6610736d4adf978f9aa',NULL),
(10,'page','941a82b76b3507442c810547a4f707c5/DDoS.jpg',NULL,NULL,'fc6cc1de6c738c417492c02f1eba9c217a455ce7',NULL),
(11,'page','4f2099bed9debab04b94e29c92e86218/modem.png',NULL,NULL,'12a81726cd6dd819f8c811fae7819279a57bd13f',NULL),
(14,'page','e862f47da97cc18e02012570e403dcae/computer-virus-1392134575.jpg',NULL,NULL,'8f2681ede6efcbf818ee2a75cc561e51d5846110',NULL),
(15,'page','3ca8bcc3eae48ac77f39efa61afb3c88/wargames.jpg',NULL,NULL,'2a2e39d1ea2edfcedd31ef10d4749e4182a49ed3',NULL),
(16,'page','16f8a6874604159febf19545a8d31445/tron.jpg',NULL,NULL,'2fbb6a63394c0e336e2974575ab144aa874ef953',NULL),
(17,'page','9598ed56b9c5beaefd1d82ca43223690/sneakers.jpg',NULL,NULL,'616458a7a91dc53caad0069cc761c1e1685d248e',NULL),
(18,'page','a00236ea5174d67ad323369c555aa415/hacker-away.jpg',NULL,NULL,'62967341d17cab8dd64218dd99fd458362169b9d',NULL),
(19,'page','898bb26812640b82829e500dc1e91a39/raven.jpg',NULL,NULL,'fdbba3731891c31e45a4939805da0474564662ac',NULL),
(20,'page','87b334f96353a9b2528eb97f28cb0efb/dumpster.jpg',NULL,NULL,'7d6a006067dabd79d6d479ff279e9669bd459d21',NULL),
(21,'page','a400e3fdcfe54d3e0300cdeec672df79/crying.gif',NULL,NULL,'b8769c007a1f22c1a6633a564f123540c6aaad3c',NULL),
(22,'page','a54bb2b0bcf90876f158df36bcafdb02/pooh.gif',NULL,NULL,'c5219b5a3b758d0f8d8cd95e71a1803be7dc8b17',NULL);
/*!40000 ALTER TABLE `files` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flags`
--

DROP TABLE IF EXISTS `flags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `flags` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `challenge_id` int(11) DEFAULT NULL,
  `type` varchar(80) DEFAULT NULL,
  `content` text DEFAULT NULL,
  `data` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `flags_ibfk_1` (`challenge_id`),
  CONSTRAINT `flags_ibfk_1` FOREIGN KEY (`challenge_id`) REFERENCES `challenges` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flags`
--

LOCK TABLES `flags` WRITE;
/*!40000 ALTER TABLE `flags` DISABLE KEYS */;
INSERT INTO `flags` VALUES
(5,1,'regex','.*',''),
(6,2,'static','wargames','case_insensitive'),
(7,2,'static','WOPR','case_insensitive'),
(8,2,'static','Global Thermonuclear War','case_insensitive'),
(9,3,'static','tron','case_insensitive'),
(13,4,'static','opsec','case_insensitive'),
(14,4,'static','physical','case_insensitive'),
(15,4,'static','procedural','case_insensitive'),
(16,5,'static','DDoS','case_insensitive'),
(17,5,'static','DDoS Attack','case_insensitive'),
(18,5,'static','Denial of Service','case_insensitive'),
(19,6,'static','Baud','case_insensitive'),
(20,6,'static','bit','case_insensitive'),
(21,7,'static','OK','case_insensitive'),
(22,3,'static','decentrlization','case_insensitive'),
(23,8,'static','decentralization','case_insensitive'),
(24,9,'static','who','case_insensitive'),
(26,10,'static','ran somewhere','case_insensitive'),
(27,10,'static','he ran some where','case_insensitive'),
(28,10,'static','ran some where','case_insensitive'),
(29,10,'static','he ran somewhere','case_insensitive'),
(30,11,'static','zeroday','case_insensitive'),
(31,11,'static','zero day','case_insensitive'),
(32,11,'static','0day','case_insensitive'),
(33,11,'static','0 day','case_insensitive'),
(34,12,'static','P!zza4me','case_insensitive'),
(35,4,'static','human','case_insensitive'),
(36,13,'static','wannacry','case_insensitive'),
(37,14,'static','honeypot','case_insensitive'),
(38,15,'static','Hyrjk874jdkrooi543kd0Kf',''),
(39,10,'static','ransomewhere','case_insensitive'),
(40,10,'static','ransomeware','case_insensitive');
/*!40000 ALTER TABLE `flags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hints`
--

DROP TABLE IF EXISTS `hints`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `hints` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(80) DEFAULT NULL,
  `challenge_id` int(11) DEFAULT NULL,
  `content` text DEFAULT NULL,
  `cost` int(11) DEFAULT NULL,
  `requirements` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`requirements`)),
  `title` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `hints_ibfk_1` (`challenge_id`),
  CONSTRAINT `hints_ibfk_1` FOREIGN KEY (`challenge_id`) REFERENCES `challenges` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hints`
--

LOCK TABLES `hints` WRITE;
/*!40000 ALTER TABLE `hints` DISABLE KEYS */;
INSERT INTO `hints` VALUES
(1,'standard',1,'get it? haha',0,'{\"prerequisites\": []}',''),
(2,'standard',9,'https://youtu.be/1opKW6X88og?si=aOuFxwFQPyvBzEoO',0,'{\"prerequisites\": []}','Video');
/*!40000 ALTER TABLE `hints` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `notifications` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` text DEFAULT NULL,
  `content` text DEFAULT NULL,
  `date` datetime(6) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `team_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `team_id` (`team_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `notifications_ibfk_1` FOREIGN KEY (`team_id`) REFERENCES `teams` (`id`),
  CONSTRAINT `notifications_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notifications`
--

LOCK TABLES `notifications` WRITE;
/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;
/*!40000 ALTER TABLE `notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pages`
--

DROP TABLE IF EXISTS `pages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `pages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(80) DEFAULT NULL,
  `route` varchar(128) DEFAULT NULL,
  `content` text DEFAULT NULL,
  `draft` tinyint(1) DEFAULT NULL,
  `hidden` tinyint(1) DEFAULT NULL,
  `auth_required` tinyint(1) DEFAULT NULL,
  `format` varchar(80) DEFAULT NULL,
  `link_target` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `route` (`route`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pages`
--

LOCK TABLES `pages` WRITE;
/*!40000 ALTER TABLE `pages` DISABLE KEYS */;
INSERT INTO `pages` VALUES
(1,'Hack Yourself','index','<div class=\"row\">\n    <div class=\"col-md-6 offset-md-3\">\n        <img class=\"w-100 mx-auto d-block\" style=\"max-width: 500px;padding: 50px;padding-top: 14vh;\" src=\"/themes/core/static/img/logo.png?d=43151cde\" />\n        <h3 class=\"text-center\">\n            <p>A cool CTF platform from <a href=\"https://ctfd.io\">ctfd.io</a></p>\n            <p>Follow us on social media:</p>\n            <a href=\"https://twitter.com/ctfdio\"><i class=\"fab fa-twitter fa-2x\" aria-hidden=\"true\"></i></a>&nbsp;\n            <a href=\"https://facebook.com/ctfdio\"><i class=\"fab fa-facebook fa-2x\" aria-hidden=\"true\"></i></a>&nbsp;\n            <a href=\"https://github.com/ctfd\"><i class=\"fab fa-github fa-2x\" aria-hidden=\"true\"></i></a>\n        </h3>\n        <br>\n        <h4 class=\"text-center\">\n            <a href=\"admin\">Click here</a> to login and setup your CTF\n        </h4>\n    </div>\n</div>',0,NULL,NULL,'markdown',NULL),
(2,'Level 1','l1','Level 1',0,1,0,'markdown',NULL);
/*!40000 ALTER TABLE `pages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ratings`
--

DROP TABLE IF EXISTS `ratings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ratings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `challenge_id` int(11) DEFAULT NULL,
  `value` int(11) DEFAULT NULL,
  `review` varchar(2000) DEFAULT NULL,
  `date` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`challenge_id`),
  KEY `challenge_id` (`challenge_id`),
  CONSTRAINT `ratings_ibfk_1` FOREIGN KEY (`challenge_id`) REFERENCES `challenges` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ratings_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ratings`
--

LOCK TABLES `ratings` WRITE;
/*!40000 ALTER TABLE `ratings` DISABLE KEYS */;
/*!40000 ALTER TABLE `ratings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `solutions`
--

DROP TABLE IF EXISTS `solutions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `solutions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `challenge_id` int(11) DEFAULT NULL,
  `content` text DEFAULT NULL,
  `state` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `challenge_id` (`challenge_id`),
  CONSTRAINT `solutions_ibfk_1` FOREIGN KEY (`challenge_id`) REFERENCES `challenges` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `solutions`
--

LOCK TABLES `solutions` WRITE;
/*!40000 ALTER TABLE `solutions` DISABLE KEYS */;
INSERT INTO `solutions` VALUES
(1,9,'https://www.youtube.com/shorts/qyvK9maFmXU','solved');
/*!40000 ALTER TABLE `solutions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `solves`
--

DROP TABLE IF EXISTS `solves`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `solves` (
  `id` int(11) NOT NULL,
  `challenge_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `team_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `challenge_id` (`challenge_id`,`team_id`),
  UNIQUE KEY `challenge_id_2` (`challenge_id`,`user_id`),
  KEY `team_id` (`team_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `solves_ibfk_1` FOREIGN KEY (`challenge_id`) REFERENCES `challenges` (`id`) ON DELETE CASCADE,
  CONSTRAINT `solves_ibfk_2` FOREIGN KEY (`id`) REFERENCES `submissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `solves_ibfk_3` FOREIGN KEY (`team_id`) REFERENCES `teams` (`id`) ON DELETE CASCADE,
  CONSTRAINT `solves_ibfk_4` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `solves`
--

LOCK TABLES `solves` WRITE;
/*!40000 ALTER TABLE `solves` DISABLE KEYS */;
INSERT INTO `solves` VALUES
(13,1,1,NULL),
(25,2,1,NULL),
(26,3,1,NULL),
(27,4,1,NULL),
(28,5,1,NULL),
(29,6,1,NULL),
(36,10,1,NULL),
(38,7,1,NULL),
(39,9,1,NULL),
(40,11,1,NULL),
(42,13,1,NULL),
(43,14,1,NULL),
(44,8,1,NULL),
(45,12,1,NULL);
/*!40000 ALTER TABLE `solves` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `submissions`
--

DROP TABLE IF EXISTS `submissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `submissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `challenge_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `team_id` int(11) DEFAULT NULL,
  `ip` varchar(46) DEFAULT NULL,
  `provided` text DEFAULT NULL,
  `type` varchar(32) DEFAULT NULL,
  `date` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `challenge_id` (`challenge_id`),
  KEY `team_id` (`team_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `submissions_ibfk_1` FOREIGN KEY (`challenge_id`) REFERENCES `challenges` (`id`) ON DELETE CASCADE,
  CONSTRAINT `submissions_ibfk_2` FOREIGN KEY (`team_id`) REFERENCES `teams` (`id`) ON DELETE CASCADE,
  CONSTRAINT `submissions_ibfk_3` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `submissions`
--

LOCK TABLES `submissions` WRITE;
/*!40000 ALTER TABLE `submissions` DISABLE KEYS */;
INSERT INTO `submissions` VALUES
(9,7,1,NULL,'172.19.0.1','ok','incorrect','2026-02-09 22:18:32.559452'),
(10,7,1,NULL,'172.19.0.1','ok','incorrect','2026-02-09 22:18:33.529610'),
(13,1,1,NULL,'192.168.65.1','blah','correct','2026-02-24 23:01:15.698580'),
(22,7,1,NULL,'10.242.242.46','ok','incorrect','2026-02-26 07:12:54.103424'),
(24,9,1,NULL,'10.242.242.46','where','incorrect','2026-02-26 07:13:13.280487'),
(25,2,1,NULL,'10.242.242.46','wargames','correct','2026-03-04 23:56:24.707215'),
(26,3,1,NULL,'10.242.242.46','tron','correct','2026-03-04 23:56:29.670022'),
(27,4,1,NULL,'10.242.242.46','physical','correct','2026-03-04 23:56:39.150760'),
(28,5,1,NULL,'10.242.242.46','ddos','correct','2026-03-04 23:58:45.450840'),
(29,6,1,NULL,'10.242.242.46','bit','correct','2026-03-04 23:58:50.898252'),
(30,10,1,NULL,'10.242.242.46','rnsomeware','incorrect','2026-03-04 23:59:00.445613'),
(31,10,1,NULL,'10.242.242.46','rnsomewhere','incorrect','2026-03-04 23:59:05.940528'),
(32,10,1,NULL,'10.242.242.46','ransomewhere','incorrect','2026-03-04 23:59:09.787381'),
(33,10,1,NULL,'10.242.242.46','ransomeware','incorrect','2026-03-04 23:59:14.656093'),
(34,10,1,NULL,'10.242.242.46','ransomeware','incorrect','2026-03-04 23:59:16.516422'),
(35,10,1,NULL,'10.242.242.46','ransomeware','incorrect','2026-03-04 23:59:17.964875'),
(36,10,1,NULL,'10.242.242.46','ran some where','correct','2026-03-04 23:59:47.614149'),
(37,7,1,NULL,'10.242.242.46','ok','incorrect','2026-03-04 23:59:52.050517'),
(38,7,1,NULL,'10.242.242.46','OK','correct','2026-03-04 23:59:56.332071'),
(39,9,1,NULL,'10.242.242.46','who','correct','2026-03-05 00:00:56.333863'),
(40,11,1,NULL,'10.242.242.46','zeroday','correct','2026-03-05 00:01:18.650449'),
(41,13,1,NULL,'10.242.242.46','wnnacry','incorrect','2026-03-05 00:01:39.857276'),
(42,13,1,NULL,'10.242.242.46','wannacry','correct','2026-03-05 00:01:44.603488'),
(43,14,1,NULL,'10.242.242.46','honeypot','correct','2026-03-05 00:01:52.159164'),
(44,8,1,NULL,'10.242.242.46','decentralization','correct','2026-03-05 00:02:04.111075'),
(45,12,1,NULL,'10.242.242.46','P!zza4me','correct','2026-03-05 00:02:39.557808'),
(46,15,1,NULL,'10.242.242.46','go','incorrect','2026-03-05 11:46:00.669579'),
(47,15,1,NULL,'192.168.8.176','hjgfjhtf','incorrect','2026-03-19 23:41:51.238493');
/*!40000 ALTER TABLE `submissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tags`
--

DROP TABLE IF EXISTS `tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `tags` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `challenge_id` int(11) DEFAULT NULL,
  `value` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `tags_ibfk_1` (`challenge_id`),
  CONSTRAINT `tags_ibfk_1` FOREIGN KEY (`challenge_id`) REFERENCES `challenges` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tags`
--

LOCK TABLES `tags` WRITE;
/*!40000 ALTER TABLE `tags` DISABLE KEYS */;
/*!40000 ALTER TABLE `tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teams`
--

DROP TABLE IF EXISTS `teams`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `teams` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `oauth_id` int(11) DEFAULT NULL,
  `name` varchar(128) DEFAULT NULL,
  `email` varchar(128) DEFAULT NULL,
  `password` varchar(128) DEFAULT NULL,
  `secret` varchar(128) DEFAULT NULL,
  `website` varchar(128) DEFAULT NULL,
  `affiliation` varchar(128) DEFAULT NULL,
  `country` varchar(32) DEFAULT NULL,
  `hidden` tinyint(1) DEFAULT NULL,
  `banned` tinyint(1) DEFAULT NULL,
  `created` datetime(6) DEFAULT NULL,
  `captain_id` int(11) DEFAULT NULL,
  `bracket_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `id` (`id`,`oauth_id`),
  UNIQUE KEY `oauth_id` (`oauth_id`),
  KEY `team_captain_id` (`captain_id`),
  KEY `bracket_id` (`bracket_id`),
  CONSTRAINT `team_captain_id` FOREIGN KEY (`captain_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `teams_ibfk_1` FOREIGN KEY (`bracket_id`) REFERENCES `brackets` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teams`
--

LOCK TABLES `teams` WRITE;
/*!40000 ALTER TABLE `teams` DISABLE KEYS */;
/*!40000 ALTER TABLE `teams` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tokens`
--

DROP TABLE IF EXISTS `tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `tokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(32) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `created` datetime(6) DEFAULT NULL,
  `expiration` datetime(6) DEFAULT NULL,
  `value` varchar(128) DEFAULT NULL,
  `description` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `value` (`value`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `tokens_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tokens`
--

LOCK TABLES `tokens` WRITE;
/*!40000 ALTER TABLE `tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `topics`
--

DROP TABLE IF EXISTS `topics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `topics` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `value` (`value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `topics`
--

LOCK TABLES `topics` WRITE;
/*!40000 ALTER TABLE `topics` DISABLE KEYS */;
/*!40000 ALTER TABLE `topics` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tracking`
--

DROP TABLE IF EXISTS `tracking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `tracking` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(32) DEFAULT NULL,
  `ip` varchar(46) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `date` datetime(6) DEFAULT NULL,
  `target` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `tracking_ibfk_1` (`user_id`),
  CONSTRAINT `tracking_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tracking`
--

LOCK TABLES `tracking` WRITE;
/*!40000 ALTER TABLE `tracking` DISABLE KEYS */;
INSERT INTO `tracking` VALUES
(1,NULL,'192.168.65.1',1,'2026-02-26 06:08:14.360748',NULL),
(2,NULL,'172.19.0.1',1,'2026-02-14 21:21:36.669726',NULL),
(3,NULL,'10.242.242.46',1,'2026-03-27 04:11:25.219395',NULL),
(4,NULL,'10.242.1.25',1,'2026-03-10 01:19:13.745659',NULL),
(5,NULL,'10.242.1.25',1,'2026-03-10 00:07:09.581430',NULL),
(6,NULL,'192.168.8.176',1,'2026-03-20 01:37:29.162232',NULL);
/*!40000 ALTER TABLE `tracking` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `unlocks`
--

DROP TABLE IF EXISTS `unlocks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `unlocks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `team_id` int(11) DEFAULT NULL,
  `target` int(11) DEFAULT NULL,
  `date` datetime(6) DEFAULT NULL,
  `type` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `unlocks_ibfk_1` (`team_id`),
  KEY `unlocks_ibfk_2` (`user_id`),
  CONSTRAINT `unlocks_ibfk_1` FOREIGN KEY (`team_id`) REFERENCES `teams` (`id`) ON DELETE CASCADE,
  CONSTRAINT `unlocks_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `unlocks`
--

LOCK TABLES `unlocks` WRITE;
/*!40000 ALTER TABLE `unlocks` DISABLE KEYS */;
INSERT INTO `unlocks` VALUES
(1,1,NULL,1,'2026-01-21 22:12:35.906096','hints'),
(2,1,NULL,2,'2026-02-26 06:27:01.089231','hints');
/*!40000 ALTER TABLE `unlocks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `oauth_id` int(11) DEFAULT NULL,
  `name` varchar(128) DEFAULT NULL,
  `password` varchar(128) DEFAULT NULL,
  `email` varchar(128) DEFAULT NULL,
  `type` varchar(80) DEFAULT NULL,
  `secret` varchar(128) DEFAULT NULL,
  `website` varchar(128) DEFAULT NULL,
  `affiliation` varchar(128) DEFAULT NULL,
  `country` varchar(32) DEFAULT NULL,
  `hidden` tinyint(1) DEFAULT NULL,
  `banned` tinyint(1) DEFAULT NULL,
  `verified` tinyint(1) DEFAULT NULL,
  `team_id` int(11) DEFAULT NULL,
  `created` datetime(6) DEFAULT NULL,
  `language` varchar(32) DEFAULT NULL,
  `bracket_id` int(11) DEFAULT NULL,
  `change_password` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `id` (`id`,`oauth_id`),
  UNIQUE KEY `oauth_id` (`oauth_id`),
  KEY `team_id` (`team_id`),
  KEY `bracket_id` (`bracket_id`),
  CONSTRAINT `users_ibfk_1` FOREIGN KEY (`team_id`) REFERENCES `teams` (`id`),
  CONSTRAINT `users_ibfk_2` FOREIGN KEY (`bracket_id`) REFERENCES `brackets` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES
(1,NULL,'thebeards','$bcrypt-sha256$v=2,t=2b,r=12$1IIGeQwOCvTiP.misvZW3.$DsWhPnSDkmJc0ekZLsfzeCurCnJMni6','na@null.com','admin',NULL,NULL,NULL,NULL,1,0,0,NULL,'2026-01-21 21:04:24.340389',NULL,NULL,0);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-03-28  4:59:28
