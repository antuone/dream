var ДАННЫЕ = {};

function initializePrivate() {
    var ID_USER = getCookie('ID');
    var HASH_USER = getCookie('HASH');
    if (ID_USER && HASH_USER) {
        var request = new XMLHttpRequest();
        request.open("POST", 'php/private/security.php', true);
        request.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        request.setRequestHeader('Accept', 'application/json');
        request.send();
        request.onreadystatechange = function () {
            if (this.status == 200 && this.readyState === XMLHttpRequest.DONE) {
                if (request.responseText !== 0) {
                    entry(JSON.parse(request.responseText));
                }
            }
        };
    }
}

function entry(_DATA) {
    if (_DATA) {
        ДАННЫЕ = _DATA;
        spaceHide($("authentication"));
        spaceShow($("private"));

        $("private_email").innerText = ДАННЫЕ.EMAIL;

        if (ДАННЫЕ.CONFIRMED === 0) {
            spaceShow($("private_confirm_email"));
        }

        realestate_fill();
    }
}

function onClickReloadRealestate() {
    РЕЖИМ = 'EDIT';

    $('main_menu_button_send').onclick = realestateEdit;

    if (ИДЕНТИФИКАТОР = $_GET('id')) {
        reload(ИДЕНТИФИКАТОР);
    } else if (ИДЕНТИФИКАТОР = this.id) {
        reload(ИДЕНТИФИКАТОР);
    } else {
        return false;
    }

    function reload(ИДЕНТИФИКАТОР) {
        if ($('reload') === null) {
            var script2 = document.createElement("script");
            script2.src = "/js/reload.js";
            script2.id = "reload";
            script2.async = true;
            script2.defer = true;
            document.getElementsByTagName("head")[0].appendChild(script2);
            script2.addEventListener('load', function () {
                initialize_reload(ИДЕНТИФИКАТОР);
            });
        } else {
            initialize_reload(ИДЕНТИФИКАТОР);
        }
    }

    spaceSwitch('main-menu', ТЕКСТ[ЛОКАЛИЗАЦИЯ].РЕДАКТИРОВАТЬ_НЕДВИЖИМОСТЬ, 'private_office');

}

/* растусовывание недвижимости по нужным контейнерам */
function realestate_fill() {

    var containerSale = $('manager_container_re_sale');
    var containerBuy = $('manager_container_re_buy');
    var containerChange = $('manager_container_re_change');
    var containerRentPay = $('manager_container_re_rent_pay');
    var containerRentTake = $('manager_container_re_rent_take');
    var container = $('manager_realestates_container');

    function clearContainer(container) {
        var el = container.firstElementChild;
        container.innerHTML = '';
        container.appendChild(el);
    }

    clearContainer(containerSale)
    clearContainer(containerBuy);
    clearContainer(containerChange);
    clearContainer(containerRentPay);
    clearContainer(containerRentTake);
    clearContainer(container);

    if (ДАННЫЕ.НЕДВИЖИМОСТЬ)
        for (var i = 0; i < Object.keys(ДАННЫЕ.НЕДВИЖИМОСТЬ).length; i++) {

            var НЕДВИЖИМОСТЬ = ДАННЫЕ.НЕДВИЖИМОСТЬ[i];
            var a = document.createElement('button');

            if (НЕДВИЖИМОСТЬ.ИМУЩЕСТВО) {
                a.innerHTML = ИМУЩЕСТВО[LANGUAGE][НЕДВИЖИМОСТЬ.ИМУЩЕСТВО] + ' ' + НЕДВИЖИМОСТЬ.SPACETOTAL + ' m<sup class="sup">2</sup>';
            } else {
                a.innerText = '?';
            }
            a.className = 'a_button';
            a.addEventListener('click', onClickReloadRealestate);
            a.id = НЕДВИЖИМОСТЬ.ИДЕНТИФИКАТОР;

            switch (НЕДВИЖИМОСТЬ.DEAL) {
                case 'SELL':
                    containerSale.appendChild(a);
                    spaceShow(containerSale);
                    break;
                case 'BUY':
                    containerBuy.appendChild(a);
                    spaceShow(containerBuy);
                    break;
                case 'EXCHANGE':
                    containerChange.appendChild(a);
                    spaceShow(containerChange);
                    break;
                case 'SELLRENT':
                    containerRentPay.appendChild(a);
                    spaceShow(containerRentPay);
                    break;
                case 'BUYRENT':
                    containerRentTake.appendChild(a);
                    spaceShow(containerRentTake);
                    break;
                default:
                    container.appendChild(a);
                    spaceShow(container);
            }
        }
}

