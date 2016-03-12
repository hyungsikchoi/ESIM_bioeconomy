display area_int;
*$stop
display nq,PR,QU;

*elastin(cc,comm)=1;
display inc_gr;
display area0;



parameter const_supply(one,comm);
const_supply(one,comm)
 = SUPPLY.l(one,comm);



option iterlim = 100000;
price_sug_0(EU27) = intpr0(eu27,'sugar');


display elast_lv_i;

display ALAREA.l;




parameter
test_decoup
test_coup
test_zucker
test_weizen
cndp_ha_test
;

*=========================================================
* File      : model-1.gms
* Author    : Martin Banse(martin.banse@wur.nl)
* Version   : 1.0
* Remarks   :
* Date      : 28/03/2006 13:07:59
* Changed   : 23.08.2010 10:59:19
* Changed by: Demo user
*=========================================================
* ============================================
* FIXING VARIABLES TO 0.0 IF BASE VALUE EQ 0.0
* ============================================

SUPPLY.up("nl","milk")=   13074;
*SUPPLY.up("be","milk")=   3498;

***chs changed 'be' milk upper bound
*SUPPLY.up("be","milk")=   3600;
SUPPLY.up("dk","milk")=   5535.6;

PD.LO(cc,comm)       = 0.1;
PD.LO(cc,comm)       = 0.1;
PC.LO(cc,comm)       = 0.1;
PSH.LO(cc,comm)      = 0.1;

*display SUPPLY.LO, FDEM_MLK.LO, PSH.LO;
PP.LO(cc,comm)       = 0.1;
PI.LO(cc,comm)       = 0.1;
PW.LO(it)            = 0.1;
FCI.LO(cc,comm)      = 0.1;
landprice1.LO(one)   = 0.0000001;

BCI.LO(cc,energ)     = 0.1;

TRADESHR_EU.lo(it) = -100;
TRADESHR_EU.up(it) = +200;
**hyungsik, increased it by 100%
*TRADESHR_EU.up(it) = +100;


TRQSHR_EU.lo(it) = -100;
TRQSHR_EU.up(it) = +100;
TRADESHR.lo(cc,it) = - 100;
TRADESHR.up(cc,it) = + 100;
TUSE.lo(one1,it)$TUSE.l(one1,it) = 0.0001;
NetPD.lo(cc,energ,comm)$NetPD.l(cc,energ,comm) =.1;
SUPPLY.lo(cc,energ)$(pr(cc,energ) and SUPPLY.l(cc,energ)) = .0001;
*QUANCES.lo(cc,energ,comm)$(QUANCES.l(cc,energ,comm) and biof_e(energ) and pr(cc,energ) and i_ethanol(comm)) = .1;
SUBSHR_EU.up(it)$(SUM(eu27, NETEXP.l(eu27,it)) and subsquant(it)) = 100;
QUALSHR_EU.up(it)$(SUM(eu27, TUSE.L(eu27,IT)) and qualquant(it)) = 100;
SUBSHR_EU.lo(it)$(SUM(eu27, NETEXP.l(eu27,it)) and subsquant(it)) = -100;
QUALSHR_EU.lo(it)$(SUM(eu27, TUSE.L(eu27,IT)) and qualquant(it)) = -100;


YIELD.LO(cc,comm)    = 0.0001;
SUPPLY.LO(cc,comm)$(not sug(comm))   = 0.0001;

*+++++++++++++++++++++++++++++
*ALAREA.LO(cc,comm)$(ALAREA.L(cc,comm)>0 AND NOT sug(comm)) = 0.001;
*+++++++++++++++++++++++++++++



SUPPLY.FX(cc,comm)$(SUPPLY.l(cc,comm) EQ 0.0)       = 0.0;


display supply.l,oilsproc;





ALAREA.FX(cc,comm)$(ALAREA.l(cc,comm) EQ 0.0)       = 0.0;
AREA_UN.FX(cc)$(sum(crops, ALAREA.l(cc,crops)) EQ 0.0)  = 0.0;
DIRPAY.FX(cc,comm)$(DIRPAY.l(cc,comm) EQ 0.0)       = 0.0;

YIELD.FX(cc,comm)$(YIELD.l(cc,comm) EQ 0.0)         = 0.0;
***hyungsik, changed from 1 to zero
YIELD.FX(eu27,"setaside")                           = 1.0;
*YIELD.FX(cc,"setaside")                           = 0.0;
YIELD.FX(cc,"LINO")                           = 10.0;


MPDEM.fx(cc,comm1,comm)$(MPDEM.l(cc,comm1,comm) EQ 0.0) = 0.0;
FDEM.fx(cc,comm)$(FDEM.l(cc,comm) EQ 0.0)           = 0.0;
FDEM_MLK.fx(cc,comm)$(FDEM_MLK.l(cc,comm) EQ 0.0)   = 0.0;
FRATE.fx(cc,feed,livest)$(FRATE.l(cc,feed,livest) EQ 0.0) = 0.0;
FCI.fx(cc,comm)$(FCI.l(cc,comm) EQ 0.0)             = 0.0;

PDEM_BF.fx(cc,energ,comm)$(PDEM_BF.l(cc,energ,comm) EQ 0.0) = 0.0;
NetPD.fx(cc,energ,comm)$(NetPD.l(cc,energ,comm) EQ 0.0)     = 0.0;
BCI.fx(cc,energ)$(BCI.l(cc,energ) EQ 0.0)                   = 0.0;
QUANCES.fx(cc,energ,comm)$(QUANCES.l(cc,energ,comm) EQ 0.0) = 0.0;

HDEM.l(cc,"c_oil")  =    ((exp(subs_shift(cc,"c_oil")*hdem_int(cc,"c_oil") + sum(comm1$PPC(cc,comm1),
         elasthd(cc,"c_oil",comm1)*log(PC.l(cc,comm1))))*pop_gr(cc)
         *inc_gr(cc)**elastin(cc,"c_oil")+ subs_milk_d(cc,"c_oil")
         )*hdem_tr(cc,"c_oil"))$(HD(cc,"c_oil") or P0(cc,"c_oil"))         ;

HDEM.fx(cc,comm)$(HDEM.l(cc,comm) EQ 0.0)           = 0.0;


SDEM.FX(cc,comm)$(sdem.l(cc,comm) EQ 0.0)           = 0.0;
PDEM.fx(cc,comm)$(PDEM.l(cc,comm) EQ 0.0)           = 0.0;
* Modification : addition of c_oil consumption
TUSE.L(cc,"c_oil") = Hdem.l(cc,"c_oil") ;
TUSE.fx(cc,comm)$(TUSE.l(cc,comm) EQ 0.0)           = 0.0;

