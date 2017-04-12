SELECT REGIONCODE, AREACODE FROM `addrobj` WHERE ACTSTATUS=1 AND AOLEVEL=3 AND REGIONCODE=59 GROUP BY AREACODE

SELECT OFFNAME, REGIONCODE, AREACODE, CITYCODE FROM `addrobj` WHERE ACTSTATUS=1 AND AOLEVEL=4 AND REGIONCODE='59' AND AREACODE='027'

SELECT OFFNAME, REGIONCODE, AREACODE, CITYCODE FROM `addrobj` WHERE ACTSTATUS=1 AND AOLEVEL=6 AND REGIONCODE='59' AND AREACODE='005' ORDER BY `addrobj`.`OFFNAME` ASC 


/*Заполнение регион*/
INSERT INTO region (id_name, code, id_type, id_global)
SELECT (SELECT id from name where OFFNAME=name),
	REGIONCODE,
        (SELECT id FROM type WHERE SHORTNAME=socr),
        AOGUID
FROM `addrobj` WHERE ACTSTATUS=1 AND AOLEVEL=1

UPDATE `region` SET `id_name` = '29041' WHERE `region`.`id` = 21;
UPDATE `region` SET `id_type` = '7' WHERE `region`.`id` = 21;

/*Заполнение дистрикт*/
INSERT INTO district (id_name, id_type, id_region, code, id_global)
SELECT
	(SELECT id from name where OFFNAME=name),
	(SELECT id FROM type WHERE SHORTNAME=socr),
	(SELECT id FROM region WHERE region.code=REGIONCODE),
	AREACODE,
	AOGUID
FROM `addrobj` WHERE ACTSTATUS=1 AND AOLEVEL=3



/*Заполнение goroda*/
INSERT INTO city (id_name, id_type, id_region, code, id_global, id_district)
SELECT
	(SELECT id from name where OFFNAME=name),
	(SELECT id FROM type WHERE SHORTNAME=socr),
	(SELECT id FROM region WHERE region.code=REGIONCODE),
	AREACODE,
	AOGUID,
	(SELECT id FROM district WHERE district.code=AREACODE AND (SELECT code FROM region WHERE
                                                               district.id_region=region.id)=REGIONCODE)
FROM `addrobj` WHERE ACTSTATUS=1 AND AOLEVEL=4


/*goroda v regione 59 ne prinadlejashih rayonam*/
SELECT name.name
FROM city
INNER JOIN region ON city.id_region=region.id
INNER JOIN name ON city.id_name=name.id
WHERE region.code=59 AND city.id_district IS NULL


SELECT name.name, (select name from name where name.id=city.id_district) as `Район`
FROM city
INNER JOIN region ON city.id_region=region.id
INNER JOIN name ON city.id_name=name.id
WHERE region.code=59 AND city.id_district IS NOT NULL


SELECT OFFNAME,REGIONCODE, AREACODE, CITYCODE, CTARCODE
FROM `addrobj` WHERE ACTSTATUS=1 AND AOLEVEL=5 and CITYCODE='000'  




/*Заполнение городских районов*/
INSERT INTO city_district (id_name, id_type, id_region, id_city, id_global)
SELECT
	(SELECT id from name where OFFNAME=name),
	(SELECT id FROM type WHERE SHORTNAME=socr),
	(SELECT id FROM region WHERE region.code=REGIONCODE),
    (SELECT id FROM city WHERE 
    						(select code from region WHERE region.id=city.id_region)=REGIONCODE AND
     						(select name from name where name.id = city.id )=
     						(select OFFNAME from addrobj where ACTSTATUS=1 and 
                             									AOLEVEL=4 and REGIONCODE=`t`.REGIONCODE AND
                            									CITYCODE=`t`.CITYCODE AND AREACODE=`t`.AREACODE
                            									and CTARCODE=`t`.CTARCODE)
    ),
	AOGUID
FROM `addrobj` as `t` WHERE ACTSTATUS=1 AND AOLEVEL=4


