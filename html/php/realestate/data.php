<?php
ini_set('error_reporting', E_ALL);
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);

# Запретить кеширование!
header("Content-Type: application/json");

# ПРОВЕРКИ БЕЗОПАСТНОСТИ

if ( ! isset($_POST['id'])) {
    
    echo 1;
    exit;
    
}


if ( ! is_numeric($_POST['id'])) {
   
    echo 2;
    exit;

}

# для тестирования я использовал гет поэтому вот так
$_GET['id'] = $_POST['id'];
$ДАННЫЕ = [];

# Вообще проверять бы id и hash на правильность
# (id должна быть только цыфрой, а hash только большие буквы и цыфры)
# и только потом делать запросы

// if ( isset($_COOKIE['ID']) && isset($_COOKIE['HASH']) ) {
    
//     # Соединямся с БД
//     include_once $_SERVER['DOCUMENT_ROOT'].'/php/properties.php';
//     include_once $_SERVER['DOCUMENT_ROOT'].'/php/functions.php';
//     include_once $_SERVER['DOCUMENT_ROOT'].'/php/allowed.php';
//     $con = new mysqli($host, $user, $password, $dbname, $port, $socket)
//         or die ('Could not connect to the database server' . mysqli_connect_error());

    
//     # проверяем существование пользователя
//     $query = "SELECT ID FROM USER WHERE ID="
//     .$con->real_escape_string($_COOKIE['ID']) . " and HASH='"
//     .$con->real_escape_string($_COOKIE['HASH'])
//     ."' LIMIT 1";
  
//     if ($result = $con->query($query)) {
//         if( ! $USER = $result->fetch_object()) {
//             echo 3;
//             exit;
        
//         }
//         $result->close();
//     }
    
// } else {
//     echo 4;
//     exit;
    
// }

# Соединямся с БД
include_once $_SERVER['DOCUMENT_ROOT'].'/php/properties.php';
include_once $_SERVER['DOCUMENT_ROOT'].'/php/functions.php';
include_once $_SERVER['DOCUMENT_ROOT'].'/php/allowed.php';
$con = new mysqli($host, $user, $password, $dbname, $port, $socket)
    or die ('Could not connect to the database server' . mysqli_connect_error());


# делаем запрос на недвижимость
$ALLOWED_REALESTATE['ИДЕНТИФИКАТОР']='i';
$НЕДВИЖИМОСТЬ = select($con, $ALLOWED_REALESTATE, '*', 'НЕДВИЖИМОСТЬ',
        ['ИДЕНТИФИКАТОР'=>$_GET['id']], 'LIMIT 1')[0]
    or error('У этого пользователя нет такой недвижимости');

# определяем тип недвижимости
$query1 = "";
$query2 = "";
$query22 = "";
$query3 = "";

$table2 = "";
$table22 = "";
$table3 = "";

switch ($НЕДВИЖИМОСТЬ['ИМУЩЕСТВО']) {
    case 'APARTMENT': $query1 = "REALESTATEAPARTMENT";
            $query2 = "SELECT * FROM REALESTATEAPARTMENTROOM WHERE ИДЕНТИФИКАТОР = ";
            $table2 = "ROOM";
    break;
    case 'HOUSE': $query1 = "REALESTATEHOUSE";
            $query2 = "SELECT * FROM REALESTATEHOUSEROOM WHERE ИДЕНТИФИКАТОР = ";
            $table2 = "ROOM";
    break;
    case 'PARCEL': $query1 = "REALESTATEPARCEL";
            $query2 = "SELECT * FROM REALESTATEPARCELHOZBUILDING WHERE ИДЕНТИФИКАТОР = ";
            $query3 = "SELECT * FROM REALESTATEPARCELPLANT WHERE ИДЕНТИФИКАТОР = ";
            $table2 = "HOZBUILDING";
            $table3 = "PLANT";
    break;
    case 'GARAGE': $query1 = "REALESTATEGARAGE";
    break;
    case 'ROOM': $query1 = "REALESTATEROOM";
            $query2 = "SELECT * FROM REALESTATEROOMMORE WHERE ИДЕНТИФИКАТОР = ";
            $table2 = "ROOM";
    break;
    case 'HOTEL': $query1 = "REALESTATEHOTEL";
            $query2 = "SELECT * FROM REALESTATEHOTELROOM WHERE ИДЕНТИФИКАТОР = ";
            $table2 = "ROOM";
    break;
    case 'OTHER': $query1 = "REALESTATEOTHER";
            $query2 = "SELECT * FROM REALESTATEOTHERBUILDING WHERE ИДЕНТИФИКАТОР = ";
            $query22 = "SELECT * FROM REALESTATEOTHERBUILDINGROOM WHERE IDOTHERBUILDING = ";
            $table2 = "ЗДАНИЕ";
            $table22 = "ROOM";
    break;
}

# если тип недвижимости есть, то запрашиваем данные определенной недвижимости
$REALESTATEPROPERTY = [];

