<?php

/*Выдача из базы всех регионов*/

include_once $_SERVER['DOCUMENT_ROOT'].'/php/properties.php';
$con = new mysqli($host, $user, $password, $dbname, $port, $socket)
	or die ('Could not connect to the database server' . mysqli_connect_error());

$query = "select name.name, type.name, region.code from region
inner join name on name.id = region.id_name
inner join type on type.id = region.id_type
order by name.name";

$regions = "var regions = [";
if ($stmt = $con->prepare($query)) {
    $stmt->execute();
    $stmt->bind_result($name, $type, $code);
    while ($stmt->fetch()) {
        $regions .= "\"$name $type\",$code,";
    }
    $stmt->close();
}
echo substr($regions, 0, strlen($regions)-1) . "];";
$con->close();
?>