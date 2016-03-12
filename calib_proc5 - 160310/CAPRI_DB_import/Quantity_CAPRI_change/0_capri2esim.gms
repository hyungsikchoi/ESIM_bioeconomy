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



set cols_to_esim(cols) / ARM1,ARM2,DSales,PROD,HCON,PROC,BIOF,ISCH,NTRD,INCE,FEED,FATS,PROT,PRCM,NAGR,EXOG,SECG/;
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

PULS      .(    PULS)
OPROT     .(    FPRI)
OENERGY   .(    FENI)
FENE       .(   MOLA,TOMA, OVEG,APPL,OFRU, CITR)

MILK      .(    COMI,SGMI)   " MILK: raw milk at diary"

CMILK     .(    FRMI)        " FRMI: Fresh milk products"
SMP       .(    SMIP)
WMP       .(    WMIO)
CREAM     .(    CREM)
CONC_MLK  .(    COCM)
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






* split missing products CMILK&ACID_MLK and CWHEAT&DURUM:
PARAMETER
   show_data(i,*,ccplus) "Consolidated data base, in 1000 t (ESIM)"
   consolid_area(i,ccplus)
   pp_results(i,ccplus,*)
*   fdem0(*,*)
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

   CapriProcess(*,i,*) processing data for FAT and Protein in diary products
   CapriProcess_export(*,i,*) processing data for FAT and Protein in diary products

   CapriMilkProcess(i,*) processing data for FAT and Protein in Milk

;




* aggregate / map to ESIM regions and products:
   CaptoEsiBalan(cc,comm,'PROD','Base') = sum(esim_to_ms(cc,RMS),
                                        sum(esim_to_rows(comm,rows),
                                               ( DATA2(RMS,'NETF',rows,'Y') + DATA2(RMS,'SEDF',rows,'Y')$DATA2(RMS,rows,'levl','Y'))
                                       $(not ((sameas(rows,'GRAS') or sameas(rows,'OFAR') or sameas(rows,'ROOF')or sameas(rows,'FMAI') or sameas(rows,'STRA')) ))

                                            +    DATA2(RMS,'MAPR',rows,'Y') $ (Not  DATA2(RMS,'NETF',rows,'Y'))
***CREM etc products included in "MAPR" indexes
                                            +    DATA2(RMS,'GROF','COMF','Y')  $sameas(rows,'COMI')
***COMF (milk for feeding) is classified as COMI (milk for sales) in gross production

                                            +    DATA2(RMS,'NETF',rows,'Y')* DATA2(RMS,'DRMA',rows,'Y')  $sameas(rows,'GRAS')
                                            +    DATA2(RMS,'NETF',rows,'Y')* DATA2(RMS,'DRMA',rows,'Y')  $(sameas(rows,'OFAR') or sameas(rows,'ROOF')or sameas(rows,'STRA'))
                                            +    DATA2(RMS,'NETF',rows,'Y')* DATA2(RMS,'DRMA',rows,'Y')  $sameas(rows,'FMAI')
***GRAS, OFAR, FMAI are calculated in dry matter with muplication of 'DRMA'

 ));







**ROW productin from CAPRI market module data, 'PROD' set, Calibrated data selected
   CaptoEsiBalan(cc,comm,'PROD','Base')$(sameas(cc,'ROW') or sameas(cc,'US'))
                                      = sum(esim_to_ms(cc,RMS),
                                         sum(esim_to_rows(comm,rows),
                                                 Data_CAL(RMS,'PROD',rows,'BAS') $ (not (sameas(rows,'GRAS')or sameas(rows,'OFAR') or sameas(rows,'FMAI')or sameas(rows,'STRA')))
                                            +    Data_CAL(RMS,'PROD','WHEA','BAS')  $sameas(rows,'SWHE')
*                                            +    Data_CAL(RMS,'PROD','MILK','BAS')  $sameas(rows,'COMI')
                                            +    Data_CAL(RMS,'PROD',rows,'BAS')* DATA2(RMS,'DRMA',rows,'Y')  $sameas(rows,'GRAS')
                                            +    Data_CAL(RMS,'PROD',rows,'BAS')* DATA2(RMS,'DRMA',rows,'Y')  $(sameas(rows,'OFAR') or sameas(rows,'ROOF')or sameas(rows,'STRA'))
                                            +    Data_CAL(RMS,'PROD',rows,'BAS')* DATA2(RMS,'DRMA',rows,'Y')  $sameas(rows,'FMAI')));
****in ROW, WHEA = SWHE and MILK = COMI


