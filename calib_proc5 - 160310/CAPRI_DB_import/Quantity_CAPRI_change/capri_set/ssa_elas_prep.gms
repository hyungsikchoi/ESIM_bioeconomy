* prepare CAPRI elasticity data for calibration to ESIM

parameter
   p_elas(cc,i,j)        price elasticity of demand for i w.r.t. j in country cc
   exp_shr(cc,i)         expenditure share of product i in total household expenditure of country cc
   exp_shr_other(cc)     expenditure share of non-depicted commodities in ESIM incl. non-ag. etc.
   inc_elas(cc,i)        income elasticity of demand for good i in country cc
   inc_elas_other(cc)    income elasticity of non-depicted commodities in ESIM incl. non-ag. etc.
   allen_elas(cc,i,j)    Allen substitution elasticity of demand for i w.r.t. j in country cc
   demandconsist_stats(*,cc) solver statistics
;


p_elas(cc,comm,comm1)$sameas(comm,comm1) = sum(esim_to_ms(cc,RMS),
                         sum(XX$esim_to_rows(comm,XX),
                                 p_toEsim(RMS,'HCON',XX,'%SIMY%') * p_toEsim(RMS,'CPRI',XX,'%SIMY%')
                         )
                       );

p_elas(cc,comm,comm1)$p_elas(cc,comm,comm) =
                         sum(esim_to_ms(cc,RMS),
                            sum(XX$esim_to_rows(comm,XX),
                                 sum(YY$esim_to_rows(comm1,YY), p_toEsim(RMS,'HCON',XX,'%SIMY%') * p_toEsim(RMS,'CPRI',XX,'%SIMY%') * p_ElasDem(RMS,XX,YY,'CAL')
                                         / p_elas(cc,comm,comm)
                                 )
                            )
                         );

* aggregate income elasticities of demand for each country and item using expenditure share-weighting of the CAPRI (item,country) contained:
inc_elas(cc,comm) = sum(esim_to_ms(cc,RMS),
                         sum(XX$esim_to_rows(comm,XX),
                                 p_toEsim(RMS,'HCON',XX,'%SIMY%') * p_toEsim(RMS,'CPRI',XX,'%SIMY%')
                         )
                    );

inc_elas(cc,comm)$inc_elas(cc,comm) =
     sum(esim_to_ms(cc,RMS),
          sum(XX$esim_to_rows(comm,XX),
                  p_toEsim(RMS,'HCON',XX,'%SIMY%') * p_toEsim(RMS,'CPRI',XX,'%SIMY%') * p_ElasDem(RMS,XX,'INCE','CAL')
                  / inc_elas(cc,comm)
          )
     );

* aggregate income elasticities of demand for each country and the "OTHER" item using expenditure share-weighting of the CAPRI (item,country) contained:
parameter exp_value_INPE(RMS), exp_shr_other_capri(cc), exp_shr_INPE_capri(cc);
exp_value_INPE(RMS) = (p_toEsim(RMS,'INCE','LEVL','%SIMY%')
                         -sum(XX1,
                                 p_toEsim(RMS,'HCON',XX1,'%SIMY%') * p_toEsim(RMS,'CPRI',XX1,'%SIMY%')
                         )
                      );


inc_elas_other(cc) = sum(esim_to_ms(cc,RMS),
                         exp_value_INPE(RMS)
                         + sum(XX1$(NOT sum(comm, esim_to_rows(comm,XX1))),
                                 p_toEsim(RMS,'HCON',XX1,'%SIMY%') * p_toEsim(RMS,'CPRI',XX1,'%SIMY%')
                           )
                     );

exp_shr_other_capri(cc) = inc_elas_other(cc)/ sum(esim_to_ms(cc,RMS), p_toEsim(RMS,'INCE','LEVL','%SIMY%'));
exp_shr_INPE_capri(cc) = sum(esim_to_ms(cc,RMS),exp_value_INPE(RMS))/sum(esim_to_ms(cc,RMS),p_toEsim(RMS,'INCE','LEVL','%SIMY%'));
display exp_value_INPE, inc_elas_other, exp_shr_other_capri, exp_shr_INPE_capri;

