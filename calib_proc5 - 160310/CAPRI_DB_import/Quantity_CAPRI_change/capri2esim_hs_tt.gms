$setglobal fcaprires '.\capri_data\res_08.gdx'
$setglobal fcapriresROW '.\capri_data\data_market_0820.gdx'

*$setglobal dircapri 'E:\CAPRI\gams'
$setglobal EUMODE EU28

$setglobal diresim '.\esim_set_data'
$setglobal SIMY                2020
$setglobal CAPRI_BASY          2004

$include '%diresim%\sets.gms'
$include '%diresim%\alias.gms'


*************************************************************
* prepare sets and parameters for capri input data
*************************************************************

$setglobal MARKET_M ON


$include '.\capri_set\capri_sets.gms'
$include '.\capri_set\capri_arm_sets.gms'

set cols_to_esim(cols) / ARM1,ARM2,DSales,PROD,HCON,PROC,BIOF,ISCH,NTRD,INCE,FEED /;
set basBal / BAS,CAL /;
set basYsimY / BAS, '%SIMY%'/;


set item
/PROD,SDEM,HDEM,FDEM,PDEM,IDEM,AREA,PRICE,NETRD/
blance(item)
/PROD,SDEM,HDEM,FDEM,PDEM,NETRD,AREA/
balance2(blance)
/PROD,SDEM,HDEM,FDEM,PDEM/
;

parameter
      Data_CAL(RMALL,COLS_to_esim,*,*)
      DATA2(RMALL,*,*,*)
;



*************************************************************
** mapping sets ESIM.CAPRI
*************************************************************
SET esim_to_rows(comm,rows) 'Map commodities from ESIM to CAPRI'
/
*
* Cereals
*
CWHEAT    .(    SWHE)
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
FODDER    .(    OFAR,ROOF)
STRA      .(    STRA)
GRAS      .(    GRAS)

PULS      .(   PULS)
OPROT     .(   FPRI)
OENERGY   .(   FENI)
OENERGY_CAPRI.(   MOLA,TOMA, OVEG,APPL,OFRU, CITR)

MILK      .(    COMI,SGMI)   " MILK: raw milk at diary"
CMILK     .(    FRMI)        " FRMI: Fresh milk products"

SMP       .(    SMIP)
WMP       .(    WMIO)
CREAM     .(    CREM)
CONC_MLK  .(    COCM)

WHEY      .(    WHEP)
BUTTER    .(    BUTT)
CHEESE    .(    CHES)
*OTHDAIRY  .(    CASE)   OTHDAIRY removed
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

GLUTFD    .(   DDGS)
**definition check again
*MANIOC    .(   FENI)  Fodder energy rich imported


*SETASIDE  .(    VSET)
*ACID_MLK ??
/;

*************************************************************
**regional mapping sets ESIM.CAPRI
*************************************************************


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
      CHN, JAP, MAL, INDO, TAW, SKOR, VIET, THAI, ASOCE_LDC, ASOCE_REST
      ANZ, CAN, MEX, ARG, BRA, MSA_ACP, RSA,
      TUN, ALG, EGY, ISR, VEN, CHL, URU, PAR, BOL)
   /;

set
   NONEU27_CAPRI(RMS) all countries or regions except EU27
   ROW_CAPRI(RMS)    all countries not included as single regions in ESIM
;


NONEU27_CAPRI(RMS)$(NOT sum(EU27, esim_to_ms(EU27,RMS))) = YES;
ROW_CAPRI(RMS)$(sum(esim_to_ms('ROW',RMS),esim_to_ms('ROW',RMS))) = YES;


display NONEU27_CAPRI,ROW_CAPRI;


* load capri results:
execute_load '%fcaprires%', DATA2;
execute_load '%fcapriresROW%', Data_CAL;


display DATA2,Data_CAL;


* split missing products CMILK&ACID_MLK and CWHEAT&DURUM:
PARAMETER
   show_data(i,*,ccplus) "Consolidated data base, in 1000 t (ESIM)"
   consolid_area(i,ccplus)
   pp_results(i,ccplus,*)
   fdem0(*,*)
;

$GDXin '%diresim%\Quantities.gdx'
$load show_data,consolid_area
$GDXIN

*$GDXin '%diresim%\data_quantities.gdx'
*$load fdem0
*$GDXIN

*$GDXin '%diresim%\prices_policies.gdx'
*$load pp_results
*$GDXIN


Parameter
compare_data(*,*,*,*)
;

*************************************************************
**Importing ESIM data
*************************************************************

compare_data(cc,comm,'PROD','ESIM')
 = show_data(comm,'PROD',cc)$(show_data(comm,'PROD',cc) gt 1);

compare_data(cc,comm,'SDEM','ESIM')
 = show_data(comm,'SDEM',cc)$(show_data(comm,'SDEM',cc) gt 1);

compare_data(cc,comm,'HDEM','ESIM')
 = show_data(comm,'HDEM',cc)$(show_data(comm,'HDEM',cc) gt 1);

compare_data(cc,comm,'FDEM','ESIM')
 = show_data(comm,'FDEM',cc)$(show_data(comm,'FDEM',cc) gt 1);

compare_data(cc,comm,'PDEM','ESIM')
 = show_data(comm,'PDEM',cc)$(show_data(comm,'PDEM',cc) gt 1);


compare_data(cc,it,'NETRD','ESIM')
 = compare_data(cc,it,'PROD','ESIM')
 - compare_data(cc,it,'SDEM','ESIM')
 - compare_data(cc,it,'HDEM','ESIM')
 - compare_data(cc,it,'FDEM','ESIM')
 - compare_data(cc,it,'PDEM','ESIM')
;


*************************************************************
**Importing CAPRI data
*************************************************************


SET VARSET variables to hand over to ESIM / SUPPLY, TUSE, NETEXP, HDEM, PW /;

