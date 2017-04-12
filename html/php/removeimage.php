<?php
# временно включим вывод ошибок
ini_set('error_reporting', E_ALL);
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);

# ПРОВЕРКИ БЕЗОПАСТНОСТИ
if (isset($_POST['ИДЕНТИФИКАТОР']) && ! is_numeric($_POST['ИДЕНТИФИКАТОР'])) {
    
    echo 1;
    exit;
    
}


if ( isset($_COOKIE['ID']) && isset($_COOKIE['HASH']) ) {
    
    # Соединямся с БД
    include_once $_SERVER['DOCUMENT_ROOT'].'/php/properties.php';
    $dbname = 'realestate';
    $con = new mysqli($host, $user, $password, $dbname, $port, $socket)
        or die ('Could not connect to the database server' . mysqli_connect_error());

    
    # проверяем существование пользователя
    $query = "SELECT ID, QUANTITY FROM USER WHERE ID="
    .$con->real_escape_string($_COOKIE['ID']) . " and HASH='"
    .$con->real_escape_string($_COOKIE['HASH'])
    ."' LIMIT 1";
  
    if ($result = $con->query($query)) {
        if( ! $USER = $result->fetch_object()) {
            echo 3;
            exit;
        }
        $result->close();
    }
    
} else {
    echo 4;
    exit;   
}

$number = 0;


# если это удаление у уже существующей недвижимости - узнаем number из БД
# если ноль недвижимостей то и не надо в БД лазить
if (0 < $USER->QUANTITY && isset($_POST['ИДЕНТИФИКАТОР'])) {
    # узнаем number
    $query = "SELECT NUMBER FROM НЕДВИЖИМОСТЬ WHERE ИДЕНТИФИКАТОР='"
    .$_POST['ИДЕНТИФИКАТОР']
    ."' LIMIT 1";
  
    if ($result = $con->query($query)) {
        if ( ! $НЕДВИЖИМОСТЬ = $result->fetch_object()) {
            echo 5;
            exit;
        }
        $result->close();
    }
    $number = $НЕДВИЖИМОСТЬ->NUMBER;
} else {
    
    echo 6;
    exit;
    #иначе если это удаление у не существующей

}


$root = '/var/www/html/photo/' . $_COOKIE['ID'] . '/' . $number;


if (unlink($root  . '/' . $_POST['name'])
	and unlink($root . '/200/'. $_POST['name'])
	and unlink($root . '/600/'. $_POST['name'])) {
	
	echo $_POST['name'] . " Удален \n";

} else {
	
	echo $_POST['name'] . " Не Удален \n";

}




?>