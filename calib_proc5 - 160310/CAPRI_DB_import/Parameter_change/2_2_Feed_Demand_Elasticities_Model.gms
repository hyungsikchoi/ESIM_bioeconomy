$include "2_Feed-Rates-Declarations.gms"
;

parameters
pd(c,f)          wholesale price for compund feed
frate(c,f,l)     feed rate
vsh(c,l,f)        value share
v_rough(c)       value of roughages in milk production
*        v_rough is used to infer the value and thus the price of roughage feed
;

$GDXin ..\Data_Price_GDX\data_prices_new
$load pd=PD00
$GDXin
;
$GDXin ..\Data_GDX\frates_calc.gdx
$load frate
$GDXin
;

display frate;

display pd;


parameter

min_comp_dairy(c)        minimum requirement for compound feed in per cent of dry matter in ration - dependant on milk yield per cow
* Feed_Rates_Suppl_Data.xls Milk (currently J37:J69)
/
AT        0.246469103
BE        0.229910541
BG        0.059949594
CY        0.264667516
CZ        0.300616738
DK        0.430278263
EE        0.275521278
FI        0.38947712
FR        0.269601044
GE        0.312499245
GR        0.073570583
HU        0.302790457
IE        0.166459396
IT        0.245808827
LT        0.153152471
LV        0.138487899
MT        0.190113128
NL        0.377673747
PL        0.131222382
PT        0.257132448
RO        0.061470456
SK        0.232355998
SI        0.220597138
ES        0.3191762
SW        0.41314569
TU        0.01
UK        0.336402745
HR        0.069490222
WB        0.01
US        0.485150471
ROW       0.01
/;


*value of roughage proportion of feed is determined by maximum share of
* roughages ( = 1 - minimum share compound feed).
* This way exessive waste does not lead to exessive value shares in feed demand
* nor in area demand. On the other hand, those values are inflated where a
* roughage shares are lower than they should be, e.g. in GR, TU and MT


***(HS)Price for new products



v_rough(c) = sum(co,frate(c,co,'MILK')*pd(c,co)) / min_comp_dairy(c) * (1-min_comp_dairy(c));
* For ROW and WB, the wirsenius et al shares are applied: 64% is supposed to be roughage
v_rough('ROW') = sum(co,frate('ROW',co,'MILK')*pd('ROW',co)) / .36 * .64;
v_rough('WB')  = sum(co,frate('WB',co,'MILK')*pd('WB',co)) / .36 * .64;
* The feed energy suposed to be provided by roughages is assessed at a value of
* two thirds that of compound feed per energy unit (in our case: dry matter)

***hyungsik, prices for energy follows previous values and prices for silage maze in turkey added.
*pd(c,ro) = v_rough(c)/sum(rr,frate(c,rr,'MILK'))*.666;

vsh(c,l,f)$sum(ff,frate(c,f,l)  * pd(c,f)) = frate(c,f,l) * pd(c,f)/sum(ff,frate(c,ff,l)  * pd(c,ff));

*execute_unload 'please_delete.gdx' , v_rough, pd, vsh;


display pd,vsh;


*$stop
*;
set
eu_15(e)
/
AT
BE
DK
ES
FI
FR
GE
GR
IE
IT
NL
PT
SW
UK
/
;

*****Protein : Energy ratio check the excel file for the calculation

Table ep_(f,l)   Protein:Energy Ratio

              POULTRY       PORK          BEEF          MILK        SHEEP
CWHEAT        0.9520        0.8623        0.9591        1.4819      0.0156
BARLEY        0.8571        0.7805        0.8423        1.2276      0.0130
CORN          0.7037        0.6884        0.7394        1.1337      0.0119
RYE           0.8509        0.7348        0.8259        1.2831      0.0134
OTHGRA        1.0392        0.9464        1.0384        1.6641      0.0171
POTATO        0.6066        0.6271        0.7766        1.0734      0.0110
SOYBEAN       2.3958        1.9731        2.3456        4.0110      0.0387
SOYMEAL       3.9554        3.2574        3.8724        6.6218      0.0662
RAPMEAL       4.5977        3.1504        3.6697        6.1168      0.0609
SUNMEAL       4.5073        2.9328        3.5976        5.9354      0.0577
SUNSEED       1.3054        0.9982        1.1993        2.0261      0.0189
*MANIOC        0.2273        0.2174        0.2308        0.3488      0.0035
GLUTFD        2.4198        1.9216        1.7422        2.8824      0.0295
OENERGY       0.8571        0.7805        0.8423        1.2276      0.0130
OPROT         4.5977        3.1504        3.6697        6.1168      0.0609
SMAIZE                      0.9449        0.7479        1.3376      0.0137
SMP           2.4524        1.9808        2.4532        3.9114      0.0457
FODDER                      1.7114        1.1905        2.2870      0.0235
GRAS                        2.3143        2.2727        3.3471      0.0342