inc_elas_other(cc)$inc_elas_other(cc) =
     sum(esim_to_ms(cc,RMS), exp_value_INPE(RMS) * p_ElasDem(RMS,'INPE','INCE','CAL')/ inc_elas_other(cc) +
          sum(XX1$(NOT sum(comm, esim_to_rows(comm,XX1))),
                  p_toEsim(RMS,'HCON',XX1,'%SIMY%') * p_toEsim(RMS,'CPRI',XX1,'%SIMY%') * p_ElasDem(RMS,XX1,'INCE','CAL')
                  / inc_elas_other(cc)
          )
     );

$ontext
exp_shr(cc,comm) = sum(esim_to_ms(cc,RMS),
                          sum(esim_to_rows(comm,XX), p_toEsim(RMS,'HCON',XX,'%SIMY%')*p_toEsim(RMS,'CPRI',XX,'%SIMY%') )
                      );
exp_shr(cc,comm)$exp_shr(cc,comm) = exp_shr(cc,comm)
                                    / sum(esim_to_ms(cc,RMS), p_toEsim(RMS,'INCE','LEVL','%SIMY%') );
$offtext

*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++
* complement CAPRI data with ESIM base data where missing:
*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++
parameters
   allena(i,j)      Starting values for Allen Elasticities of Substitution
   inc(c,i)         Starting values for Income Elasticities of Demand
   own(c,i)         Starting values for Own Price Elasticities of Demand
   value_shr(i,c)   Share of Product in total consumption expenditure
;

$GDXin '.\input\HUM-DEM.gdx'
$load allena inc own value_shr
$GDXin


* use ESIM expenditure share:
exp_shr(cc,comm) = value_shr(comm,cc);

exp_shr(cc,comm)$(exp_shr(cc,comm)<10E-20) = 0;
inc_elas(cc,comm)$(exp_shr(cc,comm)=0) = 0;

* expenditure share of non-depicted commodities incl. non-ag. etc.:
exp_shr_other(cc) = 1-sum(comm, exp_shr(cc,comm));

display inc_elas_other, exp_shr_other;


* care for product which cannot be directly mapped between ESIM and CAPRI:
* split current expenditure shares:
*exp_shr(cc,'DURUM') = exp_shr(cc,'CWHEAT') *  value_shr('DURUM',cc)/(value_shr('CWHEAT',cc)+value_shr('DURUM',cc));
*exp_shr(cc,'CWHEAT') = exp_shr(cc,'CWHEAT') *  value_shr('CWHEAT',cc)/(value_shr('CWHEAT',cc)+value_shr('DURUM',cc));
inc_elas(cc,'DURUM') = inc_elas(cc,'CWHEAT');

p_elas(cc,'DURUM',comm) = p_elas(cc,'CWHEAT',comm);
p_elas(cc,comm,'DURUM') = p_elas(cc,comm,'CWHEAT');
p_elas(cc,'DURUM','DURUM') = p_elas(cc,'CWHEAT','CWHEAT');
p_elas(cc,'DURUM','CWHEAT') = 0.1;
p_elas(cc,'CWHEAT','DURUM') = 0.1;

*exp_shr(cc,'ACID_MLK') = exp_shr(cc,'CMILK') *  value_shr('ACID_MLK',cc)/(value_shr('CMILK',cc)+value_shr('ACID_MLK',cc));
*exp_shr(cc,'CMILK') = exp_shr(cc,'CMILK') *  value_shr('CMILK',cc)/(value_shr('CMILK',cc)+value_shr('ACID_MLK',cc));
inc_elas(cc,'ACID_MLK') = inc_elas(cc,'CMILK');
p_elas(cc,'ACID_MLK',comm) = p_elas(cc,'CMILK',comm);
p_elas(cc,comm,'ACID_MLK') = p_elas(cc,comm,'CMILK');
p_elas(cc,'ACID_MLK','ACID_MLK') = p_elas(cc,'CMILK','CMILK');
p_elas(cc,'ACID_MLK','CMILK') = 0.1;
p_elas(cc,'CMILK','ACID_MLK') = 0.1;

