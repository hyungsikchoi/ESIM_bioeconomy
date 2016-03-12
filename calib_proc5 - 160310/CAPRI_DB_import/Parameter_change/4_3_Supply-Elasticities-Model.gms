$include "4_Supply-Elasticities-declarations.gms"


$GDXin ..\Data_Price_GDX\data_prices_new
$load price=PP00
$GDXin


$GDXin ..\Data_GDX\data_capri.gdx
$load supply=prod0
$load area=area0
$GDXin

supply(e,'setaside')= area(e,'setaside')
;


$GDXin supply_default
$load elastyd=elastyd
$load sigma=sigma
$load own_area=own_area
$GDXin

display supply;

********************************
*****PULS inserted as a new item
********************************

***area elasticity
el_area0(e,farm,farm) = own_area(e,farm);


$GDXin ..\Data_GDX\fdem_elast
$load forage_price=pd
$GDXin

**price check!!!
price(e,'GRAS') = forage_price(e,'GRAS');
price(e,'FODDER') = forage_price(e,'FODDER');
price(e,'SMAIZE') = forage_price(e,'SMAIZE');


$GDXin ..\Data_GDX\frates_calc
$load f_dem
$GDXin


supply(e,'GRAS')   = f_dem(e,'GRAS');
supply(e,'FODDER') = f_dem(e,'FODDER');
supply(e,'SMAIZE') = f_dem(e,'SMAIZE');


$GDXin cost_shares
$load cost_share_crops, cost_share_livest
$GDXin

cost_share_crops('TU',crops,j)  = sum(eu12,cost_share_crops(eu12,crops,j))/12;
cost_share_crops('HR',crops,j)  = sum(eu12,cost_share_crops(eu12,crops,j))/12;
cost_share_crops('US',crops,j)  = sum(eu15,cost_share_crops(eu15,crops,j))/14;
cost_share_crops('WB',crops,j)  = sum(eu12,cost_share_crops(eu12,crops,j))/12;
cost_share_crops('ROW',crops,j) = sum(eu12,cost_share_crops(eu12,crops,j))/12;

*cost_share_crops('ROW','MANIOC',j) = cost_share_crops('ROW','POTATO',j);

cost_share_livest('TU',livest,j)  = sum(eu12,cost_share_livest(eu12,livest,j))/12;
cost_share_livest('HR',livest,j)  = sum(eu12,cost_share_livest(eu12,livest,j))/12;
cost_share_livest('US',livest,j)  = sum(eu15,cost_share_livest(eu15,livest,j))/14;
cost_share_livest('WB',livest,j)  = sum(eu12,cost_share_livest(eu12,livest,j))/12;
cost_share_livest('ROW',livest,j) = sum(eu12,cost_share_livest(eu12,livest,j))/12;
;





parameters
sigma0   allen elasticities change for ROW since rice has little other substitutes
pp       producer price
epsilon2 elasticity
elast_labor(crops,c)
elast_inter(crops,c)

val_oth(e)       Value Share of other annual crops. Adopted from the 2004 version of ESIM as the source (AGRIS) is not available anymore
/
AT        0.0485
BE        0.0485
DK        0.0485
FI        0.0485
FR        0.0485
GE        0.0485
GR        0.0485
IE        0.0485
IT        0.0485
NL        0.0485
PT        0.0485
ES        0.0485
SW        0.0485
UK        0.0485
LV        0.0082
RO        0.0233
SI        0.0728
LT        0.0192
BG        0.1097
PL        0.0191
HU        0.0361
CZ        0.0547
SK        0.0191
EE        0.0062
CY        0.1733
MT        0.0
TU        0.2300
HR        0.0728
US        0.12
ROW       0.12
WB        0.12
/
******************************************
**********    SUGAR    *******************
******************************************

