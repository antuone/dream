/**
 * ДОПОЛНИТЕЛЬНО
 */

window.addEventListener("load", function () {

    //engineering_button_unmark_all
    $("engineering_button_mark_all").addEventListener("click", function () {
        var checkbox = $("engineering_for_click_all").getElementsByTagName("button");
        var length = checkbox.length;
        for (var i = 0; i < length; i++) {
            //умно умно =)
            if (checkbox[i].className.indexOf("checkbox") != -1 && checkbox[i].className.indexOf("checked") == -1) {
                checkbox[i].click();
            }
        }
    });

    $("engineering_button_unmark_all").addEventListener("click", function () {
        var checkbox = $("engineering_for_click_all").getElementsByTagName("button");
        var length = checkbox.length;
        for (var i = 0; i < length; i++) {
            if (checkbox[i].className.indexOf("checkbox") != -1 && checkbox[i].className.indexOf("checked") != -1) {
                checkbox[i].click();
            }
        }
    });
});



/**
 * фото
 */
function uploadFiles(url, files) {
    var formData = new FormData();

    for (var i = 0, file; file = files[i]; i++) {
        if (!file.type.match('image.*')) {
            continue;
        }
        formData.append(file.name, file);
    }

    if (get('ДАННЫЕ.НЕДВИЖИМОСТЬ.ИДЕНТИФИКАТОР')) {
        formData.append('ИДЕНТИФИКАТОР', ДАННЫЕ.НЕДВИЖИМОСТЬ.ИДЕНТИФИКАТОР);
    }
    var xhr = new XMLHttpRequest();
    xhr.open('POST', url, true);
    xhr.onreadystatechange = function () {
        if (this.status == 200 && this.readyState === XMLHttpRequest.DONE) {
            var json = JSON.parse(this.responseText)

            if (json.STATUS == 'Фото добавлено') {



            } else {
                console.log(this.responseText);
            }
        }
    };
    xhr.send(formData);  // multipart/form-data
}

function removeImage(name) {
    var xhr = new XMLHttpRequest();
    xhr.open('POST', 'php/removeimage.php', true);
    xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
    xhr.setRequestHeader('Accept', 'application/json');
    xhr.onreadystatechange = function () {
        if (this.status == 200 && this.readyState === XMLHttpRequest.DONE) {
            console.log(this.responseText);
        }
    };
    var query = 'name=' + name;
    var id = $_GET('id');
    if (id) {
        query += '&id=' + id;
    }
    xhr.send(query);
}

function photo_button_ok() {
    spaceSwitch('main-menu', getHeaderRealestate(), 'photo');

    var container = $("photo_container");

    if (container.getElementsByTagName('*').length > 0) {
        checked('menu_photo');
    }
}

window.addEventListener("load", function () {
    //console.log("Окно загрузилось!");
    //А тут конечно же надо сделать лайт версию для старых браузеров
    //И надо сделать полоску прогресса загрузки файла

    $("photo_button_ok").addEventListener("click", photo_button_ok);


    $("photo_file").addEventListener("change", function (evt) {
        var files = evt.target.files;
        //console.log(evt);

        uploadFiles('php/submitimage.php', files);

        //var photo_file = $("photo_file");

        for (var i = 0, f; f = files[i]; i++) {
            if (!f.type.match('image.*')) {
                continue;
            }
            var reader = new FileReader();
            reader.onload = (function (theFile) {
                return function (e) {
                    var container = $("photo_container");
                    var img = document.createElement("img");
                    img.src = e.target.result;
                    var div = document.createElement("div");
                    div.className = "photo-images-one";
                    var divx = document.createElement("div");
                    divx.innerText = "Удалить";
                    divx.title = "Удалить";
                    div.appendChild(divx);
                    div.appendChild(img);

                    divx.onclick = function () {
                        container.removeChild(div);
                        removeImage(theFile.name);
                    }
                    container.appendChild(div);
                };
            })(f);
            reader.readAsDataURL(f);
        }

    });

});







/**
 * Недвижимость
 */
function onclick_type_realestate() {
    $('property_apartment').focus();
    spaceSwitch('property', this.innerText, 'main-menu');
}
/**
 * 
 */
function onclick_price() {
    spaceSwitch('price', this.innerText, 'main-menu');
    $("price-price").focus();
}
/**
 * 
 */
function onclick_address() {
    initialize_script_APIMaps();
    spaceSwitch('address', ТЕКСТ[ЛОКАЛИЗАЦИЯ].АДРЕС, 'main-menu');
}
/**
 * 
 */
