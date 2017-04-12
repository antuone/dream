/**
 * 
 */
function initialize_reload(ИДЕНТИФИКАТОР) {
	clearRealestate();

	ДАННЫЕ.НЕДВИЖИМОСТЬ = {};
	ДАННЫЕ.НЕДВИЖИМОСТЬ.ИДЕНТИФИКАТОР = ИДЕНТИФИКАТОР;

	var request = new XMLHttpRequest();
	request.open("POST", 'php/realestate/data.php', true);
	request.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
	request.setRequestHeader('Accept', 'application/json');
	request.send('id=' + ИДЕНТИФИКАТОР);

	request.onreadystatechange = function () {
		if (this.status == 200 && this.readyState === XMLHttpRequest.DONE) {
			ДАННЫЕ = JSON.parse(request.responseText);
			reloadRealestate();
		}
	};
}
/**
 * 
 */
function checkedRadio(element, value) {
	for (var i = 0; i < element.length; i++) {
		if (element[i].value == value) {
			checked(element[i]);
			break;
		}
	}
}
/**
 * Перебераем весь пришедший json с ключами которые совпадают по имене в html
 * И заполняем input, select, textarea данными и закрашиваем включенные radiobox
 * которые у меня class="checkbox" и class="radio" с тегом button
 */
function reloadInputSelectTextareaRadio(ДАННЫЕ) {

	var keys = Object.keys(ДАННЫЕ);
	for (var i = 0; i < keys.length; i++) {
		var element = document.getElementsByName(keys[i]);
		var length2 = element.length;
		if (element && element[0] && length2 > 0) {
			if (length2 == 1) {
				element[0].value = ДАННЫЕ[keys[i]];
			} else if (length2 > 1) {
				checkedRadio(element, ДАННЫЕ[keys[i]]);
			}
		}
	}
}
/**
 * Отмечает чекбоксы принимая массив ид блоков либо 1 блок в виде строки
 */
function reloadCheckbox(ДАННЫЕ, IDSPACE) {
	if (typeof (IDSPACE) == 'string') {
		IDSPACE = [IDSPACE];
	}
	var checkbox = [];
	for (var index = 0; index < IDSPACE.length; index++) {
		var checkbox = $(IDSPACE[index]).getElementsByTagName('button');
		for (var i = 0; i < checkbox.length; i++) {
			if (checkbox[i].name && ДАННЫЕ.АТРИБУТЫ && ДАННЫЕ.АТРИБУТЫ.indexOf(checkbox[i].name) != -1) {
				checked(checkbox[i]);
			}
		}
	}
	ДАННЫЕ.АТРИБУТЫ = [];
}
/**
 * Загрузка данных во всю форму недвижимости
 */
