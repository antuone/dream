/*
    ФУНКЦИИ ДЛЯ КАРТЫ
*/
var autocomplete,
	map,
	infowindow,
	marker,
	currentInfoWindow,
	componentForm = {
		street_number: 'short_name',
		route: 'long_name',
		locality: 'long_name',
		administrative_area_level_1: 'short_name',
		country: 'long_name',
		postal_code: 'short_name'
	},
	ПОЛИГОНЫ = [],
	МАРКЕРЫ = [];

var ОКОШКО_ДЛЯ_ВВОДА_ИМЕНИ_МАРКЕРА;



function initAutocomplete() {
	autocomplete = new google.maps.places.Autocomplete(
		(document.getElementById('autocomplete')),
		{ types: ['geocode'] }
	);

	autocomplete.addListener('place_changed', fillInAddress);

	ОКОШКО_ДЛЯ_ВВОДА_ИМЕНИ_МАРКЕРА = $('address_infowindow_input_ok').cloneNode(true);

	var infowindow_button_ok = ОКОШКО_ДЛЯ_ВВОДА_ИМЕНИ_МАРКЕРА.getElementsByTagName('button')[0];
	var infowindow_input = ОКОШКО_ДЛЯ_ВВОДА_ИМЕНИ_МАРКЕРА.getElementsByTagName('input')[0];
	spaceShow(ОКОШКО_ДЛЯ_ВВОДА_ИМЕНИ_МАРКЕРА);

	infowindow_button_ok.addEventListener('click', function () {

		var div = document.createElement('div');
		div.className = 'infowindow';

		if (!infowindow_input.value) {
			infowindow_input.value = '=)';
		}

		div.innerText = infowindow_input.value;
		infowindow_input.value = '';

		currentInfoWindow.setContent(div);
		div.infoWindow = currentInfoWindow;
		div.addEventListener('click', function () {
			currentInfoWindow = this.infoWindow;
			infowindow_input.value = currentInfoWindow.getContent().innerText;
			currentInfoWindow.setContent(ОКОШКО_ДЛЯ_ВВОДА_ИМЕНИ_МАРКЕРА);
		});

	});

	$('address_infowindow_input_ok').parentElement.removeChild($('address_infowindow_input_ok'));

}

// Для поиска без карты и ручного ввода адреса
// Заполнение инпутов данными адреса и вывод адреса
function fillInAddress() {
	
	$('address_button_ready').focus();

	var place = autocomplete.getPlace();

	if (!place.address_components) {
		// НЕПОНЯТНО ПОЧЕМУ ИНОГДА address_components = undefined 
		return false;
	}

	for (var component in componentForm) {
		document.getElementById(component).value = '';
		document.getElementById(component).disabled = false;
	}

	for (var i = 0; i < place.address_components.length; i++) {
		var addressType = place.address_components[i].types[0];
		if (componentForm[addressType]) {
			var val = place.address_components[i][componentForm[addressType]];
			document.getElementById(addressType).value = val;
		}
	}

	$('a_c_formatted_address').innerText = place.formatted_address;

	var lat = $('a_c_location_lat'),
		lng = $('a_c_location_lng');

	lat.innerText = lat.innerText.replace("?", (place.geometry.location.lat() + '').slice(0, 9));
	lng.innerText = lng.innerText.replace("?", (place.geometry.location.lng() + '').slice(0, 9));

	spaceShow('address_container');
}

