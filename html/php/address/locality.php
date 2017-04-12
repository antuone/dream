<?php

/*Выдача населенных пунктов*/

include_once $_SERVER['DOCUMENT_ROOT'].'/php/properties.php';

$con = new mysqli($host, $user, $password, $dbname, $port, $socket)
	or die ('Could not connect to the database server' . mysqli_connect_error());

$region = preg_replace('/[^0-9]/','',$_REQUEST['region']);
$district = preg_replace('/[^0-9]/','',$_REQUEST['district']);
$city = preg_replace('/[^0-9]/','',$_REQUEST['city']);
    
    
$query = "SELECT name.name, type.name, locality.id FROM locality
INNER JOIN name ON name.id = locality.id_name
INNER JOIN type ON type.id = locality.id_type
WHERE locality.id_region = $region";

if($district > 0) {
	$query .= " AND locality.id_district = $district";
}
if($city > 0) {
	$query .= " AND locality.id_city = $city";
}
if($district == 0) {
	$query .= " AND ISNULL(locality.id_district)";
}
if($city == 0) {
	$query .= " AND ISNULL(locality.id_city)";
}

$query .= " ORDER BY name.name";

$result = "";
if ($stmt = $con->prepare($query)) {
    $stmt->execute();
    $stmt->bind_result($name, $type, $id);
    while ($stmt->fetch()) {
        $result .= "$name $type,$id,";
    }
    $stmt->close();
}

echo substr($result, 0, strlen($result)-1);

$con->close();
?>