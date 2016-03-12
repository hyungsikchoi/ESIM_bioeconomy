* reporting of calibration results
* comparison with AGLINK targets

$SETGLOBAL RAW_INPUT_FILE "../calibration_aglink_input.xls"

$ONMULTI
$ONEMPTY

$INCLUDE sets.gms


SETS
TGTSET           /SUPPLY, TUSE, NETEXP, PW, PD/
CTRYGRP          /EU15, EU12, OTHER, ROW, EU/
EUGRP(CTRYGRP)   /EU15, EU12, EU/
EU15EU12(EUGRP)  /EU15, EU12/
NONEU(cc)        non-EU countries set /WB, US, ROW/
NONEUeurope(cc)  european countries not in the EU set /TU, HR/
CTRYGRPMEM(CTRYGRP,cc) /EU15.set.EU15, EU12.set.EU12, EU.(set.EU15,set.EU12), ROW.(set.NONEU, set.NONEUeurope)/
SIM_BASE         /base, 2008*2020/
SIMRESSET        /SUPPLY, TUSE, HDEM, PDEM, SDEM, FDEM, FDEM_MLK, subs_milk_s, PW, PD, NETEXP, PD_euro/
SIMRESSET_Q(SIMRESSET) only quantity variables /SUPPLY, TUSE, HDEM, PDEM, SDEM, FDEM, FDEM_MLK, subs_milk_s, NETEXP/
;

ALIAS(SIM_BASE,SIM_BASE2);

PARAMETER
  alraw(*,*,*,*)                             raw AGLINK input data
  tgt(TGTSET,CTRYGRP,COMM,SIM_BASE)          target change (mixed) data
  tgtq(TGTSET,CTRYGRP,COMM,SIM_BASE)         target quantity data
  ma(TGTSET,CTRYGRP,COMM)                    margin of acceptance
  bound(SIM_BASE,CTRYGRP,*,COMM)             bounds on EU country group targets derived from ESIM quantities & AGLINK %changes & given MAs
  target(TGTSET, CTRYGRP, COMM, SIM_BASE)    final output targets data as changes from ESIM base year (multipliers)
  simres(SIMRESSET, ccplus, i, sim_base)      simulation results
  simrespch(SIMRESSET, ccplus, i, sim_base)   simulation results as percentage change from base
  simresagg(SIMRESSET, EUGRP, i, sim_base)    simulation results as percentage change from base
  simresaggpch(SIMRESSET, EUGRP, i, sim_base) simulation results as percentage change from base
  cmpres(*,SIMRESSET, CTRYGRP, COMM, SIM_BASE)   comparison of AGLINK target and calibrated ESIM data
;

$CALL GDXXRW.EXE "%RAW_INPUT_FILE%" par=alraw rng="Input data"! rdim=3 cdim=1 output="./aglink_input_raw.gdx"
$GDXIN "./aglink_input_raw.gdx"
$LOAD alraw
$GDXIN

$GDXIN "./simres.gdx"
$LOAD simres
$GDXIN

display alraw;

* all ESIM lvl PD prices are given in EUR terms, the PW is in USD terms
cmpres("ESIM lvl",SIMRESSET_Q,CTRYGRP,COMM,SIM_BASE) = sum(CTRYGRPMEM(CTRYGRP,CC), simres(SIMRESSET_Q,CC,COMM,SIM_BASE));
cmpres("ESIM lvl",'PD',EUGRP,COMM,SIM_BASE)$sum(CTRYGRPMEM(EUGRP,cc), simres('TUSE',CC,COMM,'base')) =
                 sum(CTRYGRPMEM(EUGRP,cc),simres('PD_euro',CC,COMM,SIM_BASE)*simres('TUSE',CC,COMM,'base'))
                 / sum(CTRYGRPMEM(EUGRP,cc),simres('TUSE',CC,COMM,'base'));
