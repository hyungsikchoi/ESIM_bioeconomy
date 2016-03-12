* generate balanced market quantities based on AGLINK percentage (quantity) changes and ESIM quantities
*-------------------------------------------------------------------------------------------------------
*  set PARAMETER 'NETEXP_CHG' to
*    'no'  to calibrate to absolute NETEXP levels
*    'yes' to calibrate to ESIM NETEXP level + CHANGE in AGLINK level
*  set PARAMETER ENFORCE_TRADEDIR(COMM) to
*    'yes' to restrict to AGLINK trade direction
*    'no'  to leave the trade direction free
*    NOTE: ENFORCE_TRADEDIR can be set differently for each commodity
$ONMULTI
$ONEMPTY
$INCLUDE sets.gms

* simulation year:
$setglobal BASY                2007
$setglobal SIMY                2020
set basYsimY / BAS, '%SIMY%'/;

$SETGLOBAL RAW_INPUT_FILE ".\output\target_data_capri.gdx"

PARAMETER NETEXP_CHG if yes then NETEXP is based on AGLINK quantity level CHANGES (otherwise based on AGLINK quantity LEVELS)
            /no/;
PARAMETER ENFORCE_TRADEDIR(COMM) if yes then the direction of trade is enforced for product COMM;
ENFORCE_TRADEDIR(COMM) = 1;
* switch off the enforcement of the trade direction for single commodities:
*ENFORCE_TRADEDIR('RYE') = 0;

SETS
TGTSET             /SUPPLY, TUSE, NETEXP, PW, PD/
CTRYGRP            /EU15, EU12, OTHER, ROW, EU/
EUGRP(CTRYGRP)     /EU15, EU12, OTHER/
EU15EU12(EUGRP)    /EU15, EU12/
NONEU(cc)          non-EU countries set /WB, US, ROW/
NONEUeurope(cc)    european countries not in the EU set /TU, HR/
EUGRPMEM(EUGRP,cc) /EU15.set.EU15, EU12.set.EU12, OTHER.set.NONEUeurope/
ALLPERIODS         all simulation periods including base /base, 2008*2020/
YEAR(ALLPERIODS)   all years /2020/
TRADED(EUGRP,COMM) EUGRP trades COMM in ESIM and AGLINK input data base year resp. 2008
;

PARAMETER
   show_data(i,data_base,ccplus)            "Consolidated data base, in 1000 t"
   mrktpri0(ccplus,i)                       market prices in base period
   alraw(*,*,*,*)                           raw AGLINK input data
   tgt(TGTSET,CTRYGRP,COMM,ALLPERIODS)      target change (mixed) data
   tgtq(TGTSET,CTRYGRP,COMM,ALLPERIODS)     target level data (esim quantities)
   ma(TGTSET,CTRYGRP,COMM)                  margin of acceptance
   base(TGTSET,CTRYGRP,COMM)                ESIM base year data aggregated to EU groups
   infeschk(CTRYGRP,COMM,ALLPERIODS)        check given margin of acceptance bounds for feasibility
   pcdev(TGTSET,CTRYGRP,COMM,ALLPERIODS)    percentage deviation from target QUANTITY
   pcdevoutma(TGTSET,CTRYGRP,COMM,ALLPERIODS)  percentage deviation from target QUANTITY minus margin of acceptance (only if out of margin)
   tradedir_changed(CTRYGRP,COMM,ALLPERIODS) the target direction of trade is not met (only reported if ENFORCE_TRADEDIR(COMM)=1)
   bound(ALLPERIODS,CTRYGRP,*,COMM)         bounds on EU country group targets derived from ESIM quantities & AGLINK %changes & given MAs
   target(TGTSET, CTRYGRP, COMM, ALLPERIODS) final output targets data as changes from ESIM base year (multipliers)
   cmp(*,TGTSET,CTRYGRP,COMM,ALLPERIODS)    aglink and esim (after applying aglink changes) level data for comparision
   outesimagg(*,i,*,*) output data in esim coding as levels data
   outesimaggpc(*,i,*) output data in esim coding as percentage changes from ESIM base to 2020
;
$GDXIN '%RAW_INPUT_FILE%'
$LOAD outesimagg outesimaggpc
$GDXIN


