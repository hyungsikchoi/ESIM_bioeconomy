
*elastsp("FR",i,j)= elastsp("FR",i,j)*0.85;


* Reading elasticities for bio-fuel demand and supply

$include "calib-biofuel.gms"



prod0(cc,comm) =   supply.l(cc,comm)  ;
hdem0(cc,comm) =   hdem.l(cc,comm)   ;
fdem0(cc,comm) =   fdem.l(cc,comm) ;
sdem0(cc,comm) =   sdem.l(cc,comm) ;
pdem0(cc,comm) =   pdem.l(cc,comm) ;
pp_0(cc,comm)   =   pp.l(cc,comm) ;

* CALCULATION OF SEED PARAMETER

seed_c(one,crops)$sdem.l(one,crops) =  SDEM.l(one,crops) /EFAREA.l(one,crops) ;



seed_c(cc,crops)$(rest(cc) and sdem.l(cc,crops)) =  SDEM.l(cc,crops) / SUPPLY.l(cc,crops)  ;


* == Revision of the calculation of the crushing parameters in oilseed processing ==
* in old version: same parameters of oil-processing and crushing in all countries
*  oilsd_c(c,i,j)         = oil_p(i,j);
*
* here: re-calculation of crushing parameter oilseed to oil and meal based on the FAO data
*

*  supply.l(cc,"soyoil") = pdem.l(cc,"soybean")*oil_content("soyoil");
*  supply.l(cc,"rapoil") = pdem.l(cc,"rapseed")*oil_content("rapoil");
*  supply.l(cc,"sunoil") = pdem.l(cc,"sunseed")*oil_content("sunoil");


display oil_content;

  oilsd_c(c,i,j)  = 0.0;

  oilsd_c(cc,"soyoil","soybean")$pdem.l(cc,"soybean")   = supply.l(cc,"soyoil") / pdem.l(cc,"soybean");
  oilsd_c(cc,"rapoil","rapseed")$pdem.l(cc,"rapseed")   = supply.l(cc,"rapoil") / pdem.l(cc,"rapseed");
  oilsd_c(cc,"sunoil","sunseed")$pdem.l(cc,"sunseed")   = supply.l(cc,"sunoil") / pdem.l(cc,"sunseed");

  oilsd_c(cc,"soymeal","soybean")$pdem.l(cc,"soybean")   = supply.l(cc,"soymeal") / pdem.l(cc,"soybean");
  oilsd_c(cc,"rapmeal","rapseed")$pdem.l(cc,"rapseed")   = supply.l(cc,"rapmeal") / pdem.l(cc,"rapseed");
  oilsd_c(cc,"sunmeal","sunseed")$pdem.l(cc,"sunseed")   = supply.l(cc,"sunmeal") / pdem.l(cc,"sunseed");

display oilsd_c;

parameter tttt(cc);
tttt(cc)$pdem.l(cc,"rapseed")
 =  supply.l(cc,"rapoil") / pdem.l(cc,"rapseed");

display tttt,supply.l;




*Calculation of crushing elasticities


****new sets for oilproc
  OILSPROC(CC,OSPRO)       = YES$SUPPLY.L(CC,OSPRO);



*oil_content("soyoil") = oilsd_c(cc,"soyoil","soybean");
*oil_content("rapoil") = oilsd_c(cc,"rapoil","rapseed");
*oil_content("sunoil") = oilsd_c(cc,"sunoil","sunseed");

Parameter
chk_oil_cont;

*chk_oil_cont(cc,"soyoil","soybean")$pdem.l(cc,"soybean") = oil_content("soyoil") - oilsd_c(cc,"soyoil","soybean");
*chk_oil_cont(cc,"rapoil","rapseed")$pdem.l(cc,"rapseed") = oil_content("rapoil") - oilsd_c(cc,"rapoil","rapseed");
*chk_oil_cont(cc,"sunoil","sunseed")$pdem.l(cc,"sunseed") = oil_content("sunoil") - oilsd_c(cc,"sunoil","sunseed");

*display chk_oil_cont,oil_content;