***chs, norway has some data for ROW therefore those should be removed
    CaptoEsiBalan('ROW','fodder','prod','base')=0;
    CaptoEsiBalan('ROW','gras','prod','base')=0;
    CaptoEsiBalan('ROW','stra','prod','base')=0;

    CaptoEsiBalan(cc,comm,'PROD','Base')$(sameas(comm,'ETHANOL'))
                                      = sum(esim_to_ms(cc,RMS),
                                         sum(esim_to_rows(comm,rows),
                                                 Data_CAL(RMS,'PROD',rows,'BAS')));

   CaptoEsiBalan(cc,comm,'PROD','Base')$(sameas(comm,'BioDiesel'))
                                      = sum(esim_to_ms(cc,RMS),
                                         sum(esim_to_rows(comm,rows),
                                                 Data_CAL(RMS,'PROD',rows,'BAS')));


   CaptoEsiBalan(cc,comm,'PROD','Base')$(sameas(comm,'ETHANOL_NAGR'))
                                       = sum(esim_to_ms(cc,RMS),
                                           DATA_CAL(RMS,'NAGR','BIOE','BAS')
                                         + DATA_CAL(RMS,'SECG','BIOE','BAS')
                                         + DATA_CAL(RMS,'EXOG','BIOE','BAS')
);


   CaptoEsiBalan(cc,comm,'PROD','Base')$(sameas(comm,'BIODIESEL_NAGR'))
                                       = sum(esim_to_ms(cc,RMS),
                                           DATA_CAL(RMS,'NAGR','BIOD','BAS')
                                         + DATA_CAL(RMS,'SECG','BIOD','BAS')
                                         + DATA_CAL(RMS,'EXOG','BIOD','BAS')
);

display CaptoEsiBalan;


*******************************************************************
***(1stBioenergy)NAGR,EXOG,SECG are removed in bioenergy production
*******************************************************************

   CaptoEsiBalan(cc,'ETHANOL','PROD','Base')
   =  CaptoEsiBalan(cc,'ETHANOL','PROD','Base')
    - CaptoEsiBalan(cc,'ETHANOL_NAGR','PROD','Base')
    - sum(esim_to_ms(cc,RMS),DATA2(RMS,'BIOF','TWIN','Y')*0.1);


***ethanol production is small
   CaptoEsiBalan('SI','ETHANOL','PROD','Base')
  =0;


   CaptoEsiBalan(cc,'BIODIESEL','PROD','Base')
   =  CaptoEsiBalan(cc,'BIODIESEL','PROD','Base')
    - CaptoEsiBalan(cc,'BIODIESEL_NAGR','PROD','Base');





*****************************************
****************** FATS calcuation
*****************************************
   CapToEsiBalan(cc,'FAT','PROD','Base') = sum(esim_to_ms(cc,RMS),
                                        sum(esim_to_rows('FAT','FATS'),
                                            DATA2(RMS,'FATS','levl','Y')/100));


***ROW FATS
   CaptoEsiBalan('ROW','FAT','PROD','Base') = sum(esim_to_ms('ROW',RMS),
                                        sum(esim_to_rows('FAT','FATS'),
                                                 Data_CAL(RMS,'PROD','FATS','BAS')/100/2));

***USA FATS
   CaptoEsiBalan('US','FAT','PROD','Base') = sum(esim_to_ms('US',RMS),
                                        sum(esim_to_rows('FAT','FATS'),
                                                 Data_CAL(RMS,'PROD','FATS','BAS')/100/2));




*****************************************
****************** PROTEIN calcuation****
*****************************************

   CapToEsiBalan(cc,'PROTEIN','PROD','Base') = sum(esim_to_ms(cc,RMS),
                                        sum(esim_to_rows('PROTEIN','PROT'),

                                            DATA2(RMS,'PROT','levl','Y')/100));
***ROW PROTEIN
   CapToEsiBalan('ROW','PROTEIN','PROD','Base') = sum(esim_to_ms(cc,RMS),
                                        sum(esim_to_rows('PROTEIN','PROT'),
                                            Data_CAL(RMS,'PROD','PROT','BAS')/100/2));

***USA PROTEIN
   CaptoEsiBalan('US','PROTEIN','PROD','Base') = sum(esim_to_ms('US',RMS),
                                        sum(esim_to_rows('PROTEIN','PROT'),
                                                 Data_CAL(RMS,'PROD','PROT','BAS')/100/2));



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
*             OTHDAIRY
             BUTTER
             SHEEP
             EGGS
*             CMILK
/;



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
                                                 Data_CAL(RMS,'PROC',rows,'BAS')$(sameas(rows,'SOYA') or sameas(rows,'RAPE') or sameas(rows,'SUNF')
                                                                             or sameas(rows,'CHES') or sameas(rows,'CASE')or sameas(rows,'COCM') or sameas(rows,'BUTT'))
                                               + Data_CAL(RMS,'BIOF',rows,'BAS')));
**only products in biof is selected including pam oil for all eu and rest of the world

   CapToEsiBalan(cc,'MILK','PDEM','Base') = sum(esim_to_ms(cc,RMS),
                                                    Data_CAL(RMS,'PRCM','MILK','BAS'));


 CapToEsiBalan(cc,'FAT','PDEM','Base')
 = CapToEsiBalan(cc,'FAT','PROD','Base')
;
 CapToEsiBalan(cc,'PROTEIN','PDEM','Base')
 = CapToEsiBalan(cc,'PROTEIN','PROD','Base')
;



******temporary extraction for Case and Chees and will be removed later on.



