$setglobal fcaprires '.\input\res_2_0420MTR_RD_toEsim.gdx'
$setglobal dircapri 'E:\CAPRI\gams'
$setglobal diresim '..\ESIM'
$setglobal SIMY                2020
$setglobal CAPRI_BASY          2004

$include '%diresim%\sets.gms'
$include '%diresim%\alias.gms'


*************************************************************
$ontext

 prepare sets and parameters for capri input data

$offtext
*************************************************************

$setglobal MARKET_M ON
$include '.\SSA\capri_sets.gms'
$include '.\SSA\capri_arm_sets.gms'

set cols_to_esim(cols) / PPRI,CPRI,PROD,HCON,PROC,BIOF,ISCH,NTRD,INCE /;
set basBal / BAS,CAL /;
set basYsimY / BAS, '%SIMY%'/;

parameter
      p_toEsim(RMALL,COLS_to_esim,*,*)
      p_ElasSupp(RMALL,XX_ALL,XX_ALL,BASCAL)           "Elasticity of supply"
      p_ElasDem(RMALL,XX_ALL,XX_ALL,BASCAL)            "Elasticity of human consumption"
      p_ElasFeed(RMALL,XX_ALL,XX_ALL,BASCAL)           "Elasticity of feed"
      p_ElasProc(RMALL,XX_ALL,XX_ALL,BASCAL)           "Elasticity of processing"
      p_ElasDair(RMALL,XX_ALL,XX_ALL,BASCAL)           "Elasticity of dairy production"
;

*************************************************************
$ontext

 mapping sets ESIM.CAPRI

$offtext
*************************************************************
SET esim_to_rows(comm,rows) 'Map commodities from ESIM to CAPRI'
/
*
* Cereals
*
CWHEAT    .(    WHEA)
DURUM     .(    DWHE)
BARLEY    .(    BARL)
CORN      .(    MAIZ)
RYE       .(    RYEM)
OTHGRA    .(    OCER,OATS)
*
* ESIM: paddy or rice?
*
RICE      .(    RICE)
*
* Other arable
*
SUGAR     .(    SUGA)
POTATO    .(    POTA)
SOYBEAN   .(    SOYA)
RAPSEED   .(    RAPE)
SUNSEED   .(    SUNF)
SMAIZE    .(    FMAI)
FODDER    .(    OFAR)
GRAS      .(    GRAS)
*
*OENERGY
* Milk is mapped both to raw milk (for farm balance) and deliveries
* to dairies (for market balance)
MILK      .(    MILK)
*
* On farm consumption on milk
*
CMILK     .(    FRMI)

SMP       .(    SMIP)
WMP       .(    WMIO)
CREAM     .(    CREM)
CONC_MLK  .(    COCM)
*ACID_MLK ??
WHEY      .(    WHEP)
BUTTER    .(    BUTT)
CHEESE    .(    CHES)
OTHDAIRY  .(    CASE)
*
*
FAT       .(    FATS)
PROTEIN   .(    PROT)
*
BEEF      .(    BEEF)
SHEEP     .(    SGMT)
PORK      .(    PORK)
POULTRY   .(    POUM)
EGGS      .(    EGGS)
*
SOYOIL    .(    SOYO)
RAPOIL    .(    RAPO)
SUNOIL    .(    SUNO)
PALMOIL   .(    PLMO)
*
SOYMEAL   .(    SOYC)
RAPMEAL   .(    RAPC)
SUNMEAL   .(    SUNC)
*
ETHANOL   .BIOE
BIODIESEL .BIOD
GLUTFD    .(    DDGS)
MANIOC    .(    FENI)
OPROT     .(    FPRI)
*               OSET
*SETASIDE  .(    VSET)
/;

SET esim_to_ms(ccplus,RMALL)
/
  BE.BL000000
  GE.DE000000
  DK.DK000000
  GR.EL000000
  ES.ES000000
  FR.FR000000
  IE.IR000000
  IT.IT000000
  NL.NL000000
  AT.AT000000
  PT.PT000000
  SW.SE000000
  FI.FI000000
  UK.UK000000
  CY.CY000000
  MT.MT000000
  PL.PL000000
  SK.SK000000
  SI.SI000000
  CZ.CZ000000
  EE.EE000000
  LT.LT000000
  LV.LV000000
  HU.HU000000
  BG.BG000000
  RO.RO000000
  HR.HR000000
  WB.(AL000000
      MK000000
      CS000000
      MO000000
      BA000000
      KO000000)
  TU.TUR
  US.USA
 ROW.(NO000000, CH, REU, RUS, UKR, FSU, MOR, MIDEAST
      NGA, ETH, ZAF, AFR_LDC, AFR_REST, IND, PAK, BGD
      CHN, JAP, MALIND, TAW, ASI_TIG, ASI_SE, ASOCE_LDC, ASOCE_REST
      ANZ, CAN, MEX, ARG, BRA, MSA_ACP, RSA, TUN
      ALG, EGY, ISR, VEN, CHL, URU, PAR, BOL)
   /;