parameter
   outesimpc(*,i,*) output data in esim coding as percentage changes from ESIM base to 2020
   CapToEsiBalan(*,i,*,*) output data in esim coding as levels data
   CapToEsiBalanROW(*,i,*,*) output data in esim coding as levels data

   CapToEsimArea(*,i,*,*) output data in esim coding as levels data
   CapToEsimPrice(*,i,*,*) output data in esim coding as levels data

   outesimagg(*,i,*,*) output data in esim coding as levels data with only aggregates (EU15 EU12 ROW (=ROW&US&WB))
   outesimaggpc(*,i,*) output data in esim coding as % changes with only aggregates (EU15 EU12 ROW(=ROW&US&WB))
;

* aggregate / map to ESIM regions and products:
   CaptoEsiBalan(cc,comm,'PROD','Base') = sum(esim_to_ms(cc,RMS),
                                        sum(esim_to_rows(comm,rows),
                                               ( DATA2(RMS,'NETF',rows,'Y') + DATA2(RMS,'SEDF',rows,'Y')$DATA2(RMS,rows,'levl','Y')) $(not ((sameas(rows,'GRAS') or sameas(rows,'OFAR') or sameas(rows,'ROOF')or sameas(rows,'FMAI') or sameas(rows,'STRA')) ))
                                            -    DATA2(RMS,'STCM',rows,'Y') $((DATA2(RMS,'STCM',rows,'Y') lt 0) and DATA2(RMS,rows,'levl','Y') and not (sameas(rows,'GRAS')or sameas(rows,'OFAR') or sameas(rows,'ROOF')or sameas(rows,'FMAI')or sameas(rows,'STRA')))

                                            +    DATA2(RMS,'MAPR',rows,'Y') $ (Not  DATA2(RMS,'NETF',rows,'Y'))
***CREM etc products included in "MAPR" indexes
                                            +    DATA2(RMS,'GROF','COMF','Y')  $sameas(rows,'COMI')
***COMF (milk for feeding) is classified as COMI (milk for sales) in gross production

                                            +    DATA2(RMS,'GROF',rows,'Y')* DATA2(RMS,'DRMA',rows,'Y')  $sameas(rows,'GRAS')
                                            -    DATA2(RMS,'STCM',rows,'Y') $((DATA2(RMS,'STCM',rows,'Y') lt 0) and sameas(rows,'GRAS'))

                                            +    DATA2(RMS,'GROF',rows,'Y')* DATA2(RMS,'DRMA',rows,'Y')  $(sameas(rows,'OFAR') or sameas(rows,'ROOF')or sameas(rows,'STRA'))
                                            -    DATA2(RMS,'STCM',rows,'Y') $((DATA2(RMS,'STCM',rows,'Y') lt 0) and (sameas(rows,'OFAR') or sameas(rows,'ROOF')or sameas(rows,'STRA')))

                                            +    DATA2(RMS,'GROF',rows,'Y')* DATA2(RMS,'DRMA',rows,'Y')  $sameas(rows,'FMAI')
                                            -    DATA2(RMS,'STCM',rows,'Y') $((DATA2(RMS,'STCM',rows,'Y') lt 0) and sameas(rows,'FMAI'))
***GRAS, OFAR, FMAI are calculated in dry matter with muplication of 'DRMA'

 ));


   CaptoEsiBalan(cc,comm,'PROD','Base')$(sameas(comm,'ETHANOL_NAGR'))
                                       = sum(esim_to_ms(cc,RMS),
                                           DATA2(RMS,'NAGR','BIOE','Y'));


   CaptoEsiBalan(cc,comm,'PROD','Base')$(sameas(comm,'BIODIESEL_NAGR'))
                                       = sum(esim_to_ms(cc,RMS),
                                           DATA2(RMS,'NAGR','BIOD','Y'));

***NAGR is removed in bioenergy production
   CaptoEsiBalan(cc,'ETHANOL','PROD','Base')
   =  CaptoEsiBalan(cc,'ETHANOL','PROD','Base')
    - CaptoEsiBalan(cc,'ETHANOL_NAGR','PROD','Base')
    - sum(esim_to_ms(cc,RMS),DATA2(RMS,'BIOF','TWIN','Y')*0.1);

   CaptoEsiBalan(cc,'BIODIESEL','PROD','Base')
   =  CaptoEsiBalan(cc,'BIODIESEL','PROD','Base')
    - CaptoEsiBalan(cc,'BIODIESEL_NAGR','PROD','Base');





**ROW productin from CAPRI market module data, 'PROD' set, Calibrated data selected
   CaptoEsiBalan(cc,comm,'PROD','Base')$(sameas(cc,'ROW') or sameas(cc,'US'))
                                      = sum(esim_to_ms(cc,RMS),
                                         sum(esim_to_rows(comm,rows),
                                                 Data_CAL(RMS,'PROD',rows,'BAS') $ (not (sameas(rows,'GRAS')or sameas(rows,'OFAR') or sameas(rows,'FMAI')or sameas(rows,'STRA')))
                                            +    Data_CAL(RMS,'PROD','WHEA','BAS')  $sameas(rows,'SWHE')
                                            +    Data_CAL(RMS,'PROD','MILK','BAS')  $sameas(rows,'COMI')
                                            +    Data_CAL(RMS,'PROD',rows,'BAS')* DATA2(RMS,'DRMA',rows,'Y')  $sameas(rows,'GRAS')
                                            +    Data_CAL(RMS,'PROD',rows,'BAS')* DATA2(RMS,'DRMA',rows,'Y')  $(sameas(rows,'OFAR') or sameas(rows,'ROOF')or sameas(rows,'STRA'))
                                            +    Data_CAL(RMS,'PROD',rows,'BAS')* DATA2(RMS,'DRMA',rows,'Y')  $sameas(rows,'FMAI')));
****in ROW, WHEA = SWHE and MILK = COMI


display  CaptoEsiBalan;