***ROW and US Process
   CapToEsiBalan(cc,comm,'PDEM','Base')$(sameas(cc,'ROW') or sameas(cc,'US'))
                                     = sum(esim_to_ms(cc,RMS),
                                        sum(esim_to_rows(comm,rows),
                                            +Data_CAL(RMS,'PROC',rows,'BAS')$(sameas(rows,'SOYA') or sameas(rows,'RAPE') or sameas(rows,'SUNF'))
*                                            +Data_CAL(RMS,'PROC',rows,'BAS')

                                            +Data_CAL(RMS,'BIOF','WHEA','BAS')$sameas(rows,'SWHE')
                                            +Data_CAL(RMS,'BIOF',rows,'BAS')));

*****Milk (Raw milk at diary) is assgined to production and processing demand in ROW and US
   CapToEsiBalan(cc,'MILK','PDEM','Base')$(sameas(cc,'ROW') or sameas(cc,'US'))
                                     = sum(esim_to_ms(cc,RMS),
                                            Data_CAL(RMS,'PROD','MILK','BAS'));

   CapToEsiBalan(cc,'MILK','PROD','Base')$(sameas(cc,'ROW') or sameas(cc,'US'))
                                     = sum(esim_to_ms(cc,RMS),
                                            Data_CAL(RMS,'PROD','MILK','BAS'));

display CapToEsiBalan;



*****************************************
****************** Humand Demand assigned
*****************************************

   CapToEsiBalan(cc,comm,'HDEM','Base') = sum(esim_to_ms(cc,RMS),
                                        sum(esim_to_rows(comm,rows),
                                                DATA2(RMS,'HCOM',rows,'Y')$ (not (sameas(rows,'GRAS')or sameas(rows,'OFAR') or sameas(rows,'FMAI')))
                                              + DATA2(RMS,'INDM',rows,'Y')$ (not (sameas(rows,'GRAS')or sameas(rows,'OFAR') or sameas(rows,'FMAI') or sameas(rows,'BIOE') or sameas(rows,'BIOD')))
                                              + DATA2(RMS,'LOSM',rows,'Y') $ ((not (sameas(rows,'GRAS')or sameas(rows,'OFAR') or sameas(rows,'FMAI'))) )
                                              + DATA2(RMS,'STCM',rows,'Y') $ ( not (sameas(rows,'GRAS')or sameas(rows,'OFAR') or sameas(rows,'FMAI') or sameas(rows,'BIOD') or sameas(rows,'BIOE'))
                                                                                 and (DATA2(RMS,'STCM',rows,'Y') gt 0))


                                              + DATA2(RMS,'INDM',rows,'Y')* DATA2(RMS,'DRMA',rows,'Y')  $sameas(rows,'GRAS')
                                              + DATA2(RMS,'LOSM',rows,'Y')* DATA2(RMS,'DRMA',rows,'Y')  $sameas(rows,'GRAS')
                                              + DATA2(RMS,'STCM',rows,'Y')* DATA2(RMS,'DRMA',rows,'Y')  $( sameas(rows,'GRAS'))

                                              + DATA2(RMS,'INDM',rows,'Y')* DATA2(RMS,'DRMA',rows,'Y')  $(sameas(rows,'OFAR') or sameas(rows,'ROOF'))
                                              + DATA2(RMS,'LOSM',rows,'Y')* DATA2(RMS,'DRMA',rows,'Y')  $(sameas(rows,'OFAR') or sameas(rows,'ROOF'))
                                              + DATA2(RMS,'STCM',rows,'Y')* DATA2(RMS,'DRMA',rows,'Y')  $((sameas(rows,'OFAR')or sameas(rows,'ROOF')))

                                              + DATA2(RMS,'INDM',rows,'Y')* DATA2(RMS,'DRMA',rows,'Y')  $sameas(rows,'FMAI')
                                              + DATA2(RMS,'LOSM',rows,'Y')* DATA2(RMS,'DRMA',rows,'Y')  $sameas(rows,'FMAI')
                                              + DATA2(RMS,'STCM',rows,'Y')* DATA2(RMS,'DRMA',rows,'Y')  $( sameas(rows,'FMAI'))

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
                                                    or sameas(rows,'RAPE') or sameas(rows,'SUNF') or sameas(comm,'MILK')))

                                              +  Data_CAL(RMS,'PROC','WHEA','BAS')$sameas(rows,'SWHE')
                                              ));



****************************************
*******************Merge Wheat and durum
****************************************
     CapToEsiBalan(cc,'CWHEAT',balance2,'Base')
  =  CapToEsiBalan(cc,'CWHEAT',balance2,'Base')
   + CapToEsiBalan(cc,'DURUM',balance2,'Base')
;

     CapToEsiBalan(cc,'DURUM',balance2,'Base')
 =  0;

display CapToEsiBalan;


************************************************************************************************************
******************* Extract procssing amount from production in cheese and case for fat and protein balances
************************************************************************************************************


set diary_sub(comm)
/CMILK,SMP,WMP,CREAM,CONC_MLK, WHEY, BUTTER,CHEESE, OTHDAIRY/;

******subtracting processing demand from production for fat, protein balance
     CapToEsiBalan(cc,diary_sub,'PROD','Base')
  =  CapToEsiBalan(cc,diary_sub,'PROD','Base')
  -  CapToEsiBalan(cc,diary_sub,'PDEM','Base')
;


CapToEsiBalan(cc,diary_sub,'PDEM','Base')=0;