function reloadRealestate() {
	reloadInputSelectTextareaRadio(ДАННЫЕ.НЕДВИЖИМОСТЬ);
	reloadCheckbox(ДАННЫЕ.НЕДВИЖИМОСТЬ, ['deal', 'price', 'engineering', ДАННЫЕ.НЕДВИЖИМОСТЬ.ИМУЩЕСТВО.toLowerCase()]);
	reloadInputSelectTextareaRadio(ДАННЫЕ.НЕДВИЖИМОСТЬ);

	/* выделяем недвижимость, пишим какая недвижимость и площадь */
	switch (ДАННЫЕ.НЕДВИЖИМОСТЬ.ИМУЩЕСТВО) {
		case "КВАРТИРА":
			apartment_button_ok();
			reloadApartmentRooms();
			if (get('ДАННЫЕ.НЕДВИЖИМОСТЬ.КОМНАТА')) {
				clearObjectLvl1(ДАННЫЕ.НЕДВИЖИМОСТЬ.КОМНАТА, { "ИД_КОМНАТА": 1 });
			}
			break;
		case "ДОМ":
			house_button_ok();
			reloadHouseRooms();
			if (get('ДАННЫЕ.НЕДВИЖИМОСТЬ.КОМНАТА')) {
				clearObjectLvl1(ДАННЫЕ.НЕДВИЖИМОСТЬ.КОМНАТА, { "ИД_КОМНАТА": 1 });
			}
			break;
		case "ЗЕМЛЯ":
			parcel_button_ok();
			reloadParcelHozbuildings();
			reloadParcelPlants();
			if (get('ДАННЫЕ.НЕДВИЖИМОСТЬ.АТРИБУТЫ.ЕСТЬ_ПАСЕКА') == 1) {
				spaceShow('parcel_space_paseka');
			}
			if (get('ДАННЫЕ.НЕДВИЖИМОСТЬ.АТРИБУТЫ.ЕСТЬ_САД') == 1) {
				spaceShow('parcel_in_garden');
			}
			if (ДАННЫЕ.НЕДВИЖИМОСТЬ.САД) {
				clearObjectLvl1(ДАННЫЕ.НЕДВИЖИМОСТЬ.САД, { "ИД_САД": 1 });
			}
			if (ДАННЫЕ.НЕДВИЖИМОСТЬ.ХОЗПАСТРОЙКИ) {
				clearObjectLvl1(ДАННЫЕ.НЕДВИЖИМОСТЬ.ХОЗПАСТРОЙКИ, { "ИД_ХОЗПАСТРОЙКА": 1 });
			}

			break;
		case "СТОЯНКА":
			garage_button_ok();
			if (ДАННЫЕ.НЕДВИЖИМОСТЬ.СТОЯНКА == 'МАШИНОМЕСТО') {
				spaceHide($("garage_garage_expander"));
				spaceHide($("garagedj9283j"));
				spaceShow($("garage_mesto_expander"));
			}
			break;
		case "ПОМЕЩЕНИЕ":
			room_button_ok();
			reloadRoomRooms();
			if (get('ДАННЫЕ.НЕДВИЖИМОСТЬ.КОМНАТА')) {
				clearObjectLvl1(ДАННЫЕ.НЕДВИЖИМОСТЬ.КОМНАТА, { "ИД_КОМНАТА": 1 });
			}
			break;
		case "ГОСТИНИЦА":
			hotel_button_ok();
			reloadHotel();
			if (get('ДАННЫЕ.НЕДВИЖИМОСТЬ.КОМНАТА')) {
				clearObjectLvl1(ДАННЫЕ.НЕДВИЖИМОСТЬ.КОМНАТА, { "ИД_КОМНАТА": 1 });
			}
			break;
		case "ДРУГОЕ":
			other_button_ok();
			reloadOther();
			if (get('ДАННЫЕ.НЕДВИЖИМОСТЬ.ЗДАНИЕ')) {
				clearObjectLvl2(clearObjectLvl1(
					ДАННЫЕ.НЕДВИЖИМОСТЬ.ЗДАНИЕ, { "ИД_ЗДАНИЕ": 1, "КОМНАТА": 1 }),
					"КОМНАТА", { "ИД_КОМНАТА": 1 });
				clearObject(ДАННЫЕ.НЕДВИЖИМОСТЬ, ['ЗДАНИЕ']);
			}
			break;
	}
	// ЗАПОЛНЯЕМ ГЛАВНОЕ МЕНЮ
	deal_button_ok();
	price_ready();
	engineering_button_ok();
	// ФОТО
	if (ДАННЫЕ.ФОТОГРАФИИ && Object.keys(ДАННЫЕ.ФОТОГРАФИИ).length > 0) {
		checked('menu_photo');
	}
	// АДРЕС
	var place = ДАННЫЕ.МЕСТО;

	var address = '';
	if (place.name) {
		if (place.vicinity && place.name != place.vicinity) {
			address = place.name + ', ' + place.vicinity;
		} else {
			address = place.name;
		}
	} else if (place.formatted_address) {
		address = place.formatted_address;
	} else {
		address = '?';
	}

	var el = $('menu-address');
	el.innerText = address;
	checked(el);

	// УДАЛЯЕМ ДАННЫЕ
	//delete ДАННЫЕ.ФОТОГРАФИИ;
	// clearObject(ДАННЫЕ.НЕДВИЖИМОСТЬ,
	// 	['ИМУЩЕСТВО', 'ИДЕНТИФИКАТОР', 'НОМЕР_ОБЪЯВЛЕНИЯ', 'АТРИБУТЫ', 'ДРУГОЕ',
	// 	 'ДОМ', 'КВАРТИРА', 'PARCEL', 'ROOM', 'HOTEL', 'GARAGE']);
	clearObject(ДАННЫЕ.МЕСТО, ['lat', 'lng', 'name']);

	NEWOBJECTS = true;
}
/**
 * 
 */
