<?php
$start = microtime(true);
ini_set('error_reporting', E_ALL);
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);

include_once $_SERVER['DOCUMENT_ROOT'].'/php/allowed.php';
include_once $_SERVER['DOCUMENT_ROOT'].'/php/functions.php';
include_once $_SERVER['DOCUMENT_ROOT'].'/street.php';
include_once $_SERVER['DOCUMENT_ROOT'].'/array.php';

function r0($arr) {
	return $arr[mt_rand(0,count($arr)-1)];
}
function r1($arr) {
	return $arr[mt_rand(1,count($arr)-1)];
}
# Соединямся с БД
include_once $_SERVER['DOCUMENT_ROOT'].'/php/properties.php';
$con = new mysqli($host, $user, $password, $dbname, $port, $socket)
	or die ('Could not connect to the database server' . mysqli_connect_error());

# отменить жесткие запреты
$con->query("SET sql_mode = 'ONLY_FULL_GROUP_BY,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION'");

# проверяем существование места
$query = "SELECT IDPLACE FROM realestate.PLACE where FIND_IN_SET('street_address', `types`) > 0";
	
$IDPLACE = [];
	
if ($result = $con->query($query)) {
	while ($PLACE = $result->fetch_object()) {
		$IDPLACE[] = $PLACE->IDPLACE;
	}
	$result->close();
}




