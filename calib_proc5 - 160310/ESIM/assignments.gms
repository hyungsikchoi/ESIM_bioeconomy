*###

Parameter feed_row(cc,comm);

$include "gse-reading-data.gms"
*###

display feed_row;





* =========================================================== *
* Data and parameters related to the stochastic part of ESIM  *
* =========================================================== *

$include "stochastic-data.gms"

* ========================================= *
* Processing elasticities in dairy sector   *
* ========================================= *

$include 'dairy_elast.gms'



scalar scaler /1/;

$include "macro-data.gms"
$include "cap-policies.gms"




***diffuction of lignocellosic crops
Diff.l(one,crops)=1;

scalar calib;

alpha     = 0.5;
diff_lino = 1;
T_zero    = 16;
calib =1;

parameter LINO_YIELD(cc,comm);

LINO_YIELD(cc,'lino')=10;

YIELD.l(cc,'lino')=LINO_YIELD(cc,'lino');





* ASSIGNING BASE VALUES TO VARIABLES
*

display cp;
**hyungsik "setaside" area comes from CAPRI

*area0(EU15,"setaside")  =  cp("vol_set",EU15)/scaler;
*prod0(EU15,"setaside")  =  cp("vol_set",EU15)/scaler;

*andresetas

*area0(EU12,"setaside")  =  cp("vol_set",EU12)/scaler;
*prod0(EU12,"setaside")  =  cp("vol_set",EU12)/scaler;

*area0(cc,"setaside")=0;
*prod0(cc,"setaside")=0;

display area0;

ALAREA.l(one,crops)$prod0(one,crops)    = area0(one,crops)/scaler;

ALAREA.l(one,'LINO') = sum(crops,ALAREA.l(one,crops))/1700;
Peak_LINO_Area(one) =1;
Peak_LINO_Area_scen(one) = sum(crops,ALAREA.l(one,crops))/5 /ALAREA.l(one,'LINO');

area0(cc,'LINO') = ALAREA.l(cc,'LINO');

display ALAREA.l,Peak_LINO_Area_scen;







EFAREA.l(one,crops)    = ALAREA.l(one,crops);

AREA_UN.l(one)         = sum(crops, ALAREA.l(one,crops));


OBLSETAS.l(one)         = (cp("efsetas_",one) - cp("vol_set",one))/scaler;
OBLSETAS.l(one)=0;
**set aside abolised in 2008
setas_eu15(one)          = OBLSETAS.l(one);
area_to(one)           = AREA_UN.l(one);

SUPPLY.l(cc,comm)     = prod0(cc,comm)/scaler;


SUPPLY.l(cc,'lino') = ALAREA.l(cc,'LINO')*YIELD.l(cc,'lino');


*SUPPLY.l('hr',energ)  = 0.0;
****original was HR(croatia energy is zeo)

*SUPPLY.l(eu15,"milk") = fdem0(eu15,"milk")/scaler + QUOTA_MLK("base",eu15)/scaler;

YIELD.l(one,crops)$EFAREA.l(one,crops)    = SUPPLY.l(one,crops) / EFAREA.l(one,crops);

YIELD0(one,crops)$EFAREA.l(one,crops)    = YIELD.l(one,crops);

YIELD0(one,'lino') = YIELD.l(one,'lino');

display YIELD.l,YIELD0;




HDEM.l(cc,comm)           = hdem0(cc,comm)/scaler ;
*HDEM.l('hr',energ)  = 0.0;
***HDEM.l Coratia is released



FRATE.l(one,feed,livest)  = fedrat(one,feed,livest);
FRATE.l(rest,feed,livest)  = fedrat(rest,feed,livest);



*andre

* with the new data base there is SMAIZE production and use in Sweden
* we take feed rates from Denmark

*frate.l('sw','smaize',livest) = frate.l('dk','smaize',livest) ;

* with the new data base there is SOYBEAN feed use in Romania and Turkey
* we take feed rates from Bulgaria

*frate.l('ro','soybean',livest) = frate.l('bg','soybean',livest) ;
*frate.l('tu','soybean',livest) = frate.l('bg','soybean',livest) ;


*feed_exog('ie','othgra') = 0.0 ;


FRATE.l('WB',feed,livest)  = fedrat('WB',feed,livest);

SDEM.l(cc,comm)           = sdem0(cc,comm)/scaler;

FDEM.l(cc,feed)           = fdem0(cc,feed)/scaler;

*FDEM.l(cc,'fodder')         = SUPPLY.l(cc,'fodder') ;
*FDEM.l(cc,'gras')           = SUPPLY.l(cc,'gras')   ;
*FDEM.l(cc,'smaize')         = SUPPLY.l(cc,'smaize') ;

