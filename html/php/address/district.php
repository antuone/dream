<?php

/*Выдача Районов для определенного Региона*/

include_once $_SERVER['DOCUMENT_ROOT'].'/php/properties.php';

$con = new mysqli($host, $user, $password, $dbname, $port, $socket)
	or die ('Could not connect to the database server' . mysqli_connect_error());

$region = preg_replace('/[^0-9]/','',$_REQUEST['region']); 
    
    
$query = "SELECT name.name, type.name, district.id FROM district
INNER JOIN name ON name.id = district.id_name
INNER JOIN type on type.id = district.id_type
WHERE district.id_region = $region";

$districts = "";
if ($stmt = $con->prepare($query)) {
    $stmt->execute();
    $stmt->bind_result($name, $type, $id);
    while ($stmt->fetch()) {
        $districts .= "$name $type,$id,";
    }
    $stmt->close();
}

echo substr($districts, 0, strlen($districts)-1);

$con->close();
?>