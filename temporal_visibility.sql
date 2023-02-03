/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
use temporal_visibility;
CREATE TABLE `executions_visibility` (
  `namespace_id` char(64) NOT NULL,
  `run_id` char(64) NOT NULL,
  `start_time` datetime(6) NOT NULL,
  `execution_time` datetime(6) NOT NULL,
  `workflow_id` varchar(255) NOT NULL,
  `workflow_type_name` varchar(255) NOT NULL,
  `status` int NOT NULL,
  `close_time` datetime(6) DEFAULT NULL,
  `history_length` bigint DEFAULT NULL,
  `memo` blob,
  `encoding` varchar(64) NOT NULL,
  `task_queue` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`namespace_id`,`run_id`),
  KEY `by_type_start_time` (`namespace_id`,`workflow_type_name`,`status`,`start_time` DESC,`run_id`),
  KEY `by_workflow_id_start_time` (`namespace_id`,`workflow_id`,`status`,`start_time` DESC,`run_id`),
  KEY `by_status_by_start_time` (`namespace_id`,`status`,`start_time` DESC,`run_id`),
  KEY `by_type_close_time` (`namespace_id`,`workflow_type_name`,`status`,`close_time` DESC,`run_id`),
  KEY `by_workflow_id_close_time` (`namespace_id`,`workflow_id`,`status`,`close_time` DESC,`run_id`),
  KEY `by_status_by_close_time` (`namespace_id`,`status`,`close_time` DESC,`run_id`),
  KEY `by_close_time_by_status` (`namespace_id`,`close_time` DESC,`run_id`,`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `schema_update_history` (
  `version_partition` int NOT NULL,
  `year` int NOT NULL,
  `month` int NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `manifest_md5` varchar(64) DEFAULT NULL,
  `new_version` varchar(64) DEFAULT NULL,
  `old_version` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`version_partition`,`year`,`month`,`update_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
INSERT INTO `schema_update_history` VALUES (0,2023,2,'2023-02-03 18:17:45.850791','initial version','','0.0','0'),(0,2023,2,'2023-02-03 18:17:51.221067','base version of visibility schema','698373883c1c0dd44607a446a62f2a79','1.0','0.0'),(0,2023,2,'2023-02-03 18:17:51.230583','add close time & status index','e286f8af0a62e291b35189ce29d3fff3','1.1','1.0');
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `schema_version` (
  `version_partition` int NOT NULL,
  `db_name` varchar(255) NOT NULL,
  `creation_time` datetime(6) DEFAULT NULL,
  `curr_version` varchar(64) DEFAULT NULL,
  `min_compatible_version` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`version_partition`,`db_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
INSERT INTO `schema_version` VALUES (0,'temporal_visibility','2023-02-03 18:17:51.229910','1.1','0.1');
