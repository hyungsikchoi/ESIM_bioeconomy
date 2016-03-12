
$include "2_Feed-Rates-Declarations.gms"

parameter
supply(c,l)
f_dem(c,f)
f_int(c,f)      define definition for f_int
;

*$GDXin .\data\data_quantities
*$load supply=prod0 f_dem=fdem0
*$GDXin
*;

$GDXin ..\Data_GDX\data_capri.gdx
$load supply=prod0 f_dem=fdem0
$GDXin
;




display supply,f_dem;






Parameters
lf_combination(f,l)      possible combinations of compound feeds (=non roughages) and livestock types
DM(f)    Dry Matter content
* Feed_Rates_Suppl_Data.xls TQ
/
*cereal
BARLEY        0.886
CORN          0.879
CWHEAT        0.877
RYE           0.870
OTHGRA        0.880

*protein
RAPMEAL       0.889
SOYBEAN       0.912
SOYMEAL       0.888
SUNMEAL       0.901
GLUTFD        0.890
SMP           0.940
OPROT         0.889

*Other
POTATO        0.219
SUNSEED       0.928

*Energy

OENERGY       0.886
FENE          0.886


SMAIZE        1.000
GRAS          1.000
FODDER        1.000


MILK          0.134
*no use for feeding

**new feed from CAPRI
*DURUM         0.8
RICE          0.8
SUGAR         0.8
STRA          1.000
Whey          0.9
OTHDAIRY      0.9
RAPOIL        0.9
SUNOIL        0.9
SOYOIL        0.9
WMP           0.9
RAPSEED       0.928
CONC_MLK      0.5
PULS          0.9
/

dmr_all(l)       feed requirements in t dry matter per ton of animal product
* Feed_Rates_Suppl_Data.xls DM Requirements
/
BEEF        13.54
SHEEP       14.13
PORK         3.69
POULTRY      2.23
EGGS         2.46
/
dm_dairy(c)      feed requirements in t dry matter per ton of cow milk
* Feed_Rates_Suppl_Data.xls Milk (currently G37:G69)
/
AT        1.049
BE        1.064
BG        1.221
CY        1.032
CZ        0.999
DK        0.880
EE        1.022
FI        0.917
FR        1.028
GE        0.988
GR        1.209
HU        0.997
IE        1.123
IT        1.050
LT        1.135
LV        1.149
MT        1.101
NL        0.928
PL        1.156
PT        1.039
RO        1.220
SK        1.062
SI        1.073
ES        0.982
SW        0.895
TU        1.276
UK        0.966
HR        1.212
WB        1.289
US        0.829
ROW       1.352
/
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
/

dm_req(l)                dm requirements used in loop
min_comp_dairy2(c)       minimum amount of compound feed per ton of milk in DM

frate(c,f,l)   Feed Rate


table exog_feed(c,*) feed requirements by goats horses and other livestock not in the model in dry matter
          COMP        OENERGY        OPROT          ROUGH
AT          8.0          22.6          22.6          162.3
BE          3.2           9.1           9.1           65.0
BG         30.3          86.1          86.1          617.6
CY          5.2          68.1          68.1            0.0
CZ          3.4           9.5           9.5           68.5
DK          4.5          12.6          12.6           90.6
EE          0.5           1.3           1.3            9.4
FI          5.5          15.7          15.7          112.8
FR         64.6         183.3         183.3         1314.8
GE         47.5         134.8         134.8          966.6
GR         84.1         238.7         238.7         1711.7
HU          6.5          18.6          18.6          133.1
IE          7.9          22.3          22.3          160.2
IT         74.3         210.8         210.8         1512.0
LV          1.3           3.8           3.8           27.0
LT          5.2          14.8          14.8          105.8
MT          0.3           0.8           0.8            5.8
NL         14.9         193.3         193.3            0.0
PL         28.0          79.6          79.6          570.6
PT         21.6          61.4          61.4          440.4
RO         79.0         224.2         224.2         1607.8
SK          1.5           4.1           4.1           29.5
SI          1.9           5.5           5.5           39.3
ES         87.4         248.1         248.1         1779.1
SW          7.7          21.8          21.8          156.4
TU        133.9         379.9         379.9         2724.5
UK         32.2          91.4          91.4          655.8
HR          2.7           7.7           7.7           54.9
WB         36.6         103.9         103.9          745.2
US        807.7        2292.0        2292.0        16437.2
ROW     35930.1      101963.8      101963.8       731226.3
;