Loop(cc,
Loop(oil,
Loop(oilseed,
*ABORT$(abs(chk_oil_cont(cc,oil,oilseed)) gt  0.00001) "CRUSHING PARAMETER DIFFER FROM ORIGINAL DATABASE", chk_oil_cont;
); ););

*$stop


Parameter
a                level of crushing elasticities
;

* The only number to be adjusted in order to change the sensitivity
* of oilseed crushing with respect to prices:

* <%INPUT%>
scalar elast__os_cru "Own price elasticity of oilseed crushing demand"/-10.0/;
* <%FORMAT #,###,##0%>
* <%USERLEVEL 1%>
* <%/INPUT%>


a= elast__os_cru;


* All elasticities not otherwise defined are set at zero
elastcr(cc,i,j) = 0;

* All own price elasticities of crushing demand are set at the level parameter
elastcr(cc,"soybean", "soybean") = a;
elastcr(cc,"sunseed", "sunseed") = a;
elastcr(cc,"rapseed", "rapseed") = a;


* All own price elasticities of crushing demand set relative to the level parameter
* according to the value shares of oil and meal output (assumption: 10% cost share of other inputs)

*# Soybean elasticities
elastcr(cc,"soybean", "soymeal")$oilsd_c(cc,"soymeal","soybean") = -a/0.9*
oilsd_c(cc,"soymeal","soybean")*PD.l(cc,"soymeal")/
(oilsd_c(cc,"soymeal","soybean")*PD.l(cc,"soymeal")+oilsd_c(cc,"soyoil","soybean")*PD.l(cc,"soyoil"));

elastcr(cc,"soybean", "soyoil")$oilsd_c(cc,"soyoil","soybean") = -a/0.9*
oilsd_c(cc,"soyoil","soybean")*PD.l(cc,"soyoil")/
(oilsd_c(cc,"soymeal","soybean")*PD.l(cc,"soymeal")+oilsd_c(cc,"soyoil","soybean")*PD.l(cc,"soyoil"));

*#Sunseed elasticities
elastcr(cc,"sunseed", "sunmeal")$oilsd_c(cc,"sunmeal","sunseed") = -a/0.9*
oilsd_c(cc,"sunmeal","sunseed")*PD.l(cc,"sunmeal")/
(oilsd_c(cc,"sunmeal","sunseed")*PD.l(cc,"sunmeal")+oilsd_c(cc,"sunoil","sunseed")*PD.l(cc,"sunoil"));

elastcr(cc,"sunseed", "sunoil")$oilsd_c(cc,"sunoil","sunseed") = -a/0.9*
oilsd_c(cc,"sunoil","sunseed")*PD.l(cc,"sunoil")/
(oilsd_c(cc,"sunmeal","sunseed")*PD.l(cc,"sunmeal")+oilsd_c(cc,"sunoil","sunseed")*PD.l(cc,"sunoil"));

*#Rapeseed elasticities
elastcr(cc,"rapseed", "rapmeal")$oilsd_c(cc,"rapmeal","rapseed") = -a/0.9*
oilsd_c(cc,"rapmeal","rapseed")*PD.l(cc,"rapmeal")/
(oilsd_c(cc,"rapmeal","rapseed")*PD.l(cc,"rapmeal")+oilsd_c(cc,"rapoil","rapseed")*PD.l(cc,"rapoil"));

elastcr(cc,"rapseed", "rapoil")$oilsd_c(cc,"rapoil","rapseed") = -a/0.9*
oilsd_c(cc,"rapoil","rapseed")*PD.l(cc,"rapoil")/
(oilsd_c(cc,"rapmeal","rapseed")*PD.l(cc,"rapmeal")+oilsd_c(cc,"rapoil","rapseed")*PD.l(cc,"rapoil"));


elastcr(rest,oilseed,meal)$elastcr(rest,oilseed,meal) =  elastcr(rest,oilseed,meal) + 0.3;
elastcr(rest,oilseed,oil)$elastcr(rest,oilseed,oil) =  elastcr(rest,oilseed,oil) - 0.3;


display elastcr;

