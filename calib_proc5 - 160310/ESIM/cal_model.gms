* modifies esim model for baseline parameter calibration

VARIABLES
* new variables for calibration procedure
  TP_GR_EU(cc,comm)          common technical progress multiplier for eu countries
  TP_GR_EUGRP(EUGRP,comm)    common technical progress multiplier for group of eu countries
  SUPPLYGRP(EUGRP, comm)     sum of SUPPLY over all member countries of a group
  TP_GR_NONEU(comm)          common technical progress multiplier for non-eu countries
  HDEM_TR_EU(cc,comm)        humand demand trend multiplier for european countries
  HDEM_TR_EUGRP(EUGRP,comm)  humand demand trend multiplier for group of european countries
  PDEM_TR_CAL(cc,comm)        processing demand trend multiplier for european countries
  PDEM_TR_CALGRP(CTRYGRP,comm)  processing demand trend multiplier for group of european countries
  PDEM_TR_NONEU_BF(comm)     common trend multiplier for non-eu countries
  PDEM_TR_NONEU_OIL(comm)    common trend multiplier for non-eu countries to produce oil comm
  TUSEGRP(EUGRP, comm)       sum of TUSE over all member countries of a group
  FDEM_TR_EU(cc,comm)        feed demand trend multiplier for all EU countries to adapt TUSE
  FDEM_TR_EUGRP(EUGRP,comm)  feed demand trend multiplier for all EU country gropus to adapt TUSE
;

ALIAS (mlkproc, mlkproc1);

EQUATIONS
  SUPPLYEQ_EU(cc,comm)              supply for EU commodities NOT calibrated directly in the supply equation
  SUPPLYEQ_EU_CAL(cc,comm)          supply for EU commodities calibrated directly in the supply equation
  SUPPLYEQ_NONEU(cc,comm)           supply for non-EU commodities which calibrate to the world market price PW
  SUPPLYEQ_NONEU_ENERG(NONEU,comm)  supply for non-EU biofuel commodities which calibrate to the world market price PW
  HDEMEQ_EU(cc,comm)
  HDEMEQ_EU_CAL(cc,comm)            for commodities under calibration
  HDEM_TR_EUEQ(EUGRP, cc, comm)     set all calibration params HDEM_TR_EU within one country group equal
  TUSE_EUGRPEQ(EUGRP, comm)         sum up TUSE over all member countries of a group
  HDEMEQ_NONEU(cc,comm)
  PROCEQ_STD(cc,comm)                processing demand from non-calibrated products
  PROCEQ_EU_CAL(cc,comm)             processing demand from calibrated products
  PROCM_EQ_STD(cc,dairy_comp,comm)   demand for FAT and PROTEIN from the different dairy products (products with SUPPLY not calibrated)
  PROCM_EQ_CAL(cc,dairy_comp,comm)   demand for FAT and PROTEIN from the different dairy products (products with SUPPLY calibrated)
  PDEM_TR_CALEQ(CTRYGRP, cc, comm)    set all calibration params PDEM_TR_CAL within one country group equal
  PROCEQ_NONEU(cc,comm)
  FEEDEQ_STD(cc,comm)                standard FEEDEQ for non-oilseeds and non-EU countries
  FEEDEQ_EU_CAL(cc,comm)             adapt FDEM to meet TUSE for oilseeds
  FDEM_TR_EUEQ(EUGRP,cc,comm)        set all calibration params FDEM_TR_EU within one country group equal
  FDEM_TR_HDEM_TR_LINKEQ(EUGRP,comm) for TUSE(crops) calibration HDEM_TR and FDEM_TR are shifted identically
  FDEM_TR_HDEM_TRcc_LINKEQ(cc,comm)  for TUSE(crops) calibration HDEM_TR and FDEM_TR are shifted identically
  YILDEQ_EU(cc,ag)                   yield for european countries
  YILDEQ_EU_CAL(cc,ag)               yield for european countries with calibration
  TP_GR_EUEQ(EUGRP, cc, ag)          set all calibration params TP_GR_EU within one country group equal
  SUPPLY_EUGRPEQ(EUGRP, comm)        sum up SUPPLY over all member countries of a group

  SPRICEQ_STD(cc,ag)                 determination of shadow prices for quota products (standard ESIM)
  SPRICEQ_CAL(cc,ag)                 determination of shadow prices for quota products (calibration)

  WNXEQ_PWFIX(it)
  WNXEQ_PWFREE(it)
  WNXEQ_PWFIX_ENERG(it)
  WNXEQ_PWFIX_OIL(it)
  WNXEQ_PWFIX_DAIRY(it)