***=============hyungsik
*** For us and ROW, fodder fdem is same as production
FDEM.l(cc,'fodder')$( sameas(cc,'ROW') or sameas(cc,'US'))  =feed_row(cc,'fodder') ;
SUPPLY.l(cc,'fodder')$( sameas(cc,'ROW') or sameas(cc,'US'))  =feed_row(cc,'fodder');
*SUPPLY.l(cc,'gras') =FDEM.l(cc,'fodder');




*FDEM.l(cc,'fodder')$(sameas(cc,'WB') or sameas(cc,'ROW') or sameas(cc,'US'))
*   = feed_row(cc,'fodder') ;
*FDEM.l(cc,'gras')$(sameas(cc,'WB') or sameas(cc,'ROW') or sameas(cc,'US'))
*   = feed_row(cc,'gras') ;
*FDEM.l(cc,'smaize')$(sameas(cc,'WB') or sameas(cc,'ROW') or sameas(cc,'US'))
*   = feed_row(cc,'smaize') ;


*SUPPLY.l(cc,'oenergy')     = fdem0(cc,'oenergy')/scaler;
*SUPPLY.l(cc,'oprot')       = fdem0(cc,'oprot')/scaler;
*fdem.l(cc,'oenergy')        =SUPPLY.l(cc,'oenergy');
*fdem.l(cc,'oprot')          =SUPPLY.l(cc,'oprot');
*fdem.l(cc,'OENERGY_CAPRI')          =SUPPLY.l(cc,'OENERGY_CAPRI');

FDEM_MLK.l(cc,"milk")     = fdem0(cc,"milk")/scaler;

PDEM.l(cc,comm)       = procdem0(cc,comm)/scaler;
display pdem.l;

*PDEM.l('pl',"milk")       = procdem0('pl',"milk")/scaler + 0.1*fdem0('pl',"milk")/scaler;

*PDEM.l(eu15,"milk") = QUOTA_MLK("base",eu15)/scaler;

MPDEM.l(cc,dairy_inputs,dairy_comm)  = dairy_pdem(dairy_comm,dairy_inputs,cc);

display dairy_pdem;



PDEM.l(cc,dairy_inputs)  =SUM(dairy_comm, dairy_pdem(dairy_comm,dairy_inputs,cc));

display pdem.l,dairy_inputs;


*PDEM.l(cc,dairy_inputs)  =SUPPLY.l(cc,dairy_inputs);


parameter
diary_check3(cc,dairy_inputs)
;
*********************************************
***Check new dairy_pdem coefficients for ESIM
*********************************************


diary_check3(cc,dairy_inputs)
 = SUPPLY.l(cc,dairy_inputs) - SUM(dairy_comm,  dairy_pdem(dairy_comm,dairy_inputs,cc));


display diary_check3,dairy_pdem;



MPDEM.l(cc,dairy_inputs,dairy_comm)  = dairy_pdem(dairy_comm,dairy_inputs,cc);

PDEM.l(cc,dairy_inputs)  = SUM(dairy_comm, dairy_pdem(dairy_comm,dairy_inputs,cc));




***=============hyungsik  straw production, fdem
**supply of straw, ratio parameter imported from CAPRI
parameter SHAR_STRA(cc,comm)   share of straw in the total supply
;

SUPPLY.l(cc,'stra') =sum(crops, EFAREA.l(cc,crops)*YIELD.l(cc,crops)*straw_ratio(cc,crops,'YtoStr'));

FDEM.l(cc,'stra')$(sameas(cc,'WB') or sameas(cc,'US') or sameas(cc,'ROW')) = 0;
PDEM.l(cc,'stra') =SUPPLY.l(cc,'stra') - FDEM.l(cc,'stra');
*SHAR_STRA(cc,'stra')$SUPPLY.l(cc,'stra')
*  =PDEM.l(cc,'stra')/SUPPLY.l(cc,'stra');
HDEM.l(cc,'stra') =0;
**strasw feed from WB, US and ROW becomes zero, not represented in the current version

display straw_ratio;







***total use check and net export
TUSE.l(cc,comm) = HDEM.L(CC,COMM) + SDEM.L(CC,COMM) + FDEM.L(CC,COMM)
                    + PDEM.L(CC,COMM) + FDEM_MLK.L(CC,COMM) ;


display dairy_pdem,TUSE.l,PDEM.l,SUPPLY.L ;

tuse0(cc,comm) = tuse.l(cc,comm);


NETEXP.l(cc,it)   =  supply.l(cc,it) - TUSE.l(cc,it)  ;

display NETEXP.l,FDEM_MLK.l,supply.l,TUSE.l,PDEM.L,HDEM.L,FDEM.L,SDEM.L;





* Level of production in base period is fixed for both EU-15 and New Member States

quota(eu15,"sugar") = SUPPLY.l(eu15,'sugar');
quota(eu12,"sugar") = SUPPLY.l(eu12,'sugar');
*quota("si","sugar") = 52.9;
quota("tu","sugar")     = SUPPLY.l("tu","sugar");