*
* ================================
*
* INTERCEPT CALCULATION
*
* SUPPLY


sup_int(one,livest)$PR(one,livest) = log(SUPPLY.l(one,livest)-subs_milk_s(one,livest)
                                        -FDEM_MLK.l(one,livest)    )
            -sum(livest1$ppp(one,livest1),elastsp(one,livest,livest1)
                         *(log(PI.l(one,livest1))))
            -elast_lv_i(one,livest)*log(int_ind(one))
            -elast_lv_l(one,livest)*log(lab_ind(one))
            -elast_lv_c(one,livest)*log(cap_ind(one))
            -elast_lv_f(one,livest)*log(FCI.l(one,livest));





sup_int(one,livest)$(PR(one,livest) and quota(one,livest))
                             = log(SUPPLY.l(one,livest)-subs_milk_s(one,livest)
                                        -FDEM_MLK.l(one,livest)    )
            -sum(livest1$ppp(one,livest1),elastsp(one,livest,livest1)
                         *(log(PI.l(one,livest1))))
            -elast_lv_i(one,livest)*log(int_ind(one))
            -elast_lv_l(one,livest)*log(lab_ind(one))
            -elast_lv_c(one,livest)*log(cap_ind(one))
            -elast_lv_f(one,livest)*log(FCI.l(one,livest));



sup_int(rest,livest)$PR(rest,livest) = log(SUPPLY.l(rest,livest)-FDEM_MLK.l(rest,livest) )
            -sum(livest1$ppp(rest,livest1),elastsp(rest,livest,livest1)
                         *(log(PP.l(rest,livest1))))
            -elast_lv_i(rest,livest)*log(int_ind(rest))
            -elast_lv_l(rest,livest)*log(lab_ind(rest))
            -elast_lv_c(rest,livest)*log(cap_ind(rest))
            -elast_lv_f(rest,livest)*log(FCI.l(rest,livest));






sup_int(rest,crops)$PR(rest,crops) =  log(SUPPLY.l(rest,crops))
            - sum(crops1$(PP.l(rest,crops1)), elastsp(rest,crops,crops1)
                         *log(PP.l(rest,crops1)));

sup_int(cc,feedres)$SUPPLY.l(cc,feedres) = log(SUPPLY.l(cc,feedres))-
                          0.2*log(PD.l(cc,feedres));
*                          - elastl(cc,feedres)*log(oth_IND(cc)));




sup_int(cc,energ)$PR(cc,energ)
                             = log(SUPPLY.l(cc,energ))
            -elastsp(cc,energ,energ)*log(PI.l(cc,energ))
            -elast_en_inp(cc,energ)*log(BCI.l(cc,energ));


display sup_int,feedres,energ,pr;





area_int(one,crops)$(PR(one,crops) )  = log(ALAREA.l(one,crops))
            -  sum(crops1$(ppp(one,crops1) ), elastsp(one,crops,crops1)
                         *log(PI.l(one,crops1)))
                          -elast_landpr(one,crops)*log(landprice1.l(one))
                          -sum(ecc,elast_a(ecc,one,crops)*log(cost_ind(ecc,one)))
                          ;


area_int(one,crops)$(sameas(crops,'LINO'))  = log(ALAREA.l(one,crops))
                          -elast_landpr(one,crops)*log(landprice1.l(one))
                          ;



* YIELD EQUATION

yild_int(one,crops)$(supply.l(one,crops) and not volsa(one,crops) and not sameas(crops,'lino')) =
                          (log(YIELD.l(one,crops))
                         - elastyd(one,crops,crops)
                          * log(PP.l(one,crops))
                          -sum(ecc, elast_y(ecc,one,crops)*log(cost_ind(ecc,one)))
                          )$(nq(one,crops) and not sameas(crops,'lino'))
            +
                          (log(YIELD.l(one,crops))
                         - elastyd(one,crops,crops)
                          * log(PP.l(one,crops))
*                          * MIN(log(PP.l(one,crops)),LOG(PSH.l(one,crops)) )
                          -sum(ecc, elast_y(ecc,one,crops)*log(cost_ind(ecc,one)))
                          )$qu_sugar(one,crops)
 ;