* add PALMOIL from ESIM as this seems very different in CAPRI:
* to have it clean, it requires an after-simulation expenditure share:
*exp_shr(cc,'PALMOIL') = value_shr('PALMOIL',cc);
inc_elas(cc,'PALMOIL') = inc(cc,'PALMOIL');
p_elas(cc,'PALMOIL',comm1) = (allena('PALMOIL',comm1)-inc(cc,'PALMOIL')) * value_shr(comm1,cc);
p_elas(cc,comm1,'PALMOIL') = (allena(comm1,'PALMOIL')-inc(cc,comm1)) * value_shr('PALMOIL',cc);;


* for the Allen elasticities, use the average of the two cross elasticties to have a symmetric starting point:
allen_elas(cc,comm,comm1)$exp_shr(cc,comm1) = p_elas(cc,comm,comm1)/exp_shr(cc,comm1) + inc_elas(cc,comm);
allen_elas(cc,comm,comm1) = (allen_elas(cc,comm,comm1) + allen_elas(cc,comm1,comm)) / 2;

allen_elas(cc,'DURUM','CWHEAT') = 0.5;
allen_elas(cc,'CWHEAT','DURUM') = 0.5;

allen_elas(cc,'ACID_MLK','CMILK') = 0.5;
allen_elas(cc,'CMILK','ACID_MLK') = 0.5;

* as we enforce Allen cross elasticities to be >0, we correct the starting values to be positive:
allen_elas(cc,comm,comm1)$(NOT sameas(comm,comm1) AND allen_elas(cc,comm,comm1)<0) = 0.000001;

inc_elas(cc,comm)$(exp_shr(cc,comm)=0) = 0;
allen_elas(cc,comm,comm1)$(exp_shr(cc,comm)=0 OR exp_shr(cc,comm1)=0) = 0;
p_elas(cc,comm,comm1)$(exp_shr(cc,comm)=0 OR exp_shr(cc,comm1)=0) = 0;

display exp_shr, inc_elas, p_elas, allen_elas;

parameter testx(cc);
testx(cc) = sum(comm, exp_shr(cc,comm));
display testx;

* correct expenditure shares:
parameter
   tmpshr(cc)  helper variable
   tmpshri(cc,i)  helper variable
;
tmpshri(cc,comm)$(exp_shr(cc,comm)=0 AND value_shr(comm,cc)<>0) = value_shr(comm,cc);
tmpshr(cc) = sum(comm$(exp_shr(cc,comm)=0 AND value_shr(comm,cc)<>0), value_shr(comm,cc));
display tmpshr, tmpshri;



testx(cc) = sum(comm, exp_shr(cc,comm));
display testx;


display exp_shr, inc_elas, allen_elas, allena;

parameters
   pp_results (i,cc,res_pp)      prices policies input data (ESIM)
   show_data(i,data_base,ccplus) "Consolidated data base, in 1000 t (ESIM)"
   elastin(cc,I)                 elast. humand demand w.r. to income (ESIM)
   pc(cc,i)                      consumer price (=PD + PCTAX)
;

$GDXin '%diresim%\prices_policies.gdx'
$load pp_results
$GDXIN

*$GDXin '%diresim%\Quantities.gdx'
*$load show_data
*$GDXIN

$GDXin '%diresim%\esim_parameters_40%.gdx'
$load elastin
*load elasthd
*load elastsp                                                                                                           z
*load elastyd
*load elastfd
*load fedrat
*load elast_y_i
*load elast_y_l
*load elast_y_c
*load elast_y_f
*load elast_y_e
*load elast_lv_i
*load elast_lv_l
*load elast_lv_c
*load elast_lv_f
*load feed_exog
*load el_area0
$GDXIN




VARIABLES
   OBJ                   objective function value
   EPSILON(i,j)       price elasticity of demand
   ALPHA(i,j)         Allen substitution elasticity
   ETA(i)             income elasticity of demand
   ETA_other          income elasticity of demand for non-depicted products in ESIM
   GAMMA(i)           deviation from homogeneity condition
   DELTA             deviation from adding up condition for the income elasticity
   DALPHA            objective value Allen own elasticities
   DALPHAX           objective value Allen cross elasticities
   DDELTA            objective value
   DGAMMA            objective value
   DETA              objective value income elasticities
