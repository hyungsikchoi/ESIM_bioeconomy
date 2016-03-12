Parameter
transp_fuel(sim)            Projected consumption of transportation fuel in the EU27 (in million TOE)
conv_biofuel(energ)          Conversion factor bioethanol and biodiesel in oil equivalent
          /   BIODIESEL   0.86
              ETHANOL     0.64     /
;

$ontext
* By now this table is also introduced by the Excel workbook IPTS_DATA_REQU.xlsx

Table proj_fuel(sim,*)  Projected fuel consumption in million t oil equivalent
            FUEL

Base        281.07
2008        281.53
2009        290.43
2010        291.17
2011        293.15
2012        295.12
2013        297.09
2014        299.07
2015        301.04
2016        300.84
2017        300.64
2018        300.43
2019        300.23
2020        300.03
;
$offtext

transp_fuel(sim)   =  proj_fuel(sim,"fuel");

$ontext
TABLE CONVB(energ,comm)  Conversion factors in biofuel production
           CWHEAT  CORN    SUGAR   RAPOIL SUNOIL PALMOIL SOYOIL
BIODIESEL                          0.9434 0.9434 0.9434  0.9434
ETHANOL    3.42032 3.29364 2.53357
;
$offtext

* Use of factors applied already in base data generation process
Parameter CONVBF(energ,comm);

CONVBF("BIODIESEL",i_diesel) = oil_to_diesel;
CONVBF("ETHANOL","CWHEAT")   = 1/crops_to_ethanol("CWHEAT");
CONVBF("ETHANOL","CORN")     = 1/crops_to_ethanol("CORN");
CONVBF("ETHANOL","SUGAR")    = 1/crops_to_ethanol("SUGAR");

CONVBF("ETHANOL","RYE")        = 1/crops_to_ethanol("RYE");
CONVBF("ETHANOL","OTHGRA")     = 1/crops_to_ethanol("OTHGRA");
CONVBF("ETHANOL","BARLEY")     = 1/crops_to_ethanol("BARLEY");

display crops_to_ethanol,oil_to_diesel;


Parameters
convbfcc(cc,energ,comm)  conversion factor in EU27, US, ROW
convbfcc2(cc,energ,comm)  ;

convbfcc(cc,energ,comm) = convbf(energ,comm) ;
convbfcc(cc,'biodiesel',comm)$convbf('biodiesel',comm) = 1/convbf('biodiesel',comm) ;
*convbfcc("row","biodiesel","sunoil") = procdem0("row","sunoil")/supply.l("row","biodiesel") ;

*display convbfcc;

*PDEM_BF.l(cc,'biodiesel',i_diesel) = procdem0(CC,I_diesel);
*PDEM_BF.l(cc,'ethanol',i_ethanol) = procdem0(CC,I_ethanol);

parameter
input_diesel input demand in biodiesel production
output_diesel Output biodiesel production
add_diesel
add_ethanol
input_eth input demand in ethanol production
output_eth Output ethanol production

;

***check the problems in US and ROW data in biodiesel and bioethanol production
input_diesel(cc)$SUPPLY.l(cc,'biodiesel')  = SUM(I_diesel, procdem0(cc,I_diesel)/convbfcc(cc,'biodiesel',I_diesel));
output_diesel(cc)  = SUPPLY.l(cc,'biodiesel');

input_eth(cc)$SUPPLY.l(cc,'ethanol') = SUM(i_ethanol, procdem0(cc,i_ethanol)/convbfcc(cc,'ethanol',I_ethanol));
output_eth(cc)   =  SUPPLY.l(cc,'ethanol');


display convbfcc, input_diesel,output_diesel,input_eth,output_eth,i_ethanol,i_diesel,procdem0;



parameter eth_test(cc,i_ethanol);

eth_test(cc,i_ethanol)$convbfcc(cc,'ethanol',I_ethanol) = procdem0(cc,i_ethanol)/convbfcc(cc,'ethanol',I_ethanol);

display eth_test;


add_diesel(cc)$output_diesel(cc) = input_diesel(cc)/output_diesel(cc);
add_ethanol(cc)$output_eth(cc)   = input_eth(cc)/output_eth(cc);

display add_diesel, add_ethanol,convbfcc;

convbfcc2(cc,'biodiesel',comm) =convbfcc(cc,'biodiesel',comm)* add_diesel(cc);
convbfcc2(cc,'ethanol',comm) =convbfcc(cc,'ethanol',comm)* add_ethanol(cc);