display outesimaggpc;
*$CALL GDXXRW.EXE "%RAW_INPUT_FILE%" par=alraw rng="Input data"! rdim=3 cdim=1 output="./aglink_input_raw.gdx"
*$GDXIN "./aglink_input_raw.gdx"
*$LOAD alraw
*$GDXIN

$GDXIN 'Quantities.gdx'
$LOAD show_data
$GDXIN

base('SUPPLY',EUGRP,COMM) = sum(EUGRPMEM(EUGRP,cc), show_data(COMM,'PROD',cc));
base('TUSE',EUGRP,COMM) = sum(EUGRPMEM(EUGRP,cc), show_data(COMM,'HDEM',cc)
                         +show_data(COMM,'SDEM',cc)+show_data(COMM,'FDEM',cc)+show_data(COMM,'PDEM',cc));
base('NETEXP',EUGRP,COMM) = base('SUPPLY',EUGRP,COMM) - base('TUSE',EUGRP,COMM);

tgt(TGTSET,CTRYGRP,COMM,YEAR) = 0;

ALIAS(YEAR,YEAR2);

tgt('PW','ROW',COMM,'%SIMY%')$outesimaggpc('ROW',comm,'PW') = outesimaggpc('ROW',comm,'PW')/100+1;
tgt('SUPPLY',EU15EU12,COMM,'%SIMY%')$outesimaggpc(EU15EU12,comm,'SUPPLY') = outesimaggpc(EU15EU12,comm,'SUPPLY')/100+1;
tgt('TUSE',EU15EU12,COMM,'%SIMY%')$outesimaggpc(EU15EU12,comm,'TUSE') = outesimaggpc(EU15EU12,comm,'TUSE')/100+1;

* net exports which are already separate for EU12, EU15:
if (NETEXP_CHG,
   tgt('NETEXP',EU15EU12,COMM,'%SIMY%') =
         outesimagg(EU15EU12,COMM,'NETEXP','%SIMY%') - outesimagg(EU15EU12,COMM,'NETEXP','2006/07') + base('NETEXP',EU15EU12,comm);
else
*  base NETEXP calibration on NETEXP quantity level changes instead of the pure levels
   tgt('NETEXP',EU15EU12,COMM,'%SIMY%') = outesimagg(EU15EU12,COMM,'NETEXP','%SIMY%');
);


display tgt;

* SUGAR, BIODIESEL, ETHANOL NETEXP are only given for the EU as a whole:
* - derive NETEXP = SUPPLY - TUSE
*SET missingNETEXP(comm) /'SUGAR','BIODIESEL','ETHANOL'/;
SET missingNETEXP(comm) //
;
tgt('NETEXP',EU15EU12,COMM,YEAR)$missingNETEXP(COMM) = tgt('SUPPLY',EU15EU12,COMM,YEAR)*base('SUPPLY',EU15EU12,comm) - tgt('TUSE',EU15EU12,COMM,YEAR)*base('TUSE',EU15EU12,comm);

TRADED(EU15EU12,COMM)$(base('NETEXP',EU15EU12,COMM) AND sum(YEAR, tgt('NETEXP',EU15EU12,COMM,YEAR)<>0) ) = YES;
display TRADED;

*alraw(TGTSET,COMM,CTRYGRP,'MA')$(NOT alraw(TGTSET,COMM,CTRYGRP,'MA')) = 0;
*ma(TGTSET,CTRYGRP,COMM) = alraw(TGTSET,COMM,CTRYGRP,'MA');
ma(TGTSET,CTRYGRP,COMM) = 0;

tgtq('SUPPLY',EU15EU12,COMM,YEAR)$base('SUPPLY',EU15EU12,comm) = tgt('SUPPLY',EU15EU12,COMM,YEAR)*base('SUPPLY',EU15EU12,comm);
tgtq('TUSE',EU15EU12,COMM,YEAR)$base('TUSE',EU15EU12,comm) = tgt('TUSE',EU15EU12,COMM,YEAR)*base('TUSE',EU15EU12,comm);
tgtq('NETEXP',EU15EU12,COMM,YEAR)$TRADED(EU15EU12,COMM) = tgt('NETEXP',EU15EU12,COMM,YEAR);

display tgt, ma, tgtq, base;

