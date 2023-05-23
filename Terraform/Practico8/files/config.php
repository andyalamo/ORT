<?php
  ini_set('display_errors', 1);
  error_reporting(-1);
  define('DB_HOST', '${rds_endpoint}');
  define('DB_USER', '${rds_user}');
  define('DB_PASSWORD', '${rds_password}');
  define('DB_DATABASE', '${rds_dbname}');
?>
