<?php

$host     = "127.0.0.1";
$port     = 3306;
$socket   = "";
$user     = "root";
$password = "cb4yb5wf";
$dbname   = "realestate";

//$site_name = 'BestHouseSwap.ru';
$SITENAME = 'localhost';
$site_footer_text = '@2016 BestHouseSwap.ru';
$TIMECOOCKIE = time()+60*60*24*30*12;
$HTTPS = "http://";
$PATHPHOTO = '/var/www/html/photo/';

# ЛОКАЛИЗАЦИЯ
$LANGUAGE = 'RU';
$DEAL['RU'] = [
    'SELL'      =>'Продается',
    'SELLRENT'  =>'Сдается в аренду'
];
$APARTMENTINTEGRITY['RU'] = [
    'APARTMENT'     =>'Квартира',
    'PARTAPARTMENT' =>'Часть квартиры'
];
$LOCALIZATION['RU'] = [
    'ROOMS' => ['комната', 'комнаты', 'комнат']
];
$SEARCH['STATUS'] = [
    'NOTFOUND'  => 'Ничего не найдено',
    'OK'        => 'Есть данные',
    'NOADDRESS' => 'Не указан адрес',
    'NOPROPERTY' => 'Не указан тип недвижимости'
];

?>