function clearObject(object, array) {
	var key = Object.keys(object);
	for (var i = 0; i < key.length; i++) {
		if (!in_array(array, key[i])) {
			delete object[key[i]];
		}
	}
	return object;
}
/**
 * 
 */
function in_array(array, value) {
	for (var i = 0; i < array.length; i++) {
		if (array[i] == value) {
			return true;
		}
	}
	return false;
}
/**
 * Очистка для отслеживания изменений в форме
 * на сервер отправятся только тот json который изменился
 * который в последствии обновит БД
 * Убирает все обьекты кроме тех что в списке
 */
function clearObjectLvl1(object, arrey) {
	var length = Object.keys(object).length;
	for (var i = 1; i <= length; i++) {

		var keys = Object.keys(object[i]);
		for (var j = 0; j < keys.length; j++) {
			if (arrey[keys[j]] !== 1) {
				delete object[i][keys[j]];
			}
		}
	}
	return object;
}
/**
 * Убирает все обьекты подобъектов кроме тех что в списке
 */
function clearObjectLvl2(object, name, arrey) {
	var length = Object.keys(object).length;
	for (var i = 1; i <= length; i++) {
		if (object[i][name]) {
			object[i][name] = clearObjectLvl1(object[i][name], arrey);
		}
	}
	return object;
}
/**
 * 
 */
function reloadApartmentRooms(КОМНАТА = get('ДАННЫЕ.НЕДВИЖИМОСТЬ.КОМНАТА')) {
	if (!КОМНАТА) {
		return;
	}
	var length = Object.keys(КОМНАТА).length;

	for (var i = 1; i <= length; i++) {

		var loggia = КОМНАТА[i].ОКОННЫЙ_БЛОК;
		apartment_add_room();

		if (КОМНАТА[i].НАЗВАНИЕ) {
			$('apartment_room' + i).value = КОМНАТА[i].НАЗВАНИЕ;
		}
		if (КОМНАТА[i].ПЛОЩАДЬ) {
			$('apartment_space' + i).value = КОМНАТА[i].ПЛОЩАДЬ;
		}
		if (loggia) {
			$('apartment_loggia' + i).value = loggia;
			$('apartment_loggia' + i).myOnChange();
		}
		if (КОМНАТА[i].ВИД_НА) {
			$('apartment_window' + i).value = КОМНАТА[i].ВИД_НА;
		}
		if (КОМНАТА[i].СТОРОНА_СВЕТА) {
			$('apartment_side' + i).value = КОМНАТА[i].СТОРОНА_СВЕТА;
		}
		if (КОМНАТА[i].АТРИБУТЫ && Object.keys(КОМНАТА[i].АТРИБУТЫ).length > 0) {
			reloadCheckbox(КОМНАТА[i], 'apartment_new_room' + i);
		}
		if (ДАННЫЕ.НЕДВИЖИМОСТЬ.СОБСТВЕННОСТЬ == 'ДОЛЕВАЯ') {
			Если_Изменена_Собственность('apartment_container_for_rooms', 'Долевая');
		}
	}
}
/**
 * 
 */
function reloadHouseRooms() {
	if (!get('ДАННЫЕ.НЕДВИЖИМОСТЬ.КОМНАТА')) {
		return;
	}
	var КОМНАТА = ДАННЫЕ.НЕДВИЖИМОСТЬ.КОМНАТА;
	var length = Object.keys(КОМНАТА).length;

	for (var i = 1; i <= length; i++) {

		var loggia = КОМНАТА[i].ОКОННЫЙ_БЛОК;

		house_addroom();
		
		if (КОМНАТА[i].НАЗВАНИЕ) {
			$('house_room' + i).value = КОМНАТА[i].НАЗВАНИЕ;
		}
		if (КОМНАТА[i].ПЛОЩАДЬ) {
			$('house_space' + i).value = КОМНАТА[i].ПЛОЩАДЬ;
		}
		if (loggia) {
			$('house_loggia' + i).value = loggia;
			$('house_loggia' + i).myOnChange();
		}
		if (КОМНАТА[i].ВИД_НА) {
			$('house_window' + i).value = КОМНАТА[i].ВИД_НА;
		}
		if (КОМНАТА[i].СТОРОНА_СВЕТА) {
			$('house_side' + i).value = КОМНАТА[i].СТОРОНА_СВЕТА;
		}
		if (КОМНАТА[i].АТРИБУТЫ && Object.keys(КОМНАТА[i].АТРИБУТЫ).length > 0) {
			reloadCheckbox(КОМНАТА[i], 'house_new_room' + i);
		}
		if (ДАННЫЕ.НЕДВИЖИМОСТЬ.СОБСТВЕННОСТЬ == 'ДОЛЕВАЯ') {
			Если_Изменена_Собственность('house_container_rooms', 'Долевая');
		}
	}
}
/**
 * 
 */