*** Caculation of feed from other animal sector than beef,pork,sheep etc
*** (co) is a set not including SMAIZE, GRASS, FODDER
*** unit is calculated based on wet mass content

$ontext
f_int(c,co) = (f_dem(c,co)*dm(co))/ sum(coco,f_dem(c,coco)*dm(coco)) * exog_feed(c,'COMP') / dm(co);

f_int(c,'OENERGY') = exog_feed(c,'OENERGY') / dm('OENERGY');
f_int(c,'OPROT') = exog_feed(c,'OPROT') / dm('OPROT');
* roughages are given in DM equivalents, therefore no correction for DM is necessary
f_int(c,'GRAS')$f_dem(c,'GRAS') = exog_feed(c,'ROUGH') * f_dem(c,'GRAS')/(f_dem(c,'GRAS') + f_dem(c,'FODDER'));
f_int(c,'FODDER')$f_dem(c,'FODDER') = exog_feed(c,'ROUGH') * f_dem(c,'FODDER')/(f_dem(c,'GRAS') + f_dem(c,'FODDER'));
* US, ROW, WB only have fodder as roughage feed, for which there is no data, but which is calculated from demand point of view further below
f_int(c,'GRAS')$(not e(c)) = 0;
f_int(c,'FODDER')$(not e(c)) = exog_feed(c,'ROUGH');

display f_int;
$offtext

*$exit

table lf_combination2(f,l)        possible combinations of  feeds and livestock types
               MILK     BEEF     SHEEP    PORK     POULTRY  EGGS
CWHEAT         1        1        0.5      1        1        1
BARLEY         1        1        0.5      1        1        1
CORN           1        1        0.5      1        1        1
RYE            1        1        0.5      1        1        1
OTHGRA         1        1        0.5      1        1        1
SOYMEAL        1        1        0.5      1        1        1
RAPMEAL        1        1        0.5      1        1        1
SUNMEAL        1        1        0.5      1        1        1
SOYBEAN        1        1        0.5      1        0        0
SUNSEED        1        1        0.5      1        0        0
POTATO         0        0        0        1        0        0
MILK           1        1        0        0        0        0
*MANIOC         1        1        0        1        1        1
GLUTFD         1        1        0        1        1        1
OENERGY        1        1        0.5      1        1        1
FENE           1        1        0.5      1        1        1
OPROT          1        1        0.5      1        1        1
SMAIZE         1        1        0.25     0        0        0
FODDER         1        1        1        0        0        0
GRAS           1        1        1        0        0        0
SMP            1        1        0        0        0        0

**CAPRI
DURUM          1        1         0.5     1        1        1
RICE           1        1         0.5     1        1        1
SUGAR          1        1         0.5     1        1        1
STRA           1        1         1       0        0        0
Whey           1        1         0.5     1        1        1
RAPOIL         1        1         0       1        1        1
SUNOIL         1        1         0       1        1        1
SOYOIL         1        1         0       1        1        1
WMP            1        1         0       1        1        1
RAPSEED        1        1         0.5     1        1        1
CONC_MLK       1        1         0       1        1        1
OTHDAIRY       1        1         0.5     1        1        1
PULS           1        1         0.5     1        1        1
;



dm_req(l) = dmr_all(l);
lf_combination(f,l) = lf_combination2(f,l) ;

min_comp_dairy2(c) = min_comp_dairy(c) * dm_dairy(c);


** Is enough feed available?

parameter
total_feed(c)   total available feed
total_nec(c)    total necessary feed
feed_balance(c) feed deficieny in DM
inefficiency(c) minimum ratio for available over necessary feed
* EU 15:  10% Waste
* US:     10%
* CEC10:  20%
* HR:     20%
* EU-2:   40%
/
AT       1.1
BE       1.1
BG       1.4
CY       1.4
CZ       1.2
DK       1.1
EE       1.2
FI       1.1
FR       1.1
GE       1.1
GR       1.1
HU       1.2
IE       1.1
IT       1.1
LT       1.2
LV       1.2
MT       1.4
NL       1.1
PL       1.2
PT       1.2
RO       1.4
SK       1.2
SI       1.2
ES       1.1
SW       1.1
TU       1.4
UK       1.1
HR       1.2
WB       1.4
US       1.1
ROW      1.4
/
first_balance(c)   first balance between availability and requirements (before adding OE and OP)
final_balance(c)   final balance between availability and requirements (after adding OE and OP)
comp_monogast(c)   after minimum compound feed for milk and other ruminant production is deducted is there enough compound feed left for monogastric livestock?
comp_deficit(c)    deficit of compound feed
addit_OE_OP(c)     additional other energy and other protein to compensate for deficit
;