***New CAPRI
RICE         0.8571        0.7805        0.8423        1.2276      0.0130
SUGAR        0.7037        0.6884        0.7394        1.1337      0.0119
PULS         2.3958        1.9731        2.3456        4.0110      0.0387
STRA                       0.7805        0.8423        1.2276      0.0130
OTHDAIRY     2.4524        1.9808        2.4532        3.9114      0.0457
RAPOIL       4.5977        3.1504        3.6697        6.1168      0.0609
SUNOIL       4.5977        3.1504        3.6697        6.1168      0.0609
SOYOIL       4.5977        3.1504        3.6697        6.1168      0.0609
FENE         0.7805        0.7805        0.8423        1.2276      0.0130
*stra=gras, puls=soybean,RICE=barley,Sugar=corn, CASE=SMP
;



Parameters
ep(l,f,ff)               Relative Protein:Energy Ratio
ep_coeff2(l,f,ff)        Substutability coefficient for P:E ratio
ep_coeff3(l,f,ff)        Substutability coefficient for P:E ratio
ep_coeff(l,f,ff)         Substutability coefficient for P:E ratio
value_shr(f)             Value share
al(l,f,ff)               Preliminary allen elasticity of feed demand
el(l,f,ff)               Price elasticity of feed demand
p_al(f,ff)
p_el(f,ff)
p_all(c,l,f,ff)
p_elast(c,l,f,ff)
p_scale(c,l)                  scaling parameter
scale(c)

;

scale(c) = 1.1;
scale(e)$(eu_15(e)) =1.3;

***(HS)generating inverse PE ratio
ep(l,f,ff)$ep_(ff,l) = ep_(f,l)/ep_(ff,l);

ep("EGGS",f,ff)      = ep("POULTRY",f,ff);


***(HS)apply a log function to reduce the deviation values and take the absolute value
ep_coeff2(l,f,ff)$(ep(l,f,ff) gt 0)
                    = abs(log(ep(l,f,ff)));

***(HS)apply squre root to reduce the deviation again
ep_coeff3(l,f,ff)$(not sameas(f,ff))
                    = ep_coeff2(l,f,ff)**.5;


***(HS) change this because this oenergy, oprot is an old concept
***(HS)OENERGY,OPROT respectively take the mean of cross values of Barley, Rapemeal in eneary and protein group
*** because these have to be non-zero.

ep_coeff3(l,"BARLEY","OENERGY")= sum(en,ep_coeff3(l,"BARLEY",en))/sum(en,sign(ep_coeff3(l,"BARLEY",en)));
ep_coeff3(l,"RAPMEAL","OPROT") = sum(pr,ep_coeff3(l,"RAPMEAL",pr))/sum(pr,sign(ep_coeff3(l,"RAPMEAL",pr)));
ep_coeff3(l,"OENERGY","BARLEY")= ep_coeff3(l,"BARLEY","OENERGY");
ep_coeff3(l,"OPROT","RAPMEAL") = ep_coeff3(l,"RAPMEAL","OPROT");


ep_coeff(l,f,ff)$(ep_coeff3(l,f,ff) ne 0)
                   = 1/ep_coeff3(l,f,ff);
*****

***(HS)cutt off the value if it is greater than 6
ep_coeff(l,f,ff)$(ep_coeff(l,f,ff) gt 6)=6;


al(l,en,ee)=ep_coeff(l,en,ee);
al(l,pr,pp)=ep_coeff(l,pr,pp);
al(l,ro,rr)=ep_coeff(l,ro,rr);

***(HS)make allen elasticity lower between energy and protein feed stuff
al(l,en,pr)$ep_coeff(l,en,pr) = ep_coeff(l,en,pr)*  smin(ee$(not sameas(ee,en)),ep_coeff(l,en,ee))
                                                /smax(pp,ep_coeff(l,en,pp));

***(HS)make allen elasticity much lower between energy and roghage feed stuff by mulitplying 0.25
al(l,en,ro)$ep_coeff(l,en,ro) = 0.25* ep_coeff(l,en,ro)* smin(ee$( not sameas(ee,en)),ep_coeff(l,en,ee))
                                                   /smax(rr,ep_coeff(l,en,rr));


