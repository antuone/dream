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


$ALLOWEDUSER = [
'EMAIL'=>'s',
'PASSWORD'=>'s',
'HASH'=>'s',
'IP'=>'i',
'CONFIRMED'=>'s',
'QUANTITY'=>'i'];

for ($i = 1; $i <= 1; $i++) {
		 
	# создаем пользователя
	
	$QUANTITY = 2;//mt_rand(1,3);
	
	$SOURCEUSER = [
	'EMAIL'=>'b' . $i . '@.gmail.com',
	'PASSWORD'=>'b99937535a8405c947a37947cb775575',
	'HASH'=>'',
	'IP'=>'',
	'CONFIRMED'=>'NO',
	'QUANTITY'=>$QUANTITY];
	
	insert($CON, $ALLOWEDUSER, $SOURCEUSER, 'USER')?"USER OK\n":"USER FAIL\n";
	$IDUSER  = $CON->insert_id;
	
	
	# создаем для этого пользователя $QUANTITY недвижимостей
	for ($j = 1; $j <= $QUANTITY; $j++ ) {
			 
		$SOURCEMAIN = [
		'IDUSER' => $IDUSER,
		'IDPLACE' => mt_rand(1,100),
		'NAME' => $NAME[mt_rand(0,9)],
		'DEAL' => $DEAL[mt_rand(0,4)],
		'ИМУЩЕСТВО' => $ИМУЩЕСТВО[mt_rand(0,6)],
		'ЦЕНА' => mt_rand(1000000,7000000),
		'CURRENCY' => $CURRENCY[mt_rand(0,3)],
		'CADASTRNUMBER' => 'АА:ВВ:ССССРРL:КК',
		'NUMBER' => $j,
		'АТРИБУТЫ' => random_set($ALLOWEDMAINCHECKBOXES)];
		
		insert($CON, $ALLOWEDMAIN, $SOURCEMAIN, 'НЕДВИЖИМОСТЬ')?"ALLOWEDMAIN OK\n":'FAIL';
		insert($CON, $ALLOWEDMAIN2, $SOURCEMAIN, 'REALESTATE2')?"ALLOWEDMAIN2 OK\n":'FAIL';
		insert($CON, $ALLOWEDMAIN2CHECKBOXES, $SOURCEMAIN, 'REALESTATE2CHECKBOXES')?"REALESTATE2CHECKBOXES OK\n":'FAIL';
		
		# для каждой недвижимости копируем фотки
		$FOLDER = mt_rand(1,12);
		@mkdir('/var/www/html/photo/' . $SOURCEMAIN['IDUSER']);
		@mkdir('/var/www/html/photo/' . $SOURCEMAIN['IDUSER'] . '/'. $SOURCEMAIN['NUMBER']);
		rcopy('/var/www/html/2/'.$FOLDER, '/var/www/html/photo/' . $SOURCEMAIN['IDUSER'] . '/'. $SOURCEMAIN['NUMBER']);
		
	}
}


$time = microtime(true) - $start;
printf("\nСкрипт выполнялся %.4F сек.", $time);
?>