;

*# Supply equations
SUPPLYEQ_EU(cc,comm)$( (NOT NONEU(cc) OR nt(comm))
         AND NOT (SUPPLY_CScc(cc,comm) AND (LIVEST(comm) OR ENERG(comm))) )..
      0 =e=
*## Crops in European countries
*### 1) Non-energy crops
      [-SUPPLY(cc,comm)  +
*       EFAREA(cc,comm) * YIELD(cc,comm)]$(one(cc) and pr(cc,comm) and crops(comm) and not sa_crp(comm) and not en_crp(comm))
       ALAREA(cc,comm) * YIELD(cc,comm)]$(one(cc) and pr(cc,comm) and crops(comm) )

*## 2) Crops in non-European countries
     +[-SUPPLY(cc,comm)  +
       exp(sup_int(cc,comm)+sum(crops1$PS(cc,crops1),
       elastsp(cc,comm,crops1)*log(PP(cc,crops1))))
       *tp_gr(cc,comm)*(1+stoch(cc,comm))]$(rest(cc) and pr(cc,comm) and crops(comm))

*## 3) Livestock
     +[-SUPPLY(cc,comm) +
         exp(sup_int(cc,comm)
         + sum(livest1$ppp(cc,livest1),elastsp(cc,comm,livest1)
         *log(PI(cc,livest1) ))
         +elast_lv_i(cc,comm)*log(int_ind(cc))
         +elast_lv_l(cc,comm)*log(lab_ind(cc))
         +elast_lv_c(cc,comm)*log(cap_ind(cc))
         +elast_lv_f(cc,comm)*log(FCI(cc,comm)))
         *tp_gr(cc,comm) + subs_milk_s(cc,comm) + FDEM_MLK(cc,comm)]$(pr(cc,comm) and livest(comm))

*## 4) Oil and oilmeal / oilcake
     +[-SUPPLY(cc,comm)  +
         sum(oilseed,oilsd_c(cc,comm,oilseed)*PDEM(cc,oilseed))]$oilsproc(cc,comm)

*## 5) Feed from the processing industry (other energy and other proteine)  [PROBLEM: Numbers are still zero]
     +[-SUPPLY(cc,comm)  +
         exp(sup_int(cc,comm)+ 0.2 * log(PD(cc,comm)))
         *tp_gr(cc,comm)]$fedres(cc,comm)

*## 6) Milk fat and milk protein
     +[-SUPPLY(cc,comm)  +
         PDEM(cc,'milk')*content_milk(cc,comm)]$MILK_CONT(cc,comm)

*## 7) Dairy products
     +[-SUPPLY(cc,comm)*PD(cc,comm)  +
         addcomp_dairy(cc,comm)*SUM(DAIRY_COMP, PD(cc,DAIRY_COMP)*MPDEM(cc,DAIRY_COMP,comm))
                      + subs_milk_d(cc,comm) ]$(MILKPROC(cc,comm) and PR(cc,comm))

*## 8) Biofuels
     +[-SUPPLY(cc,comm)  +
        ( exp(sup_int(cc,comm)
         + elastsp(cc,comm,comm) *log(PI(cc,comm))
         + elast_en_inp(cc,comm)*log(BCI(cc,comm))) )*pdem_tr(cc,comm)
       ]$(pr(cc,comm) and energ(comm))

*## 9) Gluten Feed
     +[-SUPPLY(cc,comm)  +
         SUM((energ,i_ethanol), coef_p_bf(energ,i_ethanol,comm) * PDEM(cc,i_ethanol))
       ]$(pr(cc,comm) and eth_pro(comm))

*## 10) Straw and ligno crops (checked)
     +[-SUPPLY(cc,comm)  + sum(crops, ALAREA(cc,crops)*YIELD(cc,crops)*straw_ratio(cc,crops,'YtoStr'))
      ]$(stra(cc,comm))

     +[-SUPPLY(cc,comm)  +  ALAREA(cc,comm)*YIELD(cc,comm)
      ]$(lino(cc,comm))

;

SUPPLYEQ_EU_CAL(cc,comm)$(SUPPLY_CScc(cc,comm) AND (NOT NONEU(cc) OR nt(comm))
         AND (LIVEST(comm) OR ENERG(comm)) )..
     0 =e=
