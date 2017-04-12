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


$query = "INSERT INTO `realestate`.`TEST2` (`1`, `2`, `3`, `4`, `5`, `6`, `7`, `8`, `9`, `10`, `11`, `12`, `13`, `14`, `15`, `16`, `17`, `18`, `19`, `20`, `21`, `22`, `23`, `24`, `25`, `26`, `27`, `28`, `29`, `30`)
VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?);";

$stmt = $con->prepare($query);

$stmt->bind_param('iiiiiiiiiiiiiiiiiiiiiiiiiiiiii',
    $array[1],$array[2],$array[3],$array[4],$array[5],$array[6],$array[7],$array[8],$array[9],
    $array[10],$array[11],$array[12],$array[13],$array[14],$array[15],$array[16],$array[17],$array[18],$array[19],
    $array[20],$array[21],$array[22],$array[23],$array[24],$array[25],$array[26],$array[27],$array[28],$array[29],
    $array[30]);

$query = "INSERT INTO `realestate`.`TEST1` (`SET`) VALUES(?)";

$stmt2 = $con->prepare($query);

$stmt2->bind_param('s', $s);

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