function initialize_script_APIMaps() {
    // кнопка МЕНЮ в адресе
    $('property_button_menu_right').title = ТЕКСТ[ЛОКАЛИЗАЦИЯ].ВЫБРАТЬ_ДРУГОЙ_ТИП_ПОИСКА_АДРЕСА;
    $('property_button_menu_right').onclick = address_button_menu_right;
    show('property_button_menu_right');

    if ($("APIMaps") === null) {
        var script = document.createElement("script");
        script.src = "https://maps.googleapis.com/maps/api/js?key=AIzaSyB0YaMfsWh0MyCN_khjY_qLRe6Cli234so&signed_in=true&libraries=places,drawing&callback=initAutocomplete&language=ru";
        script.id = "APIMaps";
        script.async = true;
        script.defer = true;
        document.getElementsByTagName("head")[0].appendChild(script);
        address_button_menu_right();
    }
}
window.addEventListener("load", function () {
    initialize('address', 'НЕДВИЖИМОСТЬ');
    initialize('engineering', 'НЕДВИЖИМОСТЬ');
    initialize('price', 'НЕДВИЖИМОСТЬ');
    initialize('property', 'НЕДВИЖИМОСТЬ');
    initialize('deal', 'НЕДВИЖИМОСТЬ');
    initialize('main-menu', 'НЕДВИЖИМОСТЬ');

    /*
        ОБРАБОТКА СОБЫТИЙ
    */
    // При клике на любой главный заголовок - переход в полноэкранный режим
    var h1 = document.getElementsByTagName('h1');
    for (var i = 0; i < h1.length; i++) {
        h1[i].addEventListener("click", launchFullScreen);
    }
    // Кнопка "Тест" для отладки
    $("main-menu-button-test").addEventListener("click", function () {
        console.log(ДАННЫЕ);
    });
    $("search_button_test").addEventListener("click", function () {
        console.log(ДАННЫЕ);
    });
    //
    $('address_button_test').addEventListener('click', function () {
        console.log(JSON.stringify(autocomplete.getPlace()));
    });


    // радио-кнопка "Тип сделки" в главном меню    
    $("menu-deal").addEventListener("click", function () {
        spaceSwitch('deal', this.innerText, 'main-menu');
        $("deal_sale").focus(); //Возможно лучше убрать, а то в телефоне сразу вылазит клавиатура
    });
    // кнопка ОК в сделке
    $("deal_button_ok").addEventListener("click", function () {
        if (РЕЖИМ == 'SEARCH') {
            deal_button_ok('search', 'search_deal');
        } else {
            deal_button_ok();
        }
    });

    // радио-кнопка "Недвижимость" в основном меню 
    $("menu-type-realestate").addEventListener("click", onclick_type_realestate);
    // кнопка "ОК" в списке недвижимостей
    $("property_button_back").addEventListener("click", function () {
        if (РЕЖИМ == 'SEARCH') {
            property_button_back('search', 'search_type_realestate');
        } else {
            property_button_back();
        }
    });
    // радио-кнопка "Стоимость" в главном меню
    $("menu-price").addEventListener("click", onclick_price);
    $("price-ready").addEventListener("click", function () {
        if (РЕЖИМ == 'SEARCH') {
            price_ready('search', 'search_price');
        } else {
            price_ready();
        }
    });
    $('price_checkbox_isbyagreement').addEventListener('click', function () {
        if (ischecked(this)) {
            disabled('price-price');
            disabled('price-currency');
            //$('price-price').value = '';
        } else {
            enabled('price-price');
            enabled('price-currency');
        }
    });

    // радио-кнопка "Адрес" в главном меню
    $("menu-address").addEventListener('click', onclick_address);
    // кнопка ОК в АДРЕСЕ
    $('address_button_ready').addEventListener('click', function () {
        if (РЕЖИМ == 'SEARCH') {
            $('search_button_search').focus();
            onclick_address_button_ready('search', 'search_address');
        } else {
            onclick_address_button_ready();
        }
    });
    // кнопка ОК в адресе в меню выбора типа поиска
    $('address_button_ok22').addEventListener('click', function () {
        if (РЕЖИМ == 'SEARCH') {
            spaceSwitch('search', getHeaderRealestate(), 'address');
        } else {
            spaceSwitch('main-menu', getHeaderRealestate(), 'address');
        }

    });
    // кнопка "Очистить все" в АДРЕСЕ
    $('address_reset').addEventListener('click', function () {
        if (map) {
            map.clearDrawing();
        }
        spaceHide('address_container');
        var menu_address = $('menu-address');
        if (menu_address.address_name) {
            menu_address.innerText = menu_address.address_name;
        }

        infowindow.setMap(null);
        marker.setMap(null);
        unchecked(menu_address);
    });
    // радио кнопка "Поиск без карты"
    $('address_button_without_map').addEventListener('click', click_address_button_without_map);
    // радио кнопка "Поиск с картой"
    $('address_button_with_map').addEventListener('click', function () {
        initialize_address_map();
        spaceShow('address_search_with_map');
        spaceHide('address_handed_input');
        spaceHide('address_search_without_map');
        address_button_menu_right();
    });
    // (Временно отключено)
    // радио кнопка "Ввод вручную"
    //$('address_button_handed_input').addEventListener('click', function() {
    //
    //    spaceHide('address_search_with_map');
    //    spaceShow('address_handed_input');
    //    spaceHide('address_search_without_map');
    //    address_button_menu_right();
    //});

    // кнопка "дополнительно"
    $('menu_engineering').addEventListener('click', function () {
        spaceSwitch('engineering', this.innerText, 'main-menu');
    });
    // Кнопка ОК в дополнительно
    $("engineering_button_ok").addEventListener("click", function () {
        if (РЕЖИМ == 'SEARCH') {
            engineering_button_ok('search', 'search_engineering');
        } else {
            engineering_button_ok();
        }
    });

    //кнопка "фото"
    $('menu_photo').addEventListener('click', function () {
        spaceSwitch('photo', this.innerText, 'main-menu');
    });
    $('menu_photo').addEventListener('click', function () {
        if (РЕЖИМ == 'EDIT') {
            reloadPhotos();
        }
    });

    $('Собственность-личная').addEventListener('click', function () {
        spaceHide('Невидимый-блок-если-собственность-личная');
    });

    $('Собственность-долевая').addEventListener('click', function () {
        spaceShow('Невидимый-блок-если-собственность-личная');
    });

    var ОТКРЫТЫЙ_БЛОК_ИМУЩЕСТВА = null;
    установитьСобытиеДляИмущества('apartment', $("property_apartment"));
    установитьСобытиеДляИмущества('house', $("property_house"));
    установитьСобытиеДляИмущества('parcel', $("property_parcel"));
    установитьСобытиеДляИмущества('garage', $("property_garage"));
    установитьСобытиеДляИмущества('room', $("property_room"));
    установитьСобытиеДляИмущества('hotel', $("property_hotel"));
    установитьСобытиеДляИмущества('other', $("property_other"));
    /**
     * Из названия понятно же =)
     */
    function установитьСобытиеДляИмущества(realestate, realestateMenu) {
        realestateMenu.addEventListener('click', function () {
            if (ОТКРЫТЫЙ_БЛОК_ИМУЩЕСТВА) {
                spaceHide(ОТКРЫТЫЙ_БЛОК_ИМУЩЕСТВА);
            }
            if (this.id == 'property_parcel') {
                spaceHide('Невидимый-блок-для-земельного-участка');
            } else {
                spaceShow('Невидимый-блок-для-земельного-участка');
            }

            if (this.id == 'property_apartment' || this.id == 'property_house') {
                spaceShow('Видимый-блок-только-для-жилья');
            } else {
                spaceHide('Видимый-блок-только-для-жилья');
            }

            spaceShow(realestate);
            ОТКРЫТЫЙ_БЛОК_ИМУЩЕСТВА = realestate;
            hide('property_button_back');
        });
    }
});