*## 3) Livestock
     +[-SUPPLY(cc,comm) + exp(sup_int(cc,comm) + sum(livest1$ppp(cc,livest1),elastsp(cc,comm,livest1)
         *log(PI(cc,livest1) ))+elast_lv_i(cc,comm)*log(int_ind(cc))+elast_lv_l(cc,comm)*log(lab_ind(cc))
         +elast_lv_c(cc,comm)*log(cap_ind(cc))+elast_lv_f(cc,comm)*log(FCI(cc,comm)))
         *TP_GR_EU(cc,comm)*tp_gr(cc,comm) + subs_milk_s(cc,comm) + FDEM_MLK(cc,comm)]$(pr(cc,comm) and livest(comm))
*## 8) Biofuels
     +[-SUPPLY(cc,comm)  +
        ( exp(sup_int(cc,comm)
         + elastsp(cc,comm,comm) *log(PI(cc,comm))
         + elast_en_inp(cc,comm)*log(BCI(cc,comm))) )*PDEM_TR_CAL(cc,comm)*pdem_tr(cc,comm)
       ]$(pr(cc,comm) and energ(comm))
;

*# Supply equations
SUPPLYEQ_NONEU(NONEU(cc),it)$(NOT (ENERG(it) AND PW_CS(it)) )..   0 =e=
*## Crops in European countries
*### 1) Non-energy crops
*      [-SUPPLY(cc,it)  +
*       ALAREA(cc,it) * YIELD(cc,it)]$(one(cc) and pr(cc,it) and crops(it) )

*## 2) Crops in non-European countries
     [-SUPPLY(cc,it)  +
       exp(sup_int(cc,it)+sum(crops1$PS(cc,crops1),
       elastsp(cc,it,crops1)*log(PP(cc,crops1))))
       *tp_gr(cc,it)*TP_GR_NONEU(it)*(1+stoch(cc,it))]$(rest(cc) and pr(cc,it) and crops(it))

*## 3) Livestock
     +[-SUPPLY(cc,it) +
         exp(sup_int(cc,it)
         + sum(livest1$ppp(cc,livest1),elastsp(cc,it,livest1)
         *log(PI(cc,livest1) ))
         +elast_lv_i(cc,it)*log(int_ind(cc))
         +elast_lv_l(cc,it)*log(lab_ind(cc))
         +elast_lv_c(cc,it)*log(cap_ind(cc))

         +elast_lv_f(cc,it)*log(FCI(cc,it)))

         *tp_gr(cc,it)*TP_GR_NONEU(it) + subs_milk_s(cc,it) + FDEM_MLK(cc,it)]$(pr(cc,it) and livest(it))

*## 4) Oils, oilmeal & oilcake from oilseeds
     +[-SUPPLY(cc,it)  +
         sum(oilseed,oilsd_c(cc,it,oilseed)*PDEM(cc,oilseed))]$oilsproc(cc,it)

*## 5) Feed from the processing industry (other energy and other proteine)  [PROBLEM: Numbers are still zero]
     +[-SUPPLY(cc,it)  +
         exp(sup_int(cc,it)+ 0.2 * log(PD(cc,it)))
         *tp_gr(cc,it)*TP_GR_NONEU(it)]$fedres(cc,it)

*## 6) Milk fat and milk protein
     +[-SUPPLY(cc,it)  +
         PDEM(cc,'milk')*content_milk(cc,it)]$MILK_CONT(cc,it)

*## 7) Dairy products
     +[-SUPPLY(cc,it)*PD(cc,it)  +
         addcomp_dairy(cc,it)*SUM(DAIRY_COMP, PD(cc,DAIRY_COMP)*MPDEM(cc,DAIRY_COMP,it))
                      + subs_milk_d(cc,it) ]$(MILKPROC(cc,it) and PR(cc,it))

*## 8) Biofuels
     +[-SUPPLY(cc,it)  +
        ( exp(sup_int(cc,it)
         + elastsp(cc,it,it) *log(PI(cc,it))
         + elast_en_inp(cc,it)*log(BCI(cc,it))) )*pdem_tr(cc,it)
       ]$(pr(cc,it) and energ(it))

*## 9) Gluten Feed
     +[-SUPPLY(cc,it)  +
         SUM((energ,i_ethanol), coef_p_bf(energ,i_ethanol,it) * PDEM(cc,i_ethanol))
       ]$(pr(cc,it) and eth_pro(it))

;

