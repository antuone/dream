<?php
$APARTMENTINTEGRITY = ['APARTMENT', 'PARTAPARTMENT'];
$APARTMENTSTATUS = ['APARTMENT', 'HOUSING'];
$APARTMENTTYPEHOUSE = ['PANEL', 'MONOLITHIC', 'MODULAR', 'BRICK'];
$APARTMENTHOUSING = ['SECONDARY', 'PRIMARY'];

//$ISFULLHOUSE = ['HOUSE', 'PARTHOUSE'];
$HOUSEHEATING = ['ПЕЧНОЕ', 'ГАЗОВОЕ', 'ВОДЯНОЕ', 'ЭЛЕКТРИЧЕСКОЕ'];

$DEAL = ['SELL', 'BUY', 'EXCHANGE', 'SELLRENT', 'BUYRENT'];
$PROPERTY2 = ['APARTMENT', 'HOUSE', 'PARCEL', 'GARAGE', 'ROOM', 'HOTEL', 'OTHER'];
$CURRENCY = ['₽', '$', '€', '¥'];

$NAME = ['Хорошая недвижимость',
		 'Крутая недвижимость',
		 'Офегенная недвижимость',
		 'Продам быстро',
		 'Недвижимость у берега моря',
		 'Купите недвижимость',
		 'Умная недвижимость',
		 'Солнечная недвижимость',
		 'Купите рай',
		 'Вы не пожалеете'];

$MOREINFO = ['Чувствую, что вам сейчас всякие CURL начнут советовать. Не слушайте их. ',
			 'Можно отправить POST-запрос используя контексты потоковых операций PHP. На хабре есть статья на эту тему. ',
			 'Через Jquery отправь и потом на PHP return сделай если надо',
			 'Какой-то народ неадекватный пошел, наверно, новый дизайн так влияет...',
			 'Не могу понять в чем проблема. Почему JSON прерывается, прошу вашей помощи, спасибо ',
			 'Смотрите что возвращает вам ваш ajax - отсюда и плящите. Посмотреть можно выводя через console.log или во вкладке Network отладчика. Может у вас ошибка 500 например ...',
			 'Подгружаю через AJAX данные в JSON, который отдает PHP. В JSONе где-то 30-40 объектов, их надо кэшировать. Возник вопрос, где лучше, в самом .js скрипте, или же рядом с php скриптом генерировать .txt и потом сравнивать?',
			 'Если данные, которые нужно кэшировать одни для 100-500-1000 юзеров, т.е. твой PHP скрипт отработал, получил результат и он должен отдаваться N раз, тогда смотри в сторону серверного кэша(файлы, redis/mem_cached). Если генерируемая пара уникальна для каждого юзера, см. ответ DevMan',
			 'Водосчетчики. Теплосчетчики. Энергосчетчики. В сторону какого протокола и сервера сбора данных смотреть?',
			 'Чтоб все это буйство работало вместе и централизованно собирало данные. Может кто подскажет производителя все этого разом. Чтоб не плодить зоопарк. Вебморда у сервера обязательно. Как и сетевой интерфейс у "мозгов"',
			 'Готового варианта, который не будет стоить как новая квартира сейчас нет. Тут или собирать от разных фирм или колхозить самому. Как вариант можно заказать у местных кулибиных. ',
			 'Сертифицированный газовый счетчик с com портом начинается от 40к
сертифицированный водосчетчик с интегрированным беспроводным интерфейсом от 25к + спец приемник 10к
энергосчетчик примерно 5к',
			 'К этому всему еще нужны приемопередачики и центральный сервер. Серверов с GUI сейчас достаточно много, главное подогнать данные под нужный формат ',
			 'Что лучше использовать dependency injection или autofac в ASP.NET Core?',
			 'Кто уже использовал IoC в ASP.NET Core? Всегда использовал autofac, сейчас столкнулся в тем, что по умолчанию уже есть dependency injection в проекте asp.net core. Стоит его использовать или лучше выпилить? ',
			 'Как видно NamedParameter и TypedParameter не позволяют этого сделать, или позволяют? Но как?',
			 'Сегодня в itunesconnect увидел предупреждение о неточности внесения финансовых данных. В Banking information появилось поле UNN. Подсказка (введите девятизначный номер учетной записи). Какой именно учетной записи? УНН банка? ',
			 'Имеется закрытое приложение, после запуска требуется авторизация так же можно зарегистрироваться через приложение. Можно ли используя стандартный share внутри приложения дать "реферальную ссылку" что бы человек скачавший приложение через AppStore зарегистрировшись внутри него стал рефералом того кто дал ссылку? Какие варианты есть для этого? GET или какая магия? ',
			 'Через AppStore никак не отследить. Но есть варианты достаточно сложные для юзера.
1. Давать уникальный код тому кто делится, и при пером запуске приложения спрашивать "У вас есть код приглашения?" чтобы этим пользовались нужно давать какой-то бонус(и тому кто приглашает и тому кто вводит код)
2. Отправлять приглашение через соц. сети, например vk.com/id1 пригласил vk.com/id500, тогда если в приложение войдет vk.com/id500 через соц. сеть считать его рефом id1, тут конечно может быть такое, что человек наспамил всему контакт-листу, и кто-то и так потом поставил приложение, а его запишешь рефом.',
			 ' Где найти(программу или сервис) для расчета теплопотерь квартиры?
Хочу посчитать сколько затрачивается на обогрев. И не просто посчитать, но и взять наружную температуру по городу (вопрос только с какого сервиса и в каком формате данных???) и сделать расчет за год(не с потолка!!!! и с точным температурным графиком). Может кто в теме? ',
			 'У вас наверняка есть карта теплопроводности наружных стен вашего дома, стыков плит и окон (с открытыми форточками и без)?
Правильный способ - ставить теплосчётчики на вход теплоносителя в квартиру(дом), и на выход. Разница показаний - и есть затраты на обогрев. Не с потолка и с точным графиком )))
Всё остальное - как раз с потолка. '];

