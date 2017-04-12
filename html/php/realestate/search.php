<?php
ini_set('error_reporting', E_ALL);
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);

header("Content-Type: application/json");
include_once $_SERVER['DOCUMENT_ROOT'].'/php/properties.php';
include_once $_SERVER['DOCUMENT_ROOT'].'/php/functions.php';
include_once $_SERVER['DOCUMENT_ROOT'].'/php/allowed.php';

# *** ОЧЕНЬ НУЖНЫ ПРОВЕРКИ БЕЗОПАСТНОСТИ !!!
# *** ОЧЕНЬ НУЖНЫ ПРОВЕРКИ БЕЗОПАСТНОСТИ !!!
# *** ОЧЕНЬ НУЖНЫ ПРОВЕРКИ БЕЗОПАСТНОСТИ !!!
# *** ОЧЕНЬ НУЖНЫ ПРОВЕРКИ БЕЗОПАСТНОСТИ !!!

$ДАННЫЕ = json_decode(file_get_contents('php://input'), true);
# Адрес
if ( ! isset($ДАННЫЕ['PLACE']['address_components'])) {
    $ДАННЫЕ = '';
    $ДАННЫЕ['STATUS'] = $SEARCH['STATUS']['NOADDRESS'];
    echo json_encode(array_filter($ДАННЫЕ), JSON_UNESCAPED_UNICODE | JSON_FORCE_OBJECT);
    exit;
}
if ( ! isset($ДАННЫЕ['НЕДВИЖИМОСТЬ']['ИМУЩЕСТВО'])) {
    $ДАННЫЕ = '';
    $ДАННЫЕ['STATUS'] = $SEARCH['STATUS']['NOPROPERTY'];
    echo json_encode(array_filter($ДАННЫЕ), JSON_UNESCAPED_UNICODE | JSON_FORCE_OBJECT);
    exit;
}



# Адрес
$WHERE = 'WHERE ';
for ( $i = 0, $length = count($ДАННЫЕ['PLACE']['address_components']); $i < $length; $i++ ) {
    $name = $ДАННЫЕ['PLACE']['address_components'][$i]['long_name'];
    $WHERE .= "IDPLACE IN ( SELECT IDPLACE FROM ADDRESS_COMPONENTS WHERE long_name = '$name')";
    if ($i+1 < $length) {
        $WHERE .= ' AND ';
    } 
}
# Тип сделки
$ANDDEAL = '';
if (isset($ДАННЫЕ['НЕДВИЖИМОСТЬ']['DEAL'])) {
    $ANDDEAL = $ДАННЫЕ['НЕДВИЖИМОСТЬ']['DEAL'];
    $ANDDEAL = "AND НЕДВИЖИМОСТЬ.DEAL = '$ANDDEAL'";
}
# Тип недвижимости
$ANDAPARTMENT = '';
if (isset($ДАННЫЕ['НЕДВИЖИМОСТЬ']['ИМУЩЕСТВО'])) {
    $ANDAPARTMENT = $ДАННЫЕ['НЕДВИЖИМОСТЬ']['ИМУЩЕСТВО'];
    $ANDAPARTMENT = "AND НЕДВИЖИМОСТЬ.ИМУЩЕСТВО = '$ANDAPARTMENT'";
}
# Цена
# Если установлен чекбокс "По договоренности" - выводим недвижимости только "по договренности", 
# Иначе если установлены границы цен "от и до", то выводим недвижимости с ценами "от и до",
# включая те что "по договренности"
# Если указана цена только "от" то выводим только недвижимости с ценами "от", аналогично с "до",
# также включая те что "по договренности"
#
# Сконвектировать валюты диапазона "От" и "До" в валюты RUB, USD, EUR, CNY 
# относительно валюты присылаемой в JSON
# сколько можно обменять валюты на одну еденицу валюты из массива ...
$RUB = [
    '₽' => 1,
    '$' => 62.9049506,
    '€' => 69.1073788,
    '¥' => 9.32886708
];
$USD = [
    '₽' => 0.015897,
    '$' => 1,
    '€' => 1.0986,
    '¥' => 0.15
];
$EUR = [
    '₽' => 0.015,
    '$' => 0.91,
    '€' => 1,
    '¥' => 0.13
];
$CNY = [
    '₽' => 0.015,
    '$' => 0.91,
    '€' => 7.42,
    '¥' => 1
];

if ( ! isset($ДАННЫЕ['НЕДВИЖИМОСТЬ']['CURRENCY'])) {
    $CURRENCY = '₽';    
} else {
    $CURRENCY = $ДАННЫЕ['НЕДВИЖИМОСТЬ']['CURRENCY'];    
}