*-------------------------------------------------*
* Impose OE/OP in order to satisfy 'inefficiency' *
*-------------------------------------------------*

*f_dem(c,'OENERGY') = 0;
*f_dem(c,'OPROT')   = 0;


* total feed available
total_feed(c) = sum(f,f_dem(c,f)*dm(f));
* total DM needs
total_nec(c) =  sum(l,dmr_all(l)* supply(c,l)) +  supply(c,'MILK')*dm_dairy(c);
* supply = total animal food supply
* total_nec= requried feed for beef,pig etc + feed for milk + other feed quantity


feed_balance(c) =  (inefficiency(c) - total_feed(c)/total_nec(c)) * total_nec(c);

display total_feed,total_nec,feed_balance;




*f_dem(c,'OENERGY')$(sameas(c,'BE')) = f_dem(c,'OENERGY')*3;
*f_dem(c,'OENERGY')$(sameas(c,'CY')) = f_dem(c,'OENERGY')*3;
*f_dem(c,'OENERGY')$(sameas(c,'MT')) = f_dem(c,'OENERGY')*1000;

*f_dem(c,'OThers')$(sameas(c,'MT')) = MAX(total_nec(c) * 0.15, feed_balance(c)/2) /0.886;
*f_dem(c,'OThers')$(sameas(c,'BE')) = MAX(total_nec(c) * 0.16, feed_balance(c)/2) /0.886;
*f_dem(c,'OThers')$(sameas(c,'AT') or sameas(c,'DK') or sameas(c,'GE') or sameas(c,'NL') or sameas(c,'UK') ) = MAX(total_nec(c) * 0.1, feed_balance(c)/2) /0.886;




display f_dem;

first_balance(c) = total_feed(c)/total_nec(c);
* recalculation
total_feed(c) = sum(f,f_dem(c,f)*dm(f));

final_balance(c) = total_feed(c)/total_nec(c);

display total_feed,first_balance,final_balance;

display f_dem;






parameter

en_pr(c,l) ratio of energy and protein compound feeds
waste(c,l) ratio of dm needs and total dm from FEED RATES
z          scalar for for-loop
comp_dairy(c)      compound feed assigned to dairy in the first round
extra_comp(c,l)    factor by which OE and OP need to be increased - as a share of total compound feed - in order to meet total requirements for compund feed
;


*-------------------------------------------*
*        for EU 27 and accession candidates *
*-------------------------------------------*
*pr('SMP') = no;
*pr('GLUTFD') = no;


*f_dem(c,'OENERGY') = MAX(f_dem(c,'OENERGY') , f_int(c,'OENERGY')+1);
*f_dem(c,'OPROT')   = MAX(f_dem(c,'OPROT')   , f_int(c,'OPROT'))+1;

* +1 is to aviod division by zero when in the 'Balance =! 0' steps

*********** set e:country, f: feed products  , l:livestock products