/*Заполнение городских районов*/
INSERT INTO city_district (id_name, id_type, id_region, id_city, id_global)
SELECT
	(SELECT id from name where OFFNAME=name),
	(SELECT id FROM type WHERE SHORTNAME=socr),
	(SELECT id FROM region WHERE region.code=REGIONCODE),
    (SELECT id FROM city WHERE 
    						(select code from region WHERE region.id=city.id_region)=REGIONCODE AND
							city.code=CITYCODE
    ),
	AOGUID
FROM `addrobj` as `t` WHERE ACTSTATUS=1 AND AOLEVEL=4




/*Заполнение городских районов*/
INSERT INTO city_district (id_name, id_type, id_region, id_city, id_global)
SELECT
	(SELECT id from name where OFFNAME=name),
	(SELECT id FROM type WHERE SHORTNAME=socr),
	(SELECT id FROM region WHERE region.code=REGIONCODE),
    (SELECT city.id FROM city
     			LEFT JOIN district on city.id_district=district.id
                LEFT JOIN region on city.id_region=region.id
     			WHERE region.code=REGIONCODE AND district.code = AREACODE AND city.code=CITYCODE 
    ),
	AOGUID
FROM `addrobj` WHERE ACTSTATUS=1 AND AOLEVEL=4


select REGIONCODE, AREACODE, CITYCODE, CTARCODE
from addrobj
where ACTSTATUS=1 and AOLEVEL=5
group by REGIONCODE, AREACODE, CITYCODE, CTARCODE having count(*)>1


/*Заполнение городских районов*/
INSERT INTO city_district (id_name, id_type, id_region, id_city, id_global)
SELECT
	(SELECT id from name where OFFNAME=name),
	(SELECT id FROM type WHERE SHORTNAME=socr),
	(SELECT id FROM region WHERE region.code=REGIONCODE),
    (SELECT city.id FROM city as `t`
     			LEFT JOIN district on city.id_district=district.id
                LEFT JOIN region on city.id_region=region.id
     			left JOIN addrobj ON city.id_global = AOGUID
     			WHERE region.code=REGIONCODE AND district.code = AREACODE AND city.code=CITYCODE
     			and CTARCODE = `t`.CTARCODE
    ),
	AOGUID
FROM `addrobj` WHERE ACTSTATUS=1 AND AOLEVEL=4




/*Заполнение городских районов*/
INSERT INTO city_district (id_name, id_type, id_region, id_city, id_global)
SELECT
	(SELECT id from name where OFFNAME=name),
	(SELECT id FROM type WHERE SHORTNAME=socr),
	(SELECT id FROM region WHERE region.code=REGIONCODE),
    (SELECT city.id FROM city
     			LEFT JOIN district on city.id_district=district.id
                LEFT JOIN region on city.id_region=region.id
     			left JOIN addrobj ON city.id_global = AOGUID
     			WHERE region.code=REGIONCODE AND district.code = AREACODE AND city.code=CITYCODE
     			and city.CTARCODE = CTARCODE
    ),
	AOGUID
FROM `addrobj` WHERE ACTSTATUS=1 AND AOLEVEL=4





/*Заполнение городских районов*/
INSERT INTO city_district (id_name, id_type, id_region, id_city, id_global)
SELECT
	(SELECT id from name where OFFNAME=name),
	(SELECT id FROM type WHERE SHORTNAME=socr),
	(SELECT id FROM region WHERE region.code=REGIONCODE),
    (SELECT id FROM city
     			left JOIN addrobj ON city.id_global = AOGUID
     			WHERE `t`.REGIONCODE=REGIONCODE AND `t`.AREACODE=AREACODE AND `t`.CITYCODE=CITYCODE
     			AND `t`.CTARCODE = CTARCODE
    ),
	AOGUID
FROM `addrobj` as `t` WHERE ACTSTATUS=1 AND AOLEVEL=5


SELECT
	name.id,
	type.id,
	region.id,
	city.id,
	AOGUID