display yild_int,YIELD.l,elastyd,elast_y,PP.l,PD.l,nq;




* DOMESTIC USE

* HUMAN DEMAND


hdem_int(cc,comm)$(HD(cc,comm)) =  log(HDEM.l(cc,comm)-subs_milk_d(cc,comm))
                           -   sum(comm1$PPC(cc,comm1),elasthd(cc,comm,comm1)*log(PC.l(cc,comm1)))
                           -  log(pop_gr(cc))
                           -  log(inc_gr(cc))*elastin(cc,comm);
;



* FEED DEMAND
elastfd(cc,feed,feed1,livest)
 $((elastfd(cc,feed,feed1,livest)eq 0) and sameas(feed,feed1))
 = - 0.05  ;


elastfd(cc,feed,feed1,livest)
 $(elastfd(cc,feed,feed1,livest)eq 0)
 = 0.01  ;




frat_int(cc,feed,livest)$FR(cc,feed,livest)  = log(FRATE.l(cc,feed,livest))
                        - sum(feed1$FD(cc,feed1),
                          elastfd(cc,feed,feed1,livest)*log(PD.l(cc,feed1)));


display frat_int,FR,frate.l,fd,elastfd,pd.l;






* PROCESSING DEMAND

*# oilseed
parameter
elastst(cc,comm) straw processing elasticity
;
elastst(cc,comm) = 0;
elastst(cc,'stra') = -5;


cr_int(cc,oilseed)$PROC(cc,oilseed) = log(PDEM.l(cc,oilseed))
       -sum(comm$PS(cc,comm),elastcr(cc,oilseed,comm)*log(PD.l(cc,comm)));


st_int(cc,comm)$stra(cc,comm) = log(PDEM.l(cc,comm))
                              - elastst(cc,comm)*log(PD.l(cc,comm));

display cr_int,st_int,PDEM.l,PD.l;




proc_int(cc,dairy_comp,mlkproc)$MPDEM.l(cc,dairy_comp,mlkproc)
 =  LOG(MPDEM.l(cc,dairy_comp,mlkproc))
       -sum(comm$PS(cc,comm),elastdm_n(cc,dairy_comp,mlkproc,comm)*log(PD.l(cc,comm)));

display proc_int, elastdm_n;

* SUGAR AREA ALLOCATION
table   sugar_parameters(cc,*)
         sinter                    sfactor                  sexpon                  smargcos
CZ       -69.47916968172700        69.66080222066580        0.02707166235256        1.53945124763699
DK       -26.33021823826720        25.46786146822810        0.12015437873180        1.79925892066065
GE       -81.45570589422750        80.00578227048180        0.04122789700928        2.07840394933160
GR       -93.07534864341130        91.46288666082810        0.02743289205005        2.79157423426196
ES       -104.67184496339600      103.72012427817300        0.02198944676074        2.33447111555554
FR       -23.37145915018820        22.89972157973860        0.12925591088764        1.61914241138643
IE       -75.29727195275380        73.20903742992640        0.04985806199753        2.29038217432430
IT       -43.73034937380970        41.51134634248960        0.04886827664008        4.61033685929910
LV       -25.29723770771280        25.20139490548540        0.10580251347605        1.49526275456718
LT       -38.96814394824040        39.36336061298290        0.05325815351350        1.33147874774387
HU       -69.62178023522990        69.53923942337130        0.03086633849474        1.64948209117119
NL       -29.34157980748660        27.30750744762380        0.10387067490716        2.75746848100406
AT       -104.60810051759000      103.71904706493700        0.02792683496217        1.90847949580542
PL       -26.82643008482540        27.63679680683660        0.11148768100923        1.06325592419215
PT       -24.49251487480520        23.35389296180030        0.09395000536574        2.54119963863228
SI       -34.74127601272690        34.86258355773210        0.04974945495809        1.64929584576197
SK       -34.73287464407690        34.87097804999430        0.05350848223507        1.57823241914938
FI       -34.46484346174680        35.16993779317840        0.04905489262312        1.18556756129913
SW       -54.28497045630840        54.98913936766980        0.03638914711785        1.15886929421790
BE       -21.42673747478140        19.07994805685790        0.15555614099592        2.82626402922817
UK       -21.15094083473790        21.46313818189350        0.10689341062403        1.34324516118654
RO       -34.74127601272690        34.86258355773210        0.04974945495809        1.64929584576197
BG       -34.74127601272690        34.86258355773210        0.04974945495809        1.64929584576197
HR       -34.74127601272690        34.86258355773210        0.04974945495809        1.64929584576197
TU       -34.74127601272690        34.86258355773210        0.04974945495809        1.64929584576197
;

