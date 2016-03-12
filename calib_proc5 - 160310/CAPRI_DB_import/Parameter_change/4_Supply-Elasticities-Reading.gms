$include "4_Supply-Elasticities-declarations.gms"

*$ontext
*$libinclude xlimport sigma  excel_data\SUPPLY.xls Allen!A1:Y24

$call gdxxrw excel_data\SUPPLY.xls  par=sigma   rng=Allen!A34:X57
$GDXIN SUPPLY.gdx
$LOAD sigma
$GDXIN

*$libinclude xlimport sigma   excel_data\SUPPLY.xls newallen

*display sigma;

$stop

*$exit
*$libinclude xlimport elast_yield  ..\data\SUPPLY-Elasticities.xls elast_yield
parameter
PINC00(c,fi)
PP00(c,fi)
;

$GDXin data_prices_100618
$load PINC00 PP00
$GDXin

$libinclude xlimport supply  ..\data\SUPPLY-Elasticities.xls production
$libinclude xlimport price   ..\data\SUPPLY-Elasticities.xls prices
*$libinclude xlimport dirpay  ..\data\SUPPLY-Elasticities.xls direct
*parameter
*DP_coupled(farm,c);
*$libinclude xlimport DP_coupled  ..\data\SUPPLY-Elasticities.xls direct_coupled

* Calculation of allocation effective direct payment for roughages  - 20% or 40%
PINC00(e,fed)$area(fed,e) = price(fed,e) + areapay(e) * exrate('GE') / exrate(e) / supply(fed,e) * area(fed,e) * .2 ;
PP00(e,fed)$area(fed,e) = price(fed,e)+ areapay(e) * exrate('GE') / exrate(e) / supply(fed,e) * area(fed,e) * .2;
price(farm,c) = MAX(PP00(c,farm),PINC00(c,farm));


* IMPORT OF AREA ALLOCATION ELASTICITIES - Start values for own price and factor price elasticities
Parameters
el_area_AT (i,fi)
el_area_BE (i,fi)
el_area_DK (i,fi)
el_area_FI (i,fi)
el_area_FR (i,fi)
el_area_GE (i,fi)
el_area_GR (i,fi)
el_area_IE (i,fi)
el_area_IT (i,fi)
el_area_NL (i,fi)
el_area_PT (i,fi)
el_area_ES (i,fi)
el_area_SW (i,fi)
el_area_UK (i,fi)
el_area_LV (i,fi)
el_area_RO (i,fi)
el_area_SI (i,fi)
el_area_LT (i,fi)
el_area_BG (i,fi)
el_area_PL (i,fi)
el_area_HU (i,fi)
el_area_CZ (i,fi)
el_area_SK (i,fi)
el_area_EE (i,fi)
el_area_CY (i,fi)
el_area_MT (i,fi)
el_area_TU (i,fi)
el_area_US (i,fi)
el_area_ROW(i,fi)
;

