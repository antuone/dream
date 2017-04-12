/**
 * - NORMAL
 * - EDIT
 * - SEARCH
 */
var РЕЖИМ = 'NORMAL';

var NEWOBJECTS = false;// *** требует правки

// Объект в котором хранятся данные
// данные отправлемые на сервер и принимаемые с сервера
var ДАННЫЕ = {};

// Различные строки текстов, которые динамически могут появится где-либо в приложении
var ЛОКАЛИЗАЦИЯ = 'РУССКИЙ';

var ИМУЩЕСТВО = {
	РУССКИЙ: {
		КВАРТИРА: "Квартира",
		ДОМ: "Дом",
		ЗЕМЛЯ: "Земельный участок",
		ГАРАЖ: "Гараж, Машиноместо",
		ПОМЕЩЕНИЕ: "Помещение, Склад, Офис",
		ГОСТИННИЦА: "Гостиница",
		ДРУГОЕ: "Другое",
		ЧАСТЬ_КВАРТИРЫ: "Часть квартиры",
		ЧАСТЬ_ДОМА: "Часть дома",
	}
};

var ТЕКСТ = {
	РУССКИЙ: {
		ПО_ДОГОВОРЕННОСТИ: 'По договор.',
		СТОИМОСТЬ_И_ДРУГОЕ: 'Стоимость и другое',
		ОБЪЯВЛЕНИЯ_НЕДВИЖИМОСТИ: 'Объявления недвижимости',
		ГЛАВНОЕ_МЕНЮ: 'Главное меню',
		АДРЕС: 'Адрес',
		ВЫБРАТЬ_ДРУГОЙ_ТИП_ПОИСКА_АДРЕСА: 'Выбрать другой тип поиска адреса',
		РЕДАКТИРОВАТЬ_НЕДВИЖИМОСТЬ: 'Редактировать недвижимость',
		НЕДВИЖИМОСТЬ: 'Недвижимость',
		ТИП_СДЕЛКИ: 'Тип сделки',
		ЦЕНА: 'Стоимость и другое',
		ОТ: 'От',
		ДО: 'До',
		КОМНАТА: 'Комната',
		M2: 'м<sup>2</sup>',
		КОМНАТ: 'комнат'
	}
};


/** 
 * - данные по умолчанию которые запишет сервер
 * - данные которые не надо отправлять серверу
 **/
var ПО_УМОЛЧАНИЮ = {
	ВАЛЮТА: '₽',
	ОКОННЫЙ_БЛОК: 'ОКНО',
	ЗВЕЗД: 5,
	ДОЛЕВАЯ_СОБСТВЕННОСТЬ: "ЛИЧНАЯ"
};
var CURRENTBLOCKID = 'main';
var CURRENTBLOCKTEXT = '';
var ISMAINMUNU = false;
/**
 * - Возвращает случайное целое число между min (включительно) и max (не включая max).
 * - Использование метода Math.round() даст вам неравномерное распределение!
 */
function getRandomInt(min, max) {
	return Math.floor(Math.random() * (max - min)) + min;
}
/**
 * Удаляет узел
 */
function removeElement(id) {
	$(id).parentElement.removeChild(this);
}
/**
 * Возвращает текст из контрола select
 */
function getSelectText(select, value) {
	if (typeof (select) == 'string') {
		select = $(select).getElementsByTagName('option');
	} else {
		select = select.options;
	}
	for (var i = 0; i < select.length; i++) {
		var O = select[i];
		if (O.value == value) {
			return O.text;
		}
	}
}
/**
 * возвращает то что на конце цепочки,
 * если не может до туда достучаться возвращает undefined 
 */
function get(patch, context = window) {
	var keys = patch.split('.');
	for (var i = 0; i < keys.length; i++) {
		try {
			var value = context[keys[i]];
		} catch (e) {
			return false;
		}
		if (value !== undefined) {
			context = value;
		} else return false;
	}
	return context;
}
/**
 * функция отрицания, тем кому не нравится знак восклицания.(not вместо !) 
 */
function not(bool) {
	return !bool;
}
/**
 * - Показывает ошибку на указонное количество милисекунд.
 * - Хотя можно использовать и для чего-то другого.
 */
