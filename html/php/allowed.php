<?php
$ALLOWED_USER = [
	'EMAIL'=>'s',
	'PASSWORD'=>'s',
	'HASH'=>'s',
	'IP'=>'s',
	'CONFIRMED'=>'s',
	'QUANTITY'=>'s'];


$ALLOWED_POLYGON = [
	'lat'=>'d',
	'lng'=>'d',
	'ИДЕНТИФИКАТОР'=>'i',
	'NUMBER'=>'i'];

$ALLOWED_MARKER = [
	'ИДЕНТИФИКАТОР'=>'i',
	'name'=>'s',
	'lat'=>'d',
	'lng'=>'d'];

$ALLOWED_ADDRESS_COMPONENTS = [
	'IDPLACE'=>'i',
	'long_name'=>'s',
	'short_name'=>'s',
	'types'=>['street_address','route','intersection','political','country','administrative_area_level_1','administrative_area_level_2','administrative_area_level_3','administrative_area_level_4','administrative_area_level_5','colloquial_area','locality','ward','sublocality','sublocality_level_1','sublocality_level_2','sublocality_level_3','sublocality_level_4','sublocality_level_5','neighborhood','premise','subpremise','postal_code','natural_feature','airport','park','point_of_interest','floor','establishment','parking','post_box','postal_town','room','street_number','bus_station','train_station','transit_station']];

$ALLOWED_PLACE = [
	'place_id' => 's',
	'location_type'=>'s',
	'name'=> 's',
	'lat'=>'d',
	'lng'=>'d',
	'vicinity'=>'s',
	'formatted_address'=>'s',
	'south'=>'d',
	'west'=>'d',
	'north'=>'d',
	'east'=>'d',
	'utc_offset'=>'i',
	'website'=>'s',
	'international_phone_number'=>'s',
	'permanently_closed'=>'i',
	'price_level'=>'i',
	'rating'=>'d',
	'types'=>['street_address','route','intersection','political','country','administrative_area_level_1','administrative_area_level_2','administrative_area_level_3','administrative_area_level_4','administrative_area_level_5','colloquial_area','locality','ward','sublocality','sublocality_level_1','sublocality_level_2','sublocality_level_3','sublocality_level_4','sublocality_level_5','neighborhood','premise','subpremise','postal_code','natural_feature','airport','park','point_of_interest','floor','establishment','parking','post_box','postal_town','room','street_number','bus_station','train_station','transit_station']];

$ALLOWED_REALESTATE = [
	'IDUSER'=>'i',
	'IDPLACE'=>'i',
	'TEXT'=>'s',
	'SPACETOTAL'=>'d',
	'DEAL'=>'s',
	'ИМУЩЕСТВО'=>'s',
	'ЦЕНА'=>'i',
	'CURRENCY'=>'s',
	'CADASTRNUMBER'=>'s',
	'NUMBER'=>'i',
	'АТРИБУТЫ'=>[
		'ISBYAGREEMENT',
		'ISDOCUMENT',
		'ELECTRONMONEY',
		'PREPAYMENT',
		'CARD',
		'CASH',
		'DEALTESTDRIVE',
		'ENGINEERINGELECTRICITY',
		'ENGINEERINGHEATING',
		'ENGINEERINGHOTWATER',
		'ENGINEERINGCOLDWATER',
		'ENGINEERINGGAS',
		'ENGINEERINGVENTILATION',
		'ENGINEERINGSEWERAGE',
		'ENGINEERINGELEVATOR',
		'ENGINEERINGINTERNET',
		'BESIDEPARKINGUNDERGROUND',
		'BESIDEPARKINGLOT',
		'BESIDEPARKINGMULTILEVEL',
		'BESIDEPARKINGCOVERED',
		'BESIDEPARKINGPROTECTION',
		'BESIDEGOODTRANSPORTINTERCHANGE']];