*** Sugar is treated differently in ESIM 06, with a non iso-elastic function.
*** The prices here are the beet prices for farmers in WSE.
*** The Elasticities are not used in the model, but serve only to make the rest of the elasticity matrix consistent
*** The prices which are used finally in the model as producer prices are the shadow prices of the sugar industry.
*** The supply function is calibrated such that an additive (unlike it is done for the other products) wholesale margin
*** (i.e. processing margin) is imlplied.
psh_sugar(c)
/
CZ        279
DK        303
GE        228
GR        279
ES        328
FR        272
IE        285
IT        217
LV        329
LT        329
HU        279
NL        210
AT        241
PL        229
PT        304
SI        329
SK        329
FI        360
SW        266
BE        185
UK        315
/
el_sugar(c)
/
AT        1.530602471
BE        1.328800879
DK        1.993934086
FI        0.969453656
FR        1.935439318
GE        1.690585119
GR        1.053607521
IE        1.676468594
IT        0.626857316
NL        1.360477995
PT        0.971104402
ES        1.132767161
SW        1.119648411
UK        1.667189906
LV        1.346163313
SI        0.781532909
LT        0.981992071
PL        1.417610032
HU        0.886669009
CZ        0.863761601
SK        0.891986920
/

;

el_area0(e,'SUGAR','SUGAR')$el_sugar(e) = el_sugar(e);
******************************************
**********    SUGAR END   ****************
******************************************

****************************************
***hyungsik PULS
****************************************

el_area0(e,'PULS','PULS') = el_area0(e,'SOYBEAN','SOYBEAN')  ;
price(e,'PULS') = price(e,'SOYBEAN');
elastyd(e,'PULS','PULS') = elastyd(e,'SOYBEAN','SOYBEAN');

*sigma('PULS',farm) = sigma('SOYBEAN',farm);
*sigma(farm,'PULS') = -0.01;

****



******************************************
**********    PULS END   ****************
******************************************


********************************
** Producer price calculation **
********************************


*****(HS)0.4 indicate the effective facotr of DP


*pp(e,farm) = price(e,farm) + areapay(e)* exrate('GE') / exrate(e) * 0.2;
*pp(e,'SETASIDE') = areapay(e) * exrate('GE') / exrate(e) * 0.2;

pp(e,farm) = price(e,farm) + areapay(e)* exrate('GE') / exrate(e) * 0.4;
pp(e,'SETASIDE') = areapay(e) * exrate('GE') / exrate(e) * 0.4;


display pp;



**************************************
** Producer price calculation - END **
**************************************



** Value share calculation **

val_shr(e,livest)= supply(e,livest)* pp (e,livest)/ sum(livest1,supply(e,livest1)*pp(e,livest1));

val_shr(e,crops)= supply(e,crops)* pp (e,crops)/ (sum(crops1,supply(e,crops1)*pp(e,crops1)))*(1-val_oth(e));
val_shr(e,"OTHER")= val_oth(e);

** Value share calculation - END **


display el_area0,PP,val_shr,supply;





* Elasticities w.r.t. factor cost are not adjusted endogeneously. They enter they calibration procedure as exogeneous.
* They are determined according to cost shares in production (like the feed cost elasticity) and distributed to area allocation and yield matrix
* Yield matrix must be homogenous of degree zero.

** elasticity of supply w.r.t. the price of inputs and production factors

parameter
elast_y_i(e,crops)
elast_y_c(e,crops)
elast_y_l(e,crops)
elast_y_f(e,crops)
elast_y_e(e,crops)
;

* combined elasticity of supply (area and yield)
el_area0(e,crops,'LABOR')    =   cost_share_crops(e,crops,'LABOR')   * 0.6 * (el_area0(e,crops,crops) + elastyd(e,crops,crops));
el_area0(e,crops,'CAPITAL')  =   cost_share_crops(e,crops,'CAPITAL') * 0.6 * (el_area0(e,crops,crops) + elastyd(e,crops,crops));
el_area0(e,crops,'FERTIL')   =   cost_share_crops(e,crops,'FERTIL')  * 0.6 * (el_area0(e,crops,crops) + elastyd(e,crops,crops));
el_area0(e,crops,'ENERGY')   =   cost_share_crops(e,crops,'ENERGY')  * 0.6 * (el_area0(e,crops,crops) + elastyd(e,crops,crops));
el_area0(e,crops,'INTERMED') =   cost_share_crops(e,crops,'INTERMED')* 0.6 * (el_area0(e,crops,crops) + elastyd(e,crops,crops));
el_area0(e,crops,'LAND')     =   cost_share_crops(e,crops,'LAND')    * 0.6 * (el_area0(e,crops,crops) + elastyd(e,crops,crops));
****0.6 indicates a facotr represents scaling down of the total cost of output values