$libinclude xlimport el_area_AT  ..\data\SUPPLY-Elasticities.xls el_area_AT_old
$libinclude xlimport el_area_BE  ..\data\SUPPLY-Elasticities.xls el_area_BE_old
$libinclude xlimport el_area_DK  ..\data\SUPPLY-Elasticities.xls el_area_DK_old
$libinclude xlimport el_area_FI  ..\data\SUPPLY-Elasticities.xls el_area_FI_old
$libinclude xlimport el_area_FR  ..\data\SUPPLY-Elasticities.xls el_area_FR_old
$libinclude xlimport el_area_GE  ..\data\SUPPLY-Elasticities.xls el_area_GE_old
$libinclude xlimport el_area_GR  ..\data\SUPPLY-Elasticities.xls el_area_GR_old
$libinclude xlimport el_area_IE  ..\data\SUPPLY-Elasticities.xls el_area_IE_old
$libinclude xlimport el_area_IT  ..\data\SUPPLY-Elasticities.xls el_area_IT_old
$libinclude xlimport el_area_NL  ..\data\SUPPLY-Elasticities.xls el_area_NL_old
$libinclude xlimport el_area_PT  ..\data\SUPPLY-Elasticities.xls el_area_PT_old
$libinclude xlimport el_area_ES  ..\data\SUPPLY-Elasticities.xls el_area_ES_old
$libinclude xlimport el_area_SW  ..\data\SUPPLY-Elasticities.xls el_area_SW_old
$libinclude xlimport el_area_UK  ..\data\SUPPLY-Elasticities.xls el_area_UK_old
$libinclude xlimport el_area_LV  ..\data\SUPPLY-Elasticities.xls el_area_LV_old
$libinclude xlimport el_area_RO  ..\data\SUPPLY-Elasticities.xls el_area_RO_old
$libinclude xlimport el_area_SI  ..\data\SUPPLY-Elasticities.xls el_area_SI_old
$libinclude xlimport el_area_LT  ..\data\SUPPLY-Elasticities.xls el_area_LT_old
$libinclude xlimport el_area_BG  ..\data\SUPPLY-Elasticities.xls el_area_BG_old
$libinclude xlimport el_area_PL  ..\data\SUPPLY-Elasticities.xls el_area_PL_old
$libinclude xlimport el_area_HU  ..\data\SUPPLY-Elasticities.xls el_area_HU_old
$libinclude xlimport el_area_CZ  ..\data\SUPPLY-Elasticities.xls el_area_CZ_old
$libinclude xlimport el_area_SK  ..\data\SUPPLY-Elasticities.xls el_area_SK_old
$libinclude xlimport el_area_EE  ..\data\SUPPLY-Elasticities.xls el_area_EE_old
$libinclude xlimport el_area_CY  ..\data\SUPPLY-Elasticities.xls el_area_CY_old
$libinclude xlimport el_area_MT  ..\data\SUPPLY-Elasticities.xls el_area_MT_old
$libinclude xlimport el_area_TU  ..\data\SUPPLY-Elasticities.xls el_area_TU_old
$libinclude xlimport el_area_US  ..\data\SUPPLY-Elasticities.xls el_area_US_old
$libinclude xlimport el_area_ROW ..\data\SUPPLY-Elasticities.xls el_area_ROW_old

el_area0("AT",farm,j)  = el_area_AT(farm,j) ;
el_area0("BE",farm,j)  = el_area_BE(farm,j) ;
el_area0("DK",farm,j)  = el_area_DK(farm,j) ;
el_area0("FI",farm,j)  = el_area_FI(farm,j) ;
el_area0("FR",farm,j)  = el_area_FR(farm,j) ;
el_area0("GE",farm,j)  = el_area_GE(farm,j) ;
el_area0("GR",farm,j)  = el_area_GR(farm,j) ;
el_area0("IE",farm,j)  = el_area_IE(farm,j) ;
el_area0("IT",farm,j)  = el_area_IT(farm,j) ;
el_area0("NL",farm,j)  = el_area_NL(farm,j) ;
el_area0("PT",farm,j)  = el_area_PT(farm,j) ;
el_area0("ES",farm,j)  = el_area_ES(farm,j) ;
el_area0("SW",farm,j)  = el_area_SW(farm,j) ;
el_area0("UK",farm,j)  = el_area_UK(farm,j) ;
el_area0("ee",farm,j)  = el_area_ee(farm,j) ;
el_area0("lv",farm,j)  = el_area_lv(farm,j) ;
el_area0("ro",farm,j)  = el_area_ro(farm,j) ;
el_area0("si",farm,j)  = el_area_si(farm,j) ;
el_area0("lt",farm,j)  = el_area_lt(farm,j) ;
el_area0("bg",farm,j)  = el_area_bg(farm,j) ;
el_area0("pl",farm,j)  = el_area_pl(farm,j) ;
el_area0("hu",farm,j)  = el_area_hu(farm,j) ;
el_area0("cz",farm,j)  = el_area_cz(farm,j) ;
el_area0("sk",farm,j)  = el_area_sk(farm,j) ;
el_area0("cy",farm,j)  = el_area_cy(farm,j) ;
el_area0("mt",farm,j)  = el_area_mt(farm,j) ;
el_area0("tu",farm,j)  = el_area_tu(farm,j) ;
el_area0("us",farm,j)  = el_area_us(farm,j) ;
el_area0("row",farm,j)  = el_area_row(farm,j) ;

