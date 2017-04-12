SELECT DEAL, PROPERTY, SPACETOTAL, NAME as 'ADDRESS', PRICE, CURRENCY, CHECKBOXES, NUMBER FROM REALESTATE
INNER JOIN PLACE ON REALESTATE.IDPLACE = PLACE.IDPLACE 
WHERE REALESTATE.IDPLACE IN (
	SELECT distinct IDPLACE FROM ADDRESS_COMPONENTS
	WHERE IDPLACE IN ( SELECT IDPLACE FROM ADDRESS_COMPONENTS WHERE long_name = 'улица Строителей') AND IDPLACE IN ( SELECT IDPLACE FROM ADDRESS_COMPONENTS WHERE long_name = 'Пермь') AND IDPLACE IN ( SELECT IDPLACE FROM ADDRESS_COMPONENTS WHERE long_name = 'город Пермь') AND IDPLACE IN ( SELECT IDPLACE FROM ADDRESS_COMPONENTS WHERE long_name = 'Пермский край') AND IDPLACE IN ( SELECT IDPLACE FROM ADDRESS_COMPONENTS WHERE long_name = 'Россия')
)
AND REALESTATE.DEAL = 'SELL'

AND ((PRICE >= 1000000 AND PRICE <= 2000000 AND CURRENCY = '₽') OR
              (PRICE >= 15897 AND PRICE <= 31794 AND CURRENCY = '$') OR
              (PRICE >= 15000 AND PRICE <= 30000 AND CURRENCY = '€') OR
              (PRICE >= 15000 AND PRICE <= 30000 AND CURRENCY = '¥') OR
              find_in_set('ISBYAGREEMENT', REALESTATE.CHECKBOXES) > 0)
AND (SPACETOTAL >= 70 AND SPACETOTAL <= 500)
AND find_in_set('CASH', REALESTATE.CHECKBOXES) > 0