;

EQUATIONS
   HOMO(i)            homogeneity of degree zero in prices and income
   SYM(i,j)           Slutsky symmetry in Allen substitution elasticities
   ADDUP              adding up condition for income elasticities
   ALLENDEF(i,j)      Definition of Allen elasticity
   NEGOWNEPSILON(i)   negativity condition for own price elasticity
   NEGOWNALLEN(i)     negativity condition for Allen own elasticity
   POSCROSSALLEN(i,j) positivity condition for Allen cross price elasticities
   OBJCONSISTDEF          global objective function consistency only
   OBJOPTDEF      global objective function optimization
   DALPHADEF
   DALPHAXDEF
   DDELTADEF
   DGAMMADEF
   DETADEF
;

PARAMETERS
   exp_shrc(i), allen_elasc(i,j), epsilon_elasc(i,j), inc_elasc(i), exp_shrc_other, inc_elasc_other;

HOMO(comm)..
   GAMMA(comm) =E= sum(comm1, EPSILON(comm,comm1)) + ETA(comm);

SYM(comm,comm1)..
   ALPHA(comm,comm1) =E= ALPHA(comm1,comm);

ALLENDEF(comm,comm1)$(exp_shrc(comm1) AND allen_elasc(comm,comm1)<>0)..
   ALPHA(comm,comm1) =E= EPSILON(comm,comm1) / exp_shrc(comm1) + ETA(comm);

ADDUP..
   DELTA =E= sum(comm, ETA(comm) * exp_shrc(comm)) + ETA_other*exp_shrc_other - 1;

NEGOWNEPSILON(comm)..
   EPSILON(comm,comm) =L= 0;

NEGOWNALLEN(comm)..
   ALPHA(comm,comm) =L= 0;

POSCROSSALLEN(comm,comm1)$(NOT sameas(comm,comm1))..
   ALPHA(comm,comm1) =G= 0;

DALPHADEF..
   DALPHA =E= 10*sum(comm$epsilon_elasc(comm,comm),
                         sqr( 100*(epsilon_elasc(comm,comm)-EPSILON(comm,comm))/epsilon_elasc(comm,comm)) );

DALPHAXDEF..
   DALPHAX =E= sum((comm,comm1)$(NOT sameas(comm,comm1) AND epsilon_elasc(comm,comm1)),
                         sqr( 100*(epsilon_elasc(comm,comm1)-EPSILON(comm,comm1))/epsilon_elasc(comm,comm1) ) );

DETADEF..
   DETA =E= 10*( sum(comm$inc_elasc(comm), sqr(100*(inc_elasc(comm)-ETA(comm))/inc_elasc(comm)) ) + sqr(100*(inc_elasc_other - ETA_other)/inc_elasc_other) );

DGAMMADEF..
   DGAMMA =E= sum( comm, sqr( 100*GAMMA(comm) ) );

DDELTADEF..
   DDELTA =E= sqr( 100*DELTA );


OBJCONSISTDEF..
   OBJ =E= DGAMMA + DDELTA;

OBJOPTDEF..
   OBJ =E= DALPHA + DALPHAX + DETA + DGAMMA + DDELTA;
*   OBJ =E= DALPHA + DALPHAX + DETA;


MODEL DEMANDOPT /
   HOMO
   SYM
   ALLENDEF
*   POSCROSSALLEN
   ADDUP
   OBJOPTDEF
   DALPHADEF
   DALPHAXDEF
   DETADEF
   DGAMMADEF
   DDELTADEF
/;

MODEL DEMANDCONSIST /
   HOMO
   ALLENDEF
   ADDUP
   OBJCONSISTDEF
   DGAMMADEF
   DDELTADEF
/;

PARAMETER
   inc_elas_diff(cc,comm)   difference between target and calibrated income elasticity
   pown_elas_diff(cc,comm)  difference between target and calibrated own price elasticity
   pelas_org(cc,i,i)             store initial mapped and aggregated CAPRI price elasticities
   yelas_org(cc,i)               store initial mapped and aggregated CAPRI income elasticities