FROM addrobj
LEFT JOIN name ON OFFNAME=name.name
LEFT JOIN type ON SHORTNAME=socr 
LEFT JOIN region ON region.code=REGIONCODE
LEFT JOIN city ON city.id_global = addrobj.AOGUID
WHERE ACTSTATUS=1 AND AOLEVEL=5



SELECT
    (SELECT id FROM city
     			left JOIN addrobj ON city.id_global = AOGUID
     			WHERE `t`.REGIONCODE=REGIONCODE AND `t`.AREACODE=AREACODE AND `t`.CITYCODE=CITYCODE
     			AND `t`.CTARCODE = CTARCODE
    )
FROM `addrobj` as `t` WHERE ACTSTATUS=1 AND AOLEVEL=5



DELETE FROM addrobj WHERE ACTSTATUS=0 
Затронуто 1556943 строки. (Запрос занял 33.1554 сек.)



SELECT
    (SELECT id FROM city
     			left JOIN addrobj ON city.id_global = AOGUID
     			WHERE `t`.REGIONCODE=REGIONCODE AND `t`.AREACODE=AREACODE AND `t`.CITYCODE=CITYCODE AND AOLEVEL=4
    ) as `id городов`
FROM `addrobj` as `t` WHERE AOLEVEL=5 LIMIT 0,100




SELECT
    (SELECT id FROM city
     LEFT JOIN addrobj ON city.id_global = AOGUID
     WHERE `t`.REGIONCODE=REGIONCODE AND `t`.AREACODE=AREACODE AND `t`.CITYCODE=CITYCODE AND AOLEVEL=4) AS `city.id`,
	name.id as 'name.id',
	type.id as 'type.id',
	region.id as 'region.id',
	AOGUID
FROM `addrobj` as `t`
LEFT JOIN name ON OFFNAME=name.name
LEFT JOIN type ON SHORTNAME=socr 
LEFT JOIN region ON region.code=REGIONCODE
LEFT JOIN city ON city.id_global = `t`.AOGUID
WHERE AOLEVEL=5 LIMIT 0,100


/*Заполнение городских районов*/
INSERT INTO city_district (id_city, id_name, id_type, id_region, id_global)
SELECT
    (SELECT id FROM city
     LEFT JOIN addrobj ON city.id_global = AOGUID
     WHERE `t`.REGIONCODE=REGIONCODE AND `t`.AREACODE=AREACODE AND `t`.CITYCODE=CITYCODE AND AOLEVEL=4) AS `city.id`,
	name.id as 'name.id',
	type.id as 'type.id',
	region.id as 'region.id',
	AOGUID
FROM `addrobj` as `t`
LEFT JOIN name ON OFFNAME=name.name
LEFT JOIN type ON SHORTNAME=socr 
LEFT JOIN region ON region.code=REGIONCODE
LEFT JOIN city ON city.id_global = `t`.AOGUID
WHERE AOLEVEL=5

Добавлено 87 строк.
Идентификатор вставленной строки: 87 (Запрос занял 57.8201 сек.)


INSERT INTO city_district (id_city, id_name, id_type, id_region, id_global, code)
SELECT
    (SELECT id FROM city
     LEFT JOIN addrobj ON city.id_global = AOGUID
     WHERE `t`.REGIONCODE=REGIONCODE AND `t`.AREACODE=AREACODE AND `t`.CITYCODE=CITYCODE AND AOLEVEL=4) AS `city.id`,
	name.id as 'name.id',
	type.id as 'type.id',
	region.id as 'region.id',
	AOGUID,
    CTARCODE
FROM `addrobj` as `t`
LEFT JOIN name ON OFFNAME=name.name
LEFT JOIN type ON SHORTNAME=socr 
LEFT JOIN region ON region.code=REGIONCODE
LEFT JOIN city ON city.id_global = `t`.AOGUID
WHERE AOLEVEL=5
 Добавлено 87 строк.
Идентификатор вставленной строки: 87 (Запрос занял 57.7010 сек.)





