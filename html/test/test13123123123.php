<?php
# временно включим вывод ошибок
ini_set('error_reporting', E_ALL);
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);

include_once $_SERVER['DOCUMENT_ROOT'].'/php/allowed.php';
include_once $_SERVER['DOCUMENT_ROOT'].'/php/properties.php';
include_once $_SERVER['DOCUMENT_ROOT'].'/php/functions.php';

# соединямся с БД
$con = new mysqli($host, $user, $password, $dbname, $port, $socket);
if ($con->connect_error) error($con->connect_error);

# проверяем существование пользователя
$ALLOWED_USER['ID'] = 'i';
$USER = select($con, $ALLOWED_USER, 'ID, QUANTITY', 'USER',
    ['ID'=>123, 'HASH'=>$_COOKIE['HASH']], 'LIMIT 1')
    or error('Пользователь не найден');

var_dump($USER);
?>