loop(e$(ord (e) le 29),
lf_combination(f,l) = lf_combination2(f,l);

dm_req(l) = dmr_all(l);
dm_req('MILK') = dm_dairy(e);

frate(e,f,l) = lf_combination(f,l);


* Waste =! 0:
frate(e,f,l)$sum(ff,frate(e,ff,l)) = frate(e,f,l) * dm_req(l)/sum(ff,frate(e,ff,l));

* Balance =! 0:
frate(e,f,l)$(sum(ll,frate(e,f,ll) * supply(e,ll))  and f_dem(e,f))
                     = frate(e,f,l) * (f_dem(e,f))/sum(ll,frate(e,f,ll) * supply(e,ll));

frate(c,f,l)$(not f_dem(c,f)) = 0;
**feedrate calcuation: total amount of feed - feed use for other animal etc hourse, goat


for
  (z = 1 to 10,

****E:Energy feed
****P:Protein feed

*             E-P Ratio of all available compoud feed      / current E-P Ratio for livestock category
en_pr(e,l)$sum(ff,frate(e,ff,l)) =
  (sum(en,(f_dem(e,en) )* dm(en))/sum(pr,(f_dem(e,pr))* dm(pr)))
  / (sum(en,frate(e,en,l) * dm(en))/sum(pr,frate(e,pr,l) * dm(pr)));
*display en_pr;

* E-P Ratio =! closer together for all livestock categories:
frate(e,en,l)$frate(e,en,l) = frate(e,en,l) * en_pr(e,l)**(0.5);
frate(e,pr,l)$frate(e,pr,l) = frate(e,pr,l) * en_pr(e,l)**(-0.5);

*display en_pr;

* Waste =! 0:
frate(e,f,l)$sum(ff,frate(e,ff,l)) = frate(e,f,l) * dm_req(l)/sum(ff,frate(e,ff,l)*dm(ff));

* Balance =! 0:
frate(e,f,l)$(sum(ll,frate(e,f,ll) * supply(e,ll)) and f_dem(e,f)) = frate(e,f,l) * (f_dem(e,f))/sum(ll,frate(e,f,ll) * supply(e,ll));
frate(c,f,l)$(not f_dem(c,f)) = 0;
*frate(c,f,l)$(frate(c,f,l) lt 0.001) = 0;
);

* Reporting Statistics

en_pr(e,l)$sum(ff,frate(e,ff,l))
= (sum(en,(f_dem(e,en))* dm(en))/sum(pr,(f_dem(e,pr))* dm(pr)))
/(sum(en,frate(e,en,l) * dm(en))/sum(pr,frate(e,pr,l) * dm(pr)));

*display en_pr;

waste(e,l)$supply(e,l)= dm_req(l)/sum(ff,frate(e,ff,l)*dm(ff));
comp_dairy(e)= sum(f$(not rou(f)), frate(e,f,'milk')*dm(f));
* rou = roughage feed
);




*f_dem(e,'OPROT') =   sum(l,frate(e,'OPROT',l) * supply(e,l));
*f_dem(e,'OENERGY') =   sum(l,frate(e,'OENERGY',l) * supply(e,l));
*f_dem(e,'OTHERS') =   sum(l,frate(e,'OTHERS',l) * supply(e,l));

parameter
check    Feed demand minus feed rates * supply - f_int: must be zero in order to be consistent!
waste2(e,l)
waste3(*,l)
;
check('balance',c,f) =  sum(ll,frate(c,f,ll) * supply(c,ll)) - f_dem(c,f) ;

check('balance',c,f) $(check('balance',c,f) lt 0.001) = 0;
*display check;

waste2(e,l)$(sameas(e,'BE'))= dm_req(l)/sum(ff,frate(e,ff,l)*dm(ff));

waste3(e,l)$(sameas(e,'BE'))
 = sum(ff,frate(e,ff,l)*dm(ff));

waste3('base',l)
 = dm_req(l);


*display waste2,waste3;



display en_pr,waste,comp_dairy,frate;







*--------------------------------------------------------------------------------------------------------------------------------------------------------*
* compound feed is increased for ruminants where needed, and if necessary FDEM of OPROT and OENERGY are increased if minimum requirements cannot be met. *
*--------------------------------------------------------------------------------------------------------------------------------------------------------*


set dairy_comp (e) countries for which the minimum amount of compound feed in dairy is not achieved
;

dairy_comp(e)$(comp_dairy(e) < min_comp_dairy2(e)) = yes;



display dairy_comp;


