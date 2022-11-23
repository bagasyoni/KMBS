<?php

date_default_timezone_set("Asia/Bangkok");

define('DB_NAME', 'db_kmbs');
define('DB_USER', 'root');
define('DB_PASSWORD', 'admin');
define('DB_HOST', 'localhost:3306');

$mysqli =  new mysqli(DB_HOST, DB_USER, DB_PASSWORD, DB_NAME);