function reloadParcelHozbuildings() {
	if (!get('ДАННЫЕ.НЕДВИЖИМОСТЬ.ХОЗПАСТРОЙКИ')) {
		return;
	}
	var ХОЗПАСТРОЙКИ = ДАННЫЕ.НЕДВИЖИМОСТЬ.ХОЗПАСТРОЙКИ;
	var length = Object.keys(ХОЗПАСТРОЙКИ).length;

	for (var i = 1; i <= length; i++) {

		inviteObjectLevel1($("parcel_new_hoz"),
			$("parcel_container_hoz"),
			"ХОЗПАСТРОЙКИ");

		if (ХОЗПАСТРОЙКИ[i].НАЗВАНИЕ) {
			$('parcel_hozpostroyka' + i).value = ХОЗПАСТРОЙКИ[i].НАЗВАНИЕ;
		}
		if (ХОЗПАСТРОЙКИ[i].ПЛОЩАДЬ) {
			$('parcel_place_hoz' + i).value = ХОЗПАСТРОЙКИ[i].ПЛОЩАДЬ;
		}
	}
}
/**
 * 
 */
function reloadParcelPlants() {
	if (!get('ДАННЫЕ.НЕДВИЖИМОСТЬ.РАСТЕНИЯ')) {
		return;
	}
	var PLANT = ДАННЫЕ.НЕДВИЖИМОСТЬ.РАСТЕНИЯ;
	var length = Object.keys(PLANT).length;

	for (var i = 1; i <= length; i++) {
		inviteObjectLevel1($("parcel_new_plant"),
			$("parcel_container_plants"),
			"РАСТЕНИЯ");
		if (PLANT[i].НАЗВАНИЕ) {
			$('parcel_plant' + i).value = PLANT[i].НАЗВАНИЕ;
		}
		if (PLANT[i].ПЛОЩАДЬ) {
			$('parcel_place_plant' + i).value = PLANT[i].ПЛОЩАДЬ;
		}
	}
}
/**
 * 
 */
function reloadRoomRooms() {
	if (!get('ДАННЫЕ.НЕДВИЖИМОСТЬ.КОМНАТА')) {
		return;
	}
	var ROOM = ДАННЫЕ.НЕДВИЖИМОСТЬ.КОМНАТА;
	var length = Object.keys(ROOM).length;

	for (var i = 1; i <= length; i++) {
		inviteObjectLevel1($("room_new_more"),
			$("room_container_add_room"),
			"КОМНАТА");

		if (ROOM[i].НАЗВАНИЕ) {
			$('room_dop_rooms' + i).value = ROOM[i].НАЗВАНИЕ;
		}
		if (ROOM.ПЛОЩАДЬ) {
			$('room_place' + i).value = ROOM[i].ПЛОЩАДЬ;
		}
	}
}
/**
 * 
 */
function reloadHotel() {
	if (!get('ДАННЫЕ.НЕДВИЖИМОСТЬ.КОМНАТА')) {
		return;
	}
	var ROOM = ДАННЫЕ.НЕДВИЖИМОСТЬ.ROOM;
	var length = Object.keys(ROOM).length;

	for (var i = 1; i <= length; i++) {
		inviteObjectLevel1($("hotel_add_more_room"),
			$("hotel_container_dop_room"),
			"КОМНАТА");
		if (ROOM[i].НАЗВАНИЕ) {
			$('hotel_name_dop_room' + i).value = ROOM[i].НАЗВАНИЕ;
		}
		if (ROOM[i].ПЛОЩАДЬ) {
			$('hotel_place_dop' + i).value = ROOM[i].ПЛОЩАДЬ;
		}
		if (ROOM[i].ТЕКСТ) {
			$('hotel_dop_textarea' + i).value = ROOM[i].ТЕКСТ;
		}
	}
}
/**
 * 
 */