if ($НЕДВИЖИМОСТЬ['ИМУЩЕСТВО']) {

    if ($query1) {
        $query = "SELECT * FROM $query1 WHERE ИДЕНТИФИКАТОР = " . $_GET['id'] . " LIMIT 1";
        if ($result = $con->query($query)) {
            if ( ! $REALESTATEPROPERTY = $result->fetch_assoc()) {
                $REALESTATEPROPERTY = [];
            }
            $result->close();
        }
        
    }
    
    
    # Запрос всяких комнат и подкомнат определенной недвижимости
    if (isset($REALESTATEPROPERTY["ИДЕНТИФИКАТОР"])) {
        $REALESTATETABLE2 = [];
        if ($query2) {
            $query2 .= $REALESTATEPROPERTY["ИДЕНТИФИКАТОР"];
            if ($result = $con->query($query2)) {
                $i = 1;
                while ($TABLE = $result->fetch_assoc()) {
                
                    $REALESTATETABLE2[$i] = array_filter($TABLE, 'filter');
                
                    # Только для "Другой" недвижимости
                    if ($query22) {
                        $query = $query22 . $TABLE["IDOTHERBUILDING"];
                        if ($result1 = $con->query($query)) {
                            $j = 1;
                            while ($TABLE1 = $result1->fetch_assoc()) {
                                $REALESTATETABLE2[$i][$table22][$j] = array_filter($TABLE1, 'filter');
                                $j++;
                            }
                            $result1->close();    
                        }
                    }
                    $i++;
                }
                $result->close();
            }
        }
        
        #запрашиваем вторые комнаты определенной недвижимости
        #Только для земельного участка
        $REALESTATETABLE3 = [];
        if ($query3) {
            $query3 .= $REALESTATEPROPERTY["ИДЕНТИФИКАТОР"];
            if ($result = $con->query($query3)) {
                $i = 1;
                while ($TABLE = $result->fetch_assoc()) {
                    $REALESTATETABLE3[$i] = array_filter($TABLE, 'filter');
                    $i++;
                }
                $result->close();
            }
            
        }
        unset($REALESTATEPROPERTY["ID"]);
    }
}

# достать name and vicinity
$query = "SELECT name, vicinity, lat, lng, types, formatted_address FROM PLACE WHERE IDPLACE='"
        . $con->real_escape_string($НЕДВИЖИМОСТЬ['IDPLACE'])
        . "' LIMIT 1";

if ($result = $con->query($query)) {
    $ДАННЫЕ['PLACE'] = $result->fetch_assoc();
    $result->close();
}

# МАРКЕРЫ
$query = "SELECT `NAME`, `LAT`, `LNG` FROM realestate.MARKER WHERE ИДЕНТИФИКАТОР = 1";
if ($result = $con->query($query)) {
        
    while ($МАРКЕРЫ = $result->fetch_array()) {
        
        $ДАННЫЕ['МАРКЕРЫ'][] = ['LAT' => $МАРКЕРЫ['LAT'],
                                    'LNG' => $МАРКЕРЫ['LNG'],
                                    'NAME' => $МАРКЕРЫ['NAME']];
        
    }

    $result->close();
}


# ПОЛИГОНЫ
$query = "SELECT `NUMBER`, `LAT`, `LNG` FROM realestate.POLYGON where ИДЕНТИФИКАТОР = 1";
if ($result = $con->query($query)) {
        
    while ($ПОЛИГОНЫ = $result->fetch_array()) {
        
        $ДАННЫЕ['ПОЛИГОНЫ'][$ПОЛИГОНЫ['NUMBER']][] = ['LAT' => $ПОЛИГОНЫ['LAT'],
                                                          'LNG' => $ПОЛИГОНЫ['LNG']];
        
    }

    $result->close();
}

$con->close();

unset($REALESTATEPROPERTY['ИДЕНТИФИКАТОР']);

# Склеиваем результаты
$ДАННЫЕ['НЕДВИЖИМОСТЬ'] = $НЕДВИЖИМОСТЬ;
$ДАННЫЕ['НЕДВИЖИМОСТЬ'][$НЕДВИЖИМОСТЬ['ИМУЩЕСТВО']] =  $REALESTATEPROPERTY;
if (isset($REALESTATETABLE2)) {
    $ДАННЫЕ['НЕДВИЖИМОСТЬ'][$НЕДВИЖИМОСТЬ['ИМУЩЕСТВО']][$table2] = $REALESTATETABLE2;
}
if (isset($REALESTATETABLE3)) {
    $ДАННЫЕ['НЕДВИЖИМОСТЬ'][$НЕДВИЖИМОСТЬ['ИМУЩЕСТВО']][$table3] = $REALESTATETABLE3;
}


/*
    Список имен фоток
*/

$path = $PATHPHOTO . $НЕДВИЖИМОСТЬ['IDUSER'] .'/'. $НЕДВИЖИМОСТЬ['NUMBER'] . '/600';
if (file_exists($path)) {
    $ДАННЫЕ['ФОТОГРАФИИ'] = scandir($path, SCANDIR_SORT_NONE);;
}
$ДАННЫЕ['PLACE'] = array_filter($ДАННЫЕ['PLACE'], 'filter');
$ДАННЫЕ['НЕДВИЖИМОСТЬ'] = array_filter($ДАННЫЕ['НЕДВИЖИМОСТЬ'], 'filter');
$ДАННЫЕ['НЕДВИЖИМОСТЬ'][$НЕДВИЖИМОСТЬ['ИМУЩЕСТВО']] = array_filter($ДАННЫЕ['НЕДВИЖИМОСТЬ'][$НЕДВИЖИМОСТЬ['ИМУЩЕСТВО']], 'filter');
# отдаем JSON
echo json_encode(array_filter($ДАННЫЕ, 'filter'), JSON_UNESCAPED_UNICODE | JSON_FORCE_OBJECT);
?>