*****************************************
****************** FATS calcuation
*****************************************
   CapToEsiBalan(cc,'FAT','PROD','Base') = sum(esim_to_ms(cc,RMS),
                                        sum(esim_to_rows('FAT','FATS'),
                                            DATA2(RMS,'FATS','LEVL','Y')/100));


***ROW FATS
   CaptoEsiBalan('ROW','FAT','PROD','Base') = sum(esim_to_ms('ROW',RMS),
                                        sum(esim_to_rows('FAT','FATS'),
                                                 Data_CAL(RMS,'PROD','FATS','BAS')/100));

***USA FATS
   CaptoEsiBalan('US','FAT','PROD','Base') = sum(esim_to_ms('US',RMS),
                                        sum(esim_to_rows('FAT','FATS'),
                                                 Data_CAL(RMS,'PROD','FATS','BAS')/100));



*****************************************
****************** PROTEIN calcuation****
*****************************************

   CapToEsiBalan(cc,'PROTEIN','PROD','Base') = sum(esim_to_ms(cc,RMS),
                                        sum(esim_to_rows('PROTEIN','PROT'),
                                            DATA2(RMS,'PROT','LEVL','Y')/100));
***ROW PROTEIN
   CapToEsiBalan('ROW','PROTEIN','PROD','Base') = sum(esim_to_ms(cc,RMS),
                                        sum(esim_to_rows('PROTEIN','PROT'),
                                            Data_CAL(RMS,'PROD','PROT','BAS')/100));

***USA PROTEIN
   CaptoEsiBalan('US','PROTEIN','PROD','Base') = sum(esim_to_ms('US',RMS),
                                        sum(esim_to_rows('PROTEIN','PROT'),
                                                 Data_CAL(RMS,'PROD','PROT','BAS')/100));



   CapToEsiBalan(cc,comm,'SDEM','Base') = sum(esim_to_ms(cc,RMS),
                                        sum(esim_to_rows(comm,rows),
                                                  DATA2(RMS,'SEDM',rows,'Y')
                                                 +DATA2(RMS,'SEDF',rows,'Y') ));



*****************************************
****************** Feed Demand Assigned
*****************************************

   CapToEsiBalan(cc,comm,'FDEM','Base') = sum(esim_to_ms(cc,RMS),
                                        sum(esim_to_rows(comm,rows),
                                                 DATA2(RMS,'FEDM',rows,'Y') $ (not (sameas(rows,'GRAS')or sameas(rows,'OFAR') or sameas(rows,'ROOF') or sameas(rows,'FMAI')or sameas(rows,'STRA')))
                                            +    DATA2(RMS,'FEDM',rows,'Y')* DATA2(RMS,'DRMA',rows,'Y')  $sameas(rows,'GRAS')
                                            +    DATA2(RMS,'FEDM',rows,'Y')* DATA2(RMS,'DRMA',rows,'Y')  $(sameas(rows,'OFAR') or sameas(rows,'ROOF')or sameas(rows,'STRA'))
                                            +    DATA2(RMS,'FEDM',rows,'Y')* DATA2(RMS,'DRMA',rows,'Y')  $sameas(rows,'FMAI')
                                           ));

*****COMF: cow milf for feeding considered as milk for feeding in ESIM
  CapToEsiBalan(cc,'MILK','FDEM','Base') = sum(esim_to_ms(cc,RMS),
                                            +    DATA2(RMS,'GROF','COMF','Y')
                                        );

***ROW FEED
   CapToEsiBalan('ROW',comm,'FDEM','Base') = sum(esim_to_ms('ROW',RMS),
                                        sum(esim_to_rows(comm,rows),
                                            Data_CAL(RMS,'FEED','WHEA','BAS')$sameas(rows,'SWHE')
                                            +Data_CAL(RMS,'FEED',rows,'BAS') ));

***US FEED
   CapToEsiBalan('US',comm,'FDEM','Base') = sum(esim_to_ms('US',RMS),
                                        sum(esim_to_rows(comm,rows),
                                            Data_CAL(RMS,'FEED','WHEA','BAS')$sameas(rows,'SWHE')
                                            +Data_CAL(RMS,'FEED',rows,'BAS') ));

****Remove 'CMILK' as feedstuff in ESIM, they are negligible
   CapToEsiBalan(cc,'CMILK','FDEM','Base') = sum(esim_to_ms('ROW',RMS),
                                        sum(esim_to_rows('CMILK',rows),
                                            0 ));


set nofeed(comm)
/
*             Whey
*             RAPSEED
*             RAPOIL
*             SUNOIL
*             SOYOIL
*             WMP
*             CONC_MLK
             OTHDAIRY
             BUTTER
             SHEEP
             EGGS
*             CMILK
/;

display  CapToEsiBalan;

****feed use removal from CAPRI data for nofeed items
  CapToEsiBalan(cc,nofeed,'FDEM','Base')
  $CapToEsiBalan(cc,nofeed,'FDEM','Base')
 = 0;

*display  CapToEsiBalan;


*****************************************
************ Processing demand calcuation
*****************************************
   CapToEsiBalan(cc,comm,'PDEM','Base') = sum(esim_to_ms(cc,RMS),
                                        sum(esim_to_rows(comm,rows),
                                                 DATA2(RMS,'PRCM',rows,'Y')$(sameas(rows,'SOYA') or sameas(rows,'RAPE') or sameas(rows,'SUNF') or sameas(comm,'MILK'))
                                               + DATA2(RMS,'BIOF',rows,'Y')$(not sameas(rows,'BIOE') or not sameas(rows,'BIOD') )));


