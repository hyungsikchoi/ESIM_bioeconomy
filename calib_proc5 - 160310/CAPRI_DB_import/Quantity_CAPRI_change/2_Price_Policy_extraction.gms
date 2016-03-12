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



set cols_to_esim(cols)
/ ARM1,ARM2,DSales,PROD,HCON,PROC,BIOF,ISCH,NTRD,INCE,FEED,FATS,PROT,CMRG,CPRI,PPRI,arm1p/;
*set TRQ /TrqNT,TaAppl/;
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
      Data_CAL(*,*,*,*)
      p_trqGlobl(RALL,*,*,*)
      DATA2(RALL,*,*,*)
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

$ontext
set eu15_to_esim(ccplus,RMALL)
/
   BE.    BL000000  "Belgium and Luxembourg"
   DK.    DK000000  "Denmark"
   GE.    DE000000  "Germany"
       EL000000  "Greece"
       ES000000  "Spain"
       FR000000  "France"
       IR000000  "Irland"
       IT000000  "Italy"
       NL000000  "The Netherlands"
       AT000000  "Austria"
       PT000000  "Portugal"
       SE000000  "Sweden"
       FI000000  "Finland"
       UK000000  "United Kingdom"
/;
$offtext

SET esim_to_ms(ccplus,RALL)
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
execute_load '%fcapriresROW%', p_trqGlobl;


display DATA2,Data_CAL,p_trqGlobl;




* split missing products CMILK&ACID_MLK and CWHEAT&DURUM:
PARAMETER
   show_data(i,*,ccplus) "Consolidated data base, in 1000 t (ESIM)"
   consolid_area(i,ccplus)
   pp_results(i,ccplus,*)  "Producer price (ESIM)"
   DP_DECOUP(i,ccplus)
   DP_COUP(i,ccplus)
   fdem0(*,*)
;

$GDXin '%diresim%\Quantities.gdx'
$load show_data,consolid_area
$GDXIN

*$GDXin '%diresim%\data_quantities.gdx'
*$load fdem0
*$GDXIN

$GDXin '%diresim%\Prices_Policies.gdx'
$load pp_results,DP_DECOUP,DP_COUP
$GDXIN

display pp_results;

Parameter
Compare_price(*,*,*,*)
Compare_DP(cc,comm,*,*)
Compare_border(*,comm,*,*)
Compare_policy(*,comm,*,*)
;

**** PP + direct payment  = PI
****        PD + tax (PW) = PC
Compare_price(comm,cc,'PP','ESIM')$((not sameas(comm,'DURUM')) and (not sameas(cc,'MANIOC')))
 =  pp_results(comm,cc,'pp');

*Compare_price(comm,'PD',cc,'ESIM')
* =  pp_results(comm,cc,'PD');



Compare_price(comm,cc,'PP','CAPRI')$(not sameas(cc,'ROW'))

 =   sum(esim_to_ms(cc,RMS), sum(esim_to_rows(comm,rows),
                                               ( Data_CAL(RMS,'PPRI',rows,'BAS')
                                               + Data_CAL(RMS,'PPRI','WHEA','BAS')  $sameas(rows,'SWHE')
                                               + Data_CAL(RMS,'PPRI','MILK','BAS')  $sameas(rows,'COMI'))));


Compare_price(comm,cc,'PP','CAPRI')
 $((sameas(cc,'WB') or sameas(cc,'ROW')) and (not sameas(comm,'OENERGY_CAPRI'))
  and sum(esim_to_rows(comm,rows), sum(esim_to_ms(cc,RMS)$( Data_CAL(RMS,'PPRI',rows,'BAS')+Data_CAL(RMS,'PPRI','WHEA','BAS')$sameas(rows,'SWHE')), 1)))

 = sum(esim_to_rows(comm,rows),
         sum(esim_to_ms(cc,RMS), ( Data_CAL(RMS,'PPRI',rows,'BAS')+Data_CAL(RMS,'PPRI','WHEA','BAS')  $sameas(rows,'SWHE') +Data_CAL(RMS,'PPRI','WHEA','BAS')  $sameas(rows,'SWHE')))
          / sum(esim_to_ms(cc,RMS)$( Data_CAL(RMS,'PPRI',rows,'BAS')+Data_CAL(RMS,'PPRI','WHEA','BAS')  $sameas(rows,'SWHE')), 1)
   );