cmpres("ESIM lvl",'PW','ROW',COMM,SIM_BASE) = simres('PW','ROW',COMM,SIM_BASE);
cmpres("ESIM lvl",'PD','ROW',COMM,SIM_BASE) = simres('PD_euro','ROW',COMM,SIM_BASE);
cmpres("ESIM pch",SIMRESSET,CTRYGRP,COMM,SIM_BASE)$cmpres("ESIM lvl",SIMRESSET,CTRYGRP,COMM,'base') =
                 100*(cmpres("ESIM lvl",SIMRESSET,CTRYGRP,COMM,SIM_BASE)/cmpres("ESIM lvl",SIMRESSET,CTRYGRP,COMM,'base')-1);
cmpres("AGLINK pch",SIMRESSET,CTRYGRP,COMM,SIM_BASE)$(NOT sameas(SIM_BASE,'base')) = alraw(SIMRESSET,COMM,CTRYGRP,SIM_BASE);
cmpres("AGLINK pch",SIMRESSET,'ROW',COMM,SIM_BASE)$(NOT sameas(SIM_BASE,'base')) = alraw(SIMRESSET,COMM,'WORLD',SIM_BASE);
cmpres("AGLINK lvl",SIMRESSET,CTRYGRP,COMM,SIM_BASE)$(NOT sameas(SIM_BASE,'base')) =
                 (alraw(SIMRESSET,COMM,CTRYGRP,SIM_BASE)/100 + 1) * alraw(SIMRESSET,COMM,CTRYGRP,'base');
cmpres("AGLINK lvl",SIMRESSET,CTRYGRP,COMM,'base') =
                 alraw(SIMRESSET,COMM,CTRYGRP,'base');
cmpres("AGLINK lvl",SIMRESSET,'ROW',COMM,SIM_BASE)$(NOT sameas(SIM_BASE,'base')) =
                 (alraw(SIMRESSET,COMM,'WORLD',SIM_BASE)/100 + 1) * alraw(SIMRESSET,COMM,'WORLD','base');
cmpres("AGLINK lvl",SIMRESSET,'ROW',COMM,'base') =
                 alraw(SIMRESSET,COMM,'WORLD','base');
cmpres("AGLINK lvl",'NETEXP',CTRYGRP,COMM,SIM_BASE) = alraw('NETEXP',COMM,CTRYGRP,SIM_BASE);
cmpres("AGLINK pch",'NETEXP',CTRYGRP,COMM,SIM_BASE)$(alraw('NETEXP',COMM,CTRYGRP,'base') AND (NOT sameas(SIM_BASE,'base')) )
         = 100*(alraw('NETEXP',COMM,CTRYGRP,SIM_BASE)/alraw('NETEXP',COMM,CTRYGRP,'base')-1);

* diff lvl = ESIM level - AGLINK level
* diff pch = ESIM %change to base - AGLINK %change to base
cmpres('diff pch',SIMRESSET,CTRYGRP,COMM,SIM_BASE)$( sum(SIM_BASE2,cmpres("AGLINK pch",SIMRESSET,CTRYGRP,COMM,SIM_BASE2)<>0) AND (NOT sameas(SIM_BASE,'base')) )
         = cmpres("ESIM pch",SIMRESSET,CTRYGRP,COMM,SIM_BASE) - cmpres("AGLINK pch",SIMRESSET,CTRYGRP,COMM,SIM_BASE) + EPS;
cmpres('diff lvl',SIMRESSET,CTRYGRP,COMM,SIM_BASE)$sum(SIM_BASE2,cmpres("AGLINK lvl",SIMRESSET,CTRYGRP,COMM,SIM_BASE2)<>0)
         = cmpres("ESIM lvl",SIMRESSET,CTRYGRP,COMM,SIM_BASE) - cmpres("AGLINK lvl",SIMRESSET,CTRYGRP,COMM,SIM_BASE) + EPS;

execute_unload "cmpres.gdx" cmpres;

display cmpres;