***ROW and US Process
   CapToEsiBalan(cc,comm,'PDEM','Base')$(sameas(cc,'ROW') or sameas(cc,'US'))
                                     = sum(esim_to_ms(cc,RMS),
                                        sum(esim_to_rows(comm,rows),
                                            +Data_CAL(RMS,'PROC',rows,'BAS')$(sameas(rows,'SOYA')
                                                    or sameas(rows,'RAPE') or sameas(rows,'SUNF') or sameas(comm,'MILK') or sameas(rows,'FENI'))
                                            +Data_CAL(RMS,'BIOF','WHEA','BAS')$sameas(rows,'SWHE')
                                            +Data_CAL(RMS,'BIOF',rows,'BAS')));



*****************************************
****************** Humand Demand assigned
*****************************************

   CapToEsiBalan(cc,comm,'HDEM','Base') = sum(esim_to_ms(cc,RMS),
                                        sum(esim_to_rows(comm,rows),
                                                DATA2(RMS,'HCOM',rows,'Y')$ (not (sameas(rows,'GRAS')or sameas(rows,'OFAR') or sameas(rows,'FMAI')))
                                              + DATA2(RMS,'INDM',rows,'Y')$ (not (sameas(rows,'GRAS')or sameas(rows,'OFAR') or sameas(rows,'FMAI') or sameas(rows,'BIOE') or sameas(rows,'BIOD')))
                                              + DATA2(RMS,'LOSM',rows,'Y') $ (not (sameas(rows,'GRAS')or sameas(rows,'OFAR') or sameas(rows,'FMAI')))
                                              + DATA2(RMS,'STCM',rows,'Y') $ ((DATA2(RMS,'STCM',rows,'Y') gt 0 ) and not (sameas(rows,'GRAS')or sameas(rows,'OFAR') or sameas(rows,'FMAI') or sameas(rows,'BIOD') or sameas(rows,'BIOE')))


                                              + DATA2(RMS,'INDM',rows,'Y')* DATA2(RMS,'DRMA',rows,'Y')  $sameas(rows,'GRAS')
                                              + DATA2(RMS,'LOSM',rows,'Y')* DATA2(RMS,'DRMA',rows,'Y')  $sameas(rows,'GRAS')
                                              + DATA2(RMS,'STCM',rows,'Y')* DATA2(RMS,'DRMA',rows,'Y')  $((DATA2(RMS,'STCM',rows,'Y') gt 0 ) and sameas(rows,'GRAS'))

                                              + DATA2(RMS,'INDM',rows,'Y')* DATA2(RMS,'DRMA',rows,'Y')  $(sameas(rows,'OFAR') or sameas(rows,'ROOF'))
                                              + DATA2(RMS,'LOSM',rows,'Y')* DATA2(RMS,'DRMA',rows,'Y')  $(sameas(rows,'OFAR') or sameas(rows,'ROOF'))
                                              + DATA2(RMS,'STCM',rows,'Y')* DATA2(RMS,'DRMA',rows,'Y')  $((DATA2(RMS,'STCM',rows,'Y') gt 0 ) and (sameas(rows,'OFAR')or sameas(rows,'ROOF')))

                                              + DATA2(RMS,'INDM',rows,'Y')* DATA2(RMS,'DRMA',rows,'Y')  $sameas(rows,'FMAI')
                                              + DATA2(RMS,'LOSM',rows,'Y')* DATA2(RMS,'DRMA',rows,'Y')  $sameas(rows,'FMAI')
                                              + DATA2(RMS,'STCM',rows,'Y')* DATA2(RMS,'DRMA',rows,'Y')  $((DATA2(RMS,'STCM',rows,'Y') gt 0 ) and sameas(rows,'FMAI'))

                                              + DATA2(RMS,'BIOF',rows,'Y') $ ( sameas(rows,'BIOD') or sameas(rows,'BIOE'))

  ));



   CapToEsiBalan(cc,'ETHANOL','PDEM','Base') = 0;
   CapToEsiBalan(cc,'BIODiesel','PDEM','Base') = 0;
* set the alcohol consum zero


***ROW Human Consumption
*   CapToEsiBalan('ROW',comm,'HDEM','Base') = sum(esim_to_ms('ROW',RMS),
*                                        sum(esim_to_rows(comm,rows),
*                                                 Data_CAL(RMS,'HCON',rows,'BAS')
*                                               +  Data_CAL(RMS,'HCON','WHEA','BAS')$sameas(rows,'SWHE')
*                                               + Data_CAL(RMS,'ARM1',rows,'BAS') $ ( sameas(rows,'BIOD') or sameas(rows,'BIOE'))
*                                              ));


*   CapToEsiBalan('ROW','ETHANOL','HDEM','Base') = CapToEsiBalan('ROW','ETHANOL','PDEM','Base');

***USA Human Consumption
   CapToEsiBalan(cc,comm,'HDEM','Base')$(sameas(cc,'ROW') or sameas(cc,'US')) = sum(esim_to_ms(cc,RMS),
                                        sum(esim_to_rows(comm,rows),
                                                 Data_CAL(RMS,'HCON',rows,'BAS')
                                              +  Data_CAL(RMS,'HCON','WHEA','BAS')$sameas(rows,'SWHE')

                                               + Data_CAL(RMS,'BIOF',rows,'BAS') $ ( sameas(rows,'BIOD') or sameas(rows,'BIOE'))

                                              +  Data_CAL(RMS,'PROC',rows,'BAS') $ (not (sameas(rows,'SOYA') or sameas(rows,'SWHE')
                                                    or sameas(rows,'RAPE') or sameas(rows,'SUNF') or sameas(comm,'MILK') or sameas(rows,'FENI')))

                                              +  Data_CAL(RMS,'PROC','WHEA','BAS')$sameas(rows,'SWHE')
                                              ));



*   CapToEsiBalan('US','ETHANOL','HDEM','Base') = CapToEsiBalan('US','ETHANOL','PDEM','Base');


************************************************************************
******Change FENI, FPRI data for ROW, US in human demand, process demand
******Only production and feed are selected and the rest is removed
************************************************************************