input_diesel(cc)$SUPPLY.l(cc,'biodiesel')  = SUM(I_diesel, procdem0(cc,I_diesel)/convbfcc2(cc,'biodiesel',I_diesel));
output_diesel(cc)  = SUPPLY.l(cc,'biodiesel');

input_eth(cc)$SUPPLY.l(cc,'ethanol') = SUM(i_ethanol, procdem0(cc,i_ethanol)/convbfcc2(cc,'ethanol',I_ethanol));
output_eth(cc)   =  SUPPLY.l(cc,'ethanol');


add_diesel(cc)$output_diesel(cc) = input_diesel(cc)/output_diesel(cc);
add_ethanol(cc)$output_eth(cc)   = input_eth(cc)/output_eth(cc);


display input_eth,output_eth,add_diesel, add_ethanol,convbfcc2;






Loop(cc,
ABORT$((abs(1-add_diesel(cc)) gt 0.0001) and (output_diesel(cc) ne 0)) "Input Output Relation BD different from Basedata",add_diesel;
ABORT$((abs(1-add_ethanol(cc)) gt 0.0001) and (output_eth(cc) ne 0)) "Input Output Relation BD different from Basedata",add_ethanol;
);


convbfcc(cc,'biodiesel',I_diesel) = convbfcc2(cc,'biodiesel',I_diesel)*add_diesel(cc);
convbfcc(cc,'ethanol',I_ethanol) = convbfcc2(cc,'ethanol',I_ethanol)*add_ethanol(cc);



parameter
coef_p_bf(energ,comm,comm1) coefficient byproducts in biofuels production
;


coef_p_bf('ethanol','cwheat','glutfd') = 0.266;
coef_p_bf('ethanol','Barley','glutfd')   = 0.266;
coef_p_bf('ethanol','OTHGRA','glutfd')   = 0.266;
coef_p_bf('ethanol','Rye','glutfd')   = 0.266;
coef_p_bf('ethanol','corn','glutfd')   = 0.292;

elasthd(cc,energ,energ)    = -3.0;
elasthd(cc,energ,'C_OIL')  = 1.0;

* <%INPUT%>
scalar elast__bf_sup "Own price elasticity of biofuel supply"/7.0/;
* <%FORMAT #,###,##0%>
* <%USERLEVEL 1%>
* <%/INPUT%>

elastsp(cc,energ,energ)    = elast__bf_sup;



elast_en_inp(cc,energ)     =  elast__bf_sup* (-.9);

* biof_CES_el(cc,energ)       elasticity parameter of input demand in biofuels

biof_CES_el(cc,energ)   =  4.5;





*================== Calibration of parameters in CES-function =========================
Variable
CAL_D(cc,energ,comm)  distrib parameter in CES function
target
;

*# Determination of net prices in biofuel production
             NetPD_0(cc,energ,comm)  =
               (PD_0(cc,comm)
               - SUM(comm1, coef_p_bf(energ,comm,comm1) * PD_0(cc,comm1))
               )$(biof_e(energ) and I_ETHANOL(COMM))
+
               (PD_0(cc,comm)
               - SUM(comm1, coef_p_bf(energ,comm,comm1) * PD_0(cc,comm1))
               )$(biof_d(energ) and I_DIESEL(COMM)) ;


*#Überschreiben für Zucker in Ethanolproduktion um auf Weltmarktpreis zu kalibrieren

             NetPD_0(member,'ethanol','sugar')  =

               (PD_0('row','sugar')/exrate(member)

               - SUM(comm1, coef_p_bf('ethanol','sugar',comm1) * PD_0(member,comm1))
               )$(biof_e('ethanol') and I_ETHANOL('sugar'));

*NetPD_0('HR',energ,comm) = 0.0;

Equation
EQCAL_D1(cc,i_diesel)   distrib parameter in CES function biodiesel
EQCAL_E1(cc,i_ethanol)  distrib parameter in CES function ethanol
EQCAL_D2(cc)       Sum of distrib parameter in CES function biodiesel
EQCAL_E2(cc)       Sum of distrib parameter in CES function ethanol
EQOBJ
;



