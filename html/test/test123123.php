<?php

# временно включим вывод ошибок
ini_set('error_reporting', E_ALL);
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);

function plural_form($number, $after) {
    $cases = array (2, 0, 1, 1, 1, 2);
    return $number.' '.$after[ ($number%100>4 && $number%100<20)? 2: $cases[min($number%10, 5)] ];
}

for($i = 0; $i < 1000000; $i++) {
    echo plural_form($i, ['Рубль', 'Рубля', 'Рублей']) . '<br/>';
}





?>