SUPPLYEQ_NONEU_ENERG(NONEU(cc),it)$(ENERG(it) AND PW_CS(it))..   0 =e=
*## 8) Biofuels
     [-SUPPLY(cc,it)  +
        ( exp(sup_int(cc,it)
         + elastsp(cc,it,it) *log(PI(cc,it))
         + elast_en_inp(cc,it)*log(BCI(cc,it))) )*pdem_tr(cc,it)*PDEM_TR_NONEU_BF(it)
       ]$(pr(cc,it) and energ(it))
;

*# Demand equations
*## 10) Human demand
HDEMEQ_EU(cc,comm)$(((NOT NONEU(cc)) AND (NOT TUSE_CScc(cc,comm))) )..     0    =E=
         [-HDEM(cc,comm)  +
         (exp(subs_shift(cc,comm)*hdem_int(cc,comm) + sum(comm1$PPC(cc,comm1),
         elasthd(cc,comm,comm1)*log(PC(cc,comm1))))*pop_gr(cc)
         *inc_gr(cc)**elastin(cc,comm)+ subs_milk_d(cc,comm)
         )*hdem_tr(cc,comm)]$(HD(cc,comm) or P0(cc,comm))
;

HDEMEQ_EU_CAL(cc,comm)$((NOT NONEU(cc)) AND TUSE_CScc(cc,comm) )..     0    =E=
         [-HDEM(cc,comm)  +
         (exp(subs_shift(cc,comm)*hdem_int(cc,comm) + sum(comm1$PPC(cc,comm1),
         elasthd(cc,comm,comm1)*log(PC(cc,comm1))))*pop_gr(cc)
         *inc_gr(cc)**elastin(cc,comm)+ subs_milk_d(cc,comm)
         )*HDEM_TR_EU(cc,comm)*hdem_tr(cc,comm)]$(HD(cc,comm) or P0(cc,comm))
;

HDEM_TR_EUEQ(EUGRP, cc, comm)$({HDEM0(cc,comm) AND} EUGRPMEM(EUGRP,cc) AND TUSE_CS(EUGRP, comm))..
         HDEM_TR_EUGRP(EUGRP,comm) =E= HDEM_TR_EU(cc,comm);

TUSE_EUGRPEQ(EUGRP, comm)$TUSE_CS(EUGRP, comm)..
         TUSEGRP(EUGRP, comm) =E= sum(EUGRPMEM(EUGRP,cc), TUSE(cc, comm));

*## 10) Human demand
HDEMEQ_NONEU(NONEU(cc),comm)..     0    =E=
         [-HDEM(cc,comm)  +
         (exp(subs_shift(cc,comm)*hdem_int(cc,comm) + sum(comm1$PPC(cc,comm1),
         elasthd(cc,comm,comm1)*log(PC(cc,comm1))))*pop_gr(cc)
         *inc_gr(cc)**elastin(cc,comm)+ subs_milk_d(cc,comm)
         )*hdem_tr(cc,comm)]$(HD(cc,comm) or P0(cc,comm))
;

*## Processing demand
PROCEQ_STD(cc,comm)$(nt(comm) OR (NOT sum(PROD2INPUT(comm1,comm), NONEU(cc) AND PW_CS(comm1) AND PROC_OIL(cc,comm)) AND
         NOT sum(PROD2INPUT(comm1,comm),SUPPLY_CScc(cc,comm1) AND PROC_OIL(cc,comm)) ) )..
         0 =E=
*### 13) For oilseeds
         [-PDEM(cc,comm)  +
         (exp(cr_int(cc,comm)+sum(comm1$PS(cc,comm1),
         elastcr(cc,comm,comm1)*log(PD(cc,comm1)))))*pdem_tr(cc,comm)]$PROC_OIL(cc,comm)

*### 14) For oils and sugar and cereals in biofuels
      +  [-PDEM(cc,comm)  +
         SUM(energ, PDEM_BF(cc,energ,comm))]$(PROC_CER_S(cc,comm) or PROC_OIL_D(cc,comm))

*### 15) For milk to be processed to fat and protein
      +  [-PDEM(cc,comm) * PD(cc,comm)
          + addcomp_milk(cc,comm) * SUM(dairy_comp, SUPPLY(cc,dairy_comp)*PD(cc,dairy_comp))
         ]$MILK_(cc,comm)

*### 16) For milk fat and protein
      +  [-PDEM(cc,comm)  + SUM(mlkproc, MPDEM(cc,comm,mlkproc))]$MILK_CONT(cc,comm)
;



