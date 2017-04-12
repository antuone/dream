<?php
# временно включим вывод ошибок
ini_set('error_reporting', E_ALL);
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);

include_once $_SERVER['DOCUMENT_ROOT'].'/php/properties.php';
include_once $_SERVER['DOCUMENT_ROOT'].'/php/functions.php';

# ПРОВЕРКИ БЕЗОПАСТНОСТИ

# проверка ID пользователя
if ( ! isset($_COOKIE['ID']))
    error('В куках нет ID пользователя');
if ( ! ctype_digit($_COOKIE['ID']))
    error('В $_POST есть ID пользователя, но не все символы цыфры');
# проверка HASH
if ( ! isset($_COOKIE['HASH']))
    error('Отсутствует HASH');
if ( ! preg_match('/^[a-zA-Z0-9]{32}/', $_COOKIE['HASH']))
    error('HASH не соответсвует регулярному выражению /^[a-zA-Z0-9]{32}/');

# соединямся с БД
$con = new mysqli($host, $user, $password, $dbname, $port, $socket);
if ($con->connect_error) error($con->connect_error);

# проверяем существование пользователя
$ALLOWED_USER['ID'] = 'i';
$USER = select($con, $ALLOWED_USER, 'ID, QUANTITY', 'USER',
    ['ID'=>$_COOKIE['ID'], 'HASH'=>$_COOKIE['HASH']], 'LIMIT 1')[0]
    or error('Пользователь не найден');

# еще некоторые проверки
if ($USER['QUANTITY'] < 0) {
    error('$USER->QUANTITY не может быть меньше нуля');
}
if (isset($_POST['ИДЕНТИФИКАТОР']) && ! ctype_digit($_POST['ИДЕНТИФИКАТОР'])) {
    error('В $_POST есть ИДЕНТИФИКАТОР, но не все символы цыфры');
}
   
if (isset($_POST['ИДЕНТИФИКАТОР'])) {
    #если это добавление к уже существующей недвижимости
    # узнаем номер недвижимости
    $ALLOWED_REALESTATE['ИДЕНТИФИКАТОР'] = 'i';
    $НЕДВИЖИМОСТЬ = select($con, $ALLOWED_REALESTATE,
        'NUMBER,SPACETOTAL,ИМУЩЕСТВО,ЦЕНА,CURRENCY,DEAL', 'НЕДВИЖИМОСТЬ',
    ['ИДЕНТИФИКАТОР'=>$_POST['ИДЕНТИФИКАТОР']], 'LIMIT 1')[0]
        or error('Недвижимость с таким ИДЕНТИФИКАТОР не найдена');
    $number = $НЕДВИЖИМОСТЬ['NUMBER'];
} else {
    #иначе это добавление к новой недвижимости
    $number = $USER['QUANTITY'] + 1;
}

# путь к папке пользователя с фото
$root = $PATHPHOTO . $_COOKIE['ID'];
# создаем эту папку
if ( ! file_exists($root)) 
    mkdir($root);
# путь к папке недвижимости с фото
$root .= '/' . $number;
# создаем эту папку
if ( ! file_exists($root)) 
    mkdir($root);

# перемещаем фото в нужные папки изменяя при этом их размер
foreach ($_FILES as $key => $value) {
    if (is_uploaded_file($value['tmp_name'])) {
        image_resize($value['tmp_name'], $root , [200, 600, 1200, 0]);
    }
}

# переменная для ответа
$REQUEST = ['STATUS'=>'Фото добавлено'];
echo json_encode($REQUEST, JSON_UNESCAPED_UNICODE | JSON_FORCE_OBJECT);
?>