function setifisset(id, variable) {
	if (variable) {
		$(id).value = variable;
	}
}
/**
 * 
 */
function reloadOther() {
	if (!get('ДАННЫЕ.НЕДВИЖИМОСТЬ.ЗДАНИЕ')) {
		return;
	}
	var ЗДАНИЕ = ДАННЫЕ.НЕДВИЖИМОСТЬ.ЗДАНИЕ;
	var length = Object.keys(ЗДАНИЕ).length;

	for (var i = 1; i <= length; i++) {
		other_button_add_building_new();
		setifisset('other_add_textarea' + i, ЗДАНИЕ[i].ТЕКСТ);
		setifisset('other_name_building' + i, ЗДАНИЕ[i].НАЗВАНИЕ);
		setifisset('other_place_building' + i, ЗДАНИЕ[i].ПЛОЩАДЬ);
		setifisset('other_floor_building' + i, ЗДАНИЕ[i].КОЛИЧЕСТВО_ЭТАЖЕЙ);
		setifisset('other_height_floor_building' + i, ЗДАНИЕ[i].ВЫСОТА_ЭТАЖЕЙ);
		setifisset('other_type_building' + i, ЗДАНИЕ[i].МАТЕРИАЛ);

		if (ЗДАНИЕ[i].АТРИБУТЫ && Object.keys(ЗДАНИЕ[i].АТРИБУТЫ).length > 0) {
			reloadCheckbox(ЗДАНИЕ[i], 'other_new_main_building' + i);
		}

		if (!ЗДАНИЕ[i].КОМНАТА) {
			continue;
		}

		var КОМНАТА = ЗДАНИЕ[i].КОМНАТА;
		var length2 = Object.keys(КОМНАТА).length;
		for (var j = 1; j <= length2; j++) {
			$('other-button-add-room' + i).click();
			if (КОМНАТА[j].ТЕКСТ) {
				$('other_add_textarea_room' + i + '' + j).value = КОМНАТА[j].ТЕКСТ;
			}
			if (КОМНАТА[j].НАЗВАНИЕ) {
				$('other_name_room' + i + '' + j).value = КОМНАТА[j].НАЗВАНИЕ;
			}
			if (КОМНАТА[j].ПЛОЩАДЬ) {
				$('other_place_room' + i + '' + j).value = КОМНАТА[j].ПЛОЩАДЬ;
			}
		}
	}
}
/**
 * надо еще чтобы подгружались добавленые фотки для незапостеной недвижимости
 */
function reloadPhotos() {
	if (!ДАННЫЕ.ФОТОГРАФИИ) {
		return;
	}

	var length = Object.keys(ДАННЫЕ.ФОТОГРАФИИ).length;
	var container = $("photo_container");

	for (var i = 0; i < length; i++) {
		if (ДАННЫЕ.ФОТОГРАФИИ[i] == '.' || ДАННЫЕ.ФОТОГРАФИИ[i] == '..') {
			continue;
		}
		var img = document.createElement("img");
		img.src = 'photo/' + getCookie('ID') + '/'
			+ ДАННЫЕ.НЕДВИЖИМОСТЬ.НОМЕР_ОБЪЯВЛЕНИЯ
			+ '/600/' + ДАННЫЕ.ФОТОГРАФИИ[i];
		var div = document.createElement("div");
		div.className = "photo-images-one";
		var divx = document.createElement("div");
		divx.innerText = "Удалить";
		divx.title = "Удалить";
		div.appendChild(divx);
		div.appendChild(img);
		div.fileName = ДАННЫЕ.ФОТОГРАФИИ[i];
		divx.name = ДАННЫЕ.ФОТОГРАФИИ[i];
		divx.div = div;
		divx.addEventListener('click', rm);
		container.appendChild(div);
	}

	function rm() {
		removeImage(this.name);
		$("photo_container").removeChild(this.div);
	}
}