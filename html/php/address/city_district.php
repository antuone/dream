<?php

/*Выдача Городских районов для определенного Города*/

include_once $_SERVER['DOCUMENT_ROOT'].'/php/properties.php';

$con = new mysqli($host, $user, $password, $dbname, $port, $socket)
	or die ('Could not connect to the database server' . mysqli_connect_error());

$city = preg_replace('/[^0-9]/','',$_REQUEST['city']); 
    
    
$query = "SELECT name.name, type.name, city_district.id FROM city_district
INNER JOIN name ON name.id = city_district.id_name
INNER JOIN type ON type.id = city_district.id_type
WHERE city_district.id_city = $city" ;

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