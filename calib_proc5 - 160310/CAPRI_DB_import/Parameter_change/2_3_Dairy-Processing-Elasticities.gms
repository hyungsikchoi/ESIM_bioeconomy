Set
c        countries and regions
/
GE
AT
BE
DK
FI
FR
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
d        dairy products
/
MILK

SMP
WMP
CREAM
CONC_MLK
ACID_MLK
WHEY
CMILK
BUTTER
CHEESE
OTHDAIRY

PROTEIN
FAT
INTERMED
/

i(d)     input components
/
PROTEIN
FAT
INTERMED
/

in(d)
/
PROTEIN
FAT
/

z(d)     endproducts
/
SMP
WMP
CREAM
CONC_MLK
*ACID_MLK
WHEY
CMILK
BUTTER
CHEESE
OTHDAIRY
/
;
Alias (i,j),(d,dd),(c,cc);

parameter
price(c,d)        price for dairy products and inputs
supply(c,d)       supply of milk and milk components and final dairy products
dairy_pdem(z,i,c) processing demand for components by endproducts - used to calculate input coefficients
coeff(c,i,z)      coefficients of input use in dairy products
profit(c,z)       price minus input costs and intermediates
val_shr(c,z,i)    value share of inputs
beta(c,z)         parameter of quadratic cost function for dairy supply
d_supply(c,z)     increase of supply as a response to a 0.01 percent increase in own price
own(c,z)          own price elasticity of dairy supply
elast(c,i,z)      elasticity of dairy supply w.r.t input prices
elasticity(c,*,z) elasticity of milk component demand with respect to input and output prices
;

****Price after logistic fuction calibration
$GDXin ..\Data_Price_GDX\data_prices_new
$load price=PD00
$GDXin

$GDXin ..\Data_GDX\data_capri
$load supply=prod0
$GDXin

$GDXin ..\Data_GDX\CapriProcess
$load dairy_pdem=CapriProcess_export
$GDXin
;

*****
display dairy_pdem,supply;

Parameter check(c,*,*);

check(c,z,'PROTEIN')
 = supply(c,z);

check(c,z,'PROTEIN')
 = dairy_pdem(z,'PROTEIN',c)* supply(c,z);

display check;



display price;

*********************************
****Price change for OTHDAIRY****
*********************************

$ontext
price('AT','OTHDAIRY')
 = 7285;

price('GE','OTHDAIRY')
 = price('AT','OTHDAIRY');

price('FI','OTHDAIRY')
 = price('AT','OTHDAIRY');

price('IE','OTHDAIRY')
 = price('AT','OTHDAIRY');

price('NL','OTHDAIRY')
 = price('AT','OTHDAIRY');

price('FR','OTHDAIRY')
 = price('AT','OTHDAIRY');

price('IT','OTHDAIRY')
 = price('AT','OTHDAIRY');

price('LT','OTHDAIRY')
 = price('AT','OTHDAIRY');

price('GR','OTHDAIRY')
 = price('AT','OTHDAIRY');

price('PT','OTHDAIRY')=0;
price('ES','OTHDAIRY')=0;
price('SW','OTHDAIRY')=0;
price('SI','OTHDAIRY')=0;
price('HU','OTHDAIRY')=0;
price('HR','OTHDAIRY')=0;

price('DK','OTHDAIRY')
 = price('DK','CMILK')*price('AT','CMILK')*price('AT','OTHDAIRY');

price('CZ','OTHDAIRY')
 = price('CZ','CMILK')*price('AT','CMILK')*price('AT','OTHDAIRY');

price('MT','OTHDAIRY')
 = price('MT','CMILK')*price('AT','CMILK')*price('AT','OTHDAIRY');


price('UK','OTHDAIRY')
 = price('UK','CMILK')*price('AT','CMILK')*price('AT','OTHDAIRY');

price('LV','OTHDAIRY')
 = price('LV','CMILK')*price('AT','CMILK')*price('AT','OTHDAIRY');
$offtext


*price(c,'OTHDAIRY')$ (not supply(c,'OTHDAIRY'))
* = 0;

*price(c,'OTHDAIRY')$supply(c,'OTHDAIRY')
* = price(c,'SMP')*3;


***milk product price check
*price(c,'CMILK')
* =price(c,'CMILK')* 8645/price('GE','CMILK');

***cheese price chekc!!!
*price(c,'CHEESE')
* =price(c,'CHEESE')* 3700/price('GE','CHEESE');


*display price;

*price(c,'FAT')
* =price(c,'FAT')*0.8;

*price(c,'PROTEIN')
* =price(c,'PROTEIN')*0.7;

display price;

***(HS) coeff indicates fat or protein content in unit end diary product
*coeff(c,i,z)$supply(c,i) =  dairy_pdem(z,i,c)*supply(c,z)*0.01/supply(c,i);

