* Writes all parameteres generated to gdx files readible by ESIM






parameters
* esim_parameters.gdx
*dirpay0          source
el_area0     own and cross  price elasticity of area

elast_a_c    capital cost elasticity of area
elast_a_i    intermediate cost elasticity of area
elast_a_l    labor cost elasticity of area

elast_lv_c   capital cost elasticity of livestok supply
elast_lv_f   feed cost elasticity of livestock supply
elast_lv_i   intermediate cost elasticity of livestock supply
elast_lv_l   labor cost elasticity of livestock supply

elast_y_c   capital cost elasticity of yield
elast_y_e   energy cost elasticity of yield
elast_y_f   fertilizer cost elasticity of yield
elast_y_i   intermediate cost elasticity of yield
elast_y_l   labor cost elasticity of yield

elastfd_b   price elasticity of feed demand
elastfd     price elasticity of feed demand
elasthd     price elasticity of humand demand
elastin     income elasticity of humand demand

elastsp     own and cross  price elasticity of area
elastyd     price elasticity of yield
fedrat      feed rate

*feed_exog
*HIST_AREA        source
*PRICE_DEV        source
;
*$GDXin esim_parameters.gdx
*$load dirpay0, HIST_AREA, PRICE_DEV
*$GDXin

$GDXin ..\Data_GDX\Supply_elast_40.gdx
$load el_area0, elast_y_c, elast_y_e, elast_y_f, elast_y_i, elast_y_l,elastyd
$GDXin



set
c        countries
/
AT
BE
DK
FI
FR
GE
GR
IE
IT
NL
PT
ES
SW
UK
LV
RO
SI
LT
BG
PL
HU
CZ
SK
EE
CY
MT
TU
HR
WB
US
ROW
/
i
/
CWHEAT
DURUM
BARLEY
CORN
RYE
OTHGRA
RICE
SUGAR
POTATO
SOYBEAN
PULS    new
RAPSEED
SUNSEED
MANIOC
GLUTFD
SMP
SUNMEAL
RAPMEAL
SOYMEAL
OPROT
OENERGY
MILK
BEEF
SHEEP
PORK
POULTRY
EGGS
GRAS
FODDER
SMAIZE
SETASIDE
PALMOIL
OTHER
LABOR
CAPITAL
FEED
INTERMED
LAND
ENERGY
FERTIL
/
crops
/
CWHEAT
DURUM
BARLEY
CORN
RYE
OTHGRA
RICE
SUGAR
POTATO
SOYBEAN
PULS     new
RAPSEED
SUNSEED
MANIOC
GRAS
FODDER
SMAIZE
SETASIDE
OTHER
/
livest
/
MILK
BEEF
SHEEP
PORK
POULTRY
EGGS
/
;
alias (i,j);
elast_a_c(c,crops) = el_area0(c,crops,'capital');
elast_a_i(c,crops) = el_area0(c,crops,'intermed');
elast_a_l(c,crops) = el_area0(c,crops,'labor');
elast_lv_c(c,livest) = el_area0(c,livest,'capital');
elast_lv_f(c,livest) = el_area0(c,livest,'feed');
elast_lv_i(c,livest) = el_area0(c,livest,'intermed');
elast_lv_l(c,livest) = el_area0(c,livest,'labor');

elastsp(c,i,j) = el_area0(c,i,j);

$GDXin ..\Data_GDX\fdem_elast.gdx
$load elastfd_b=p_elast
$GDXin
elastfd(c,i,j,livest) = elastfd_b(c,livest,i,j);
elastfd(c,i,j,livest)$(not elastfd(c,i,i,livest)) = 0;
elastfd(c,i,j,livest)$(not elastfd(c,j,j,livest)) = 0;


$GDXin ..\Data_GDX\HUM-DEM-RES.gdx
$load elasthd=st_price
$load elastin=stor_inc
$GDXin

$GDXin ..\Data_GDX\frates_calc.gdx
$load fedrat=frate
*$load feed_exog=f_int
$GDXin




execute_unload '..\Data_GDX\esim_parameters_20%.gdx'
*dirpay0
el_area0
elast_a_c
elast_a_i
elast_a_l
elast_lv_c
elast_lv_f
elast_lv_i
elast_lv_l
elast_y_c
elast_y_e
elast_y_f
elast_y_i
elast_y_l
elastfd
elasthd
elastin
elastsp
elastyd
fedrat
*feed_exog
*HIST_AREA
*PRICE_DEV
;
*** for version with 40% allocation efficacy
parameter
el_area_40
;
$GDXin ..\Data_GDX\Supply_elast_40.gdx
$load el_area_40 = el_area0
$GDXin