yild_int(one,crops)$(supply.l(one,crops) and not volsa(one,crops)) =
                          (log(YIELD.l(one,crops))
                         - elastyd(one,crops,crops)
                          * log(PP.l(one,crops))
                          -sum(ecc, elast_y(ecc,one,crops)*log(cost_ind(ecc,one)))
                          )$(nq(one,crops) and not sameas(crops,'lino'))
            +
                          (log(YIELD.l(one,crops))
                         - elastyd(one,crops,crops)
*                          * log(PI.l(one,crops))
                          * MIN(log(PP.l(one,crops)),LOG(PSH.l(one,crops)) )
                          -sum(ecc, elast_y(ecc,one,crops)*log(cost_ind(ecc,one)))
                          )$qu_sugar(one,crops)
 ;



display sugar_parameters;

area_add_int_sug(one)$(europe(one) and prod0(one,"SUGAR"))  = sugar_parameters(one,'sinter')*prod0(one,"SUGAR");

area_factor_sug(one)$(europe(one) and prod0(one,"SUGAR"))   = sugar_parameters(one,'sfactor')*prod0(one,"SUGAR")
                         /((PP.l(one,"SUGAR")/sugar_parameters(one,'smargcos'))**sugar_parameters(one,'sexpon'));
area_exponent_sug(one)$(europe(one) and prod0(one,"SUGAR")) = sugar_parameters(one,'sexpon');

area_int2_sug(one)$ppp(one,"sugar") =   log(1)-
                         sum( nonsug$ppp(one,nonsug), elastsp(one,"sugar",nonsug)
                         *log(PI.l(one,nonsug)))
                          -elast_landpr(one,"sugar")*log(landprice1.l(one))
                          -sum(ecc, elast_a(ecc,one,"sugar")*log(cost_ind(ecc,one)))
                          ;

area_int3_sug (one)$(ppp(one,"sugar") and prod0(one,"SUGAR"))=   log(YIELD.l(one,"sugar"))-
                         elastyd(one,"sugar","sugar")
                         *log(PI.l(one,"sugar"));
                           ;
display area_add_int_sug,area_factor_sug,area_exponent_sug,area_int3_sug;

display area_factor_sug;


area_factor_sug_0(one) = area_factor_sug(one);

parameter
area_int0
area_int_sft;

area_int0(eu15,crops) = area_int(eu15,crops);

Table area_shift(eu15,crops)
          CORN        RAPSEED       SUNSEED      CWHEAT
AT          0
$ontext
AT        0.006        0.146        0.195        0.005       0.000
BE        0.009        0.543        0.000        0.007       0.000
DK        0.000        0.235        0.000        0.001       0.000
ES        0.028        0.248        0.011        0.043      -0.049
FI        0.000        0.000        0.000        0.022      -0.006
FR        0.008        0.320        0.066        0.006       0.000
GE        0.024        0.289        0.751        0.019      -0.012
GR        0.006        0.000        0.000        0.005      -0.067
IE        0.000        0.965        0.000        0.006       0.000
IT        0.013        0.000        0.042        0.010      -0.3
NL        0.031        0.508        0.000        0.024       0.000
PT        0.020        0.000        0.501        0.014      -0.149
SW        0.000        0.035        0.000        0.150      -0.005
UK        0.000        0.154        0.000        0.009       0.000
;

$offtext


