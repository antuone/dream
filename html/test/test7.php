<?php
$start = microtime(true);
ini_set('error_reporting', E_ALL);
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);

include_once $_SERVER['DOCUMENT_ROOT'].'/php/allowed.php';
include_once $_SERVER['DOCUMENT_ROOT'].'/php/functions.php';
include_once $_SERVER['DOCUMENT_ROOT'].'/street.php';

# Соединямся с БД
include_once $_SERVER['DOCUMENT_ROOT'].'/php/properties.php';
$con = new mysqli($host, $user, $password, $dbname, $port, $socket)
	or die ('Could not connect to the database server' . mysqli_connect_error());

# отменить жесткие запреты
$con->query("SET sql_mode = 'ONLY_FULL_GROUP_BY,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION'");



$myCurl = curl_init();

for ($i = 0; $i < 100; $i++) {

	$number_house = mt_rand(1,25);
	$street2 = $street[mt_rand(0, 1330)];
	$city2 = $city[mt_rand(0, 80)];
	$address = "$number_house+$street2,+$city2,+Россия";

	curl_setopt_array($myCurl, array(
		CURLOPT_URL => 'https://maps.googleapis.com/maps/api/geocode/json?address='.
		$address.
		'&key=AIzaSyB0YaMfsWh0MyCN_khjY_qLRe6Cli234so&language=ru',
		CURLOPT_RETURNTRANSFER => true,
		CURLOPT_POST => true,
		CURLOPT_POSTFIELDS => http_build_query([])
	));
	$response = curl_exec($myCurl);
	
	$response = json_decode($response, true);
	
	if ($response['status'] != 'OK') {
		echo 0;
		continue;
	}
	
	$ДАННЫЕ['PLACE'] = $response['results'][0];
	
	//print_r($ДАННЫЕ['PLACE']);
	# флаг - есть такое место или нет
	$ISPLACE = false;
	
	# проверяем существование места
	$query = "SELECT IDPLACE FROM PLACE WHERE place_id='"
		.$con->real_escape_string($ДАННЫЕ['PLACE']['place_id'])
		."' LIMIT 1";
	
	if ($result = $con->query($query)) {
		if ($PLACE = $result->fetch_object()) {
			$ISPLACE = true;
			$IDPLACE = $PLACE->IDPLACE;
			//printf("Такое место есть.\n");
		}
		$result->close();
	}
	
	$ДАННЫЕ['PLACE']['lat'] = $ДАННЫЕ['PLACE']['geometry']['location']['lat'];
	$ДАННЫЕ['PLACE']['lng'] = $ДАННЫЕ['PLACE']['geometry']['location']['lng'];
	
	$ДАННЫЕ['PLACE']['north'] = $ДАННЫЕ['PLACE']['geometry']['viewport']['northeast']['lat'];
	$ДАННЫЕ['PLACE']['east'] = $ДАННЫЕ['PLACE']['geometry']['viewport']['northeast']['lng'];
	$ДАННЫЕ['PLACE']['south'] = $ДАННЫЕ['PLACE']['geometry']['viewport']['southwest']['lat'];
	$ДАННЫЕ['PLACE']['west'] = $ДАННЫЕ['PLACE']['geometry']['viewport']['southwest']['lng'];
	
	$ДАННЫЕ['PLACE']['location_type'] = $ДАННЫЕ['PLACE']['geometry']['location_type'];
	
	# если такого места нет в бд то добавляем
	if ( ! $ISPLACE) {
		if (insert($con, $ALLOWED_PLACE, $ДАННЫЕ['PLACE'], 'PLACE', true)) {
			
			//printf("Место добавлено\n");
		
			$IDPLACE = $con->insert_id;
	
			if  (isset($ДАННЫЕ['PLACE']['address_components'])) {
				for ($j = 0; $j < count($ДАННЫЕ['PLACE']['address_components']); $j++) {
					$ДАННЫЕ['PLACE']['address_components'][$j]['IDPLACE'] = $IDPLACE;
					insert($con, $ALLOWED_ADDRESS_COMPONENTS, $ДАННЫЕ['PLACE']['address_components'][$j],'ADDRESS_COMPONENTS', true);
					//?printf("$j-й address_component добавлен\n"):'';
				}
			}
		}
	}
}
$con->close();
curl_close($myCurl);
$time = microtime(true) - $start;
printf("\nСкрипт выполнялся %.4F сек.", $time);

?>