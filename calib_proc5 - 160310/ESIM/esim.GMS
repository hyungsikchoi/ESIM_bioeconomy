* switch on calibration procedure to AGLINK (yes or no):
$SETGLOBAL calibrateToAglink      no
* switch on using AGLINK calibrated parameters in ESIM simulations (yes or no):
$SETGLOBAL useCalibratedShifters  yes

* switch on model likange with TimePan-EU for the bioeconomy scenarios
$SETGLOBAL bioscenario no

* switch on lignocellulosic biomass supply diffusion in the market
$SETGLOBAL Lignomodule no

*$SETGLOBAL Bioenergy_shifter "Bioen_Halbierte BMU_C75_BIO_ITer4_nolink.gdx"


$inlinecom { }
*=========================================================
* Use this file to put certain environment variables
* under Windows/Dos into GAMS Global parameters
*=========================================================
*
$INCLUDE ENVIRONMENT.GMS
*=========================================================
*If you want to control this model outside GSE please
*uncomment one of the following:
*=========================================================
* 1. Run the model and use the GDX file
$setglobal GSEACTION SCENARIO
*=========================================================

*========*
* ESIM   *
*========*

$include "sets.gms"


$include "alias.gms"

*$include "mapping.gms"

$include "parameters.gms"

$include "variables.gms"

$include "assignments.gms"

$include "calibration.gms"




*++++++++++++++++++++++++++++++++++++++++++++++++++++++
* do not apply if automated calibration is used:
*$include "fapri.gms"
*++++++++++++++++++++++++++++++++++++++++++++++++++++++


**GAMSCHK test*

*option MCP=gamschk;

$onecho > %system.fn%.gck
?blockpic
?blocklist
?analysis
displaycr
?nonopt
postopt
$offecho


* define model and check that base year replicates correctly:
$include "model.gms"


* check that base simulation reproduces input data:
$include "base_check.gms"


* calculate exongeous parameters which change between simulation runs from input files
* (technical progress, demographic, policy, trends, etc.):
$include "sim_param_calc.gms"




* perform simulations:
$include "simulation.gms"



* generate output:
$include "output.gms"

parameter totaltime;
totaltime = TIMEELAPSED;
display totaltime;

$label end_model