function showErrorOnTime(id, time = 3000) {
	spaceShow(id);
	setTimeout(function () {
		spaceHide(id);
	}, time);
}
/**
 * Восстанавливаем в первоначальный вид блоки недвижимости
 */
function clearRealestate() {
	spaceShow('address_menu_right');
	spaceHide('address_main_content');

	ДАННЫЕ = {};
	var array = document.getElementsByTagName('input');
	for (var i = 0; i < array.length; i++) {
		if (ПО_УМОЛЧАНИЮ[array[i].name]) {
			array[i].value = ПО_УМОЛЧАНИЮ[array[i].name];
		} else {
			array[i].value = '';
		}
	}
	array = document.getElementsByTagName('textarea');
	for (var i = 0; i < array.length; i++) {
		array[i].value = '';
	}
	// пока ПО_УМОЛЧАНИЮ только для select проверяем только для него
	array = document.getElementsByTagName('select');
	for (var i = 0; i < array.length; i++) {
		if (ПО_УМОЛЧАНИЮ[array[i].name]) {
			array[i].value = ПО_УМОЛЧАНИЮ[array[i].name];
		}
	}
	array = document.getElementsByTagName('button');
	for (var i = 0; i < array.length; i++) {
		if (ПО_УМОЛЧАНИЮ[array[i].name] || array[i].className.indexOf('checked') != -1) {
			checked(array[i]);
		} else {
			unchecked(array[i]);
		}
	}
	function clearContainer(container) {
		var container = $(container);
		container.innerText = '';
		container.inc = null;
	}
	clearContainer('apartment_container_for_rooms');
	clearContainer('house_container_rooms');
	clearContainer('other-main-container');
	clearContainer('parcel_container_plants');
	clearContainer('parcel_container_hoz');
	clearContainer('room_container_add_room');
	clearContainer('hotel_container_dop_room');
	clearContainer('photo_container');
	clearContainer('search_container');


	$('menu-deal').innerText = ТЕКСТ[ЛОКАЛИЗАЦИЯ].ТИП_СДЕЛКИ;
	$('menu-type-realestate').innerText = ТЕКСТ[ЛОКАЛИЗАЦИЯ].НЕДВИЖИМОСТЬ;
	$('menu-price').innerText = ТЕКСТ[ЛОКАЛИЗАЦИЯ].ЦЕНА;
	$('menu-address').innerText = ТЕКСТ[ЛОКАЛИЗАЦИЯ].АДРЕС;

}
// Открывает space, ставит заголовок text и закрывает space_hide
function spaceSwitch(space, text, space_hide) {
	spaceHide(space_hide);
	spaceShow(space);
	CURRENTBLOCKID = space;
	if (text != 'НЕМЕНЯТЬ') {
		$('header_main_text').innerText = text;
	}
}
// Выдает заголовок для недвижимости в зависимости от режима поиска или другого
function getHeaderRealestate() {
	if (РЕЖИМ == 'SEARCH') {
		return $('main_menu_search').innerText;
	} else {
		return $('main_menu_add').innerText;
	}
}

// Переключатель блока main-menu из обычного вида в поиск и обратно
function initializeSearch() {
	if ($("script_search") === null) {
		var script = document.createElement("script");
		script.src = "js/search.js";
		script.id = "script_search";
		script.async = true;
		script.defer = true;
		document.getElementsByTagName("head")[0].appendChild(script);
		script.onload = function () {
			onloadScriptSearch();
		};
	}
	click_address_button_without_map();
}