SELECT * FROM `addrobj` WHERE AOLEVEL=6 
Отображение строк 0 - 24 (188952 всего, Запрос занял 0.0012 сек.)

SELECT * FROM `addrobj` WHERE AOLEVEL=6 AND CTARCODE='000' 
Отображение строк 0 - 24 (188796 всего, Запрос занял 0.0012 сек.)

SELECT * FROM `addrobj` WHERE AOLEVEL=6 AND CTARCODE='000' AND CITYCODE='000'
Отображение строк 0 - 24 (171951 всего, Запрос занял 0.0012 сек.)

SELECT * FROM `addrobj` WHERE AOLEVEL=6 AND CITYCODE='000' 
Отображение строк 0 - 24 (171951 всего, Запрос занял 0.0011 сек.)






SELECT
    (SELECT id FROM city
     LEFT JOIN addrobj ON city.id_global = AOGUID
     WHERE `t`.REGIONCODE=REGIONCODE AND `t`.AREACODE=AREACODE AND `t`.CITYCODE=CITYCODE
     		AND `t`.CTARCODE=CTARCODE AND `t`.PLACECODE=PLACECODE  AND AOLEVEL=4) AS `city.id`,
	name.id as 'name.id',
	type.id as 'type.id',
	region.id as 'region.id',
    district.id as 'district.id',
    city_district.id as 'city_district.id',
	AOGUID,
    CTARCODE
FROM `addrobj` as `t`
LEFT JOIN name ON OFFNAME=name.name
LEFT JOIN type ON SHORTNAME=socr 
LEFT JOIN region ON region.code=REGIONCODE
LEFT JOIN city ON city.id_global = `t`.AOGUID
LEFT JOIN district ON district.id_global = `t`.AOGUID
LEFT JOIN city_district ON city_district.id_global = `t`.AOGUID
WHERE AOLEVEL=6








SELECT
    (SELECT id FROM city
     LEFT JOIN addrobj ON city.id_global = AOGUID
     WHERE `t`.REGIONCODE=REGIONCODE AND `t`.AREACODE=AREACODE AND `t`.CITYCODE=CITYCODE
     		AND `t`.CTARCODE=CTARCODE AND `t`.PLACECODE=PLACECODE  AND AOLEVEL=4) AS `city.id`,
	name.id as 'name.id',
	type.id as 'type.id',
	region.id as 'region.id',
    district.id as 'district.id',
    city_district.id as 'city_district.id',
	AOGUID,
    CTARCODE
FROM `addrobj` as `t`
LEFT JOIN name ON OFFNAME=name.name
LEFT JOIN type ON SHORTNAME=socr 
LEFT JOIN region ON region.code=REGIONCODE
LEFT JOIN city ON city.id_global = `t`.AOGUID
LEFT JOIN district ON district.id_global = `t`.AOGUID
LEFT JOIN city_district ON city_district.id_global = `t`.AOGUID
WHERE AOLEVEL=6



SELECT
    (SELECT id FROM city
     LEFT JOIN addrobj ON city.id_global = AOGUID
     WHERE `t`.REGIONCODE=REGIONCODE AND `t`.AREACODE=AREACODE AND `t`.CITYCODE=CITYCODE
     		AND `t`.CTARCODE=CTARCODE AND `t`.PLACECODE=PLACECODE  AND AOLEVEL=4) AS `city.id`
FROM `addrobj` as `t`
WHERE AOLEVEL=6




SELECT
	city.id as 'city.id',
	name.id as 'name.id',
	type.id as 'type.id',
	region.id as 'region.id',
    district.id as 'district.id',
    city_district.id as 'city_district.id',
	AOGUID,
    CTARCODE
FROM `addrobj` as `t`
LEFT JOIN name ON OFFNAME=name.name
LEFT JOIN type ON SHORTNAME=socr 
LEFT JOIN region ON region.code=REGIONCODE
LEFT JOIN city ON city.id_global = `t`.AOGUID
LEFT JOIN district ON district.id_global = `t`.AOGUID
LEFT JOIN city_district ON city_district.id_global = `t`.AOGUID
WHERE AOLEVEL=6



