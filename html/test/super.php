<?php
phpinfo();
exit;

ini_set('error_reporting', E_ALL);
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);

$path = "/var/www/html/photo/new";

mkdir($path);

/*
QUANTITY
*/    
?>


In addition to yaroukh at gmail dot com comment.

It seems that even a small image can eat up your default memory limit real quick. Config value 'memory_limit' is marked PHP_INI_ALL, so you can change it dynamically using ini_set. Therefore, we can "allocate memory dynamically", to prevent those memory limit exceeded errors.

<?php

$imageInfo = getimagesize('PATH/TO/YOUR/IMAGE');
$memoryNeeded = round(($imageInfo[0] * $imageInfo[1] * $imageInfo['bits'] * $imageInfo['channels'] / 8 + Pow(2, 16)) * 1.65);
                   
if (function_exists('memory_get_usage') && memory_get_usage() + $memoryNeeded > (integer) ini_get('memory_limit') * pow(1024, 2)) {
                       
    ini_set('memory_limit', (integer) ini_get('memory_limit') + ceil(((memory_get_usage() + $memoryNeeded) - (integer) ini_get('memory_limit') * pow(1024, 2)) / pow(1024, 2)) . 'M');
                       
}

?>