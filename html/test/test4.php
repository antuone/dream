<?php





$start = microtime(true);
ini_set('error_reporting', E_ALL);
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);

include_once $_SERVER['DOCUMENT_ROOT'].'/php/allowed.php';
include_once $_SERVER['DOCUMENT_ROOT'].'/php/functions.php';

# Соединямся с БД
include_once $_SERVER['DOCUMENT_ROOT'].'/php/properties.php';
$CON = new mysqli($host, $user, $password, $dbname, $port, $socket)
	or die ('Could not connect to the database server' . mysqli_connect_error());

$DEAL = ['SELL', 'BUY', 'EXCHANGE', 'SELLRENT', 'BUYRENT'];
$ИМУЩЕСТВО = ['APARTMENT', 'HOUSE', 'PARCEL', 'GARAGE', 'ROOM', 'HOTEL', 'OTHER'];
$CURRENCY = ['₽', '$', '€', '¥'];

$NAME = ['Хорошая недвижимость',
		 'Крутая недвижимость',
		 'Офегенная недвижимость',
		 'Продам быстро',
		 'Недвижимость у берега моря',
		 'Купите недвижимость',
		 'Умная недвижимость',
		 'Солнечная недвижимость',
		 'Купите рай',
		 'Вы не пожалеете'];

$SOURCEREALESTATE = [
'IDUSER' => 5,
'IDPLACE' => mt_rand(1,100),
'NAME' => $NAME[mt_rand(0,9)],
'DEAL' => $DEAL[mt_rand(0,4)],
'ИМУЩЕСТВО' => $ИМУЩЕСТВО[mt_rand(0,6)],
'ЦЕНА' => mt_rand(1000000,7000000),
'CURRENCY' => $CURRENCY[mt_rand(0,3)],
'CADASTRNUMBER' => 'АА:ВВ:ССССРРL:КК',
'NUMBER' => 1,
'ISDOCUMENT' => 1,
'PREPAYMENT' => 0,
'ENGINEERINGHOTWATER' => 1,
'ENGINEERINGSEWERAGE' => 1,
'BESIDEPARKINGLOT' => 1,
'BESIDEPARKINGCOVERED' => 1,
'BESIDEGOODTRANSPORTINTERCHANGE' => 1,
];

echo prepare($ALLOWEDREALESTATE, $SOURCEREALESTATE, $values, $param) . "\n";
print_r($values);

$time = microtime(true) - $start;
printf("\nСкрипт выполнялся %.4F сек.", $time);

?>