window.addEventListener("load", function () {
    initialize(private_office, '');
    ДАННЫЕ.АУТЕНТИФИКАЦИЯ = 1;

    initializePrivate();



    // if ($_GET("manager") == "open") {
    //     spaceHide("private");
    //     spaceShow("manager");        
    // }



    $("private_button_confirm_email").addEventListener("click", function () {
        spaceHide($("private"));
        spaceShow($("email_confirm"));

        $("email_message").innerText = $("email_message").innerText.replace("?", USER.EMAIL);

        var xhr1 = new XMLHttpRequest();
        xhr1.open('POST', 'php/confirm_email.php', true);
        xhr1.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        xhr1.onreadystatechange = function () {
            if (this.status == 200 && this.responseText) {
                console.log(this.responseText);
            }
        };
        xhr1.send();
    });

    $("email_confirm_button_back").addEventListener("click", function () {
        spaceHide($("email_confirm"));
        spaceShow($("private"));
    });

    $("private_exit").addEventListener("click", function () {
        deleteCookie("ID");
        deleteCookie("HASH");
        spaceHide($("private"));
        spaceShow($("authentication"));
    });

    // $('button_test1').addEventListener('click', function() {
    //     console.dir(ДАННЫЕ);
    // });

    // Send the data by pressing the "OK" button
    $("authentication_button_ok").addEventListener("click", function () {
        if (!ДАННЫЕ.АУТЕНТИФИКАЦИЯ) {
            return false;
        }

        var containerError = $("authentication_errors");
        var email = $("authentication_email").value;
        var password = $("authentication_password").value;
        var password2 = $("authentication_password2").value;



        /*
             Авторизация
        */
        if (ДАННЫЕ.АУТЕНТИФИКАЦИЯ == 1) {
            var xhr = new XMLHttpRequest();
            xhr.open('POST', 'php/private/login.php', true);
            xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
            xhr.setRequestHeader('Accept', 'application/json');
            xhr.onreadystatechange = readystatechange;
            xhr.send("password=" + password + "&email=" + email);
        }

        /*
            Регистрация
        */
        if (ДАННЫЕ.АУТЕНТИФИКАЦИЯ == 2) {
            if (password != password2) {
                spaceShow($("authentication_passwords_do_not_match"));
                return;
            }

            var xhr2 = new XMLHttpRequest();
            xhr2.open('POST', 'php/private/register.php', true);
            xhr2.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
            xhr2.setRequestHeader('Accept', 'application/json');
            xhr2.onreadystatechange = readystatechange;

            xhr2.send("password=" + password + "&email=" + email);
        }

        function readystatechange() {
            if (this.status == 200 && this.readyState === XMLHttpRequest.DONE) {

                var ДАННЫЕ = JSON.parse(this.responseText);


                if (ДАННЫЕ.ДОСТУП == "РАЗРЕШЕН") {
                    entry(ДАННЫЕ);
                    return;
                }

                containerError.innerHTML = "";
                var length = Object.keys(ДАННЫЕ).length;
                for (var i = 0; i < length; i++) {
                    containerError.appendChild(createDivError(ДАННЫЕ[i]));
                }
            }
        }
    });



    /*
        When you select a radio button "authorization" hide additional fields for registration
    */
    $("authentication_radio_authorization").addEventListener("click", function () {
        spaceHide($("authentication_registration"));
    });

    /*
        When you select a radio button "registration" show additional fields for registration
    */
    $("authentication_radio_registration").addEventListener("click", function () {
        spaceShow($("authentication_registration"));
    });

});