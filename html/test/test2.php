<?php

$start = microtime(true);
ini_set('error_reporting', E_ALL);
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);


# Соединямся с БД
include_once $_SERVER['DOCUMENT_ROOT'].'/php/properties.php';
$dbname = 'realestate';
$con = new mysqli($host, $user, $password, $dbname, $port, $socket)
    or die ('Could not connect to the database server' . mysqli_connect_error());
    
# отменить жесткие запреты
$con->query("SET sql_mode = 'ONLY_FULL_GROUP_BY,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION'");


$query = "INSERT INTO `realestate`.`НЕДВИЖИМОСТЬ` (`IDUSER`, `IDPLACE`, `NAME`, `DEAL`, `DEALTESTDRIVE`, `ИМУЩЕСТВО`,
    `ЦЕНА`, `CURRENCY`, `CASH`, `CARD`, `PREPAYMENT`, `ELECTRONMONEY`,
    `CADASTRNUMBER`, `ISDOCUMENT`, `ENGINEERING`, `BESIDE`, `NUMBER`)
    VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";

$stmt = $con->prepare($query);


    
/*
$IDUSER
$IDPLACE
$NAME
$DEAL
$DEALTESTDRIVE
$ИМУЩЕСТВО
$ЦЕНА
$CURRENCY
$CASH
$CARD
$PREPAYMENT
$ELECTRONMONEY
$CADASTRNUMBER
$ISDOCUMENT
$ENGINEERING
$BESIDE
$NUMBER
*/  
    
//АТРИБУТЫ
//SET('ISDOCUMENT', 'ELECTRONMONEY', 'PREPAYMENT', 'CARD', 'CASH', 'DEALTESTDRIVE', 'ENGINEERINGELECTRICITY', 'ENGINEERINGHEATING', 'ENGINEERINGHOTWATER', 'ENGINEERINGCOLDWATER', 'ENGINEERINGGAS', 'ENGINEERINGVENTILATION', 'ENGINEERINGSEWERAGE', 'ENGINEERINGELEVATOR', 'ENGINEERINGINTERNET','BESIDEPARKINGUNDERGROUND', 'BESIDEPARKINGLOT', 'BESIDEPARKINGMULTILEVEL', 'BESIDEPARKINGCOVERED', 'BESIDEPARKINGPROTECTION', 'BESIDEGOODTRANSPORTINTERCHANGE')


//ENUM('RUBLE, DOLLAR, EURO)
//ENUM('₽','$','€')


//ENUM('APARTMENT','HOUSE','PARCEL','GARAGE','ROOM','HOTEL','OTHER')

//ENUM('SELL','BUY','EXCHANGE','RENT','FORRENT')

//ENUM('SELL','BUY','EXCHANGE','SELLRENT','BUYRENT')


for ($k = 0; $k < 1000000; $k++) {

    for ($i = 1; $i <= 30; $i++) {
        $array[$i] = mt_rand(0,1);
    }
    
    if ( ! $stmt->execute()) echo $stmt->error;
    
    
    
    for ($i = 1, $s =''; $i <= 30; $i++) {
        $s .= $array[$i]?$i.',':'';
    }
    
    $s = substr($s, 0, -1);
    
    if ( ! $stmt2->execute()) echo $stmt->error;
    
}	


$stmt->close();
$stmt2->close();
$con->close();



$time = microtime(true) - $start;
printf("\nСкрипт выполнялся %.4F сек.", $time);
?>