// кнопка ОК в списке сделок
function deal_button_ok(id_block = 'main-menu', id_button = 'menu-deal') {
    spaceSwitch(id_block, getHeaderRealestate(), 'deal');
    var menuDeal = $(id_button);
    if (ДАННЫЕ.НЕДВИЖИМОСТЬ && ДАННЫЕ.НЕДВИЖИМОСТЬ.DEAL) {
        var buttons = $('deal').getElementsByTagName("button");
        for (var i = 0; i < buttons.length; i++) {
            if (buttons[i].value == ДАННЫЕ.НЕДВИЖИМОСТЬ.DEAL) {
                menuDeal.innerText = buttons[i].innerText;
                break;
            }
        }
        checked(menuDeal);
    }
    mainMenuNextFocus();
}
// кнопка ОК в списке недвижимости
function property_button_back(id_block = 'main-menu', id_button = 'menu-type-realestate') {
    hide('property_button_menu_right');
    spaceSwitch(id_block, getHeaderRealestate(), 'property');

    if (get('ДАННЫЕ.НЕДВИЖИМОСТЬ') && get('ДАННЫЕ.НЕДВИЖИМОСТЬ.ИМУЩЕСТВО')) {
        var button = $('property').getElementsByTagName('button');
        for (var i = 0; i < button.length; i++) {
            if (button[i].value == ДАННЫЕ.НЕДВИЖИМОСТЬ.ИМУЩЕСТВО) {
                $(id_button).innerText = button[i].innerText;
                checked(id_button);
                break;
            }
        }
    }
}
/* кнопка ОК в меню "Стоимость и документы" */
function price_ready(id_block = 'main-menu', id_button = 'menu-price') {
    spaceSwitch(id_block, getHeaderRealestate(), 'price');

    var currency = $('price-currency').value;
    var menu = $(id_button);
    var price = $('price-price').value;

    if (get("ДАННЫЕ.НЕДВИЖИМОСТЬ.АТРИБУТЫ.ISBYAGREEMENT") == 1) {
        checked(menu);
        menu.innerText = ТЕКСТ[ЛОКАЛИЗАЦИЯ].ПО_ДОГОВОРЕННОСТИ;
    } else if (price) {
        checked(menu);
        menu.innerText = str2price(price) + " " + currency;
    } else {
        unchecked(menu);
        menu.innerText = ТЕКСТ[ЛОКАЛИЗАЦИЯ].СТОИМОСТЬ_И_ДРУГОЕ;
    }
    mainMenuNextFocus();
}
// Кнопка ОК в Адресе
function onclick_address_button_ready(id_block = 'main-menu', id_button = 'menu-address') {
    hide('property_button_menu_right');
    spaceSwitch(id_block, getHeaderRealestate(), 'address');

    var inputs = $('address_handed_input').getElementsByTagName('input');
    var isAllEmpty = true;
    for (var i = 0; i < inputs.length; i++) {
        if (inputs[i].value) {
            //ДАННЫЕ[inputs[i].id] = inputs[i].value;
            isAllEmpty = false;
        }
    }
    ДАННЫЕ.ПОЛИГОНЫ = [];
    ДАННЫЕ.МАРКЕРЫ = [];

    МАРКЕРЫ.forEach(function (element) {
        ДАННЫЕ.МАРКЕРЫ.push({
            name: element.getContent().innerText,
            lat: element.getPosition().lat().toString(),
            lng: element.getPosition().lng().toString()
        });
    });

    ПОЛИГОНЫ.forEach(function (element) {
        var arr = [];
        element.getPath().getArray().forEach(function (_element) {
            arr.push({
                lat: _element.lat().toString(),
                lng: _element.lng().toString()
            });
        });
        ДАННЫЕ.ПОЛИГОНЫ.push(arr);
    });

    var place = autocomplete.getPlace();

    if (!place || isAllEmpty) {
        return false;
    }

    ДАННЫЕ.МЕСТО = place;

    var address = '';
    if (place.vicinity && place.name != place.vicinity) {
        address = place.name + ', ' + place.vicinity;
    } else {
        address = place.name;
    }

    var menu_address = $(id_button);
    menu_address.address_name = menu_address.innerText;

    menu_address.innerText = address;

    if (menu_address.address_name != address) {
        checked(menu_address);
    }
    mainMenuNextFocus();

}