display CapToEsiBalan;






************************************************************************
******Change FENI, FPRI data for ROW, US in human demand, process demand
******Only production and feed are selected and the rest is removed
************************************************************************


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


  CapToEsiBalan(cc,comm,'PROD','Base')
 $(  CapToEsiBalan(cc,comm,'PROD','Base') lt 0.01)
 =0;

  CapToEsiBalan('US','OENERGY','PROD','Base')
 =  CapToEsiBalan('US','OENERGY','FDEM','Base')  ;
****keep minimum amount for oenergy in the US for feed supply


display CapToEsiBalan;





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

CapToEsiBalan(cc,'GLUTFD','PROD','Base')
*   $((sameas(cc,'US') or sameas(cc,'ROW')))
 = sum(glu_comm , CapToEsiBalan(cc,glu_comm,'PDEM','Base')*coef_p_bf('ethanol',glu_comm,'glutfd'))
;


* compare_data(cc,'GLUTFD','FDEM','CAPRI')
*   $((sameas(cc,'US') or sameas(cc,'ROW')) )
*  =  compare_data(cc,'GLUTFD','PROD','CAPRI')
*;






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

***area merge cwheat with durum
   CapToEsimArea(cc,'CWHEAT','Area','Base')
    =    CapToEsimArea(cc,'CWHEAT','Area','Base')
   +     CapToEsimArea(cc,'DURUM','Area','Base');

CapToEsimArea(cc,'DURUM','Area','Base')=0;

   CapToEsimArea(cc,'sugar','Area','Base') = sum(esim_to_ms(cc,RMS),
                                                 DATA2(RMS,'SUGB','levl','Y'));

   CapToEsimArea(cc,'RICE','Area','Base') = sum(esim_to_ms(cc,RMS),
                                                 DATA2(RMS,'PARI','levl','Y'));


   CapToEsimArea(cc,'SMAIZE','Area','Base') = sum(esim_to_ms(cc,RMS),
                                                 DATA2(RMS,'MAIF','levl','Y'));

**setadise area
   CapToEsimArea(cc,'SETASIDE','Area','Base') = sum(esim_to_ms(cc,RMS),
                                                 DATA2(RMS,'SETA','levl','Y'));



   CapToEsimArea(cc,'FENE','Area','Base')=0;
   CapToEsimArea('ROW',comm,'Area','Base')=0;
   CapToEsimArea('US',comm,'Area','Base')=0;


************** Seed demand becomes zero if area is zero*****************

   CapToEsiBalan(cc,comm,'SDEM','Base')
    $((CapToEsimArea(cc,comm,'Area','Base') eq 0) and not( sameas(cc,'ROW') or sameas(cc,'US')))
      = 0;


display CaptoEsiBalan;

********************************************************
*******************Straw production, loss and feed check
********************************************************

* aggregate / map to ESIM regions and products:
   CaptoEsiBalan(cc,comm,'PROD','Base')$(sameas(comm,'STRA')) = sum(esim_to_ms(cc,RMS),
                                        sum(esim_to_rows(comm,rows) ,
                                  DATA2(RMS,'GROF',rows,'Y')* DATA2(RMS,'DRMA',rows,'Y')));

   CaptoEsiBalan(cc,comm,'HDEM','Base')$(sameas(comm,'STRA')) = sum(esim_to_ms(cc,RMS),
                                        sum(esim_to_rows(comm,rows) ,
                                  DATA2(RMS,'LOSF',rows,'Y')* DATA2(RMS,'DRMA',rows,'Y')));


   CaptoEsiBalan(cc,comm,'FDEM','Base')$(sameas(comm,'STRA')) = sum(esim_to_ms(cc,RMS),
                                        sum(esim_to_rows(comm,rows),
                                  DATA2(RMS,'FEDM',rows,'Y')* DATA2(RMS,'DRMA',rows,'Y')));

display CaptoEsiBalan;



parameter
Stra_Yield(cc,comm,*)
Crop_Yield(cc,comm)
;

Stra_Yield(cc,comm,'abs') = sum(esim_to_ms(cc,RMS),
                        sum(esim_to_rows(comm,rows),
                             DATA2(RMS,rows,'STRA','Y')*0.001));

Stra_Yield(cc,comm,'abs')$(sameas(comm,'OTHGRA')) = sum(esim_to_ms(cc,RMS),
                                 (DATA2(RMS,'OCER','STRA','Y')+ DATA2(RMS,'OATS','STRA','Y') )/2*0.001 );


Stra_Yield(cc,comm,'abs')$(sameas(cc,'WB'))
 = Stra_Yield(cc,comm,'abs')/4;

Stra_Yield(cc,comm,'abs')$(sameas(cc,'ROW'))
 = 0;


Stra_Yield(cc,comm,'YtoStr')
 $sum(esim_to_ms(cc,RMS),sum(esim_to_rows(comm,rows), DATA2(RMS,rows,'YILD','Y')*0.001))
 =    sum(esim_to_ms(cc,RMS),sum(esim_to_rows(comm,rows), DATA2(RMS,rows,'STRA','Y')*0.001))
 /    sum(esim_to_ms(cc,RMS),sum(esim_to_rows(comm,rows), DATA2(RMS,rows,'YILD','Y')*0.001))