Table area_shift2(eu15,*)
          shift
AT        0.000
$ontext
AT        0.005
BE        0.004
DK        0.018
ES        0.000
FI        0.000
FR        0.008
GE        0.000
GR        0.000
IE        0.002
IT        0.000
NL        0.003
PT        0.000
SW        0.000

UK        0.010
$offtext
;



area_int_sft(eu15,crops)= log (1+area_shift2(eu15,"shift"));
display area_int_sft;
area_int_sft(eu15,crops)$(area_shift(eu15,crops) ne 0)=area_int_sft(eu15,crops) + log(1+area_shift(eu15,crops));
display area_int_sft;




Parameter
add_demand_BD
add_demand_ETH
add_demand_starchy
add_demand_woody;

set years(sim_base) / 2010, 2015, 2020, 2025, 2030, 2035, 2040, 2045, 2050 /;

parameter
Exog_Woodycrops(cc,sim_base)
woodycrop_rate(sim_base)
*Exog_land(cc)
year_shift(sim_base)
;

Parameter
biofuel_additional
biofuels_ext(cc,energ)
BF_fix
;

set
*biogas_inputs(comm) / cwheat, smaize, gras /;
biogas_inputs(comm) / cwheat, corn, gras /;

Parameter
exog_biogas_dem(cc,comm,sim_base)
biogas_shift(comm,sim_base)
exog_biogas(cc,comm)
abs_biogas_dem
;

Parameter
Exog_land2(cc);

Exog_land2(cc) = 0;

*$ontext


$GDXin '%Bioenergy_shifter%'
$load  add_demand_BD
$load  add_demand_ETH
$load  add_demand_starchy
$load  add_demand_woody
$GDXIN

display add_demand_BD
        add_demand_ETH
        add_demand_starchy
        add_demand_woody
        ;

*********************************************************
**** Adaption of Spreads between Biofuels and Inputs ****
*********************************************************






woodycrop_rate(years) = add_demand_woody(years) / sum(eu27,land_data(eu27,'max_land_use'));


*achtung
$ontext
woodycrop_rate("2010") = 0.1;
woodycrop_rate("2015") = 0.1;
woodycrop_rate("2020") = 0.15;
woodycrop_rate("2025") = 0.2;
woodycrop_rate("2030") = 0.25;
woodycrop_rate("2035") = 0.25;
woodycrop_rate("2040") = 0.3;
woodycrop_rate("2045") = 0.3;
woodycrop_rate("2050") = 0.3;
$offtext

Exog_Woodycrops(EU27,years) = area_max(eu27) * woodycrop_rate(years);


display woodycrop_rate, Exog_Woodycrops;


*year_shift("base") =   2006;
year_shift("2010") =   2010;
year_shift("2015") =   2015;
year_shift("2020") =   2020;
year_shift("2025") =   2025;
year_shift("2030") =   2030;
year_shift("2035") =   2035;
year_shift("2040") =   2040;
year_shift("2045") =   2045;
year_shift("2050") =   2050;



biofuel_additional(years,"BIODIESEL") =  add_demand_BD(years) / (Sum(EU27,HDEM.l(EU27,"BIODIESEL")));
biofuel_additional(years,"ETHANOL")   =  add_demand_ETH(years) / (Sum(EU27,HDEM.l(EU27,"ETHANOL"  )));

BF_fix(EU27,energ) = hdem.l(EU27,energ);

biofuel_additional(sim_base,energ) = Max (-0.9, biofuel_additional(sim_base,energ));

display  biofuel_additional;


loop(years,
loop(energ,
if(biofuel_additional(years,energ) < -0.9,
abort "Biofuel Reduction too large");
);
);

*biofuel_additional(sim_base,energ) =0;
biofuels_ext(cc,"biodiesel") =  0;
biofuels_ext(cc,"ethanol")   =  0;



abs_biogas_dem(years,biogas_inputs)= add_demand_starchy(biogas_inputs,years);

biogas_shift(biogas_inputs,years) = abs_biogas_dem(years,biogas_inputs) / SUM(eu27, fdem.l(eu27,biogas_inputs));