* PDEM is only used to calibrate plant oils by increasing PDEM of the corresponding oilseed
PROCEQ_EU_CAL(cc,comm)$((NOT NONEU(cc) OR nt(comm))  AND (sum(PROD2INPUT(comm1,comm),SUPPLY_CScc(cc,comm1) AND PROC_OIL(cc,comm))))..   0      =E=
*### 13) For oilseeds
         [-PDEM(cc,comm)  +
         (exp(cr_int(cc,comm)+sum(comm1$PS(cc,comm1),
         elastcr(cc,comm,comm1)*log(PD(cc,comm1)))))*sum(PROD2INPUT(comm1,comm), PDEM_TR_CAL(cc,comm))*pdem_tr(cc,comm)
         ];

PDEM_TR_CALEQ(CTRYGRP, cc, comm)$({(PDEM0(cc,comm) OR sum(dairy_comp,dairy_pdem(comm,dairy_comp,cc)) OR (PROD0(cc,comm) AND ENERG(comm))) AND} CTRYGRPMEM(CTRYGRP,cc) AND (
         sum(PROD2INPUT(comm1,comm),SUPPLY_CScc(cc,comm1) AND PROC_OIL(cc,comm))
         OR (SUPPLY_CScc(cc,comm) AND ENERG(comm))
         OR (SUPPLY_CScc(cc,comm) AND MLKPROC(comm))
         OR (PW_CS(comm) AND NONEU(cc) AND MLKPROC(comm))
         ) )..
         PDEM_TR_CALGRP(CTRYGRP,comm) =E= PDEM_TR_CAL(cc,comm);



*## Processing demand
PROCEQ_NONEU(NONEU(cc),it)$( sum(PROD2INPUT(it1,it), PW_CS(it1) AND PROC_OIL(cc,it)) )..   0      =E=
*### 13) For oilseeds
         [-PDEM(cc,it)  +
         (exp(cr_int(cc,it)+sum(it1$PS(cc,it1),
         elastcr(cc,it,it1)*log(PD(cc,it1)))))*sum(it1$PROD2INPUT(it1,it), PDEM_TR_NONEU_OIL(it))*pdem_tr(cc,it)]$sum(PROD2INPUT(it1,it), PW_CS(it1) AND PROC_OIL(cc,it))
*### 14) For oils and sugar and cereals in biofuels
      +  [-PDEM(cc,it)  +
         SUM(energ, PDEM_BF(cc,energ,it))]$(PROC_CER_S(cc,it) or PROC_OIL_D(cc,it))

*### 15) For milk to be processed to fat and protein
      +  [-PDEM(cc,it) * PD(cc,it)
          + addcomp_milk(cc,it) * SUM(dairy_comp, SUPPLY(cc,dairy_comp)*PD(cc,dairy_comp))
         ]$MILK_(cc,it)

*### 16) For milk fat and protein
      +  [-PDEM(cc,it)  + SUM(mlkproc, MPDEM(cc,it,mlkproc))]$MILK_CONT(cc,it)
;

*### 17) For fat and protein in different dairy products
PROCM_EQ_STD(cc,dairy_comp,comm)$(PROC_DAIRY(cc,dairy_comp,comm) AND NOT (SUPPLY_CScc(cc,comm) OR (PW_CS(comm) AND NONEU(cc))) )..  0   =E=
          -MPDEM(cc,dairy_comp,comm) + pdem_tr(cc,comm) * exp(proc_int(cc,dairy_comp,comm)
          + SUM(comm1$PS(cc,comm1), elastdm_n(cc,dairy_comp,comm,comm1)*log(PD(cc,comm1))) );

PROCM_EQ_CAL(cc,dairy_comp,comm)$(PROC_DAIRY(cc,dairy_comp,comm) AND (SUPPLY_CScc(cc,comm) OR (PW_CS(comm) AND NONEU(cc))) )..  0   =E=
          -MPDEM(cc,dairy_comp,comm) + PDEM_TR_CAL(cc,comm) * pdem_tr(cc,comm) * exp(proc_int(cc,dairy_comp,comm)
          + SUM(comm1$PS(cc,comm1), elastdm_n(cc,dairy_comp,comm,comm1)*log(PD(cc,comm1))) );

*### 18) Feeding stuff
FEEDEQ_STD(cc,feed)$((NOT TUSE_CScc(cc,feed)) OR NOT(crops(feed) OR MLKPROC(feed)))..   0      =E=
         [-FDEM(cc,feed)  +  (feed_exog(cc,feed)+
         sum(livest, FRATE(cc,feed,livest)* SUPPLY(cc,livest)))*fdem_tr(cc,feed) ]$FD(cc,feed);