VARIABLES
S(EU15EU12,COMM,YEAR)  supply
D(EU15EU12,COMM,YEAR)  tuse
X(EU15EU12,COMM,YEAR)  netexp
Y(EU15EU12,COMM,YEAR)  objective function value for a single market
Z                      global objective function value
;

$ontext
bound(YEAR,EU15EU12,'S.LO',COMM) = max(0,tgt('SUPPLY',EU15EU12,COMM,YEAR)-ma('SUPPLY',EU15EU12,COMM)/100)*base('SUPPLY',EU15EU12,comm);
bound(YEAR,EU15EU12,'S.UP',COMM) = (tgt('SUPPLY',EU15EU12,COMM,YEAR)+ma('SUPPLY',EU15EU12,COMM)/100)*base('SUPPLY',EU15EU12,comm);
bound(YEAR,EU15EU12,'D.LO',COMM) = max(0,tgt('TUSE',EU15EU12,COMM,YEAR)-ma('TUSE',EU15EU12,COMM)/100)*base('TUSE',EU15EU12,comm);
bound(YEAR,EU15EU12,'D.UP',COMM) = (tgt('TUSE',EU15EU12,COMM,YEAR)+ma('TUSE',EU15EU12,COMM)/100)*base('TUSE',EU15EU12,comm);
bound(YEAR,EU15EU12,'X.LO',COMM) = tgtq('NETEXP',EU15EU12,COMM,YEAR)-ma('NETEXP',EU15EU12,COMM);
bound(YEAR,EU15EU12,'X.UP',COMM) = tgtq('NETEXP',EU15EU12,COMM,YEAR)+ma('NETEXP',EU15EU12,COMM);
bound(YEAR,EU15EU12,'X.UP',COMM)$(alraw('NETEXP',COMM,EU15EU12,YEAR)<0 AND ENFORCE_TRADEDIR(COMM)) =
         min(0,tgtq('NETEXP',EU15EU12,COMM,YEAR)+ma('NETEXP',EU15EU12,COMM));
bound(YEAR,EU15EU12,'X.LO',COMM)$(alraw('NETEXP',COMM,EU15EU12,YEAR)>0 AND ENFORCE_TRADEDIR(COMM)) =
         max(0,tgtq('NETEXP',EU15EU12,COMM,YEAR)-ma('NETEXP',EU15EU12,COMM));

display bound;

* mark infeasibilities caused by given bounds:
infeschk(EU15EU12,COMM,YEAR)$(NOT (bound(YEAR,EU15EU12,'S.UP',COMM)-bound(YEAR,EU15EU12,'D.LO',COMM)>=bound(YEAR,EU15EU12,'X.LO',COMM)
                         AND bound(YEAR,EU15EU12,'S.LO',COMM)-bound(YEAR,EU15EU12,'D.UP',COMM)<=bound(YEAR,EU15EU12,'X.UP',COMM))) = YES;

* not infeasible if one of {supply, tuse, netexp} is not given as a target because then the market balance can be freely computed:
infeschk(EU15EU12,COMM,YEAR)$( SUM(YEAR2, alraw('SUPPLY',COMM,EU15EU12,YEAR2)<>0)=0 OR SUM(YEAR2, alraw('TUSE',COMM,EU15EU12,YEAR2)<>0)=0 OR SUM(YEAR2, alraw('NETEXP',COMM,EU15EU12,YEAR2)<>0)=0)
                         = NO;