display  CapToEsiBalan;


  CapToEsiBalan(cc,comm,'PROD','Base')
   $((sameas(cc,'US') or sameas(cc,'ROW')) and (sameas(comm,'OENERGY') or sameas(comm,'OPROT')))
  =  CapToEsiBalan(cc,comm,'PROD','Base')
   - CapToEsiBalan(cc,comm,'HDEM','Base')
   - CapToEsiBalan(cc,comm,'PDEM','Base')
;

  CapToEsiBalan(cc,comm,'HDEM','Base')
   $((sameas(cc,'US') or sameas(cc,'ROW')) and (sameas(comm,'OENERGY') or sameas(comm,'OPROT')))
 =0;


  CapToEsiBalan(cc,comm,'PDEM','Base')
   $((sameas(cc,'US') or sameas(cc,'ROW')) and (sameas(comm,'OENERGY') or sameas(comm,'OPROT')))
 =0;




*************************************************************************
*************************Seed Data Assignement for the Rest of the World
*************************************************************************
   CapToEsiBalan(cc,comm,'SDEM','Base')
    $((sameas(cc,'ROW') or sameas(cc,'US'))and compare_data(cc,comm,'SDEM','ESIM'))
*     =CapToEsiBalan(cc,comm,'PROD','Base') * compare_data(cc,comm,'SDEM','ESIM') /compare_data(cc,comm,'PROD','ESIM');
     =CapToEsiBalan(cc,comm,'PROD','Base') * 0.008 $sameas(cc,'ROW')
    + CapToEsiBalan(cc,comm,'PROD','Base') * 0.0018 $sameas(cc,'US');

   CapToEsiBalan(cc,comm,'PROD','Base')$(sameas(cc,'ROW') or sameas(cc,'US'))
   =    CapToEsiBalan(cc,comm,'PROD','Base')
    -   CapToEsiBalan(cc,comm,'SDEM','Base');



*************Area*********************+
   CapToEsimArea(cc,comm,'Area','Base')
                                     = sum(esim_to_ms(cc,RMS),
                                        sum(esim_to_rows(comm,rows) $(not (sameas(comm,'FAT') or sameas(comm,'PROTEIN'))),
                                                 DATA2(RMS,rows,'levl','Y')));


   CapToEsimArea(cc,'sugar','Area','Base') = sum(esim_to_ms(cc,RMS),
                                                 DATA2(RMS,'SUGB','levl','Y'));

   CapToEsimArea(cc,'RICE','Area','Base') = sum(esim_to_ms(cc,RMS),
                                                 DATA2(RMS,'PARI','levl','Y'));


   CapToEsimArea(cc,'SMAIZE','Area','Base') = sum(esim_to_ms(cc,RMS),
                                                 DATA2(RMS,'MAIF','levl','Y'));
************** Seed demand becomes zero if area is zero*****************

   CapToEsiBalan(cc,comm,'SDEM','Base')
    $((CapToEsimArea(cc,comm,'Area','Base') eq 0) and not( sameas(cc,'ROW') or sameas(cc,'US')))
      = 0;



**************Production becomes zero if area is zero*****************

set area_prod(comm)
 /CWHEAT,DURUM,BARLEY,CORN,RYE,OTHGRA,RICE,SUGAR,POTATO,SOYBEAN,RAPSEED
  SMAIZE,FODDER,GRAS,PULS/;

   CapToEsiBalan(one,area_prod,'PROD','Base')
    $(not CapToEsimArea(one,area_prod,'Area','Base'))
     =0;


option CapToEsimArea:1:3:1
display CapToEsimArea;



compare_data(ccplus,i,'AREA','ESIM')
 = consolid_area(i,ccplus) ;

display consolid_area;


****************************************************************************************
****************Each data should be greater than 0.1 and considered for meaningfuel secotr.
*****************************************************************************************



  CapToEsiBalan(cc,comm,balance2,'Base')
  $(CapToEsiBalan(cc,comm,balance2,'Base') lt 0.01)
 = 0;

display CapToEsiBalan;



  CapToEsiBalan(cc,it,'NETRD','Base')
  $(not (sameas(it,'FAT') or sameas(it,'PROTEIN')))
  = CapToEsiBalan(cc,it,'PROD','Base')
  - CapToEsiBalan(cc,it,'SDEM','Base')
  - CapToEsiBalan(cc,it,'FDEM','Base')
  - CapToEsiBalan(cc,it,'PDEM','Base')
  - CapToEsiBalan(cc,it,'HDEM','Base')
;

  CapToEsiBalan(cc,comm,balance2,'NETRD')
  $(CapToEsiBalan(cc,comm,balance2,'NETRD') lt 0.1)
 = 0;


display CapToEsiBalan;


*******************************************
***********POTA net trade bias removal*****
*******************************************


  CapToEsiBalan(cc,comm,'NETRD','Base')
  $(sameas(comm,'POTATO '))
  = CapToEsiBalan(cc,comm,'PROD','Base')
  - CapToEsiBalan(cc,comm,'SDEM','Base')
  - CapToEsiBalan(cc,comm,'FDEM','Base')
  - CapToEsiBalan(cc,comm,'PDEM','Base')
  - CapToEsiBalan(cc,comm,'HDEM','Base')
;
display CapToEsiBalan;

  CapToEsiBalan(cc,comm,'HDEM','Base')
   $(sameas(comm,'POTATO '))
 =  CapToEsiBalan(cc,comm,'HDEM','Base')
  + CapToEsiBalan(cc,comm,'NETRD','Base') $(CapToEsiBalan(cc,comm,'NETRD','Base') gt 0)
;

  CapToEsiBalan(cc,comm,'HDEM','Base')
   $(sameas(comm,'POTATO '))
 =  CapToEsiBalan(cc,comm,'HDEM','Base')
  + CapToEsiBalan(cc,comm,'NETRD','Base') $(CapToEsiBalan(cc,comm,'NETRD','Base') lt 0)