;

***other grain/ straw yield is higher than others because of oats
Stra_Yield(cc,comm,'YtoStr')$(sameas(comm,'OTHGRA') and
   sum(esim_to_ms(cc,RMS), (DATA2(RMS,'OCER','YILD','Y')+ DATA2(RMS,'OATS','YILD','Y') )/2*0.001 ))
 =  Stra_Yield(cc,comm,'abs')
  / sum(esim_to_ms(cc,RMS), (DATA2(RMS,'OCER','YILD','Y')+ DATA2(RMS,'OATS','YILD','Y') )/2*0.001 );


Stra_Yield('ROW',comm,'YtoStr')=0;

display Stra_Yield;

Crop_Yield(cc,comm)
 $sum(esim_to_ms(cc,RMS),sum(esim_to_rows(comm,rows), DATA2(RMS,rows,'STRA','Y')*0.001))
 = sum(esim_to_ms(cc,RMS),sum(esim_to_rows(comm,rows), DATA2(RMS,rows,'YILD','Y')*0.001));

Crop_Yield(cc,comm)$(sameas(comm,'OTHGRA')) = sum(esim_to_ms(cc,RMS),
                                 (DATA2(RMS,'OCER','YILD','Y')+ DATA2(RMS,'OATS','YILD','Y') )/2*0.001 );

Crop_Yield('row',comm)=0;

display Crop_Yield;


**recalculate straw production from area- yield data

parameter
str_prod(cc,comm,*)
str_yld(cc,comm,*)
;

str_prod(cc,comm,'sta')
 = CapToEsimArea(cc,comm,'Area','Base')*Stra_Yield(cc,comm,'abs');

str_prod(cc,comm,'yld')
 = CapToEsimArea(cc,comm,'Area','Base')*Crop_Yield(cc,comm)*Stra_Yield(cc,comm,'YtoStr');

display str_prod;

str_yld(cc,comm,'sta')
 = Stra_Yield(cc,comm,'abs');

str_yld(cc,comm,'yld')
 = Crop_Yield(cc,comm)*Stra_Yield(cc,comm,'YtoStr');

display str_yld;



   CaptoEsiBalan(cc,'STRA','PROD','Base')
  = sum(comm, CapToEsimArea(cc,comm,'Area','Base')*Stra_Yield(cc,comm,'abs')*DATA2('DE000000','DRMA','STRA','Y'));

display CaptoEsiBalan;

   CaptoEsiBalan(cc,'STRA','PROD','Base')
  = sum(comm, CapToEsimArea(cc,comm,'Area','Base')*Crop_Yield(cc,comm)*Stra_Yield(cc,comm,'YtoStr'));

   CaptoEsiBalan(cc,'STRA','HDEM','Base')
   =  CaptoEsiBalan(cc,'STRA','PROD','Base')
   -  CaptoEsiBalan(cc,'STRA','FDEM','Base')
;

set str_cc(cc)
/WB,ROW,US/;

***no straw production from WB, ROW and US
CaptoEsiBalan(str_cc,'STRA','HDEM','Base') =0;
CaptoEsiBalan(str_cc,'STRA','PROD','Base') =0;
CaptoEsiBalan(str_cc,'STRA','FDEM','Base') =0;


display CaptoEsiBalan;



*******************************************
***********Other energy, Other protein data correction*****
*******************************************

  CapToEsiBalan(cc,comm,'PROD','Base')
 $(sameas(comm,'FENE'))
 =   CapToEsiBalan(cc,comm,'FDEM','Base')
;

  CapToEsiBalan(cc,comm,'HDEM','Base')
 $(sameas(comm,'FENE') )
 = 0;

  CapToEsiBalan(cc,comm,'SDEM','Base')
 $(sameas(comm,'FENE') )
 = 0;

  CapToEsiBalan(cc,comm,'PDEM','Base')
 $(sameas(comm,'FENE') )
 = 0;


*************************************************************
***********Raw Milk data correction for human consumption****
*************************************************************


CapToEsiBalan(cc,comm,'HDEM','Base')
 $(sameas(comm,'MILK'))
=0;

option CapToEsiBalan:1:3:1
display CapToEsiBalan;




*******************************************
***********Human consumption change********
*******************************************


CapToEsiBalan(cc,comm,'HDEM','Base')
 $(sameas(comm,'RAPSEED'))
=0;

CapToEsiBalan(cc,comm,'HDEM','Base')
 $(sameas(comm,'SOYMEAL'))
=0;

CapToEsiBalan(cc,comm,'HDEM','Base')
 $(sameas(comm,'SUNMEAL'))
=0;
CapToEsiBalan(cc,comm,'HDEM','Base')
 $(sameas(comm,'RAPMEAL'))
=0;


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





********************************************
************Import palmo oil for Turkey
********************************************

compare_data(cc,comm,'HDEM','CAPRI')
 $(sameas(comm,'PALMOIL') and sameas(cc,'TU'))
 = (365+439+368)/3
;

compare_data(cc,comm,'NETRD','CAPRI')
 $(sameas(comm,'PALMOIL') and sameas(cc,'TU'))
 = -compare_data(cc,comm,'HDEM','CAPRI')