EQCAL_D1(CC,i_DIESEL) $ (not sameas(I_DIESEL,'RAPOIL') and procdem0(CC,I_DIESEL) and supply.l(cc,'biodiesel'))  ..
                (procdem0(CC,I_DIESEL)/convbfcc(cc,'biodiesel',I_DIESEL))*CAL_D(cc,'BIODIESEL','RAPOIL')
                 *NETPD_0(cc,'biodiesel',i_diesel)**biof_CES_el(CC,'BIODIESEL')
                =e= (procdem0(CC,'RAPOIL')/convbfcc(cc,'biodiesel','RAPOIL'))*CAL_D(cc,'BIODIESEL',I_DIESEL)
                    *NetPD_0(cc,'BIODIESEL','RAPOIL')**biof_CES_el(CC,'BIODIESEL');

EQCAL_D2(CC)$supply.l(cc,'biodiesel') .. 1 =e= sum(I_DIESEL, CAL_D(CC,'BIODIESEL',I_DIESEL));


EQCAL_E1(CC,i_ETHANOL) $ (not sameas(I_ETHANOL,'CORN') and procdem0(CC,I_ETHANOL) and supply.l(cc,'ethanol'))  ..

                (procdem0(CC,I_ETHANOL)/convbfcc(cc,'ETHANOL',I_ETHANOL))*CAL_D(cc,'ETHANOL','CORN')
                *NetPD_0(cc,'ETHANOL',i_ethanol)**biof_CES_el(CC,'ETHANOL')
                 =e= (procdem0(CC,'CORN')/convbfcc(cc,'ETHANOL','CORN'))
                               * CAL_D(cc,'ETHANOL',I_ETHANOL)
                               *NetPD_0(cc,'ETHANOL','CORN')**biof_CES_el(CC,'ETHANOL');

EQCAL_E2(CC)$supply.l(cc,'ethanol') .. 1 =e= sum(I_ETHANOL, CAL_D(CC,'ETHANOL',I_ETHANOL));

EQOBJ..  TARGET =E=  SUM((CC,i_ethanol), CAL_D(CC,'ethanol',i_ethanol));


model MCALD /EQCAL_D1,EQCAL_D2,EQCAL_E1,EQCAL_E2,EQOBJ/;


* Initialisation of CES parameters
alias (i_diesel,i_diesel1) ;
cal_D.l(cc,'biodiesel',i_diesel)$supply.l(cc,'biodiesel') = procdem0(CC,I_DIESEL)/convbfcc(cc,'biodiesel',I_DIESEL)
                                   *netpd_0(cc,'biodiesel',i_diesel)**biof_CES_el(CC,'BIODIESEL')/
                                   sum(i_diesel1,procdem0(CC,I_DIESEL1)/convbfcc(cc,'biodiesel',I_DIESEL1)
                                                 *netpd_0(cc,'biodiesel',i_diesel1)**biof_CES_el(CC,'BIODIESEL')
                                       ) ;
alias (i_ethanol,i_ethanol1) ;
cal_D.l(cc,'ethanol',i_ethanol)$supply.l(cc,'ethanol') = procdem0(CC,I_ethanol)/convbfcc(cc,'ethanol',I_ethanol)
                                   *netpd_0(cc,'ethanol',i_ethanol)**biof_CES_el(CC,'ethanol')/
                                   sum(i_ethanol1, procdem0(CC,I_ethanol1)/convbfcc(cc,'ethanol',I_ethanol1)
                                   *netpd_0(cc,'ethanol',i_ethanol1)**biof_CES_el(CC,'ethanol')
                                  ) ;

*cal_D.l(cc,'biodiesel',i_diesel)$(cal_D.l(cc,'biodiesel',i_diesel) lt 0.0005) = 0;
*cal_D.l(cc,'ethanol',i_ethanol)$(cal_D.l(cc,'ethanol',i_ethanol) lt 0.0005) = 0;


CAL_D.fx(CC,'BIODIESEL',i_diesel)$(procdem0(CC,I_DIESEL) eq 0.0) = 0;
CAL_D.fx(CC,'ETHANOL',i_ethanol)$(procdem0(CC,I_ETHANOL) eq 0.0) = 0;
CAL_D.fx(CC,'BIODIESEL',i_ethanol)$(procdem0(CC,I_ethanol) eq 0.0) = 0;
CAL_D.fx(CC,'ETHANOL',i_diesel)$(procdem0(CC,I_diesel) eq 0.0) = 0;


display cal_d.l;




solve MCALD maximizing target using nlp ;


