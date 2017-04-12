<?php
function filter($E) {
    return $E || $E == 'null';
}
# возвращает число и склоняемое слово
# пример использования: 
# echo plural_form(1000000, ['Рубль', 'Рубля', 'Рублей']);
function plural_form($number, $after) {
    $cases = array (2, 0, 1, 1, 1, 2);
    return $number.' '.$after[ ($number%100>4 && $number%100<20)? 2: $cases[min($number%10, 5)] ];
}

# Ошибка для отладки
# В дальнейшем вывод будет убран, но добавлена отправка на почту
# информация о том кто этот скрипт запустил
# можно будет забанить аккаунт
function error ($text) {
    echo $text;
    //print_r(debug_backtrace());
    exit;
}

# Функция для генерации случайной строки
function generateCode($length=6) {
    $chars = 'abcd56789!@ijklmnopqrs[]{}\';efghRQST>?`~tuvwxyzABCDEFUVWGXYZ01234:\"<HIJKLMNOP%^&*()_+=-';
    $code = "";
    $clen = strlen($chars) - 1;  
    while (strlen($code) < $length) {
            $code .= $chars[mt_rand(0,$clen)];  
    }
    return $code;
}

# Создание новой картинки из другой картинки с новыми размерами
# $source_path - путь к картинке
# $path - папка куда сохранять картинки
# $newwidth - массив ширин картинок
# $quality - качество сохраняемой картинки
function image_resize($source_path, $path, $newwidth, $quality = FALSE) {
    if ( ! is_dir($path)) {
        error('Директория куда сохранять картинки не верна');
    }

    if ( ! is_file($source_path)) {
        error('Файл которые следует сохранить не является файлом');
    }

    if ( ! is_array($newwidth)) {
        error('Массив ширин картинок не является массивом');
    }

    list($oldwidth, $oldheight, $type) = getimagesize($source_path);
    switch ($type) {
        case IMAGETYPE_JPEG: $typestr = 'jpeg'; break;
        case IMAGETYPE_GIF: $typestr = 'gif' ;break;
        case IMAGETYPE_PNG: $typestr = 'png'; break;
        default: return false;
    }
    $function = "imagecreatefrom$typestr";
    $src_resource = $function($source_path);
    
    $length = count($newwidth);
    for ($i = 0; $i < $length; $i++) {
        if ($newwidth[$i] >= $oldwidth) {
            continue;
        }
        $destination_path = $path . '/' . $newwidth[$i];
        # создаем папку для фото его размера
        if ( ! file_exists($destination_path)) {
            mkdir($destination_path)
                or error('Не удалось создать папку для картинки');
        }
        if ($newwidth[$i] == 0) {
            $newwidth[$i] = $oldwidth;
        }

        $newheight = round($newwidth[$i] * $oldheight/$oldwidth);    
        $destination_resource = imagecreatetruecolor($newwidth[$i], $newheight)
            or error('Не удалось создать ресурс изображения');
        imagecopyresampled($destination_resource,
            $src_resource, 0, 0, 0, 0, $newwidth[$i], $newheight, $oldwidth, $oldheight)
            or error('Не удалось - копирование и изменение размера изображения с ресемплированием');
        imageinterlace($destination_resource, 1);
        
        $destination_path .= '/' . md5($source_path) . '.jpg';
        imagejpeg($destination_resource, $destination_path, $quality?$quality:75)
            or error('Не удалось - запись изображения в файл');
    }
    imagedestroy($destination_resource)
        or error('Не удалось - уничтожить изображение');
    imagedestroy($src_resource)
        or error('Не удалось - Уничтожить изображение');
}



function set($allowed, $source) {
	if (!is_array($allowed) || !is_array($source))	{
		return '';
	}

	$set = '';
	foreach ($allowed as $key) {
		if (isset($source[$key]) && $source[$key] == 1) {
			$set .= $key . ',';
		}
	}
	return substr($set, 0, -1);
}

function setForSelectCheckbox($allowed, $source) {
	if (!is_array($allowed) || !is_array($source))	{
		return '';
	}

	$set = '';
	foreach ($allowed as $key) {
		if (isset($source[$key]) && $source[$key] == 1) {
            $set .= "find_in_set('$key', `АТРИБУТЫ`) > 0 and ";
		}
	}
	return substr($set, 0, -5);
}

function setPlace($allowed, $source) {
	if (! is_array($allowed) || !is_array($source))	{
		return '';
	}
	
	$set = '';
	foreach ($allowed as $key) {
		if (in_array($key, $source)) {
			$set .= $key . ',';
		}
	}
	return substr($set, 0, -1);
}

# Подготовка к запросу к столбцу с типом SET
# Возвращает строку в виде find_in_set(?, `АТРИБУТЫ`) > 0 and find_in_set(?, `АТРИБУТЫ`) > 0
# $allowed - массив разрешенных данных
# $source - массив с данными
# &$values - ссылка на массив, который заполняется ссылками на данные для подготовленного запроса
# &$param - ссылка на строка с типами данных для подготовленнго запроса 
function set_select_checkbox($allowed, $source, &$values, &$param) {
	if ( ! is_array($allowed) || ! is_array($source)) {
		return false;
	}
	$set = '';
	$arr = [];
	$i = 0;
	foreach ($allowed as $key) {
		if (isset($source[$key]) && $source[$key] == 1) {
			$set .= "find_in_set(?, `АТРИБУТЫ`) > 0 and ";
			$param .= 's';
			$arr[$i] = $key;
			$values[] = &$arr[$i];
			$i++;
		}
	}
	return $set;
}

