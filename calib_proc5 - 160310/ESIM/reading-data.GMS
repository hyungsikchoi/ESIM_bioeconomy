* LOADING THE PARAMETER FILES


$include "load-para.gms"

****************************** START: IMPORTANT ******************************
*
* LOADING THE DATA FILES:
*
* - To load a new data base (quantities and prices), please delete the '*' and run the programme
* under the option $setglobal GSEACTION VERSION in file ESIM.GMS
* - This will create the new GDX files which contain the data base for ESIM
* - For later runs ALLWAYS put an '*' in the first column in the following line
*
*$include "load-new-database.gms"
****************************** END: IMPORTANT *******************************


******** LOADING EXISTING BASE DATA FILE IN GDX FORMAT ******

* LOADING THE DATA FILES:
* COUNTRY SPECIFIC DATA


$GDXin 'database_esim.gdx'
$load hdem0
$load prod0
$load sdem0
$load fdem0
$load feed_exog
$load procdem0
$load pdem_en0
$load netexp0
$load area0
$load hist_area
$GDXIN

************  LODADING PRICE DATA   ************

$include "load-prices.gms"

************  SAVE ALL CURRENT BASE DATA   ************

execute_UNLOAD 'complete_esim_database.gdx',
elasthd
elastsp,
elastyd,
elastfd,
fedrat,
elastin,
elast_y_i,
elast_y_l,
elast_y_c,
elast_y_e,
elast_y_f,
*elast_a_i,
*elast_a_l,
*elast_a_c,
elast_lv_i,
elast_lv_l,
elast_lv_c,
elast_lv_f,
*elastdm,
hdem_b,
prod_b,
sdem_b,
fdem_b,
procdem_b,
pdem_en_b,
netexp_b,
area_b,
feed_exog,
mrktpri0,
margin0,
eu_pols,
hdem0,
prod0,
sdem0,
fdem0,
procdem0,
pdem_en0,
netexp0,
dirpay0,
price_dev,
area0,
hist_area;