// Главный вход и единственный =)
window.addEventListener('load', function () {

	$('test777').addEventListener('click', function () {
		console.log($('apartment_side_label').control);
	});

	// кнопка "Личный кабинет" в стартовом блоке
	$('main_private').addEventListener('click', function () {
		spaceSwitch('private_office', this.innerText, 'main');
		show('gamburger_left');
	});
	// кнопка "Поиск недвижимости" в стартовом блоке
	$('main_search').addEventListener('click', function () {
		$('search_address').focus();
		clearRealestate();
		initializeSearch();
		spaceSwitch('search', this.innerText, 'main');
		РЕЖИМ = 'SEARCH';
		show('gamburger_left');
	});
	// кнопка "Добавить недвижимость" в стартовом блоке
	$('main_add').addEventListener('click', function () {
		$('main_menu_space').focus();
		clearRealestate();
		spaceSwitch('main-menu', this.innerText, 'main');
		show('gamburger_left');
		$('main_menu_button_send').onclick = realestateCreate;
		РЕЖИМ = 'NORMAL';
	});
	// кнопка "Информация" в стартовом блоке
	$('main_info').addEventListener('click', function () {
		spaceSwitch('info', this.innerText, 'main');
		show('gamburger_left');
	});
	// кнопка гамбургер слева
	$('gamburger_left').addEventListener('click', function () {
		hide('property_button_menu_right');
		spaceSwitch2(CURRENTBLOCKID);
		spaceSwitch2('main_menu');
		if (!ISMAINMUNU) {
			ISMAINMUNU = true;
			CURRENTBLOCKTEXT = $('header_main_text').innerText;
			$('header_main_text').innerText = ТЕКСТ[ЛОКАЛИЗАЦИЯ].ГЛАВНОЕ_МЕНЮ;
		} else {
			ISMAINMUNU = false;
			$('header_main_text').innerText = CURRENTBLOCKTEXT;
		}
	});
	// кнопка "Главная" в главном меню
	$('main_menu_main').addEventListener('click', function () {
		spaceSwitch('main', ТЕКСТ[ЛОКАЛИЗАЦИЯ].ОБЪЯВЛЕНИЯ_НЕДВИЖИМОСТИ, 'main_menu');
		hide('gamburger_left');
		ISMAINMUNU = false;
	});
	// кнопка "Личный кабинет" в главном меню
	$('main_menu_private').addEventListener('click', function () {
		spaceSwitch('private_office', this.innerText, 'main_menu');
		ISMAINMUNU = false;
	});
	// кнопка "Найти недвижимость" в главном меню
	$('main_menu_search').addEventListener('click', function () {
		$('search_address').focus();
		clearRealestate();
		initializeSearch();
		spaceSwitch('search', this.innerText, 'main_menu');
		РЕЖИМ = 'SEARCH';
		ISMAINMUNU = false;
	});
	// кнопка "Добавить недвижимость" в главном меню
	$('main_menu_add').addEventListener('click', function () {
		$('main_menu_space').focus();
		clearRealestate();
		spaceSwitch('main-menu', this.innerText, 'main_menu');
		ISMAINMUNU = false;
		РЕЖИМ = 'NORMAL';
		$('main_menu_button_send').onclick = realestateCreate;
	});
	// кнопка "Информация" в главном меню
	$('main_menu_info').addEventListener('click', function () {
		spaceSwitch('info', this.innerText, 'main_menu');
		ISMAINMUNU = false;
	});
});


// скрывает все дивы в контеййнере
function spaceCloseAll(container) {
	container = $(container).getElementsByTagName('div');
	for (var index = 0; index < container.length; index++) {
		spaceHide(container[index]);
	}
}

// Вставляет точки каждые 3 символа
// TODO: переделать алгоритм
function str2price(str) {
	var s = "";
	var price = str;

	for (var i = price.length - 1; i >= 0; i--) {
		s += price[i];
		j = price.length - i;
		if (i > 0)
			if (j == 3 || j == 6 || j == 9 || j == 12 || j == 15 || j == 18 || j == 21 || j == 24) {
				s += ".";
			}
	}
	var _price = "";
	for (i = s.length - 1; i >= 0; i--) {
		_price += s[i];
	}
	return _price;
}

// TODO: можно тоже переделать алгоритм на "клонирующий"
function createDivError(text) {
	var div = document.createElement('div');
	div.className = 'error';
	div.innerText = text;
	return div;
}


// var rooms =[
// "Спальня",
// "Гостевая",
// "Гостевая спальня",
// "Кухня",
// "Столовая",
// "Туалет",
// "Ванная",
// "Кладовая",
// "Чулан",
// "Прачечная",
// "Мастерская",
// "Детская",
// "Гардеробная",
// "Коридор",
// "Кабинет",
// "Бильярдная",
// "Тренажерый зал",
// "Веранда",
// "Холл",
// "Бассеин",
// "Сауна",
// "Баня",
// "Прихожая",
// "Котельная",
// "Комната отдыха",
// "Комната для рабочих",
// "Офисное помещение",
// ];

