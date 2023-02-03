/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `activity_info_maps` (
  `shard_id` int NOT NULL,
  `namespace_id` binary(16) NOT NULL,
  `workflow_id` varchar(255) NOT NULL,
  `run_id` binary(16) NOT NULL,
  `schedule_id` bigint NOT NULL,
  `data` mediumblob,
  `data_encoding` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`shard_id`,`namespace_id`,`workflow_id`,`run_id`,`schedule_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `buffered_events` (
  `shard_id` int NOT NULL,
  `namespace_id` binary(16) NOT NULL,
  `workflow_id` varchar(255) NOT NULL,
  `run_id` binary(16) NOT NULL,
  `id` bigint NOT NULL AUTO_INCREMENT,
  `data` mediumblob NOT NULL,
  `data_encoding` varchar(16) NOT NULL,
  PRIMARY KEY (`shard_id`,`namespace_id`,`workflow_id`,`run_id`,`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `child_execution_info_maps` (
  `shard_id` int NOT NULL,
  `namespace_id` binary(16) NOT NULL,
  `workflow_id` varchar(255) NOT NULL,
  `run_id` binary(16) NOT NULL,
  `initiated_id` bigint NOT NULL,
  `data` mediumblob,
  `data_encoding` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`shard_id`,`namespace_id`,`workflow_id`,`run_id`,`initiated_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cluster_membership` (
  `membership_partition` int NOT NULL,
  `host_id` binary(16) NOT NULL,
  `rpc_address` varchar(128) DEFAULT NULL,
  `rpc_port` smallint NOT NULL,
  `role` tinyint NOT NULL,
  `session_start` timestamp NULL DEFAULT '1970-01-01 18:30:01',
  `last_heartbeat` timestamp NULL DEFAULT '1970-01-01 18:30:01',
  `record_expiry` timestamp NULL DEFAULT '1970-01-01 18:30:01',
  PRIMARY KEY (`membership_partition`,`host_id`),
  KEY `role` (`role`,`host_id`),
  KEY `role_2` (`role`,`last_heartbeat`),
  KEY `rpc_address` (`rpc_address`,`role`),
  KEY `last_heartbeat` (`last_heartbeat`),
  KEY `record_expiry` (`record_expiry`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cluster_metadata` (
  `metadata_partition` int NOT NULL,
  `data` mediumblob,
  `data_encoding` varchar(16) NOT NULL DEFAULT 'Proto3',
  `version` bigint NOT NULL DEFAULT '1',
  PRIMARY KEY (`metadata_partition`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cluster_metadata_info` (
  `metadata_partition` int NOT NULL,
  `cluster_name` varchar(255) NOT NULL,
  `data` mediumblob NOT NULL,
  `data_encoding` varchar(16) NOT NULL,
  `version` bigint NOT NULL,
  PRIMARY KEY (`metadata_partition`,`cluster_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `current_executions` (
  `shard_id` int NOT NULL,
  `namespace_id` binary(16) NOT NULL,
  `workflow_id` varchar(255) NOT NULL,
  `run_id` binary(16) NOT NULL,
  `create_request_id` varchar(255) DEFAULT NULL,
  `state` int NOT NULL,
  `status` int NOT NULL,
  `start_version` bigint NOT NULL DEFAULT '0',
  `last_write_version` bigint NOT NULL,
  PRIMARY KEY (`shard_id`,`namespace_id`,`workflow_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `executions` (
  `shard_id` int NOT NULL,
  `namespace_id` binary(16) NOT NULL,
  `workflow_id` varchar(255) NOT NULL,
  `run_id` binary(16) NOT NULL,
  `next_event_id` bigint NOT NULL,
  `last_write_version` bigint NOT NULL,
  `data` mediumblob,
  `data_encoding` varchar(16) NOT NULL,
  `state` mediumblob,
  `state_encoding` varchar(16) NOT NULL,
  `db_record_version` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`shard_id`,`namespace_id`,`workflow_id`,`run_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `history_immediate_tasks` (
  `shard_id` int NOT NULL,
  `category_id` int NOT NULL,
  `task_id` bigint NOT NULL,
  `data` mediumblob NOT NULL,
  `data_encoding` varchar(16) NOT NULL,
  PRIMARY KEY (`shard_id`,`category_id`,`task_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `history_node` (
  `shard_id` int NOT NULL,
  `tree_id` binary(16) NOT NULL,
  `branch_id` binary(16) NOT NULL,
  `node_id` bigint NOT NULL,
  `txn_id` bigint NOT NULL,
  `data` mediumblob NOT NULL,
  `data_encoding` varchar(16) NOT NULL,
  `prev_txn_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`shard_id`,`tree_id`,`branch_id`,`node_id`,`txn_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `history_scheduled_tasks` (
  `shard_id` int NOT NULL,
  `category_id` int NOT NULL,
  `visibility_timestamp` datetime(6) NOT NULL,
  `task_id` bigint NOT NULL,
  `data` mediumblob NOT NULL,
  `data_encoding` varchar(16) NOT NULL,
  PRIMARY KEY (`shard_id`,`category_id`,`visibility_timestamp`,`task_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `history_tree` (
  `shard_id` int NOT NULL,
  `tree_id` binary(16) NOT NULL,
  `branch_id` binary(16) NOT NULL,
  `data` mediumblob,
  `data_encoding` varchar(16) NOT NULL,
  PRIMARY KEY (`shard_id`,`tree_id`,`branch_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `namespace_metadata` (
  `partition_id` int NOT NULL,
  `notification_version` bigint NOT NULL,
  PRIMARY KEY (`partition_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
INSERT INTO `namespace_metadata` VALUES (54321,1);
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `namespaces` (
  `partition_id` int NOT NULL,
  `id` binary(16) NOT NULL,
  `name` varchar(255) NOT NULL,
  `notification_version` bigint NOT NULL,
  `data` mediumblob,
  `data_encoding` varchar(16) NOT NULL,
  `is_global` tinyint(1) NOT NULL,
  PRIMARY KEY (`partition_id`,`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `queue` (
  `queue_type` int NOT NULL,
  `message_id` bigint NOT NULL,
  `message_payload` mediumblob,
  `message_encoding` varchar(16) NOT NULL DEFAULT 'Json',
  PRIMARY KEY (`queue_type`,`message_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `queue_metadata` (
  `queue_type` int NOT NULL,
  `data` mediumblob,
  `data_encoding` varchar(16) NOT NULL DEFAULT 'Json',
  `version` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`queue_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `replication_tasks` (
  `shard_id` int NOT NULL,
  `task_id` bigint NOT NULL,
  `data` mediumblob,
  `data_encoding` varchar(16) NOT NULL,
  PRIMARY KEY (`shard_id`,`task_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `replication_tasks_dlq` (
  `source_cluster_name` varchar(255) NOT NULL,
  `shard_id` int NOT NULL,
  `task_id` bigint NOT NULL,
  `data` mediumblob,
  `data_encoding` varchar(16) NOT NULL,
  PRIMARY KEY (`source_cluster_name`,`shard_id`,`task_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `request_cancel_info_maps` (
  `shard_id` int NOT NULL,
  `namespace_id` binary(16) NOT NULL,
  `workflow_id` varchar(255) NOT NULL,
  `run_id` binary(16) NOT NULL,
  `initiated_id` bigint NOT NULL,
  `data` mediumblob,
  `data_encoding` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`shard_id`,`namespace_id`,`workflow_id`,`run_id`,`initiated_id`)
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
INSERT INTO `schema_update_history` VALUES (0,2023,2,'2023-02-03 18:16:30.264844','initial version','','0.0','0'),(0,2023,2,'2023-02-03 18:16:39.850372','base version of schema','55b84ca114ac34d84bdc5f52c198fa33','1.0','0.0'),(0,2023,2,'2023-02-03 18:16:39.866165','schema update for cluster metadata','58f06841bbb187cb210db32a090c21ee','1.1','1.0'),(0,2023,2,'2023-02-03 18:16:40.132408','schema update for RPC replication and blob size adjustments','d0980c1ffb9ffa6e3ab6f84e285ffa9d','1.2','1.1'),(0,2023,2,'2023-02-03 18:16:40.136145','schema update for kafka deprecation','3beee7d470421674194475f94b58d89b','1.3','1.2'),(0,2023,2,'2023-02-03 18:16:40.143357','schema update for cluster metadata cleanup','c53e2e9cea5660c8a1f3b2ac73cdb138','1.4','1.3'),(0,2023,2,'2023-02-03 18:16:40.159232','schema update for cluster_membership, executions and history_node tables','bfb307ba10ac0fdec83e0065dc5ffee4','1.5','1.4'),(0,2023,2,'2023-02-03 18:16:40.162896','schema update for queue_metadata','978e1a6500d377ba91c6e37e5275a59b','1.6','1.5'),(0,2023,2,'2023-02-03 18:16:40.172045','create cluster metadata info table to store cluster information and executions to store tiered storage queue','366b8b49d6701a6a09778e51ad1682ed','1.7','1.6'),(0,2023,2,'2023-02-03 18:16:40.181069','drop unused tasks table; expand VARCHAR columns governed by maxIDLength to VARCHAR(255)','bc0761b792a339f7e1e29e00c4fd3e64','1.8','1.7'),(0,2023,2,'2023-02-03 18:16:40.187970','add history tasks table','b62e4e5826967e152e00b75da42d12ea','1.9','1.8');
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
INSERT INTO `schema_version` VALUES (0,'temporal','2023-02-03 18:16:40.187539','1.9','1.0');
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `shards` (
  `shard_id` int NOT NULL,
  `range_id` bigint NOT NULL,
  `data` mediumblob,
  `data_encoding` varchar(16) NOT NULL,
  PRIMARY KEY (`shard_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `signal_info_maps` (
  `shard_id` int NOT NULL,
  `namespace_id` binary(16) NOT NULL,
  `workflow_id` varchar(255) NOT NULL,
  `run_id` binary(16) NOT NULL,
  `initiated_id` bigint NOT NULL,
  `data` mediumblob,
  `data_encoding` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`shard_id`,`namespace_id`,`workflow_id`,`run_id`,`initiated_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `signals_requested_sets` (
  `shard_id` int NOT NULL,
  `namespace_id` binary(16) NOT NULL,
  `workflow_id` varchar(255) NOT NULL,
  `run_id` binary(16) NOT NULL,
  `signal_id` varchar(255) NOT NULL,
  PRIMARY KEY (`shard_id`,`namespace_id`,`workflow_id`,`run_id`,`signal_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `task_queues` (
  `range_hash` int unsigned NOT NULL,
  `task_queue_id` varbinary(272) NOT NULL,
  `range_id` bigint NOT NULL,
  `data` mediumblob,
  `data_encoding` varchar(16) NOT NULL,
  PRIMARY KEY (`range_hash`,`task_queue_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tasks` (
  `range_hash` int unsigned NOT NULL,
  `task_queue_id` varbinary(272) NOT NULL,
  `task_id` bigint NOT NULL,
  `data` mediumblob,
  `data_encoding` varchar(16) NOT NULL,
  PRIMARY KEY (`range_hash`,`task_queue_id`,`task_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `timer_info_maps` (
  `shard_id` int NOT NULL,
  `namespace_id` binary(16) NOT NULL,
  `workflow_id` varchar(255) NOT NULL,
  `run_id` binary(16) NOT NULL,
  `timer_id` varchar(255) NOT NULL,
  `data` mediumblob,
  `data_encoding` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`shard_id`,`namespace_id`,`workflow_id`,`run_id`,`timer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `timer_tasks` (
  `shard_id` int NOT NULL,
  `visibility_timestamp` datetime(6) NOT NULL,
  `task_id` bigint NOT NULL,
  `data` mediumblob,
  `data_encoding` varchar(16) NOT NULL,
  PRIMARY KEY (`shard_id`,`visibility_timestamp`,`task_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transfer_tasks` (
  `shard_id` int NOT NULL,
  `task_id` bigint NOT NULL,
  `data` mediumblob,
  `data_encoding` varchar(16) NOT NULL,
  PRIMARY KEY (`shard_id`,`task_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `visibility_tasks` (
  `shard_id` int NOT NULL,
  `task_id` bigint NOT NULL,
  `data` mediumblob NOT NULL,
  `data_encoding` varchar(16) NOT NULL,
  PRIMARY KEY (`shard_id`,`task_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