el_area0("AT",farm,farm)  = el_area_AT(farm,"own") ;
el_area0("BE",farm,farm)  = el_area_BE(farm,"own") ;
el_area0("DK",farm,farm)  = el_area_DK(farm,"own") ;
el_area0("FI",farm,farm)  = el_area_FI(farm,"own") ;
el_area0("FR",farm,farm)  = el_area_FR(farm,"own") ;
el_area0("GE",farm,farm)  = el_area_GE(farm,"own") ;
el_area0("GR",farm,farm)  = el_area_GR(farm,"own") ;
el_area0("IE",farm,farm)  = el_area_IE(farm,"own") ;
el_area0("IT",farm,farm)  = el_area_IT(farm,"own") ;
el_area0("NL",farm,farm)  = el_area_NL(farm,"own") ;
el_area0("PT",farm,farm)  = el_area_PT(farm,"own") ;
el_area0("ES",farm,farm)  = el_area_ES(farm,"own") ;
el_area0("SW",farm,farm)  = el_area_SW(farm,"own") ;
el_area0("UK",farm,farm)  = el_area_UK(farm,"own") ;
el_area0("ee",farm,farm)  = el_area_ee(farm,"own") ;
el_area0("lv",farm,farm)  = el_area_lv(farm,"own") ;
el_area0("ro",farm,farm)  = el_area_ro(farm,"own") ;
el_area0("si",farm,farm)  = el_area_si(farm,"own") ;
el_area0("lt",farm,farm)  = el_area_lt(farm,"own") ;
el_area0("bg",farm,farm)  = el_area_bg(farm,"own") ;
el_area0("pl",farm,farm)  = el_area_pl(farm,"own") ;
el_area0("hu",farm,farm)  = el_area_hu(farm,"own") ;
el_area0("cz",farm,farm)  = el_area_cz(farm,"own") ;
el_area0("sk",farm,farm)  = el_area_sk(farm,"own") ;
el_area0("cy",farm,farm)  = el_area_cy(farm,"own") ;
el_area0("mt",farm,farm)  = el_area_mt(farm,"own") ;
el_area0("tu",farm,farm)  = el_area_tu(farm,"own") ;
el_area0("us",farm,farm)  = el_area_us(farm,"own") ;
el_area0("row",farm,farm)  = el_area_row(farm,"own") ;




* IMPORT OF FEED RATES - for calculation of value share of feed cost
parameter
fedrat_AT(f,livest)
fedrat_BE(f,livest)
fedrat_DK(f,livest)
fedrat_FI(f,livest)
fedrat_FR(f,livest)
fedrat_GE(f,livest)
fedrat_GR(f,livest)
fedrat_IE(f,livest)
fedrat_IT(f,livest)
fedrat_NL(f,livest)
fedrat_PT(f,livest)
fedrat_ES(f,livest)
fedrat_SW(f,livest)
fedrat_UK(f,livest)
fedrat_lv(f,livest)
fedrat_ro(f,livest)
fedrat_si(f,livest)
fedrat_lt(f,livest)
fedrat_bg(f,livest)
fedrat_pl(f,livest)
fedrat_hu(f,livest)
fedrat_cz(f,livest)
fedrat_sk(f,livest)
fedrat_ee(f,livest)
fedrat_cy(f,livest)
fedrat_mt(f,livest)
fedrat_tu(f,livest)
fedrat_hr(f,livest)
fedrat_wb(f,livest)
fedrat_us(f,livest)
fedrat_row(f,livest)
;