;




**********************************
**assinge 'oenergy' to 0 unitl its crosss price elasticities are calculated
**********************************


 compare_data(cc,'OENERGY',item,'CAPRI')
  $(sameas(item,'prod') or sameas(item,'fdem'))
 =   compare_data(cc,'OENERGY',item,'CAPRI') ;
*   + compare_data(cc,'OENERGY_CAPRI',item,'CAPRI');

*  compare_data(cc,'OENERGY_CAPRI',item,'CAPRI')
* =0;


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



********************************
***Biofuel data check
********************************

set bio_fuel /ethanol,diesel/;

Parameter check_biofuel(cc,bio_fuel,*)
check_biofuel2(cc,bio_fuel,*)
biofuel_etc(cc,*,*)
crops_to_ethanol(comm)
oil_to_diesel(i_diesel)
;

oil_to_diesel(i_diesel) = 0.922;

crops_to_ethanol('CWHEAT') = 0.274;
crops_to_ethanol('RYE') = 0.247;
crops_to_ethanol('OTHGRA') = 0.247;
crops_to_ethanol('CORN') = 0.335;
crops_to_ethanol('SUGAR') = 0.517;
crops_to_ethanol('BARLEY') = 0.247;

check_biofuel(cc,'ethanol','input')
 = sum(comm, compare_data(cc,comm,'pdem','CAPRI')*crops_to_ethanol(comm));

check_biofuel(cc,'diesel','input')
 = sum(i_diesel, compare_data(cc,i_diesel,'pdem','CAPRI')*oil_to_diesel(i_diesel));

check_biofuel2('US','ethanol',comm)
 =  compare_data('US',comm,'pdem','CAPRI')*crops_to_ethanol(comm);
display check_biofuel2;


check_biofuel(cc,'ethanol','output')
 = compare_data(cc,'ETHANOL','prod','CAPRI');

check_biofuel(cc,'diesel','output')
 = compare_data(cc,'biodiesel','prod','CAPRI');

display compare_data,check_biofuel;


*compare_data(cc,'ETHANOL','prod','CAPRI')
* = check_biofuel(cc,'ethanol','input');
*compare_data(cc,'biodiesel','prod','CAPRI')
* = check_biofuel(cc,'diesel','input');


check_biofuel(cc,'ethanol','output')
 = compare_data(cc,'ETHANOL','prod','CAPRI');

check_biofuel(cc,'diesel','output')
 = compare_data(cc,'biodiesel','prod','CAPRI');


biofuel_etc(cc,'BIOE','NAGR')
  = sum(esim_to_ms(cc,RMS), Data_CAL(RMS,'NAGR','BIOE','BAS'));

biofuel_etc(cc,'BIOE','EXOG')
  = sum(esim_to_ms(cc,RMS), Data_CAL(RMS,'EXOG','BIOE','BAS'));

biofuel_etc(cc,'BIOE','SECG')
  = sum(esim_to_ms(cc,RMS), Data_CAL(RMS,'SECG','BIOE','BAS'));


*check_biofuel(cc,'diesel','input')
* = sum(i_diesel,compare_data(cc,i_diesel,'pdem','CAPRI')*oil_to_diesel(i_diesel));


display check_biofuel;




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

$ontext
compare_data(cc,comm,'NETRD','CAPRI')
 $( sameas(cc,'ROW') and net_balance(comm,'CAPRI','total'))
 = compare_data(cc,comm,'NETRD','CAPRI')
 *(1+net_balance(comm,'CAPRI','total')/abs(compare_data(cc,comm,'NETRD','CAPRI')))
;

compare_data(cc,comm,blance,'CAPRI')
 $(( sameas(cc,'ROW')) and net_balance(comm,'CAPRI','total') and (sameas(blance,'HDEM')or sameas(blance,'FDEM')or sameas(blance,'PDEM'))
     and abs(compare_data(cc,comm,'NETRD','CAPRI')))
 = compare_data(cc,comm,blance,'CAPRI')*(1+net_balance(comm,'CAPRI','total')
   /abs(compare_data(cc,comm,'HDEM','CAPRI') + compare_data(cc,comm,'FDEM','CAPRI')+compare_data(cc,comm,'PDEM','CAPRI')))
;
$offtext
****============changing production becuase production from ROW is smaller in CAPRI data(HS)
compare_data(cc,comm,'NETRD','CAPRI')
 $( sameas(cc,'ROW') and net_balance(comm,'CAPRI','total'))
 = compare_data(cc,comm,'NETRD','CAPRI')
 *(1+net_balance(comm,'CAPRI','total')/abs(compare_data(cc,comm,'NETRD','CAPRI')));

***production increase for ddgs in ROW

display compare_data;

compare_data(cc,comm,blance,'CAPRI')
 $(( sameas(cc,'ROW')) and net_balance(comm,'CAPRI','total') and sameas(blance,'PROD')
     and abs(compare_data(cc,comm,'NETRD','CAPRI')) and not sameas(comm,'GLUTFD'))
 = compare_data(cc,comm,'PROD','CAPRI')+(-net_balance(comm,'CAPRI','total'));

