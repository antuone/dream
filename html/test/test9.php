<?php
$start = microtime(true);
ini_set('error_reporting', E_ALL);
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);

include_once $_SERVER['DOCUMENT_ROOT'].'/php/allowed.php';
include_once $_SERVER['DOCUMENT_ROOT'].'/php/functions.php';

function r0($arr) {
	return $arr[mt_rand(0,count($arr)-1)];
}
function r1($arr) {
	return $arr[mt_rand(1,count($arr)-1)];
}
# Соединямся с БД
include_once $_SERVER['DOCUMENT_ROOT'].'/php/properties.php';
$con = new mysqli($host, $user, $password, $dbname, $port, $socket)
	or die ('Could not connect to the database server' . mysqli_connect_error());

# отменить жесткие запреты
$con->query("SET sql_mode = 'ONLY_FULL_GROUP_BY,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION'");

for ($i = 1; $i <= 7033; $i++) {
	$set = random_set($ALLOWED_REALESTATE['АТРИБУТЫ']);
	$query = "UPDATE `realestate`.`НЕДВИЖИМОСТЬ` SET `АТРИБУТЫ`='$set' WHERE `ИДЕНТИФИКАТОР` = " . $i;
	$con->query($query);
}





$con->close();
$time = microtime(true) - $start;
printf("\nСкрипт выполнялся %.4F сек.", $time);
?>