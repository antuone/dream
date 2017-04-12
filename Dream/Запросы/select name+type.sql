select name from region 
join name on region.id_name = name.id
where region.id = 59
limit 1