***feed increase for ddgs in ROW
compare_data('ROW','GLUTFD','FDEM','CAPRI')
 =compare_data('ROW','GLUTFD','FDEM','CAPRI')
 + net_balance('GLUTFD','CAPRI','total');

display compare_data;


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


display global_balance,global_check,compare_data;



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


display nontrd_check,compare_data;


compare_data(cc,'MILK','PROD','CAPRI')
 = compare_data(cc,'MILK','FDEM','CAPRI')
  + compare_data(cc,'MILK','PDEM','CAPRI')
;

display compare_data;



set nonTRD /milk,cmilk/;


compare_data(cc,nonTRD,'HDEM','CAPRI')$sameas(nonTRD,'CMILK')
 = compare_data(cc,nonTRD,'PROD','CAPRI');



NonTRD_check(cc,nt)
 = compare_data(cc,nt,'PROD','CAPRI')
 - compare_data(cc,nt,'SDEM','CAPRI')
 - compare_data(cc,nt,'HDEM','CAPRI')
 - compare_data(cc,nt,'FDEM','CAPRI')
 - compare_data(cc,nt,'PDEM','CAPRI')
;

display nontrd_check;

****Milk (raw milk data for US and ROW check)
$ontext
compare_data(cc,'MILK','PROD','CAPRI')
  $(sameas(cc,'US') or sameas(cc,'ROW'))
 = compare_data(cc,'MILK','PROD','ESIM');

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
$offtext



display compare_data;


*************************************************
**************Diary processing parameters********
*************************************************

  CapriProcess(comm,'FAT',cc) = sum(esim_to_ms(cc,RMS)$(not sameas(cc,'ROW')),
                                       sum(esim_to_rows(comm,rows),
                                       Data_CAL(RMS,'FATS',rows,'BAS')));

  CapriProcess(comm,'Protein',cc) = sum(esim_to_ms(cc,RMS)$(not sameas(cc,'ROW')),
                                       sum(esim_to_rows(comm,rows),
                                       Data_CAL(RMS,'PROT',rows,'BAS')));


  CapriMilkProcess('FAT',cc) = sum(esim_to_ms(cc,RMS)$(not sameas(cc,'ROW')),
                                       Data_CAL(RMS,'FATS','MILK','BAS'));

  CapriMilkProcess('Protein',cc) = sum(esim_to_ms(cc,RMS)$(not sameas(cc,'ROW')),
                                       Data_CAL(RMS,'PROT','MILK','BAS'));

display CapriMilkProcess;



****Initial parameter insertion for ROW , Candia dariry coefficitens used and will be updated soon later


  CapriProcess(comm,'FAT',cc) $((sameas(cc,'ROW') or sameas(cc,'WB'))
    and sum(esim_to_ms(cc,RMS), sum(esim_to_rows(comm,rows)$Data_CAL(RMS,'FATS',rows,'BAS'),
                                       1)))
    = sum(esim_to_ms(cc,RMS), sum(esim_to_rows(comm,rows),
                                       Data_CAL(RMS,'FATS',rows,'BAS')))
      /sum(esim_to_ms(cc,RMS), sum(esim_to_rows(comm,rows)$Data_CAL(RMS,'FATS',rows,'BAS'),
                                       1));


  CapriProcess(comm,'PROTEIN',cc) $((sameas(cc,'ROW') or sameas(cc,'WB'))
    and sum(esim_to_ms(cc,RMS), sum(esim_to_rows(comm,rows)$Data_CAL(RMS,'PROT',rows,'BAS'),
                                       1)))
    = sum(esim_to_ms(cc,RMS), sum(esim_to_rows(comm,rows),
                                       Data_CAL(RMS,'PROT',rows,'BAS')))
      /sum(esim_to_ms(cc,RMS), sum(esim_to_rows(comm,rows)$Data_CAL(RMS,'PROT',rows,'BAS'),
                                       1));

display CapriProcess;


  CapriMilkProcess('FAT',cc) $((sameas(cc,'ROW') or sameas(cc,'WB'))
    and sum(esim_to_ms(cc,RMS), sum(esim_to_rows(comm,rows)$Data_CAL(RMS,'FATS','MILK','BAS'),1)))
    = sum(esim_to_ms(cc,RMS), Data_CAL(RMS,'FATS','MILK','BAS'))
      /sum(esim_to_ms(cc,RMS)$Data_CAL(RMS,'FATS','MILK','BAS'), 1);

  CapriMilkProcess('Protein',cc) $((sameas(cc,'ROW') or sameas(cc,'WB'))
    and sum(esim_to_ms(cc,RMS)$Data_CAL(RMS,'PROT','MILK','BAS'),1))
    = sum(esim_to_ms(cc,RMS), Data_CAL(RMS,'PROT','MILK','BAS'))
      /sum(esim_to_ms(cc,RMS)$Data_CAL(RMS,'PROT','MILK','BAS'), 1);


display CapriMilkProcess;


set DIR(comm)
/fat,protein/

parameter check_fatprot(cc,*,*)
check_prod(cc,*,*)
check_coeff(cc,*,*)
check_comm(cc,*,*)

calib(comm)
;

********************************
***Fat, Protein from supply data
********************************