PD.FX(cc,comm)$((tuse0(cc,comm) eq 0.0) and (supply.l(cc,comm) eq 0.0) )         = 0.0;
PD.FX(cc,comm)$(PD.l(cc,comm) eq 0.0)               = 0.0;
PC.FX(cc,comm)$(HDEM.l(cc,comm) eq 0.0 and P0(cc,comm) eq 0.0)  = 0.0;

PSH.FX(cc,comm)$(PSH.l(cc,comm) EQ 0.0)             = 0.0;

QUOTARENT.FX(cc,comm)$(PSH.L(cc,comm) EQ 0.0)             = 0.0;
QUOTARENT.LO(cc,comm)$quota(cc,comm) = -INF;
QUOTARENT.UP(cc,comm)$quota(cc,comm) = +INF;

PP.FX(cc,comm)$(PP.l(cc,comm) EQ 0.0)               = 0.0;
PI.FX(cc,comm)$(PI.l(cc,comm) EQ 0.0)               = 0.0;
PW.fx(it)$(PW.l(it) EQ 0.0)                         = 0.0;
OBLSETAS.FX(cc)$(OBLSETAS.l(cc) eq 0.0)             = 0.0;
EFAREA_GC.FX(one)$(EFAREA_GC.l(one) eq 0.0)             = 0.0;

TRADESHR.FX(rest,comm)                              =  0.0;
TRADESHR.FX(cc,it)$(netexp.l(cc,it) eq 0.0 and supply.l(cc,it) eq 0.0)  =  0.0;
TRQSHR.FX(one,comm)$(TRQ(comm) EQ 0.0)          = 0.0;
SUBSHR.FX(one,comm)$(subsquant(comm) EQ 0.0)    = 0.0;
QUALSHR.FX(one,comm)$(qualquant(comm) EQ 0.0)    = 0.0;
TRQSHR.FX(rest,comm)                                = 0.0;
SUBSHR.FX(rest,comm)                                = 0.0;
QUALSHR.FX(rest,comm)                                = 0.0;

SUBSHR_EU.FX(comm)$(subsquant(comm) EQ 0.0)    = 0.0;
TRQSHR_EU.FX(comm)$(TRQ(comm) EQ 0.0)          = 0.0;
TRQSHR_EU.UP('sugar')          = +inf;
TRQSHR_EU.LO('sugar')          = -inf;
SUGIMP_EU.FX(comm)$(not sug(comm))             = 0.0;
QUALSHR_EU.FX(comm)$(qualquant(comm) EQ 0.0)   = 0.0;


P_UP.FX(rest,it)                                    = 0.0;
P_LO.FX(rest,it)                                    = 0.0;
P_UP.FX(one,it)$(P_UP.l(one,it) eq 0.0)           = 0.0;
P_LO.FX(one,it)$(P_LO.l(one,it) eq 0.0)           = 0.0;
P_UP_2.FX(rest,it)                                  = 0.0;
P_UP_2.FX(cc,it)$(P_UP_2.l(cc,it) EQ 0.0)           = 0.0;

EFAREA.LO(eu15,"GRAS")  = area0(eu15,"gras");
setas_eu12(EU12) = 0.0;
chg_oblsetas_cum(one) = 0.0;

area0(cc,comm) = alarea.l(cc,comm);
pd_0(cc,comm) = pd.l(cc,comm);

PS(cc,comm)        = NO;
PS(cc,comm)        = YES$PD.l(cc,comm);





parameter
chk_milk_Quota(cc,sim_base) Check for phasing out milk quota
Dirpay_check Check if in current period DP-envelops are filled or not
;


Parameter
deflation_kum   "Accumulated infaltion rates - used for the introduction of new payments";

deflation_kum(cc)=1;


sug_imp_exog('sugar')
 = 4100.202;

*$ontext
SUGIMP_EU.l(it) =         [MIN(preftrq,trq_int  * MAX(0,
                                         MAX(0,(PD.l('UK','SUGAR') *exrate('UK')/SUM(euro1, exrate(euro1))
                                              - PW.l("SUGAR") /SUM(euro1, exrate(euro1))- trq_tc)
                                            )** trq_elast
                                 )
             )]$(sug(it) and (endog_sug eq 2.0))
+
         [sug_imp_exog(it)]$(sug(it) and (endog_sug eq 1.0));

display TRQSHR_EU.l,SUGIMP_EU.l;

SUGIMP_EU.l("sugar") =4100.202;

TRQSHR_EU.l("sugar") = [SUGIMP_EU.l("sugar")  /SUM(cc$member(cc),tuse.l(cc,"sugar"))*100] ;

display  endog_sug,sug_imp_exog,preftrq,trq_int,SUGIMP_EU.l;

display TRQSHR_EU.l;


**fixed sugar policy
endog_sug=1;
***hyungsik, set the sugart import to sug_imp_exog
*SUGIMP_EU.l(it) =        preftrq;
display preftrq,endog_sug,pd.l;

*$stop

*$offtext



display trq_elast,trq_int,SUGIMP_EU.l,preftrq;



dirpay0(cc,comm)$(prod0(cc,comm) eq 0.0) = 0;

pd_t1(cc,ag)  = pd.l(cc,ag);
pd_t2(cc,ag)  = pd.l(cc,ag);


* ================================
*
* DECLARATION OF EQUATIONS


EQUATIONS


SUPPLYEQ(cc,comm)        Supply equations
HDEMEQ(cc,comm)          Human demand
SDEMEQ(cc,comm)          Seed demand

PROCEQ(cc,comm)          Processing activities
PROCW_EQ(cc,comm)        straw processing activities
PROCM_EQ(cc,dairy_comp,comm)  Processing demand for fat and protein for different activities in dairy industries

FEEDEQ(cc,feed)          Feed demand
FEEDMEQ(cc,comm)         Feed demand for milk

FRATEEQ(cc,feed,livest)  Feed rate for livestock products

TUSEEQ(cc,comm)          Total domestic use
YILDEQ(cc,ag)            Yields crops
AREAEQ1(one,crops)       Price part of area allocation
AREAEQ5(one)             Effective setaside area

EQ_Diff(one,crops)       Diffusion of ligno biomass crops

EQ_QNEW1(one)            Land supply for crops on non setaside land
EQ_QNEW2(one)            Land supply for crops on setaside land
EQ_A1(one)               Land asymptote (for non setaside land)
EQ_A2(one)               Land asymptote (for setaside land)
EQ_LANDMRKT1(one)        Market clearing on land markets (for non setaside land)
EQ_LANDMRKT2(one)        Market clearing on land markets (for setaside land)
DIRPAYEQ(one,comm)       Level of Direct Payment per ton