$ANDPRICE = '';
$isFROM = false;
$isTO = false;
if (isset($ДАННЫЕ['НЕДВИЖИМОСТЬ']['PRICEFROM']) && is_numeric($ДАННЫЕ['НЕДВИЖИМОСТЬ']['PRICEFROM'])) {
    $isFROM = true;
    $SPACE_RUB_FROM = $ДАННЫЕ['НЕДВИЖИМОСТЬ']['PRICEFROM'] * $RUB[$CURRENCY];
    $SPACE_USD_FROM = $ДАННЫЕ['НЕДВИЖИМОСТЬ']['PRICEFROM'] * $USD[$CURRENCY];
    $SPACE_EUR_FROM = $ДАННЫЕ['НЕДВИЖИМОСТЬ']['PRICEFROM'] * $EUR[$CURRENCY];
    $SPACE_CNY_FROM = $ДАННЫЕ['НЕДВИЖИМОСТЬ']['PRICEFROM'] * $CNY[$CURRENCY];
}
if (isset($ДАННЫЕ['НЕДВИЖИМОСТЬ']['PRICETO']) && is_numeric($ДАННЫЕ['НЕДВИЖИМОСТЬ']['PRICETO'])) {
    $isTO = true;
    $SPACE_RUB_TO = $ДАННЫЕ['НЕДВИЖИМОСТЬ']['PRICETO'] * $RUB[$CURRENCY];
    $SPACE_USD_TO = $ДАННЫЕ['НЕДВИЖИМОСТЬ']['PRICETO'] * $USD[$CURRENCY];
    $SPACE_EUR_TO = $ДАННЫЕ['НЕДВИЖИМОСТЬ']['PRICETO'] * $EUR[$CURRENCY];
    $SPACE_CNY_TO = $ДАННЫЕ['НЕДВИЖИМОСТЬ']['PRICETO'] * $CNY[$CURRENCY];
}
if (isset($ДАННЫЕ['НЕДВИЖИМОСТЬ']['АТРИБУТЫ']['ISBYAGREEMENT'])
    && $ДАННЫЕ['НЕДВИЖИМОСТЬ']['АТРИБУТЫ']['ISBYAGREEMENT'] == 1) {
    $ANDPRICE = "AND find_in_set('ISBYAGREEMENT', НЕДВИЖИМОСТЬ.АТРИБУТЫ) > 0";
} else {
    if ($isFROM && $isTO) {
        $ANDPRICE =
        "AND ((ЦЕНА >= $SPACE_RUB_FROM AND ЦЕНА <= $SPACE_RUB_TO AND CURRENCY = '₽') OR
              (ЦЕНА >= $SPACE_USD_FROM AND ЦЕНА <= $SPACE_USD_TO AND CURRENCY = '$') OR
              (ЦЕНА >= $SPACE_EUR_FROM AND ЦЕНА <= $SPACE_EUR_TO AND CURRENCY = '€') OR
              (ЦЕНА >= $SPACE_CNY_FROM AND ЦЕНА <= $SPACE_CNY_TO AND CURRENCY = '¥') OR
              find_in_set('ISBYAGREEMENT', НЕДВИЖИМОСТЬ.АТРИБУТЫ) > 0)";
    }
    if ($isFROM && ! $isTO) {
        $ANDPRICE =
        "AND ((ЦЕНА >= $SPACE_RUB_FROM AND CURRENCY = '₽') OR
              (ЦЕНА >= $SPACE_USD_FROM AND CURRENCY = '$') OR
              (ЦЕНА >= $SPACE_EUR_FROM AND CURRENCY = '€') OR
              (ЦЕНА >= $SPACE_CNY_FROM AND CURRENCY = '¥') OR
              find_in_set('ISBYAGREEMENT', НЕДВИЖИМОСТЬ.АТРИБУТЫ) > 0)";
    }
    if ( ! $isFROM && $isTO) {
        $ANDPRICE =
        "AND ((ЦЕНА <= $SPACE_RUB_TO AND CURRENCY = '₽') OR
              (ЦЕНА <= $SPACE_USD_TO AND CURRENCY = '$') OR
              (ЦЕНА <= $SPACE_EUR_TO AND CURRENCY = '€') OR
              (ЦЕНА <= $SPACE_CNY_TO AND CURRENCY = '¥') OR
              find_in_set('ISBYAGREEMENT', НЕДВИЖИМОСТЬ.АТРИБУТЫ) > 0)";
    }
}

# Площадь
$ANDSPACE = '';
$isFROM = false;
$isTO = false;