$libinclude xlimport fedrat_AT  ..\data\SUPPLY-Elasticities.xls fed_AT
$libinclude xlimport fedrat_BE  ..\data\SUPPLY-Elasticities.xls fed_BE
$libinclude xlimport fedrat_DK  ..\data\SUPPLY-Elasticities.xls fed_DK
$libinclude xlimport fedrat_FI  ..\data\SUPPLY-Elasticities.xls fed_FI
$libinclude xlimport fedrat_FR  ..\data\SUPPLY-Elasticities.xls fed_FR
$libinclude xlimport fedrat_GE  ..\data\SUPPLY-Elasticities.xls fed_GE
$libinclude xlimport fedrat_GR  ..\data\SUPPLY-Elasticities.xls fed_GR
$libinclude xlimport fedrat_IE  ..\data\SUPPLY-Elasticities.xls fed_IE
$libinclude xlimport fedrat_IT  ..\data\SUPPLY-Elasticities.xls fed_IT
$libinclude xlimport fedrat_NL  ..\data\SUPPLY-Elasticities.xls fed_NL
$libinclude xlimport fedrat_PT  ..\data\SUPPLY-Elasticities.xls fed_PT
$libinclude xlimport fedrat_ES  ..\data\SUPPLY-Elasticities.xls fed_ES
$libinclude xlimport fedrat_SW  ..\data\SUPPLY-Elasticities.xls fed_SW
$libinclude xlimport fedrat_UK  ..\data\SUPPLY-Elasticities.xls fed_UK
$libinclude xlimport fedrat_ee  ..\data\SUPPLY-Elasticities.xls fed_ee
$libinclude xlimport fedrat_lv  ..\data\SUPPLY-Elasticities.xls fed_lv
$libinclude xlimport fedrat_ro  ..\data\SUPPLY-Elasticities.xls fed_ro
$libinclude xlimport fedrat_si  ..\data\SUPPLY-Elasticities.xls fed_si
$libinclude xlimport fedrat_lt  ..\data\SUPPLY-Elasticities.xls fed_lt
$libinclude xlimport fedrat_bg  ..\data\SUPPLY-Elasticities.xls fed_bg
$libinclude xlimport fedrat_pl  ..\data\SUPPLY-Elasticities.xls fed_pl
$libinclude xlimport fedrat_hu  ..\data\SUPPLY-Elasticities.xls fed_hu
$libinclude xlimport fedrat_cz  ..\data\SUPPLY-Elasticities.xls fed_cz
$libinclude xlimport fedrat_sk  ..\data\SUPPLY-Elasticities.xls fed_sk
$libinclude xlimport fedrat_cy  ..\data\SUPPLY-Elasticities.xls fed_cy
$libinclude xlimport fedrat_mt  ..\data\SUPPLY-Elasticities.xls fed_mt
$libinclude xlimport fedrat_tu  ..\data\SUPPLY-Elasticities.xls fed_tu
$libinclude xlimport fedrat_hr  ..\data\SUPPLY-Elasticities.xls fed_hr
$libinclude xlimport fedrat_wb  ..\data\SUPPLY-Elasticities.xls fed_wb
$libinclude xlimport fedrat_us  ..\data\SUPPLY-Elasticities.xls fed_us
$libinclude xlimport fedrat_row  ..\data\SUPPLY-Elasticities.xls fed_row

feedrate0("AT",f,livest)  = fedrat_AT(f,livest) ;
feedrate0("BE",f,livest)  = fedrat_BE(f,livest) ;
feedrate0("DK",f,livest)  = fedrat_DK(f,livest) ;
feedrate0("FI",f,livest)  = fedrat_FI(f,livest) ;
feedrate0("FR",f,livest)  = fedrat_FR(f,livest) ;
feedrate0("GE",f,livest)  = fedrat_GE(f,livest) ;
feedrate0("GR",f,livest)  = fedrat_GR(f,livest) ;
feedrate0("IE",f,livest)  = fedrat_IE(f,livest) ;
feedrate0("IT",f,livest)  = fedrat_IT(f,livest) ;
feedrate0("NL",f,livest)  = fedrat_NL(f,livest) ;
feedrate0("PT",f,livest)  = fedrat_PT(f,livest) ;
feedrate0("ES",f,livest)  = fedrat_ES(f,livest) ;
feedrate0("SW",f,livest)  = fedrat_SW(f,livest) ;
feedrate0("UK",f,livest)  = fedrat_UK(f,livest) ;
feedrate0("ee",f,livest)  = fedrat_ee(f,livest) ;
feedrate0("lv",f,livest)  = fedrat_lv(f,livest) ;
feedrate0("ro",f,livest)  = fedrat_ro(f,livest) ;
feedrate0("si",f,livest)  = fedrat_si(f,livest) ;
feedrate0("lt",f,livest)  = fedrat_lt(f,livest) ;
feedrate0("bg",f,livest)  = fedrat_bg(f,livest) ;
feedrate0("pl",f,livest)  = fedrat_pl(f,livest) ;
feedrate0("hu",f,livest)  = fedrat_hu(f,livest) ;
feedrate0("cz",f,livest)  = fedrat_cz(f,livest) ;
feedrate0("sk",f,livest)  = fedrat_sk(f,livest) ;
feedrate0("cy",f,livest)  = fedrat_cy(f,livest) ;
feedrate0("mt",f,livest)  = fedrat_mt(f,livest) ;
feedrate0("tu",f,livest)  = fedrat_tu(f,livest) ;
feedrate0("hr",f,livest)  = fedrat_hr(f,livest) ;
feedrate0("wb",f,livest)  = fedrat_wb(f,livest) ;
feedrate0("us",f,livest)  = fedrat_us(f,livest) ;
feedrate0("row",f,livest)  = fedrat_row(f,livest) ;

execute_unload 'supply_read.gdx';