;

  CapToEsiBalan(cc,comm,'NETRD','Base')
  $(sameas(comm,'POTATO '))
  = CapToEsiBalan(cc,comm,'PROD','Base')
  - CapToEsiBalan(cc,comm,'SDEM','Base')
  - CapToEsiBalan(cc,comm,'FDEM','Base')
  - CapToEsiBalan(cc,comm,'PDEM','Base')
  - CapToEsiBalan(cc,comm,'HDEM','Base')
;

display  CapToEsiBalan;


*******************************************
***********Other energy, Other protein data correction*****
*******************************************

  CapToEsiBalan(cc,comm,'PROD','Base')
 $(sameas(comm,'OENERGY_CAPRI'))
 =   CapToEsiBalan(cc,comm,'FDEM','Base')
;

  CapToEsiBalan(cc,comm,'HDEM','Base')
 $(sameas(comm,'OENERGY_CAPRI') )
 = 0;

  CapToEsiBalan(cc,comm,'SDEM','Base')
 $(sameas(comm,'OENERGY_CAPRI') )
 = 0;

  CapToEsiBalan(cc,comm,'PDEM','Base')
 $(sameas(comm,'OENERGY_CAPRI') )
 = 0;


*******************************************
***********Milk data correction*****
*******************************************

  CapToEsiBalan(cc,comm,'PDEM','Base')
 $(sameas(comm,'MILK'))
 =   CapToEsiBalan(cc,comm,'PDEM','Base')
 +   CapToEsiBalan(cc,comm,'HDEM','Base');

CapToEsiBalan(cc,comm,'HDEM','Base')
 $(sameas(comm,'MILK'))
=0;





**Check the unit of fodder maize, grass
**CAPRI unit is fresh mass, wet mass
option CapToEsiBalan:1:3:1
display CapToEsiBalan;



*****OTHER ENERGY and OTHER PROTEIN data import

*parameter  f_dem(cc,comm);
*$GDXin ..\..\CAPRI_frates_calc.gdx
*$load f_dem
*$GDXin
*;




compare_data('EU27',comm,blance,'ESIM')
 =sum(EU27, compare_data(EU27,comm,blance,'ESIM'));


compare_data(cc,comm,item,'CAPRI')
 = CapToEsiBalan(cc,comm,item,'Base')$(not sameas(item,'NETRD'))
  + CapToEsiBalan(cc,comm,item,'Base')$(sameas(item,'NETRD'))
  +CapToEsimArea(cc,comm,item,'Base')$sameas(item,'Area');
*  +CapToEsimPrice(cc,comm,item,'Base')$sameas(item,'price') ;


*compare_data(cc,comm,item,'CAPRI')
* $(sameas(comm,'OENERGY') or sameas(comm,'OPROT'))
* = f_dem(cc,comm)$(sameas(item,'PROD') or sameas(item,'FDEM'));


**************************************
************Import ESIM data for DURUM
**************************************

compare_data(cc,comm,item,'CAPRI')
 $(sameas(comm,'DURUM') and (sameas(cc,'ROW') or sameas(cc,'US')))
 = compare_data(cc,comm,item,'ESIM')
;



********************************************
************Import ESIM data for palmo oil for Turkey
********************************************

compare_data(cc,comm,item,'CAPRI')
 $(sameas(comm,'PALMOIL') and sameas(cc,'TU'))
 = compare_data(cc,comm,item,'ESIM')
;


************************************************************************
******Change Sugar data , use ESIM data
************************************************************************

*compare_data(cc,'sugar',item,'CAPRI')
* = compare_data(cc,'sugar',item,'esim')
*;




**********************************
**assinge 'oenergy' to 0 unitl its crosss price elasticities are calculated
**********************************

compare_data(cc,'OENERGY_CAPRI',item,'CAPRI')
 =0;


compare_data('EU27',comm,blance,'CAPRI')
 =sum(EU27, compare_data(EU27,comm,blance,'CAPRI'));


compare_data(cc,comm,item,'%')
 $compare_data(cc,comm,item,'ESIM')
 = (compare_data(cc,comm,item,'CAPRI')
   - compare_data(cc,comm,item,'ESIM'))
   /compare_data(cc,comm,item,'ESIM')*100;

compare_data('EU27',comm,item,'%')
 $compare_data('EU27',comm,item,'ESIM')
 = (compare_data('EU27',comm,item,'CAPRI')
   - compare_data('EU27',comm,item,'ESIM'))
   /compare_data('EU27',comm,item,'ESIM')*100;




option compare_data:0:3:1;
display compare_data;




Parameter feed_check(*,*,*,*);

**here
set drymatter(ROWS)
/GRAS,MAIF,OFAR,ROOF,STRA/;

feed_check(cc,I_CAPRI,ROWS,'CAPRI')
 = sum(esim_to_ms(cc,RMS),sum(FEED_TO_O(I_CAPRI,ROWS),
        DATA2(RMS,'FEDM',ROWS,'Y')
));

feed_check(cc,I_CAPRI,drymatter,'CAPRI')
 = sum(esim_to_ms(cc,RMS),sum(FEED_TO_O(I_CAPRI,drymatter),
    +   DATA2(RMS,'FEDM',drymatter,'Y')*DATA2(RMS,'DRMA',drymatter,'Y')
));


feed_check(cc,I_CAPRI,'TOTAL','CAPRI')
 = sum(esim_to_ms(cc,RMS),sum(FEED_TO_O(I_CAPRI,ROWS),
  feed_check(cc,I_CAPRI,ROWS,'CAPRI')));



feed_check('EU27',I_CAPRI,ROWS,'CAPRI')
 = sum(EU27, feed_check(EU27,I_CAPRI,ROWS,'CAPRI'));


feed_check('EU27',I_CAPRI,'TOTAL','CAPRI')
 =sum(EU27, feed_check(EU27,I_CAPRI,'TOTAL','CAPRI'));

display FEED_TO_O;


