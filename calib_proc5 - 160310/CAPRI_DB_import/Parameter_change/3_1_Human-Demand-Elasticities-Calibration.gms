$include "3_Human-Demand-Elasticities-declarations.gms"


parameters
hdem0(c,i)
price0(c,i)
allena(i,j)      starting values for allen elasticities of human demand
own(c,i)         starting values for own price elasticities of human demand
inc(c,i)         starting values for income elasticities of demand
value_shr(i,c)   value share of ESIM product in household consumption
;

$GDXin ..\Data_Price_GDX\data_prices_new
$load price0=PD00
$GDXin

$GDXin ..\Data_GDX\data_capri.gdx
$load hdem0=hdem0
$GDXin


display hdem0;

price0(c,'OTHDAIRY')=0;
price0(c,'PULS')=0;
***this is same as in 1_1_price_change.gms file
price0(c,'OTHDAIRY')$(hdem0(c,'OTHDAIRY'))
 = price0(c,'SMP')*3
;

price0(c,'PULS')$(hdem0(c,'PULS'))
 = price0(c,'OPROT')
;



parameter
HH_EXP(c)       Total Household Expenditure in domestic currency - preliminary parameter
/
AT        139594.1082
BE        180299.9946
BG        34956.22262
HR        173816.4355
CY        9658.72931
CZ        1609048.075
DK        790459.2794
EE        111665.4046
FI        86437.78183
FR        1029264.784
GE        1347841.174
GR        154642.143
HU        12598969.85
IE        83142.4481
IT        872055.667
LV        6725.317049
LT        54444.6322
MT        3206.915316
NL        256671.8236
PL        675682.8509
PT        101864.5929
RO        234259.7797
SK        992047.4022
SI        16762.76292
ES        566684.5113
SW        1361996.412
TU        528597.5724
UK        850958.7682
US        9260682.744
ROW       12459930.78
WB        60721.50176
/
;
$libinclude xlimport allena excel_data\HDEM.xls start_allen
$libinclude xlimport inc    excel_data\HDEM.xls start_inc
$libinclude xlimport own    excel_data\HDEM.xls start_own

display allena,inc,own;

allena(i,'WHEY')=0;
allena('WHEY',j)=0;


****************************
*****(HS) in initial value assigment, new values added for HR, WB and for Puls ****
****************************


value_shr(i,c) = hdem0(c,i)*price0(c,i)/1000/HH_EXP(c);
value_shr("OTHER",c) = 1 - sum(i,value_shr(i,c));

display value_shr,price0,HH_EXP;




*display price;

parameter
sigma(c,i,j)     Country specific allen elasticities of human demand
own2(i)          Check parameter for own price elasticity
*storage parameters

stor_inc(c,i)    Storage parameter for income elasticity
st_allen(c,i,j)  Storage parameter for allen elasticity
st_price(c,i,j)  Storage parameter for price elasticity
stor_val(c,i)    Storage parameter for value share
* parameters for starting values within solve
etafx(i)         Start value for income elasticity
val_shr(i)       Value Share
epsilon(i,j)     Start value for price elasticity
;


own(c,i)$(value_shr(i,c) eq 0) = 0;

Variables
FACTOR   Scaling factor for cross price elasticities
ALLEN(i,j)       Allen's elasticity of human demand
ELAST(i,j)       Price elasticity of human demand
ETA(i)           Income elasticity of human demand
OMEGA            Variable of objective function
;

Equations
SCALE
ELAST2ALL(i,j)
ETA_ZERO(i)
ELAST_ZERO(i,j)
TARGET
;

*******ETA: income elasticity of humand demand

****(HS) cross price elasticity initial value calculation with a scaling factor

SCALE(i,j)$(ord(i) ne ord(j))..  ALLEN(i,j) =E= FACTOR * allena(i,j);

ELAST2ALL(i,j)$(ord(i) ne ord(j))..    ELAST(i,j) =E= (ALLEN(i,j) - ETA(i))*val_shr(j);

TARGET..         OMEGA =E= sum(i$own2(i),(sum(j,ELAST(i,j)) + ETA(i))*(sum(j,ELAST(i,j)) + ETA(i)));
;

model Homogeneuos /

                   SCALE
                   ELAST2ALL
                   TARGET
                  /
;



loop(c,

own2(i)$(value_shr(i,c) gt 0) = own(c,i);

ALLEN.l(i,j) = allena(i,j);

ELAST.l(i,j) = (allena(i,j)-inc(c,i)) * value_shr(j,c);

ELAST.fx(i,i) = own(c,i);

*ELAST.l(i,"OTHER") =    (allena(i,"OTHER")-inc(c,i)) * value_shr("OTHER",c);

val_shr(i) = value_shr(i,c);

ETA.fx(i) = inc(c,i);

solve Homogeneuos using dnlp minimizing OMEGA;

sigma(c,i,j) = ALLEN.l(i,j);

)


display sigma,allena,own,inc,value_shr,FACTOR.l;

display ELAST.l;






********************************************************************************

********************************************************************************

********************************************************************************

********************************************************************************

********************************************************************************


