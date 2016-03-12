* Historical Data

parameter
area_wh(cc,time)   historical area Whaet (1000 ha)
area_du(cc,time)   historical area Durum (1000 ha)
area_co(cc,time)   historical area Corn (1000 ha)
area_ry(cc,time)   historical area Rye (1000 ha)
area_ri(cc,time)   historical area Rice (1000 ha)
area_su(cc,time)   historical area Sugar Beet (1000 ha)
area_ba(cc,time)   historical area Barley (1000 ha)
area_og(cc,time)   historical area Other Grain (1000 ha)
area_sm(cc,time)   historical area Silage Maize (1000 ha)
area_pa(cc,time)   historical area Pasture (1000 ha)
area_po(cc,time)   historical area Potato (1000 ha)
area_fo(cc,time)   historical area Fodder (1000 ha)
area_rap(cc,time)   historical area Rapeseed (1000 ha)
area_sun(cc,time)   historical area Sunseed (1000 ha)
area_soy(cc,time)   historical area Soybeen (1000 ha)
HIST_AREA(one,crops,hist)
;

$libinclude xlimport area_wh  data\data-area.xls wheat
$libinclude xlimport area_du  data\data-area.xls durum
$libinclude xlimport area_co  data\data-area.xls corn
$libinclude xlimport area_ry  data\data-area.xls rye
$libinclude xlimport area_ri  data\data-area.xls rice
$libinclude xlimport area_su  data\data-area.xls sugarbeet
$libinclude xlimport area_ba  data\data-area.xls barley
$libinclude xlimport area_og  data\data-area.xls ograin
$libinclude xlimport area_sm  data\data-area.xls smaize
$libinclude xlimport area_pa  data\data-area.xls pasture
$libinclude xlimport area_po  data\data-area.xls potato
$libinclude xlimport area_fo  data\data-area.xls fodder
$libinclude xlimport area_rap   data\data-area.xls rapseed
$libinclude xlimport area_sun   data\data-area.xls sunseed
$libinclude xlimport area_soy   data\data-area.xls soyseed


HIST_AREA(one,'cwheat',hist)  = area_wh(one,hist)       ;
HIST_AREA(one,'durum',hist)   = area_du(one,hist)       ;
HIST_AREA(one,'corn',hist)    = area_co(one,hist)       ;
HIST_AREA(one,'rye',hist)     = area_ry(one,hist)       ;
HIST_AREA(one,'rice',hist)    = area_ri(one,hist)       ;
HIST_AREA(one,'sugar',hist)   = area_su(one,hist)       ;
HIST_AREA(one,'barley',hist)  = area_ba(one,hist)       ;
HIST_AREA(one,'othgra',hist)  = area_og(one,hist)       ;
HIST_AREA(one,'smaize',hist)  = area_sm(one,hist)       ;
HIST_AREA(one,'gras',hist)    = area_pa(one,hist)       ;
HIST_AREA(one,'potato',hist)  = area_po(one,hist)       ;
HIST_AREA(one,'fodder',hist)  = area_fo(one,hist)       ;
HIST_AREA(one,'rapseed',hist) = area_rap(one,hist)      ;
HIST_AREA(one,'sunseed',hist) = area_sun(one,hist)      ;
HIST_AREA(one,'soybean',hist) = area_soy(one,hist)      ;

display hist_Area