*Price equations
P_LO_EQ(one,it)          Lower price bound in 1st step of LOGIT function
P_UP_EQ(one,it)          Upper price bound in 1st step of LOGIT function
P_UP_2_EQ(one,it)        Upper price bound in 2nd step of LOGIT function
PRICEQ(cc,it)            Price transmission
PIEQ(cc,comm)            Producer incentive price
PCEQ(cc,comm)            Consumer price
NPDBFEQ(cc,energ,comm)   Net-price for inputs in biofuel production
SPRICEQ(cc,ag)           Shadow price functions for quota products

QUOTAEQ(cc,ag)           set quota limit

FCIEQ(cc,livest)         Feed cost per ton of livestock product
BCIEQ(cc,energ)          Biofuel cost price index (1 in base situation)
TRANSEQ(cc,ag)           For products with margins between PD and PP
*PDEQNMLK(cc,comm)        Price for milk derived from prices of fat and protein


*Other Equations
NETXEQ(cc,it)            Net exports
XSHREQ(cc,it)            Share of net exports in total use for individual c.
XSHR_EUEQ(it)            Share of net exports in total use for EU
*XSHR_DEQ(it)             Share of net exports in total use for delayed integration

CESQUAN(cc,energ,comm)   Unscaled input demand in biofuel production
CESSHR(cc,energ,comm)    Shares in input demand function for biofuel production

SUBSHR_EUEQ(it)          Adjusted share of net exports in total use for the subsidized exports in individual EU-15 members
QUALSHREQ(it)            Adjusted share of net exports in total use for high quality exports in EU
TRQSHR_EUEQ(it)          Adjusted share of net exports in total use for the TRQ into the  EU
SUGIMP_EUEQ(it)          Preferential sugar imports (either endogenous or exogenously fixed

WNXEQ(it)              Market clearing condition for tradeable goods
*WNXEQ(comm)              Market clearing condition for tradeable goods
NTRADEQ(cc,nt)       Regional market clearing condition for nt goods
*NTRADEQ(cc,nt_mlk)       Regional market clearing condition for nt goods
;

* Definition of equations
*# Supply equations
SUPPLYEQ(cc,comm)..   0 =e=
*## Crops in European countries
*### 1) Non-energy crops   (checked)
      [-SUPPLY(cc,comm)  +
*       EFAREA(cc,comm) * YIELD(cc,comm)]$(one(cc) and pr(cc,comm) and crops(comm) and not sa_crp(comm) and not en_crp(comm))
       ALAREA(cc,comm) * YIELD(cc,comm)]$(one(cc) and pr(cc,comm) and crops(comm) )

*## 2) Crops in non-European countries (checked)
     +[-SUPPLY(cc,comm)  +
       exp(sup_int(cc,comm)+sum(crops1$PS(cc,crops1),
       elastsp(cc,comm,crops1)*log(PP(cc,crops1))))
       *tp_gr(cc,comm)*(1+stoch(cc,comm))]$(rest(cc) and pr(cc,comm) and crops(comm))


*## 3) Livestock   (checked)
     +[-SUPPLY(cc,comm) +
         exp(sup_int(cc,comm)
         + sum(livest1$ppp(cc,livest1),elastsp(cc,comm,livest1)*log(PI(cc,livest1)))
         +elast_lv_i(cc,comm)*log(int_ind(cc))
         +elast_lv_l(cc,comm)*log(lab_ind(cc))
         +elast_lv_c(cc,comm)*log(cap_ind(cc))
         +elast_lv_f(cc,comm)*log(FCI(cc,comm)))
         *tp_gr(cc,comm) + subs_milk_s(cc,comm) + FDEM_MLK(cc,comm)]$(pr(cc,comm) and livest(comm))

*## 4) Oils, oilmeal & oilcake from oilseeds  (checked)
     +[-SUPPLY(cc,comm)  +
         sum(oilseed,oilsd_c(cc,comm,oilseed)*PDEM(cc,oilseed))]$oilsproc(cc,comm)

*## 5) Feed from the processing industry (other energy and other proteine, FENE)  [PROBLEM: Numbers are still zero]
     +[-SUPPLY(cc,comm)  +
         exp(sup_int(cc,comm)+ 0.2 * log(PD(cc,comm)))
         *tp_gr(cc,comm)]$fedres(cc,comm)

*## 6) Milk fat and milk protein (checked)
     +[-SUPPLY(cc,comm)  +
         PDEM(cc,'milk')*content_milk(cc,comm)]$MILK_CONT(cc,comm)

*## 7) Dairy products  (checked)
     +[-SUPPLY(cc,comm)*PD(cc,comm)  +
         addcomp_dairy(cc,comm)*SUM(DAIRY_COMP, PD(cc,DAIRY_COMP)*MPDEM(cc,DAIRY_COMP,comm))
                      + subs_milk_d(cc,comm) ]$(MILKPROC(cc,comm) and PR(cc,comm))

*## 8) Biofuels  (checked)
     +[-SUPPLY(cc,comm)  +
        ( exp(sup_int(cc,comm)
         + elastsp(cc,comm,comm) *log(PI(cc,comm))
         + elast_en_inp(cc,comm)*log(BCI(cc,comm))) )*pdem_tr(cc,comm)
       ]$(pr(cc,comm) and energ(comm))


*## 9) Gluten Feed (checked)
     +[-SUPPLY(cc,comm)  +
         SUM((energ,i_ethanol), coef_p_bf(energ,i_ethanol,comm) * PDEM(cc,i_ethanol))
       ]$(pr(cc,comm) and eth_pro(comm))

*## 10) Straw and ligno crops (checked)

     +[-SUPPLY(cc,comm)  +  ALAREA(cc,comm)*YIELD(cc,comm)
      ]$(lino(cc,comm))

     +[-SUPPLY(cc,comm)  + sum(crops, ALAREA(cc,crops)*YIELD(cc,crops)*straw_ratio(cc,crops,'YtoStr'))
      ]$(stra(cc,comm))

;




*# Demand equations
*## 1) Human demand  (checked)
HDEMEQ(cc,comm)..     0    =E=
         [-HDEM(cc,comm)  +
         (exp(subs_shift(cc,comm)*hdem_int(cc,comm) + sum(comm1$PPC(cc,comm1),
         elasthd(cc,comm,comm1)*log(PC(cc,comm1))))*  pop_gr(cc)
         *inc_gr(cc)**elastin(cc,comm)+ subs_milk_d(cc,comm)
         )*hdem_tr(cc,comm)]$(HD(cc,comm) or P0(cc,comm))
;

*## Seed demand
SDEMEQ(cc,comm)..    0     =E=

*### 11) In European Countries   (checked)
        [-SDEM(cc,comm)   +
        seed_c(cc,comm) * ALAREA(cc,comm)]$(one(cc) and pr(cc,comm) and crops(comm))
*### 12) In Non-European Countries   (checked)
      + [-SDEM(cc,comm)   +
        seed_c(cc,comm) * SUPPLY(cc,comm)]$(rest(cc) and pr(cc,comm) and crops(comm));

