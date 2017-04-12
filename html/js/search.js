/** Тексты для презентационного вывода объявления */
var PRESENT = {
	RU: {
		TEXT: {
			DIVXTITLE: 'Удалить это объявление из этого списка',
			ROOMS: 'комн.',
			FLOOR: 'эт.',
		},
		TYPEHOUSE: {
			PANEL: 'панель',
			MONOLITHIC: 'монолит',
			MODULAR: 'блок',
			BRICK: 'кирпич'
		}
	},
	DEAL: {
		RU: {
			SELL: 'Продается',
			BUY: 'Купят',
			EXCHANGE: 'Обменяют',
			SELLRENT: 'Продается в аренду',
			BUYRENT: 'Купят в аренду'
		}
	},
	ИМУЩЕСТВО: {
		RU: {
			APARTMENT: {
				APARTMENT: 'Квартира',
				PARTAPARTMENT: 'Часть квартиры',
			},
			HOUSE: {
				HOUSE: 'Дом',
				PARTHOUSE: 'Часть дома'
			},
			PARCEL: 'Участок земли',
			GARAGE: {
				ГАРАЖ: 'Гараж',
				МАШИНОМЕСТО: 'Машиноместо'
			},
			ROOM: {
				ОФИСНОЕ: 'Офисное помещение',
				ТОРГОВОЕ: 'Торговое помещение',
				СКЛАДСКОЕ: 'Складское помещение',
				СВОБОДНОГОНАЗНАЧЕНИЯ: 'Помещение свободного назначения',
				САЛОНКРАСОТЫ: 'Салон красоты',
				ПРОИЗВОДСТВЕННОГОНАЗНАЧЕНИЯ: 'Помещение производственного назначения',
				ОБЩЕСТВЕННОГОПИТАНИЯ: 'Помещение общественного питания'
			},
			HOTEL: 'Гостиница',
			OTHER: 'Другое'
		}
	}
};

var SEARCH_MAP = null;
var SEARCH_MARKERS = [];

function initAPIMAP() {
	if ($("APIMaps") === null) {
		var script = document.createElement("script");
		script.src = "https://maps.googleapis.com/maps/api/js?key=AIzaSyB0YaMfsWh0MyCN_khjY_qLRe6Cli234so&signed_in=true&libraries=places,drawing&callback=initMap&language=ru";
		script.id = "APIMaps";
		script.async = true;
		script.defer = true;
		document.getElementsByTagName("head")[0].appendChild(script);
		address_button_menu_right();
	} else {
		initMap();
	}
}

function initMap() {
	/**
	 * 15 улица
	 * 10 город
	 * 4  регион
	 * 2  страна
	 */
	var zoom = 10;
	var types = get('ДАННЫЕ.PLACE.types');
	if (types) {
		for (var i = 0; i < types.length; i++) {
			if (types[i] == 'street_address') {
				zoom = 17;
				break;
			}
			if (types[i] == 'route') {
				zoom = 15;
				break;
			}
			if (types[i] == 'locality') {
				zoom = 10;
				break;
			}
			if (types[i] == 'administrative_area_level_1') {
				zoom = 4;
				break;
			}
			if (types[i] == 'country') {
				zoom = 2;
				break;
			}
		}
	}

	var center = {
		lat: ДАННЫЕ.PLACE.geometry.location.lat(),
		lng: ДАННЫЕ.PLACE.geometry.location.lng()
	};

	if (!SEARCH_MAP) {
		SEARCH_MAP = new google.maps.Map($('MAP_SEARCH'), {
			zoom: zoom,
			center: center
		});
	}

	SEARCH_MAP.setCenter(center);
	SEARCH_MAP.setZoom(zoom);

}

