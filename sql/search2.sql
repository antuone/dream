SELECT 
    DEAL,
    PROPERTY,
    SPACETOTAL,
    NAME,
    PRICE,
    CURRENCY,
    IDUSER
FROM
    REALESTATE
        INNER JOIN
    REALESTATEAPARTMENT ON REALESTATE.IDREALESTATE = REALESTATEAPARTMENT.IDREALESTATE
        INNER JOIN
    PLACE ON REALESTATE.IDPLACE = PLACE.IDPLACE
WHERE
    REALESTATE.IDPLACE IN (SELECT DISTINCT
            IDPLACE
        FROM
            ADDRESS_COMPONENTS
        WHERE
            IDPLACE IN (SELECT 
                    IDPLACE
                FROM
                    ADDRESS_COMPONENTS
                WHERE
                    long_name = 'Россия')
                AND IDPLACE IN (SELECT 
                    IDPLACE
                FROM
                    ADDRESS_COMPONENTS
                WHERE
                    long_name = 'Пермский край')
                AND IDPLACE IN (SELECT 
                    IDPLACE
                FROM
                    ADDRESS_COMPONENTS
                WHERE
                    long_name = 'город Пермь')
                AND IDPLACE IN (SELECT 
                    IDPLACE
                FROM
                    ADDRESS_COMPONENTS
                WHERE
                    long_name = 'Пермь')
                AND IDPLACE IN (SELECT 
                    IDPLACE
                FROM
                    ADDRESS_COMPONENTS
                WHERE
                    long_name = 'улица Строителей'))
        AND REALESTATE.DEAL = 'SELL'
        AND REALESTATE.PROPERTY = 'APARTMENT'
        AND ((PRICE >= 1000000 AND PRICE <= 2000000
        AND CURRENCY = '₽')
        OR (PRICE >= 1000000 AND PRICE <= 2000000
        AND CURRENCY = '$')
        OR (PRICE >= 1000000 AND PRICE <= 2000000
        AND CURRENCY = '€')
        OR (PRICE >= 1000000 AND PRICE <= 2000000
        AND CURRENCY = '¥')
        OR FIND_IN_SET('ISBYAGREEMENT', REALESTATE.CHECKBOXES) > 0)
        AND (SPACETOTAL >= 70 AND SPACETOTAL <= 500)
        AND FIND_IN_SET('CASH', REALESTATE.CHECKBOXES) > 0