// var viewFromWindow = [
// "Двор",
// "Город",
// "Пляж",
// "Море",
// "Горы",
// "Сад",
// "Реку",
// "Лес",
// "Озеро"
// ];

// Возвращает ссылку на последний обьект из ДАННЫЕ проходя
// путь указанный в строке вида 'НЕДВИЖИМОСТЬ.КОМНАТА'
function str22branch(str) {
	var arr = str.split('.');
	var branch = ДАННЫЕ[arr[0]];
	if (!branch) {
		return false;
	}
	for (var i = 1; i < arr.length; i++) {
		branch = branch[arr[i]];
	}
	branch.name = arr[i - 1];
	return branch;
}
// Возвращает ссылку на ПРЕДпоследний обьект из ДАННЫЕ проходя
// путь указанный в строке вида 'НЕДВИЖИМОСТЬ.КОМНАТА'
function str227branch(str) {
	var arr = str.split('.');
	var branch = ДАННЫЕ[arr[0]];
	for (var i = 1; i < arr.length - 1; i++) {
		branch = branch[arr[i]];
	}
	return branch;
}
// Из строки типа 'НЕДВИЖИМОСТЬ.КОМНАТА'
// Создает такой обьект НЕДВИЖИМОСТЬ.КОМНАТА
// Возвращает два обьекта ссылающихся на корень объекта и последний объект
function str222branch(str) {
	if (str === '') {
		var obj = {};
		return [obj, obj];
	}
	var arr = str.split('.');
	var root = {};
	root[arr[0]] = {};
	var branch = root[arr[0]];
	for (var i = 1; i < arr.length; i++) {
		branch[arr[i]] = {};
		branch = branch[arr[i]];
	}
	return [root, branch];
}

function inviteObjectLevel2(object, container, INCID, ROOT, NAMEROOM) {

	if (!container.inc) {
		container.inc = 0;
	}
	container.inc++;

	var newObject = object.cloneNode(true);
	newObject.id += INCID;
	newObject.inc = container.inc;
	newObject.firstElementChild.innerText += ' ' + container.inc;

	var newDivX = $('divx').cloneNode(true);
	spaceShow(newDivX);
	newDivX.id += container.inc;

	newDivX.addEventListener('click', function () {
		this.parentElement.parentElement.removeChild(this.parentElement);

		ELEMENT = str22branch(ROOT);
		delete ELEMENT.name;

		if (ELEMENT[INCID][NAMEROOM][newObject.inc].STATUS == 'NEW') {
			delete ELEMENT[INCID][NAMEROOM][newObject.inc];

			if (Object.keys(ELEMENT[INCID][NAMEROOM]).length === 0) {
				delete ELEMENT[INCID][NAMEROOM];
			}
		} else
			ELEMENT[INCID][NAMEROOM][newObject.inc].STATUS = 'DELETE';
	});

	newObject.insertBefore(newDivX, newObject.firstElementChild);

	var elements = newObject.getElementsByTagName("*");
	var length = elements.length;
	for (var i = 0; i < length; i++) {
		if (elements[i].id) {
			elements[i].id += INCID + "" + newObject.inc;
		}
		if (elements[i].name) {

			elements[i].lvl = 2;
			elements[i].inc = newObject.inc;
			elements[i].incid = INCID;
			elements[i].nameroom = NAMEROOM;

			if (NEWOBJECTS) {
				elements[i].status = 'NEW';
			}
		}
	}

	spaceShow(newObject);
	initialize(newObject, ROOT);
	container.appendChild(newObject);
	return container.inc;
}