* TUSE is met by adapting FDEM and HDEM when both are available
FEEDEQ_EU_CAL(cc,feed)$(TUSE_CScc(cc,feed) AND (crops(feed) OR MLKPROC(feed)) )..   0      =E=
         [-FDEM(cc,feed)  +  (feed_exog(cc,feed)+
         sum(livest, FRATE(cc,feed,livest)* SUPPLY(cc,livest)))*FDEM_TR_EU(cc,feed)*fdem_tr(cc,feed) ]$FD(cc,feed);

* set all FDEM_TR_EU within an EUGRP equal:
FDEM_TR_EUEQ(EUGRP,cc,feed)$({FDEM0(cc,feed) AND} EUGRPMEM(EUGRP,cc) AND TUSE_CS(EUGRP,feed))..
         FDEM_TR_EUGRP(EUGRP,feed) =E= FDEM_TR_EU(cc,feed);

* for TUSE(oilseed) calibration, FDEM and HDEM are shifted identically:
FDEM_TR_HDEM_TR_LINKEQ(EUGRP,feed)$({sum(EUGRPMEM(EUGRP,cc), FDEM0(cc,feed)) AND sum(EUGRPMEM(EUGRP,cc), HDEM0(cc,feed)) AND} TUSE_CS(EUGRP,feed))..
         FDEM_TR_EUGRP(EUGRP,feed) =E= HDEM_TR_EUGRP(EUGRP,feed);

* YIELD
*### 22) Yield for non quota crops
YILDEQ_EU(cc,ag)$(NOT SUPPLY_CScc(cc,ag))..      0     =E=
         [- YIELD(cc,ag) + exp(yild_int(cc,ag) + elastyd(cc,ag,ag) * log(PP(cc,ag)) +sum(ecc, elast_y(ecc,cc,ag)*log(cost_ind(ecc,cc)))
          ) * tp_gr(cc,ag) * (1+stoch(cc,ag))
         ]$(one(cc) and pr(cc,ag) and crops(ag) and nq(cc,ag) and not volsa(cc,ag))
*### 23) Yield for quota crops dependent on shadow price
       + [- YIELD(cc,ag)  + exp(yild_int(cc,ag) + elastyd(cc,ag,ag) * log(PP(cc,ag)) +sum(ecc, elast_y(ecc,cc,ag)*log(cost_ind(ecc,cc)))
          ) * tp_gr(cc,ag)
         ]$(one(cc) and qu_sugar(cc,ag) and crops(ag) and not volsa(cc,ag));

*### 22) Yield for non quota crops
YILDEQ_EU_CAL(cc,ag)$(SUPPLY_CScc(cc,ag))..      0     =E=
         [- YIELD(cc,ag) + exp(yild_int(cc,ag) + elastyd(cc,ag,ag) * log(PP(cc,ag)) +sum(ecc, elast_y(ecc,cc,ag)*log(cost_ind(ecc,cc)))
          ) * TP_GR_EU(cc,ag) * tp_gr(cc,ag) * (1+stoch(cc,ag))
         ]$(one(cc) and pr(cc,ag) and crops(ag) and nq(cc,ag) and not volsa(cc,ag))
*### 23) Yield for quota crops dependent on shadow price
       + [- YIELD(cc,ag)  + exp(yild_int(cc,ag) + elastyd(cc,ag,ag) * log(PP(cc,ag)) +sum(ecc, elast_y(ecc,cc,ag)*log(cost_ind(ecc,cc)))
          ) * TP_GR_EU(cc,ag) * tp_gr(cc,ag)
         ]$(one(cc) and qu_sugar(cc,ag) and crops(ag) and not volsa(cc,ag));

* link all TP_GR within an EUGRP together:
TP_GR_EUEQ(EUGRP, cc, ag)$({PROD0(cc,ag) AND} EUGRPMEM(EUGRP,cc) AND SUPPLY_CScc(cc, ag))..
         TP_GR_EUGRP(EUGRP,ag) =E= TP_GR_EU(cc,ag);

* aggregate to target SUPPLY value:
SUPPLY_EUGRPEQ(EUGRP, comm)$SUPPLY_CS(EUGRP, comm)..
         SUPPLYGRP(EUGRP, comm) =E= sum(EUGRPMEM(EUGRP,cc), SUPPLY(cc, comm));

*## Determination of shadow prices

