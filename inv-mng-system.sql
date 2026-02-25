-- MySQL dump 10.13  Distrib 8.0.36, for Linux (x86_64)
--
-- Host: localhost    Database: inv_mng_system
-- ------------------------------------------------------
-- Server version	8.0.45-0ubuntu0.24.04.1

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
-- Table structure for table `cache`
--

DROP TABLE IF EXISTS `cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cache` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`),
  KEY `cache_expiration_index` (`expiration`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache`
--

LOCK TABLES `cache` WRITE;
/*!40000 ALTER TABLE `cache` DISABLE KEYS */;
/*!40000 ALTER TABLE `cache` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cache_locks`
--

DROP TABLE IF EXISTS `cache_locks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cache_locks` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`),
  KEY `cache_locks_expiration_index` (`expiration`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache_locks`
--

LOCK TABLES `cache_locks` WRITE;
/*!40000 ALTER TABLE `cache_locks` DISABLE KEYS */;
/*!40000 ALTER TABLE `cache_locks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `expense_histories`
--

DROP TABLE IF EXISTS `expense_histories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `expense_histories` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `buy_date` datetime NOT NULL,
  `product_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  `unit_price` decimal(15,2) NOT NULL,
  `quantity` int NOT NULL,
  `total_payment` decimal(15,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `expense_histories`
--

LOCK TABLES `expense_histories` WRITE;
/*!40000 ALTER TABLE `expense_histories` DISABLE KEYS */;
INSERT INTO `expense_histories` VALUES (1,'2026-02-24 18:59:18',1,1,100.00,50,5000.00,'2026-02-24 12:59:18','2026-02-24 12:59:18'),(2,'2026-02-24 19:57:35',1,1,110.00,10,1100.00,'2026-02-24 13:57:35','2026-02-24 13:57:35'),(3,'2026-02-24 23:40:58',2,1,30.00,20,600.00,'2026-02-24 17:40:58','2026-02-24 17:40:58'),(4,'2026-02-24 23:51:21',1,1,110.00,4,440.00,'2026-02-24 17:51:21','2026-02-24 17:51:21'),(5,'2026-02-24 23:53:35',2,1,30.00,10,300.00,'2026-02-24 17:53:35','2026-02-24 17:53:35'),(6,'2026-02-25 05:28:46',1,1,110.00,30,3300.00,'2026-02-24 23:28:46','2026-02-24 23:28:46'),(7,'2026-02-25 05:28:52',2,1,30.00,20,600.00,'2026-02-24 23:28:52','2026-02-24 23:28:52'),(8,'2026-02-25 06:19:38',3,1,40.00,24,960.00,'2026-02-25 00:19:38','2026-02-25 00:19:38'),(9,'2026-02-25 06:19:50',3,1,40.00,10,400.00,'2026-02-25 00:19:50','2026-02-25 00:19:50'),(10,'2026-02-25 06:39:05',4,1,120.00,30,3600.00,'2026-02-25 00:39:05','2026-02-25 00:39:05'),(11,'2026-02-25 06:39:18',4,1,120.00,10,1200.00,'2026-02-25 00:39:18','2026-02-25 00:39:18');
/*!40000 ALTER TABLE `expense_histories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `failed_jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `failed_jobs`
--

LOCK TABLES `failed_jobs` WRITE;
/*!40000 ALTER TABLE `failed_jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `failed_jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventories`
--

DROP TABLE IF EXISTS `inventories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inventories` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `available_stock` int NOT NULL DEFAULT '0',
  `total_sold` int NOT NULL DEFAULT '0',
  `total_stock` int NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventories`
--

LOCK TABLES `inventories` WRITE;
/*!40000 ALTER TABLE `inventories` DISABLE KEYS */;
INSERT INTO `inventories` VALUES (1,87,7,94,'2026-02-24 12:59:18','2026-02-24 23:28:46'),(2,48,2,50,'2026-02-24 17:40:58','2026-02-24 23:28:52'),(3,34,0,34,'2026-02-25 00:19:38','2026-02-25 00:19:50'),(4,38,2,40,'2026-02-25 00:39:05','2026-02-25 00:40:34');
/*!40000 ALTER TABLE `inventories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `job_batches`
--

DROP TABLE IF EXISTS `job_batches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `job_batches` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int NOT NULL,
  `pending_jobs` int NOT NULL,
  `failed_jobs` int NOT NULL,
  `failed_job_ids` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext COLLATE utf8mb4_unicode_ci,
  `cancelled_at` int DEFAULT NULL,
  `created_at` int NOT NULL,
  `finished_at` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `job_batches`
--

LOCK TABLES `job_batches` WRITE;
/*!40000 ALTER TABLE `job_batches` DISABLE KEYS */;
/*!40000 ALTER TABLE `job_batches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jobs`
--

DROP TABLE IF EXISTS `jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint unsigned NOT NULL,
  `reserved_at` int unsigned DEFAULT NULL,
  `available_at` int unsigned NOT NULL,
  `created_at` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jobs`
--

LOCK TABLES `jobs` WRITE;
/*!40000 ALTER TABLE `jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (1,'0001_01_01_000000_create_users_table',1),(2,'0001_01_01_000001_create_cache_table',1),(3,'0001_01_01_000002_create_jobs_table',1),(4,'2026_02_24_163044_create_oauth_auth_codes_table',2),(5,'2026_02_24_163045_create_oauth_access_tokens_table',2),(6,'2026_02_24_163046_create_oauth_refresh_tokens_table',2),(7,'2026_02_24_163047_create_oauth_clients_table',2),(8,'2026_02_24_163048_create_oauth_device_codes_table',2),(9,'2026_02_24_164208_create_inventories_table',3),(10,'2026_02_24_164326_create_products_table',3),(11,'2026_02_24_164759_create_stock_histories_table',3),(12,'2026_02_24_164915_create_sales_table',3),(13,'2026_02_24_165135_create_expense_histories_table',3);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth_access_tokens`
--

DROP TABLE IF EXISTS `oauth_access_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oauth_access_tokens` (
  `id` char(80) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `client_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_access_tokens_user_id_index` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth_access_tokens`
--

LOCK TABLES `oauth_access_tokens` WRITE;
/*!40000 ALTER TABLE `oauth_access_tokens` DISABLE KEYS */;
INSERT INTO `oauth_access_tokens` VALUES ('1cdc64eac5d651d821d9991494da0d803ffc39ac1634f81ff1b2dfcb52fa800f6d981bc76e0c5756',1,'019c907d-1bc2-70b1-b89b-8d3a175ff635','E-com','[]',0,'2026-02-24 17:10:39','2026-02-24 17:10:39','2026-08-24 23:10:39'),('242ac3b8fa3bc1bba45b1daf83a462b5fdfc029ef1dda4066926a6e29b8ef241e799b1885bd3c4c3',1,'019c907d-1bc2-70b1-b89b-8d3a175ff635','E-com','[]',0,'2026-02-24 17:06:52','2026-02-24 17:06:53','2026-08-24 23:06:52'),('26bd7329dc7b8356b3f87701d392e74dcfb65de34495471efc92e6f64febcc7a4d2a234ad14dd0da',1,'019c907d-1bc2-70b1-b89b-8d3a175ff635','E-com','[]',0,'2026-02-25 00:11:35','2026-02-25 00:11:35','2026-08-25 06:11:35'),('3309e2f2fd5df019590befc8ad7873967955bf6154739f260fa4b886977ec2d9461165d8f056cc64',1,'019c907d-1bc2-70b1-b89b-8d3a175ff635','E-com','[]',0,'2026-02-25 00:13:09','2026-02-25 00:13:09','2026-08-25 06:13:09'),('382af7645c1e30be44b8cbb0c174b18f8f790000ed8a08c2c5ab60a0b69ef4624ed534edcf68e54d',1,'019c90bb-b76b-7004-931c-2405fd2e25a9',NULL,'[\"*\"]',0,'2026-02-24 11:42:36','2026-02-24 11:42:36','2026-02-24 17:57:36'),('5dfc81496abe4abede1a5e2d9e0f6c6f7abb64d5e9cd27c1a048403146f7b2be73ce58965203dae9',1,'019c907d-1bc2-70b1-b89b-8d3a175ff635','E-com','[]',0,'2026-02-25 00:38:05','2026-02-25 00:38:05','2026-08-25 06:38:05'),('83be990f841730e42aefe8c6eac2e2ec6a135de1c7fb3442a501d567dbc17813a506c68333d93ad0',1,'019c907d-1bc2-70b1-b89b-8d3a175ff635','E-com','[]',0,'2026-02-24 17:05:37','2026-02-24 17:05:37','2026-08-24 23:05:37'),('8e7c244178fd805f5f48d220d2ca6e699969a21f34c0d3fdf0462b1593ef8aff6cd1f81cf3485899',1,'019c907d-1bc2-70b1-b89b-8d3a175ff635','E-com','[]',0,'2026-02-25 00:15:46','2026-02-25 00:15:46','2026-08-25 06:15:46'),('a4a6378b66809af5df89dff815ce6ec0a4c146b5a0c89bef19beb94872987b8c1630d2cdec1c3324',1,'019c907d-1bc2-70b1-b89b-8d3a175ff635','E-com','[]',0,'2026-02-24 17:13:51','2026-02-24 17:13:51','2026-08-24 23:13:51'),('b2f691b64634d176a69b1fd39ad1d29765e0f5a0b6429c0c783f122c908d965946d42ffcb25aa3da',1,'019c907d-1bc2-70b1-b89b-8d3a175ff635','E-com','[]',0,'2026-02-24 17:16:15','2026-02-24 17:16:15','2026-08-24 23:16:15'),('c7b1cadceea4df0d97751f52d7911cdc2b030817cd990bb80ef94dfc55867183b1f1f7ee18a956a6',1,'019c907d-1bc2-70b1-b89b-8d3a175ff635','E-com','[]',0,'2026-02-25 00:16:41','2026-02-25 00:16:41','2026-08-25 06:16:41'),('c861246953b4bdc449e0053bb02e142b6b4f189f0dedd74e05a7f1e67d56e6db9ccd8a97d89f01c3',1,'019c907d-1bc2-70b1-b89b-8d3a175ff635','E-com','[]',0,'2026-02-24 17:10:26','2026-02-24 17:10:26','2026-08-24 23:10:26'),('cec13a41422f628c2506e2be9943cd3a0486bc7f6ce58d6da36446c01506ad8c6fcceb60e3429ccb',1,'019c907d-1bc2-70b1-b89b-8d3a175ff635','E-com','[]',0,'2026-02-24 17:09:18','2026-02-24 17:09:18','2026-08-24 23:09:18'),('ced5806ac6419c40a88eb8ac98f15439083d75dcf6e55ac8ea811c51d53c7e5ebd83531e67b4e973',1,'019c907d-1bc2-70b1-b89b-8d3a175ff635','E-com','[]',0,'2026-02-24 17:08:11','2026-02-24 17:08:11','2026-08-24 23:08:11'),('d8d90078e06f77e33da8a0aaede9f359e82a348d0f26e82ec5d7a7184648c7c38c7e3bc0defcd430',1,'019c907d-1bc2-70b1-b89b-8d3a175ff635','E-com','[]',0,'2026-02-25 00:14:25','2026-02-25 00:14:25','2026-08-25 06:14:25'),('e051a531be741c927b9ac5b548dffc65441790c6536446c8e17631b15b76cc8874817a721d80a11b',1,'019c907d-1bc2-70b1-b89b-8d3a175ff635','E-com','[]',0,'2026-02-25 00:09:52','2026-02-25 00:09:52','2026-08-25 06:09:52'),('e0d1291bf775b1bb642d1ea25fb7ac8cc7c8dece487ed24b0ef161b6178409dcb68de71d920b2da4',1,'019c907d-1bc2-70b1-b89b-8d3a175ff635','E-com','[]',0,'2026-02-25 00:18:35','2026-02-25 00:18:35','2026-08-25 06:18:35'),('f315be2e69ccdcda525b053cccaa33f01a45dcf1792419167e886ad20019361230219304951004da',1,'019c907d-1bc2-70b1-b89b-8d3a175ff635','E-com','[]',0,'2026-02-25 00:08:43','2026-02-25 00:08:43','2026-08-25 06:08:43'),('f5940e396bba640b509d7eae03702bf5790afd00c4444ba63494d8c1f3e0a501781025d11f31bee8',1,'019c907d-1bc2-70b1-b89b-8d3a175ff635','InvMngSystem','[]',0,'2026-02-24 11:25:06','2026-02-24 11:25:06','2026-08-24 17:25:06');
/*!40000 ALTER TABLE `oauth_access_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth_auth_codes`
--

DROP TABLE IF EXISTS `oauth_auth_codes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oauth_auth_codes` (
  `id` char(80) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  `client_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_auth_codes_user_id_index` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth_auth_codes`
--

LOCK TABLES `oauth_auth_codes` WRITE;
/*!40000 ALTER TABLE `oauth_auth_codes` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth_auth_codes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth_clients`
--

DROP TABLE IF EXISTS `oauth_clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oauth_clients` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner_id` bigint unsigned DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `secret` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `provider` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `redirect_uris` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `grant_types` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_clients_owner_type_owner_id_index` (`owner_type`,`owner_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth_clients`
--

LOCK TABLES `oauth_clients` WRITE;
/*!40000 ALTER TABLE `oauth_clients` DISABLE KEYS */;
INSERT INTO `oauth_clients` VALUES ('019c907d-1bc2-70b1-b89b-8d3a175ff635',NULL,NULL,'Laravel','$2y$12$.Xz4CMC1vk6PEvA7p1r3JeBJ1xhpjkieTVngWTpQutVw8N74LeG52',NULL,'[]','[\"personal_access\"]',0,'2026-02-24 10:30:44','2026-02-24 10:30:44'),('019c90bb-b76b-7004-931c-2405fd2e25a9',NULL,NULL,'InvMngSystem','$2y$12$feTodBTmeYuuOoMzG7YNA.a3mULDYvsHGdpqFILi67P.tT.oPyx1K','users','[]','[\"password\",\"refresh_token\"]',0,'2026-02-24 11:39:07','2026-02-24 11:39:07');
/*!40000 ALTER TABLE `oauth_clients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth_device_codes`
--

DROP TABLE IF EXISTS `oauth_device_codes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oauth_device_codes` (
  `id` char(80) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `client_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_code` char(8) COLLATE utf8mb4_unicode_ci NOT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `user_approved_at` datetime DEFAULT NULL,
  `last_polled_at` datetime DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `oauth_device_codes_user_code_unique` (`user_code`),
  KEY `oauth_device_codes_user_id_index` (`user_id`),
  KEY `oauth_device_codes_client_id_index` (`client_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth_device_codes`
--

LOCK TABLES `oauth_device_codes` WRITE;
/*!40000 ALTER TABLE `oauth_device_codes` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth_device_codes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth_refresh_tokens`
--

DROP TABLE IF EXISTS `oauth_refresh_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oauth_refresh_tokens` (
  `id` char(80) COLLATE utf8mb4_unicode_ci NOT NULL,
  `access_token_id` char(80) COLLATE utf8mb4_unicode_ci NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_refresh_tokens_access_token_id_index` (`access_token_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth_refresh_tokens`
--

LOCK TABLES `oauth_refresh_tokens` WRITE;
/*!40000 ALTER TABLE `oauth_refresh_tokens` DISABLE KEYS */;
INSERT INTO `oauth_refresh_tokens` VALUES ('e40912a4dbd58b764411f154bc5c21bb19739151362c5415d7ffe7cde58b5e8502c6e7025ebb1bd5','382af7645c1e30be44b8cbb0c174b18f8f790000ed8a08c2c5ab60a0b69ef4624ed534edcf68e54d',0,'2026-02-24 19:42:36');
/*!40000 ALTER TABLE `oauth_refresh_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_reset_tokens`
--

DROP TABLE IF EXISTS `password_reset_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_reset_tokens`
--

LOCK TABLES `password_reset_tokens` WRITE;
/*!40000 ALTER TABLE `password_reset_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_reset_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint NOT NULL,
  `category` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `buy_price` decimal(15,2) NOT NULL,
  `sell_price` decimal(15,2) NOT NULL,
  `inventory_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `products_inventory_id_unique` (`inventory_id`),
  CONSTRAINT `products_inventory_id_foreign` FOREIGN KEY (`inventory_id`) REFERENCES `inventories` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,'Product One',1,'Type1 Updated',110.00,220.00,1,'2026-02-24 12:59:18','2026-02-24 13:38:33'),(2,'Wireless Mouse',1,'Electronics',30.00,60.00,2,'2026-02-24 17:40:58','2026-02-24 17:40:58'),(3,'keyboard',1,'electronics',40.00,80.00,3,'2026-02-25 00:19:38','2026-02-25 00:19:38'),(4,'monitor',1,'screen',120.00,200.00,4,'2026-02-25 00:39:05','2026-02-25 00:39:05');
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sales`
--

DROP TABLE IF EXISTS `sales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sales` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `product_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  `customer_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `quantity` int NOT NULL,
  `discount_amount` decimal(15,2) NOT NULL DEFAULT '0.00',
  `vat_amount` decimal(15,2) NOT NULL DEFAULT '0.00',
  `total_price` decimal(15,2) NOT NULL,
  `customer_paid_amount` decimal(15,2) NOT NULL,
  `due_amount` decimal(15,2) NOT NULL DEFAULT '0.00',
  `final_payment` decimal(15,2) NOT NULL DEFAULT '0.00',
  `payment_date` datetime NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sales`
--

LOCK TABLES `sales` WRITE;
/*!40000 ALTER TABLE `sales` DISABLE KEYS */;
INSERT INTO `sales` VALUES (1,1,1,'Testa',4,50.00,5.00,880.00,1000.00,0.00,874.00,'2026-02-24 21:19:05','2026-02-24 15:19:05','2026-02-24 15:19:05'),(2,2,1,'Hamzi',2,20.00,3.00,120.00,80.00,23.60,103.60,'2026-02-25 03:54:52','2026-02-24 21:54:52','2026-02-24 21:54:52'),(3,1,1,'Hib',3,40.00,10.00,660.00,700.00,0.00,686.00,'2026-02-25 05:02:02','2026-02-24 23:02:02','2026-02-24 23:02:02'),(4,4,1,'David',2,100.00,7.00,400.00,300.00,28.00,328.00,'2026-02-25 06:40:34','2026-02-25 00:40:34','2026-02-25 00:40:34');
/*!40000 ALTER TABLE `sales` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sessions` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sessions_user_id_index` (`user_id`),
  KEY `sessions_last_activity_index` (`last_activity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sessions`
--

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stock_histories`
--

DROP TABLE IF EXISTS `stock_histories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stock_histories` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `update_date` datetime NOT NULL,
  `stock_quantity` int NOT NULL,
  `product_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  `status` enum('added','sold') COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stock_histories`
--

LOCK TABLES `stock_histories` WRITE;
/*!40000 ALTER TABLE `stock_histories` DISABLE KEYS */;
INSERT INTO `stock_histories` VALUES (1,'2026-02-24 18:59:18',50,1,1,'added','2026-02-24 12:59:18','2026-02-24 12:59:18'),(2,'2026-02-24 19:57:35',10,1,1,'added','2026-02-24 13:57:35','2026-02-24 13:57:35'),(3,'2026-02-24 21:19:05',4,1,1,'sold','2026-02-24 15:19:05','2026-02-24 15:19:05'),(4,'2026-02-24 23:40:58',20,2,1,'added','2026-02-24 17:40:58','2026-02-24 17:40:58'),(5,'2026-02-24 23:51:21',4,1,1,'added','2026-02-24 17:51:21','2026-02-24 17:51:21'),(6,'2026-02-24 23:53:35',10,2,1,'added','2026-02-24 17:53:35','2026-02-24 17:53:35'),(7,'2026-02-25 03:54:52',2,2,1,'sold','2026-02-24 21:54:52','2026-02-24 21:54:52'),(8,'2026-02-25 05:02:02',3,1,1,'sold','2026-02-24 23:02:02','2026-02-24 23:02:02'),(9,'2026-02-25 05:28:46',30,1,1,'added','2026-02-24 23:28:46','2026-02-24 23:28:46'),(10,'2026-02-25 05:28:52',20,2,1,'added','2026-02-24 23:28:52','2026-02-24 23:28:52'),(11,'2026-02-25 06:19:38',24,3,1,'added','2026-02-25 00:19:38','2026-02-25 00:19:38'),(12,'2026-02-25 06:19:50',10,3,1,'added','2026-02-25 00:19:50','2026-02-25 00:19:50'),(13,'2026-02-25 06:39:05',30,4,1,'added','2026-02-25 00:39:05','2026-02-25 00:39:05'),(14,'2026-02-25 06:39:18',10,4,1,'added','2026-02-25 00:39:18','2026-02-25 00:39:18'),(15,'2026-02-25 06:40:34',2,4,1,'sold','2026-02-25 00:40:34','2026-02-25 00:40:34');
/*!40000 ALTER TABLE `stock_histories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'TestName','test@email.test',NULL,'$2y$12$nhjImI4RYX4abaSgiYrqRe.wtUNGSPRN564oKk.1ieTFB8awSgebO',NULL,'2026-02-24 11:25:06','2026-02-24 11:25:06');
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

-- Dump completed on 2026-02-25 13:35:50
