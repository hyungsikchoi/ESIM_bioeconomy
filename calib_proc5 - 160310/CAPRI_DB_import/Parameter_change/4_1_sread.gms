$include "4_Supply-Elasticities-declarations.gms"

*****(HS)read new allen elasticies from supply.xls including 'PULS'.gms"

$call gdxxrw excel_data\SUPPLY.xls  par=sigma   rng=Allen!A34:X57
$GDXIN SUPPLY.gdx
$LOAD sigma
$GDXIN


****supply_read gdx comes from preivous file "supply-Elasticiteds-Reading.gms"
***area price elasticities from previous verions
$GDXin supply_read
$load  el_area0
$GDXin




*****************************************
**** own price elasticites from previous verions
*****************************************
$GDXin esim_parameters.gdx
$load  elastyd
$GDXin

elastyd('MT','DURUM','DURUM') = elastyd('IT','DURUM','DURUM');

elastyd('TU','SMAIZE','SMAIZE') = elastyd('SK','SMAIZE','SMAIZE');
elastyd('WB','SMAIZE','SMAIZE') = elastyd('SK','SMAIZE','SMAIZE');


el_area0('HR',farm,j)$(el_area0('SI',farm,j) OR el_area0('HU',farm,j))
= (el_area0('SI',farm,j) + el_area0('HU',farm,j)) / abs(sign(el_area0('SI',farm,j)) + sign(el_area0('HU',farm,j)));

el_area0('WB',farm,j)$(el_area0('SI',farm,j) OR el_area0('HU',farm,j))
= (el_area0('SI',farm,j) + el_area0('HU',farm,j)) / abs(sign(el_area0('SI',farm,j)) + sign(el_area0('HU',farm,j)));

el_area0('ROW','PALMOIL',j)=el_area0('ROW','SOYBEAN',j);

**hyungsik assgn seaside values from adres' paramter
el_area0('GE','setaside','setaside')=0.12;
el_area0(eu12,'setaside','setaside') =  el_area0('GE','setaside','setaside');
display el_area0;

*** Q U I C K   F I X: Own price elasticity for Potatos too high with little substitutes, infeasible otherwise
el_area0('MT','POTATO','POTATO') = 0.5;

el_area0('PL','SOYBEAN',j) = el_area0('SK','SOYBEAN',j);
el_area0('TU','RAPSEED',j) = el_area0('GR','RAPSEED',j);

*****hyungsik, Turkey smaize elasticies are assiged from SK
el_area0('TU','SMAIZE',j)= el_area0('SK','SMAIZE',j);


sigma(farm,farm) = 0.1 * sigma(farm,farm);

own_area(e,farm) = el_area0(e,farm,farm);
own_area(e,'GLUTFD') = 0;

***GRAS exist for WB
*own_area('WB','GRAS') = 0;
own_area('US','GRAS') = 0;
own_area('ROW','GRAS') = 0;

***Smaize exists for WB
*own_area('WB','SMAIZE') = 0;
own_area('US','SMAIZE') = 0;
own_area('ROW','SMAIZE') = 0;


*own_area('WB','FODDER') = own_area('GE','GRAS');
*own_area('US','FODDER') = own_area('GE','GRAS');
*own_area('ROW','FODDER') = own_area('GE','GRAS');

own_area('WB','FODDER') = own_area('GE','FODDER')/2;
own_area('US','FODDER') = own_area('GE','FODDER')/2;
own_area('ROW','FODDER') = own_area('GE','FODDER')/2;

display own_area;

sigma(farm,farm) = 0;
* For ROW
*sigma('manioc',j)=   sigma('potato',j);
*sigma('manioc','potato')=   sigma('potato','sugar');
*sigma(farm,'manioc')= sigma('manioc',farm);
sigma('other',farm)= 0;

sigma('palmoil',j)=   sigma('soybean',j);
sigma('palmoil','soybean')=   sigma('palmoil','sunseed');
sigma(farm,'palmoil')= sigma('palmoil',farm);
sigma('other',farm)= 0;
;




execute_unload 'supply_default.gdx' sigma, own_area, elastyd;