loop(dairy_comp,
lf_combination(co,l) = lf_combination2(co,l);

dm_req(l) = dmr_all(l);
dm_req('MILK') = dm_dairy(dairy_comp)* min_comp_dairy(dairy_comp) ;
dm_req('BEEF') = dm_req('BEEF')* min_comp_dairy(dairy_comp) * .8;
dm_req('SHEEP') = dm_req('SHEEP')* min_comp_dairy(dairy_comp) * .5 ;


frate(dairy_comp,co,l) = lf_combination(co,l);


* Waste =! 0:
frate(dairy_comp,co,l)$sum(coco,frate(dairy_comp,coco,l))
  = frate(dairy_comp,co,l) * dm_req(l)/sum(coco,frate(dairy_comp,coco,l));

* Balance =! 0:
frate(dairy_comp,co,l)$(supply(dairy_comp,l)  and f_dem(dairy_comp,co) and sum(ll,frate(dairy_comp,co,ll) * supply(dairy_comp,ll)))
 = frate(dairy_comp,co,l) * (f_dem(dairy_comp,co))/sum(ll,frate(dairy_comp,co,ll) * supply(dairy_comp,ll));

frate(c,f,l)$(not f_dem(c,f)) = 0;

for
  (z = 1 to 10,

*             E-P Ratio of all available compoud feed      / current E-P Ratio for livestock category
en_pr(dairy_comp,l)$sum(coco,frate(dairy_comp,coco,l)) =
  (sum(en,f_dem(dairy_comp,en) * dm(en))/sum(pr,f_dem(dairy_comp,pr) * dm(pr)))
    / (sum(en,frate(dairy_comp,en,l) * dm(en ))/sum(pr,frate(dairy_comp,pr,l) * dm(pr)));

* E-P Ratio =! closer together for all livestock categories:
***This code makes the frate paramter follow the E-P ratio in the available feed
***en_pr gt 1 and increases the energy ratio and decreases the protein ratio
***en_pr lt 1 and decreases the energy ratio and increases the protein ratio
frate(dairy_comp,en,l)$frate(dairy_comp,en,l) = frate(dairy_comp,en,l) * en_pr(dairy_comp,l)**(0.5);
frate(dairy_comp,pr,l)$frate(dairy_comp,pr,l) = frate(dairy_comp,pr,l) * en_pr(dairy_comp,l)**(-0.5);


* Waste =! 0:
frate(dairy_comp,co,l)$sum(coco,frate(dairy_comp,coco,l))
  = frate(dairy_comp,co,l) * dm_req(l)/sum(coco,frate(dairy_comp,coco,l)*dm(coco));

* Balance =! 0:
frate(dairy_comp,co,l)$(sum(ll,frate(dairy_comp,co,ll) * supply(dairy_comp,ll)) and f_dem(dairy_comp,co))
  = frate(dairy_comp,co,l) * (f_dem(dairy_comp,co))/sum(ll,frate(dairy_comp,co,ll) * supply(dairy_comp,ll));

frate(c,f,l)$(not f_dem(c,f)) = 0;
);

* Reporting Statistics
en_pr(dairy_comp,l)$sum(coco,frate(dairy_comp,coco,l))
 = (sum(en,f_dem(dairy_comp,en) * dm(en))/sum(pr,f_dem(dairy_comp,pr) * dm(pr)))
     / (sum(en,frate(dairy_comp,en,l) * dm(en))/sum(pr,frate(dairy_comp,pr,l) * dm(pr)));

waste(dairy_comp,l)$supply(dairy_comp,l) = dm_req(l)/sum(coco,frate(dairy_comp,coco,l)*dm(coco));
comp_dairy(dairy_comp) = sum(co$(not rou(co)), frate(dairy_comp,co,'milk')*dm(co));

* factor by which OE and OP must be increased to meet requirements for compound feed
*extra_comp(dairy_comp,l) =  (inefficiency(dairy_comp) * waste(dairy_comp,l) -1) * sum(coco,frate(dairy_comp,coco,l)*dm(coco))/2;

*frate(dairy_comp,'OENERGY',l) = frate(dairy_comp,'OENERGY',l) + MAX(0,extra_comp(dairy_comp,l)/dm('OENERGY'));
*frate(dairy_comp,'OPROT',l) = frate(dairy_comp,'OPROT',l) + MAX(0,extra_comp(dairy_comp,l)/dm('OPROT'));


* Reporting Statistics
en_pr(dairy_comp,l)$sum(coco,frate(dairy_comp,coco,l))
 = (sum(en,f_dem(dairy_comp,en) * dm(en))/sum(pr,f_dem(dairy_comp,pr) * dm(pr)))
     /(sum(en,frate(dairy_comp,en,l) * dm(en))/sum(pr,frate(dairy_comp,pr,l) * dm(pr)));

* This version of Waste only relates to compound feed
waste(dairy_comp,l)$supply(dairy_comp,l) = dm_req(l)/sum(coco,frate(dairy_comp,coco,l)*dm(coco));

* Final version of Waste also including roughages
dm_req(l) = dmr_all(l);
dm_req('MILK') = dm_dairy(dairy_comp);
   );

display comp_dairy;
display waste;


waste(e,l)$supply(e,l) = dm_req(l)/sum(ff,frate(e,ff,l)*dm(ff));

**STRAW change in frate should be corrected

f_dem(e,'STRA') =   sum(l,frate(e,'STRA',l) * supply(e,l));