if (isset($ДАННЫЕ['НЕДВИЖИМОСТЬ']['SPACEFROM']) && is_numeric($ДАННЫЕ['НЕДВИЖИМОСТЬ']['SPACEFROM'])) {
    $isFROM = true;
    $SPACEFROM = $ДАННЫЕ['НЕДВИЖИМОСТЬ']['SPACEFROM'];
}
if (isset($ДАННЫЕ['НЕДВИЖИМОСТЬ']['SPACETO']) && is_numeric($ДАННЫЕ['НЕДВИЖИМОСТЬ']['SPACETO'])) {
    $isTO = true;
    $SPACETO = $ДАННЫЕ['НЕДВИЖИМОСТЬ']['SPACETO'];
}
if ($isFROM && $isTO) {
    $ANDSPACE = "AND (SPACETOTAL >= $SPACEFROM AND SPACETOTAL <= $SPACETO)";
}
if ($isFROM && ! $isTO) {
    $ANDSPACE = "AND SPACETOTAL >= $SPACEFROM";
}
if ( ! $isFROM && $isTO) {
    $ANDSPACE = "AND SPACETOTAL <= $SPACETO";
}
# Чекбоксы
$ANDCHECKBOXES = '';
if (isset($ДАННЫЕ['НЕДВИЖИМОСТЬ']['АТРИБУТЫ']) && count($ДАННЫЕ['НЕДВИЖИМОСТЬ']['АТРИБУТЫ']) > 0) {
    $АТРИБУТЫ = setForSelectCheckbox($ALLOWED_REALESTATE['АТРИБУТЫ'], $ДАННЫЕ['НЕДВИЖИМОСТЬ']['АТРИБУТЫ']);
    if ($АТРИБУТЫ) {
        $ANDCHECKBOXES = "AND $АТРИБУТЫ";
    }
}
# Подключаемая дополнительная таблица недвижимости
$ИМУЩЕСТВО = $ДАННЫЕ['НЕДВИЖИМОСТЬ']['ИМУЩЕСТВО'];
$SELECT = [
    'APARTMENT'=>['APARTMENTINTEGRITY',
                 'APARTMENTQUANTITYROOMS',
                 'APARTMENTTYPEHOUSE',
                 'APARTMENTNUMBEROFSTOREYS',
                 'APARTMENTFLOOR',
                 'APARTMENTOWNEDROOMS']
];

$SELECTSTRING = implode($SELECT[$ИМУЩЕСТВО], ',');
# Сам запрос
$QUERY = 
"SELECT DEAL, ИМУЩЕСТВО, SPACETOTAL, NAME as `АДРЕС`,
         ЦЕНА, CURRENCY, НЕДВИЖИМОСТЬ.АТРИБУТЫ as `АТРИБУТЫ`, NUMBER,
         lat, lng, USER.ID as `IDUSER`, НЕДВИЖИМОСТЬ.ИДЕНТИФИКАТОР as `ИДЕНТИФИКАТОР`, TEXT,
         $SELECTSTRING
FROM НЕДВИЖИМОСТЬ
INNER JOIN НЕДВИЖИМОСТЬ$ИМУЩЕСТВО ON НЕДВИЖИМОСТЬ.ИДЕНТИФИКАТОР = НЕДВИЖИМОСТЬ$ИМУЩЕСТВО.ИДЕНТИФИКАТОР
INNER JOIN PLACE ON НЕДВИЖИМОСТЬ.IDPLACE = PLACE.IDPLACE 
INNER JOIN USER ON НЕДВИЖИМОСТЬ.IDUSER = USER.ID
WHERE НЕДВИЖИМОСТЬ.IDPLACE IN (SELECT distinct IDPLACE FROM ADDRESS_COMPONENTS $WHERE)
$ANDDEAL
$ANDAPARTMENT
$ANDPRICE
$ANDSPACE
$ANDCHECKBOXES
LIMIT 10";


# соединямся с БД
$con = new mysqli($host, $user, $password, $dbname, $port, $socket);
if ($con->connect_error) error($con->connect_error);


$ДАННЫЕ = '';
$result = $con->query($QUERY)
    or error('Не удалось выполнить запрос');

while ($row = $result->fetch_assoc()) {
    $row = array_filter($row, 'filter');
    $path = $PATHPHOTO . $row['IDUSER'] .'/'. $row['NUMBER'] . '/200';
    if (file_exists($path)) {
        $row['ФОТОГРАФИИ'] = array_slice(scandir($path), 2);
    }
    $length = count($SELECT[$ИМУЩЕСТВО]);
    for ($i = 0; $i < $length; $i++) {
        if (isset($row[$SELECT[$ИМУЩЕСТВО][$i]])) {
            $row[$ИМУЩЕСТВО][$SELECT[$ИМУЩЕСТВО][$i]] = $row[$SELECT[$ИМУЩЕСТВО][$i]];
        }
        unset($row[$SELECT[$ИМУЩЕСТВО][$i]]);
    }
    $ДАННЫЕ['НЕДВИЖИМОСТЬ'][] = $row; 
}
if (isset($ДАННЫЕ['НЕДВИЖИМОСТЬ']) && count($ДАННЫЕ['НЕДВИЖИМОСТЬ']) > 0) {
    $ДАННЫЕ['STATUS'] = $SEARCH['STATUS']['OK'];
} else {
    $ДАННЫЕ['STATUS'] = $SEARCH['STATUS']['NOTFOUND'];
}
$result->close();


$con->close();

# отдаем JSON
echo json_encode(array_filter($ДАННЫЕ, 'filter'), JSON_UNESCAPED_UNICODE | JSON_FORCE_OBJECT);
?>