* combined elasticity of yield - not sensitive to land price or cross prices: input prices must be homogeneous with own price
elast_y_l(e,crops) = - elastyd(e,crops,crops) * cost_share_crops(e,crops,'LABOR')    /(1-cost_share_crops(e,crops,'LAND'));
elast_y_c(e,crops) = - elastyd(e,crops,crops) * cost_share_crops(e,crops,'CAPITAL')  /(1-cost_share_crops(e,crops,'LAND'));
elast_y_f(e,crops) = - elastyd(e,crops,crops) * cost_share_crops(e,crops,'FERTIL')   /(1-cost_share_crops(e,crops,'LAND'));
elast_y_e(e,crops) = - elastyd(e,crops,crops) * cost_share_crops(e,crops,'ENERGY')   /(1-cost_share_crops(e,crops,'LAND'));
elast_y_i(e,crops) = - elastyd(e,crops,crops) * cost_share_crops(e,crops,'INTERMED') /(1-cost_share_crops(e,crops,'LAND'));

el_area0(e,crops,'LABOR')    = - el_area0(e,crops,'LABOR')    - elast_y_l(e,crops);
el_area0(e,crops,'CAPITAL')  = - el_area0(e,crops,'CAPITAL')  - elast_y_c(e,crops);
el_area0(e,crops,'FERTIL')   = - el_area0(e,crops,'FERTIL')   - elast_y_f(e,crops);
el_area0(e,crops,'ENERGY')   = - el_area0(e,crops,'ENERGY')   - elast_y_e(e,crops);
el_area0(e,crops,'INTERMED') = - el_area0(e,crops,'INTERMED') - elast_y_i(e,crops);
el_area0(e,crops,'LAND')     = - el_area0(e,crops,'LAND');

* Value Share of Malta for Fodder requires input and factor price elasticities to be increased, otherwise homgeneity cannot be reached.
el_area0('MT','FODDER','LABOR')    = el_area0('MT','FODDER','LABOR')   * 1.8;
el_area0('MT','FODDER','CAPITAL')  = el_area0('MT','FODDER','CAPITAL') * 1.8;
el_area0('MT','FODDER','FERTIL')   = el_area0('MT','FODDER','FERTIL')  * 1.8;
el_area0('MT','FODDER','ENERGY')   = el_area0('MT','FODDER','ENERGY')  * 1.8;
el_area0('MT','FODDER','INTERMED') = el_area0('MT','FODDER','INTERMED')* 1.8;
el_area0('MT','FODDER','LAND')     = el_area0('MT','FODDER','LAND')    * 1.8;

* Animal Supply Elasticities are detemined exogeneously


el_area0(e,livest,livest1)$(ord(livest) ne ord(livest1))=  sigma(livest,livest1)*val_shr(e,livest1);



el_area0(e,livest,'LABOR')    =  - cost_share_livest(e,livest,'LABOR')    * sum(livest1,el_area0(e,livest,livest1));
el_area0(e,livest,'CAPITAL')  =  - cost_share_livest(e,livest,'CAPITAL')  * sum(livest1,el_area0(e,livest,livest1));
el_area0(e,livest,'ENERGY')   =  - cost_share_livest(e,livest,'ENERGY')   * sum(livest1,el_area0(e,livest,livest1));
el_area0(e,livest,'INTERMED') =  - cost_share_livest(e,livest,'INTERMED') * sum(livest1,el_area0(e,livest,livest1));
el_area0(e,livest,'FEED')     =  - cost_share_livest(e,livest,'FEED')     * sum(livest1,el_area0(e,livest,livest1));


display el_area0,elast_y_l;






parameter
vs(farm) value share
el(farm,j)   price elasticities
al(farm,farm1)   allen elasticities
ela(farm,farm1)  cross price Elasticity parameter
fact(c)                  storage for factor
allen1(c,farm,j)     storage for allen
elast1(c,farm,farm1)     storage for cross price elasticities
;


Variables
ALLEN(farm,farm1)
ELAST(farm,farm)
FACTOR
OMEGA
;

