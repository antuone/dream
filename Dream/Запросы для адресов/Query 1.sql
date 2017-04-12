select name.name, region.code from region
inner join name on name.id = region.id_name
order by name.name