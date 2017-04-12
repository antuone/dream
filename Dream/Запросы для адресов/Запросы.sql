select * from addrobj where AOGUID='69956e18-9c2e-434e-b1fd-33d7372feaf5'

SELECT OFFNAME FROM addrobj WHERE ACTSTATUS=1 AND AOLEVEL=3

SELECT OFFNAME FROM addrobj WHERE ACTSTATUS=1 AND AOLEVEL=4 AND OFFNAME='Москва'
MySQL вернула пустой результат (т.е. ноль строк). (Запрос занял 7.2039 сек.)

SELECT OFFNAME FROM addrobj WHERE ACTSTATUS=1 AND AOLEVEL=2
MySQL вернула пустой результат (т.е. ноль строк). (Запрос занял 7.7657 сек.)

Условно выделены следующие уровни адресных объектов:
1 – уровень региона
2 – /*уровень автономного округа*/
3 – уровень района
4 – уровень города
5 – уровень внутригородской территории
6 – уровень населенного пункта
7 – уровень улицы
90 – уровень дополнительных территорий
91 – уровень подчиненных дополнительным территориям объектов


SELECT OFFNAME, REGIONCODE FROM addrobj WHERE ACTSTATUS=1 AND AOLEVEL=7 AND CITYCODE='000' AND AREACODE='000' AND CTARCODE='000' AND PLACECODE='000' 
Отображение строк 0 - 24 (7550 всего, Запрос занял 0.0133 сек.)

SELECT OFFNAME FROM addrobj
WHERE ACTSTATUS=1 AND AOLEVEL=7 AND CITYCODE='000' AND AREACODE='000' AND CTARCODE='000' AND PLACECODE='000' AND REGIONCODE=77
Отображение строк 0 - 24 (3673 всего, Запрос занял 0.0173 сек.)

SELECT OFFNAME FROM addrobj WHERE ACTSTATUS=1 AND REGIONCODE=77 AND AOLEVEL=1 
Отображение строк 0 - 0 (1 всего, Запрос занял 8.2535 сек.)
Москва

SELECT OFFNAME FROM addrobj
WHERE ACTSTATUS=1 AND AOLEVEL=7 AND CITYCODE='000' AND AREACODE='000' AND CTARCODE='000' AND PLACECODE='000' AND REGIONCODE='00'
MySQL вернула пустой результат (т.е. ноль строк). (Запрос занял 7.4745 сек.)

SELECT OFFNAME FROM addrobj WHERE ACTSTATUS=1 AND CITYCODE='000' AND AREACODE='000' AND CTARCODE='000' AND PLACECODE='000' AND REGIONCODE='00' 
MySQL вернула пустой результат (т.е. ноль строк). (Запрос занял 7.5673 сек.)

SELECT OFFNAME, SHORTNAME FROM addrobj WHERE ACTSTATUS=1 AND AOLEVEL=4
Отображение строк 0 - 99 (6326 всего, Запрос занял 0.7942 сек.)

SELECT OFFNAME FROM addrobj WHERE ACTSTATUS=1 AND AOLEVEL=4 AND CITYCODE='000'
 MySQL вернула пустой результат (т.е. ноль строк). (Запрос занял 7.1235 сек.)

SELECT OFFNAME FROM addrobj WHERE ACTSTATUS=1 AND AOLEVEL=5 AND CTARCODE='000'
 MySQL вернула пустой результат (т.е. ноль строк). (Запрос занял 7.7032 сек.)

SELECT OFFNAME FROM addrobj WHERE ACTSTATUS=1 AND AOLEVEL=3 AND AREACODE='000'
MySQL вернула пустой результат (т.е. ноль строк). (Запрос занял 6.9129 сек.)

SELECT * FROM(
SELECT OFFNAME, COUNT(OFFNAME) as `COUNTOFFNAME` FROM addrobj WHERE ACTSTATUS=1 AND AOLEVEL=3 GROUP BY OFFNAME
    )AS `T` WHERE `COUNTOFFNAME`>1
Отображение строк 0 - 24 (94 всего, Запрос занял 7.5164 сек.)

SELECT * FROM(
SELECT AREACODE, COUNT(AREACODE) as `COUNTER` FROM addrobj WHERE ACTSTATUS=1 AND AOLEVEL=3 GROUP BY AREACODE
    )AS `T` WHERE `COUNTER`>1
Отображение строк 0 - 24 (61 всего, Запрос занял 7.7716 сек.)


SELECT OFFNAME, REGIONCODE, AREACODE FROM addrobj WHERE ACTSTATUS=1 AND AOLEVEL=3 AND AREACODE='001' 
 Отображение строк 0 - 24 (29 всего, Запрос занял 3.8164 сек.)
Разные районы находящиеся в разных регионах могут имет одинаковый код.

SELECT CITYCODE FROM addrobj WHERE ACTSTATUS=1 AND AOLEVEL=1 AND OFFNAME='Москва' 
Отображение строк 0 - 0 (1 всего, Запрос занял 7.6398 сек.)
CITYCODE Код города 	
000

SELECT * FROM addrobj WHERE ACTSTATUS=1 AND AOLEVEL=5 AND PARENTGUID='a309e4ce-2f36-4106-b1ca-53e0f48a6d95'

SELECT * FROM addrobj WHERE ACTSTATUS=1 AND AOLEVEL=5 AND CITYCODE=(
    SELECT CITYCODE FROM addrobj WHERE ACTSTATUS=1 AND AOLEVEL=4 AND OFFNAME='Пермь'
    )

SELECT OFFNAME, SHORTNAME, OKATO FROM addrobj WHERE ACTSTATUS=1 AND  AOLEVEL=3 AND OKATO LIKE '57%'  
ORDER BY `addrobj`.`OFFNAME` ASC

SELECT COUNT(DISTINCT OFFNAME) FROM addrobj WHERE ACTSTATUS=1
290163

SELECT COUNT(OFFNAME) FROM addrobj WHERE ACTSTATUS=1 
1254024



Заполнение таблицы name
INSERT INTO name (name) SELECT DISTINCT OFFNAME FROM addrobj WHERE ACTSTATUS=1 
 Добавлено 290163 строки.
Идентификатор вставленной строки: 290163 (Запрос занял 44.6455 сек.)





