SELECT
	name.id as 'name.id',
	type.id as 'type.id',
	region.id as 'region.id',
	AOGUID,
    CTARCODE
FROM addrobj
LEFT JOIN name ON name.name=OFFNAME
LEFT JOIN type ON type.socr=SHORTNAME
LEFT JOIN region ON region.code=REGIONCODE
WHERE AOLEVEL=6



SELECT
	city.id as 'city.id',
	name.id as 'name.id',
	type.id as 'type.id',
	region.id as 'region.id',
	AOGUID,
    CTARCODE
FROM addrobj
LEFT JOIN name ON name.name=OFFNAME
LEFT JOIN type ON type.socr=SHORTNAME
LEFT JOIN region ON region.code=REGIONCODE
LEFT JOIN city ON city.id_region = region.id and city.code = CITYCODE
WHERE AOLEVEL=6




SELECT 
    *
FROM
    addrobj
        LEFT JOIN
    region ON region.code = REGIONCODE
        LEFT JOIN
    district ON district.code = AREACODE
        LEFT JOIN
    city ON city.id_region = region.id
        AND city.code = CITYCODE
        AND citycode <> '000'
        AND city.id_district = district.id
WHERE
    AOLEVEL = 6




SELECT * FROM `addrobj` WHERE AOLEVEL=4 ORDER BY `addrobj`.`CITYCODE` ASC 
Отображение строк 0 - 24 (6326 всего, Запрос занял 3.0376 сек.) [CITYCODE: 001... - 001...]





/*Заполнение goroda*/
INSERT INTO city (id_name, id_type, id_region, code, id_global, id_district)
SELECT
	name.id as 'name.id',
	type.id as 'type.id',
	region.id as 'region.id',
	CITYCODE,
    AOGUID,
    district.id as 'district.id'
FROM addrobj
INNER JOIN name ON name.name=OFFNAME
INNER JOIN type ON type.socr=SHORTNAME
INNER JOIN region ON region.code=REGIONCODE
INNER JOIN district ON district.code = AREACODE and district.id_region=REGIONCODE
WHERE AOLEVEL=4


/*Заполнение goroda*/
SELECT
	name.id as 'name.id',
	type.id as 'type.id',
	region.id as 'region.id',
	CITYCODE,
    AOGUID,
    district.id as 'district.id'
FROM addrobj
INNER JOIN name ON name.name=OFFNAME
INNER JOIN type ON type.socr=SHORTNAME
INNER JOIN region ON region.code=REGIONCODE
INNER JOIN district ON district.code = AREACODE and district.id_region=region.id
WHERE AOLEVEL=4




/*Заполнение goroda*/
INSERT INTO city (id_name, id_type, id_region, code, id_global, id_district)
SELECT
	name.id as 'name.id',
	type.id as 'type.id',
	region.id as 'region.id',
	CITYCODE,
    AOGUID,
    district.id as 'district.id'
FROM addrobj
INNER JOIN name ON name.name=OFFNAME
INNER JOIN type ON type.socr=SHORTNAME
INNER JOIN region ON region.code=REGIONCODE
LEFT JOIN district ON district.code = AREACODE and district.id_region=region.id
WHERE AOLEVEL=4
6326 row(s) affected Records: 6326  Duplicates: 0  Warnings: 0



SELECT name.name
FROM city
INNER JOIN region ON city.id_region=region.id
INNER JOIN name ON city.id_name=name.id
WHERE region.code=59 AND city.id_district IS NULL
13 row(s) returned	0,0051 sec / 0,000034 sec


/*Заполнение городских районов*/
INSERT INTO city_district (id_city, id_name, id_type, id_region, id_global, code)
SELECT
	city.id as 'city.id',
	name.id as 'name.id',
	type.id as 'type.id',
	region.id as 'region.id',
	AOGUID,
    CTARCODE