function inviteObjectLevel1(object, container, ROOT, isButtonClose = true) {
	if (typeof (object) == 'string') {
		object = $(object);
	}
	if (typeof (container) == 'string') {
		container = $(container);
	}
	if (!container.inc) {
		container.inc = 0;
	}
	container.inc++;

	var newObject = object.cloneNode(true);

	newObject.id += container.inc;
	newObject.inc = container.inc;
	if (РЕЖИМ != 'SEARCH') {
		newObject.firstElementChild.innerText += ' ' + container.inc;
	}

	if (isButtonClose) {
		var newDivX = $('divx').cloneNode(true);
		spaceShow(newDivX);
		newDivX.id += container.inc;
		// *** Вынести функцию отдельно !!!
		// *** Вынести функцию отдельно !!!
		// *** Вынести функцию отдельно !!!
		// *** Вынести функцию отдельно !!!
		// *** Вынести функцию отдельно !!!
		newDivX.addEventListener('click', function () {
			this.parentElement.parentElement.removeChild(this.parentElement);
			ELEMENT = str22branch(ROOT);
			if (!ELEMENT) {
				return false;
			}

			if (ELEMENT[newObject.inc].STATUS == 'NEW') {
				delete ELEMENT[newObject.inc];

				if (Object.keys(ELEMENT).length === 1) {
					delete str227branch(ROOT)[ELEMENT.name];
				}
			} else
				ELEMENT[newObject.inc].STATUS = 'DELETE';
		});
		newObject.insertBefore(newDivX, newObject.firstElementChild);
	}

	var elements = newObject.getElementsByTagName("*");
	var length = elements.length;
	for (var i = 0; i < length; i++) {
		if (elements[i].id) {
			elements[i].id += newObject.inc;
		}
		if (elements[i].name) {
			elements[i].lvl = 1;
			elements[i].inc = newObject.inc;
			if (NEWOBJECTS) {
				elements[i].status = 'NEW';
			}
		}
	}

	spaceShow(newObject);
	initialize(newObject, ROOT);
	container.appendChild(newObject);

	return container.inc;
}



/* Обновляем дерево добавляя некоторые функции*/
function initialize(topNode, saveNode) {

	if (!topNode) {
		return false;
	}

	if (typeof (topNode) == "string") {
		topNode = $(topNode);
	}

	if (typeof (topNode) != "object") {
		return false;
	}

	if (typeof (saveNode) != "string") {
		return false;
	}

	var all = topNode.getElementsByTagName("*");

	var checkedElements = {}; //объект временно хранящий имена уже обработанных обьектов

	function onChange(node) {
		if (!node) {
			return false;
		}
		if (!node.name) {
			return false;
		}
		if (!node.value) {
			if (РЕЖИМ != 'EDIT') {
				var D = get('ДАННЫЕ.' + saveNode);
				delete D[node.name];
			}
			return false;
		}
		var isCheckBox = false;
		if (node.className.indexOf("checkbox") != -1) {
			isCheckBox = true;
		}
		var branch2 = str222branch(saveNode);

		switch (node.lvl) {
			case 2:
				branch2[1][node.incid] = {};
				branch2[1][node.incid][node.nameroom] = {};
				branch2[1][node.incid][node.nameroom][node.inc] = {};
				if (isCheckBox) {
					branch2[1][node.incid][node.nameroom][node.inc].АТРИБУТЫ = {};
					branch2[1][node.incid][node.nameroom][node.inc].АТРИБУТЫ[node.name] = node.value;
				} else {
					branch2[1][node.incid][node.nameroom][node.inc][node.name] = node.value;
				}
				if (node.status) {
					branch2[1][node.incid][node.nameroom][node.inc].STATUS = node.status;
				}
				break;
			case 1:
				branch2[1][node.inc] = {};
				if (isCheckBox) {
					branch2[1][node.inc].АТРИБУТЫ = {};
					branch2[1][node.inc].АТРИБУТЫ[node.name] = node.value;
				} else {
					branch2[1][node.inc][node.name] = node.value;
				}
				if (node.status) {
					branch2[1][node.inc].STATUS = node.status;
				}
				break;
			default:
				if (isCheckBox) {
					branch2[1].АТРИБУТЫ = {};
					branch2[1].АТРИБУТЫ[node.name] = node.value;
				} else {
					branch2[1][node.name] = node.value;
				}
		}

		ДАННЫЕ = mergeObjects(ДАННЫЕ, branch2[0]);
		return true;
	}

	function click_checkbox() {
		if (switchChecked(this)) {
			this.value = 1;
		} else {
			this.value = 0;
		}
		onChange(this);
	}

	function click_radio() {
		if (this.className.indexOf("disabled") != -1) {
			return false;
		}
		onChange(this);
		uncheckeds(this.name);
		checked(this);
	}

	function change_input() {
		//delete this.name;
		onChange(this);
	}

	for (var i = 0; i < all.length; i++) {
		var node = all[i];

		// Добавление всем checkbox поведения состояний checked and unchecked
		if (node.className.indexOf("checkbox") != -1) {
			if (node.className.indexOf("checked") != -1) {
				node.value = 1;
			}
			node.addEventListener("click", click_checkbox);
		}

		var elements = [];

		//  класс радио
		if (node.className.indexOf("radio") != -1) {
			// если есть имя у элемента
			// и его нет во временном списке
			// тогда добавлем его в него чтобы больше такое имя не обрабатывать
			if (node.name && checkedElements[node.name] === undefined) {
				checkedElements[node.name] = -1;
				/*создаем список с одинаковыми именами*/
				var _all = document.getElementsByTagName("button");
				var _length = _all.length;
				for (var k = 0; k < _length; k++) {
					var _node = _all[k];
					if (_node.name == node.name) {
						elements.push(_node);
					}
				}
				/*и обработываем этот список*/
				for (var j = 0; j < elements.length; j++) {
                    /*если кликнут на радио тогда сохраняем номер этой кнопки в ДАННЫЕ
                      все другие кнопки делаем не помеченными, а кликнутую помеченной*/
					elements[j].addEventListener("click", click_radio);
				}
				/*Очищаем список*/
				elements.length = 0;
			}
		}
		/*
			firefox сохраняет данные в инпутах и селектах если была обновлена страница
			есть данные по умолчанию, о которых знает БД
			их не надо в ДАННЫЕ записывать
			но всеже неплохо бы если браузер запомнил некоторые данные
			нужно либо данные записать в ДАТА либо удалить из инпутов
			проверять же каждую переменную по умолчанию не корректно
			
			Решил создать список данных поумолчанию и сравнивать
			- если узел принадлежит к данным по умолчанию и его данные изменены,
			 тогда заносим его в ДАННЫЕ
		*/
		if (node.tagName == "SELECT" || node.tagName == "INPUT" || node.tagName == "TEXTAREA") {
			if (!ПО_УМОЛЧАНИЮ[node.name]) {
				onChange(node);
			}
			else if (node.value != ПО_УМОЛЧАНИЮ[node.name]) {
				onChange(node);
			}
			node.addEventListener("change", change_input);
		}
	}
}

