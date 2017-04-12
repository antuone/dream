<?php

/*Выдача Городов для определенного Региона*/

include_once $_SERVER['DOCUMENT_ROOT'].'/php/properties.php';

$con = new mysqli($host, $user, $password, $dbname, $port, $socket)
	or die ('Could not connect to the database server' . mysqli_connect_error());

$region = preg_replace('/[^0-9]/','',$_REQUEST['region']); 
$district = preg_replace('/[^0-9]/','',$_REQUEST['district']); 
    
$query = "SELECT name.name, type.name, city.id FROM city
INNER JOIN name ON name.id = city.id_name
INNER JOIN type on type.id = city.id_type
WHERE city.id_region = $region";

if ($district>0) {
	$query .= " AND city.id_district = $district";
}

$query .= " ORDER BY name.name";

$cities = "";
if ($stmt = $con->prepare($query)) {
    $stmt->execute();
    $stmt->bind_result($name, $type, $id);
    while ($stmt->fetch()) {
        $cities .= "$name $type,$id,";
    }
    $stmt->close();
}

echo substr($cities, 0, strlen($cities)-1);

$con->close();
?>