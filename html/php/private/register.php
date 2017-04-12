<?php
# Скрипт регситрации нового пользователя
# временно включим вывод ошибок
ini_set('error_reporting', E_ALL);
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);

# Соединямся с БД
include_once $_SERVER['DOCUMENT_ROOT'].'/php/properties.php';
include_once $_SERVER['DOCUMENT_ROOT'].'/php/functions.php';
$dbname = 'realestate';
$con = new mysqli($host, $user, $password, $dbname, $port, $socket)
	or die ('Could not connect to the database server' . mysqli_connect_error());

$err = array();

# проверям почту
if(filter_var($_POST['email'], FILTER_VALIDATE_EMAIL)) {

    # проверяем, не сущестует ли пользователя с такой почтой
    $query = "SELECT COUNT(`ID`) as 'ID' FROM `realestate`.`USER` WHERE `EMAIL`='" . $_POST['email'] . "'";
    
    $stmt = $con->query($query);
    
	$ID = $stmt->fetch_object()->ID;
    
    if($ID) {
        
        $err[] = "Пользователь с таким email уже существует";
    
    }

} else {
    
    $err[] = "Введен не правельный email";

}

# проверяем пароль
if(strlen($_POST['password']) < 8 or strlen($_POST['password']) > 45) {

    $err[] = "Пароль должен быть не меньше 8 символов и не больше 45";

}

# Если нет ошибок, то добавляем в БД нового пользователя
if(count($err) == 0) {
	$HASH = md5(generateCode(77));
    # Делаем двойное шифрование
    $_POST['password'] = md5(md5(trim($_POST['password'])));
    $con->query("INSERT INTO USER SET EMAIL='". $_POST['email']. "', PASSWORD='". $_POST['password'] ."', HASH='$HASH'");
    
	$body = $HTTPS . $SITENAME . "/confirmation.php?id=" . $ID . "&hash=" . $HASH;
    if ( mail($_POST['email'],
		"Подтверждение аккаунта",
		$body,
		"From:no-reply@$SITENAME")) {
		
		$err[] = "На почту " . $_POST['email'] . " отправлено письмо для подтверждения аккаунта";
		$ID = $con->insert_id;
		
		setcookie("ID", $ID, $TIMECOOCKIE, '/');
		setcookie("HASH", $HASH, $TIMECOOCKIE, '/');
		
		$err['CONFIRMED'] = 0;
		$err['ID'] = $ID;
		$err['EMAIL'] = $_POST['email'];
		$err['PRIVATEOFFICE'] = "WELCOME";
	} else {
		
		$err[] = "Что-то пошло не так и письмо не отправлено";
		
	}
}

# отправляем в клиент сообщения в формате JSON
echo json_encode($err, JSON_UNESCAPED_UNICODE | JSON_FORCE_OBJECT);


?>