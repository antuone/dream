<?php
ini_set('error_reporting', E_ALL);
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);

header("Content-Type: application/json; charset=utf-8");

# Соединямся с БД
include_once $_SERVER['DOCUMENT_ROOT'].'/php/properties.php';
$con = new mysqli($host, $user, $password, $dbname, $port, $socket)
	or die ('Could not connect to the database server' . mysqli_connect_error());

$USER = [];
$REALESTATES = [];

if (isset($_COOKIE['ID']) && isset($_COOKIE['HASH']) ) {
    # проверяем, не сущестует ли пользователя с такими данными
    $query = "SELECT `ID`, `EMAIL`, `CONFIRMED` FROM `realestate`.`USER` WHERE `ID`='"
        .$con->real_escape_string($_COOKIE['ID']) . "' and `HASH`='"
        .$con->real_escape_string($_COOKIE['HASH']) . "'"
	    .' LIMIT 1';
  
    $REALESTATES = [];
    if ($result = $con->query($query)) {
        if ($USER = $result->fetch_assoc()) {
            $query = "SELECT ИДЕНТИФИКАТОР, DEAL, ИМУЩЕСТВО, SPACETOTAL
                        FROM НЕДВИЖИМОСТЬ WHERE IDUSER = " . $USER['ID'];
            if ($result1 = $con->query($query)) {
                while($НЕДВИЖИМОСТЬ = $result1->fetch_assoc()) {
                    $REALESTATES[] = $НЕДВИЖИМОСТЬ;
                }
				$result1->free();
			}
        } else {
			echo 0;
			exit;
		}
		$result->free();
	}
}
$con->close();

$USER['НЕДВИЖИМОСТЬ'] = $REALESTATES;
echo json_encode($USER, JSON_UNESCAPED_UNICODE | JSON_FORCE_OBJECT);

?>