<?php
//$start = microtime(true);

function nop123($value='') {
	# code...
}


ini_set('error_reporting', E_ALL);
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);

try {
    /* mysql сам экранирует данные, но вот как эти данные воспримет браузер, когда будет принимать их обратно*/
    $ДАННЫЕ = json_decode(file_get_contents('php://input'), true);
    # ПРОВЕРКИ БЕЗОПАСТНОСТИ
    if ( ! isset($ДАННЫЕ['НЕДВИЖИМОСТЬ']['ИДЕНТИФИКАТОР'])) {
        echo 0;
        exit;
    } else {
        $ИДЕНТИФИКАТОР = $ДАННЫЕ['НЕДВИЖИМОСТЬ']['ИДЕНТИФИКАТОР'];
    }

    include_once $_SERVER['DOCUMENT_ROOT'].'/php/properties.php';
    include_once $_SERVER['DOCUMENT_ROOT'].'/php/functions.php';
    include_once $_SERVER['DOCUMENT_ROOT'].'/php/allowed.php';
    $con = new mysqli($host, $user, $password, $dbname, $port, $socket)
        or die ('Could not connect to the database server' . mysqli_connect_error());

    $con->query("SET sql_mode = 'ONLY_FULL_GROUP_BY,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION'");

    # Обновляемые данные приходят без STATUS
    # Удаляемые и новые данные имеют STATUS = NEW and DELETE

    # ОБНОВЛЯЕМ НЕДВИЖИММОСТЬ (ОСНОВНУЮ ТАБЛИЦУ)
    unset($ALLOWED_REALESTATE['IDUSER']);
    unset($ALLOWED_REALESTATE['NUMBER']);
    update($con, $ALLOWED_REALESTATE, $ДАННЫЕ['НЕДВИЖИМОСТЬ'], "НЕДВИЖИМОСТЬ", "ИДЕНТИФИКАТОР", $ИДЕНТИФИКАТОР)?
        nop123("Недвижимость обновлена\n"):'';

    # ОБНОВЛЯЕМ МАРКЕРЫ
    # Тут сделаю как проще - удаление и добавление
    # Потом подумаю как сделать лучше.
    # МАРКЕРЫ
    if (isset($ДАННЫЕ['МАРКЕРЫ'])
        && count($ДАННЫЕ['МАРКЕРЫ']) > 0) {
        
        $query = "DELETE FROM `realestate`.`MARKER` WHERE `ИДЕНТИФИКАТОР`='".$ИДЕНТИФИКАТОР."'";
        $con->query($query)?
            nop123("Маркеры удалены\n"):'';
        
        for ($i = 0; $i < count($ДАННЫЕ['МАРКЕРЫ']); $i++) {
            $ДАННЫЕ['МАРКЕРЫ'][$i]['ИДЕНТИФИКАТОР'] = $ИДЕНТИФИКАТОР;
            insert($con, $ALLOWED_MARKER, $ДАННЫЕ['МАРКЕРЫ'][$i], 'MARKER', true)?
                nop123("$i-й маркер добавлен\n"):'';
        }
    }
    # ПОЛИГОНЫ
    if (isset($ДАННЫЕ['ПОЛИГОНЫ'])
        && count($ДАННЫЕ['ПОЛИГОНЫ']) > 0) {
        
        $query = "DELETE FROM `realestate`.`POLYGON` WHERE `ИДЕНТИФИКАТОР`='".$ИДЕНТИФИКАТОР."'";
        $con->query($query)?
            nop123("Полигоны удалены\n"):'';

        for ($i = 0; $i < count($ДАННЫЕ['ПОЛИГОНЫ']); $i++) {
            for ($j = 0; $j < count($ДАННЫЕ['ПОЛИГОНЫ'][$i]); $j++) {
                
                $ДАННЫЕ['ПОЛИГОНЫ'][$i][$j]['ИДЕНТИФИКАТОР'] = $ИДЕНТИФИКАТОР;
                $ДАННЫЕ['ПОЛИГОНЫ'][$i][$j]['NUMBER'] = $i;
                
                insert($con, $ALLOWED_POLYGON,$ДАННЫЕ['ПОЛИГОНЫ'][$i][$j], 'POLYGON', true) ?
                    nop123("$i-$j полигон добавлен\n"):'';
            }
        }
    }

    # Обновляем определенную недвижимость и их комнаты и подкомнаты
    if (isset($ДАННЫЕ['НЕДВИЖИМОСТЬ']) &&
        isset($ДАННЫЕ['НЕДВИЖИМОСТЬ']['ИМУЩЕСТВО']) &&
        isset($ДАННЫЕ['НЕДВИЖИМОСТЬ'][$ДАННЫЕ['НЕДВИЖИМОСТЬ']['ИМУЩЕСТВО']])) {

    $ИМУЩЕСТВО = &$ДАННЫЕ['НЕДВИЖИМОСТЬ'][$ДАННЫЕ['НЕДВИЖИМОСТЬ']['ИМУЩЕСТВО']];

    //print_r($ДАННЫЕ['НЕДВИЖИМОСТЬ'][$ДАННЫЕ['НЕДВИЖИМОСТЬ']['ИМУЩЕСТВО']]);

    switch($ДАННЫЕ['НЕДВИЖИМОСТЬ']['ИМУЩЕСТВО']) {

    # КВАРТИРА
    case 'APARTMENT':

    unset($ALLOWED_REALESTATE_APARTMENT['ИДЕНТИФИКАТОР']);
    update($con, $ALLOWED_REALESTATE_APARTMENT, $ИМУЩЕСТВО, "REALESTATEAPARTMENT", "ИДЕНТИФИКАТОР", $ИДЕНТИФИКАТОР)?
        nop123("Квартира обновлена\n"):'';

    if ( ! isset($ИМУЩЕСТВО['ROOM'])) {
        break;
    }

    foreach ($ИМУЩЕСТВО['ROOM'] as $APARTMENTROOM) {
        if (isset($APARTMENTROOM['STATUS'])) {
            switch ($APARTMENTROOM['STATUS']) {
                case 'NEW':
                    $APARTMENTROOM['ИДЕНТИФИКАТОР'] = $ИДЕНТИФИКАТОР;
                    $ALLOWED_REALESTATE_APARTMENT_ROOM['ИДЕНТИФИКАТОР']='i';
                    insert($con, $ALLOWED_REALESTATE_APARTMENT_ROOM, $APARTMENTROOM, 'REALESTATEAPARTMENTROOM')?
                        nop123("Комната в квартире добавлена.\n"):'';
                break;
                case 'DELETE':
                    $con->query("DELETE FROM REALESTATEAPARTMENTROOM WHERE IDAPARTMENTROOM=" .
                                $APARTMENTROOM['IDAPARTMENTROOM'])?
                        nop123("Комната в квартире удалена\n"):'';
                break;
            }
            
        } else {
            unset($ALLOWED_REALESTATE_APARTMENT_ROOM['ИДЕНТИФИКАТОР']);
            update($con, $ALLOWED_REALESTATE_APARTMENT_ROOM, $APARTMENTROOM,
                "REALESTATEAPARTMENTROOM", "IDAPARTMENTROOM", $APARTMENTROOM['IDAPARTMENTROOM'])?
                nop123("Комната в квартире обновлена\n"):'';
        }
    }
    break;


    # ДОМ
    case 'HOUSE':
        unset($ALLOWED_REALESTATE_HOUSE['ИДЕНТИФИКАТОР']);
        update($con, $ALLOWED_REALESTATE_HOUSE, $ИМУЩЕСТВО, "REALESTATEHOUSE", "ИДЕНТИФИКАТОР", $ИДЕНТИФИКАТОР)?
            nop123("Дом обновлен\n"):'';

        if ( ! isset($ИМУЩЕСТВО['ROOM'])) {
            break;
        }

        foreach ($ИМУЩЕСТВО['ROOM'] as $HOUSEROOM) {
            if (isset($HOUSEROOM['STATUS'])) {
                switch ($HOUSEROOM['STATUS']) {
                    case 'NEW':
                        $HOUSEROOM['ИДЕНТИФИКАТОР'] = $ИДЕНТИФИКАТОР;
                        $ALLOWED_REALESTATE_HOUSE_ROOM['ИДЕНТИФИКАТОР']='i';
                        insert($con, $ALLOWED_REALESTATE_HOUSE_ROOM, $HOUSEROOM, 'REALESTATEHOUSEROOM')?
                            nop123("Комната в доме добавлена.\n"):'';
                    break;
                    case 'DELETE':
                        $con->query("DELETE FROM REALESTATEHOUSEROOM WHERE IDHOUSEROOM = " .
                                    $HOUSEROOM['IDHOUSEROOM'])?
                            nop123("Комната в доме удалена\n"):'';
                    break;
                }
            } else {
                unset($ALLOWED_REALESTATE_HOUSE_ROOM['ИДЕНТИФИКАТОР']);
                update($con, $ALLOWED_REALESTATE_HOUSE_ROOM, $HOUSEROOM, "REALESTATEHOUSEROOM", "IDHOUSEROOM",
                $HOUSEROOM['IDHOUSEROOM'])?
                    nop123("Комната в доме обновлена\n"):'';
            }
        }
    break;


    #   ЗЕМЛЯ
    case 'PARCEL':
    unset($ALLOWED_REALESTATE_PARCEL['ИДЕНТИФИКАТОР']);
    update($con, $ALLOWED_REALESTATE_PARCEL, $ИМУЩЕСТВО, "REALESTATEPARCEL", "ИДЕНТИФИКАТОР", $ИДЕНТИФИКАТОР)?
        nop123("Земля обновлена\n"):'';

    if (isset($ИМУЩЕСТВО['HOZBUILDING'])) {
        foreach ($ИМУЩЕСТВО['HOZBUILDING'] as $PARCELHOZBUILDING) {
            if (isset($PARCELHOZBUILDING['STATUS'])) {
                switch ($PARCELHOZBUILDING['STATUS']) {
                    case 'NEW':
                    $PARCELHOZBUILDING['ИДЕНТИФИКАТОР'] = $ИДЕНТИФИКАТОР;
                    $ALLOWED_REALESTATE_PARCEL_HOZBUILDING['ИДЕНТИФИКАТОР'] = 'i';
                    insert($con, $ALLOWED_REALESTATE_PARCEL_HOZBUILDING,
                        $PARCELHOZBUILDING, 'REALESTATEPARCELHOZBUILDING')
                        ? nop123("Хозпостройка на земельном участке добавлена.\n"):'';
                    break;
                case 'DELETE':
                    $con->query("DELETE FROM REALESTATEPARCELHOZBUILDING WHERE IDPARCELHOZBUILDING = " .
                                $PARCELHOZBUILDING['IDPARCELHOZBUILDING'])?
                        nop123("Хозпастройка удалена\n"):'';
                    break;
                }

            } else {
                unset($ALLOWED_REALESTATE_PARCEL_HOZBUILDING['ИДЕНТИФИКАТОР']);
                update($con, $ALLOWED_REALESTATE_PARCEL_HOZBUILDING, $PARCELHOZBUILDING, "REALESTATEPARCELHOZBUILDING", "IDPARCELHOZBUILDING",
                    $PARCELHOZBUILDING['IDPARCELHOZBUILDING'])?
                    nop123("Хозяйственная постройка обновлена\n"):'';
            }
        }
    }

    if (isset($ИМУЩЕСТВО['PLANT'])) {
        foreach ($ИМУЩЕСТВО['PLANT'] as $PARCELPLANT) {
            if (isset($PARCELPLANT['STATUS'])) {
                switch ($PARCELPLANT['STATUS']) {
                    case 'NEW':
                        $PARCELPLANT['ИДЕНТИФИКАТОР'] = $ИДЕНТИФИКАТОР;
                        $ALLOWED_REALESTATE_PARCEL_PLANT['ИДЕНТИФИКАТОР'] = 'i';
                        insert($con, $ALLOWED_REALESTATE_PARCEL_PLANT,
                            $PARCELPLANT, 'REALESTATEPARCELPLANT')
                            ? nop123("Растение на земельном участке добавлено.\n"):'';

                    break;
                    case 'DELETE':
                        $con->query("DELETE FROM REALESTATEPARCELPLANT WHERE IDPARCELPLANT = " .
                                    $PARCELPLANT['IDPARCELPLANT'])?
                            nop123("Растение удалено\n"):'';
                    break;
                }
            } else {
                unset($ALLOWED_REALESTATE_PARCEL_PLANT['ИДЕНТИФИКАТОР']);
                update($con, $ALLOWED_REALESTATE_PARCEL_PLANT, $PARCELPLANT, "REALESTATEPARCELPLANT", "IDPARCELPLANT",
                $PARCELPLANT['IDPARCELPLANT'])?
                    nop123("Растение обновлена\n"):'';
            }
        }
    }
    break;


    # ГАРАЖЕМЕСТО
    case 'GARAGE':
        unset($ALLOWED_REALESTATE_GARAGE['ИДЕНТИФИКАТОР']);
        update($con, $ALLOWED_REALESTATE_GARAGE, $ИМУЩЕСТВО, "REALESTATEGARAGE", "ИДЕНТИФИКАТОР", $ИДЕНТИФИКАТОР)?
            nop123("Гараж \ Машиноместо обновлено\n"):'';
    break;


    # ПОМЕЩЕНИЕ
    case 'ROOM':
        unset($ALLOWED_REALESTATE_ROOM['ИДЕНТИФИКАТОР']);
        update($con, $ALLOWED_REALESTATE_ROOM, $ИМУЩЕСТВО, "REALESTATEROOM", "ИДЕНТИФИКАТОР", $ИДЕНТИФИКАТОР)?
            nop123("Помещение обновлено\n"):'';
        
        if  ( ! isset($ИМУЩЕСТВО['ROOM'])) {
            break;
        }

        foreach ($ИМУЩЕСТВО['ROOM'] as $ROOM) {
            if (isset($ROOM['STATUS'])) {
                switch ($ROOM['STATUS']) {
                    case 'NEW':
                        $ROOM['ИДЕНТИФИКАТОР'] = $ИДЕНТИФИКАТОР;
                        $ALLOWED_REALESTATE_ROOMMORE['ИДЕНТИФИКАТОР'] = 'i';
                        inset($con, $ALLOWED_REALESTATE_ROOMMORE, $ROOM, 'REALESTATEROOMMORE')?
                            nop123("Комната в помещении добавлена.\n"):'';                break;
                case 'DELETE':
                    $con->query("DELETE FROM REALESTATEROOMMORE WHERE IDROOMMORE = " . $ROOM['IDROOMMORE'])?
                        nop123("Комната в помещении удалена\n"):'';
                break;
                }
            
            } else {
                unset($ALLOWED_REALESTATE_ROOMMORE['ИДЕНТИФИКАТОР']);
                update($con, $ALLOWED_REALESTATE_ROOMMORE, $ROOM, "REALESTATEROOMMORE", "IDROOMMORE", $ROOM['IDROOMMORE'])?
                    nop123("Комната в помещении обновлена\n"):'';
            }
        }
    break;


    # ГОСТИНИЦА
    case 'HOTEL':
        unset($ALLOWED_REALESTATE_HOTEL['ИДЕНТИФИКАТОР']);
        update($con, $ALLOWED_REALESTATE_HOTEL, $ИМУЩЕСТВО, "REALESTATEHOTEL", "ИДЕНТИФИКАТОР", $ИДЕНТИФИКАТОР)?
            nop123("Гостиница обновлена\n"):'';
        
        if  ( ! isset($ИМУЩЕСТВО['ROOM'])) {
            break;
        }
        
        foreach ($ИМУЩЕСТВО['ROOM'] as $ROOM) {
            if (isset($ROOM['STATUS'])) {
                switch ($ROOM['STATUS']) {
                    case 'NEW':
                        $ROOM['ИДЕНТИФИКАТОР'] = $ИДЕНТИФИКАТОР;
                        $ALLOWED_REALESTATE_HOTEL_ROOM['ИДЕНТИФИКАТОР'] = 'i';
                        insert($con, $ALLOWED_REALESTATE_HOTEL_ROOM, $ROOM, 'REALESTATEHOTELROOM')?
                            nop123("Комната в отеле добавлена.\n"):'';
                    break;
                    case 'DELETE':
                        $con->query("DELETE FROM REALESTATEHOTELROOM WHERE IDHOTELROOM = " . $ROOM['IDHOTELROOM'])?
                            nop123("Комната в гостинице удалена\n"):'';
                    break;
                }
            
            } else {
                unset($ALLOWED_REALESTATE_HOTEL_ROOM['ИДЕНТИФИКАТОР']);
                update($con, $ALLOWED_REALESTATE_HOTEL_ROOM, $ROOM, "REALESTATEHOTELROOM", "IDHOTELROOM", $ROOM['IDHOTELROOM'])?
                    nop123("Комната в гостинице обновлена\n"):'';
            }
        }
    break;

    # другое
    case 'OTHER':
        unset($ALLOWED_REALESTATE_OTHER['ИДЕНТИФИКАТОР']);
        update($con, $ALLOWED_REALESTATE_OTHER, $ИМУЩЕСТВО, "REALESTATEOTHER", "ИДЕНТИФИКАТОР", $ИДЕНТИФИКАТОР)?
            nop123("Другое обновлено\n"):'';

        if ( ! isset($ИМУЩЕСТВО['ЗДАНИЕ'])) {
            break;
        }
        foreach ($ИМУЩЕСТВО['ЗДАНИЕ'] as $OTHERBUILDING) {
            IF (isset($OTHERBUILDING['STATUS'])) {
                switch ($OTHERBUILDING['STATUS']) {
                    case 'NEW':
                        $OTHERBUILDING['ИДЕНТИФИКАТОР'] = $ИДЕНТИФИКАТОР;
                        $ALLOWED_REALESTATE_OTHER_BUILDING['ИДЕНТИФИКАТОР']='i';
                        insert($con, $ALLOWED_REALESTATE_OTHER_BUILDING, $OTHERBUILDING,
                            'REALESTATEOTHERBUILDING')?
                            nop123("Здание добавлено.\n"):'';
                        $IDBUILDING = $con->insert_id;
                        
                        if (isset($OTHERBUILDING['ROOM'])) {
                            foreach ($OTHERBUILDING['ROOM'] as $ROOM) {
                                $ROOM['IDOTHERBUILDING'] = $IDBUILDING;
                                $ALLOWED_REALESTATE_OTHER_BUILDING_ROOM['IDOTHERBUILDING']='i';
                                insert($con, $ALLOWED_REALESTATE_OTHER_BUILDING_ROOM, $ROOM,
                                    'REALESTATEOTHERBUILDINGROOM')?
                                    nop123("Помещение в здании добавлено.\n"):'';
                            }
                        }
                    break;
                    // !!! УЯЗВИМОСТЬ - ПЕРЕДЕЛАТЬ УДАЛЕНИЕ ЧЕРЕЗ ПОДГАТАВЛИВАЕМЫЙ ЗАПРОС!
                    case 'DELETE':
                        $con->query("DELETE FROM REALESTATEOTHERBUILDING WHERE IDOTHERBUILDING = " .
                                    $OTHERBUILDING['IDOTHERBUILDING'])?
                            nop123("Здание в другом удалено\n"):'';
                        
                        if (isset($OTHERBUILDING['ROOM'])) {
                            $query = "DELETE FROM REALESTATEOTHERBUILDINGROOM";
                            $where = " WHERE";
                            $length = count($OTHERBUILDING['ROOM']);
                            $j = 1;
                            foreach ($OTHERBUILDING['ROOM'] as $ROOM) {   
                                $where .= " IDOTHERBUILDINGROOM=" . $ROOM['IDOTHERBUILDINGROOM'];
                                if ($j + 1 <= $length) {
                                    $where .= " OR";
                                }
                                $j++;
                            }
                        }
                        $query .= $where;
                        $con->query($query)?
                            nop123("Комната в здании другого удалена\n"):'';
                    break;
                }
            
            }    ELSE    {
                unset($ALLOWED_REALESTATE_OTHER_BUILDING['ИДЕНТИФИКАТОР']);
                update($con, $ALLOWED_REALESTATE_OTHER_BUILDING, $OTHERBUILDING,
                    "REALESTATEOTHERBUILDING", "IDOTHERBUILDING",
                    $OTHERBUILDING['IDOTHERBUILDING'])?
                    nop123("Здание в другом обновлено\n"):'';
                
                if (isset($OTHERBUILDING['ROOM'])) {
                    foreach ($OTHERBUILDING['ROOM'] as $ROOM) {
                        IF (isset($ROOM['STATUS'])) {
                            switch ($ROOM['STATUS']) {
                                case 'NEW':
                                    $ROOM['IDOTHERBUILDING'] = $OTHERBUILDING['IDOTHERBUILDING'];
                                    $ALLOWED_REALESTATE_OTHER_BUILDING_ROOM['IDOTHERBUILDING']='i';
                                    insert($con, $ALLOWED_REALESTATE_OTHER_BUILDING_ROOM,
                                        $ROOM, 'REALESTATEOTHERBUILDINGROOM')?
                                        nop123("Помещение в здании добавлено.\n"):'';
                                break;
                                case 'DELETE':
                                    $con->query("DELETE FROM REALESTATEOTHERBUILDINGROOM WHERE IDOTHERBUILDINGROOM = " .
                                                $ROOM['IDOTHERBUILDINGROOM'])?
                                        nop123("Комната в здании другого удалена\n"):'';
                                break;
                            }
                        }   ELSE   {
                            unset($ALLOWED_REALESTATE_OTHER_BUILDING_ROOM['IDOTHERBUILDING']);
                            update($con, $ALLOWED_REALESTATE_OTHER_BUILDING_ROOM, $ROOM,
                                "REALESTATEOTHERBUILDINGROOM", "IDOTHERBUILDINGROOM",
                                $ROOM['IDOTHERBUILDINGROOM'])?
                                nop123("Комната в здании другого обновлена\n"):'';
                        }
                    }

                }
            }
        }
    break;
    }#end switch
    }#end IF isset property

    $con->close();
} catch (Exception $e) {
	echo false;
	exit;
}

echo true;

//$time = microtime(true) - $start;
//nop123("\nСкрипт выполнялся %.4F сек.", $time);
?>