al(l,pr,en)$ep_coeff(l,pr,en) = ep_coeff(l,pr,en)* smin(pp$( not sameas(pp,pr)),ep_coeff(l,pr,pp))

                                                  /smax(ee,ep_coeff(l,pr,ee));

***(HS)make allen elasticity much lower between energy and protein feed stuff by mulitplying 0.25
al(l,pr,ro)$ep_coeff(l,pr,ro) = 0.25* ep_coeff(l,pr,ro)* smin(pp$( not sameas(pp,pr)),ep_coeff(l,pr,pp))
                                                      /smax(rr,ep_coeff(l,pr,rr));

***(HS)make allen elasticity much lower between roghage and energy feed stuff by mulitplying 0.25
al(l,ro,en)$ep_coeff(l,ro,en) = 0.25*ep_coeff(l,ro,en)*  smin(rr$( not sameas(rr,ro)),ep_coeff(l,ro,rr))
                                                  /smax(ee,ep_coeff(l,ro,ee));

***(HS)make allen elasticity much lower between roghage and protein feed stuff by mulitplying 0.25
al(l,ro,pr)$ep_coeff(l,ro,pr) = 0.25*ep_coeff(l,ro,pr)* smin(rr$( not sameas(rr,ro)),ep_coeff(l,ro,rr))
                                                  /smax(pp,ep_coeff(l,ro,pp));

display al,ep_coeff,ep_coeff3;



VARIABLES
ELAST(f,ff)    Price elasticity of feed demand
ALLEN(f,ff)    Allen elasticity of feed demand
OMEGA
SCALER
;



EQUATIONS
SYMMETRY(f,ff)
ALL2EL(f,ff)
HOMOGENEITY(f)
NON_NEGAT(f,ff)
NON_POSIT(f,f)
SCALEQ
OBJ
;
SYMMETRY(f,ff)..  ALLEN(f,ff) =E= ALLEN(ff,f);

ALL2EL(f,ff)..    ELAST(f,ff) =E= ALLEN(f,ff)* value_shr(ff);

HOMOGENEITY(f)$p_el(f,f)..  abs(sum(ff,ELAST(f,ff))) =L= 0.0001;

NON_NEGAT(f,ff)$(not sameas(f,ff)).. ALLEN(f,ff) =G= 0;

NON_POSIT(f,f)..  ALLEN(f,f) =L= 0;


SCALEQ..        OMEGA =E= sum(f, abs(sum(ff$(not sameas(ff,f)), SCALER* p_el(f,ff))+ p_el(f,f)) );


OBJ.. OMEGA =E= log(sum((f,ff)$(p_al(f,ff) and not sameas(ff,f)),
                     (ALLEN(f,ff)-p_al(f,ff)*SCALER)*(ALLEN(f,ff)-p_al(f,ff)*SCALER)/(p_al(f,ff)*p_al(f,ff)*SCALER*SCALER))/1000
              + 2*sum(f$p_al(f,f),(ALLEN(f,f)-p_al(f,f))*(ALLEN(f,f)-p_al(f,f))/(p_al(f,f)*p_al(f,f)))/1000)
;

model feedelast
/
SYMMETRY
ALL2EL
HOMOGENEITY
NON_NEGAT
NON_POSIT
OBJ
/
;

model scaling
/
SCALEQ
/
;

****** STORAGE **************
parameter
almilk(c,f,ff)
albeef(c,f,ff)
alsheep(c,f,ff)
alpork(c,f,ff)
alpoultry(c,f,ff)
aleggs(c,f,ff)
;

********(S.Nolte)Scaling the parameter to meet the homogeneity of the model, Scaler.l and p_scale

loop(c ,
*$(ord(c) le 27)
loop(
l,

value_shr(f)= vsh(c,l,f);

***setting the starting values of own price elasticity
**enery:energy -1.3
**protein:protein -.16
**roghage:roghage -0.6
**potato value   -0.8



if (ord(c) eq 1,
   al(l,en,en)$value_shr(en) = -1.3  / value_shr(en);

else
   al(l,en,en)$value_shr(en) = -1.3  / value_shr(en);
    );

al(l,pr,pr)$value_shr(pr) = -1.6/ value_shr(pr);
al(l,"POTATO","POTATO")$value_shr("POTATO") = -.8 / value_shr("POTATO");
al(l,ro,ro)$value_shr(ro) = -.6 / value_shr(ro);

el(l,f,ff)$value_shr(f) = al(l,f,ff)* value_shr(ff);

p_el(f,ff)=el(l,f,ff);
SCALER.lo = 0;
solve Scaling using dnlp minimizing OMEGA;

p_scale(c,l) = SCALER.l;
)
)
;