$ALLOWED_REALESTATE_APARTMENT = [
	'ИДЕНТИФИКАТОР'=>'i',
	'APARTMENTINTEGRITY'=>'s',
	'APARTMENTSTATUS'=>'s',
	'APARTMENTQUANTITYROOMS'=>'i',
	'APARTMENTOWNEDROOMS'=>'i',
	'APARTMENTRESIDENTIALSPACE'=>'d',
	'APARTMENTTYPEHOUSE'=>'s',
	'APARTMENTNUMBEROFSTOREYS'=>'i',
	'APARTMENTFLOOR'=>'i',
	'APARTMENTCEILINGHEIGHT'=>'d',
	'APARTMENTHOUSING'=>'s',
	'АТРИБУТЫ'=>['APARTMENTPLAYGROUND','APARTMENTINTERCOM','APARTMENTSTUDIO','APARTMENTQUIETNEIGHBORS']];

$ALLOWED_REALESTATE_APARTMENT_ROOM = [
	'ИДЕНТИФИКАТОР'=>'i',
	'APARTMENTNEWNAMEROOM'=>'s',
	'APARTMENTNEWROOMSPACE'=>'d',
	'APARTMENTLOGGIA'=>'s',
	'APARTMENTVIEWFROMTHEWINDOW'=>'s',
	'APARTMENTWINDOWSIDE'=>'s',
	'АТРИБУТЫ'=>['APARTMENTOWNED']];
	
$ALLOWED_REALESTATE_HOUSE = [
	'ИДЕНТИФИКАТОР'=>'i',
	'ISFULLHOUSE'=>'s',
	'HOUSEQUANTITYROOMS'=>'i',
	'HOUSEOWNEDROOMS'=>'i',
	'HOUSERESIDENTIALSPACE'=>'d',
	'HOUSEHOWMANYFLOORS'=>'i',
	'HOUSETYPEHOUSE'=>'s',
	'HOUSEHOUSING'=>'s',
	'HOUSEHEATING'=>'s',
	'HOUSEHOMETOP'=>'s',
	'HOUSECEILINGHEIGHT'=>'d',
	'HOUSEFOUNDATION'=>'s',
	'АТРИБУТЫ'=>['HOUSEPLAYGROUND','HOUSEINTERCOM','HOUSEQUIETNEIGHBORS','HOUSECELLAR','HOUSEBASEMENT']];

$ALLOWED_REALESTATE_HOUSE_ROOM = [
	'ИДЕНТИФИКАТОР'=>'i',
	'HOUSENEWROOMNAME'=>'s',
	'HOUSENEWROOMSPACE'=>'d',
	'HOUSENEWROOMLOGGIA'=>'s',
	'HOUSENEWROOMVIEWOFTHE'=>'s',
	'HOUSENEWROOMSIDE'=>'s',
	'АТРИБУТЫ'=>['HOUSENEWROOMOWNED']];

$ALLOWED_REALESTATE_PARCEL = [
	'ИДЕНТИФИКАТОР'=>'i',
	'PARCELAPIARYSPACE'=>'d',
	'PARCELQUANTITYHIVES'=>'i',
	'АТРИБУТЫ'=>['PARCELISAPIARY','PARCELISGARDEN','PARCELISELECTRICITY','PARCELISWATERPIPES','PARCELISGAS','PARCELISINTERNET','PARCELISSEWERAGE','PARCELISHEATING']];

$ALLOWED_REALESTATE_PARCEL_PLANT = [
	'ИДЕНТИФИКАТОР'=>'i',
	'PARCELNEWPLANT'=>'s',
	'PARCELNEWPLANTPLACE'=>'d'];

$ALLOWED_REALESTATE_PARCEL_HOZBUILDING = [
	'ИДЕНТИФИКАТОР'=>'i',
	'PARCELHOZBUILDINGGNAME'=>'s',
	'PARCELHOZBUILDINPLACE'=>'d'];