*## Processing demand
PROCEQ(cc,comm)..   0      =E=

*### 13) For oilseeds  (checked)
         [-PDEM(cc,comm)  +
         (exp(cr_int(cc,comm)+sum(comm1$PS(cc,comm1),
         elastcr(cc,comm,comm1)*log(PD(cc,comm1)))))*pdem_tr(cc,comm)]$PROC_OIL(cc,comm)

*### 14) For oils and sugar and cereals in biofuels (checked)
      +  [-PDEM(cc,comm)  +
         SUM(energ, PDEM_BF(cc,energ,comm))]$(PROC_CER_S(cc,comm) or PROC_OIL_D(cc,comm))

*### 15) For milk to be processed to fat and protein (checked)
      +  [-PDEM(cc,comm) * PD(cc,comm)
          + addcomp_milk(cc,comm) * SUM(dairy_comp, SUPPLY(cc,dairy_comp)*PD(cc,dairy_comp))
         ]$MILK_(cc,comm)

*### 16) For milk fat and protein  (checked)
      +  [-PDEM(cc,comm)  + SUM(mlkproc, MPDEM(cc,comm,mlkproc))]$MILK_CONT(cc,comm)

*### 16) For straw for bioeconomy or soil  (checked)
*      +  [-PDEM(cc,comm)  + SUPPLY(cc,comm)-FDEM(cc,comm)]$stra(cc,comm)
;

PROCW_EQ(cc,comm) ..  0   =E=
*### 17) For processing demand for straw residue  (checked)
        [-PDEM(cc,comm) +
         exp(st_int(cc,comm) + elastst(cc,comm)*log(PD(cc,comm)))
         ]$stra(cc,comm)
;


PROCM_EQ(cc,dairy_comp,comm) ..  0   =E=
*### 17) For fat and protein in different dairy products  (checked)
      +   [-MPDEM(cc,dairy_comp,comm) +
        pdem_tr(cc,comm) * exp(proc_int(cc,dairy_comp,comm)
        +SUM(comm1$PS(cc,comm1),
         elastdm_n(cc,dairy_comp,comm,comm1)*log(PD(cc,comm1)))
         )]$PROC_DAIRY(cc,dairy_comp,comm);

*## Feed demand

*### 18) Feeding stuff     (checked)
FEEDEQ(cc,feed)..   0      =E=
         [-FDEM(cc,feed)  +  (feed_exog(cc,feed)+
         sum(livest, FRATE(cc,feed,livest)* SUPPLY(cc,livest)))*fdem_tr(cc,feed) ]$FD(cc,feed);

*### 19) Feed milk    (checked)
FEEDMEQ(cc,comm)$MLK(comm)..   0          =E=
        [-FDEM_MLK(cc,comm)  +
         SUPPLY(cc,comm) * feed_milk(cc)]$FD_MLK(cc);

*### 20)  Feed rates  (checked)
FRATEEQ(cc,feed,livest)$FR(cc,feed,livest)..   FRATE(cc,feed,livest)     =E=
         exp(frat_int(cc,feed,livest)+sum(feed1$PPF(cc,feed1),
         elastfd(cc,feed,feed1,livest)*log(PD(cc,feed1))))*tp_fr(cc,livest);


*# 21) Total domestic use (checked)
TUSEEQ(cc,comm).. TUSE(cc,comm)                       =E=
         HDEM(cc,comm)+SDEM(cc,comm)+PDEM(cc,comm)+FDEM(cc,comm)+FDEM_MLK(cc,comm)+ subs_milk_s(cc,comm);

*# Agricultural supply components
*## Yield
*### 22) Yield for non quota crops  (checked)
YILDEQ(cc,ag)..      0     =E=
         [- YIELD(cc,ag)    +
         exp(yild_int(cc,ag) +
         elastyd(cc,ag,ag) * log(PP(cc,ag))
         +sum(ecc, elast_y(ecc,cc,ag)*log(cost_ind(ecc,cc)))
         ) * tp_gr(cc,ag) * (1+stoch(cc,ag))]$(one(cc) and pr(cc,ag) and not sameas(ag,'lino') and crops(ag) and nq(cc,ag) and not volsa(cc,ag))

*### 23) Yield for quota crops dependent on shadow price  (checked)
       +
         [- YIELD(cc,ag)    +
         exp(yild_int(cc,ag) +
         elastyd(cc,ag,ag) * log(PP(cc,ag))
         +sum(ecc, elast_y(ecc,cc,ag)*log(cost_ind(ecc,cc)))
         ) * tp_gr(cc,ag)]$(one(cc) and qu_sugar(cc,ag) and crops(ag) and not volsa(cc,ag))
;

*## Area allocation
*### Unrestricted area
AREAEQ1(one,crops)$YIELD0(one,crops)..      0  =E=

*#### 24) For crops other than sugar beet (checked)

         [-ALAREA(one,crops) +
         exp(
         area_int(one,crops)+sum(crops1$ppp(one,crops1),elastsp(one,crops,crops1)*log(PI(one,crops1)))
         +elast_landpr(one,crops)   *log(landprice1(one))
         +sum(ecc,elast_a(ecc,one,crops)*log(cost_ind(ecc,one)))
         )*Diff(one,crops)*area_corpar(one,crops)]$(nonsug(crops) )
         +
*#### 25) For sugar beet  (checked)
         [-ALAREA(one,crops) +
         MAX(
         0,
         (area_add_int_sug(one) + exp(log(area_factor_sug(one)) +
         area_exponent_sug(one) * log(PI(one,crops))))
         )
         *
         exp(
         area_int2_sug(one)+sum( nonsug$ppp(one,nonsug), elastsp(one,crops,nonsug)*log(PI(one,nonsug)))
* New version with variable elasticity
*+(elast_landpr(one,crops)*landprice1(one)/landprice0(one))  *log(landprice1(one))
         +elast_landpr(one,crops)*log(landprice1(one))
         +sum(ecc,elast_a(ecc,one,crops)*log(cost_ind(ecc,one)))
         )
         /
         exp(area_int3_sug(one) + elastyd(one,crops,crops)
                         *log(PP(one,crops)))
         ]$sug(crops)
*#####  For Lignocellosic biomass area with diffusion
         +
         [-ALAREA(one,crops) +
         exp(
         area_int(one,crops)
         +elast_landpr(one,crops) *log(landprice1(one)))*Diff(one,crops)
         ]$(sameas(crops,'lino'))

*#### 25) For lignocellosic biomass(miscantus, short rotation coppice) (checked)

;