check('balance',c,f) =  sum(ll,frate(c,f,ll) * supply(c,ll)) - f_dem(c,f) ;

check('balance',c,f) $(check('balance',c,f) lt 0.001) = 0;

display check,frate,waste;





*------------------------------------------------------------------------------------------------------------------------------------------*
* compound feed dairy - E N D                                                                                                              *
*------------------------------------------------------------------------------------------------------------------------------------------*




*--------------*
*  ROW,  US *
*--------------*

*For ROW and US, fodder, ONTERGY, OPROT are stimated
**GRAS      FODDER      SMAIZE  STRA are missing compared EU27
**here Fodder is used as an aggreated item for other energy

table non_comp_row(l,f)
* In order to infer the demand and supply of these feed products for WB, US & ROW
* Feed_Rates_Suppl_Data.xls ROW
* Source; Wirsenius et al. (2010), own calculations
*             OENERGY       OPROT         FODDER
*MILK         0.14          0.14          0.64
*BEEF         0.08          0.08          0.79
*SHEEP        0.10          0.10          0.75
*PORK         0.18          0.18          0.07
*POULTRY      0.12          0.12          0.00
*EGGS         0.12          0.12          0.00

            FODDER
MILK         0.64
BEEF         0.79
SHEEP        0.75
PORK         0.10
POULTRY      0.00
EGGS         0.00
;

parameter comp_row(l) 1 - sum of non_comp_row
/
*MILK         0.07
*BEEF         0.05
*SHEEP        0.04
*PORK         0.57
*POULTRY      0.77
*EGGS         0.77

MILK         0.36
BEEF         0.21
SHEEP        0.25
PORK         0.90
POULTRY      1.0
EGGS         1.0

/
comp_balance(c)  1 means the total available compound feed can provide the total feed needs indicated by comp_row(l)
;

non_comp_row(l,'OENERGY')=0;
non_comp_row(l,'OPROT')=0;



set vs(c) in order to impose minimum compound share for the US
/US/
;

**************************************
*******WB,ROW Frate calculation*******
**************************************

loop(c$(SAMEAS(C,'ROW')),

*f_dem(c,'OPROT')   = 0;
*f_dem(c,'OENERGY') = 0;
f_dem(c,'FODDER')  = 0;

lf_combination(f,l) = lf_combination2(f,l);
lf_combination('FODDER','PORK') = 1;

dm_req(l) = dmr_all(l)*comp_row(l);
dm_req('MILK') = dm_dairy(c)*comp_row('MILK');

frate(c,f,l) = lf_combination(f,l);
display  frate;

* Waste =! 0:
frate(c,f,l)$sum(ff,frate(c,ff,l)) = frate(c,f,l) * dm_req(l)/sum(ff,frate(c,ff,l));

* Balance =! 0:
frate(c,f,l)$(supply(c,l)  and f_dem(c,f) and sum(ll,frate(c,f,ll) * supply(c,ll)))
 = frate(c,f,l) * (f_dem(c,f))/sum(ll,frate(c,f,ll) * supply(c,ll));
frate(c,f,l)$(not f_dem(c,f)) = 0;

display  frate,f_dem;

for
  (z = 1 to 10,

*             E-P Ratio of all available compoud feed                 / current E-P Ratio for livestock category
en_pr(c,l)$sum(ff,frate(c,ff,l)) = (sum(en,f_dem(c,en) * dm(en))/sum(pr,f_dem(c,pr) * dm(pr)))/ (sum(en,frate(c,en,l) * dm(en))/sum(pr,frate(c,pr,l) * dm(pr)));

* E-P Ratio =! closer together for all livestock categories:
frate(c,en,l)$frate(c,en,l) = frate(c,en,l) * en_pr(c,l)**(0.5);
frate(c,pr,l)$frate(c,pr,l) = frate(c,pr,l) * en_pr(c,l)**(-0.5);


* Waste =! 0:
frate(c,f,l)$sum(ff,frate(c,ff,l)) = frate(c,f,l) * dm_req(l)/sum(ff,frate(c,ff,l)*dm(ff));

* Balance =! 0:
frate(c,f,l)$(supply(c,l) and f_dem(c,f) and sum(ll,frate(c,f,ll) * supply(c,ll)))
 = frate(c,f,l) * (f_dem(c,f))/sum(ll,frate(c,f,ll) * supply(c,ll));
frate(c,f,l)$(not f_dem(c,f)) = 0;
);

* Reporting Statistics
en_pr(c,l)$sum(ff,frate(c,ff,l))
 = (sum(en,f_dem(c,en) * dm(en))/sum(pr,f_dem(c,pr) * dm(pr)))
     / (sum(en,frate(c,en,l) * dm(en))/sum(pr,frate(c,pr,l) * dm(pr)));


comp_dairy(c) = sum(f$(not rou(f)), frate(c,f,'milk')*dm(f));

waste(c,l)$supply(c,l) = dm_req(l)/sum(ff,frate(c,ff,l)*dm(ff));

* factor by which OE and OP must be increased to meet requirements for compound feed
extra_comp(c,l) =  (inefficiency(c) * waste(c,l) -1) * sum(coco,frate(c,coco,l)*dm(coco))/3;
frate(c,'OENERGY',l) = frate(c,'OENERGY',l) + MAX(0,extra_comp(c,l)/dm('OENERGY'));
*frate(c,'OPROT',l) = frate(c,'OPROT',l) + MAX(0,extra_comp(c,l)/dm('OPROT'));


*display  frate,f_dem,f_int;
frate(c,f,l)$non_comp_row(l,f) =  non_comp_row(l,f)/comp_row(l) * sum(co,frate(c,co,l)*dm(co))/dm(f);

****************************************
****Roughage rate change for calibration
****************************************
*frate(c,f,l)$(rou(f)) = frate(c,f,l)*1.3 ;

waste(c,l)$supply(c,l) = dm_req(l)/sum(ff,frate(c,ff,l)*dm(ff));
display waste;

*************************Check this!!!!******************

f_dem(c,'OENERGY') =   sum(l,frate(c,'OENERGY',l) * supply(c,l));
f_dem(c,'FODDER') =   sum(l,frate(c,'FODDER',l) * supply(c,l));
*frate(c,f,l)$(frate(c,f,l) lt 0.001) = 0;
   );