set
   NONEU27_CAPRI(RMS) all countries or regions except EU27
   ROW_CAPRI(RMS)    all countries not included as single regions in ESIM
;


NONEU27_CAPRI(RMS)$(NOT sum(EU27, esim_to_ms(EU27,RMS))) = YES;
ROW_CAPRI(RMS)$(NOT sum(cc, esim_to_ms(cc,RMS))) = YES;
display ROW_CAPRI;

* load capri results:
execute_load '%fcaprires%', p_toEsim, p_ElasDem;

SET VARSET variables to hand over to ESIM / SUPPLY, TUSE, NETEXP, HDEM, PW /;

parameter
   outesimpc(*,i,*) output data in esim coding as percentage changes from ESIM base to 2020
   outesim(*,i,*,*) output data in esim coding as levels data
   outesimagg(*,i,*,*) output data in esim coding as levels data with only aggregates (EU15 EU12 ROW (=ROW&US&WB))
   outesimaggpc(*,i,*) output data in esim coding as % changes with only aggregates (EU15 EU12 ROW(=ROW&US&WB))
;

* aggregate / map to ESIM regions and products:
   outesim(cc,comm,'SUPPLY',basYsimY) = sum(esim_to_ms(cc,RMS),
                                    sum(esim_to_rows(comm,XX), p_toEsim(RMS,'PROD',XX,basYsimY) )
                                 );

   outesim(cc,comm,'TUSE',basYsimY) = sum(esim_to_ms(cc,RMS),
                                    sum(esim_to_rows(comm,XX), p_toEsim(RMS,'PROD',XX,basYsimY) - p_toEsim(RMS,'NTRD',XX,basYsimY))
                                 );

   outesim(cc,comm,'NETEXP',basYsimY) = sum(esim_to_ms(cc,RMS),
                                    sum(esim_to_rows(comm,XX), p_toEsim(RMS,'NTRD',XX,basYsimY))
                                 );

   outesim(cc,comm,'HDEM',basYsimY) = sum(esim_to_ms(cc,RMS),
                                    sum(esim_to_rows(comm,XX), p_toEsim(RMS,'HCON',XX,basYsimY) )
                                 );

   outesim('ROW',comm,'PW',basYsimY)$sum(esim_to_ms(cc,RMS)$(NONEU27_CAPRI(RMS)), sum(esim_to_rows(comm,XX), p_toEsim(RMS,'PROD',XX,basYsimY) ) )
                                    = sum(esim_to_ms(cc,RMS)$(NONEU27_CAPRI(RMS)),
                                       sum(esim_to_rows(comm,XX), p_toEsim(RMS,'PPRI',XX,basYsimY)
                                               * p_toEsim(RMS,'PROD',XX,basYsimY) ) )
                                       / sum(esim_to_ms(cc,RMS)$(NONEU27_CAPRI(RMS)),
                                       sum(esim_to_rows(comm,XX), p_toEsim(RMS,'PROD',XX,basYsimY) ) );

* split missing products CMILK&ACID_MLK and CWHEAT&DURUM:
PARAMETER
   show_data(i,data_base,ccplus) "Consolidated data base, in 1000 t (ESIM)"
;