;

* store CAPRI elasticities for comparision:
pelas_org(cc,comm,comm1) =  ( allen_elas(cc,comm,comm1) - inc_elas(cc,comm) ) * exp_shr(cc,comm1);
yelas_org(cc,comm) = inc_elas(cc,comm);

options nlp=conopt;
DEMANDOPT.OPTFILE = 1;
*$sameas(cc,'ROW')
loop(cc,
   ALPHA.UP(comm,comm1) = +INF;
   ALPHA.LO(comm,comm1) = -INF;
   EPSILON.UP(comm,comm1) = +INF;
   EPSILON.LO(comm,comm1) = -INF;
   ETA.UP(comm) = +INF;
   ETA.LO(comm) = -INF;
   DELTA.UP = +0.00000001;
   DELTA.LO = -0.00000001;
   GAMMA.UP(comm) = +0.0001;
   GAMMA.LO(comm) = -0.0001;
* initialize variables:

   EPSILON.UP(comm,comm1)$sameas(comm,comm1) = 0;
   ALPHA.UP(comm,comm1)$sameas(comm,comm1) = 0;
   ALPHA.LO(comm,comm1)$(NOT sameas(comm,comm1)) = 0;

   ALPHA.L(comm,comm1) = allen_elas(cc,comm,comm1);
   ETA.L(comm) = inc_elas(cc,comm);
   ETA_other.L = inc_elas_other(cc);
   EPSILON.L(comm,comm1) = ( allen_elas(cc,comm,comm1) - inc_elas(cc,comm) ) * exp_shr(cc,comm1);

   ALPHA.FX(comm,comm1)$(allen_elas(cc,comm,comm1)=0) = 0;
*   EPSILON.FX(comm,comm1)$(allen_elas(cc,comm,comm1)=0) = 0;
   ETA.FX(comm)$(exp_shr(cc,comm)=0) = 0;
   allen_elasc(comm,comm1) = allen_elas(cc,comm,comm1);
   epsilon_elasc(comm,comm1) = EPSILON.L(comm,comm1);
   inc_elasc(comm) = inc_elas(cc,comm);
   exp_shrc(comm) = exp_shr(cc,comm);
   inc_elasc_other = inc_elas_other(cc);
   exp_shrc_other = exp_shr_other(cc);

*   SOLVE DEMANDCONSIST using NLP minimizing OBJ;
display allen_elasc, epsilon_elasc, inc_elasc, exp_shrc;
display alpha.l, eta.l, epsilon.l;

   SOLVE DEMANDOPT using NLP minimizing OBJ;
   demandconsist_stats('Model-status',cc) =  DEMANDOPT.MODELSTAT;
   demandconsist_stats('Solver-status',cc) = DEMANDOPT.SOLVESTAT;
   DEMANDOPT.MODELSTAT = 0;
   DEMANDOPT.SOLVESTAT = 0;
   inc_elas_diff(cc,comm) = inc_elas(cc,comm) - ETA.L(comm);
   pown_elas_diff(cc,comm) = p_elas(cc,comm,comm) - EPSILON.L(comm,comm);
*  store results:
   inc_elas(cc,comm) = ETA.L(comm);
   allen_elas(cc,comm,comm1) = ALPHA.L(comm,comm1);
   p_elas(cc,comm,comm1) = EPSILON.L(comm,comm1);
);
display inc_elas, allen_elas, p_elas, inc_elas_diff, pown_elas_diff;

display demandconsist_stats;

execute_UNLOAD '.\output\hdem_elas_capri.gdx', inc_elas, p_elas, allen_elas;

execute_UNLOAD '.\output\hdem_elas_capri_org.gdx', yelas_org, pelas_org, cc, comm;

*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++
$ontext
 FEED DEMAND ELASTICITIES
 In ESIM:
   FRATE(cc,feed,livest): amount of feed required per unit of livest in country cc
   elastfd(cc,i,j,g)      price elast of feed demand for i w.r.t. the price for j in the production of livestock g
$offtext
*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++