function onloadScriptSearch() {
	initialize('search', 'НЕДВИЖИМОСТЬ');
	initialize('search_price', 'НЕДВИЖИМОСТЬ');

	$('search_button_search').addEventListener('click', function () {
		var isError = false;
		if (!get('ДАННЫЕ.МЕСТО')) {
			showErrorOnTime('errors_required_address');
			isError = true;
		}
		if (!get('ДАННЫЕ.НЕДВИЖИМОСТЬ.ИМУЩЕСТВО')) {
			showErrorOnTime('errors_required_property');
			isError = true;
		}
		if (isError) {
			return false;
		}

		var request7 = new XMLHttpRequest();
		request7.open("POST", 'php/realestate/search.php', true);
		request7.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
		request7.setRequestHeader('Accept', 'application/json');
		request7.send(JSON.stringify(ДАННЫЕ));
		request7.onreadystatechange = function () {
			if (this.status == 200 && this.readyState === XMLHttpRequest.DONE) {
				try {
					draw_re(JSON.parse(this.responseText));
				} catch (e) {
					showErrorOnTime('errors_request_error');
				}
			}
		};
	});

	// радио-кнопка "Тип сделки" в главном меню    
	$("search_deal").addEventListener("click", function () {
		spaceSwitch('deal', this.innerText, 'search');
	});

	// радио-кнопка "Недвижимость" в основном меню 
	$("search_type_realestate").addEventListener("click", function () {
		$('property_apartment').focus();
		spaceSwitch('property', this.innerText, 'search');
	});

	// радио-кнопка "Стоимость" в главном меню
	$("search_button_price").addEventListener("click", function () {
		spaceSwitch('search_price', ТЕКСТ[ЛОКАЛИЗАЦИЯ].СТОИМОСТЬ_И_ДРУГОЕ, 'search');
	});
	// по договорености
	$('search_price_checkbox_isbyagreement').addEventListener('click', function () {
		if (ischecked(this)) {
			disabled('search_price_from');
			disabled('search_price_to');
			disabled('search_price_currency');
		} else {
			enabled('search_price_from');
			enabled('search_price_to');
			enabled('search_price_currency');
		}
	});

	// кнопка ОК в блоке search_price
	$('search_price_button_ok').addEventListener('click', function () {
		spaceSwitch('search', getHeaderRealestate(), 'search_price');

		var currency = $('price-currency').value;
		var menu = $('search_button_price');
		var search_price_from = $('search_price_from').value;
		var search_price_to = $('search_price_to').value;
		menu.innerText = '';
		if (get('ДАННЫЕ.НЕДВИЖИМОСТЬ.АТРИБУТЫ.ISBYAGREEMENT') == 1) {
			checked(menu);
			menu.innerText = ТЕКСТ[ЛОКАЛИЗАЦИЯ].ПО_ДОГОВОРЕННОСТИ;
		} else if (search_price_from || search_price_to) {
			checked(menu);
			var comma = '';
			if (search_price_from) {
				menu.innerText = ТЕКСТ[ЛОКАЛИЗАЦИЯ].ОТ + ' ' + str2price(search_price_from);
				comma = ', ';
			}
			if (search_price_to) {
				menu.innerText += comma + ТЕКСТ[ЛОКАЛИЗАЦИЯ].ДО + ' ' + str2price(search_price_to);
			}
			menu.innerText += " " + currency;

		} else {
			unchecked(menu);
			menu.innerText = ТЕКСТ[ЛОКАЛИЗАЦИЯ].СТОИМОСТЬ_И_ДРУГОЕ;
		}
		mainMenuNextFocus();
	});

	// радио-кнопка "Адрес" в главном меню
	$("search_address").addEventListener('click', function () {
		initialize_script_APIMaps();
		spaceSwitch('address', ТЕКСТ[ЛОКАЛИЗАЦИЯ].АДРЕС, 'search');
		address_button_menu_right();
		$('autocomplete').focus();
	});

	// "дополнительно"
	$('search_engineering').addEventListener('click', function () {
		spaceSwitch('engineering', this.innerText, 'search');
	});

	$('search_button').addEventListener('click', function () {
		spaceSwitch('search', 'НЕМЕНЯТЬ', 'search_result');
	});
}



