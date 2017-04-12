/**
 *  КВАРТИРА
 */

/* Обработка нажатия кнопки ОК в форме-данных "Квартира, Часть квартиры" */
function apartment_button_ok() {
    spaceHide($("property"));
    spaceShow($("main-menu"));
    var apartment = "";

    if (get('ДАННЫЕ.НЕДВИЖИМОСТЬ.СОБСТВЕННОСТЬ') == 'ДОЛЕВАЯ') {
        apartment = ИМУЩЕСТВО[ЛОКАЛИЗАЦИЯ].ЧАСТЬ_КВАРТИРЫ;
        apartment += ", " + ТЕКСТ[ЛОКАЛИЗАЦИЯ].КОМНАТ + ' ' + $("Комнат-для-сделки").value;
    } else {
        apartment = ИМУЩЕСТВО[ЛОКАЛИЗАЦИЯ].КВАРТИРА;
    }

    $("menu-type-realestate").innerHTML = apartment;
    checked($("menu-type-realestate"));
    mainMenuNextFocus();
}

window.addEventListener("load", function () {

    $("apartment_button_ok").addEventListener("click", apartment_button_ok);


    $("Собственность-личная").addEventListener('click', function () {
        Если_Изменена_Собственность('apartment_container_for_rooms');
    });

    $("Собственность-долевая").addEventListener('click', function () {
        Если_Изменена_Собственность('apartment_container_for_rooms', 'Долевая');
    });

    $("apartment_add_room").addEventListener("click", apartment_add_room);

});

function Если_Изменена_Собственность(Контейнер, Собственность = 'Личная') {
    var elements = $(Контейнер).getElementsByTagName("button");
    var length = elements.length;
    for (var i = 0; i < length; i++) {
        if (elements[i].id.indexOf("owned") != -1) {
            if (Собственность == 'Личная') {
                spaceHide(elements[i]);
            } else {
                spaceShow(elements[i]);
            }
        }
    }
}

function apartment_add_room() {
    var inc = inviteObjectLevel1('apartment_new_room',
        'apartment_container_for_rooms', 'НЕДВИЖИМОСТЬ.КОМНАТА');

    if (get('ДАННЫЕ.НЕДВИЖИМОСТЬ.СОБСТВЕННОСТЬ') == 'ДОЛЕВАЯ') {
        spaceShow("apartment_owned" + inc);
    }
    var select = $("apartment_loggia" + inc);
    select.addEventListener("change", Если_Изменился_Тип_Окна);
}

function Если_Изменился_Тип_Окна() {
    if (this.value == "НИЧЕГО") {
        spaceHide($("apartment_window_label" + inc));
        spaceHide($("apartment_side_label" + inc));
    } else {
        spaceShow($("apartment_window_label" + inc));
        spaceShow($("apartment_side_label" + inc));
    }
};

/**
 *  ДОМ
 */
/* Кнопка ОК в "Дом, Часть дома" */
function house_button_ok() {
    spaceHide("property");
    spaceShow("main-menu");
    checked($("menu-type-realestate"));
    mainMenuNextFocus();

    var s = "";
    if (get('ДАННЫЕ.НЕДВИЖИМОСТЬ.СОБСТВЕННОСТЬ') == 'ДОЛЕВАЯ') {
        s = ИМУЩЕСТВО[ЛОКАЛИЗАЦИЯ].ЧАСТЬ_ДОМА;
        s += ', ' + ТЕКСТ[ЛОКАЛИЗАЦИЯ].КОМНАТ + ' '
            + $("Комнат-для-сделки").value;
    } else {
        s = ИМУЩЕСТВО[ЛОКАЛИЗАЦИЯ].ДОМ;
    }
    $("menu-type-realestate").innerHTML = s;
}

window.addEventListener("load", function () {

    $("house_button_ok").addEventListener("click", house_button_ok);

    $("Собственность-личная").addEventListener('click', function () {
        Если_Изменена_Собственность('house_container_rooms');
    });
    $("Собственность-долевая").addEventListener('click', function () {
        Если_Изменена_Собственность('house_container_rooms', 'Долевая');
    });

    $("house_addroom").addEventListener("click", house_addroom);
});

function house_addroom() {
    var inc = inviteObjectLevel1($("house_new_room"),
        $("house_container_rooms"),
        "НЕДВИЖИМОСТЬ.КОМНАТА");

    if (get('ДАННЫЕ.НЕДВИЖИМОСТЬ.СОБСТВЕННОСТЬ') == 'ДОЛЕВАЯ') {
        spaceShow('house_owned' + inc);
    }

    var select = $("house_loggia" + inc);

    select.myOnChange = function () {
        if (this.value == "НИЧЕГО") {
            spaceHide($("house_window_label" + inc));
            spaceHide($("house_side_label" + inc));
        } else {
            spaceShow($("house_window_label" + inc));
            spaceShow($("house_side_label" + inc));
        }
    };

    select.addEventListener("change", select.myOnChange);
}

/**
 * ЗЕМЕЛЬНЫЙ УЧАСТОК
 */
/* Обработка нажатия кнопки ОК в форме-данных "Земельный участок" */
function parcel_button_ok() {
    spaceHide($("property"));
    spaceShow($("main-menu"));
    var menu = $("menu-type-realestate");
    checked(menu);
    mainMenuNextFocus();
    menu.innerText = $("property_parcel").innerText;
}

