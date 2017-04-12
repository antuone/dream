<?php
ini_set('error_reporting', E_ALL);
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);

# Запретить кеширование!
header("Content-Type: application/json");

# Скрипт авторизации пользователя
# Принимает через POST email and password
# Если все хорошо возвращает JSON данные пользователя

# Соединямся с БД
include_once $_SERVER['DOCUMENT_ROOT'].'/php/properties.php';
include_once $_SERVER['DOCUMENT_ROOT'].'/php/functions.php';
$con = new mysqli($host, $user, $password, $dbname, $port, $socket)
	or die ('Could not connect to the database server' . mysqli_connect_error());

$err = array();
$REALESTATES = [];

# проверям почту
if(filter_var($_POST['email'], FILTER_VALIDATE_EMAIL)) {

    $passhash = md5(md5($_POST['password']));

    # проверяем, не сущестует ли пользователя с такой почтой
    $query = "SELECT `ID`, `PASSWORD`, `CONFIRMED` FROM `realestate`.`USER` WHERE `EMAIL`='"
    . $_POST['email'] . "' and `PASSWORD`='" . $passhash . "'";
    
    $result = $con->query($query);
	
	# если такой пользователь есть, обновляем хеш и куки
	# отправляем нужные данные
    if($USER = $result->fetch_object()) {
        $HASH = md5(generateCode(mt_rand(11,77)));
		
        $query = "UPDATE `realestate`.`USER` SET `HASH`='$HASH' WHERE `PASSWORD`='".
					$USER->PASSWORD."' and `EMAIL` = '" . $_POST["email"] . "'";
        $con->query($query);
        
 		setcookie("ID", $USER->ID, $TIMECOOCKIE, '/');
		setcookie("HASH", $HASH, $TIMECOOCKIE, '/');
		
		$err['CONFIRMED'] = $USER->CONFIRMED;
		$err['ID'] = $USER->ID;
		$err['EMAIL'] = $_POST["email"];
		$err['ДОСТУП'] = "РАЗРЕШЕН";

		$query = "SELECT ИДЕНТИФИКАТОР, NAME, DEAL, ИМУЩЕСТВО FROM НЕДВИЖИМОСТЬ WHERE IDUSER = " . $USER->ID;
		if ($result1 = $con->query($query)) {
			while($НЕДВИЖИМОСТЬ = $result1->fetch_assoc()) {
				$REALESTATES[] = $НЕДВИЖИМОСТЬ;
			}
			$result1->free();
		}

    } else {
        $err[] = "Email или пароль не верны";
    }

} else {
    
    $err[] = "Введен не правельный email";

}
if (count($REALESTATES) > 0) {
	$err['НЕДВИЖИМОСТЬ'] = $REALESTATES;
}
# отправляем в клиент сообщения в формате JSON
echo json_encode($err, JSON_UNESCAPED_UNICODE | JSON_FORCE_OBJECT);



?>