/* Обработка нажатия кнопки ОК в форме-данных "Инженерные коммуникации" */
function engineering_button_ok(id_block = 'main-menu', id_button = 'menu_engineering') {
    spaceSwitch(id_block, getHeaderRealestate(), 'engineering');
    mainMenuNextFocus();

    var checkbox = $('engineering').getElementsByTagName('button');
    var isChecked = false;

    for (var i = 0; i < checkbox.length; i++) {
        if (checkbox[i].value == 1) {
            isChecked = true;
            break;
        }
    }

    if (isChecked) {
        checked(id_button);
    } else {
        unchecked(id_button);
    }
}

// Кнопка "ОК" в недвижимости
// СОЗДАТЬ НЕДВИЖИМОСТЬ
function realestateCreate() {
    var is_error = false;

    spaceCloseAll('errors');

    // Заполните сначало данные пожалуйста

    if (!ДАННЫЕ.НЕДВИЖИМОСТЬ) {
        showErrorOnTime('errors_required_all');
        return false;
    }
    // Площадь
    if (!ДАННЫЕ.НЕДВИЖИМОСТЬ.ПЛОЩАДЬ) {
        showErrorOnTime('errors_required_space');
        is_error = true;
    }
    // Тип сделки должен быть заплнен обязательно
    if (!ДАННЫЕ.НЕДВИЖИМОСТЬ.СДЕЛКА) {
        showErrorOnTime('errors_required_deal');
        is_error = true;
    }
    // Тип недвижимости должен быть заполнен обязательно
    if (!ДАННЫЕ.НЕДВИЖИМОСТЬ.ИМУЩЕСТВО) {
        showErrorOnTime('errors_required_property');
        is_error = true;
    }
    // Цена должна быть указана обязательно
    if (!ДАННЫЕ.НЕДВИЖИМОСТЬ.ЦЕНА && $('price_checkbox_isbyagreement').value != 1) {
        showErrorOnTime('errors_required_price');
        is_error = true;
    }
    // Адрес 
    if (!ДАННЫЕ.МЕСТО) {
        showErrorOnTime('errors_required_address');
        is_error = true;
    }
    if (is_error) {
        return false;
    }
    if (ДАННЫЕ.МЕСТО.geometry) {
        if (ДАННЫЕ.МЕСТО.geometry.location) {
            ДАННЫЕ.МЕСТО.lat = ДАННЫЕ.МЕСТО.geometry.location.lat();
            ДАННЫЕ.МЕСТО.lng = ДАННЫЕ.МЕСТО.geometry.location.lng();
        }
        if (ДАННЫЕ.МЕСТО.geometry.viewport) {
            ДАННЫЕ.МЕСТО.north = ДАННЫЕ.МЕСТО.geometry.viewport.b.b;
            ДАННЫЕ.МЕСТО.east = ДАННЫЕ.МЕСТО.geometry.viewport.b.f;
            ДАННЫЕ.МЕСТО.south = ДАННЫЕ.МЕСТО.geometry.viewport.f.b;
            ДАННЫЕ.МЕСТО.west = ДАННЫЕ.МЕСТО.geometry.viewport.f.f;
        }
    }
    var script = "";
    if ($_GET("id")) {
        script = 'php/realestate/update.php';
    } else {
        script = 'php/realestate/new.php';
    }

    var request = new XMLHttpRequest(script);
    request.open('POST', script);
    request.send(JSON.stringify(ДАННЫЕ));
    request.onreadystatechange = function () {
        if (this.status == 200 && this.readyState === XMLHttpRequest.DONE) {
            enabled('main_menu_button_send');
            if (request.responseText == 1) {
                initializePrivate();
                spaceSwitch('private_office', $('main_menu_private').innerText, 'main-menu');
            } else {
                showErrorOnTime('errors_add_realestate');
            }
        }
    };
    disabled('main_menu_button_send');
}