if (sum((EU15EU12,COMM,YEAR),infeschk(EU15EU12,COMM,YEAR)),
   DISPLAY "USER INPUT WARNING: Some margins of acceptance are not large enough to allow a consistent market balance. Bounds will not be respected for targets included in infeschk.", infeschk;
);
* set bound according to MAs
* if MAs are infeasible, only apply condition to keep NETEXP positive or negative and S and D positive
S.LO(EU15EU12,COMM,YEAR)$(NOT infeschk(EU15EU12,COMM,YEAR) OR NOT bound(YEAR,EU15EU12,'S.LO',COMM)) = bound(YEAR,EU15EU12,'S.LO',COMM);
S.UP(EU15EU12,COMM,YEAR)$(NOT infeschk(EU15EU12,COMM,YEAR)) = bound(YEAR,EU15EU12,'S.UP',COMM);
D.LO(EU15EU12,COMM,YEAR)$(NOT infeschk(EU15EU12,COMM,YEAR) OR NOT bound(YEAR,EU15EU12,'D.LO',COMM)) = bound(YEAR,EU15EU12,'D.LO',COMM);
D.UP(EU15EU12,COMM,YEAR)$(NOT infeschk(EU15EU12,COMM,YEAR)) = bound(YEAR,EU15EU12,'D.UP',COMM);
X.LO(EU15EU12,COMM,YEAR)$(NOT infeschk(EU15EU12,COMM,YEAR) OR NOT bound(YEAR,EU15EU12,'X.LO',COMM)) = bound(YEAR,EU15EU12,'X.LO',COMM);
X.UP(EU15EU12,COMM,YEAR)$(NOT infeschk(EU15EU12,COMM,YEAR) OR NOT bound(YEAR,EU15EU12,'X.UP',COMM)) = bound(YEAR,EU15EU12,'X.UP',COMM);

$offtext

S.L(EU15EU12,COMM,YEAR) = tgtq('SUPPLY',EU15EU12,COMM,YEAR);
D.L(EU15EU12,COMM,YEAR) = tgtq('TUSE',EU15EU12,COMM,YEAR);
X.L(EU15EU12,COMM,YEAR) = tgtq('NETEXP',EU15EU12,COMM,YEAR);
S.LO(EU15EU12,COMM,YEAR) = 0;
D.LO(EU15EU12,COMM,YEAR) = 0;
*S.FX(EU15EU12,COMM,YEAR)$(NOT TRADED(EU15EU12,COMM) AND tgt('SUPPLY',EU15EU12,COMM,YEAR)*base('SUPPLY',EU15EU12,comm)) = tgt('SUPPLY',EU15EU12,COMM,YEAR)*base('SUPPLY',EU15EU12,comm);
*D.FX(EU15EU12,COMM,YEAR)$(NOT TRADED(EU15EU12,COMM) AND tgt('TUSE',EU15EU12,COMM,YEAR)*base('TUSE',EU15EU12,comm)) = tgt('TUSE',EU15EU12,COMM,YEAR)*base('TUSE',EU15EU12,comm);
X.FX(EU15EU12,COMM,YEAR)$(NOT TRADED(EU15EU12,COMM)) = 0;
*Y.FX(EU15EU12,COMM,YEAR)$(NOT TRADED(EU15EU12,COMM)) = 0;
$ontext
S.FX(EU15EU12,COMM,YEAR)$(NOT TRADED(EU15EU12,COMM) OR NOT tgtq('SUPPLY',EU15EU12,COMM,YEAR)) = 0;
D.FX(EU15EU12,COMM,YEAR)$(NOT TRADED(EU15EU12,COMM) OR NOT tgtq('TUSE',EU15EU12,COMM,YEAR)) = 0;
X.FX(EU15EU12,COMM,YEAR)$(NOT TRADED(EU15EU12,COMM) OR NOT tgtq('NETEXP',EU15EU12,COMM,YEAR)) = 0;
*Y.FX(EU15EU12,COMM,YEAR)$(NOT TRADED(EU15EU12,COMM)) = 0;
Y.FX(EU15EU12,COMM,YEAR)$(NOT TRADED(EU15EU12,COMM) OR NOT tgtq('SUPPLY',EU15EU12,COMM,YEAR) OR NOT tgtq('TUSE',EU15EU12,COMM,YEAR) OR NOT tgtq('NETEXP',EU15EU12,COMM,YEAR)) = 0;
$offtext

* fix variable to zero if ESIM base value is zero:
S.FX(EU15EU12,COMM,YEAR)$(NOT base('SUPPLY',EU15EU12,comm)) = 0;
D.FX(EU15EU12,COMM,YEAR)$(NOT base('TUSE',EU15EU12,comm)) = 0;

*display S.LO, S.UP, D.LO, D.UP, X.LO, X.UP;



EQUATIONS
BALANCE(EU15EU12,COMM,YEAR) market balance
OBJ_MKT(EU15EU12,COMM,YEAR) market objective function
GLOBALOBJ                   global objective function
;

