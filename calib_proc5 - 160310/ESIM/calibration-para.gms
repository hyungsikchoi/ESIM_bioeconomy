
parameter
adjust_cap(it) /eggs 2.0
                corn 0.9
                othgra 3.0
                rice 1.075
                sheep 0.9
                beef 1.57
                /
;

trq("sheep")  = trq("sheep")  * adjust_cap("sheep");
trq("rice")  = trq("rice")  * adjust_cap("rice");
trq("beef")  = trq("beef")  * adjust_cap("beef");
subsquant("eggs") = adjust_cap("eggs") * subsquant("eggs");
trq("CORN")   = trq("corn")   * adjust_cap("corn");
trq("othgra")   = trq("othgra")   * adjust_cap("othgra");



TRADESHR.L(ONE,IT)$(not eu27(one) and NETEXP.L(ONE,IT) ne 0.0
                and MAX(SUPPLY.L(ONE,IT),TUSE.L(ONE,IT)) ne 0.0)
                                  = NETEXP.L(ONE,IT) /
                                    MAX(SUPPLY.L(ONE,IT),TUSE.L(ONE,IT)) * 100;


*TRADESHR.L(ONE,'OENERGY') = 0;
*TRADESHR.L(ONE,'OPROT') = 0;



*
* For the EU the trade share is allways calculated according to the Total Use
*

QUALSHR_EU.l(it)$(SUM(eu27, TUSE.L(eu27,IT)))   = qualquant(IT) / ( SUM(eu27, TUSE.L(eu27,IT))) * 100;

display QUALSHR_EU.l,TRQ;


TRADESHR_EU.l(it)$(SUM(eu27, TUSE.L(eu27,IT))) = ( SUM(eu27, NETEXP.L(eu27,IT)))
                   /(SUM(eu27, TUSE.l(eu27,IT)))*100;




TRADESHR_D.l(delay_c)$(SUM(delay_r, TUSE.l(delay_r,delay_c)))= ( SUM(delay_r, NETEXP.L(delay_r,delay_c)))
                   /(SUM(delay_r, TUSE.l(delay_r,delay_c)))*100;


TRQSHR_EU.l(it)$(SUM(eu27, NETEXP.l(eu27,it)) and TRQ(it))
  = TRQ(IT) /
  ( SUM(eu27, TUSE.L(eu27,IT))) * 100;




*sug_imp_exog('sugar')=528;
**improt data from the model.gms
sug_imp_exog('sugar')=4100.202;
TRQSHR_EU.l("sugar") = [sug_imp_exog('sugar')  /SUM(cc$member(cc),tuse.l(cc,"sugar"))*100] ;

*TRQSHR_EU.l("sugar") = 8.811;
***changed according to the quota ratio
*TRADESHR_EU.l("sugar") = 8.811;

display TRQSHR_EU.l,sug_imp_exog;


SUBSHR_EU.l(it)$(SUM(eu27, NETEXP.l(eu27,it)) and subsquant(it) )
*                        and ((eu_pols(it,"exp_sub") ne 0.0) or (eu_pols(it,"exstab") ne 0.0)))   =
                                    =
         SUBSQUANT(it) /
         ( SUM(eu27, TUSE.L(eu27,IT))) * 100;

display tuse.l,SUBSHR_EU.l;