** First equation and solve block minimizing each country's matrice's
** aggregate deviation from homogeneity
set
non(farm)
/
GRAS
OTHER
/
;
Equation
SCALE(farm,farm)
A2E(farm,farm)
OBJ1
;
SCALE(crops,crops1)..  ALLEN(crops,crops1)=E= FACTOR * al(crops,crops1);
A2E(crops,crops1)..    ELAST(crops,crops1)=E= ALLEN(crops,crops1)*vs(crops1);
OBJ1.. OMEGA =E= abs(sum(crops,sum(crops1, ELAST(crops,crops1)) + sum(j,el(crops,j))));

model homog /all/;

sigma(farm,farm) = 0;
sigma0(farm,farm)= sigma(farm,farm);

display sigma;




loop
(e ,
if(ord(e) = 31,
sigma('rice',j)$(sigma('rice',j) eq 0)=  0.5* sigma('corn',j);
sigma(farm,'rice')$(sigma(farm,'rice')eq 0)=  0.5* sigma(farm,'corn');
sigma('corn','other')= -1.5;
);

vs(farm) =  val_shr(e,farm);
ALLEN.l(crops,crops1)=0;
ALLEN.l(crops,crops1)$(vs(crops) and vs(crops1)) = sigma(crops,crops1);
al(crops,crops1)=0;
al(crops,crops1)$(vs(crops) and vs(crops1)) = sigma(crops,crops1);
el(crops,j)=0;
el(crops,j)$(vs(crops)) = el_area0(e,crops,j);

solve homog using dnlp minimizing OMEGA;

sigma(farm,farm) = sigma0(farm,farm);
fact(e)    = FACTOR.l;
allen1(e,farm,farm1) = ALLEN.l(farm,farm1);
elast1(e,farm,farm1) = ELAST.l(farm,farm1);
);
** First block E N D **

el_area0(c,farm,j)$(val_shr(c,farm) eq 0) = 0;

display allen1,elast1,val_shr,vs,sigma;


display el_area0;






** Second block calibrating final elasticities **
set ot(farm)  Homogeneity only for included crops products
/
OTHER
/
;
Equations

HOMOGEN(crops)
ZERO1(crops)
SYMMETRY(crops,crops1)
NON_POS(crops,crops1)
OBJ2;

HOMOGEN(crops)$(not ot(crops)).. abs(sum(crops1, ELAST(crops,crops1)) + sum(j,el(crops,j)))=L= .0001;

ZERO1(crops)..           ALLEN(crops,crops) =E= 0;

SYMMETRY(crops,crops1).. ALLEN(crops,crops1)  =E= ALLEN(crops1,crops) ;

NON_POS(crops,crops1).. ALLEN(crops,crops1) =L= 0;


OBJ2.. OMEGA =E= log(1 + sum(crops,sum(crops1$ela(crops,crops1), (ELAST(crops,crops1)- ela(crops,crops1))/ela(crops,crops1)
                                       *(ELAST(crops,crops1)- ela(crops,crops1))/ela(crops,crops1)))
                     ) ;

model calib /A2E, HOMOGEN, SYMMETRY, NON_POS, ZERO1, OBJ2/;

loop
(e ,
ALLEN.up(farm,farm1)= + inf;
ALLEN.lo(farm,farm1)= - inf;
ALLEN.l(farm,farm1)= allen1(e,farm,farm1);
ALLEN.fx(farm,farm1)$(allen1(e,farm,farm1) eq 0 and not non(farm))=0;
ELAST.l(farm,farm1) = elast1(e,farm,farm1);
vs(farm) =  val_shr(e,farm);
ela(farm,farm1) = elast1(e,farm,farm1);
el(crops,j) = el_area0(e,crops,j);
OMEGA.l = 1;

solve calib using dnlp minimizing OMEGA;

allen1(e,farm,j) = 0;
allen1(e,crops,crops1) = ALLEN.l(crops,crops1);
allen1(e,livest,livest1)= sigma(livest,livest1);
el_area0(e,crops,crops1)$(ord(crops) ne ord(crops1))=  ELAST.l(crops,crops1);
)
;
** Second block E N D **

display el_area0,val_shr,elast1,allen1,ELAST.l;

*execute_unload 'Supply_elast_20.gdx' el_area0,allen1
execute_unload '..\Data_GDX\Supply_elast_40.gdx'
el_area0
allen1
elast_y_l
elast_y_c
elast_y_f
elast_y_e
elast_y_i
elastyd
val_shr;