* MODEL:
*BALANCE(EU15EU12,COMM,YEAR)$(tgtq('SUPPLY',EU15EU12,COMM,YEAR) AND tgtq('TUSE',EU15EU12,COMM,YEAR) AND tgtq('NETEXP',EU15EU12,COMM,YEAR))..
BALANCE(EU15EU12,COMM,YEAR)..
         X(EU15EU12,COMM,YEAR) =E= S(EU15EU12,COMM,YEAR) - D(EU15EU12,COMM,YEAR);
*OBJ(EU15EU12,COMM,YEAR)$(TRADED(EU15EU12,COMM) AND tgtq('SUPPLY',EU15EU12,COMM,YEAR) AND tgtq('TUSE',EU15EU12,COMM,YEAR) AND tgtq('NETEXP',EU15EU12,COMM,YEAR))..
OBJ_MKT(EU15EU12,COMM,YEAR)..
         Y(EU15EU12,COMM,YEAR) =E=
                 POWER(S(EU15EU12,COMM,YEAR)/tgtq('SUPPLY',EU15EU12,COMM,YEAR)-1,2)$tgtq('SUPPLY',EU15EU12,COMM,YEAR)
                 + POWER(D(EU15EU12,COMM,YEAR)/tgtq('TUSE',EU15EU12,COMM,YEAR)-1,2)$tgtq('TUSE',EU15EU12,COMM,YEAR)
                 + POWER(X(EU15EU12,COMM,YEAR)/tgtq('NETEXP',EU15EU12,COMM,YEAR)-1,2)$tgtq('NETEXP',EU15EU12,COMM,YEAR);
GLOBALOBJ..
         Z =E= sum((EU15EU12,COMM,YEAR), Y(EU15EU12,COMM,YEAR));

MODEL MARKETBAL /BALANCE, OBJ_MKT, GLOBALOBJ/;

options limcol=50, limrow=50;
SOLVE MARKETBAL min Z using NLP;
display S.L, D.L, X.L;

* diagnostic tables
pcdev('SUPPLY',EU15EU12,COMM,YEAR)$(TRADED(EU15EU12,COMM) AND tgtq('SUPPLY',EU15EU12,COMM,YEAR)) = (S.L(EU15EU12,COMM,YEAR)/tgtq('SUPPLY',EU15EU12,COMM,YEAR)-1)*100;
pcdev('TUSE',EU15EU12,COMM,YEAR)$(TRADED(EU15EU12,COMM) AND tgtq('TUSE',EU15EU12,COMM,YEAR)) = (D.L(EU15EU12,COMM,YEAR)/tgtq('TUSE',EU15EU12,COMM,YEAR)-1)*100;
pcdev('NETEXP',EU15EU12,COMM,YEAR)$TRADED(EU15EU12,COMM) = (X.L(EU15EU12,COMM,YEAR)/tgtq('NETEXP',EU15EU12,COMM,YEAR)-1)*100;

pcdevoutma('SUPPLY',EU15EU12,COMM,YEAR)$pcdev('SUPPLY',EU15EU12,COMM,YEAR) = abs(pcdev('SUPPLY',EU15EU12,COMM,YEAR))-ma('SUPPLY',EU15EU12,COMM);
pcdevoutma('TUSE',EU15EU12,COMM,YEAR)$pcdev('TUSE',EU15EU12,COMM,YEAR) = abs(pcdev('TUSE',EU15EU12,COMM,YEAR))-ma('TUSE',EU15EU12,COMM);
pcdevoutma('NETEXP',EU15EU12,COMM,YEAR)$pcdev('NETEXP',EU15EU12,COMM,YEAR) = abs(pcdev('NETEXP',EU15EU12,COMM,YEAR))-ma('NETEXP',EU15EU12,COMM)/tgtq('NETEXP',EU15EU12,COMM,YEAR);
pcdevoutma(TGTSET,EU15EU12,COMM,YEAR)$(pcdevoutma(TGTSET,EU15EU12,COMM,YEAR)<0) = 0;

display pcdev, pcdevoutma;