EQ_Diff(one,crops)..    0 =E=
*      [
*       -Diff(one,biomass) + exp(-1*(LANDPRICE(one)-200)/200)/(1+exp(-alpha*(time-T_zero)))
*      ]$(sameas(biomass,'ligno') and LP_feedback and not calib)
*      +
      [
       -Diff(one,crops) + ((Peak_LINO_Area(one)-1)*(1/(1+exp(-alpha*(diff_lino-T_zero))))+1)
      ]$(lino(one,crops) and  not calib)
      +
      [
       -Diff(one,crops) + 1
      ]$(nonlino(crops) and  not calib)

*     +
*      [
*       -Diff(one,crops) + (1-( ALAREA(one,'LINO')-base_area('LINO'))*beta(one,crops)/base_area(crops))
*      ]$(nonsug(crops) and not competition and not calib)
      +
      [
       -Diff(one,crops) + 1
      ]$(calib)


;



*### 26) Determination of obligatory set aside area  (checked)
AREAEQ5(one)..     0        =E=
         -OBLSETAS(one)
         +
         [setas_eu15(one)]$eu15(one)
         +
         [setas_eu12(one)]$eu12(one)
         ;
*
*Determination of agricultural land use
*
*### 27)  total available agricultural area for non setaside land  (checked)
EQ_QNEW1(one)..  0     =E=
         [-Q_NEW1(one)       +
         area_max(one) * ch_area(one) - marg_land(one)*OBLSETAS(one)];


*### 28)  land supply for non setaside land  (checked)
EQ_A1(one)..   0  =E=
         [-LANDSUPPLY1(one)
          + Q_NEW1(one) - bend_ld1(one)/(shift_ld(one) +  LANDPRICE1(one))];


*### 29)  market clearing for land non setaside land  (checked)
EQ_LANDMRKT1(one)..    0  =E=
         [-LANDSUPPLY1(one)
*           + SUM(crops, ALAREA(one,crops))];
           + (SUM(crops, ALAREA(one,crops)) + exog_biof(one))];



*# Direct payments
DIRPAYEQ(one,comm)..  0       =E=
*## 30) Direct payments for crops
         [-DIRPAY(one,comm)  +
          (( (OVERALL_DECOUP(one) * prod_effdp(comm,"effdp")) / SUM(comm1,ALAREA(one,comm1))) / YIELD(one,comm))
           +
          ((OVERALL_COUP(one,comm) / ALAREA(one,comm)) / YIELD(one,comm))$(not sameas("sugar",comm))
*          ((OVERALL_COUP(one,comm) / AREA0(one,comm)) / YIELD(one,comm))$(not sameas("sugar",comm) and area0(one,comm))

*** For Sugar, coupled payments are divided by base area because of the possibility to drop out of production during
*** the simulation period, which would cause execution errors ("devision by zero")

          +((OVERALL_COUP(one,comm) / AREA0(one,comm)) / YIELD(one,comm))$(sameas("sugar",comm))

         ]$(area0(one,comm) and member(one) and crops(comm))
          +
*## 31) Direct payments for livestock
          [-DIRPAY(one,comm) +
            (OVERALL_COUP(one,comm) * prod_effdp(comm,"effdp")) / SUPPLY(one,comm)
          ]$(Overall_Coup(one,comm) and livest(comm) and member(one))
;


*# Price equations
*## Definition of lower und upper price bounds
*### Definition of lower bounds

P_LO_EQ(one,it)..  0          =E=

*#### 32) Lower price bound in LOGIT function in NMS prior to accession   (checked)
         [-P_LO(one,it)     +
          PW(it)/exrate(one)*(1+subs_ad(one,it))]$(nomember(one) and PS(one,it))
         +
*#### 33) Lower price bound in LOGIT function in EU for products with intervention price  (checked)
         [-P_LO(one,it)     +
          MAX(PW(it)/exrate(one),intpr (one,it)+exstab(one,it))]$(member(one) and PS(one,it) and not (delay_r(one) and delay_c(it))
                                                                                  and (THRESH(it) or FLOOR(it)))
         +
*#### 34) Lower price bound in LOGIT function in delayed integration regions for non-intervention products  (checked)
         [-P_LO(one,it)     +
          MAX(intpr(one,it), delay(one,it) * (SUM(euro1, (PD("GE",it)+mrktpri0(euro1,it)-PD00("GE",it))
                    *exrate(euro1)) /exrate(one)))]$(delay_r(one) and delay_c(it) and member(one))
        +

*#### 35) Lower price bound in LOGIT function in EU for products without intervention price  (checked)
         [-P_LO(one,it)     +
           PW(it)/exrate(one)]$(member(one) and not (delay_r(one) and delay_c(it))
                                                                        and TAR(it));

*### Definition of upper bounds
P_UP_EQ(one,it)..  0          =E=

*#### 36) Upper price bound in LOGIT function in NMS prior to accession  (checked)
         [-P_UP(one,it)     +
          (PW(it)/exrate(one)*(1+tar_ad(one,it)) )]$(nomember(one) and PS(one,it))
         +
*#### 37) Upper price bound in LOGIT function in EU for products with threshhold prices  (checked)
         [-P_UP(one,it)     +
          MAX(PW(it)/exrate(one),thrpr(one,it))]$(member(one) and THRESH(it))
         +
*#### 38) Upper price bound in LOGIT function in EU for products with ad-valorem or specific tariffs  (checked)
         [-P_UP(one,it)     +
         (PW(it)/exrate(one))*(1+tar_ad(one,it))+sp_d(one,it)]$(member(one) and PS(one,it) and (FLOOR(it) or TAR(it)));


*### 39) Definition of second upper bounds in the EU for products with export subsidies or quality markups  (checked)
P_UP_2_EQ(one,it).. 0         =E=
         [-P_UP_2(one,it)   +
           MAX(exp_sub(one,it),qual_ad(one,it)) + PW(it)/exrate(one)
         ]$(member(one) {and not (delay_r(one) and delay_c(it)) }
                      and (tar(IT) or thresh(it))
                      and EXPSUB(one,it))
;

*##  Price transmission

PRICEQ(cc,it)..    0         =E=
*### 40) Definition of world market price  (checked)
            [-PD(cc,it)      +
             PW(it)]$(PS(cc,it) and REST(cc))
             +
*### 41) Price transmission on EU markets WITHOUT export subsidies  (checked)
             [-PD(cc,it)      +
             (P_UP(cc,it) - P_LO(cc,it))
                  *( (-1)*logitshift(cc,it)*(exp(logit_scale(cc,it)*(trqshr_eu(it)+tradeshr_eu(it)))  /
                     (1+logitshift(cc,it)*exp(logit_scale(cc,it)*(trqshr_eu(it)+tradeshr_eu(it)))) ))
                   + P_UP(cc,it)
             ]$(PS(cc,it) and NEXPSUB(cc,it) and member(cc) and not (delay_r(cc) and delay_c(it)))