function draw_re(DATA2) {
	if (not(DATA2.STATUS)) {
		return false;
	}
	if (DATA2.STATUS == 'Ничего не найдено') {
		return false;
	}
	if (DATA2.STATUS != 'Есть данные') {
		return false;
	}
	if (not(DATA2.НЕДВИЖИМОСТЬ)) {
		return false;
	}

	spaceSwitch('search_result', 'НЕМЕНЯТЬ', 'search');
	$('search_container').innerHTML = '';

	var isNeedMap = ischecked('search_button_with_map');
	if (isNeedMap) {
		initAPIMAP();
		show('MAP_SEARCH');
	} else {
		hide('MAP_SEARCH');
	}

	var image = {
		url: 'png/marker2.png',
		// This marker is 20 pixels wide by 32 pixels high.
		size: new google.maps.Size(15, 15),
		// The origin for this image is (0, 0).
		origin: new google.maps.Point(0, 0),
		// The anchor for this image is the base of the flagpole at (0, 32).
		anchor: new google.maps.Point(0, 15)
	};
	var shape = {
		coords: [1, 1, 1, 20, 18, 20, 18, 1],
		type: 'poly'
	};

	for (var i = 0; i < SEARCH_MARKERS.length; i++) {
		SEARCH_MARKERS[i].setMap(null);
	}
	SEARCH_MARKERS.length = 0;

	var REALESTATE2 = DATA2.НЕДВИЖИМОСТЬ;
	var length = Object.keys(REALESTATE2).length;
	for (var i = 0; i < length; i++) {
		var R = REALESTATE2[i];


		if (!isNeedMap) {
			addRealestateInList(R);
		} else {
			var marker = new google.maps.Marker({
				position: { lat: +R.lat, lng: +R.lng },
				map: SEARCH_MAP,
				icon: image,
				shape: shape,
				title: title + ' ' + price,
				zIndex: i
			});

			marker.R = R;
			marker.addListener('click', function () {
				addRealestateInList(this.R);
			});
			SEARCH_MARKERS.push(marker);
		}
	}
}

function addRealestateInList(R) {
	var inc_card = inviteObjectLevel1('card', 'search_container', 'CARD');

	var title = R.АДРЕС + ', ' + R.SPACETOTAL + 'м<sup>2</sup>';
	var price = '';
	if (R.АТРИБУТЫ.indexOf('ISBYAGREEMENT') == -1) {
		price = str2price(R.ЦЕНА + '') + ' ' + R.CURRENCY;
	} else {
		price = ТЕКСТ[ЛОКАЛИЗАЦИЯ]['ПО_ДОГОВОРЕННОСТИ'];
	}

	$('card_price' + inc_card).innerText = price;
	$('card_space' + inc_card).innerText = R.SPACETOTAL;
	$('card_address' + inc_card).innerText = R.АДРЕС;

	if (R.TEXT.length - 130 > 0) {
		R.TEXT = R.TEXT.substr(0, 130) + '...';
	}
	$('card_text' + inc_card).innerText = R.TEXT;
	//НЕ ПАШЕТ СЛЕДУЮЩАЯ СТРОКА
	//$('divx' + inc_card).title = PRESENT[LANGUAGE].TEXT.DIVXTITLE;

	var type = getProperty(R);
	var A = R.APARTMENT;
	if (A.APARTMENTINTEGRITY == 'PARTAPARTMENT') {
		type += ', ' + A.APARTMENTOWNEDROOMS + '/'
			+ A.APARTMENTQUANTITYROOMS;
	}
	if (A.APARTMENTINTEGRITY == 'APARTMENT') {
		if (A.APARTMENTQUANTITYROOMS) {
			type += ', ' + A.APARTMENTQUANTITYROOMS;
		}
	}

	type += ' ' + PRESENT[LANGUAGE].TEXT.ROOMS;

	type += ', ' + A.APARTMENTFLOOR + '/'
		+ A.APARTMENTNUMBEROFSTOREYS + PRESENT[LANGUAGE].TEXT.FLOOR;

	if (A.APARTMENTTYPEHOUSE) {
		type +=', ' + PRESENT[LANGUAGE].TYPEHOUSE[A.APARTMENTTYPEHOUSE];
	}
	$('card_type' + inc_card).innerText = type;

	spaceShow('card' + inc_card);

	if (R.ФОТОГРАФИИ) {
		var length = Object.keys(R.ФОТОГРАФИИ).length;
		if (length > 0) {
			$('card_image' + inc_card).src = 'photo/' + R.IDUSER + '/' + R.NUMBER + '/200/'
				+ R.ФОТОГРАФИИ[getRandomInt(0, length)];
		}
	}

	$('card' + inc_card).addEventListener('click', function () {
		spaceSwitch('realestate', 'НЕМЕНЯТЬ', 'search_result');
		var property = R.ИМУЩЕСТВО.toLowerCase();
		$('realestate_property').innerHTML = '';
		inc = inviteObjectLevel1($(property), $('realestate_property'), 're1', false);
		hide(property + '_button_ok' + inc);
		show('realestate_present_room' + inc);
		$('additionally').innerHTML = '';
		inc = inviteObjectLevel1($('engineering'), $('additionally'), 're1', false);
		hide('engineering_button_ok' + inc);
		hide('engineering_button_mark_all' + inc);
		hide('engineering_button_unmark_all' + inc);
		requestRealestet(R.ИДЕНТИФИКАТОР);
	});


}