function $_GET(key) {
	var s = window.location.search;
	s = s.match(new RegExp(key + '=([^&=]+)'));
	return s ? s[1] : false;
}

function setCookie(name, value, options) {
	options = options || {};

	var expires = options.expires;

	if (typeof expires == "number" && expires) {
		var d = new Date();
		d.setTime(d.getTime() + expires * 1000);
		expires = options.expires = d;
	}
	if (expires && expires.toUTCString) {
		options.expires = expires.toUTCString();
	}

	value = encodeURIComponent(value);

	var updatedCookie = name + "=" + value;

	for (var propName in options) {
		updatedCookie += "; " + propName;
		var propValue = options[propName];
		if (propValue !== true) {
			updatedCookie += "=" + propValue;
		}
	}

	document.cookie = updatedCookie;
}

function deleteCookie(name) {
	setCookie(name, "", { expires: -1 });
}

/*
  if so, it returns the cookie named name, if not, undefined
*/
function getCookie(name) {
	var matches = document.cookie.match(new RegExp(
		"(?:^|; )" + name.replace(/([\.$?*|{}\(\)\[\]\\\/\+^])/g, '\\$1') + "=([^;]*)"
	));
	return matches ? decodeURIComponent(matches[1]) : undefined;
}

// Сокращение записи (незнаю как влеяет на скорость выполнения, ведь вызов функции тоже требует времени)
// Проверить потом!!!
function $(id) {
	return document.getElementById(id);
}

// Добавляет к первому обьекту все ветки и подветки и значея второго
function mergeObjects(obj1, obj2) {
	for (var k2 in obj2) {
		if (obj1[k2] && obj1[k2].constructor === Object && obj2[k2].constructor === Object) {
			obj1[k2] = mergeObjects(obj1[k2], obj2[k2]);
		} else {
			obj1[k2] = obj2[k2];
		}
	}
	return obj1;
}