Equations
ELAST2ALLEN(i,j)
HOMOGENEITY(i)
SYMMETRY(i,j)
ADDING_UP
NON_NEGAT(i,j)
NON_POSIT(i,i)
ZERO(i,j)        Elasticities which have zero value shares for i and j are zero
OBJ              Objective function
OBJ_ADDING_UP
;

ELAST2ALLEN(i,j)..     ELAST(i,j) =E= (ALLEN(i,j) - ETA(i))*val_shr(j);


HOMOGENEITY(i)$own2(i).. abs(sum(j,ELAST(i,j)) + ETA(i)) =L= 0.0001;


SYMMETRY(i,j)..        ALLEN(i,j) =E= ALLEN(j,i);



NON_NEGAT(i,j)$(ord(i) ne ord(j))..    ALLEN(i,j) =G= 0;


NON_POSIT(i,i)..       ALLEN(i,i) =L= 0;

ZERO(i,j)$(val_shr(i) eq 0)..     ALLEN(i,j) =E= 0;

OBJ..                 OMEGA =e= log(1+
                                 SUM((i,j)$epsilon(i,j),
                                     (ELAST(i,j)- epsilon(i,j))/epsilon(i,j)*
                                     (ELAST(i,j)- epsilon(i,j))/epsilon(i,j))
                            + 3*   SUM(i$epsilon(i,i),
                                     (ELAST(i,i)- epsilon(i,i))/epsilon(i,i)*
                                     (ELAST(i,i)- epsilon(i,i))/epsilon(i,i))

                            + 4* SUM(i$val_shr(i),
                                     (ETA(i) - etafx(i))/etafx(i)*
                                     (ETA(i) - etafx(i))/etafx(i))
                                 );

ADDING_UP..           abs(1-sum(i,ETA(i)* val_shr(i))) =L= 0.00000001;

OBJ_ADDING_UP..          OMEGA =E=  SUM(i$etafx(i),
                                     (ETA(i) - etafx(i))/etafx(i)*
                                     (ETA(i) - etafx(i))/etafx(i)
                                         );

*providing for adding-up condition


model addup
/
ADDING_UP
OBJ_ADDING_UP
/;
*****income elasticity calibration with respect to the value share factor

loop(c,
ETA.lo(i) = -INF;
ETA.up(i) = +INF;
ETA.l(i)         = inc(c,i);

etafx(i)      = inc(c,i);
val_shr(i)    = value_shr(i,c);
solve addup using dnlp minimizing OMEGA;
inc(c,i) = ETA.l(i);
);
display inc;





model human
            /
            ELAST2ALLEN
            HOMOGENEITY
            SYMMETRY
            ADDING_UP
            NON_NEGAT
            NON_POSIT
*            ZERO
            OBJ
            /
;




loop
*(c,
(c,
* $sameas(d,'HR'),
ETA.lo(i) = -INF;
ETA.up(i) = +INF;
ELAST.lo(i,i) = -INF;
ELAST.up(i,i) = +INF;
*Stephan
ALLEN.up(i,j) = +inf;
ALLEN.lo(i,j) = -inf;
ALLEN.fx(i,j)$(not value_shr(i,c) or not value_shr(i,c)) = 0;
*Stephan END
ALLEN.l(i,j)=0;
ALLEN.l(i,i)=0;
ELAST.l(i,j)=0;
ELAST.l(i,i)=0;
epsilon(i,j)=0;
epsilon(i,i)=0;
ETA.l(i)=0;
etafx(i)=0;
val_shr(i)=0;
own2(i)=0;


***cross pricess elasticity from the previous runs (sigma)
ALLEN.l(i,j)     = sigma(c,i,j);
ALLEN.l(i,i)$value_shr(i,c)    = own(c,i)/ value_shr(i,c) + inc(c,i);

*stephan2
ALLEN.l(i,i)$(not value_shr(i,c))     = 0;
*Stephan2 end

ELAST.l(i,j)     = (sigma(c,i,j)-inc(c,i)) * value_shr(j,c);
epsilon(i,j)  = (sigma(c,i,j)-inc(c,i)) * value_shr(j,c);
ELAST.l(i,i)  = own(c,i);
epsilon(i,i)  = own(c,i);

ETA.l(i)      = inc(c,i);
etafx(i)      = inc(c,i);
val_shr(i)    = value_shr(i,c);
own2(i)$(value_shr(i,c) gt 0) = own(c,i);

display allen.l,sigma,own,value_shr;

*display ALLEN.l,ELAST.l,ETA.l,epsilon,sigma,own,inc,value_shr,etafx;

solve human using dnlp minimizing OMEGA;

stor_inc(c,i)$value_shr(i,c)   =  ETA.l(i);
st_allen(c,i,j) =  ALLEN.l(i,j);
st_price(c,i,j)$value_shr(i,c) =  ELAST.l(i,j);
stor_val(c,i)   =  value_shr(i,c);
)
;


display stor_inc;

execute_UNLOAD '..\Data_GDX\HUM-DEM-RES.gdx',stor_inc,st_allen,st_price,epsilon,stor_val,sigma;