// Кнопка "ОК" в недвижимости
// РЕКДАКТИРОВАНИЕ НЕДВИЖИМОСТи
function realestateEdit() {

    if (ДАННЫЕ.МЕСТО.geometry) {
        if (ДАННЫЕ.МЕСТО.geometry.location) {
            ДАННЫЕ.МЕСТО.lat = ДАННЫЕ.МЕСТО.geometry.location.lat();
            ДАННЫЕ.МЕСТО.lng = ДАННЫЕ.МЕСТО.geometry.location.lng();
        }
        if (ДАННЫЕ.МЕСТО.geometry.viewport) {
            ДАННЫЕ.МЕСТО.north = ДАННЫЕ.МЕСТО.geometry.viewport.b.b;
            ДАННЫЕ.МЕСТО.east = ДАННЫЕ.МЕСТО.geometry.viewport.b.f;
            ДАННЫЕ.МЕСТО.south = ДАННЫЕ.МЕСТО.geometry.viewport.f.b;
            ДАННЫЕ.МЕСТО.west = ДАННЫЕ.МЕСТО.geometry.viewport.f.f;
        }
    }

    var script = 'php/realestate/update.php';

    var request = new XMLHttpRequest(script);
    request.open('POST', script);
    request.send(JSON.stringify(ДАННЫЕ));
    request.onreadystatechange = function () {
        if (this.status == 200 && this.readyState === XMLHttpRequest.DONE) {
            enabled('main_menu_button_send');
            if (request.responseText == 1) {
                initializePrivate();
                spaceSwitch('private_office', $('main_menu_private').innerText, 'main-menu');
            } else {
                showErrorOnTime('errors_add_realestate');
            }
        }
    };
    disabled('main_menu_button_send');
}



// переключает видимость содержимого адреса и меню справа
function address_button_menu_right() {
    spaceSwitch2('address_menu_right');
    spaceSwitch2('address_main_content');
}

function click_address_button_without_map() {
    spaceHide('address_search_with_map');
    spaceHide('address_handed_input');
    spaceShow('address_search_without_map');
    address_button_menu_right();
}