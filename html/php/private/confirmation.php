<?php

# Соединямся с БД
include_once $_SERVER['DOCUMENT_ROOT'].'/php/properties.php';
$dbname = 'realestate';
$con = new mysqli($host, $user, $password, $dbname, $port, $socket)
	or die ('Could not connect to the database server' . mysqli_connect_error());

    
$_GET['id'] = $con->real_escape_string($_GET['id']);
$_GET['hash'] = $con->real_escape_string($_GET['hash']);

$query = "SELECT `CONFIRMED` FROM `realestate`.`USER` where `ID` = '". $_GET["id"]
			."' and HASH = '". $_GET["hash"] ."'";
$result = $con->query($query);


$link = "<a href='$HTTPS"."$SITENAME'>$SITENAME</a>";
$style = "style='font-size: 50px'";

# если такая комбнация найдена из id и hash
if ($result->num_rows == 1) {

    foreach($result->fetch_row() as $row) {
        $CONFIRMED = $row['CONFIRMED'];
    }

    if ( $CONFIRMED == 0 ) {
        
        $query = "UPDATE `realestate`.`USER` SET `CONFIRMED`='1' WHERE `HASH`='"
					.$_GET["hash"]."' and `ID` = '" . $_GET["id"] . "'";
        $con->query($query);
    
    	setcookie("ID", $_GET['id'], $TIMECOOCKIE, '/');
		setcookie("HASH", $_GET['hash'], $TIMECOOCKIE, '/');
        
        echo "<p $style>Вы успешно подтвердили email. $link</p>";
    
    } else {
        
        echo "<p $style>Этот email уже подтвержден. $link</p>";
        
    }

} else {
    
    echo "<p $style>Не верная ссылка. $link</p>";
    
}
?>