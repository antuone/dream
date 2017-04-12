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