check_fatprot(cc,dir,'supply')
=compare_data(cc,dir,'prod','capri');

***Fat, Protein from raw milk
check_fatprot(cc,dir,'supply_milk')
=CapriMilkProcess(dir,cc) *compare_data(cc,'milk','PDEM','capri')*0.01;

display check_fatprot;

***hyungsik, orignally only for WB, ROW Fat, Protein content paramter was recalibrated.
***hyungsik, recalibrate all dairy processing data because small diffrence in the ratio caues infesability in the error

CapriMilkProcess(DIR,cc)
*$(sameas(cc,'WB') or sameas(cc,'ROW'))
 = CapriMilkProcess(DIR,cc)*check_fatprot(cc,DIR,'supply')/ check_fatprot(cc,DIR,'supply_milk');

***

check_fatprot(cc,dir,'supply_milk')
=CapriMilkProcess(dir,cc) *compare_data(cc,'milk','PDEM','capri')*0.01;

check_fatprot(cc,DIR,'coeff')
 = sum(comm,CapriProcess(comm,DIR,cc)* compare_data(cc,comm,'prod','capri'))*0.01;

***check the HR coefficients have minus values in coefficients and should be recalibrated

CapriProcess(comm,DIR,cc)
 $check_fatprot(cc,DIR,'coeff')
*$(sameas(cc,'WB') or sameas(cc,'HR') or sameas(cc,'ROW'))
 = CapriProcess(comm,DIR,cc)*check_fatprot(cc,DIR,'supply')/ check_fatprot(cc,DIR,'coeff');

check_fatprot(cc,DIR,'coeff')
 = sum(comm,CapriProcess(comm,DIR,cc)* compare_data(cc,comm,'prod','capri'))*0.01;



CapriProcess_export(comm,DIR,cc)
 = CapriProcess(comm,DIR,cc)*compare_data(cc,comm,'prod','capri')*0.01
;

display check_fatprot,CapriProcess_export;

parameter fatcheck(dir,cc,*);

fatcheck(dir,cc,'abs')
 =sum(comm, CapriProcess_export(comm,DIR,cc));

fatcheck(dir,cc,'ratio')
 $compare_data(cc,dir,'prod','capri')
 = fatcheck(dir,cc,'abs')
  / compare_data(cc,dir,'prod','capri');



option fatcheck:3:1:1
display fatcheck;

option compare_data:3:3:1
display compare_data;


*****************************************************
*********************Set asdie area Assignment**********
*****************************************************

compare_data(cc,'SETASIDE','prod','capri')
 = compare_data(cc,'SETASIDE','area','capri');


Execute_unload '..\Data_GDX\CapriProcess.gdx',CapriProcess_export;

**export gdx to ESIM model

Execute_unload '..\Data_GDX\CapriMilkProcess.gdx',CapriMilkProcess;


*****************************************************
*********************Data Demand Assignment**********
*****************************************************

parameter area0(cc,comm),fdem0(cc,comm),hdem0(cc,comm),netexp0(cc,comm),pdem0(cc,comm),prod0(cc,comm),sdem0(cc,comm);

area0(cc,comm)=compare_data(cc,comm,'area','CAPRI');

fdem0(cc,comm)=compare_data(cc,comm,'FDEM','CAPRI');

hdem0(cc,comm)=compare_data(cc,comm,'HDEM','CAPRI');

netexp0(cc,comm)=compare_data(cc,comm,'NETRD','CAPRI');

pdem0(cc,comm)=compare_data(cc,comm,'PDEM','CAPRI');

prod0(cc,comm)=compare_data(cc,comm,'PROD','CAPRI');

sdem0(cc,comm)=compare_data(cc,comm,'SDEM','CAPRI');


*fdem1(cc,comm)
* $(sameas(comm,'GRAS') or sameas(comm,'FODDER'))
* = prod1(cc,comm);

*display fdem1,prod1;

Execute_unload '..\Data_GDX\data_capri.gdx',area0,fdem0,hdem0,netexp0,pdem0,prod0,sdem0;
*Execute_unload '..\Parameter_change\data\data_capri.gdx',fdem1,prod1;


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

**export gdx to ESIM model
Execute_unload '..\Data_GDX\CAPRI_show_data',show_data_CAPRI,show_diary_CAPRI;
Execute_unload '..\Data_GDX\CAPRI_consolid_area',consolid_area_CAPRI;
Execute_unload '..\Data_GDX\Straw_ratio',Stra_Yield;



set product_check(cc,comm);

product_check(cc,comm)
 $ compare_data(cc,comm,'prod','CAPRI')
 = yes;

display product_check;

Execute_unload 'product_check.gdx',product_check;
$call gdxxrw  product_check.gdx o=product_check.xls  set=product_check  Rng=output!a1



parameter area_check(*,*);

set area2/grass,crop/;

area_check(cc,'grass')
 =sum(comm $( sameas(comm,'GRAS')),
    compare_data(cc,comm,'Area','CAPRI'));

area_check(cc,'crop')
 =sum(comm $(not(sameas(comm,'GRAS'))),
    compare_data(cc,comm,'Area','CAPRI'));

area_check('eu27',area2)
 =sum(eu27, area_check(eu27,area2));

display area_check;