el_area0(c,i,j) = el_area_40(c,i,j);

elast_a_c(c,crops) = el_area_40(c,crops,'capital');
elast_a_i(c,crops) = el_area_40(c,crops,'intermed');
elast_a_l(c,crops) = el_area_40(c,crops,'labor');
elast_lv_c(c,livest) = el_area_40(c,livest,'capital');
elast_lv_f(c,livest) = el_area_40(c,livest,'feed');
elast_lv_i(c,livest) = el_area_40(c,livest,'intermed');
elast_lv_l(c,livest) = el_area_40(c,livest,'labor');

elastsp(c,i,j) = el_area_40(c,i,j);

execute_unload '..\Data_GDX\esim_parameters_40%.gdx'
*dirpay0
el_area0
elast_a_c
elast_a_i
elast_a_l
elast_lv_c
elast_lv_f
elast_lv_i
elast_lv_l
elast_y_c
elast_y_e
elast_y_f
elast_y_i
elast_y_l
elastfd
elasthd
elastin
elastsp
elastyd
fedrat
*feed_exog
*HIST_AREA
*PRICE_DEV
;
*** for version with 40% allocation efficacy - END



parameter
* data_prices.gdx
DIRPAY00
PD00
PINC00
PP00

pd
;



$GDXin ..\Data_Price_GDX\data_prices_new
$load DIRPAY00, PD00, PINC00, PP00
$GDXin


$GDXin ..\Data_GDX\fdem_elast
$load pd
$GDXin

PD00(c,'OENERGY') = pd(c,'OENERGY');
PD00(c,'OPROT  ') = pd(c,'OPROT  ');
PD00(c,'GRAS   ') = pd(c,'GRAS   ');
PD00(c,'FODDER ') = pd(c,'FODDER ');
PD00(c,'SMAIZE ') = pd(c,'SMAIZE ');


PP00(c,'OENERGY') = pd(c,'OENERGY');
PP00(c,'OPROT  ') = pd(c,'OPROT  ');
PP00(c,'GRAS   ') = pd(c,'GRAS   ');
PP00(c,'FODDER ') = pd(c,'FODDER ');
PP00(c,'SMAIZE ') = pd(c,'SMAIZE ');

PINC00(c,'GRAS   ') = pd(c,'GRAS   ') + DIRPAY00(c,'GRAS   ');
PINC00(c,'FODDER ') = pd(c,'FODDER ') + DIRPAY00(c,'FODDER ');
PINC00(c,'SMAIZE ') = pd(c,'SMAIZE ') + DIRPAY00(c,'SMAIZE ');

execute_unload '..\Data_GDX\data_prices.gdx'
DIRPAY00
PD00
PINC00
PP00
;


parameter
* data_quantities.gdx
area0
fdem0
hdem0
netexp0
pdem0
prod0
sdem0

f_dem
;

$GDXin ..\Data_GDX\data_capri
$load area0, fdem0, hdem0, netexp0, pdem0, prod0, sdem0
$GDXin

$GDXin ..\Data_GDX\frates_calc
$load f_dem
$GDXin

fdem0(c,'OENERGY') = f_dem(c,'OENERGY');
fdem0(c,'OPROT  ') = f_dem(c,'OPROT  ');
fdem0(c,'GRAS   ') = f_dem(c,'GRAS   ');
fdem0(c,'FODDER ') = f_dem(c,'FODDER ');
fdem0(c,'SMAIZE ') = f_dem(c,'SMAIZE ');


prod0(c,'OENERGY') = f_dem(c,'OENERGY');
prod0(c,'OPROT  ') = f_dem(c,'OPROT  ');
prod0(c,'GRAS   ') = f_dem(c,'GRAS   ');
prod0(c,'FODDER ') = f_dem(c,'FODDER ');
prod0(c,'SMAIZE ') = f_dem(c,'SMAIZE ');

execute_unload '..\Data_GDX\data_quantities.gdx'
area0
fdem0
hdem0
netexp0
pdem0
prod0
sdem0
;