FROM `addrobj` as `t`
INNER JOIN `name` ON `name`.`name`=OFFNAME
INNER JOIN `type` ON `type`.`socr`=SHORTNAME
INNER JOIN `region` ON `region`.`code`=REGIONCODE
LEFT JOIN district ON district.code=AREACODE and district.id_region=region.id
LEFT JOIN `city` ON `city`.code=CITYCODE and AOLEVEL=4 and district.code=AREACODE and region.code=REGIONCODE
WHERE AOLEVEL=5




/*Заполнение городских районов*/
INSERT INTO city_district (id_city, id_name, id_type, id_region, id_global, code)
SELECT 
	city.id as 'city.id',
	name.id as 'name.id',
	type.id as 'type.id',
	region.id as 'region.id',
	AOGUID,
    CTARCODE
FROM
    addrobj3
        INNER JOIN
    name ON name.name = OFFNAME
        INNER JOIN
    type ON type.socr = SHORTNAME
        INNER JOIN
    region ON region.code = REGIONCODE
        LEFT JOIN
    district ON district.code = AREACODE
        AND district.id_region = region.id
        LEFT JOIN
    city ON city.code = CITYCODE AND AOLEVEL = 5
        AND IFNULL((select code from district where district.id=city.id_district),0)=AREACODE
        AND city.id_region = region.id
WHERE
    AOLEVEL = 5

/*НУЖНО ИЗБАВИТСЯ от NULL в таблицах*/

/*Общее количество населенных пунктов*/
SELECT COUNT(*) FROM `addrobj3` WHERE AOLEVEL=6 
188952

/*Количество населенных пунктов не привязанных не к одному городскому району*/
SELECT COUNT(*) FROM `addrobj3` WHERE AOLEVEL=6 AND CTARCODE='000' 
188796

/*Непривязанных к гродам*/
SELECT COUNT(*) FROM `addrobj3` WHERE AOLEVEL=6 AND CITYCODE='000' 
171951

/*Непривязанных к районам*/
SELECT COUNT(*) FROM `addrobj3` WHERE AOLEVEL=6 AND AREACODE='000' 
9945

/*Количество населенных пунктов без кода*/
SELECT COUNT(*) FROM `addrobj3` WHERE AOLEVEL=6 AND PLACECODE='000' 
0


SELECT 
    city.id AS 'city.id',
    name.id AS 'name.id',
    type.id AS 'type.id',
    region.id AS 'region.id',
    AOGUID,
    CTARCODE,
    REGIONCODE,
    AREACODE,
    CITYCODE,
    CTARCODE
FROM
    addrobj3
        INNER JOIN
    name ON name.name = OFFNAME
        INNER JOIN
    type ON type.socr = SHORTNAME
        INNER JOIN
    region ON region.code = REGIONCODE
        LEFT JOIN
    district ON district.code = AREACODE
        AND district.id_region = region.id
        LEFT JOIN
    city ON city.code = CITYCODE
        AND IFNULL(city.id_district, 0) = IFNULL(district.id, 0)
        AND city.id_region = region.id
WHERE
    AOLEVEL = 5




/*Заполнение населенных пунктов*/
/*INSERT INTO locality (id_name, id_type, id_region, id_district, id_city, id_city_district, code, id_global)*/
SELECT 
    name.id AS 'name.id',
    type.id AS 'type.id',
    region.id AS 'region.id',
    district.id AS 'district.id',
    city.id AS 'city.id',
    city_district.id AS 'city_district.id',
    PLACECODE,
    AOGUID,
    REGIONCODE,
    AREACODE,
    CITYCODE,
    CTARCODE
FROM
    (SELECT 
        *
    FROM
        addrobj3
    WHERE
        AOLEVEL = 6) AS `T`
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
        AND AOLEVEL = 6
        LEFT JOIN
    city_district ON city_district.id_region = region.id
        AND IFNULL(city_district.id_city, 0) = IFNULL(city.id, 0)
        AND city_district.code = CTARCODE










