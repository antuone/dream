select * from REALESTATE
left join REALESTATEADDRESS on REALESTATE.IDREALESTATE = REALESTATEADDRESS.IDREALESTATE
left join REALESTATEBESIDE on REALESTATE.IDREALESTATE = REALESTATEBESIDE.IDREALESTATE
left join REALESTATEENGINEERING on REALESTATE.IDREALESTATE = REALESTATEENGINEERING.IDREALESTATE 
where REALESTATE.IDREALESTATE = 1 and REALESTATE.IDUSER = 2