*### 42) Price transmission on EU markets WITH export subsidies  (checked)
            +
            [-PD(cc,it)      +
             MAX[
                  (P_UP(cc,it) - P_LO(cc,it))
                  *( (-1)*(exp(trqshr_eu(it) + tradeshr_eu(it))  /
                     (1+exp(trqshr_eu(it) + tradeshr_eu(it)) ) ))
                 + P_UP(cc,it) ,
                  (P_UP_2(cc,it) - P_LO(cc,it))
                  *( (-1)*logitshift(cc,it)*(exp(logit_scale(cc,it)*(tradeshr_eu(it)
                              - SUBSHR_eu(it) - QUALSHR_eu(it) + TRQSHR_eu(it) ))  /
                     (1+logitshift(cc,it)*exp(logit_scale(cc,it)*(tradeshr_eu(it)
                              - SUBSHR_eu(it) - QUALSHR_eu(it) + TRQSHR_eu(it) )
                        )) )) + P_UP_2(cc,it)                 ]
                    ]$(member(cc) and (PS(cc,it)) and (EXPSUB(cc,it)) and not (delay_r(cc) and delay_c(it)))
            +

*### 43) Price transmission on new member states' markets with delayed integration to Single Market  (checked)
            [-PD(cc,it)      +
            (P_UP(cc,it) - P_LO(cc,it))
             *((-1)*logitshift(cc,it)*(exp(tradeshr_d(it))  /
             (1+logitshift(cc,it)*exp(tradeshr_d(it))) ))
             +P_UP(cc,it)]$(member(cc) and PS(cc,it) and delay_r(cc) and delay_c(it))
            +
*### 44) Price transmission on candidate countries' markets prior to EU-accession  (checked)
            [-PD(cc,it)      +
            (P_UP(cc,it) - P_LO(cc,it))
             *((-1)*logitshift(cc,it)*(exp(tradeshr(cc,it))  /
             (1+logitshift(cc,it)*exp(tradeshr(cc,it))) ))
             +P_UP(cc,it)]$(nomember(cc) and PS(cc,it)) ;


*## Determination of shadow prices