for ($u = 1001; $u <= 10000; $u++) {
		 
	# создаем пользователя
	
	$QUANTITY = mt_rand(1,3);
	
	$SOURCEUSER = [
	'EMAIL'=>'b' . $u . '@gmail.com',
	'PASSWORD'=>'b99937535a8405c947a37947cb775575',
	'HASH'=>'',
	'IP'=>'',
	'CONFIRMED'=>'NO',
	'QUANTITY'=>$QUANTITY];
	
	insert($con, $ALLOWED_USER, $SOURCEUSER, 'USER')?"USER OK\n":"USER FAIL\n";
	$IDUSER  = $con->insert_id;
	
	
	# создаем для этого пользователя $QUANTITY недвижимостей
	for ($j = 1; $j <= $QUANTITY; $j++ ) {
			 
		$SOURCEMAIN = [
		'IDUSER' => $IDUSER,
		'IDPLACE' => $IDPLACE[mt_rand(0,count($IDPLACE)-1)],
		'NAME' => $NAME[mt_rand(0,9)],
		'DEAL' => $DEAL[mt_rand(0,4)],
		'ИМУЩЕСТВО' => $PROPERTY2[mt_rand(0,6)],
		'ЦЕНА' => mt_rand(1000000,7000000),
		'CURRENCY' => $CURRENCY[mt_rand(0,3)],
		'CADASTRNUMBER' => 'АА:ВВ:ССССРРL:КК',
		'NUMBER' => $j,
		'АТРИБУТЫ' => random_set($ALLOWED_REALESTATE['АТРИБУТЫ'])];
		
		insert($con, $ALLOWED_REALESTATE, $SOURCEMAIN, 'НЕДВИЖИМОСТЬ')?"ALLOWEDMAIN OK\n":'FAIL';
		$ИДЕНТИФИКАТОР = $con->insert_id;
		# для каждой недвижимости копируем фотки
		$FOLDER = mt_rand(1,12);
		@mkdir('/var/www/html/photo/' . $SOURCEMAIN['IDUSER']);
		@mkdir('/var/www/html/photo/' . $SOURCEMAIN['IDUSER'] . '/'. $SOURCEMAIN['NUMBER']);
		rcopy('/var/www/html/2/'.$FOLDER, '/var/www/html/photo/' . $SOURCEMAIN['IDUSER'] . '/'. $SOURCEMAIN['NUMBER']);
		
		/**
		  *   Добавляем определенную недвижимость
		  */
		
		
		
		switch ($SOURCEMAIN['ИМУЩЕСТВО']) {
		
		#Квартира, Часть квартиры
		case 'APARTMENT':

		
		$REALESTATE_APARTMENT = [
			'ИДЕНТИФИКАТОР'=>$ИДЕНТИФИКАТОР,
			'APARTMENTINTEGRITY'=> r0($APARTMENTINTEGRITY),
			'APARTMENTSTATUS'=>$APARTMENTSTATUS[mt_rand(0,1)],
			'APARTMENTQUANTITYROOMS'=>mt_rand(1,10),
			'APARTMENTOWNEDROOMS'=>mt_rand(1,10),
			'APARTMENTOVERALLSPACE'=>mt_rand(67,145),
			'APARTMENTRESIDENTIALSPACE'=>mt_rand(67,145),
			'APARTMENTTYPEHOUSE'=>$APARTMENTTYPEHOUSE[mt_rand(0,3)],
			'APARTMENTNUMBEROFSTOREYS'=>mt_rand(1,25),
			'APARTMENTFLOOR'=>mt_rand(1,25),
			'APARTMENTCEILINGHEIGHT'=>mt_rand(1,3),
			'APARTMENTHOUSING'=>$APARTMENTHOUSING[mt_rand(0,1)],
			'APARTMENTMOREINFO'=>r0($MOREINFO),
			'АТРИБУТЫ'=>random_set(['APARTMENTPLAYGROUND','APARTMENTINTERCOM','APARTMENTSTUDIO','APARTMENTQUIETNEIGHBORS'])];
		
		$ИМУЩЕСТВО = $REALESTATE_APARTMENT;
		
		$length = mt_rand(0, 10);
		for ($r = 1; $r < $length; $r++) {
			$REALESTATE_APARTMENT_ROOM = [
			'ИДЕНТИФИКАТОР'=>$ИДЕНТИФИКАТОР,
			'APARTMENTNEWNAMEROOM'=>$NAMEROOM[mt_rand(0, count($NAMEROOM) - 1)],
			'APARTMENTNEWROOMSPACE'=>mt_rand(67,244),
			'APARTMENTLOGGIA'=>$LOGGIA[mt_rand(0,3)],
			'APARTMENTVIEWFROMTHEWINDOW'=>$VID[mt_rand(0,count($VID)-1)],
			'APARTMENTWINDOWSIDE'=>$WINDOWSIDE[mt_rand(0,count($WINDOWSIDE)-1)],
			'АТРИБУТЫ'=>random_set(['APARTMENTOWNED'])];
			$ИМУЩЕСТВО['ROOM'][$r] = $REALESTATE_APARTMENT_ROOM;
		}
			
			insert($con, $ALLOWED_REALESTATE_APARTMENT, $ИМУЩЕСТВО, 'REALESTATEAPARTMENT')?
				printf("Квартира добавлена\n"):
				printf($stmt->error);
			if (isset($ИМУЩЕСТВО['ROOM'])) {
				for ($i = 1, $k = 0; $i <= count($ИМУЩЕСТВО['ROOM']); $i++) {    
					$ИМУЩЕСТВО['ROOM'][$i]['ИДЕНТИФИКАТОР'] = $ИДЕНТИФИКАТОР;
					insert($con, $ALLOWED_REALESTATE_APARTMENT_ROOM, $ИМУЩЕСТВО['ROOM'][$i], 'REALESTATEAPARTMENTROOM')?
						printf("$i-я комната в квартире добавлена.\n"):'';
				}
			}
			break;
		
		# Дом, Часть дома
		case 'HOUSE':
			
			$REALESTATE_HOUSE = [
			'ИДЕНТИФИКАТОР'=>$ИДЕНТИФИКАТОР,
			'ISFULLHOUSE'=>['HOUSE', 'PARTHOUSE'][mt_rand(0,1)],
			'HOUSEQUANTITYROOMS'=>mt_rand(1,10),
			'HOUSEOWNEDROOMS'=>mt_rand(1,10),
			'HOUSEOVERALLSPACE'=>mt_rand(56,134),
			'HOUSERESIDENTIALSPACE'=>mt_rand(56,134),
			'HOUSEHOWMANYFLOORS'=>mt_rand(1,28),
			'HOUSETYPEHOUSE'=>$APARTMENTTYPEHOUSE[mt_rand(0,3)],
			'HOUSEHOUSING'=>$APARTMENTHOUSING[mt_rand(0,1)],
			'HOUSEHEATING'=>$HOUSEHEATING[mt_rand(0,3)],
			'HOUSEHOMETOP'=>r0(['МАНСАРДА', 'ЧЕРДАК']),
			'HOUSEMOREINFO'=>r0($MOREINFO),
			'HOUSECEILINGHEIGHT'=>mt_rand(1,3),
			'HOUSEFOUNDATION'=>r0($FOUNDATION),
			'АТРИБУТЫ'=>random_set(['HOUSEPLAYGROUND','HOUSEINTERCOM','HOUSEQUIETNEIGHBORS','HOUSECELLAR','HOUSEBASEMENT'])];

			$ИМУЩЕСТВО = $REALESTATE_HOUSE;
			
			$length = mt_rand(0, 10);
			for ($r = 1; $r < $length; $r++) {			
				$REALESTATE_HOUSE_ROOM = [
				'ИДЕНТИФИКАТОР'=>$ИДЕНТИФИКАТОР,
				'HOUSENEWROOMNAME'=>r0($NAMEROOM),
				'HOUSENEWROOMSPACE'=>mt_rand(87,231),
				'HOUSENEWROOMLOGGIA'=>r0($LOGGIA),
				'HOUSENEWROOMVIEWOFTHE'=>r0($VID),
				'HOUSENEWROOMSIDE'=>r0($WINDOWSIDE),
				'АТРИБУТЫ'=>random_set(['HOUSENEWROOMOWNED'])];
				$ИМУЩЕСТВО['ROOM'][$r] = $REALESTATE_HOUSE_ROOM;
			}
			
			insert($con, $ALLOWED_REALESTATE_HOUSE, $ИМУЩЕСТВО, 'REALESTATEHOUSE')?
				printf("Дом добавлен.\n"):
				printf($stmt->error);
			if (isset($ИМУЩЕСТВО['ROOM'])) {
				for ($i = 1; $i <= count($ИМУЩЕСТВО['ROOM']); $i++) {
					$ИМУЩЕСТВО['ROOM'][$i]['ИДЕНТИФИКАТОР'] = $ИДЕНТИФИКАТОР;
					insert($con, $ALLOWED_REALESTATE_HOUSE_ROOM, $ИМУЩЕСТВО['ROOM'][$i], 'REALESTATEHOUSEROOM')?
						printf("$i-я комната в доме добавлена.\n"):'';
				}
			}
			break;
		
		# Земельный участок
		case 'PARCEL':
			
			$REALESTATE_PARCEL = [
				'ИДЕНТИФИКАТОР'=>$ИДЕНТИФИКАТОР,
				'PARCELPLACE'=>mt_rand(34,98),
				'PARCELAPIARYSPACE'=>mt_rand(34,98),
				'PARCELQUANTITYHIVES'=>mt_rand(0,23),
				'PARCELMOREINFO'=>r0($MOREINFO),
				'АТРИБУТЫ'=>random_set(['PARCELISAPIARY','PARCELISGARDEN','PARCELISELECTRICITY','PARCELISWATERPIPES','PARCELISGAS','PARCELISINTERNET','PARCELISSEWERAGE','PARCELISHEATING'])];
			
			$ИМУЩЕСТВО = $REALESTATE_PARCEL;
			
			$length = mt_rand(0, 10);
			for ($r = 1; $r < $length; $r++) {	
				$REALESTATE_PARCEL_PLANT = [
					'ИДЕНТИФИКАТОР'=>$ИДЕНТИФИКАТОР,
					'PARCELNEWPLANT'=>r0($PLANT),
					'PARCELNEWPLANTPLACE'=>mt_rand(12,45)];
				$ИМУЩЕСТВО['PLANT'][$r] = $REALESTATE_PARCEL_PLANT;
			}
			$length = mt_rand(0, 10);
			for ($r = 1; $r < $length; $r++) {
				$REALESTATE_PARCEL_HOZBUILDING = [
				'ИДЕНТИФИКАТОР'=>$ИДЕНТИФИКАТОР,
				'PARCELHOZBUILDINGGNAME'=>r0($HOZPOSTR),
				'PARCELHOZBUILDINPLACE'=>mt_rand(10,45)];
				$ИМУЩЕСТВО['HOZBUILDING'][$r] = $REALESTATE_PARCEL_HOZBUILDING;
			}
			insert($con, $ALLOWED_REALESTATE_PARCEL, $ИМУЩЕСТВО, 'REALESTATEPARCEL')
				? printf("Земельный участок добавлен.\n"):'';
			# Растения
			if  (isset($ИМУЩЕСТВО['PLANT'])) {
				for ($i = 1; $i <= count($ИМУЩЕСТВО['PLANT']); $i++) {
					$ИМУЩЕСТВО['PLANT'][$i]['ИДЕНТИФИКАТОР'] = $ИДЕНТИФИКАТОР;
					insert($con, $ALLOWED_REALESTATE_PARCEL_PLANT,
						   $ИМУЩЕСТВО['PLANT'][$i], 'REALESTATEPARCELPLANT')
						? printf("$i-е растение на земельном участке добавлено.\n"):'';
				}
			}
			# Хозпостройки
			if  (isset($ИМУЩЕСТВО['HOZBUILDING'])) {
				for ($i = 1; $i <= count($ИМУЩЕСТВО['HOZBUILDING']); $i++) {
					$ИМУЩЕСТВО['HOZBUILDING'][$i]['ИДЕНТИФИКАТОР'] = $ИДЕНТИФИКАТОР;
					insert($con, $ALLOWED_REALESTATE_PARCEL_HOZBUILDING,
						   $ИМУЩЕСТВО['HOZBUILDING'][$i], 'REALESTATEPARCELHOZBUILDING')
						? printf("$i-я хозпостройка на земельном участке добавлена.\n"):'';
					
				}
			}
			break;
		
		# Гараж \ Машиноместо
		case 'GARAGE':
			$REALESTATE_GARAGE = [
			'ИДЕНТИФИКАТОР'=>$ИДЕНТИФИКАТОР,
			'GARAGEGARAGEORPARKINGPLACE'=>mt_rand(23,98),
			'GARAGETYPEOFPARKING'=>r0($TYPEOFPARKING),
			'GARAGETYPEGARAGE'=>r0($TYPEGARAGE),
			'GARAGEFOUNDATION'=>r0($FOUNDATION),
			'GARAGEHOWMANYFLOORS'=>mt_rand(1,43),
			'GARAGEFLOOR'=>mt_rand(1,43),
			'GARAGECOMPLEXNAME'=>r0($COMPLEXNAME),
			'GARAGEPLACE'=>mt_rand(23,34),
			'GARAGECEILINGHEIGHT'=>mt_rand(1,3),
			'GARAGEGATEHEIGHT'=>mt_rand(1,3),
			'GARAGEMOREINFO'=>r0($MOREINFO),
			'АТРИБУТЫ'=>random_set(['GARAGEANDPARCELOWNED','GARAGEPROTECTED','GARAGEVIDEOMONITORING','GARAGELIGHTING','GARAGECELLAR','GARAGEBASEMENT','GARAGEPIT','GARAGESHELVES'])];

			$ИМУЩЕСТВО = $REALESTATE_GARAGE;
			
			insert($con, $ALLOWED_REALESTATE_GARAGE, $ИМУЩЕСТВО, 'REALESTATEGARAGE')?
				printf("Гараж, Машиноместо добавлено.\n"):'';
			break;
		
		# Помещение
		case 'ROOM':
			$REALESTATE_ROOM = [
				'ИДЕНТИФИКАТОР'=>$ИДЕНТИФИКАТОР,
				'ROOMTYPEROOM'=>r0($ROOMTYPEROOM),
				'ROOMSPACE'=>mt_rand(23,34),
				'ROOMTYPEBUILDING'=>r0($TYPEBUILDING),
				'ROOMCEILINGHEIGHT'=>mt_rand(1,3),
				'ROOMHOWMANYFLOORS'=>mt_rand(1,45),
				'ROOMFLOOR'=>mt_rand(1,45),
				'ROOMMOREINFO'=>r0($MOREINFO),
				'АТРИБУТЫ'=>random_set(['ROOMSEPARATEENTRANCE','ROOMSEPARATEELECTRICALPANEL'])];
			
			$ИМУЩЕСТВО = $REALESTATE_ROOM;
			
			$length = mt_rand(0, 10);
			for ($r = 1; $r < $length; $r++) {			
				$REALESTATE_ROOMMORE = [
				'ИДЕНТИФИКАТОР'=>$ИДЕНТИФИКАТОР,
				'ROOMMOREROOMNAME'=>r0($NAMEROOM),
				'ROOMMOREROONSPACE'=>mt_rand(12,34)];
				$ИМУЩЕСТВО['ROOM'][$r] = $REALESTATE_ROOMMORE;
			}
			
			insert($con, $ALLOWED_REALESTATE_ROOM, $ИМУЩЕСТВО, 'REALESTATEROOM')?
				printf("Помещение, склад, офис добавлено.\n"):'';
						
			if  (isset($ИМУЩЕСТВО['ROOM'])) {
				for ($i = 1; $i <= count($ИМУЩЕСТВО['ROOM']); $i++) {
					$ИМУЩЕСТВО['ROOM'][$i]['ИДЕНТИФИКАТОР'] = $ИДЕНТИФИКАТОР;
					insert($con, $ALLOWED_REALESTATE_ROOMMORE, $ИМУЩЕСТВО['ROOM'][$i], 'REALESTATEROOMMORE')?
						printf("$i-я комната в помещении добавлена.\n"):'';
				}
			}
			break;
		# Гостиница
		case 'HOTEL':

			$REALESTATE_HOTEL = [
				'ИДЕНТИФИКАТОР'=>$ИДЕНТИФИКАТОР,
				'HOTELHOWMANYFLOORS'=>mt_rand(1,12),
				'HOTELSPACE'=>mt_rand(133,233),
				'HOTELHOWMANYROOMS'=>mt_rand(50,155),
				'HOTELHOWMANYSTARS'=>mt_rand(1,5),
				'HOTELTYPEBUILDING'=>r0($TYPEBUILDING),
				'HOTELFOUNDATION'=>r0($FOUNDATION),
				'HOTELMOREINFO'=>r0($MOREINFO),
				'АТРИБУТЫ'=>random_set(['HOTELNONSMOKINGROOMS','HOTELFAMILYROOMS','HOTELINDOORSWIMMINGPOOL','HOTELSPAWELLNESSCENTRE','HOTELRESTAURANTDINING','HOTELFITNESSCENTRE','ОТЕЛЬУДОБСТВАДЛЯГОСТЕЙСОГРАНИЧЕННЫМИФИЗИЧЕСКИМИВОЗМОЖНОСТЯМИ','HOTELMEETINGBANQUET','HOTELFACILITIES','HOTELBAR','HOTELHONEYMOONSUITE','HOTELBARBERBEAUTYSALON','ОТЕЛЬСАУНА','ОТЕЛЬСОЛЯРИЙ','ОТЕЛЬТУРЕЦКАЯБАНЯ','ОТЕЛЬМАССАЖ'])];
			
			$ИМУЩЕСТВО = $REALESTATE_HOTEL;
			
			$length = mt_rand(0, 10);
			for ($r = 1; $r < $length; $r++) {									
				$REALESTATE_HOTEL_ROOM = [
				'ИДЕНТИФИКАТОР'=>$ИДЕНТИФИКАТОР,
				'HOTELMOREROOMNAME'=>r0($NAMEROOM),
				'HOTELMOREROOMSPACE'=>mt_rand(12,45),
				'HOTELMOREROOMINFO'=>r0($MOREINFO)];
				$ИМУЩЕСТВО['ROOM'][$r] = $REALESTATE_HOTEL_ROOM;
			}
			insert($con, $ALLOWED_REALESTATE_HOTEL, $ИМУЩЕСТВО, 'REALESTATEHOTEL')?
				printf("Отель добавлен.\n"):'';
			
			if (isset($ИМУЩЕСТВО['ROOM'])) {
				for ($i = 1; $i <= count($ИМУЩЕСТВО['ROOM']); $i++) {
					$ИМУЩЕСТВО['ROOM'][$i]['ИДЕНТИФИКАТОР'] = $ИДЕНТИФИКАТОР;
					insert($con, $ALLOWED_REALESTATE_HOTEL_ROOM, $ИМУЩЕСТВО['ROOM'][$i], 'REALESTATEHOTELROOM')?
						printf("$i-я комната в отеле добавлена.\n"):'';
				}
			}
			break;
		
		# Другое
		case 'OTHER':
			
			$REALESTATE_OTHER = [
				'ИДЕНТИФИКАТОР'=>$ИДЕНТИФИКАТОР,
				'OTHERSPACE'=>mt_rand(233,255),
				'OTHERMOREINFO'=>r0($MOREINFO)];
			
			$ИМУЩЕСТВО = $REALESTATE_OTHER;
			
			$length = mt_rand(0, 10);
			for ($r = 1; $r < $length; $r++) {				
				$REALESTATE_OTHER_BUILDING = [
				'ИДЕНТИФИКАТОР'=>$ИДЕНТИФИКАТОР,
				'OTHERBUILDINGTEXTAREA'=>r0($MOREINFO),
				'OTHERNEWBUILDINGNAME'=>r0(['Склад','Помещение','Здание','Земля']),
				'OTHERNEWBUILDINGSPACE'=>mt_rand(34,56),
				'OTHERNEWBUILDINGLOORS'=>mt_rand(1,12),
				'OTHERNEWBUILDINGFLOORHEIGHT'=>mt_rand(1,3),
				'OTHERNEWBUILDINGTYPE'=>r0($TYPEBUILDING),
				'АТРИБУТЫ'=>random_set(['OTHERNEWBUILDINGSEPARATEENTRANCE'])];
				$ИМУЩЕСТВО['ЗДАНИЕ'][$r] = $REALESTATE_OTHER_BUILDING;
				
				$length2 = mt_rand(0, 10);
				for ($s = 1; $s < $length2; $s++) {					
					$REALESTATE_OTHER_BUILDING_ROOM = [
					'OTHERNEWROOMMOREINFO'=>r0($MOREINFO),
					'OTHERNEWROOMNAME'=>r0($NAMEROOM),
					'OTHERNEWROOMSPACE'=>mt_rand(23,34)];
					$ИМУЩЕСТВО['ЗДАНИЕ'][$r]['ROOM'][$s] = $REALESTATE_OTHER_BUILDING_ROOM;
				}
			}
			
			insert($con, $ALLOWED_REALESTATE_OTHER, $ИМУЩЕСТВО, 'REALESTATEOTHER')?
				printf("Запись об 'другой' недвижимости добавлена.\n"):'';
						
			if (isset($ИМУЩЕСТВО['ЗДАНИЕ'])) {
				for ($i = 1; $i <= count($ИМУЩЕСТВО['ЗДАНИЕ']); $i++) {
					$ИМУЩЕСТВО['ЗДАНИЕ'][$i]['ИДЕНТИФИКАТОР'] = $ИДЕНТИФИКАТОР;
					insert($con, $ALLOWED_REALESTATE_OTHER_BUILDING, $ИМУЩЕСТВО['ЗДАНИЕ'][$i],
						   'REALESTATEOTHERBUILDING')?
						printf("$i-е здание добавлено.\n"):'';
					$IDBUILDING = $con->insert_id;
		
					if (isset($ИМУЩЕСТВО['ЗДАНИЕ'][$i]['ROOM'])) {
						for ($j = 1; $j <= count($ИМУЩЕСТВО['ЗДАНИЕ'][$i]['ROOM']); $j++) {
							$ИМУЩЕСТВО['ЗДАНИЕ'][$i]['ROOM'][$j]['IDOTHERBUILDING'] = $IDBUILDING;
							insert($con, $ALLOWED_REALESTATE_OTHER_BUILDING_ROOM,
								   $ИМУЩЕСТВО['ЗДАНИЕ'][$i]['ROOM'][$j],
								   'REALESTATEOTHERBUILDINGROOM')?
								printf("$j-е помещение в здании добавлено.\n"):'';
						}
					}
				}
			}
		}
	}
}



$con->close();
$time = microtime(true) - $start;
printf("\nСкрипт выполнялся %.4F сек.", $time);
