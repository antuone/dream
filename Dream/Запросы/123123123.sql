SELECT IDPLACE FROM realestate.PLACE
where FIND_IN_SET('street_address', `types`) > 0