set
feed_esim(*,comm)/
 FCER.(CWHEAT, DURUM , RYE,  BARLEY,  CORN,  OTHGRA,  RICE)
 FPRO. (RAPMEAL, SOYMEAL, SUNMEAL, GLUTFD, OPROT)
 FOTH. (POTATO,SUNSEED, SOYBEAN, SUGAR)
 FENE. (MANIOC, OENERGY)
 FMAI. (SMAIZE)
* FSTR. (STRA)
 FGRA. (GRAS)
 FOFA. FODDER
 FCOM. MILK
 FMIL. SMP
/;


$ontext
ESIM definition
GLUTFD
OPROT
SMP
RAPMEAL
SOYBEAN
SOYMEAL
SUNMEAL
SUNSEED
$offtext


feed_check(cc,I_CAPRI,'TOTAL','ESIM')
 = sum(esim_to_ms(cc,RMS),sum(feed_esim(I_CAPRI,comm), compare_data(cc,comm,'FDEM','ESIM') ));

feed_check(cc,I_CAPRI,comm,'ESIM')
 = sum(esim_to_ms(cc,RMS),sum(feed_esim(I_CAPRI,comm), compare_data(cc,comm,'FDEM','ESIM') ));


feed_check('EU27',I_CAPRI,comm,'ESIM')
 =sum(EU27,  feed_check(EU27,I_CAPRI,comm,'ESIM'));


feed_check('EU27',I_CAPRI,'TOTAL','ESIM')
 =sum(EU27, feed_check(EU27,I_CAPRI,'TOTAL','ESIM'));

display feed_check;




**********************************************************************
*********DURUM, Fodder data from ROW, USA should be collected from FAO
**********************************************************************


*compare_data(cc,comm,blance,'CAPRI')
* $((sameas(cc,'ROW')or sameas(cc,'US')) and (sameas(comm,'FODDER') or sameas(comm,'DURUM')))
* = compare_data(cc,comm,blance,'ESIM');


*display compare_data;


***************************
****************************Net balance check and modlification
set mmodel /CAPRI,ESIM/;
parameter net_balance(comm,mmodel,*);

net_balance(comm,mmodel,'EU')
 = compare_data('EU27',comm,'NETRD',mmodel)
   +compare_data('TU',comm,'NETRD',mmodel)
   + compare_data('HR',comm,'NETRD',mmodel)
   + compare_data('WB',comm,'NETRD',mmodel) ;

net_balance(comm,mmodel,'USA')
 = compare_data('US',comm,'NETRD',mmodel);

net_balance(comm,mmodel,'ROW')
 = compare_data('ROW',comm,'NETRD',mmodel);

net_balance(comm,mmodel,'total')
 = sum(cc, compare_data(cc,comm,'NETRD',mmodel));

display net_balance;


*********************************************
*********Bias correction for ROW*************
*********************************************

compare_data(cc,comm,'NETRD','CAPRI')
 $( sameas(cc,'ROW') and net_balance(comm,'CAPRI','total'))
 = compare_data(cc,comm,'NETRD','CAPRI')*(1+net_balance(comm,'CAPRI','total')/abs(compare_data(cc,comm,'NETRD','CAPRI')))
;

compare_data(cc,comm,blance,'CAPRI')
 $(( sameas(cc,'ROW')) and net_balance(comm,'CAPRI','total') and (sameas(blance,'HDEM')or sameas(blance,'FDEM')or sameas(blance,'PDEM'))
     and abs(compare_data(cc,comm,'NETRD','CAPRI')))
 = compare_data(cc,comm,blance,'CAPRI')*(1+net_balance(comm,'CAPRI','total')
   /abs(compare_data(cc,comm,'HDEM','CAPRI') + compare_data(cc,comm,'FDEM','CAPRI')+compare_data(cc,comm,'PDEM','CAPRI')))
;

compare_data(cc,comm,'NETRD','CAPRI')
  $( sameas(cc,'ROW') and net_balance(comm,'CAPRI','total') and (not (sameas(comm,'FAT') or sameas(comm,'PROTEIN'))))
 = compare_data(cc,comm,'PROD','CAPRI')
 - compare_data(cc,comm,'SDEM','CAPRI')
 - compare_data(cc,comm,'HDEM','CAPRI')
 - compare_data(cc,comm,'PDEM','CAPRI')
 - compare_data(cc,comm,'FDEM','CAPRI')
;

********************************************************
****************************Recalulation of Net balance*
*********************************************************

net_balance(comm,mmodel,'EU')$sameas(mmodel,'CAPRI')
 = compare_data('EU27',comm,'NETRD',mmodel)
   + compare_data('TU',comm,'NETRD',mmodel)
   + compare_data('HR',comm,'NETRD',mmodel)
   + compare_data('WB',comm,'NETRD',mmodel) ;


net_balance(comm,mmodel,'EU27')$sameas(mmodel,'CAPRI')
 = compare_data('EU27',comm,'NETRD',mmodel);
net_balance(comm,mmodel,'TU')$sameas(mmodel,'CAPRI')
 = compare_data('TU',comm,'NETRD',mmodel) ;
net_balance(comm,mmodel,'HR')$sameas(mmodel,'CAPRI')
 = compare_data('HR',comm,'NETRD',mmodel) ;
net_balance(comm,mmodel,'WB')$sameas(mmodel,'CAPRI')
 = compare_data('WB',comm,'NETRD',mmodel);


net_balance(comm,mmodel,'USA')$sameas(mmodel,'CAPRI')
 = compare_data('US',comm,'NETRD',mmodel);

net_balance(comm,mmodel,'ROW') $sameas(mmodel,'CAPRI')
 = compare_data('ROW',comm,'NETRD',mmodel);

net_balance(comm,mmodel,'total')$sameas(mmodel,'CAPRI')
 = sum(cc, compare_data(cc,comm,'NETRD',mmodel));

net_balance(comm,mmodel,'total')
 $((net_balance(comm,mmodel,'total') lt 1)and sameas(mmodel,'CAPRI') )
 =0;