waste(c,l)$(supply(c,l) and sum(ff,frate(c,ff,l)*dm(ff))) = dmr_all(l)/sum(ff,frate(c,ff,l)*dm(ff));


display  comp_dairy,waste,frate;



**************************************
*******US Frate calculation*******
**************************************


loop(c$vs(c),
*f_dem(c,'OPROT')   = 0;
*f_dem(c,'OENERGY') = 0;
*f_dem(c,'gras')  = 0;
f_dem(c,'FODDER')  = 0;
*f_dem(c,'smaize')  = 0;

lf_combination(co,l) = 0;
lf_combination(co,l) = lf_combination2(co,l);


dm_req(l) = dmr_all(l);
dm_req('MILK') = dm_dairy(c)* min_comp_dairy(c) ;
dm_req('BEEF') = dm_req('BEEF')* min_comp_dairy(c) * .8;
dm_req('SHEEP') = dm_req('SHEEP')* min_comp_dairy(c) * .5 ;

frate(c,f,l) = lf_combination(f,l);

* Waste =! 0:
frate(c,co,l)$sum(coco,frate(c,coco,l)) = frate(c,co,l) * dm_req(l)/sum(coco,frate(c,coco,l));

* Balance =! 0:
frate(c,co,l)$(supply(c,l)  and f_dem(c,co) and sum(ll,frate(c,co,ll) * supply(c,ll)))
 = frate(c,co,l) * (f_dem(c,co) )/sum(ll,frate(c,co,ll) * supply(c,ll));
frate(c,f,l)$(not f_dem(c,f)) = 0;

display dm_req,frate;

for
  (z = 1 to 10,

*             E-P Ratio of all available compoud feed                 / current E-P Ratio for livestock category
en_pr(c,l)$sum(coco,frate(c,coco,l)) = (sum(en,f_dem(c,en) * dm(en))/sum(pr,f_dem(c,pr) * dm(pr)))
                                    / (sum(en,frate(c,en,l) * dm(en))/sum(pr,frate(c,pr,l) * dm(pr)));

* E-P Ratio =! closer together for all livestock categories:
frate(c,en,l)$frate(c,en,l) = frate(c,en,l) * en_pr(c,l)**(0.5);
frate(c,pr,l)$frate(c,pr,l) = frate(c,pr,l) * en_pr(c,l)**(-0.5);


* Waste =! 0:
frate(c,co,l)$sum(coco,frate(c,coco,l)) = frate(c,co,l) * dm_req(l)/sum(coco,frate(c,coco,l)*dm(coco));

* Balance =! 0:
frate(c,co,l)$(supply(c,l) and f_dem(c,co) and sum(ll,frate(c,co,ll) * supply(c,ll)))
 = frate(c,co,l) * (f_dem(c,co) )/sum(ll,frate(c,co,ll) * supply(c,ll));
frate(c,f,l)$(not f_dem(c,f)) = 0;
*display  frate;
);
display frate;

* Reporting Statistics
en_pr(c,l)$sum(coco,frate(c,coco,l)) = (sum(en,f_dem(c,en) * dm(en))/sum(pr,f_dem(c,pr) * dm(pr)))/ (sum(en,frate(c,en,l) * dm(en))/sum(pr,frate(c,pr,l) * dm(pr)));
waste(c,l)$supply(c,l) = dm_req(l)/sum(coco,frate(c,coco,l)*dm(coco));
comp_dairy(c) = sum(co$(not rou(co)), frate(c,co,'milk')*dm(co));

* factor by which OE and OP must be increased to meet requirements for compound feed
extra_comp(c,l) =  (inefficiency(c) * waste(c,l) -1) * sum(coco,frate(c,coco,l)*dm(coco))/2;
*frate(c,'OENERGY',l) = frate(c,'OENERGY',l) + MAX(0,extra_comp(c,l)/dm('OENERGY'));
*frate(c,'OPROT',l) = frate(c,'OPROT',l) + MAX(0,extra_comp(c,l)/dm('OPROT'));

frate(c,'FODDER','MILK') = sum(co$(not rou(co)), frate(c,co,'milk')*dm(co)) * (1-min_comp_dairy(c))/min_comp_dairy(c);
frate(c,'FODDER','beef') = sum(co$(not rou(co)), frate(c,co,'beef')*dm(co)) * (1-min_comp_dairy(c)*0.7)/min_comp_dairy(c)/0.7;
frate(c,'FODDER','sheep') = sum(co$(not rou(co)), frate(c,co,'sheep')*dm(co)) * (1-min_comp_dairy(c)*0.4)/min_comp_dairy(c)/0.4;


* Reporting Statistics
en_pr(c,l)$sum(coco,frate(c,coco,l)) = (sum(en,f_dem(c,en) * dm(en))/sum(pr,f_dem(c,pr) * dm(pr)))/ (sum(en,frate(c,en,l) * dm(en))/sum(pr,frate(c,pr,l) * dm(pr)));
* This version of Waste only relates to compound feed
waste(c,l)$supply(c,l) = dm_req(l)/sum(coco,frate(c,coco,l)*dm(coco));

* Final version of Waste also including roughages
dm_req(l) = dmr_all(l);
*dm_req('MILK') = dm_dairy(c);
waste(c,l)$supply(c,l) = dm_req(l)/sum(ff,frate(c,ff,l)*dm(ff));

*f_dem(c,'OPROT') =  f_int(c,'OPROT') + sum(l,frate(c,'OPROT',l) * supply(c,l));
*f_dem(c,'OENERGY') =  f_int(c,'OENERGY') + sum(l,frate(c,'OENERGY',l) * supply(c,l));
f_dem(c,'FODDER') =   sum(l,frate(c,'FODDER',l) * supply(c,l));
   );


display frate;


*test_fr(cc,feed)$fdem.l(cc,feed)   =  (sum(livest, FRATE_0(cc,feed,livest)* SUPPLY.l(cc,livest)) + feed_exog(cc,feed)) / fdem.l(cc,feed);

check('balance',c,f)$f_dem(c,f) =  (sum(ll,frate(c,f,ll) * supply(c,ll))) / f_dem(c,f) ;

check('balance',c,f)
 $(check('balance',c,f) lt 0.001)
 =0;

display check;
*$exit

*frate(c,f,ll)$check('balance',c,f) = frate(c,f,ll)/check('balance',c,f);
*check('balance',c,f)$f_dem(c,f) =  (sum(ll,frate(c,f,ll) * supply(c,ll)))/f_dem(c,f) ;
*check('balance',c,f) $(check('balance',c,f) lt 0.001) = 0;


display f_dem,waste,frate;



execute_unload '..\Data_GDX\frates_calc.gdx', frate, waste, f_dem, f_int ;

