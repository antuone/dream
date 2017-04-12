/*Список регионов*/
SELECT name.name as 'Region', type.name as 'Type', region.code as 'Code' FROM region
INNER JOIN name ON region.id_name = name.id
INNER JOIN type ON region.id_type = type.id
ORDER BY name.name ASC

/*Города в Республике Адыгея*/
SELECT name.name FROM city
INNER JOIN name ON name.id = city.id_name
WHERE city.id_region = 1 ORDER BY name ASC


Вторичное жилье
Первичное жилье
Часть квартиры или дома
