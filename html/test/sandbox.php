<?php

$filename = '/var/www/html/photo/new';

if (file_exists($filename)) {
    echo "Файл $filename существует";
} else {
    echo "Файл $filename не существует";
}

?>