function mainMenuNextFocus() {
	// var buttons = $("main-menu").getElementsByTagName("button");
	// var length = buttons.length;
	// for (var i = 0; i < length; i++) {
	// 	if (buttons[i].className.indexOf("radio") != -1 && buttons[i].className.indexOf("checked") == -1) {
	// 		buttons[i].focus();
	// 		return;
	// 	}
	// }
	// $("main_menu_button_send").focus();
}

/**/
function enabled(element) {

	if (typeof (element) == "string") {
		element = $(element);
	}

	if (!element) {
		return false;
	}

	if (typeof (element) != "object") {
		return false;
	}

	if (element.className.indexOf(" disabled") != -1) {
		element.className = element.className.replace(" disabled", "");
	}
	element.disabled = false;
}
/**/
function disabled(element) {
	if (typeof (element) == "string") {
		element = $(element);
	}

	if (!element) {
		return false;
	}

	if (typeof (element) != "object") {
		return false;
	}

	if (element.className.indexOf(" disabled") == -1) {
		element.className += " disabled";
	}
	element.disabled = true;
}

/**/
function switchChecked(element) {
	if (element.className.indexOf("checked") == -1) {
		element.className = element.className + " checked";
		return true;
	} else {
		element.className = element.className.replace("checked", "");
		return false;
	}
}
/**/
function checked(element) {
	if (typeof element == "string") {
		element = $(element);
	}

	if (typeof (element) != "object") {
		return false;
	}

	if (element.className.indexOf("checked") == -1) {
		if (element.className.indexOf("radio") != -1) {
			uncheckeds(element.name);
		}
		element.className += " checked";
		if (element.className.indexOf("checkbox") != -1) {
			element.value = 1;
		}
	}
}
/**/
function unchecked(element) {
	if (typeof (element) == "string") {
		element = $(element);
	}
	if (typeof (element) != "object") {
		return false;
	}
	if (element.className.indexOf("checked") != -1) {
		element.className = element.className.replace(" checked", "");
	}
}
/*lkj*/
function uncheckeds(name) {
	if (!name) {
		return;
	}
	var all = document.getElementsByTagName("button");
	var length = all.length;
	for (var k = 0; k < length; k++) {
		var node = all[k];
		if (node.name == name) {
			unchecked(node);
		}
	}
}
/*Переключатель скрытия или показа поля*/
function spaceSwitch2(space) {

	if (!space) {
		return false;
	}

	if (typeof space == "string") {
		space = $(space);
	}

	if (typeof space != "object") {
		return false;
	}

	if (space.className.indexOf("space-close") != -1) {
		spaceShow(space);
	} else {
		spaceHide(space);
	}
}
/* Скрыть поле*/
function spaceHide(space) {

	if (typeof (space) == "string") {
		space = $(space);
	}

	if (space.className.indexOf("space-close") == -1) {
		if (space.className.indexOf("space-open") == -1) {
			space.className += " space-close";
		} else {
			space.className = space.className.replace("space-open", "space-close");
		}
	}
}
/* Показать поле*/
function spaceShow(space) {

	if (typeof (space) == "string") {
		space = $(space);
	}

	if (space.className.indexOf("space-open") == -1) {
		if (space.className.indexOf("space-close") == -1) {
			space.className += " space-open";
		} else {
			space.className = space.className.replace("space-close", "space-open");
		}
	}
}
/* Скрыть поле*/
function hide(space) {

	if (typeof (space) == "string") {
		space = $(space);
	}

	if (space.className.indexOf("hide") == -1) {
		if (space.className.indexOf("show") == -1) {
			space.className += " hide";
		} else {
			space.className = space.className.replace("show", "hide");
		}
	}
}
/* Показать поле*/
function show(space) {

	if (typeof (space) == "string") {
		space = $(space);
	}

	if (space.className.indexOf("show") == -1) {
		if (space.className.indexOf("hide") == -1) {
			space.className += " show";
		} else {
			space.className = space.className.replace("hide", "show");
		}
	}
}
// проверка - включен ли чекбокс по его id
function ischecked(space) {
	if (typeof (space) == "string") {
		space = $(space);
	}

	if (space && space.value && space.value == 1) {
		return true;
	} else {
		return false;
	}
}