SET IPOL_YRS(ALLPERIODS)   /2008*'%SIMY%' /;
* construct output table:
* interpolate years between base and 2020:
*target(TGTSET, CTRYGRP, COMM, YEAR) = tgt(TGTSET,CTRYGRP,COMM,YEAR);
target(TGTSET, CTRYGRP, COMM, IPOL_YRS)$(tgt(TGTSET,CTRYGRP,COMM,'%SIMY%') AND base(TGTSET,CTRYGRP,COMM) AND NOT sameas(TGTSET,'PW') ) =
   ( base(TGTSET,CTRYGRP,COMM) + ORD(IPOL_YRS) / CARD(IPOL_YRS) * (tgt(TGTSET,CTRYGRP,COMM,'%SIMY%')*base(TGTSET,CTRYGRP,COMM)-base(TGTSET,CTRYGRP,COMM) ) ) / base(TGTSET,CTRYGRP,COMM);
target('PW', 'ROW', COMM, IPOL_YRS)$tgt('PW','ROW',COMM,'%SIMY%') = 1 + ORD(IPOL_YRS) / CARD(IPOL_YRS) * (tgt('PW','ROW',COMM,'%SIMY%')-1);
target('SUPPLY', EU15EU12, COMM, IPOL_YRS)$S.L(EU15EU12,COMM,'%SIMY%') =
   ( base('SUPPLY',EU15EU12,COMM) + ORD(IPOL_YRS) / CARD(IPOL_YRS) * (S.L(EU15EU12,COMM,'%SIMY%')-base('SUPPLY',EU15EU12,COMM) ) ) / base('SUPPLY',EU15EU12,COMM);
target('TUSE', EU15EU12, COMM, IPOL_YRS)$D.L(EU15EU12,COMM,'%SIMY%') =
   ( base('TUSE',EU15EU12,COMM) + ORD(IPOL_YRS) / CARD(IPOL_YRS) * (D.L(EU15EU12,COMM,'%SIMY%')-base('TUSE',EU15EU12,COMM) ) ) / base('TUSE',EU15EU12,COMM);
target('NETEXP', EU15EU12, COMM, IPOL_YRS)$X.L(EU15EU12,COMM,'%SIMY%') =
   ( base('NETEXP',EU15EU12,COMM) + ORD(IPOL_YRS) / CARD(IPOL_YRS) * (X.L(EU15EU12,COMM,'%SIMY%')-base('NETEXP',EU15EU12,COMM) ) ) / base('NETEXP',EU15EU12,COMM);

parameter tgtchk(CTRYGRP, COMM, ALLPERIODS);
tgtchk(CTRYGRP, COMM, ALLPERIODS) = abs( target('SUPPLY', CTRYGRP, COMM, ALLPERIODS)*base('SUPPLY',CTRYGRP,COMM)
                                         -target('NETEXP', CTRYGRP, COMM, ALLPERIODS)*base('NETEXP',CTRYGRP,COMM)
                                         -target('TUSE', CTRYGRP, COMM, ALLPERIODS)*base('TUSE',CTRYGRP,COMM) ) ;

display tgtchk;
* deviation from the AGLINK trade direction:
tradedir_changed(EU15EU12,COMM,'%SIMY%')$ENFORCE_TRADEDIR(COMM) = target('NETEXP', EU15EU12, COMM, '%SIMY%')*base('NETEXP',EU15EU12,COMM)*outesimagg(EU15EU12,COMM,'NETEXP','%SIMY%')<0;

* aglink and esim data for comparison:
cmp('ESIM lvl',TGTSET,CTRYGRP,COMM,YEAR) = base(TGTSET,CTRYGRP,COMM)*target(TGTSET, CTRYGRP, COMM, YEAR);
cmp('ESIM lvl',TGTSET,CTRYGRP,COMM,'base')$sum(YEAR2,target(TGTSET, CTRYGRP, COMM, YEAR2)) = base(TGTSET,CTRYGRP,COMM);
cmp('CAPRI lvl',TGTSET,CTRYGRP,COMM,YEAR) = outesimagg(CTRYGRP,COMM,TGTSET,YEAR);
cmp('CAPRI lvl',TGTSET,CTRYGRP,COMM,'base') = outesimagg(CTRYGRP,COMM,TGTSET,'2006/07');

display target, pcdev, pcdevoutma, cmp, tradedir_changed;
execute_unload ".\output\target_input_balanced.gdx", target, pcdev, pcdevoutma, infeschk, tradedir_changed, cmp;