biof_CES_shr(cc,energ,comm)  = cal_d.l(cc,energ,comm);

display biof_CES_shr;



biof_CES_int(cc,'biodiesel')$SUPPLY.l(cc,'biodiesel') = 1/sum[I_DIESEL, biof_CES_shr(cc,'BIODIESEL',I_DIESEL)**(1/biof_CES_el(CC,'BIODIESEL'))
                               *(procdem0(CC,I_DIESEL)/convbfcc(cc,'biodiesel',I_DIESEL))**((biof_CES_el(CC,'BIODIESEL')-1)/biof_CES_el(CC,'BIODIESEL'))]
                                   **(biof_CES_el(CC,'BIODIESEL')/(biof_CES_el(CC,'BIODIESEL')-1));

biof_CES_int(cc,'ETHANOL')$SUPPLY.l(cc,'ethanol') = 1/sum[I_ETHANOL, biof_CES_shr(cc,'ETHANOL',I_ETHANOL)**(1/biof_CES_el(CC,'ETHANOL'))
                               *(procdem0(CC,I_ETHANOL)/convbfcc(cc,'ethanol',I_ETHANOL))**((biof_CES_el(CC,'ETHANOL')-1)/biof_CES_el(CC,'ETHANOL'))]
                                   **(biof_CES_el(CC,'ETHANOL')/(biof_CES_el(CC,'ETHANOL')-1));


parameter
ini_quan(cc,energ,comm) Initial quantities in biofuel production after CES function calibration
ini_shr(cc,energ,comm)  Initial shares in biofuel production after CES function calibration
;
ini_quan(cc,'BIODIESEL',comm)$NetPD_0(cc,'BIODIESEL',comm) =
              [ 1 / biof_CES_int(cc,'BIODIESEL') * biof_CES_shr(cc,'BIODIESEL',comm) / NetPD_0(cc,'BIODIESEL',comm)**biof_CES_el(CC,'BIODIESEL')
               *sum[comm1$(i_diesel(comm1) or i_ethanol(comm1)), biof_CES_shr(cc,'BIODIESEL',comm1)*NetPD_0(cc,'BIODIESEL',comm1)**(1-biof_CES_el(CC,'BIODIESEL'))]
        **(biof_CES_el(CC,'BIODIESEL')/(1-biof_CES_el(CC,'BIODIESEL')))
             ]$(supply.l(cc,'BIODIESEL') and (i_diesel(comm) or i_ethanol(comm)));

ini_quan(cc,'ETHANOL',comm)$NetPD_0(cc,'ETHANOL',comm) =
              [ 1 / biof_CES_int(cc,'ETHANOL') * biof_CES_shr(cc,'ETHANOL',comm) / NetPD_0(cc,'ETHANOL',comm)**biof_CES_el(CC,'ETHANOL')
               *sum[comm1$(i_diesel(comm1) or i_ethanol(comm1)), biof_CES_shr(cc,'ETHANOL',comm1)*NetPD_0(cc,'ETHANOL',comm1)**(1-biof_CES_el(CC,'ETHANOL'))]
        **(biof_CES_el(CC,'ETHANOL')/(1-biof_CES_el(CC,'ETHANOL')))
             ]$(supply.l(cc,'ETHANOL') and (i_diesel(comm) or i_ethanol(comm)));


ini_shr(cc,energ,comm)$supply.l(cc,energ) = ini_quan(cc,energ,comm) / SUM(comm1, ini_quan(cc,energ,comm1)) ;

BCI0(cc,energ) =  (SUM(comm$i_biofuel(energ,comm), ini_quan(cc,energ,comm)*(NetPD_0(cc,energ,comm))) /
                  SUM(comm$i_biofuel(energ,comm), ini_quan(cc,energ,comm)))$SUPPLY.l(cc,energ);



BCI.l(cc,energ) = 1.0;
NetPD.l(cc,energ,comm)= NetPD_0(cc,energ,comm);
QUANCES.l(cc,energ,comm) =  ini_quan(cc,energ,comm);
QUANCES0(cc,energ,comm) =  ini_quan(cc,energ,comm);
PDEM_BF.l(cc,'biodiesel',i_diesel) = procdem0(CC,I_diesel);
PDEM_BF.l(cc,'ethanol',i_ethanol) = procdem0(CC,I_ethanol);


shft_bioenergy(cc,comm) = 1.0;