LOOP(it,
LOOP(cand,
*IF((netexp.l(cand,it) eq 0.0) and (tuse.l(cand,it) eq 0.0) ,
*resulted in problems with TUR and biofuels
IF((netexp.l(cand,it) or tuse.l(cand,it)) eq 0.0 ,
mrktpri0(cand,it) = 0.0;
);
);
);

subs_ad(one,it) = 0.0;
LOOP(it,
LOOP(cand,
IF(netexp.l(cand,it) lt 0.0 ,
tar_ad(cand,it) = round([mrktpri0(cand,it) / ( mrktpri0("row",it) / exrate(cand) )  -1.0],4);
);
IF(netexp.l(cand,it) gt 0.0 ,
subs_ad(cand,it) = round([mrktpri0(cand,it) / ( mrktpri0("row",it) / exrate(cand) )  -1.0],4);
tar_ad(cand,it)  = (1.25*(PW.l(it)/exrate(cand)*(1+subs_ad(cand,it))))/( mrktpri0("row",it) / exrate(cand)) -1.;
);
);
);

display subs_ad, tar_ad;



parameter
check_cand_tar
check_cand_subs
;
check_cand_tar(cand,it)  =    tar_ad(cand,it);
check_cand_subs(cand,it) =    subs_ad(cand,it);

display tuse.l,netexp.l,mrktpri0;

delay(cc,comm) = 1.0;

loop(delay_r,
* delay(delay_r,delay_c)  =  PRICE_DEV(delay_c) ;
  delay(delay_r,delay_c)  =  1;
);

display delay,exp_sub,qual_ad,tar_ad,sp_d,tar,floor,thresh,intpr,thrpr,delay_r,delay_c,EXPSUB,NEXPSUB;

* TAR PRODUCTS:

** LOWER BOUND **

tar_ad('TU','oenergy')= 0;

*tar_ad(one,'oprot')  =  0.3;
*sp_d(one,'oenergy')  = sp_d(one,'barley');
*sp_d(one,'oprot')    = 100;
***FOR oenergy,oprot have no tarif rate and sp_d for EU countries
***and take world price PW


P_LO.l(one,tar)$mrktpri0(one,tar) = PW.l(tar)/exrate(one);


P_LO.l(delay_r,tar)$(delay_c(tar) and mrktpri0(delay_r,tar)) = delay(delay_r,tar)*(SUM(EURO1, mrktpri0(EURO1,tar) * exrate(EURO1))
                                                                              / exrate(delay_r));
** UPPER BOUND **

P_UP.l(one,tar)$(mrktpri0(one,tar) and eu27(one)) = (PW.l(tar)/exrate(one))*(1+tar_ad(one,tar))+sp_d(one,tar);






P_UP_2.l(one,tar)$(eu27(one) and mrktpri0(one,tar) and (qual_ad(one,tar) or exp_sub(one,tar)))
                                     = MAX(exp_sub(one,tar),qual_ad(one,tar)) + PW.l(tar)/exrate(one);


* FLOOR PRODUCTS:

** LOWER BOUND **

*****update sugar intpr level
*intpr(one,'sugar')=404;
*697/632*intpr(one,'sugar');

P_LO.l(one,floor)$ (mrktpri0(one,floor) and eu27(one))   = MAX(PW.l(floor)/exrate(one),exstab(one,floor) + intpr(one,floor));

** UPPER BOUND **
P_UP.l(one,floor)$ (mrktpri0(one,floor) and eu27(one))  = (PW.l(floor)/exrate(one))*(1+tar_ad(one,floor))+sp_d(one,floor);


display pw.l,P_UP.l,P_LO.l,exstab,intpr,floor,mrktpri0,tar_ad,sp_d;








* THRESHOLD PRODUCTS:
** LOWER BOUND **
P_LO.l(one,thresh)$ (mrktpri0(one,thresh) and eu27(one)) =  MAX(PW.l(thresh)/exrate(one),intpr(one,thresh));

P_LO.l(delay_r,thresh)$ (mrktpri0(delay_r,thresh) and delay_c(thresh)) = MAX(intpr(delay_r,thresh),
                                                                         delay(delay_r,thresh)
                                                                       *(SUM(EURO1, mrktpri0(EURO1,thresh) * exrate(EURO1))
                                                                           / exrate(delay_r))
                                                                             );

** UPPER BOUND **
P_UP.l(one,thresh)$ (mrktpri0(one,thresh) and eu27(one)) = MAX(PW.l(thresh)/exrate(one),thrpr(one,thresh));

** 2nd STEP IN LOGIT FUNCTION
P_UP_2.l(one,thresh)$(eu27(one) and mrktpri0(one,thresh) and (qual_ad(one,thresh) or exp_sub(one,thresh)))
                                     = MAX(exp_sub(one,thresh),qual_ad(one,thresh)) + PW.l(thresh)/exrate(one);

** CANDIDATE COUNTRIES

P_LO.l(cand,it)$(mrktpri0(cand,it) and NETEXP.l(cand,it) gt 0.0) = PW.l(it)/exrate(cand)
                                                                 *(1+subs_ad(cand,it));

P_UP.l(cand,it)$(mrktpri0(cand,it) and NETEXP.l(cand,it) gt 0.0) = (1+tar_ad(cand,it))*(PW.l(it)
                                                      /exrate(cand));


display tar,floor,thresh;

*$stop


P_LO.l(cand,it)$(mrktpri0(cand,it) and NETEXP.l(cand,it) lt 0.0) = PW.l(it)/exrate(cand);
P_UP.l(cand,it)$(mrktpri0(cand,it) and NETEXP.l(cand,it) lt 0.0) = PW.l(it)/exrate(cand)
                                                                    *(1+tar_ad(cand,it));

********************
**Added for new ESIM
********************
P_UP.l(cand,tar)$(mrktpri0(cand,tar) and NETEXP.l(cand,tar) eq 0.0) = PW.l(tar)/exrate(cand);

*P_LO.l(cc,'oenergy')= P_LO.l(cc,'oenergy')*0.5;
*P_LO.l(cc,'oprot')= P_LO.l(cc,'oprot')*0.5;

*P_UP.l(cc,'oenergy')=P_UP.l(cc,'oenergy')*1.5;
*P_UP.l(cc,'oprot')=P_UP.l(cc,'oprot')*1.5;

display P_UP.l,NETEXP.l,tar,mrktpri0;





* =======================================================
*
* The following file checks the calibration of the domestic price level with the LOGIT-
* Function and the difference between the calibrated prices and the domestic prices as
* given in the base data
*
*




$include "logit-calib.gms"

*$libinclude xlexport chk_floor_eu1 '.\Logit Kalib\logit-crops-final.xls' logit_calib

*
* End of test of calibrating of the LOGIT function
* =======================================================
*
* Taking the calibrated domestic prices of the LOGIT-Function as starting values for PD.l

*By now included in the base data generation procedure:
display margin0,lag_weight,lag_period;

*margin0(cc,"SUGAR") = 1;

display margin0;


display pd.l;

PD.l(eu27,it)  = chk_floor_eu(eu27,it,"PD_CALC")$(SUPPLY.l(eu27,it) or TUSE.l(EU27,it));
PD.l(delay_r,delay_c)  = chk_floor_d(delay_r,delay_c,"PD_CALC");
PD.l(cand,it)  = chk_floor_c(cand,it,"PD_CALC");

display PD.l,chk_floor_eu;





******
******FOR sugar
*P_LO.l(eu27,"sugar")$ (mrktpri0(eu27,"sugar"))
* =   chk_floor_eu(eu27,"sugar","PD_CALC");


*****FOR CAPRI-ESIM oenergy, oprot

PD.l(cc,'oenergy') = 0.5*pd.l(cc,'barley');
PD.l(eu27,'oenergy') = 0.5*chk_floor_eu(eu27,'barley',"PD_CALC");
PD.l(cc,'oprot')   = 0.5*pd.l(cc,'rapmeal');
PD.l(eu27,'oprot')   = 0.5*chk_floor_eu(eu27,'rapmeal',"PD_CALC");

P_UP.l('TU','oenergy') = P_LO.l('TU','oenergy');

PD.l(eu27,'oenergy')= P_LO.l(eu27,'oenergy');


PD.l(cand,'oenergy') = P_LO.l(cand,'oenergy');

***change to 0.3 for Turkey, Beligium
PD.l(cand,'oprot')   = P_LO.l(cand,'oprot');

****US fodder price assigment
PD.l('us','fodder') =  PD.l('row','fodder');




$ontext
****** CALCULATION OF DIRECT PAYMENT ENVELOPES **********

Parameter
OVERALL_DECOUP(ccplus)
OVERALL_COUP(ccplus,i)
ENV_ART_69(ccplus,i)
ENV_COUP_EU(ccplus,i)
ENV_DCNDP(ccplus)
ENV_DECOUP_EU(ccplus)
ENV_SUGAR(ccplus,i)
ENV_CNDP(ccplus,i)
Change_env(ccplus,i)
Current_year
;

* DIRPAYS ARE EXPRESSED IN 1000 EUROS

ENV_ART_69(EU27,comm)      =  1000* Art_69_env(EU27,comm) + (Art_69_ha(EU27,comm) * ALAREA.l(EU27,comm));

ENV_COUP_EU(EU27,CROPS)    =  DP_coup_ha(EU27,CROPS) * ALAREA.l(EU27,CROPS);
ENV_COUP_EU(EU27,LIVEST)   =  1000 * DP_coup_env(EU27,livest);

ENV_DCNDP(EU12)            =  DP_decoup_ha(eu12,'DCNDP')  * SUM(crops,ALAREA.l(EU12,CROPS));
ENV_DECOUP_EU(EU27)        =  DP_decoup_ha(eu27,'premia') * SUM(crops,ALAREA.l(EU27,CROPS));

ENV_CNDP(EU27,comm)        =  (CNDP_ha(EU27,comm) * ALAREA.l(EU27,comm)) + 1000 * CNDP_env(EU27,comm);

OVERALL_DECOUP(EU27)       =  ((ENV_DCNDP(EU27) + ENV_DECOUP_EU(EU27)) ) * SUM(euro1, exrate(EURO1))/exrate(eu27) ;
OVERALL_COUP(EU27,comm)    =  (ENV_ART_69(EU27,comm) + ENV_COUP_EU(EU27,comm) + ENV_CNDP(EU27,comm)) * SUM(euro1, exrate(EURO1))/exrate(eu27) ;



display  ENV_ART_69, ENV_COUP_EU,ENV_DCNDP, ENV_DECOUP_EU, ENV_CNDP, OVERALL_DECOUP, OVERALL_COUP;
*$stop
$offtext



parameter

PD00(cc,comm) Final prices (PD) after calib logistic function
PP00(cc,comm) Final producer prices (PP) after calib logistic function
DIRPAY00(cc,comm) Final direct payments in national currency per ton
PINC00(cc,comm) Final incentive prices (PP) after calib logistic function
FCI0(cc,comm) Feed price index in the base
;

PD00(cc,it) = PD.l(cc,it);
PD00(cc,nt) = PD.l(cc,nt);


****** CALCULATION OF DIRECT PAYMENT ENVELOPES **********

Parameter
OVERALL_DECOUP(ccplus)
OVERALL_COUP(ccplus,i)
ENV_ART_69(ccplus,i)
ENV_COUP_EU(ccplus,i)
ENV_DCNDP(ccplus)
ENV_DECOUP_EU(ccplus)
ENV_SUGAR(ccplus,i)
ENV_CNDP(ccplus,i)
Change_env(ccplus,i)
Current_year
;

* DIRPAYS ARE EXPRESSED IN 1000 EUROS

ENV_ART_69(EU27,comm)      =  1000* Art_69_env(EU27,comm) + (Art_69_ha(EU27,comm) * ALAREA.l(EU27,comm));

ENV_COUP_EU(EU27,CROPS)    =  DP_coup_ha(EU27,CROPS) * ALAREA.l(EU27,CROPS);
ENV_COUP_EU(EU27,LIVEST)   =  1000 * DP_coup_env(EU27,livest);

ENV_DCNDP(EU12)            =  DP_decoup_ha(eu12,'DCNDP')  * SUM(crops,ALAREA.l(EU12,CROPS));
ENV_DECOUP_EU(EU27)        =  DP_decoup_ha(eu27,'premia') * SUM(crops,ALAREA.l(EU27,CROPS));

ENV_CNDP(EU27,comm)        =  (CNDP_ha(EU27,comm) * ALAREA.l(EU27,comm)) + 1000 * CNDP_env(EU27,comm);

OVERALL_DECOUP(EU27)       =  ((ENV_DCNDP(EU27) + ENV_DECOUP_EU(EU27)) ) * SUM(euro1, exrate(EURO1))/exrate(eu27) ;
OVERALL_COUP(EU27,comm)    =  (ENV_ART_69(EU27,comm) + ENV_COUP_EU(EU27,comm) + ENV_CNDP(EU27,comm)) * SUM(euro1, exrate(EURO1))/exrate(eu27) ;



display  ENV_ART_69, ENV_COUP_EU,ENV_DCNDP, ENV_DECOUP_EU, ENV_CNDP, OVERALL_DECOUP, OVERALL_COUP,DP_COUP;



* Calculate direct payments
**Calculate direct payments per ton and reduction by decoupling factor

DP_DECOUP('lino',one) =DP_DECOUP('Barley',one);
*DP_DECOUP(crops,one) = OVERALL_DECOUP(one)/SUM(crops1,ALAREA.l(one,CROPS1));

dirpay0(ccplus,i)   = 0;

dirpay0 (one,crops)$YIELD.l(one,crops) =
  DP_COUP(crops,one)+  DP_DECOUP(crops,one)*prod_effdp(crops,"effdp")/YIELD0(one,crops);

dirpay0 (one, livest)$supply.l(one,livest) = DP_COUP(livest,one)*prod_effdp(livest,"effdp");

display dirpay0,DP_COUP,DP_DECOUP,YIELD0;

***hyungsik, DIRPAY adjustment for new CAPRI data


display OVERALL_DECOUP,OVERALL_COUP;

dirpay0 (one,crops)$(YIELD.l(one,crops) and ALAREA.l(one,CROPS))
 =
  OVERALL_DECOUP(one)*prod_effdp(crops,"effdp")/SUM(crops1,ALAREA.l(one,CROPS1))/YIELD0(one,crops)

  +OVERALL_COUP(one,crops)/ALAREA.l(one,CROPS)/YIELD.l(one,CROPS)
;

dirpay0 (one, livest)$(supply.l(one,livest) and dirpay0(one,livest))
 = OVERALL_COUP(one,livest)/supply.l(one,livest)*prod_effdp(livest,"effdp") ;

display dirpay0,YIELD0;


*DIRPAY.l(one,'setaside')=0;
*prod_effdp('setaside',"effdp")=0;
***hyungsikchoi
*dirpay0 (one,'setaside') =0;

DIRPAY.l(one,comm)$(supply.l(one,comm) and dirpay0(one,comm)) =  dirpay0(one,comm) ;

display dirpay.l;



***DIRPAY adjustment for new CAPRI data


DIRPAY00(one,comm)$supply.l(one,comm) = DIRPAY.l(one, comm);



*Assignment of producer prices
PP.l(cc,ag)$ (margin0(cc,ag))          = PD.l(cc,ag) / margin0(cc,ag);
PP.l(cc,ag)$((margin0(cc,ag) eq 0.0) ) = PD.l(cc,ag);

display pp.l,PD.l,margin0;


*Assingment of shadow prices
PSH.l(one,comm)$quota(one,comm)      =  0.8 * (PP.l(one,comm) + DIRPAY.l(one,comm));

PSH.l(eu15,"milk")$(quota(eu15,"milk"))  =  psh_mlk(eu15,'milk') * (PP.l(eu15,"milk") + DIRPAY.l(eu15,"milk"));




PSH.l(eu12,"milk")$(quota(eu12,"milk"))  =  {psh_mlk(eu12,'milk') *} PP.l(eu12,"milk") + DIRPAY.l(eu12,"milk")  ;
*PSH.l(one,"milk")$(quota(one,"milk") and (eu12(one)))  =  {0.84 *} PP.l(one,"milk") + DIRPAY.l(one,"milk")  ;



PSH.l(one,"sugar")$(quota(one,"sugar") and eu27(one)) =  450.0 /margin0(one,"sugar") * SUM(euro1, exrate(EURO1))/exrate(one);
PSH.l("GE","sugar")=  400.0 /margin0("GE","sugar")* SUM(euro1, exrate(EURO1))/exrate('ge');
PSH.l("AT","sugar")=  400.0 /margin0("AT","sugar")* SUM(euro1, exrate(EURO1))/exrate('at');
PSH.l("BE","sugar")=  400.0 /margin0("BE","sugar")* SUM(euro1, exrate(EURO1))/exrate('be');
PSH.l("DK","sugar")=  450.0 /margin0("DK","sugar")* SUM(euro1, exrate(EURO1))/exrate('dk');
PSH.l("FI","sugar")=  550.0 /margin0("FI","sugar")* SUM(euro1, exrate(EURO1))/exrate('fi');
PSH.l("FR","sugar")=  400.0 /margin0("FR","sugar")* SUM(euro1, exrate(EURO1))/exrate('fr');
PSH.l("GR","sugar")=  550.0 /margin0("GR","sugar")* SUM(euro1, exrate(EURO1))/exrate('gr');
PSH.l("IE","sugar")=  550.0 /margin0("IE","sugar")* SUM(euro1, exrate(EURO1))/exrate('ie');
PSH.l("IT","sugar")=  550.0 /margin0("IT","sugar")* SUM(euro1, exrate(EURO1))/exrate('it');
PSH.l("NL","sugar")=  400.0 /margin0("NL","sugar")* SUM(euro1, exrate(EURO1))/exrate('nl');
PSH.l("PT","sugar")=  550.0 /margin0("PT","sugar")* SUM(euro1, exrate(EURO1))/exrate('pt');
PSH.l("ES","sugar")=  550.0 /margin0("ES","sugar")* SUM(euro1, exrate(EURO1))/exrate('es');
PSH.l("SW","sugar")=  400.0 /margin0("SW","sugar")* SUM(euro1, exrate(EURO1))/exrate('sw');
PSH.l("UK","sugar")=  400.0 /margin0("UK","sugar")* SUM(euro1, exrate(EURO1))/exrate('uk');




*PSH.l("si","sugar")= PD.l("si","sugar");

PP.l(one,"milk")$quota(one,"milk")   = MIN(pd.l(one,"milk")/margin0(one,"milk"),PSH.l(one,"milk"));



PP.l(one,"sugar")$quota(one,"sugar") = MIN(pd.l(one,"sugar")/margin0(one,"sugar"),PSH.l(one,"sugar"));

display psh.l,PP.l,pd.l,margin0,exrate;

PP00(cc,ag) = PP.l(cc,ag);

PC.l(cc,comm)    = PD.l(cc,comm) + pctax(cc,comm) ;



PC.l(cc,cr_oil)  = P0(cc,cr_oil) + pctax(cc,cr_oil) ;

*Calculation of incentive price
PINC00(one,comm) = PP00(one,comm)+DIRPAY00(one,comm);



execute_UNLOAD 'data_prices.gdx',
pd00
PP00
DIRPAY00
PINC00
;



* DEFINITION OF DYNAMIC SETS SECOND PART

PS(cc,comm)        = YES$PD.l(cc,comm);



pd_0(one,comm) = PD.l(one,comm);
pd_0(rest,it)$(SUPPLY.l(rest,it) or (FDEM.l(rest,it) or HDEM.l(rest,it))) = Pw.l(it);
pd_0(cc,nt) = PD.l(cc,nt);
*PD_0("WB",it)$(SUPPLY.l("WB",it) eq 0.0)    = 0;


prod0(cc,comm) =   supply.l(cc,comm)  ;
hdem0(cc,comm) =   hdem.l(cc,comm)   ;
fdem0(cc,comm) =   fdem.l(cc,comm) ;
sdem0(cc,comm) =   sdem.l(cc,comm) ;
pdem0(cc,comm) =   pdem.l(cc,comm) ;
pp_0(cc,comm)   =   pp.l(cc,comm) ;

execute_UNLOAD 'data_quantities.gdx',
prod0
hdem0
fdem0
sdem0
pdem0
netexp0
area0
;

display exrate,yield0;



*
* PARAMETERS DAIRY INDUSTRIES
*
* technical coefficient for fat and protein in dairy industries
*
*
display MPDEM.L;

dairy_input_coeff(cc,dairy_comp,mlkproc)$SUPPLY.l(cc,mlkproc) = MPDEM.l(cc,dairy_comp,mlkproc)/SUPPLY.l(cc,mlkproc);
*
display content_milk,PD.l,dairy_comp,MPDEM.l;

***********************************
***********New from CAPRI**********
***********************************
content_milk(cc,dairy_comp) =SUPPLY.l(cc,dairy_comp)/ PDEM.l(cc,'milk');
display content_milk;

addcomp_milk(cc,'milk') =  PD.l(cc,'MILK') / SUM(dairy_comp, content_milk(cc,dairy_comp) * PD.l(cc,dairy_comp));

display addcomp_milk;
*
*
*addcomp_dairy(cc,mlkproc)$SUPPLY.l(cc,mlkproc) = (PD.l(cc,mlkproc) - SUM(dairy_comp, dairy_input_coeff(cc,dairy_comp,mlkproc)*PD.l(cc,dairy_comp)))/PD.l(cc,mlkproc) +1;


addcomp_dairy(cc,mlkproc)$(SUPPLY.l(cc,mlkproc) and SUM(dairy_comp, dairy_input_coeff(cc,dairy_comp,mlkproc)*PD.l(cc,dairy_comp)))
 = PD.l(cc,mlkproc) / SUM(dairy_comp, dairy_input_coeff(cc,dairy_comp,mlkproc)*PD.l(cc,dairy_comp));



display MPDEM.l,SUPPLY.l,dairy_input_coeff,PD.l,addcomp_dairy;




*
* PARAMETER ACREAGE AND COMPENSATORY PAYMENTS
*
area_gc_(one)         = sum(comcrop, ALAREA.l(one,comcrop))+marg_land(one)*OBLSETAS.l(one);
area_to(one)          = SUM(crops, ALAREA.l(one,crops))+ marg_land(one)*OBLSETAS.l(one);

EFAREA_GC.l(one)      = area_gc_(one);


yield_b(one,crops)    = YIELD.l(one,crops);


FC_0(cc,livest)=sum(feed,FRATE.l(cc,feed,livest)*PD.l(cc,feed));

feed_milk(cc) $ supply.l(cc,"milk")    = fdem_mlk.l(cc,"milk")/supply.l(cc,"milk");
display feed_milk;


* Umstellen von Weizen auf ha-Prämie
*PSH.l(eu15,"setaside")$(quota(eu15,"setaside") and DP_POLS(eu15,'ag2000') eq 1.0)  =  0.35 * YIELD.l(eu15,'cwheat')*DIRPAY.l(eu15,'cwheat') ;
*PSH.l(eu15,"setaside")$(quota(eu15,"setaside") and DP_POLS(eu15,'ag2000') eq 1.0)  = 0.9 *  dp_decoup_ha(eu15,'premia')* prod_effdp('setaside',"effdp")* SUM(euro1, exrate(EURO1))/exrate(eu15)   ;

PSH_0(one,comm)$quota(one,comm)  =  PSH.l(one,comm);


**HYUNGSIK dirpay set aside=0
DIRPAY0(CC,'setaside')=0;



parameter testxx
testx;
testxx(eu15) = dp_decoup_ha(eu15,'premia') * prod_effdp('setaside',"effdp")* SUM(euro1, exrate(EURO1))/exrate(eu15)  ;
testx(eu15)$(quota(eu15,"setaside") and DP_POLS(eu15,'ag2000') eq 1.0)  =  YIELD.l(eu15,'cwheat')*DIRPAY.l(eu15,'cwheat') ;
*testx(eu15) =  YIELD.l(eu15,'cwheat')*DIRPAY.l(eu15,'cwheat') ;

display testxx, testx;
*$stop

*DIRPAY.l("ge",'setaside') =  YIELD.l("ge",'cwheat')*DIRPAY.l("ge",'cwheat') ;
*DIRPAY0("ge",'setaside') =  YIELD.l("ge",'cwheat')*DIRPAY.l("ge",'cwheat') ;

PI.l(cc,ag)      =  PP.l(cc,ag) + DIRPAY.l(cc,ag);

*PP.l(cc,'setaside')=0;
*PI.l(cc,'setaside')=0;

PI.l(cc,energ)   =  PD.l(cc,energ) ;

pay_biof = biofuel_premia('base','premia')*1000;

PI.l(one,energ)$member(one)   =  PD.l(one,energ) + pay_biof /SUM((energ1,member), SUPPLY.l(member,energ1))* SUM(euro1, exrate(EURO1))/exrate(one);

PI.l(one,ag)$quota(one,ag)  = MIN(pi.l(one,ag),PSH.l(one,ag));

display pi.l,PP.l,dirpay.l;



PPP(cc,ag) = YES$(PI.l(cc,ag) or PP.l(cc,ag));


$include "calc-para.gms"