$ALLOWED_REALESTATE_GARAGE = [
	'ИДЕНТИФИКАТОР'=>'i',
	'GARAGEGARAGEORPARKINGPLACE'=>'s',
	'GARAGETYPEOFPARKING'=>'s',
	'GARAGETYPEGARAGE'=>'s',
	'GARAGEFOUNDATION'=>'s',
	'GARAGEHOWMANYFLOORS'=>'i',
	'GARAGEFLOOR'=>'i',
	'GARAGECOMPLEXNAME'=>'s',
	'GARAGECEILINGHEIGHT'=>'d',
	'GARAGEGATEHEIGHT'=>'d',
	'АТРИБУТЫ'=>['GARAGEANDPARCELOWNED','GARAGEPROTECTED','GARAGEVIDEOMONITORING','GARAGELIGHTING','GARAGECELLAR','GARAGEBASEMENT','GARAGEPIT','GARAGESHELVES']];

$ALLOWED_REALESTATE_ROOM = [
	'ИДЕНТИФИКАТОР'=>'i',
	'ROOMTYPEROOM'=>'s',
	'ROOMTYPEBUILDING'=>'s',
	'ROOMCEILINGHEIGHT'=>'d',
	'ROOMHOWMANYFLOORS'=>'i',
	'ROOMFLOOR'=>'i',
	'АТРИБУТЫ'=>['ROOMSEPARATEENTRANCE','ROOMSEPARATEELECTRICALPANEL']];

$ALLOWED_REALESTATE_ROOMMORE = [
	'ИДЕНТИФИКАТОР'=>'i',
	'ROOMMOREROOMNAME'=>'s',
	'ROOMMOREROONSPACE'=>'d'];

$ALLOWED_REALESTATE_HOTEL = [
	'ИДЕНТИФИКАТОР'=>'i',
	'HOTELHOWMANYFLOORS'=>'i',
	'HOTELHOWMANYROOMS'=>'i',
	'HOTELHOWMANYSTARS'=>'s',
	'HOTELTYPEBUILDING'=>'s',
	'HOTELFOUNDATION'=>'s',
	'АТРИБУТЫ'=>['HOTELNONSMOKINGROOMS','HOTELFAMILYROOMS','HOTELINDOORSWIMMINGPOOL','HOTELSPAWELLNESSCENTRE','HOTELRESTAURANTDINING','HOTELFITNESSCENTRE','ОТЕЛЬУДОБСТВАДЛЯГОСТЕЙСОГРАНИЧЕННЫМИФИЗИЧЕСКИМИВОЗМОЖНОСТЯМИ','HOTELMEETINGBANQUET','HOTELFACILITIES','HOTELBAR','HOTELHONEYMOONSUITE','HOTELBARBERBEAUTYSALON','ОТЕЛЬСАУНА','ОТЕЛЬСОЛЯРИЙ','ОТЕЛЬТУРЕЦКАЯБАНЯ','ОТЕЛЬМАССАЖ']];

$ALLOWED_REALESTATE_HOTEL_ROOM = [
	'ИДЕНТИФИКАТОР'=>'i',
	'HOTELMOREROOMNAME'=>'s',
	'HOTELMOREROOMSPACE'=>'d',
	'HOTELMOREROOMINFO'=>'s'];

$ALLOWED_REALESTATE_OTHER = [
	'ИДЕНТИФИКАТОР'=>'i'];

$ALLOWED_REALESTATE_OTHER_BUILDING = [
	'ИДЕНТИФИКАТОР'=>'i',
	'OTHERBUILDINGTEXTAREA'=>'s',
	'OTHERNEWBUILDINGNAME'=>'s',
	'OTHERNEWBUILDINGSPACE'=>'d',
	'OTHERNEWBUILDINGLOORS'=>'i',
	'OTHERNEWBUILDINGFLOORHEIGHT'=>'d',
	'OTHERNEWBUILDINGTYPE'=>'s',
	'АТРИБУТЫ'=>['OTHERNEWBUILDINGSEPARATEENTRANCE']];

$ALLOWED_REALESTATE_OTHER_BUILDING_ROOM = [
	'IDOTHERBUILDING'=>'i',
	'OTHERNEWROOMMOREINFO'=>'s',
	'OTHERNEWROOMNAME'=>'s',
	'OTHERNEWROOMSPACE'=>'d'];

?>