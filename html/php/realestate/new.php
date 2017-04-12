<?php
//$start = microtime(true);

#
ini_set('error_reporting', E_ALL);
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);

function nop123($value='') {
	# code...
}

try {

	#
	$ДАННЫЕ = json_decode(file_get_contents('php://input'), true);

	# ПРОВЕРКИ БЕЗОПАСТНОСТИ
	if ( isset($_COOKIE['ID']) && isset($_COOKIE['HASH']) ) {
		
		# Соединямся с БД
		include_once $_SERVER['DOCUMENT_ROOT'].'/php/properties.php';
		include_once $_SERVER['DOCUMENT_ROOT'].'/php/functions.php';
		include_once $_SERVER['DOCUMENT_ROOT'].'/php/allowed.php';
		$dbname = 'realestate';
		$con = new mysqli($host, $user, $password, $dbname, $port, $socket)
			or die ('Could not connect to the database server' . mysqli_connect_error());
		
		# проверяем существование пользователя
		$query = "SELECT ID, QUANTITY FROM USER WHERE ID="
		.$con->real_escape_string($_COOKIE['ID']) . " and HASH='"
		.$con->real_escape_string($_COOKIE['HASH'])
		."' LIMIT 1";
	
		if ($result = $con->query($query)) {
			if( ! $USER = $result->fetch_object()) {
				echo 3;
				exit;
			}
			$result->close();
		}
		
	} else {
		echo 4;
		exit;   
	}
		
	# отменить жесткие запреты
	$con->query("SET sql_mode = 'ONLY_FULL_GROUP_BY,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION'");

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
			nop123("Такое место есть.\n");
		}
		$result->close();
	}

	# если такого места нет в бд то добавляем
	if ( ! $ISPLACE) {
		insert($con, $ALLOWED_PLACE, $ДАННЫЕ['PLACE'], 'PLACE', true)?
			nop123("Место добавлено\n"):'';
		$IDPLACE = $con->insert_id;

		if  (isset($ДАННЫЕ['PLACE']['address_components'])) {
			for ($j = 0; $j < count($ДАННЫЕ['PLACE']['address_components']); $j++) {
				$ДАННЫЕ['PLACE']['address_components'][$j]['IDPLACE'] = $IDPLACE;
				insert($con, $ALLOWED_ADDRESS_COMPONENTS, $ДАННЫЕ['PLACE']['address_components'][$j],'ADDRESS_COMPONENTS', true)?
					nop123("$j-й address_component добавлен\n"):'';
			}
		}
	}


	# *** ??? МОЖЕТ ОШИБКА НИЖЕ БУДЕТ А Я ТУТ УЖЕ ИНКРИМЕНТИРУЮ ???
	# ИНКРИМЕНТ КОЛИЧЕСТВА НЕДВИЖИМОСТЕЙ
	update($con, ["QUANTITY"=>"i"], ["QUANTITY"=>($USER->QUANTITY + 1)], "USER", "ID", $USER->ID)?
		nop123("Количество недвижимости инкрементировано\n"):'';

		
	# добавляем запись в основную таблицу НЕДВИЖИМОСТЬ
	$ДАННЫЕ['НЕДВИЖИМОСТЬ']['IDUSER'] = $_COOKIE['ID'];
	$ДАННЫЕ['НЕДВИЖИМОСТЬ']['IDPLACE'] = $IDPLACE;
	$ДАННЫЕ['НЕДВИЖИМОСТЬ']['NUMBER'] = $USER->QUANTITY + 1;
	insert($con, $ALLOWED_REALESTATE, $ДАННЫЕ['НЕДВИЖИМОСТЬ'], 'НЕДВИЖИМОСТЬ')?
		nop123("Недвижимость добавлена\n"):'';
	$ИДЕНТИФИКАТОР = $con->insert_id;
		
	# МАРКЕРЫ
	if (isset($ДАННЫЕ['МАРКЕРЫ']) && count($ДАННЫЕ['МАРКЕРЫ']) > 0) {
		for ($i = 0; $i < count($ДАННЫЕ['МАРКЕРЫ']); $i++) {
			$ДАННЫЕ['МАРКЕРЫ'][$i]['ИДЕНТИФИКАТОР'] = $ИДЕНТИФИКАТОР;
			insert($con, $ALLOWED_MARKER, $ДАННЫЕ['МАРКЕРЫ'][$i], 'MARKER', true)?
				nop123("$i-й маркер добавлен\n"):'';
		}
	}

	# ПОЛИГОНЫ
	if (isset($ДАННЫЕ['ПОЛИГОНЫ'])
		&& count($ДАННЫЕ['ПОЛИГОНЫ']) > 0) {
		
		for ($i = 0; $i < count($ДАННЫЕ['ПОЛИГОНЫ']); $i++) {
			
			for ($j = 0; $j < count($ДАННЫЕ['ПОЛИГОНЫ'][$i]); $j++) {
				
				$ДАННЫЕ['ПОЛИГОНЫ'][$i][$j]['ИДЕНТИФИКАТОР'] = $ИДЕНТИФИКАТОР;
				$ДАННЫЕ['ПОЛИГОНЫ'][$i][$j]['NUMBER'] = $i;
				
				insert($con, $ALLOWED_POLYGON,$ДАННЫЕ['ПОЛИГОНЫ'][$i][$j], 'POLYGON', true) ?
					nop123("$i-$j полигон добавлен\n"):'';
				
			}
		}
	}

	/**
	*   Добавляем определенную недвижимость
	*/

	if (isset($ДАННЫЕ['НЕДВИЖИМОСТЬ']) && isset($ДАННЫЕ['НЕДВИЖИМОСТЬ']['ИМУЩЕСТВО'])) {
		$PROPERTY_NAME = $ДАННЫЕ['НЕДВИЖИМОСТЬ']['ИМУЩЕСТВО'];
	}

	if (isset($ДАННЫЕ['НЕДВИЖИМОСТЬ'][$PROPERTY_NAME])) {
		
		$ДАННЫЕ['НЕДВИЖИМОСТЬ'][$PROPERTY_NAME]['ИДЕНТИФИКАТОР'] = $ИДЕНТИФИКАТОР;

		$ИМУЩЕСТВО = &$ДАННЫЕ['НЕДВИЖИМОСТЬ'][$PROPERTY_NAME];
		
		switch ($PROPERTY_NAME) {
		
		#Квартира, Часть квартиры
		case 'APARTMENT':
			
			insert($con, $ALLOWED_REALESTATE_APARTMENT, $ИМУЩЕСТВО, 'REALESTATEAPARTMENT')?
				nop123("Квартира добавлена\n"):
				nop123($stmt->error);
			if (isset($ИМУЩЕСТВО['ROOM'])) {
				for ($i = 1, $k = 0; $i <= count($ИМУЩЕСТВО['ROOM']); $i++) {    
					$ИМУЩЕСТВО['ROOM'][$i]['ИДЕНТИФИКАТОР'] = $ИДЕНТИФИКАТОР;
					insert($con, $ALLOWED_REALESTATE_APARTMENT_ROOM, $ИМУЩЕСТВО['ROOM'][$i], 'REALESTATEAPARTMENTROOM')?
						nop123("$i-я комната в квартире добавлена.\n"):'';
				}
			}
			break;
		
		# Дом, Часть дома
		case 'HOUSE':
			insert($con, $ALLOWED_REALESTATE_HOUSE, $ИМУЩЕСТВО, 'REALESTATEHOUSE')?
				nop123("Дом добавлен.\n"):
				nop123($stmt->error);
			if (isset($ИМУЩЕСТВО['ROOM'])) {
				for ($i = 1; $i <= count($ИМУЩЕСТВО['ROOM']); $i++) {
					$ИМУЩЕСТВО['ROOM'][$i]['ИДЕНТИФИКАТОР'] = $ИДЕНТИФИКАТОР;
					insert($con, $ALLOWED_REALESTATE_HOUSE_ROOM, $ИМУЩЕСТВО['ROOM'][$i], 'REALESTATEHOUSEROOM')?
						nop123("$i-я комната в доме добавлена.\n"):'';
				}
			}
			break;
		
		# Земельный участок
		case 'PARCEL':
		
			insert($con, $ALLOWED_REALESTATE_PARCEL, $ИМУЩЕСТВО, 'REALESTATEPARCEL')
				? nop123("Земельный участок добавлен.\n"):'';
			# Растения
			if  (isset($ИМУЩЕСТВО['PLANT'])) {
				for ($i = 1; $i <= count($ИМУЩЕСТВО['PLANT']); $i++) {
					$ИМУЩЕСТВО['PLANT'][$i]['ИДЕНТИФИКАТОР'] = $ИДЕНТИФИКАТОР;
					insert($con, $ALLOWED_REALESTATE_PARCEL_PLANT,
						$ИМУЩЕСТВО['PLANT'][$i], 'REALESTATEPARCELPLANT')
						? nop123("$i-е растение на земельном участке добавлено.\n"):'';
				}
			}
			# Хозпостройки
			if  (isset($ИМУЩЕСТВО['HOZBUILDING'])) {
				for ($i = 1; $i <= count($ИМУЩЕСТВО['HOZBUILDING']); $i++) {
					$ИМУЩЕСТВО['HOZBUILDING'][$i]['ИДЕНТИФИКАТОР'] = $ИДЕНТИФИКАТОР;
					insert($con, $ALLOWED_REALESTATE_PARCEL_HOZBUILDING,
						$ИМУЩЕСТВО['HOZBUILDING'][$i], 'REALESTATEPARCELHOZBUILDING')
						? nop123("$i-я хозпостройка на земельном участке добавлена.\n"):'';
					
				}
			}
			break;
		
		# Гараж \ Машиноместо
		case 'GARAGE':
			
			insert($con, $ALLOWED_REALESTATE_GARAGE, $ИМУЩЕСТВО, 'REALESTATEGARAGE')?
				nop123("Гараж, Машиноместо добавлено.\n"):'';
			break;
		
		# Помещение
		case 'ROOM':
			insert($con, $ALLOWED_REALESTATE_ROOM, $ИМУЩЕСТВО, 'REALESTATEROOM')?
				nop123("Помещение, склад, офис добавлено.\n"):'';
						
			if  (isset($ИМУЩЕСТВО['ROOM'])) {
				for ($i = 1; $i <= count($ИМУЩЕСТВО['ROOM']); $i++) {
					$ИМУЩЕСТВО['ROOM'][$i]['ИДЕНТИФИКАТОР'] = $ИДЕНТИФИКАТОР;
					insert($con, $ALLOWED_REALESTATE_ROOMMORE, $ИМУЩЕСТВО['ROOM'][$i], 'REALESTATEROOMMORE')?
						nop123("$i-я комната в помещении добавлена.\n"):'';
				}
			}
			break;
		# Гостиница
		case 'HOTEL':
			insert($con, $ALLOWED_REALESTATE_HOTEL, $ИМУЩЕСТВО, 'REALESTATEHOTEL')?
				nop123("Отель добавлен.\n"):'';
			if (isset($ИМУЩЕСТВО['ROOM'])) {
				for ($i = 1; $i <= count($ИМУЩЕСТВО['ROOM']); $i++) {
					$ИМУЩЕСТВО['ROOM'][$i]['ИДЕНТИФИКАТОР'] = $ИДЕНТИФИКАТОР;
					insert($con, $ALLOWED_REALESTATE_HOTEL_ROOM, $ИМУЩЕСТВО['ROOM'][$i], 'REALESTATEHOTELROOM')?
						nop123("$i-я комната в отеле добавлена.\n"):'';
				}
			}
			break;
		
		# Другое
		case 'OTHER':
			insert($con, $ALLOWED_REALESTATE_OTHER, $ИМУЩЕСТВО, 'REALESTATEOTHER')?
				nop123("Запись об 'другой' недвижимости добавлена.\n"):'';
						
			if (isset($ИМУЩЕСТВО['ЗДАНИЕ'])) {
				for ($i = 1; $i <= count($ИМУЩЕСТВО['ЗДАНИЕ']); $i++) {
					$ИМУЩЕСТВО['ЗДАНИЕ'][$i]['ИДЕНТИФИКАТОР'] = $ИДЕНТИФИКАТОР;
					insert($con, $ALLOWED_REALESTATE_OTHER_BUILDING, $ИМУЩЕСТВО['ЗДАНИЕ'][$i],
						'REALESTATEOTHERBUILDING')?
						nop123("$i-е здание добавлено.\n"):'';
					$IDBUILDING = $con->insert_id;
		
					if (isset($ИМУЩЕСТВО['ЗДАНИЕ'][$i]['ROOM'])) {
						for ($j = 1; $j <= count($ИМУЩЕСТВО['ЗДАНИЕ'][$i]['ROOM']); $j++) {
							$ИМУЩЕСТВО['ЗДАНИЕ'][$i]['ROOM'][$j]['IDOTHERBUILDING'] = $IDBUILDING;
							insert($con, $ALLOWED_REALESTATE_OTHER_BUILDING_ROOM,
								$ИМУЩЕСТВО['ЗДАНИЕ'][$i]['ROOM'][$j],
								'REALESTATEOTHERBUILDINGROOM')?
								nop123("$j-е помещение в здании добавлено.\n"):'';
						}
					}
				}
			}
		}
	}
	$con->close();

} catch (Exception $e) {
	echo false;
	exit;
}

echo true;


//$time = microtime(true) - $start;
//nop123("\nСкрипт выполнялся %.4F сек.", $time);
?>