exog_biogas_dem(eu27,biogas_inputs,years) = biogas_shift(biogas_inputs,years) *  fdem.l(eu27,biogas_inputs);

exog_biogas(eu27,biogas_inputs) = 0;

display exog_biogas_dem, biogas_shift;

*$offtext


Parameter store_round, store_value1, store_value2;

loop(years,

biofuel_additional(sim_base,energ)$(sameas(sim_base,years))      = biofuel_additional(years,energ);
biofuel_additional(sim_base+1,energ)$(sameas(sim_base,years))    = (4/5)*biofuel_additional(years,energ) + 1/5*biofuel_additional(years+1,energ)  ;
biofuel_additional(sim_base+2,energ)$(sameas(sim_base,years))    = (3/5)*biofuel_additional(years,energ) + 2/5*biofuel_additional(years+1,energ)  ;
biofuel_additional(sim_base+3,energ)$(sameas(sim_base,years))    = (2/5)*biofuel_additional(years,energ) + 3/5*biofuel_additional(years+1,energ)  ;
biofuel_additional(sim_base+4,energ)$(sameas(sim_base,years))    = (1/5)*biofuel_additional(years,energ) + 4/5*biofuel_additional(years+1,energ)  ;

Exog_Woodycrops(EU27,sim_base)$(sameas(sim_base,years))          =  Exog_Woodycrops(EU27,years);
Exog_Woodycrops(EU27,sim_base+1)$(sameas(sim_base,years))          =  (4/5)*Exog_Woodycrops(EU27,years)  + 1/5*Exog_Woodycrops(EU27,years+1) ;
Exog_Woodycrops(EU27,sim_base+2)$(sameas(sim_base,years))          =  (3/5)*Exog_Woodycrops(EU27,years)  + 2/5*Exog_Woodycrops(EU27,years+1) ;
Exog_Woodycrops(EU27,sim_base+3)$(sameas(sim_base,years))          =  (2/5)*Exog_Woodycrops(EU27,years)  + 3/5*Exog_Woodycrops(EU27,years+1) ;
Exog_Woodycrops(EU27,sim_base+4)$(sameas(sim_base,years))          =  (1/5)*Exog_Woodycrops(EU27,years)  + 4/5*Exog_Woodycrops(EU27,years+1) ;

exog_biogas_dem(EU27,biogas_inputs,sim_base)$(sameas(sim_base,years))      =  exog_biogas_dem(EU27,biogas_inputs,years);
exog_biogas_dem(EU27,biogas_inputs,sim_base+1)$(sameas(sim_base,years))    =  (4/5)*exog_biogas_dem(EU27,biogas_inputs,years)  + 1/5*exog_biogas_dem(EU27,biogas_inputs,years+1) ;
exog_biogas_dem(EU27,biogas_inputs,sim_base+2)$(sameas(sim_base,years))    =  (3/5)*exog_biogas_dem(EU27,biogas_inputs,years)  + 2/5*exog_biogas_dem(EU27,biogas_inputs,years+1) ;
exog_biogas_dem(EU27,biogas_inputs,sim_base+3)$(sameas(sim_base,years))    =  (2/5)*exog_biogas_dem(EU27,biogas_inputs,years)  + 3/5*exog_biogas_dem(EU27,biogas_inputs,years+1) ;
exog_biogas_dem(EU27,biogas_inputs,sim_base+4)$(sameas(sim_base,years))    =  (1/5)*exog_biogas_dem(EU27,biogas_inputs,years)  + 4/5*exog_biogas_dem(EU27,biogas_inputs,years+1) ;



);
display biofuel_additional, Exog_Woodycrops, exog_biogas_dem;


*$stop






$IFTHEN "%bioscenario%"=="no"

Exog_Woodycrops(EU27,sim_base)              = 0;
exog_biogas_dem(eu27,biogas_inputs,sim_base)= 0;
biofuel_additional(sim_base,"ETHANOL")      = 0;
biofuel_additional(sim_base,"BIODIESEL")    = 0;

$ENDIF