SPRICEQ_STD(cc,ag)$(NOT SUPPLY_CScc(cc,ag))..  0        =E=
*### 45) For livestock
            [-PSH(cc,ag) +
         exp(      (log(quota(cc,ag){-subs_milk(cc,ag)-FDEM_MLK(cc,ag)})
         - sup_int(cc,ag)
         -sum(ag1$((not sameas(ag1,ag)) and ppp(cc,ag1)),
         elastsp(cc,ag,ag1)*log(PI(cc,ag1)))
         -elast_lv_i(cc,ag)*log(int_ind(cc))
         -elast_lv_l(cc,ag)*log(lab_ind(cc))
         -elast_lv_c(cc,ag)*log(cap_ind(cc))
         -elast_lv_f(cc,ag)*log(FCI(cc,ag))
         -log(tp_gr(cc,ag)))
         /elastsp(cc,ag,ag))]$(pr(cc,ag) and livest(ag) and quota(cc,ag))
            +
*### 46) For crops
            [-PSH(cc,ag)  +
                (  [quota(cc,ag)
           /
           ( exp(yild_int(cc,ag)) * prod(ecc, cost_ind(ecc, cc)**elast_y(ecc, cc,ag)) * tp_gr(cc,ag)  {from yield eq}
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
*### 47) For voluntary setaside
            [-PSH(cc,ag)  +
         exp(        (log(quota(cc,ag))
         -area_int(cc,ag)
         -sum(ag1$((not sameas(ag1,ag))and ppp(cc,ag1)),
         elastsp(cc,ag,ag1)*log(PI(cc,ag1)))
         -elast_landpr(cc,ag)*log(landprice1(cc))
         -sum(ecc, elast_a(ecc,cc,ag)*log(cost_ind(ecc,cc)))
         )
         /(elastsp(cc,ag,ag)))]$volsaq(cc,ag);


SPRICEQ_CAL(cc,ag)$SUPPLY_CScc(cc,ag)..  0        =E=
*### 45) For livestock
            [-PSH(cc,ag) +
         exp(      (log(quota(cc,ag){-subs_milk(cc,ag)-FDEM_MLK(cc,ag)})
         - sup_int(cc,ag)
         -sum(ag1$((not sameas(ag1,ag)) and ppp(cc,ag1)),
         elastsp(cc,ag,ag1)*log(PI(cc,ag1)))
         -elast_lv_i(cc,ag)*log(int_ind(cc))
         -elast_lv_l(cc,ag)*log(lab_ind(cc))
         -elast_lv_c(cc,ag)*log(cap_ind(cc))
         -elast_lv_f(cc,ag)*log(FCI(cc,ag))
         -log(TP_GR_EU(cc,ag)*tp_gr(cc,ag)))
         /elastsp(cc,ag,ag))]$(pr(cc,ag) and livest(ag) and quota(cc,ag))
            +
*### 46) For crops
            [-PSH(cc,ag)  +
                (  [quota(cc,ag)
           /
           ( exp(yild_int(cc,ag)) * int_ind(cc)**elast_y_i(cc,ag) * lab_ind(cc)**elast_y_l(cc,ag) * tp_gr(cc,ag) * TP_GR_EU(cc,ag) {from yield eq}
             * exp(area_int2_sug(cc)) * prod(nonsug$ppp(cc,nonsug), PI(cc,nonsug)**elastsp(cc,ag,nonsug))
             * landprice1(cc)**elast_landpr(cc,ag) * prod(ecc, cost_ind(ecc,cc)**elast_a(ecc,cc,ag))
             * [1/exp(area_int3_sug(cc))]                                                          {from alarea eq}
           )
                     - area_add_int_sug(cc)
                   ]
         / area_factor_sug(cc)
                )**(1/area_exponent_sug(cc))
       ]$(one(cc) and pr(cc,ag) and qu_sugar(cc,ag))

            +
*### 47) For voluntary setaside
            [-PSH(cc,ag)  +
         exp(        (log(quota(cc,ag))
         -area_int(cc,ag)
         -sum(ag1$((not sameas(ag1,ag))and ppp(cc,ag1)),
         elastsp(cc,ag,ag1)*log(PI(cc,ag1)))
         -elast_landpr(cc,ag)*log(landprice1(cc))
         -sum(ecc,elast_a(ecc,cc,ag)*log(cost_ind(ecc,cc)))
         )
         /(elastsp(cc,ag,ag)))]$volsaq(cc,ag);


*## 73) World market clearing condition
WNXEQ_PWFREE(it)$(NOT PW_CS(it))..
         SUM(cc, NETEXP(cc,it)) =E=  0.0 ;
*## 73) World market clearing condition
* unprocessed products:
WNXEQ_PWFIX(it)$(PW_CS(it) AND NOT (energ(it) OR oil(it) OR mlkproc(it)))..
         SUM(cc, NETEXP(cc,it)) =E=  0.0 ;
*## 73) World market clearing condition
WNXEQ_PWFIX_ENERG(it)$(PW_CS(it) AND ENERG(it))..
         SUM(cc, NETEXP(cc,it)) =E=  0.0 ;
WNXEQ_PWFIX_OIL(it)$(PW_CS(it) AND OIL(it))..
         SUM(cc, NETEXP(cc,it)) =E=  0.0 ;

WNXEQ_PWFIX_DAIRY(it)$(PW_CS(it) AND mlkproc(it))..
         SUM(cc, NETEXP(cc,it)) =E=  0.0 ;


MODEL BASELINECALIB model for baseline calibration
/
* new calibration procedure equations:
SUPPLYEQ_EU.SUPPLY
SUPPLYEQ_EU_CAL.SUPPLY
SUPPLYEQ_NONEU.SUPPLY
SUPPLYEQ_NONEU_ENERG.SUPPLY

HDEMEQ_EU.HDEM
HDEMEQ_EU_CAL.HDEM
HDEM_TR_EUEQ
TUSE_EUGRPEQ

HDEMEQ_NONEU.HDEM

PROCEQ_STD.PDEM
PROCEQ_EU_CAL.PDEM
PDEM_TR_CALEQ

PROCEQ_NONEU.PDEM
PROCM_EQ_STD.MPDEM
PROCM_EQ_CAL.MPDEM

FEEDEQ_STD.FDEM
FEEDEQ_EU_CAL.FDEM
FDEM_TR_EUEQ
FDEM_TR_HDEM_TR_LINKEQ

YILDEQ_EU.YIELD
YILDEQ_EU_CAL.YIELD
TP_GR_EUEQ
SUPPLY_EUGRPEQ

SPRICEQ_STD.PSH
SPRICEQ_CAL.PSH

WNXEQ_PWFREE.PW
WNXEQ_PWFIX.TP_GR_NONEU
WNXEQ_PWFIX_ENERG.PDEM_TR_NONEU_BF
WNXEQ_PWFIX_OIL
WNXEQ_PWFIX_DAIRY

*++++++++++++++++++++++++++++++++++
*+ original ESIM model equations: +
*++++++++++++++++++++++++++++++++++
SDEMEQ.SDEM       , {Seed demand}
*PROCM_EQ.MPDEM    , {Processing demand for fresh milk}
PROCW_EQ.PDEM     , {Processing activities of straw}

*FEEDEQ.FDEM       , {Feed demand}
FEEDMEQ.FDEM_MLK  , {feed milk}
FRATEEQ.FRATE     , {Feed rate for livestock products}
TUSEEQ.TUSE       , {Total domestic use}
*YILDEQ.YIELD      , {Yields crops}
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
*SPRICEQ.PSH       , {Shadow price functions for quota products}
FCIEQ.FCI         , {Feed cost per ton of livestock product}
TRANSEQ.PP        , {For products with margins between PD and PP}
NETXEQ.NETEXP     , {Net exports}
XSHREQ.TRADESHR   , {Share of net exports in total use for individual c.}
XSHR_EUEQ.TRADESHR_EU   , {Share of net exports in total use for individual EU-15 states}
SUBSHR_EUEQ.SUBSHR_EU   , {Adjusted share of net exports in total use for the subsidized exports in EU}
QUALSHREQ.QUALSHR_EU , {Adjusted share of net exports in total use for the quality exports in EU}
TRQSHR_EUEQ.TRQSHR_EU   , {Adjusted share of net exports in total use for the TRQ into the  EU}
SUGIMP_EUEQ.SUGIMP_EU   , {Imports of sugar under preferential agreements or pre-fixed}
*WNXEQ.PW          , {Market clearing condition for tradeable goods}
NTRADEQ.PD        , {Regional market clearing condition for nt goods}
CESQUAN.QUANCES   , {Unscaled input demand in biofuel production}
CESSHR.PDEM_BF    , {Shares in input demand function for biofuel production}
BCIEQ.BCI         ,
NPDBFEQ.NetPD
EQ_DIFF.DIFF
/;

