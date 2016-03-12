********************************************************************************
$ontext

   CAPRI project

   GAMS file : TO_ESIM.GMS

   @purpose  : Store selected results from international market model and
               behavioral parameters in GDX to be picked up by ESIM
               for stochastic analysis

   @author   : W.Britz
   @date     : 19.12.12
   @since    :
   @refDoc   :
   @seeAlso  :
   @calledBy :

$offtext
********************************************************************************
$offlisting

*$setglobal results_in   t:\britz\results
$setglobal results_in   E:\CAPRI_results

$setglobal SIMY                2020
$setglobal BAS                 04
$setglobal CUR                 20
$setglobal regLevelIndicator    2
$setglobal capri_res           MTR_RD

$setglobal MARKET_M ON
*$include 'sets.gms'
*$include 'arm\arm_sets.gms'
$include 'capri_sets.gms'
$include 'capri_arm_sets.gms'

   PARAMETER DATAOUT(*,*,*,*,*);

   execute_loadpoint "%results_in%\capmod\res_%regLevelIndicator%_%BAS%%CUR%%capri_res%.gdx" DATAOUT;


   set cols_to_esim(cols) / PPRI,CPRI,PROD,HCON,PROC,BIOF,ISCH,NTRD /;

   set basBal / BAS,CAL /;


   parameter p_toEsim(RMALL,COLS_to_esim,XX,*)

      p_ElasSupp(RMALL,XX_ALL,XX_ALL,BASCAL)           "Elasticity of supply"
      p_ElasDem(RMALL,XX_ALL,XX_ALL,BASCAL)            "Elasticity of human consumption"
      p_ElasFeed(RMALL,XX_ALL,XX_ALL,BASCAL)           "Elasticity of feed"
      p_ElasProc(RMALL,XX_ALL,XX_ALL,BASCAL)           "Elasticity of processing"
      p_ElasDair(RMALL,XX_ALL,XX_ALL,BASCAL)           "Elasticity of dairy production"
 ;


   execute_loadpoint "%results_in%\arm\elas%bas%%cur%" p_ElasDem,p_ElasFeed,p_ElasProc,p_ElasDair,p_ElasSupp;





parameter test(RMS);
test(RMS) = DATAOUT(RMS,"","PROD","WHEA","BAS");
display test;
$stop


   p_toEsim(RMS,cols_to_esim,XX,"BAS")    = DATAOUT(RMS,"",cols_to_esim,XX,"BAS");
   p_toEsim(RMS,cols_to_esim,XX,"TRD")    = DATAOUT(RMS,"",cols_to_esim,XX,"TRD");
   p_toEsim(RMS,cols_to_esim,XX,"%SIMY%") = DATAOUT(RMS,"",cols_to_esim,XX,"%SIMY%");

   set basTrdSimy / BAS,TRD,"%SIMY%" /;

*
*  --- net trade (>0 => exports)
*
   p_toEsim(RMS,"NTRD",XX,BasTrdSimY)
      = DATAOUT(RMS,"","PROD",XX,BasTrdSimy)
      - DATAOUT(RMS,"","HCON",XX,BasTrdSimy)
      - DATAOUT(RMS,"","FEED",XX,BasTrdSimy)
      - DATAOUT(RMS,"","PROC",XX,BasTrdSimy)
      - DATAOUT(RMS,"","BIOF",XX,BasTrdSimy)
      - DATAOUT(RMS,"","ISCH",XX,BasTrdSimy);
*
*  --- Test world
*
   parameter p_testWorld;
   p_testWorld(XX,basTrdSimy) = sum(RMS, p_toEsim(RMS,"NTRD",XX,BasTrdSimy));
   display p_testWorld;

   execute_unload "%results_in%\capmod\res_%regLevelIndicator%_%BAS%%CUR%%capri_res%_toEsim.gdx" p_toEsim,p_ElasDem,p_ElasFeed,p_ElasProc,p_ElasDair,p_ElasSupp;