// Иницыализация карты в окне поиска с картой
function initialize_address_map() {
	if (map) {
		return false;
	}
	var zoom = 17;
	// координаты Перми
	var center = { lat: 58.02968129999999, lng: 56.2667916 };

	if ($_GET('id') && ДАННЫЕ.МЕСТО) {
		center = { lat: Number(ДАННЫЕ.МЕСТО.lat), lng: Number(ДАННЫЕ.МЕСТО.lng) };
	}

	map = new google.maps.Map($('map'), {
		mapTypeId: google.maps.MapTypeId.HYBRID,
		fullscreenControl: true,
		center: center,
		zoom: zoom
	});
	infowindow = new google.maps.InfoWindow();
	marker = new google.maps.Marker({
		map: map,
		anchorPoint: new google.maps.Point(0, -29)
	});

	marker.addListener('click', function () {
		infowindow.open(map, marker);
	});

	autocomplete.addListener('place_changed', place_changed);

	var place = autocomplete.getPlace();

	if (place) {
		place_changed();
	} else {

		if ($_GET('id') && ДАННЫЕ.МЕСТО) {

			marker.setMap(map);
			marker.setPosition(center);

			infowindow.setContent(ДАННЫЕ.МЕСТО.name);
			infowindow.open(map, marker);



			var length = Object.keys(ДАННЫЕ.МАРКЕРЫ).length;
			for (var i = 0; i < length; i++) {
				var _infowindow = new google.maps.InfoWindow({
					content: '',
					maxWidth: 300
				});

				_infowindow.addListener('closeclick', function () {
					_infowindow.setMap(null);
					delete МАРКЕРЫ[_infowindow];
					_infowindow = null;
				});


				var div = document.createElement('div');
				div.className = 'infowindow';

				div.innerText = ДАННЫЕ.МАРКЕРЫ[i].NAME;

				div.infoWindow = _infowindow;
				div.addEventListener('click', function () {
					currentInfoWindow = this.infoWindow;
					currentInfoWindow.setContent(ОКОШКО_ДЛЯ_ВВОДА_ИМЕНИ_МАРКЕРА);
				});

				_infowindow.setOptions({
					content: div,
					position: {
						lat: Number(ДАННЫЕ.МАРКЕРЫ[i].LAT),
						lng: Number(ДАННЫЕ.МАРКЕРЫ[i].LNG)
					}
				});
				_infowindow.open(map);

				МАРКЕРЫ.push(_infowindow);
			}

			length = Object.keys(ДАННЫЕ.ПОЛИГОНЫ).length;
			for (i = 0; i < length; i++) {
				var coords = [];
				var length2 = Object.keys(ДАННЫЕ.ПОЛИГОНЫ[i]).length;
				for (var j = 0; j < length2; j++) {
					coords.push({
						lat: Number(ДАННЫЕ.ПОЛИГОНЫ[i][j].LAT),
						lng: Number(ДАННЫЕ.ПОЛИГОНЫ[i][j].LNG)
					});
				}


				var polygon = new google.maps.Polygon({
					paths: coords,
					fillColor: '#ffff00',
					fillOpacity: 0.3,
					strokeWeight: 5,
					clickable: true,
					editable: true,
					zIndex: 1,
					draggable: true
				});
				polygon.setMap(map);
				ПОЛИГОНЫ.push(polygon);
			}

		} else if (navigator.geolocation) {// Пытаемся получить координаты от браузера
			navigator.geolocation.getCurrentPosition(function (position) {
				var pos = {
					lat: position.coords.latitude,
					lng: position.coords.longitude
				};
				map.setCenter(pos);
			});
		}
		//?
		autocomplete.bindTo('bounds', map);
	}

	var drawingManager = new google.maps.drawing.DrawingManager({
		drawingControl: true,
		drawingControlOptions: {
			position: google.maps.ControlPosition.TOP_CENTER,
			drawingModes: [
				google.maps.drawing.OverlayType.MARKER,
				google.maps.drawing.OverlayType.POLYGON,
			]
		},
		polygonOptions: {
			fillColor: '#ffff00',
			fillOpacity: 0.3,
			strokeWeight: 5,
			clickable: true,
			editable: true,
			zIndex: 1,
			draggable: true
		},
		markerOptions: {
			clickable: true,
			editable: true
		}
	});
	drawingManager.setMap(map);


	google.maps.event.addListener(drawingManager, 'polygoncomplete', function (polygon) {
		drawingManager.setDrawingMode(null);
		ПОЛИГОНЫ.push(polygon);
	});

	google.maps.event.addListener(drawingManager, 'markercomplete', function (_marker) {

		drawingManager.setDrawingMode(null);

		var _infowindow = new google.maps.InfoWindow({
			content: '',
			maxWidth: 300
		});

		_infowindow.addListener('closeclick', function () {
			_infowindow.setMap(null);
			delete МАРКЕРЫ[_infowindow];
			_infowindow = null;
		});

		_infowindow.setOptions({ content: ОКОШКО_ДЛЯ_ВВОДА_ИМЕНИ_МАРКЕРА, position: _marker.position });
		_marker.setMap(null);
		_marker = null;
		_infowindow.open(map);
		currentInfoWindow = _infowindow;

		МАРКЕРЫ.push(_infowindow);
	});

	// Для кнопки "Очистить все" 
	map.clearDrawing = function () {
		ПОЛИГОНЫ.forEach(function (element) {
			element.setMap(null);
			element = null;
		});
		ПОЛИГОНЫ = [];
		МАРКЕРЫ.forEach(function (element) {
			element.setMap(null);
			element = null;
		});
		МАРКЕРЫ = [];
	};


	function place_changed() {
		infowindow.close();
		marker.setVisible(false);



		var place = autocomplete.getPlace();

		if (!place.geometry) {
			// ИЗМЕНИТЬ ТУТ ПОВЕДЕНИЕ
			// плохое поведение - поставить в угол
			window.alert("Autocomplete's returned place contains no geometry");
			return;
		}
		// If the place has a geometry, then present it on a map.
		if (place.geometry.viewport) {
			map.fitBounds(place.geometry.viewport);
		} else {
			map.setCenter(place.geometry.location);
			map.setZoom(17);
		}
		marker.setMap(map);
		marker.setPosition(place.geometry.location);
		marker.setVisible(true);

		infowindow.setContent(place.name);
		infowindow.open(map, marker);
	}
}