display dairy_pdem, supply;

coeff(c,i,z)$supply(c,z) =  dairy_pdem(z,i,c)/supply(c,z);

coeff(c,'INTERMED',z) = price(c,z) * 0.2;
***assume 20% of intermediate cost in total price
price(c,'INTERMED') = 1;
;


display coeff;

val_shr(c,z,i)$supply(c,z) = coeff(c,i,z) * price(c,i)/price(c,z);

display supply,val_shr;



* recalculation of value share of intermediates (=per unit processing costs other than profits) in case value shares add up to more than 97.5%
*val_shr(c,z,'INTERMED') = MAX(0,MIN(0.2,.975-val_shr(c,z,'FAT')-val_shr(c,z,'PROTEIN')));
val_shr(c,z,'INTERMED') = MAX(0,MIN(0.2,.8-val_shr(c,z,'FAT')-val_shr(c,z,'PROTEIN')));

coeff(c,'INTERMED',z) = val_shr(c,z,'INTERMED');

coeff(c,i,z)$(coeff(c,i,z) gt 0.5)=0.5;

coeff('BG',i,z)$(coeff('BG',i,z) gt 0.4)=0.4;

*recalculation END

profit(c,z)$ (supply(c,z)) = price(c,z) - sum(i,coeff(c,i,z) * price(c,i));

display coeff,val_shr,profit;


parameter dddd(c,z,*);


dddd(c,z,i) =  coeff(c,i,z) * price(c,i);
dddd(c,z,'p') =  price(c,z);

display dddd;

*$exit




parameter
Procheck(c,i,z)
;


Procheck(c,i,z)
 = coeff(c,i,z) * price(c,i);

display Procheck;

*profit('CY','BUTTER') = profit('GE','BUTTER')/price('GE','BUTTER')*price('CY','BUTTER');
*val_shr('CY','BUTTER',i) = val_shr('GE','BUTTER',i);
beta(c,z)$supply(c,z) = profit(c,z) / supply(c,z);

d_supply(c,z)$supply(c,z) =  (price(c,z)*1.0001 - sum (i,coeff(c,i,z) * price(c,i)))/beta(c,z);



display d_supply;


own(c,z)$supply(c,z) = (d_supply(c,z)/supply(c,z)-1) * 10000;
own(c,z) = own(c,z)**0.5;
elast(c,i,z)$supply(c,z) = - own(c,z) * val_shr(c,z,i);

elasticity(c,z,z)$supply(c,z)=own(c,z);
elasticity(c,i,z)$supply(c,z)=elast(c,i,z);
elasticity(c,'INTERMED',z)$supply(c,z)=elast(c,'INTERMED',z) -1;

elasticity('CY',z,z)$supply('CY',z)=own('GE',z);
elasticity('CY',i,z)$supply('CY',z)=elast('GE',i,z);
elasticity('CY','INTERMED',z)$supply('CY',z)=elasticity('AT','INTERMED',z);

display own,elast;


parameter
dairy_el(c,z,i,*)        Elasticity of processing demand for fat and protein per dairy product
;
dairy_el(c,z,'FAT',i) =  elasticity(c,i,z);
dairy_el(c,z,'PROTEIN',i) =  elasticity(c,i,z);
dairy_el(c,z,'FAT',z) =  elasticity(c,z,z);
dairy_el(c,z,'PROTEIN',z) =  elasticity(c,z,z);

display dairy_el;

set
subst (z)        products where the relation between fat and protein is not fix and thus a positive cross price elasticity of input demand is necessary
/
CHEESE
*OTHDAIRY
/
;
dairy_el(c,subst,'PROTEIN','PROTEIN')$supply(c,subst) =  elasticity(c,'PROTEIN',subst) * 1.058615742;
dairy_el(c,subst,'PROTEIN','FAT')$supply(c,subst) =  - dairy_el(c,subst,'PROTEIN',subst) - dairy_el(c,subst,'PROTEIN','PROTEIN') - dairy_el(c,subst,'PROTEIN','INTERMED');
dairy_el(c,subst,'FAT','PROTEIN')$supply(c,subst) =  dairy_el(c,subst,'PROTEIN','FAT') *(coeff(c,'PROTEIN',subst) * price(c,'PROTEIN')) /(coeff(c,'FAT',subst) * price(c,'FAT'));
dairy_el(c,subst,'FAT','FAT')$supply(c,subst) =  - dairy_el(c,subst,'FAT',subst) - dairy_el(c,subst,'FAT','PROTEIN') - dairy_el(c,subst,'FAT','INTERMED');

display dairy_el;

execute_unload '..\Data_GDX\dairy_el.gdx', dairy_el, profit val_shr;