$GDXin '%diresim%\Quantities.gdx'
$load show_data
$GDXIN

   outesim(cc,'DURUM','SUPPLY',basYsimY) = outesim(cc,'CWHEAT','SUPPLY',basYsimY) * show_data('DURUM','PROD',cc)/(show_data('DURUM','PROD',cc)+show_data('CWHEAT','PROD',cc));
   outesim(cc,'CWHEAT','SUPPLY',basYsimY) = outesim(cc,'CWHEAT','SUPPLY',basYsimY) - outesim(cc,'DURUM','SUPPLY',basYsimY);
   outesim(cc,'DURUM','TUSE',basYsimY) = outesim(cc,'CWHEAT','TUSE',basYsimY) * show_data('DURUM','PROD',cc)/(show_data('DURUM','PROD',cc)+show_data('CWHEAT','PROD',cc));
   outesim(cc,'CWHEAT','TUSE',basYsimY) = outesim(cc,'CWHEAT','TUSE',basYsimY) - outesim(cc,'DURUM','TUSE',basYsimY);
   outesim(cc,'CWHEAT','NETEXP',basYsimY) = outesim(cc,'CWHEAT','SUPPLY',basYsimY) - outesim(cc,'CWHEAT','TUSE',basYsimY);
   outesim(cc,'DURUM','NETEXP',basYsimY) = outesim(cc,'DURUM','SUPPLY',basYsimY) - outesim(cc,'DURUM','TUSE',basYsimY);
   outesim('ROW','DURUM','PW',basYsimY) = outesim('ROW','CWHEAT','PW',basYsimY);

   outesim(cc,'ACID_MLK','SUPPLY',basYsimY) = outesim(cc,'CMILK','SUPPLY',basYsimY) * show_data('ACID_MLK','PROD',cc)/(show_data('ACID_MLK','PROD',cc)+show_data('CMILK','PROD',cc));
   outesim(cc,'CMILK','SUPPLY',basYsimY) = outesim(cc,'CMILK','SUPPLY',basYsimY) - outesim(cc,'ACID_MLK','SUPPLY',basYsimY);
   outesim(cc,'ACID_MLK','TUSE',basYsimY) = outesim(cc,'CMILK','TUSE',basYsimY) * show_data('ACID_MLK','PROD',cc)/(show_data('ACID_MLK','PROD',cc)+show_data('CMILK','PROD',cc));
   outesim(cc,'CMILK','TUSE',basYsimY) = outesim(cc,'CMILK','TUSE',basYsimY) - outesim(cc,'ACID_MLK','TUSE',basYsimY);
   outesim(cc,'CMILK','NETEXP',basYsimY) = outesim(cc,'CMILK','SUPPLY',basYsimY) - outesim(cc,'CMILK','TUSE',basYsimY);
   outesim(cc,'ACID_MLK','NETEXP',basYsimY) = outesim(cc,'ACID_MLK','SUPPLY',basYsimY) - outesim(cc,'ACID_MLK','TUSE',basYsimY);
   outesim('ROW','ACID_MLK','PW',basYsimY) = outesim('ROW','CMILK','PW',basYsimY);


* aggregate EU15, EU12 and a ROW comprising ROW&US&WB:
   SET SDX /SUPPLY, TUSE, NETEXP, HDEM/;
   outesimagg('EU15',comm,SDX,basYsimY) = sum(cc$EU15(cc),outesim(cc,comm,SDX,basYsimY));
   outesimagg('EU12',comm,SDX,basYsimY) = sum(cc$EU12(cc),outesim(cc,comm,SDX,basYsimY));
   outesimagg('ROW',comm,SDX,basYsimY) = sum(cc$rest(cc),outesim(cc,comm,SDX,basYsimY));
   outesimagg('ROW',comm,'PW',basYsimY)$outesimagg('ROW',comm,'SUPPLY',basYsimY) = sum(esim_to_ms(rest,RMS),
                                    sum(esim_to_rows(comm,XX), p_toEsim(RMS,'PPRI',XX,basYsimY)
                                            * p_toEsim(RMS,'PROD',XX,basYsimY) ) / outesimagg('ROW',comm,'SUPPLY',basYsimY)
                              );
   outesimagg('ROW','DURUM','PW',basYsimY) = outesimagg('ROW','CWHEAT','PW',basYsimY);
   outesimagg('ROW','ACID_MLK','PW',basYsimY) = outesimagg('ROW','CMILK','PW',basYsimY);




* calculate percentage changes from base year:
* CAPRI currently uses 2004
* ESIM currently uses 2006-2007
* use a linear interpolation to get changes from 2006/07 to 2020

parameter ipol_pt distance of ESIM base year from CAPRI base year /2.5/;
SET ccEU1512 / set.cc, EU15, EU12 /;
SET EU1512ROW / EU15, EU12, ROW /;

outesim(cc,comm,VARSET,'2006/07') = outesim(cc,comm,VARSET,'BAS') + ipol_pt/(%SIMY%-%CAPRI_BASY%) * (outesim(cc,comm,VARSET,'%SIMY%') - outesim(cc,comm,VARSET,'BAS'));
outesimagg(EU1512ROW,comm,VARSET,'2006/07') = outesimagg(EU1512ROW,comm,VARSET,'BAS') + ipol_pt/(%SIMY%-%CAPRI_BASY%) * (outesimagg(EU1512ROW,comm,VARSET,'%SIMY%') - outesimagg(EU1512ROW,comm,VARSET,'BAS'));

outesimpc(ccEU1512,comm,VARSET)$outesim(ccEU1512,comm,VARSET,'2006/07') = 100*(outesim(ccEU1512,comm,VARSET,'%SIMY%') / outesim(ccEU1512,comm,VARSET,'2006/07') -1);
outesimaggpc(EU1512ROW,comm,VARSET)$outesimagg(EU1512ROW,comm,VARSET,'2006/07') = 100*(outesimagg(EU1512ROW,comm,VARSET,'%SIMY%') / outesimagg(EU1512ROW,comm,VARSET,'2006/07') -1);

display outesim, outesimpc, outesimagg, outesimaggpc;


execute_UNLOAD '.\output\target_data_capri.gdx', outesimagg, outesimaggpc;

