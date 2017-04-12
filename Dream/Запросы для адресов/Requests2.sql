/*Заполнение населенных пунктов*/
INSERT INTO locality (id_name, id_type, id_region, id_district, id_city, id_city_district, code, id_global)
SELECT 
    name.id AS 'name.id',
    type.id AS 'type.id',
    region.id AS 'region.id',
    district.id AS 'district.id',
    city.id AS 'city.id',
    city_district.id AS 'city_district.id',
    PLACECODE,
    AOGUID
FROM
    (SELECT * FROM addrobj3 WHERE AOLEVEL = 6) AS `T`
        INNER JOIN
    name ON name.name = OFFNAME
        INNER JOIN
    type ON type.socr = SHORTNAME
        INNER JOIN
    region ON region.code = REGIONCODE
        LEFT JOIN
    district ON district.id_region = region.id
        AND district.code = AREACODE
        LEFT JOIN
    city ON city.id_region = region.id
        AND IFNULL(city.id_district, 0) = IFNULL(district.id, 0)
        AND city.code = CITYCODE
        LEFT JOIN
    city_district ON city_district.id_region = region.id
        AND IFNULL(city_district.id_city, 0) = IFNULL(city.id, 0)
        AND city_district.code = CTARCODE

CREATE TEMPORARY TABLE temp_table SELECT * FROM addrobj3 WHERE AOLEVEL = 7


SELECT COUNT(*) FROM addrobj3 WHERE aolevel=7 
969907


SELECT COUNT(*) FROM street
970008

/**11111111111111111111111111111111111111111111/

/*Заполнение улиц*/
INSERT INTO street (id_name, id_type, id_region, id_district, id_city, id_city_district, id_global)
SELECT 
    name.id AS 'name.id',
    type.id AS 'type.id',
    region.id AS 'region.id',
    district.id AS 'district.id',
    city.id AS 'city.id',
    city_district.id AS 'city_district.id',
/*    locality.id AS 'locality.id',*/
    AOGUID
FROM
    (SELECT * FROM addrobj3 WHERE AOLEVEL = 7) AS `T`
        INNER JOIN
    name ON name.name = OFFNAME
        INNER JOIN
    type ON type.socr = SHORTNAME
        INNER JOIN
    region ON region.code = REGIONCODE
        LEFT JOIN
    district ON district.id_region = region.id
        AND district.code = AREACODE
        LEFT JOIN
    city ON city.id_region = region.id
        AND IFNULL(city.id_district, 0) = IFNULL(district.id, 0)
        AND city.code = CITYCODE
        LEFT JOIN
    city_district ON city_district.id_region = region.id
        AND IFNULL(city_district.id_city, 0) = IFNULL(city.id, 0)
        AND city_district.code = CTARCODE
/*		LEFT JOIN
	locality ON locality.id_region = region.id
		AND ifnull(locality.id_district,0) = ifnull(district.id,0)
        AND IFNULL(locality.id_city, 0) = IFNULL(city.id, 0)
        AND IFNULL(locality.id_city_district, 0) = IFNULL(city_district.id, 0)
        AND locality.code = PLACECODE*/

/*2222222222222222222*/
/* Заполнение улиц 2 */
SET SQL_SAFE_UPDATES=0;
UPDATE street
        LEFT JOIN
    locality ON locality.id_region = street.id_region
        AND IFNULL(locality.id_city, 0) = IFNULL(street.id_city, 0)
        AND IFNULL(locality.id_city_district, 0) = IFNULL(street.id_city_district, 0)
        AND IFNULL(locality.id_district, 0) = IFNULL(street.id_district, 0)
        AND locality.code = street.code_locality 
SET 
    street.id_locality = locality.id;

SET SQL_SAFE_UPDATES=1;