*quota(eu15,"milk")   = QUOTA_MLK("base",eu15)/scaler;
quota(eu15,"milk")   = PDEM.L(eu15,'milk')/scaler;

* ASSUMPTION: MILK QUOTA IN NMS: SUPPLY - FDEM_MLK

quota(eu12,"milk")   = supply.l(eu12,"milk")-fdem_mlk.l(eu12,"milk")/scaler;

display fdem_mlk.l;



quota(EU15,"setaside")$(DP_POLS(eu15,'ag2000') eq 1.0) = prod0(EU15,"setaside");

* Reinitialisation of unconstrained total area
AREA_UN.l(one)    = ( sum(CR_N_SU_GR_SAE, ALAREA.l(one,CR_N_SU_GR_SAE)) )$quota(one,"sugar")
          +          (sum(CR_N_GR_SAE,    ALAREA.l(one,CR_N_GR_SAE)) )$(not quota(one,"sugar")) ;



* LEVEL OF CAP INTRUMENTS

subsquant(comm)  = (eu_pols(comm,"es_limit")*1000);
***==================durum subsidy export becomes equal to zero
*subsquant('durum') =0;


exp_sub_0(eu27,comm)      = eu_pols(comm,"exp_sub")* SUM(euro1, exrate(EURO1))/exrate(eu27);

sp_d_0(eu27,comm)     = eu_pols(comm,"sp_d") * SUM(euro1, exrate(EURO1))/exrate(eu27);

sp_d_n(eu27,comm)     = sp_d_0(eu27,comm);

tar_ad(eu27,comm)     = eu_pols(comm,"tar_ad");

****==========hyungsik, new intervention price for EU
eu_pols('sugar',"intpr")=541;

intpr0(eu27,comm)     = eu_pols(comm,"intpr")* SUM(euro1, exrate(EURO1))/exrate(eu27);

intpr(eu27,comm)      = intpr0(eu27,comm) ;

thrpr0(eu27,comm)     = eu_pols(comm,"thrpr")* SUM(euro1, exrate(EURO1))/exrate(eu27);

thrpr(eu27,comm)      = eu_pols(comm,"thrpr")* SUM(euro1, exrate(EURO1))/exrate(eu27);

trq(comm)        = (eu_pols(comm,"trq")*1000);
display trq;

chgtrq(it)         = 0.0;
exstab(eu27,comm)     = eu_pols(comm,"exstab")* SUM(euro1, exrate(EURO1))/exrate(eu27);

exstab_0(eu27,comm)   = exstab(eu27,comm);

exp_sub(eu27,comm)   = exp_sub_0(eu27,comm);
sp_d(eu27,comm)      = sp_d_0(eu27,comm)   ;

****hyungsik, sugar tariff rate change to new value
*sp_d(eu27,'sugar')=419;


thrpr(eu27,comm)     = thrpr0(eu27,comm)  ;

qual_ad(eu27,it)$eu_pols(it,"qual_comp")    = exp_sub(eu27,it);
qual_ad(eu27,it)$(eu_pols(it,"qual_comp") and exp_sub(eu27,it) eq 0.0 )   = mrktpri0(eu27,it)
                                                                   - mrktpri0("row",it)/exrate(eu27) ;

qual_ad(delay_r,delay_c)$eu_pols(delay_c,"qual_comp") =  qual_ad("PL",delay_c)*exrate('PL')/exrate(delay_r);


qual_ad_0(eu27,it)  = qual_ad(eu27,it);

qualquant(it)        =  eu_pols(it,"qual_comp")*1000;

display qual_ad,qual_ad_0,qualquant;




* World market prices eq "domestic" prices in Rest of World

PW.l(it)           = mrktpri0("row",it);

***==================OTHDAIRY WORLD MARKET PRICE (hs)
PW.l('OTHDAIRY')   = mrktpri0("GE",'BUTTER')*exrate('GE');

display PW.l;

PD.l(rest,it)$(SUPPLY.l(rest,it) or (FDEM.l(rest,it) or HDEM.l(rest,it)))      = PW.l(it);

mrktpri0(cc,'STRA') = mrktpri0(cc,'fodder')*2/3;
mrktpri0(cc,'FENE') = mrktpri0(cc,'fodder')*2/3;

PD.l(cc,nt)$SUPPLY.l(cc,nt)    = mrktpri0(cc,nt);

PD.l(one,"milk") $ Supply.l(one,"milk")   = mrktpri0(one,"milk");

display mrktpri0,PD.l,PW.l,Supply.l;






FCI.l(cc,livest)$SUPPLY.l(cc,livest)  = 1;


$include 'land_data.gms'

pdem_tr(cc,comm) = 1.0;
hdem_tr(cc,comm) = 1.0;
fdem_tr(cc,comm) = 1.0;
area_corpar(cc,comm) = 1.0;

