<?php

# Соединямся с БД
include_once $_SERVER['DOCUMENT_ROOT'].'/php/properties.php';
$dbname = 'realestate';
$con = new mysqli($host, $user, $password, $dbname, $port, $socket)
	or die ('Could not connect to the database server' . mysqli_connect_error());

    
$_COOKIE['ID'] = $con->real_escape_string($_COOKIE['ID']);
$_COOKIE['HASH'] = $con->real_escape_string($_COOKIE['HASH']);

$query = "SELECT `EMAIL` FROM `realestate`.`USER` where ID = '"
		. $_COOKIE['ID'] ."' and HASH = '". $_COOKIE["HASH"] ."'";
		
$result = $con->query($query);

if ($result->num_rows == 1) {

	$EMAIL = $result->fetch_object()->EMAIL;

	$body = $HTTPS . $SITENAME
			. "/confirmation.php?id=".$_COOKIE['ID']
			. "&hash=".$_COOKIE['HASH'];
	
	if ( mail($EMAIL,
		"Подтверждение аккаунта",
		$body,
		"From:no-reply@$SITENAME")) {
		
		echo "Отправлено!";
	} else {
		echo "Не отправлено";
	}
} else {
	echo "Утютю!";
}


    
?>