# подготовка запроса -
# $values - построение строки запроса в виде `key`=?,`key`=?...
# $param - построение строки типов в виде "iiiissss"
function prepare($allowed, $source, &$values, &$param, $isplace = false, $is_select = false) {
    $set = '';
    $param = "";
    $values[0] = "";
    $values[1] = &$param;
    foreach ($allowed as $key=>$value) {
        if (is_array($allowed[$key]) && isset($source[$key])) {
            if ($is_select) {
				$set.= set_select_checkbox($allowed[$key], $source[$key], $values, $param);
			} else {
				$set.="`".$key."`". "=?,";	
				$param .= 's';
				$i = 0;
				if ($isplace) {
					$s[$i] = setPlace($allowed[$key], $source[$key]);
				} else {
					$s[$i] = set($allowed[$key], $source[$key]);
				}
				$values[] = &$s[$i];
				$i++;
			}
        }
        else if (isset($source[$key])) {
            if ($is_select) {
				// if ($value == 'i>') {
                //     $set.="`".$key."`". ">? and ";    
                // } elseif ($value == 'i<') {
                //     $set.="`".$key."`". "<? and ";    
                // } else {
                //     $set.="`".$key."`". "=? and ";
                // }
                $set.="`".$key."`". "=? and ";
			} else {
				$set.="`".$key."`". "=?,";	
			}
			$param .= $value;
            $values[] = &$source[$key];
        }
    }
	
	if ($is_select) {
		return substr($set, 0, -5);
	} else {
		return substr($set, 0, -1);
	}
}

# Обновляет запись по заданному id из объекта JSON, через подготовленный запрос
# $con - текущее соединение с БД
# $allowed - массив разрешенных столбцов к обновлению
# $object - json объект в котором содержатся данные таблицы
# $table - название обновляемой таблицы
# $nameid - название id таблицы
# $id - значение id таблицы
function update($con, $allowed, $source, $table, $nameid, $id, $isplace = false) {
    // if (count($source) < 2) {
	// 	return false;
	// }
	$prepare = prepare($allowed, $source, $values, $param, $isplace);
    if ($prepare) {
        $query = "UPDATE $table SET " . $prepare . " WHERE " . $nameid . "=?";
        if ( ! $stmt = $con->prepare($query)) {
            echo $con->error;
            return false;
        }
        $values[0] = &$stmt;
        $param .= "i";
        $values[] = &$id;
		$bind_param = new ReflectionFunction('mysqli_stmt_bind_param');
        $bind_param->invokeArgs($values);
        
        if ($stmt->execute()) {
            $stmt->close();
            return true;
        } else {
            $stmt->close();
            return false;
        }
    } else {
        return false;
    }
}

# Вставляет запись из объекта JSON, через подготовленный запрос
# $con - текущее соединение с БД
# $allowed - массив разрешенных столбцов к обновлению
# $object - json объект в котором содержатся данные 
# $table - название обновляемой таблицы
function insert($con, $allowed, $source, $table, $isplace = false) {
    $prepare = prepare($allowed, $source, $values, $param, $isplace);
    if ($prepare) {
        $query = "INSERT $table SET " . $prepare;
        if ( ! $stmt = $con->prepare($query)) {
            echo $con->error;
            return false;
        }
        $values[0] = &$stmt;
        $bind_param = new ReflectionFunction('mysqli_stmt_bind_param');
        $bind_param->invokeArgs($values);
        
        if ($stmt->execute()) {
            $stmt->close();
            return true;
        } else {
			$stmt->close();
            return false;
        }
    } else {
        return false;
    }
}


# Поиск записей в БД.
# Создание запроса из объекта JSON, через подготовленный запрос
# $con - текущее соединение с БД
# $allowed - массив разрешенных столбцов
# $select - строка столбцов для отбора
# $from - название таблицы
# $where - json объект в котором содержатся данные 
# $lastwhere - добавляется в конец строки WHERE, можно добавить LIMIT 1
function select($con, $allowed, $select, $from, $where, $lastwhere) {
    $prepare = prepare($allowed, $where, $values, $param, false, true);
    $query = "SELECT $select FROM $from WHERE $prepare $lastwhere";
    $stmt = $con->prepare($query) 
        or error($con->error);
    $values[0] = &$stmt;
    $bind_param = new ReflectionFunction('mysqli_stmt_bind_param');
    $bind_param->invokeArgs($values);
    $stmt->execute()
        or error($stmt->error);
    $result = $stmt->get_result();
    $results = [];
    while ($row = $result->fetch_assoc()) {
        $results[] = $row;
    }
    $stmt->close();
    if (count($results) > 0) {
        return $results;
    } else {
        return false;
    }
}


function random_set($allowed) {
	$set = '';
	foreach ($allowed as $value) {
		if (mt_rand(0,1)) {
			$set .= $value . ',';
		}
	}
	return substr($set, 0, -1);
}


// removes files and non-empty directories
function rrmdir($dir) {
  if (is_dir($dir)) {
    $files = scandir($dir);
    foreach ($files as $file)
    if ($file != "." && $file != "..") rrmdir("$dir/$file");
    rmdir($dir);
  }
  else if (file_exists($dir)) unlink($dir);
}

// copies files and non-empty directories
function rcopy($src, $dst) {
  if (file_exists($dst)) rrmdir($dst);
  if (is_dir($src)) {
    mkdir($dst);
    $files = scandir($src);
    foreach ($files as $file)
    if ($file != "." && $file != "..") rcopy("$src/$file", "$dst/$file");
  }
  else if (file_exists($src)) copy($src, $dst);
}



?>