Compare_price(comm,cc,'PP','CAPRI')

 $( sameas(comm,'SMAIZE') or sameas(comm,'FODDER') or sameas(comm,'GRAS'))

 = sum(esim_to_rows(comm,rows),
         sum(esim_to_ms(cc,RMS), ( DATA2(RMS,'UVAP',rows,'Y') ) ));

****Fodder price check halfed ????

Compare_price(comm,cc,'PP','CAPRI')$(sameas(comm,'OTHGRA'))
 = Compare_price('PP',comm,cc,'CAPRI')/2;


Compare_price(comm,cc,'PD','ESIM')
 = pp_results(comm,cc,'pd');



* mapping market model regions to regions
*SET RMEU_TO_EUAGG_EUMODE(RMEU,RALL,EUMODE) /
*   EU.      EU027000.EU27
*   EU015000.EU015000.EU27
*   EU_EAST .EU010000.EU27
*   BUR     .BUR     .EU27
*   EU      .EU028000.EU28
*   EU015000.EU015000.EU28
*   EU_EAST .EU011000.EU28
*   BUR     .BUR     .EU28
*  /;

********************************************************************************************************
***PD CAPRI, ARM1P = average market price = weighted price of domestic producer price and imported price
********************************************************************************************************

loop(REU15,
Compare_price(comm,cc,'PD','CAPRI')$esim_to_ms(cc,REU15)
 =    sum(esim_to_rows(comm,rows),  ( Data_CAL('EU015000','arm1p',rows,'BAS')
                                              +  Data_CAL('EU015000','arm1p','WHEA','BAS')  $sameas(rows,'SWHE')));
);

loop(REU11,
Compare_price(comm,cc,'PD','CAPRI')$esim_to_ms(cc,REU11)
 =    sum(esim_to_rows(comm,rows),
                                               ( Data_CAL('eu_east','arm1p',rows,'BAS')
                                              +  Data_CAL('eu_east','arm1p','WHEA','BAS')  $sameas(rows,'SWHE')));
);

Compare_price(comm,cc,'PD','CAPRI')$esim_to_ms(cc,'RO000000')
 =    sum(esim_to_rows(comm,rows),( Data_CAL('eu_east','arm1p',rows,'BAS')
                                 +  Data_CAL('eu_east','arm1p','WHEA','BAS')  $sameas(rows,'SWHE')));


Compare_price(comm,cc,'PD','CAPRI')$esim_to_ms(cc,'BG000000')
 =    sum(esim_to_rows(comm,rows),( Data_CAL('BUR','arm1p',rows,'BAS')
                                 +  Data_CAL('BUR','arm1p','WHEA','BAS')  $sameas(rows,'SWHE')));


Compare_price(comm,cc,'PD','CAPRI')$esim_to_ms(cc,'TUR')
 =    sum(esim_to_rows(comm,rows),( Data_CAL('TUR','arm1p',rows,'BAS')
                                 +  Data_CAL('TUR','arm1p','WHEA','BAS')  $sameas(rows,'SWHE')));


Compare_price(comm,cc,'PD','CAPRI')$esim_to_ms(cc,'USA')
 =    sum(esim_to_rows(comm,rows),( Data_CAL('USA','arm1p',rows,'BAS')
                                 +  Data_CAL('USA','arm1p','WHEA','BAS')  $sameas(rows,'SWHE')));


Compare_price(comm,cc,'PC','CAPRI')
 =   sum(esim_to_ms(cc,RMS), sum(esim_to_rows(comm,rows),
                                               ( Data_CAL(RMS,'CPRI',rows,'BAS')
                                              +  Data_CAL(RMS,'CPRI','WHEA','BAS')  $sameas(rows,'SWHE'))));

Compare_price(comm,cc,'Margin','CAPRI')
 =   sum(esim_to_ms(cc,RMS), sum(esim_to_rows(comm,rows),
                                               ( Data_CAL(RMS,'CMrg',rows,'BAS')
                                              +  Data_CAL(RMS,'CMrg','WHEA','BAS')  $sameas(rows,'SWHE'))));



option compare_price:0:2:2
display Compare_price;



Compare_DP(cc,comm,'PRME','ESIM')
 = DP_DECOUP(comm,cc);

Compare_DP(cc,comm,'PRMD','ESIM')
 = DP_COUP(comm,cc);