var hozpostr = [
    "Баня",
    "Гараж",
    "Летняя кухня",
    "Беседка",
    "Парник",
    "Теплица",
    "Колодец",
    "Скважина",
    "Садовая мебель"
];

var plants = [
    "Малина",
    "Крыжовник",
    "Смородина",
    "Рябина",
    "Грецкий орех",
    "Яблоня",
    "Груша",
    "Мандарин",
    "Абрикос",
    "Лимон",
    "Апельсин",
    "Вишня"];

window.addEventListener("load", function () {

    $("parcel_button_ok").addEventListener("click", parcel_button_ok);

    $("parcel_paseka_checkbox").addEventListener("click", function () {
        spaceSwitch($('parcel_space_paseka'));
    });

    $("parcel_in_garden_checkbox").addEventListener("click", function () {
        spaceSwitch($('parcel_in_garden'));
    });

    $("parcel_button_add_hoz").addEventListener("click", function () {
        inviteObjectLevel1($("parcel_new_hoz"),
            $("parcel_container_hoz"),
            "НЕДВИЖИМОСТЬ.ХОЗПОСТРОЙКИ");
    });

    $("parcel_add_plant_button").addEventListener("click", function () {
        inviteObjectLevel1($("parcel_new_plant"),
            $("parcel_container_plants"),
            "НЕДВИЖИМОСТЬ.РАСТЕНИЯ");
    });
});

/**
 * ГАРАЖ
 */
/* Обработка нажатия кнопки ОК в форме-данных "Гараж, Машиноместо" */
function garage_button_ok() {
    spaceHide($("property"));
    spaceShow($("main-menu"));
    var menu = $("menu-type-realestate");
    checked(menu);
    mainMenuNextFocus();

    if (ДАННЫЕ.НЕДВИЖИМОСТЬ.СТОЯНКА == 'МАШИНОМЕСТО') {
        menu.innerText = $("garage_mesto").innerText;
    } else {
        menu.innerText = $("garage_garage").innerText;
    }
}

window.addEventListener("load", function () {
    $("garage_garage").addEventListener("click", function () {
        spaceShow($("garage_garage_expander"));
        spaceShow($("garagedj9283j"));
        spaceHide($("garage_mesto_expander"));
    });
    $("garage_mesto").addEventListener("click", function () {
        spaceHide($("garage_garage_expander"));
        spaceHide($("garagedj9283j"));
        spaceShow($("garage_mesto_expander"));
    });

    $("garage_button_ok").addEventListener("click", garage_button_ok);
});
/**
 * ПОМЕЩЕНИЕ
 */

/* Обработка нажатия кнопки ОК в форме-данных "Помещение, Склад, Офис" */
function room_button_ok() {
    spaceHide($("property"));
    spaceShow($("main-menu"));
    mainMenuNextFocus();

    if (!get('ДАННЫЕ.НЕДВИЖИМОСТЬ.ТИП_ПОМЕЩЕНИЯ')) {
        return;
    }

    var menu = $("menu-type-realestate");
    checked(menu);
    mainMenuNextFocus();

    var s = "";

    var elements = $("room").getElementsByTagName("button");
    var length = elements.length;
    for (var i = 0; i < length; i++) {
        if (elements[i].name == "ТИП_ПОМЕЩЕНИЯ" && elements[i].value == ДАННЫЕ.НЕДВИЖИМОСТЬ.ТИП_ПОМЕЩЕНИЯ) {
            s = elements[i].innerText;
            break;
        }
    }
    menu.innerText = s;
}

window.addEventListener("load", function () {
    $("room_add_room_button").addEventListener("click", function () {
        inviteObjectLevel1($("room_new_more"),
            $("room_container_add_room"),
            "НЕДВИЖИМОСТЬ.КОМНАТА");
    });

    $("room_button_ok").addEventListener("click", room_button_ok);
});

/**
 * ГОСТИНИЦА
 */
/* Обработка нажатия кнопки ОК в форме-данных "Отель" */
function hotel_button_ok() {
    spaceHide($("property"));
    spaceShow($("main-menu"));
    var menu = $("menu-type-realestate");
    menu.innerText = $("property_hotel").innerText;
    checked(menu);
    mainMenuNextFocus();
}

window.addEventListener("load", function () {
    $("hotel_add_dop_button").addEventListener("click", function () {
        inviteObjectLevel1($("hotel_add_more_room"),
            $("hotel_container_dop_room"),
            "НЕДВИЖИМОСТЬ.КОМНАТА");
    });

    $("hotel_button_ok").addEventListener("click", hotel_button_ok);
});

/**
 * ДРУГОЕ
 */
window.addEventListener("load", function () {

    $("other_button_add_building_new").addEventListener("click", other_button_add_building_new);

    $("other_button_ok").addEventListener("click", other_button_ok);

});

function other_button_add_building_new() {
    var inc = inviteObjectLevel1($("other_new_main_building"),
        $("other-main-container"),
        "НЕДВИЖИМОСТЬ.ЗДАНИЕ");

    $("other-button-add-room" + inc).addEventListener("click", function () {
        inviteObjectLevel2($("other_new_room_element"),
            $("other-room-container" + inc), inc, "НЕДВИЖИМОСТЬ.ЗДАНИЕ", "КОМНАТА");
    });
}

function other_button_ok() {
    hide('property_button_menu_right');
    spaceHide($("other"));
    spaceHide($("property"));
    spaceShow($("main-menu"));
    var menu = $("menu-type-realestate");
    checked(menu);
    mainMenuNextFocus();
    menu.innerText = "Другое";
}