function requestRealestet(ИДЕНТИФИКАТОР) {
	var request = new XMLHttpRequest();
	request.open("POST", 'php/realestate/data.php', true);
	request.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
	request.setRequestHeader('Accept', 'application/json');
	request.send('id=' + ИДЕНТИФИКАТОР);

	request.onreadystatechange = function () {
		if (this.status == 200 && this.readyState === XMLHttpRequest.DONE) {
			reloadRealestate2(JSON.parse(request.responseText));
		}
	};
}

function getProperty(R) {
	var S = false;
	switch (R.ИМУЩЕСТВО) {
		case 'APARTMENT': if (!S) S = R[R.ИМУЩЕСТВО]['APARTMENTINTEGRITY'];
		case 'HOUSE': if (!S) S = R[R.ИМУЩЕСТВО]['ISFULLHOUSE'];
		case 'GARAGE': if (!S) S = R[R.ИМУЩЕСТВО]['GARAGEGARAGEORPARKINGPLACE'];
		case 'ROOM': if (!S) S = R[R.ИМУЩЕСТВО]['ROOMTYPEROOM'];
			if (S) {
				return PRESENT.ИМУЩЕСТВО[LANGUAGE][R.ИМУЩЕСТВО][S];
			} else {
				return ИМУЩЕСТВО[LANGUAGE][R.ИМУЩЕСТВО];
			}
		case 'HOTEL':
		case 'PARCEL':
		case 'HOTEL':
		case 'OTHER':
			return PRESENT.ИМУЩЕСТВО[LANGUAGE][R.ИМУЩЕСТВО];
	}
}

function reloadRealestate2(DATA2) {
	var R = DATA2.НЕДВИЖИМОСТЬ;
	$('realestate_deal').innerText = PRESENT.DEAL[LANGUAGE][R.DEAL];

	var property = getProperty(R);


	$('realestate_property2').innerText = property;
	if (R.АТРИБУТЫ.indexOf('ISBYAGREEMENT') != -1) {
		$('realestate_price').innerText = ТЕКСТ[ЛОКАЛИЗАЦИЯ]['ПО_ДОГОВОРЕННОСТИ'];
	} else {
		$('realestate_price').innerText = str2price('' + R.ЦЕНА) + ' ' + R.CURRENCY;
	}
	$('realestate_space').innerHTML = R.SPACETOTAL + 'м<sup>2</sup>';
	$('realestate_address').innerText = DATA2.PLACE.name + ', ' + DATA2.PLACE.vicinity;
	$('realestate_text').innerText = R.TEXT;

	var inc = $('realestate_property').inc;
	property = R.ИМУЩЕСТВО.toLowerCase();
	var form = $(property + inc);
	switch (R.ИМУЩЕСТВО) {
		case 'APARTMENT':
			form.removeChild($('apartment_integrity' + inc));
			form.removeChild($('realestate_f_add_room' + inc));
			presentFillRooms('realestate_container_present_room' + inc,
				R[R.ИМУЩЕСТВО]['ROOM'], 'apartment_new_room');
			break;
		case 'HOUSE':
			break;
		case 'GARAGE':
			break;
		case 'ROOM':
			break;
		case 'HOTEL':
			break;
		case 'PARCEL':
			break;
		case 'HOTEL':
			break;
		case 'OTHER':
	}

	reloadForm(R[R.ИМУЩЕСТВО], form);
	reloadForm(R, 'engineering' + inc);
}