/**/
function superShowList(input, inputX, container, functionGetArrey, functionIfSelected, isNecessarily, step) {

	container.className = "beside-list";

	inputX.onclick = function () {
		input.value = "";
	};

	var focusElement = -1;

	input.onkeyup = function (e) {
		var kc = e.keyCode || e.charCode;
		if (kc != 38 && kc != 40 && kc != 13) {
			fillList();
		}
	};

	input.onblur = function () {
		setTimeout(function () {
			container.style.display = "none";
			if (isNecessarily) {
				for (var i = 0; i < functionGetArrey().length; i += step) {
					if (input.value.localeCompare(functionGetArrey()[i]) === 0) {
						functionIfSelected()(functionGetArrey()[i + 1]);
						return;
					}
				}
				input.value = "";
				functionIfSelected()(0);
			} else {
				functionIfSelected()(0);
			}
		}, 1000);
	};

	input.onkeydown = function (e) {

		var c = e.keyCode || e.charCode;

		if (c == 13) {
			//input.blur();
			input.value = container.getElementsByTagName('*')[focusElement].innerText;
			container.style.display = "none";
			functionIfSelected()(functionGetArrey()[focusElement * step + step - 1]);
		}

		//Down
		if (c == 40) {
			//input.blur();
			if (focusElement == container.getElementsByTagName('*').length - 1) {
				container.getElementsByTagName('*')[focusElement].className = "no-focus-element";
				container.getElementsByTagName('*')[0].className = "focus-element";
				focusElement = 0;
			} else {
				if (focusElement != -1) {
					container.getElementsByTagName('*')[focusElement].className = "no-focus-element";
				}
				focusElement++;
				container.getElementsByTagName('*')[focusElement].className = "focus-element";
			}
		}
		//Up
		if (c == 38) {
			//input.blur();
			if (focusElement === 0) {
				container.getElementsByTagName('*')[focusElement].className = "no-focus-element";
				container.getElementsByTagName('*')[container.getElementsByTagName('*').length - 1].className = "focus-element";
				focusElement = container.getElementsByTagName('*').length - 1;
			} else if (focusElement == -1) {
				container.getElementsByTagName('*')[container.getElementsByTagName('*').length - 1].className = "focus-element";
				focusElement = container.getElementsByTagName('*').length - 1;
			} else {
				container.getElementsByTagName('*')[focusElement].className = "no-focus-element";
				focusElement--;
				container.getElementsByTagName('*')[focusElement].className = "focus-element";
			}
		}
	};

	input.onfocus = function () {
		fillList();
	};

	input.onclick = function () {
		fillList();
	};

	function fillList() {
		focusElement = -1;

		while (container.firstChild) container.removeChild(container.firstChild);
		container.style.display = "block";
		for (var i = 0; i < functionGetArrey().length; i += step) {
			if (input.value.toUpperCase().localeCompare(
				functionGetArrey()[i].substr(0, input.value.length).toUpperCase()) === 0) {
				var element = document.createElement("div");
				element.innerText = functionGetArrey()[i];
				element.value = functionGetArrey()[i + step - 1];
				element.className = "beside-list-element";
				element.onclick = function () {
					//alert(this.innerText);
					input.value = this.innerText;
					functionIfSelected()(this.value);
				};
				container.appendChild(element);
			}
		}
	}
}

//Запустить отображение в полноэкранном режиме
function launchFullScreen() {
	if (document.documentElement.requestFullScreen) {
		document.documentElement.requestFullScreen();
	} else if (document.documentElement.mozRequestFullScreen) {
		document.documentElement.mozRequestFullScreen();
	} else if (document.documentElement.webkitRequestFullScreen) {
		document.documentElement.webkitRequestFullScreen();
	}
}

// Выход из полноэкранного режима
function cancelFullscreen() {
	if (document.cancelFullScreen) {
		document.cancelFullScreen();
	} else if (document.mozCancelFullScreen) {
		document.mozCancelFullScreen();
	} else if (document.webkitCancelFullScreen) {
		document.webkitCancelFullScreen();
	}
}