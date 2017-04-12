XX XXX XXX КЧ
12 345 678

1 и 2 это регион

3 это
	1 — автономный округ;
	2 — район (в том числе внутригородской), округ;
	4 — город, посёлок городского типа.

4 и 5 это районы и города автономных округов, входящих в состав краев и областей

6 это
    3 — внутригородской район, округ города;
    5 — город, посёлок городского типа;
    8 — сельсовет.

7 и 8  подчиненные объекты для 4 и 5 (города, поселки городского типа и сельсоветы) 





SELECT OFFNAME, OKATO FROM `addrobj` WHERE ACTSTATUS=1 AND AOLEVEL=4 AND SUBSTRING(OKATO,4,2) = '00'

/*заполнение type*/
INSERT INTO type (name, socr)
SELECT DISTINCT `SOCRNAME`, `SCNAME` FROM `socrbase`


SELECT (SELECT id from name where OFFNAME=name), REGIONCODE, (SELECT id FROM type WHERE SHORTNAME=socr), OKATO, SUBSTRING(OKATO, 1, 2) FROM `addrobj` WHERE ACTSTATUS=1 AND AOLEVEL=1

SELECT * from addrobj WHERE REGIONCODE=21 AND ACTSTATUS=1 AND AOLEVEL=1

/*Заполнение регион*/
INSERT INTO region (id_name, code, id_type, okato, id_global)
SELECT (SELECT id from name where OFFNAME=name),
		REGIONCODE,
        (SELECT id FROM type WHERE SHORTNAME=socr),
        SUBSTRING(OKATO, 1, 2),
        AOGUID
FROM `addrobj` WHERE ACTSTATUS=1 AND AOLEVEL=1

UPDATE `region` SET `id_name` = '29041' WHERE `region`.`id` = 20;

/*Заполнение дистрикт*/
INSERT INTO district (id_name, id_region)
SELECT (SELECT id from name where OFFNAME=name), (SELECT id FROM region WHERE REGIONCODE=region.code) FROM `addrobj` WHERE ACTSTATUS=1 AND AOLEVEL=3 


INSERT INTO aoguid_region (id, id_region) SELECT AOGUID, (SELECT id FROM region WHERE REGIONCODE=region.code) FROM `addrobj` WHERE ACTSTATUS=1 AND AOLEVEL=1 


INSERT INTO aoguid_district (id, id_district) SELECT AOGUID, (SELECT id FROM district WHERE district.id_region = (SELECT id FROM region WHERE REGIONCODE=region.code) AND district.id_name = (SELECT id from name where OFFNAME=name.name)) FROM `addrobj` WHERE ACTSTATUS=1 AND AOLEVEL=3 


SELECT OFFNAME, SHORTNAME, OKATO, substring(OKATO,3,3) as `District` FROM addrobj WHERE ACTSTATUS=1 AND AOLEVEL=3 AND substring(OKATO,1,2)='57' ORDER BY `District` ASC 


/*Заполнение дистрикт*/
INSERT INTO district (id_name, id_type, id_region, okato, id_global)
SELECT (SELECT id from name where OFFNAME=name),
(SELECT id FROM type WHERE SHORTNAME=socr),
(SELECT id FROM region WHERE region.code=REGIONCODE),
OKATO,
AOGUID
FROM `addrobj` WHERE ACTSTATUS=1 AND AOLEVEL=3 


SELECT OFFNAME, REGIONCODE, OKATO FROM `addrobj` WHERE ACTSTATUS=1 AND AOLEVEL=1 ORDER BY `addrobj`.`OKATO` ASC 


/*Заполнение goroda*/
INSERT INTO city (id_name, id_type, id_region, okato, id_global, id_district)
SELECT (SELECT id from name where OFFNAME=name),
(SELECT id FROM type WHERE SHORTNAME=socr),
(SELECT id FROM region WHERE region.code=REGIONCODE),
substring(OKATO,6,3),
AOGUID,
(SELECT id FROM district WHERE district.okato=substring(OKATO,2,3)
FROM `addrobj` WHERE ACTSTATUS=1 AND AOLEVEL=4





/*Заполнение goroda*/
INSERT INTO city (id_name, id_type, id_region, okato, id_global, id_district)
SELECT (SELECT id from name where OFFNAME=name),
(SELECT id FROM type WHERE SHORTNAME=socr),
(SELECT id FROM region WHERE region.code=REGIONCODE),
OKATO,
AOGUID,
(SELECT id FROM district WHERE district.okato=substring(OKATO,2,3)
FROM `addrobj` WHERE ACTSTATUS=1 AND AOLEVEL=4


SELECT OFFNAME, REGIONCODE, OKATO FROM `addrobj` WHERE ACTSTATUS=1 AND AOLEVEL=4 ORDER BY `addrobj`.`OKATO` ASC


SELECT * FROM ( SELECT okato, COUNT(*) as `qwe` FROM district GROUP by okato ) as `T` WHERE `qwe`>1 

 okato 		qwe 	
04143000000 	2
DELETE from district WHERE id_global='a33fb615-695f-473b-ac2e-4edd048312db'

04146000000 	2
DELETE FROM district WHERE id_global='02008591-8f4c-4e35-9b66-7fbff7e9bb00'
04149000000 	2
DELETE FROM district WHERE id_global='e807f24c-c064-4be7-b389-f90934971ee8'
35000000000 	2	в крыму два района с одинаковым окато, удалил нахуй
DELETE FROM district WHERE id_global='5c6a204a-5468-46d8-8cf3-1121232ace22' 
DELETE FROM district WHERE id_global='5c6a204a-5468-46d8-8cf3-1121232ace22' 
35235000000 	2 тоже в крыму
DELETE FROM district WHERE id_global='0989cf50-3130-46c8-b121-c3e38e93002b' 
DELETE FROM district WHERE id_global='ff26b263-42b0-4bdf-8aaf-7111c281ea2c' 
92228000000 	2