display net_balance;







**********************************************************************
*********Check global balance
**********************************************************************


Parameter
global_balance(comm)
global_check(comm,cc)
;

global_balance(comm) = sum(cc,compare_data(cc,comm,'NETRD ','CAPRI'));

global_check(comm,cc)=compare_data(cc,comm,'NETRD ','CAPRI');


display global_balance,global_check;




set item2(COLS_to_esim) /PROD,FEED,HCON,PROC/;

Parameter NonTRD_check(cc,nt);


display compare_data;

NonTRD_check(cc,nt)
 = compare_data(cc,nt,'PROD','CAPRI')
 - compare_data(cc,nt,'SDEM','CAPRI')
 - compare_data(cc,nt,'HDEM','CAPRI')
 - compare_data(cc,nt,'FDEM','CAPRI')
 - compare_data(cc,nt,'PDEM','CAPRI')
;




****Milk (raw milk data for US and ROW check)

*compare_data(cc,'MILK','PROD','CAPRI')
* = compare_data(cc,'MILK','PROD','ESIM');

compare_data(cc,'MILK','FDEM','CAPRI')
 $(sameas(cc,'US') or sameas(cc,'ROW'))
 = compare_data(cc,'MILK','FDEM','ESIM');

compare_data(cc,'MILK','PDEM','CAPRI')
  $(sameas(cc,'US') or sameas(cc,'ROW'))
 = compare_data(cc,'MILK','PROD','CAPRI')
  -compare_data(cc,'MILK','FDEM','CAPRI')
 ;


compare_data('ROW','GRAS',item,'CAPRI')
 =0;

compare_data('ROW','FODDER',item,'CAPRI')
 =0;


set nonTRD /milk,cmilk,OTHDAIRY/;

compare_data(cc,nonTRD,'PROD','CAPRI')
 = compare_data(cc,nonTRD,'PROD','CAPRI')
  -  (compare_data(cc,nonTRD,'PROD','CAPRI')
  -   compare_data(cc,nonTRD,'HDEM','CAPRI')
  -   compare_data(cc,nonTRD,'FDEM','CAPRI')
  -   compare_data(cc,nonTRD,'PDEM','CAPRI')
     );



display compare_data;

NonTRD_check(cc,nt)
 = compare_data(cc,nt,'PROD','CAPRI')
 - compare_data(cc,nt,'SDEM','CAPRI')
 - compare_data(cc,nt,'HDEM','CAPRI')
 - compare_data(cc,nt,'FDEM','CAPRI')
 - compare_data(cc,nt,'PDEM','CAPRI')
;

display NonTRD_check;




************************************************************************
******Change glutan feed data for ROW, US, make it non-tradable
************************************************************************

parameter
coef_p_bf(energ,comm,comm1) coefficient byproducts in biofuels production
;

coef_p_bf('ethanol','cwheat','glutfd') = 0.266;
coef_p_bf('ethanol','Barley','glutfd')   = 0.266;
coef_p_bf('ethanol','OTHGRA','glutfd')   = 0.266;
coef_p_bf('ethanol','Rye','glutfd')   = 0.266;
coef_p_bf('ethanol','corn','glutfd')   = 0.292;

set glu_comm(comm)
/cwheat, barley,othgra, rye,corn/;

compare_data(cc,'GLUTFD','PROD','CAPRI')
   $((sameas(cc,'US') or sameas(cc,'ROW')))
 = sum(glu_comm , compare_data(cc,glu_comm,'PDEM','CAPRI')*coef_p_bf('ethanol',glu_comm,'glutfd'))
;

 compare_data(cc,'GLUTFD','FDEM','CAPRI')
   $((sameas(cc,'US') or sameas(cc,'ROW')) )
  =  compare_data(cc,'GLUTFD','PROD','CAPRI')
;

display compare_data;






*****************************************************
*********************Data Demand Assignment**********
*****************************************************

parameter fdem1(cc,comm),prod1(cc,comm);

fdem1(cc,comm)=compare_data(cc,comm,'FDEM','CAPRI');
*$(not (sameas(comm,'MANIOC') or sameas(comm,'GLUTFD'))) ;

prod1(cc,comm)=compare_data(cc,comm,'PROD','CAPRI');
*$(not (sameas(comm,'MANIOC') or sameas(comm,'GLUTFD')));


fdem1(cc,comm)
 $(sameas(comm,'GRAS') or sameas(comm,'FODDER'))
 = prod1(cc,comm);




display fdem1,prod1;

Execute_unload '..\Parameter_change\feedrate_capri\data\data_capri.gdx',fdem1,prod1;



Execute_unload 'Compare_DATA.gdx',compare_data;


$call gdxxrw  Compare_DATA.gdx o=Compare_DATA.xls  par=compare_data  Rng=output!a1




*****Export data to CAPRI

Parameter
show_data_CAPRI(comm,item,cc)
consolid_area_CAPRI(i,ccplus) "Consolidated area data, avg. 2007 and 2009, in 1000 ha"
show_diary_CAPRI(comm,item,cc) " FAT & PROTEIN production and processing demand from CAPRI"
;

show_data_CAPRI(comm,item,cc)
 =compare_data(cc,comm,item,'CAPRI')$(not (sameas(item,'Area')));

consolid_area_CAPRI(comm,cc)
=compare_data(cc,comm,'Area','CAPRI');


show_diary_CAPRI(comm,item,cc)
 = compare_data(cc,comm,item,'CAPRI')$(sameas(comm,'FAT') or sameas(comm,'PROTEIN'))
;


display show_data_CAPRI,show_diary_CAPRI,consolid_area_CAPRI;

Execute_unload '..\..\CAPRI_show_data.gdx',show_data_CAPRI,show_diary_CAPRI;
Execute_unload '..\..\CAPRI_consolid_area',consolid_area_CAPRI;