SPRICEQ(cc,ag)..  0        =E=
*### 45) For livestock  (checked)
            [-PSH(cc,ag) +
         exp(      (log(quota(cc,ag){-subs_milk(cc,ag)-FDEM_MLK(cc,ag)})
         - sup_int(cc,ag)
*         -sum(ag1$(ord(ag1) ne ord(ag) and ppp(cc,ag1)),
         -sum(ag1$( not sameas(ag1,ag) and ppp(cc,ag1)),
              elastsp(cc,ag,ag1)*log(PI(cc,ag1)))

         -elast_lv_i(cc,ag)*log(int_ind(cc))
         -elast_lv_l(cc,ag)*log(lab_ind(cc))
         -elast_lv_c(cc,ag)*log(cap_ind(cc))
         -elast_lv_f(cc,ag)*log(FCI(cc,ag))
         -log(tp_gr(cc,ag)))
         /elastsp(cc,ag,ag))]$(pr(cc,ag) and livest(ag) and {quota}QU(cc,ag))
            +
*### 46) For crops  (checked)
$ontext
* old sugar  psh equation:
            [-PSH(cc,ag)  +
                 (((quota(cc,ag)*exp(area_int3_sug(cc))
                   /exp(yild_int(cc,ag)
                         +elast_y_i(cc,ag)*log(int_ind(cc))
                         +elast_y_l(cc,ag)*log(lab_ind(cc))
                         +log(tp_gr(cc,ag)))
                   /exp(area_int2_sug(cc)+sum( nonsug$ppp(cc,nonsug), elastsp(cc,ag,nonsug)*log(PI(cc,nonsug)))
                          +elast_landpr(cc,ag)*log(landprice1(cc))
                          +elast_a_i(cc,ag)*log(int_ind(cc))
                          +elast_a_l(cc,ag)*log(lab_ind(cc))
                          +elast_a_c(cc,ag)*log(cap_ind(cc)))
                        )- area_add_int_sug(cc)
                         )*(1/area_factor_sug(cc))
                         )**(1/area_exponent_sug(cc))
                 ]$(one(cc) and pr(cc,ag) and qu_sugar(cc,ag))
$offtext
* new sugar psh equation:
            [-PSH(cc,ag)  +
                (  [quota(cc,ag)
           /
           ( exp(yild_int(cc,ag)) * prod(ecc, cost_ind(ecc,cc)**elast_y(ecc,cc,ag)) * tp_gr(cc,ag)  {from yield eq}
             * exp(area_int2_sug(cc)) * prod(nonsug$ppp(cc,nonsug), PI(cc,nonsug)**elastsp(cc,ag,nonsug))
             * landprice1(cc)**elast_landpr(cc,ag) * prod(ecc, cost_ind(ecc,cc)**elast_a(ecc,cc,ag))
             * [1/exp(area_int3_sug(cc))]                                         {from alarea eq}
           )
                     - area_add_int_sug(cc)
                   ]
         / area_factor_sug(cc)
                )**(1/area_exponent_sug(cc))
       ]$(one(cc) and pr(cc,ag) and qu_sugar(cc,ag))

            +
*### 47) For voluntary setaside  (checked)
            [-PSH(cc,ag)  +
         exp(        (log(quota(cc,ag))
         -area_int(cc,ag)
*         -sum(ag1$( ord(ag1) ne ord(ag)and ppp(cc,ag1)),
         -sum(ag1$(not sameas(ag1,ag) and ppp(cc,ag1)),
         elastsp(cc,ag,ag1)*log(PI(cc,ag1)))
         -elast_landpr(cc,ag)*log(landprice1(cc))
         -sum(ecc, elast_a(ecc,cc,ag)*log(cost_ind(ecc,cc)))
         )
         /(elastsp(cc,ag,ag)))]$volsaq(cc,ag);


*## Price transmission wholesale to producer price
TRANSEQ(cc,ag).. 0    =E=

* The following lines are related to the sequential dynamic version of ESIM
*#### 48) For products with margin
            [-PP(cc,ag)   +
            (1-SUM(lag_period, lag_weight(cc,ag,lag_period))) * PD(cc,ag)   / margin0(cc,ag)
          +                     lag_weight(cc,ag,"t_1"      ) * PD_t1(cc,ag) / margin0(cc,ag)
          +                     lag_weight(cc,ag,"t_2"      ) * PD_t2(cc,ag) / margin0(cc,ag)
            ]$(margin0(cc,ag) ne 0.0 and nq(cc,ag)  )

*#### 49) For products without margin
            +
            [-PP(cc,ag)   +
            (1-SUM(lag_period, lag_weight(cc,ag,lag_period))) * PD(cc,ag)
          +                     lag_weight(cc,ag,"t_1"      ) * PD_t1(cc,ag)
          +                     lag_weight(cc,ag,"t_2"      ) * PD_t2(cc,ag)
            ]$(margin0(cc,ag) eq 0.0  )

*#### 50) For quota products
            +
            [-PP(cc,ag)   +
             MIN(
            (1-SUM(lag_period, lag_weight(cc,ag,lag_period))) * PD(cc,ag)    / margin0(cc,ag)
          +                     lag_weight(cc,ag,"t_1"      ) * PD_t1(cc,ag) / margin0(cc,ag)
          +                     lag_weight(cc,ag,"t_2"      ) * PD_t2(cc,ag) / margin0(cc,ag)
                , PSH(cc,ag))]$(margin0(cc,ag) ne 0.0 and qu(cc,ag)  )
;


*## Consumer prices
*### 51) Agri-food commodities  (checked)
PCEQ(cc,comm).. 0    =E=
            [-PC(cc,comm)   +
             PD(cc,comm) + pctax(cc,comm)]$hd(cc,comm)
            +
*### 52) Crude oil  (checked)
            [-PC(cc,comm)   +
             p0(cc,comm) + pctax(cc,comm)]$cr_oil(comm)
;

*## Producer incentive prices
PIEQ(cc,comm).. 0    =E=

*### 53) Non-quota products  (checked)
            [-PI(cc,comm)   +
             PP(cc,comm) + DIRPAY(cc,comm)]$(nq(cc,comm) and ag(comm))
            +

*### 54) Quota products  (checked)
            [-PI(cc,comm)   +
             MIN((PP(cc,comm) + DIRPAY(cc,comm)),PSH(cc,comm))]$(qu(cc,comm) and ag(comm))
            +

*### 55) Energy crops in the EU on non set-aside  (checked)
            [-PI(cc,comm)   +
             PD(cc,comm) + (pay_biof/SUM((energ,c)$member(c), SUPPLY(c,energ))) * SUM(euro1, exrate(EURO1))/exrate(cc)
             ]$(pr(cc,comm) and energ(comm) and member(cc))
            +

*### 56) Energy crops in non EU  (checked)
            [-PI(cc,comm)   +
             PD(cc,comm) ]$(pr(cc,comm) and energ(comm) and not member(cc))

;


*## Determination of net prices in biofuel production
*### 57) Biodiesel inputs  (checked)
NPDBFEQ(cc,energ,comm).. 0            =E=
             [-NetPD(cc,energ,comm)   +
               PD(cc,comm)
               - SUM(comm1, coef_p_bf(energ,comm,comm1) * PD(cc,comm1))
             ]$(biof_d(energ) and I_DIESEL(COMM))


*### 58) Bioethanol inputs non-sugar  (checked)
            +
             [-NetPD(cc,energ,comm)   +
               PD(cc,comm)
               - SUM(comm1, coef_p_bf(energ,comm,comm1) * PD(cc,comm1))
             ]$(biof_e(energ) and I_ETHANOL_NS(COMM))

*### 59) Bioethanol inputs sugar non-EU  (checked)
            +
             [-NetPD(cc,energ,comm)   +
               PD(cc,comm)
               - SUM(comm1, coef_p_bf(energ,comm,comm1) * PD(cc,comm1))
             ]$(biof_e(energ) and I_ETHANOL_S(COMM) and not member (cc))

*### 60) Bioethanol inputs sugar EU  (checked)

            +
             [-NetPD(cc,energ,comm)   +
               PD('row',comm)/exrate(cc)
               - SUM(comm1, coef_p_bf(energ,comm,comm1) * PD(cc,comm1))
             ]$(biof_e(energ) and I_ETHANOL_S(COMM) and member (cc));



*## Determination of cost indices
*### 61) Feed cost index  (checked)
FCIEQ(cc,livest).. 0            =E=
             [-FCI(cc,livest)   +
               sum(feed,FRATE(cc,feed,livest)
               * PD(cc,feed))/FC_0(cc,livest)]$(pr(cc,livest) and livest(livest));


*### 62) Biofuel cost index  (checked)
BCIEQ(cc,energ).. 0            =E=
             [-BCI(cc,energ)   +
               (sum(comm$I_BIOFUEL(energ,comm), QUANCES0(cc,energ,comm)  * NetPD(cc,energ,comm))
              /
               sum(comm$I_BIOFUEL(energ,comm), QUANCES0(cc,energ,comm)) )
               / BCI0(cc,energ)
             ]$pr(cc,energ);


*# Biofuel technology

*## Determination of unscaled quantities in bio-fuel energy production function
CESQUAN(cc,energ,comm).. 0            =E=

*### 63) Biodiesel  (checked)
             [-QUANCES(cc,energ,comm) +
               1 / biof_CES_int(cc,energ) * biof_CES_shr(cc,energ,comm) / NetPD(cc,energ,comm)**biof_CES_el(CC,energ)
               *sum[comm1$(i_diesel(comm1) or i_ethanol(comm1)), biof_CES_shr(cc,energ,comm1)*NetPD(cc,energ,comm1)**(1-biof_CES_el(CC,energ))]
        **(biof_CES_el(CC,energ)/(1-biof_CES_el(CC,energ)))
             ]$(biof_d(energ) and pr(cc,energ) and i_diesel(comm))
+

*### 64) Bioethanol  (checked)
             [-QUANCES(cc,energ,comm) +
               1 / biof_CES_int(cc,energ) * biof_CES_shr(cc,energ,comm) / NetPD(cc,energ,comm)**biof_CES_el(CC,energ)
               *sum[comm1$(i_diesel(comm1) or i_ethanol(comm1)), biof_CES_shr(cc,energ,comm1)*NetPD(cc,energ,comm1)**(1-biof_CES_el(CC,energ))]
        **(biof_CES_el(CC,energ)/(1-biof_CES_el(CC,energ)))
             ]$(biof_e(energ) and pr(cc,energ) and i_ethanol(comm))
;

*## 65) Scaling of relative input quantities to add up to supply of biofuels
CESSHR(cc,energ,comm).. 0            =E=
             [-PDEM_BF(cc,energ,comm)/convbfcc(cc,energ,comm)
              / SUPPLY(cc,energ)
               +
               QUANCES(cc,energ,comm) / MAX(0.0000001,SUM(comm1, QUANCES(cc,energ,comm1)))
             ]$(pr(cc,energ)  and i_biofuel(energ,comm) );




*# Other equations
*## 66) Net trade per region (checked)
NETXEQ(cc,it)..  NETEXP(cc,it) =E= SUPPLY(cc,it) - TUSE(cc,it) {+ chgtrq(cc,it)};

*## Trade shares
*### 75) Share of net exports in domestic market volume (EU) (checked)
XSHR_EUEQ(it).. 0      =E=
            [-TRADESHR_EU(it)  +

            (SUM(one1$member(one1), NETEXP(one1,it))-C_sugar_exports(it))
            /SUM(one1$member(one1),TUSE(one1,it))*100]$(SUM(member, NX(member,it)));

*### 67) Share of net exports in domestic market volume for new members with delayed market integration
*XSHR_DEQ(it).. 0      =E=
*            [-TRADESHR_D(it)   +
*            SUM(delay_r, NETEXP(delay_r,it))
*            /SUM(delay_r, TUSE(delay_r,it))*100]$DELAY_C(IT);

*### 68) Share of net exports in domestic market volume (individual countries) (checked)
XSHREQ(cc,it).. 0     =E=
            [-TRADESHR(cc,it)  +
             NETEXP(cc,it)/MAX(SUPPLY(cc,it),TUSE(cc,it))*100]$(nomember(cc) and (NX(cc,it) or pr(cc,it)));

*### 69) Share of high quality exports in domestic market volume   (checked)
QUALSHREQ(it)$(QUALQUANT(it)).. QUALSHR_EU(it)   =E=
         QUALQUANT(it)/SUM(one$member(one),TUSE(one,it))*100;

*### 70) Share of export subsidy limit in domestic market volume   (checked)
SUBSHR_EUEQ(it).. SUBSHR_EU(it)       =E=    SUBSQUANT(it)  /SUM(cc$member(cc),tuse(cc,it))*100;

*### 71) Share of TRQ in domestic market volume   (checked)
TRQSHR_EUEQ(it).. TRQSHR_EU(it)       =E=
         [TRQ(it)        /SUM(cc$member(cc),tuse(cc,it))*100]$(not(sug(it)))
+
         [SUGIMP_EU(it)  /SUM(cc$member(cc),tuse(cc,it))*100]$(sug(it))
         ;

*### 72) Preferential Sugar imports or pre-fixed sugar imports   (checked)
SUGIMP_EUEQ(it).. SUGIMP_EU(it)       =E=
         [MIN(preftrq,trq_int  * MAX(0,
                                         MAX(0.00001,(PD('UK','SUGAR') *exrate('UK')/SUM(euro1, exrate(euro1))
                                              - PW("SUGAR") /SUM(euro1, exrate(euro1))- trq_tc)
                                            )** trq_elast
                                 )
             )]$(sug(it) and (endog_sug eq 2.0))
+
         [sug_imp_exog(it)]$(sug(it) and (endog_sug eq 1.0))
         ;

*## 73) World market clearing condition    (checked)
WNXEQ(it)..         SUM(cc, NETEXP(cc,it)) =E=  0.0 ;

*## 74) Regional market clearing for non-tradable products
NTRADEQ(cc,nt)$TUSE0(cc,nt)..  SUPPLY(cc,nt)  =E=  TUSE(cc,nt) ;
*NTRADEQ(cc,nt_mlk)..  SUPPLY(cc,nt_mlk)  =E=  TUSE(cc,nt_mlk) ;

*## 75) Determination of milk prices derived from fat and protein prices
*PDEQNMLK(cc,comm)$MILK_(cc,comm)..  PD(cc,comm) =E= [addcomp_milk(cc,comm)
*    *SUM(dairy_comp, content(cc,dairy_comp) * PD(cc,dairy_comp))];


model esimmcp mcp model structure
/
SUPPLYEQ.SUPPLY   , {Supply equations}
HDEMEQ.HDEM       , {Human demand}
SDEMEQ.SDEM       , {Seed demand}
PROCEQ.PDEM       , {Processing activities}
PROCM_EQ.MPDEM    , {Processing demand for fresh milk}
PROCW_EQ.PDEM     , {Processing activities of straw}
FEEDEQ.FDEM       , {Feed demand}
FEEDMEQ.FDEM_MLK  , {feed milk}
FRATEEQ.FRATE     , {Feed rate for livestock products}
TUSEEQ.TUSE       , {Total domestic use}
YILDEQ.YIELD      , {Yields crops}
AREAEQ1.ALAREA    , {Price part of area allocation}

AREAEQ5.OBLSETAS  , {Effective setaside area}
EQ_A1.LANDSUPPLY1, {Landsupply}

EQ_LANDMRKT1.LANDPRICE1,        {Market clearing land market}

EQ_QNEW1.Q_NEW1     , {Maximum area without eff. oblig. setaside}

DIRPAYEQ.DIRPAY   , {Total direct payments}
P_LO_EQ.P_LO      , {Lower price bound in 1st step of LOGIT function}
P_UP_EQ.P_UP      , {Upper price bound in 1st step of LOGIT function}
P_UP_2_EQ.P_UP_2  , {Upper price bound in 2nd step of LOGIT function}
PRICEQ.PD         , {Price transmission}
PIEQ.PI           , {producer incentive price}
PCEQ.PC           , {consumer price}
SPRICEQ.PSH       , {Shadow price functions for quota products}

FCIEQ.FCI         , {Feed cost per ton of livestock product}
TRANSEQ.PP        , {For products with margins between PD and PP}
NETXEQ.NETEXP     , {Net exports}
XSHREQ.TRADESHR   , {Share of net exports in total use for individual c.}
XSHR_EUEQ.TRADESHR_EU   , {Share of net exports in total use for individual EU-15 states}
SUBSHR_EUEQ.SUBSHR_EU   , {Adjusted share of net exports in total use for the subsidized exports in EU}
QUALSHREQ.QUALSHR_EU , {Adjusted share of net exports in total use for the quality exports in EU}
TRQSHR_EUEQ.TRQSHR_EU   , {Adjusted share of net exports in total use for the TRQ into the  EU}
SUGIMP_EUEQ.SUGIMP_EU   , {Imports of sugar under preferential agreements or pre-fixed}
WNXEQ.PW          , {Market clearing condition for tradeable goods}
NTRADEQ.PD        , {Regional market clearing condition for nt goods}
*PDEQNMLK.PD       ,
CESQUAN.QUANCES   , {Unscaled input demand in biofuel production}
CESSHR.PDEM_BF    , {Shares in input demand function for biofuel production}
BCIEQ.BCI         ,
NPDBFEQ.NetPD     ,
EQ_DIFF.DIFF      ,  {diffusion of lignocelluosic biomass}
*XSHR_DEQ.TRADESHR_D
/;




  option MCP=PATH;
*  option iterlim=0, limcol=2000, limrow=2000;
  option limcol=20,limrow=20;
 SOLVE ESIMMCP using MCP;



parameter
transter_yield(cc,comm)
transter_area(cc,comm)
transter_supply(cc,comm)
transter_dir(cc,comm)
;

transter_yield(cc,comm)
 = yield.l(cc,comm);

transter_area(cc,comm)
 = ALAREA.l(cc,comm);

transter_supply(cc,comm)
 = supply.l(cc,comm);

transter_dir(cc,comm)
 =dirpay.l(cc,comm);
display  transter_supply;