loop(c ,
*$(ord(c) le 27)
loop(
l,

SCALER.l = p_scale(c,l);

value_shr(f)= vsh(c,l,f);


if (ord(c) eq 1,
   al(l,en,en)$value_shr(en) = -1.3  / value_shr(en);
*** in this case, you can select a contry and chnage the parameter.
else
   al(l,en,en)$value_shr(en) = -1.3  / value_shr(en);
    );

al(l,pr,pr)$value_shr(pr) = -1.6/ value_shr(pr);
al(l,"POTATO","POTATO")$value_shr("POTATO") = -.8 / value_shr("POTATO");
****potato substition keep low -0.8
al(l,ro,ro)$value_shr(ro) = -.6 / value_shr(ro);

el(l,f,ff)$value_shr(f) = al(l,f,ff)* value_shr(ff);


ELAST.l(f,ff) =  el(l,f,ff)* SCALER.l;
ELAST.fx(f,"MILK") = 0;
***no substitutionbilty to Milk
ALLEN.l(f,ff)$value_shr(ff)  = el(l,f,ff)/value_shr(ff)* SCALER.l;
ALLEN.fx(f,"MILK") = 0;
*ALLEN.fx(f,f) = al(l,f,f);
*ELAST.fx(l,f,f) =  el(l,f,f);

p_el(f,ff) =  el(l,f,ff);
p_al(f,ff) =  al(l,f,ff);

display p_el,p_al,value_shr;

solve feedelast using dnlp minimizing OMEGA;

****(N.Stephan) Scaling of own price elasticities of cereals to around 1.2 for EU-15 and to 1 for CEC ******
*$ontext
el(l,f,ff) = ELAST.l(f,ff);


ELAST.l(f,ff)$(el(l,f,ff) ne 0) = scale(c) * ELAST.l(f,ff) /

(
(el(l,"CWHEAT","CWHEAT")+ el(l,"BARLEY","BARLEY")+ el(l,"CORN","CORN")+ el(l,"RYE","RYE")+ el(l,"OTHGRA","OTHGRA"))
/
((sign(el(l,"CWHEAT","CWHEAT"))+ sign(el(l,"BARLEY","BARLEY"))+ sign(el(l,"CORN","CORN"))+ sign(el(l,"RYE","RYE"))+sign(el(l,"OTHGRA","OTHGRA"))))
);

ALLEN.l(f,ff)$(el(l,f,ff) ne 0)= scale(c) * ALLEN.l(f,ff)/

(
(el(l,"CWHEAT","CWHEAT")+ el(l,"BARLEY","BARLEY")+ el(l,"CORN","CORN")+ el(l,"RYE","RYE")+ el(l,"OTHGRA","OTHGRA"))
/
((sign(el(l,"CWHEAT","CWHEAT"))+ sign(el(l,"BARLEY","BARLEY"))+ sign(el(l,"CORN","CORN"))+ sign(el(l,"RYE","RYE"))+sign(el(l,"OTHGRA","OTHGRA"))))
);

*$offtext
el(l,f,ff) = ELAST.l(f,ff);
;
p_all(c,l,f,ff)$(value_shr(f) and value_shr(ff))     =   ALLEN.l(f,ff)     ;

p_elast(c,l,f,ff) = el(l,f,ff);
)
;

almilk(c,f,ff)    =  p_all(c,"milk",f,ff)      ;
albeef(c,f,ff)    =  p_all(c,"beef",f,ff)      ;
alsheep(c,f,ff)   =  p_all(c,"sheep",f,ff)     ;
alpork(c,f,ff)    =  p_all(c,"pork",f,ff)      ;
alpoultry(c,f,ff) =  p_all(c,"poultry",f,ff)   ;
aleggs(c,f,ff)    =  p_all(c,"eggs",f,ff)      ;
)
;
************  L O O P  - END *******************
parameter
check_result(c,l,f,ff)
;
check_result(c,l,f,ff) = p_all(c,l,f,ff)* vsh(c,l,ff) - p_elast(c,l,f,ff);
*$include "Feed-Demand-Elasticities-Writing.gms"

execute_unload '..\Data_GDX\fdem_elast.gdx', vsh, p_all, p_elast, check_result,pd;