function presentFillRooms(CONTAINER, ROOMS, IDROOM) {
	if (!CONTAINER || !ROOMS || !IDROOM) {
		return;
	}
	var LABELS = $(IDROOM).getElementsByTagName('label');
	var KEYS_ROOMS = Object.keys(ROOMS);
	for (var i = 1; i <= KEYS_ROOMS.length; i++) {
		var R = ROOMS[i];
		inc = inviteObjectLevel1('present_room', CONTAINER, 'PRESENT_ROOM', false);
		var table = $('present_room' + inc);
		for (var j = 0; j < LABELS.length; j++) {
			var L = LABELS[j];
			var td1 = document.createElement('td');
			td1.innerText = L.firstChild.textContent.trim();
			var td2 = document.createElement('td');
			switch (L.control.tagName) {
				case 'SELECT':
					if (R[L.control.name]) {
						td2.innerText = getSelectText(L.control, R[L.control.name]);
					}
					break;
				case 'INPUT':
					if (R[L.control.name]) {
						td2.innerText = R[L.control.name];
					}
					break;
			}
			var tr = document.createElement('tr');
			tr.appendChild(td1);
			tr.appendChild(td2);
			table.appendChild(tr);
		}
	}

}

// var KEYS_ROOMS = Object.keys(ROOMS).length;
// for (var i = 1; i <= KEYS_ROOMS.length; i++) {
// 	var R = ROOMS[i];
// 	inc = inviteObjectLevel1('present_room', CONTAINER, 'PRESENT_ROOM', false);
// 	var table = $('present_room' + inc);
// 	var KEYS_ALLOWED = Object.keys(ALLOWED);
// 	for (var i = 0; i < KEYS_ALLOWED.length; i++) {
// 		var K = KEYS_ALLOWED[i];
// 		if (R[K]) {
// 		}
// 	}
// }

function presentFillRoomsApartment(ROOM, inc) {
	if (!ROOM) {
		return;
	}

	var length = Object.keys(ROOM).length;
	for (var i = 1; i <= length; i++) {
		var R = ROOM[i];
		// заголовок
		var header = '';
		if (R.APARTMENTNEWNAMEROOM) {
			header = R.APARTMENTNEWNAMEROOM;
		} else {
			header = ТЕКСТ[ЛОКАЛИЗАЦИЯ]['ROOM'];
		}
		if (R.APARTMENTNEWROOMSPACE) {
			header += ', ' + R.APARTMENTNEWROOMSPACE + ТЕКСТ[ЛОКАЛИЗАЦИЯ].M2;
		}
		// текст
		var APARTMENTLOGGIA = getSelectText('apartment_loggia', R.APARTMENTLOGGIA);
		var APARTMENTWINDOWSIDE = getSelectText('apartment_side', R.APARTMENTWINDOWSIDE);
		var main = '';
		var vih = false;
		switch (R.APARTMENTLOGGIA) {
			case 'WINDOW':
			case 'BALCONY':
				vih = ТЕКСТ[ЛОКАЛИЗАЦИЯ].ВЫХОДЯЩЕЕ;
			case 'LOGGIA':
				if (!vih) vih = ТЕКСТ[ЛОКАЛИЗАЦИЯ].ВЫХОДЯЩИЙ;
				main = APARTMENTLOGGIA + ' '
					+ ТЕКСТ[ЛОКАЛИЗАЦИЯ].СВИДОМНА + ' '
					+ R.APARTMENTVIEWFROMTHEWINDOW + ', '
					+ vih + ' ' + APARTMENTWINDOWSIDE;
		}
		presentAddRoom(header, main, '', 'realestate_container_present_room' + inc, 'PRESENT_ROOM');
	}
}

//заполнить форму данными
function reloadForm(P, form) {
	if (typeof (form) == 'string') {
		form = $(form);
	}

	form = form.getElementsByTagName('fieldset');
	for (var i = 0; i < form.length; i++) {
		var fieldset = form[i].getElementsByTagName('*');
		form[i].disabled = true;
		for (var j = 0; j < fieldset.length; j++) {
			var E = fieldset[j];

			if (!E.name) {
				continue;
			}
			// radiobox
			if (E.value && P[E.name] && E.value == P[E.name]) {
				checked(E);
			}
			// checkbox
			if (P.АТРИБУТЫ && P.АТРИБУТЫ.indexOf(E.name) != -1) {
				checked(E);
			}
			//input
			if (E.tagName == 'INPUT' && P[E.name]) {
				E.value = P[E.name];
			}
		}
	}
}