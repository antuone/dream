<?php

/*Выдача улиц*/

include_once $_SERVER['DOCUMENT_ROOT'].'/php/properties.php';

$con = new mysqli($host, $user, $password, $dbname, $port, $socket)
	or die ('Could not connect to the database server' . mysqli_connect_error());

$region = preg_replace('/[^0-9]/','',$_REQUEST['region']);
$district = preg_replace('/[^0-9]/','',$_REQUEST['district']);
$city = preg_replace('/[^0-9]/','',$_REQUEST['city']);
$city_district = preg_replace('/[^0-9]/','',$_REQUEST['city_district']);
$locality = preg_replace('/[^0-9]/','',$_REQUEST['locality']);
    
$query = "SELECT name.name, type.name, street.id FROM street
INNER JOIN name ON name.id = street.id_name
INNER JOIN type ON type.id = street.id_type
WHERE street.id_region = $region";

if ($district > 0) {
	$query .= " AND street.id_district = $district";
}
if ($city > 0) {
	$query .= " AND street.id_city = $city";
}
if ($city_district > 0) {
	$query .= " AND street.id_city_district = $city_district";
}
if ($locality > 0) {
	$query .= " AND street.id_locality = $locality";
}
if ($district == 0 && $city == 0 && $city_district == 0 && $locality == 0) {
	$query .= " AND ISNULL(street.id_district)";
	$query .= " AND ISNULL(street.id_city)";
	$query .= " AND ISNULL(street.id_city_district)";
	$query .= " AND ISNULL(street.id_locality)";
}
if ($district > 0 && $city == 0 && $city_district == 0 && $locality == 0) {
	$query .= " AND ISNULL(street.id_city)";
	$query .= " AND ISNULL(street.id_city_district)";
	$query .= " AND ISNULL(street.id_locality)";
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