$NAMEROOM = ['Спальня','Гостиная','Кухня','Прачечная','Бильярдная','Ванная','Санузел',
			 'Кабинет','Столовая','Раздевалка','Коридор','Балкон','Кладовка','Гардеробная'];

$ALLOWEDUSER = [
'EMAIL'=>'s',
'PASSWORD'=>'s',
'HASH'=>'s',
'IP'=>'i',
'CONFIRMED'=>'s',
'QUANTITY'=>'i'];

$LOGGIA = ['WINDOW', 'LOGGIA', 'BALCONY', 'NOTHING'];
$VID = ['Горы','Двор','Река','Лес','Деревня','Город'];

$WINDOWSIDE = ['SOUTH', 'WEST', 'EAST', 'NORTH', 'SOUTHEAST', 'SOUTHWEST', 'NORTHEAST', 'NORTHWEST'];

$FOUNDATION = ['ЛЕНТОЧНЫЙ', 'СТОЛБЧАТЫЙ', 'ПЛИТНЫЙ', 'КОНТИНУАЛЬНЫЙ'];

$PLANT = ['Малина','Тыква','Вишня','Огурцы','Теплица','Картошка','Брусника','Крыжовник','Яблоки','Груша','Помидор','Виктория'];

$HOZPOSTR = [
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

$TYPEOFPARKING = ['КРЫТАЯСТОЯНКА', 'ПОДЗЕМНЫЙПАРКИНГ', 'МНОГОУРОВНЕВЫЙПАРКИНГ', 'ОТКРЫТАЯСТОЯНКА'];
$TYPEGARAGE = ['ЖЕЛЕЗОБЕТОННЫЙ', 'МЕТАЛЛИЧЕСКИЙ', 'КИРПИЧНЫЙ'];

$COMPLEXNAME = ['Московский','Высоцкий','Подземный','Парковый','Надежный'];

$ROOMTYPEROOM = ['ОФИСНОЕ', 'ТОРГОВОЕ', 'СКЛАДСКОЕ', 'СВОБОДНОГОНАЗНАЧЕНИЯ', 'САЛОНКРАСОТЫ', 'ПРОИЗВОДСТВЕННОГОНАЗНАЧЕНИЯ', 'ОБЩЕСТВЕННОГОПИТАНИЯ'];

$TYPEBUILDING = ['ПАНЕЛЬНОЕ', 'МОНОЛИТНОЕ', 'БЛОЧНОЕ', 'КИРПИЧНОЕ'];
?>