Compare_DP(cc,comm,'PRME','CAPRI')
 =   sum(esim_to_ms(cc,RMS), sum(esim_to_rows(comm,rows),
                                       ( DATA2(RMS,rows,'PRME','Y')
                                       + DATA2(RMS,'WHEA','PRME','Y')  $sameas(rows,'SWHE'))));

Compare_DP(cc,comm,'PRME_UAAR','CAPRI')
 =   sum(esim_to_ms(cc,RMS), sum(esim_to_rows(comm,rows),
                                       ( DATA2(RMS,'UAAR','PRME','Y'))))
;


Compare_DP(cc,comm,'PRMD','CAPRI')
 =   sum(esim_to_ms(cc,RMS), sum(esim_to_rows(comm,rows),
                                       ( DATA2(RMS,rows,'PRMD','Y')
                                       + DATA2(RMS,'WHEA','PRMD','Y')  $sameas(rows,'SWHE'))));

option Compare_DP:0:2:2
display Compare_DP;

*Compare_price(cc,comm,'ESIM')
* =

*"TRQ quota quantity as applied"
Compare_border('EU27',comm,'TRQ','CAPRI')
    =    sum(esim_to_rows(comm,rows),
                                    ( p_trqGlobl('EU027000',ROWS,'TrqNT','2008')
                                   +  p_trqGlobl('EU027000','WHEA','TrqNT','2008')$(sameas(rows,'SWHE'))));


Compare_border('EU27',comm,'TRQ','ESIM')
   = pp_results(comm,'GE','TRQ')*1000;


Compare_border('EU27',comm,'IntPR','ESIM')
   = pp_results(comm,'GE','intPR');



Compare_border('EU15',comm,'IntPR','CAPRI')
   = sum(esim_to_rows(comm,rows),  ( Data_CAL('EU015000','PADM',rows,'BAS')));

Compare_border('EU_East',comm,'IntPR','CAPRI')
   = sum(esim_to_rows(comm,rows),  ( Data_CAL('EU_EAST','PADM',rows,'BAS')));




Compare_border('EU27',comm,'SP_D','ESIM')
   = pp_results(comm,'GE','sp_d');

Compare_border('EU27',comm,'SP_D','CAPRI')
 $(sum(esim_to_rows(comm,rows),  ( Data_CAL('EU027000','TARS',rows,'2008'))) gt 1)
   = sum(esim_to_rows(comm,rows),  ( Data_CAL('EU027000','TARS',rows,'2008')));


Compare_border('EU27',comm,'ThrPr','ESIM')
   = pp_results(comm,'GE','thrpr');



Compare_border('EU27',comm,'ExpSub','ESIM')
   = pp_results(comm,'GE','exp_sub');

*Compare_border('EU15',comm,'TrqNT','CAPRI')
*    =    sum(esim_to_rows(comm,rows),
*                                    ( p_trqGlobl('EU015000',ROWS,'TrqNT','2008')));




*Compare_border('EU27',comm,'TaMFN','CAPRI')
*    =    sum(esim_to_rows(comm,rows),  ( p_trqGlobl('EU027000',ROWS,'TSMFN','2008')));

Compare_border('EU27',comm,'tar_ad','ESIM')
   = pp_results(comm,'GE','tar_ad')*100;

Compare_border('EU15',comm,'tar_ad','CAPRI')
    =    sum(esim_to_rows(comm,rows),( Data_CAL('EU015000','TARV',rows,'BAS') ));

Compare_border('EU_EAST',comm,'tar_ad','CAPRI')
    =    sum(esim_to_rows(comm,rows),( Data_CAL('EU_EAST','TARV',rows,'BAS') ));


option  Compare_border:0:2:2
display Compare_border;

Execute_unload 'Compare_border.gdx',Compare_border;
Execute_unload 'Compare_price.gdx',Compare_price;  
Execute_unload 'Compare_DP.gdx',Compare_DP;


$call gdxxrw  Compare_border.gdx o=Check_policy.xls  par=Compare_border Rng=Border!a1 Cdim=2 Rdim=2

$call gdxxrw  Compare_price.gdx o=Check_policy.xls par=Compare_price Rng=Price!a1 Cdim=2 Rdim=2

$call gdxxrw  Compare_DP.gdx o=Check_policy.xls par=Compare_DP Rng=Premium!a1 Cdim=2 Rdim=2