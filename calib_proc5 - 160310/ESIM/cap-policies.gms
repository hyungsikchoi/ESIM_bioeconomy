Parameter
exog_biof(one);
exog_biof(one) = 0;

Parameter
pol_set_floor
pol_set_thresh
pol_set_tariff
;

*TABLE  pol_set_(comm,sim)   Type of price formation
*3=treshold
*1=tariff
*2= floor
pol_set_floor(comm,sim)$(pol_set_(comm,sim) eq 2)   = 1;
pol_set_thresh(comm,sim)$(pol_set_(comm,sim) eq 3)  = 1;
pol_set_tariff(comm,sim)$(pol_set_(comm,sim) eq 1)  = 1;



pol_set(comm,sim,"floor")   = pol_set_floor(comm,sim);
pol_set(comm,sim,"thresh")  = pol_set_thresh(comm,sim);
pol_set(comm,sim,"tariff")  = pol_set_tariff(comm,sim);


display pol_set;

FLOOR(IT) = YES$(POL_SET(it,"base","FLOOR"));

*============puls trade policy (HS)
FLOOR('puls') =yes;
FLOOR('othdairy')=yes;





THRESH(IT) = YES$(POL_SET(it,"base","THRESH"));
TAR(IT) = YES$(POL_SET(it,"base","TARIFF")or sameas(IT,'OENERGY') OR sameas(IT,'OPROT'));
*TAR(IT) = YES$();


display TAR;


* <%INPUT%>
TABLE  prod_effdp(comm,effdp_ST_)   Effectiveness of direct payments
            effdp
CWHEAT      0.2
*DURUM       0.2
***new item from CAPRI puls
LINO        0.2
PULS        0.2
BARLEY      0.2
CORN        0.2
RYE         0.2
OTHGRA      0.2
RICE        0.2
SUGAR       0.2
POTATO      0.2
SOYBEAN     0.2
RAPSEED     0.2
SUNSEED     0.2
SMAIZE      0.2
FODDER      0.2
GRAS        0.2
SETASIDE    0.2
MILK        0.8
BEEF        0.8
SHEEP       0.8
PORK        0.8
POULTRY     0.8
EGGS        0.8
;
* <%FORMAT ###,##0%>
* <%USERLEVEL 3%>
* <%BOUNDS%>
* *.* 0  1
* <%ENDBOUNDS%>
* <%NONEDIT%>
* *.effdp
* <%ENDNONEDIT%>

* 0 = not effective
* 1 = fully effective
* <%ENDINFO%>
* <%/INPUT%>


* <%INPUT%>
TABLE  DP_POLS(cc,POLS_ST_) Implementation of setaside policies in BASE
           AG2000   MTR
CY         0.0      1.0
CZ         0.0      1.0
EE         0.0      1.0
HU         0.0      1.0
LV         0.0      1.0
LT         0.0      1.0
PL         0.0      1.0
SK         0.0      1.0
RO         0.0      1.0
BG         0.0      1.0
MT         0.0      0.0
SI         0.0      0.0
AT         1.0      0.0
BE         1.0      0.0
DK         1.0      0.0
FI         1.0      0.0
FR         1.0      0.0
GE         1.0      0.0
GR         1.0      0.0
IE         1.0      0.0
IT         1.0      0.0
NL         1.0      0.0
PT         1.0      0.0
ES         1.0      0.0
SW         1.0      0.0
UK         1.0      0.0
;
* <%FORMAT ###,##0.##%>
* <%/INPUT%>


*TABLE  bound_tar(bound_comm,tar_st_)   Applied specific tariffs for cereal products
Parameter
bound_tar_cc;
bound_tar_cc(cc,bound_comm,tar_st_)=bound_tar(bound_comm,tar_st_);



defl_pol(cc,sim_base) = deflation(cc,sim_base);


* <%INPUT%>
TABLE  membership(cc,sim) Year of membership
*    BASE 2008 2009 2010 2011 2012 2013 2014 2015 2016 2017 2018 2019 2020 2021 2022 2023 2024 2025 2026 2027 2028 2029 2030
*GE  1.0  1.0  1.0  1.0  1.0  1.0  1.0  1.0  1.0  1.0  1.0  1.0  1.0  1.0  1.0  1.0  1.0  1.0  1.0  1.0  1.0  1.0  1.0  1.0
*TU  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0
*HR  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0
*;
    BASE 2009 2010 2011 2012 2013 2014 2015 2016 2017 2018 2019 2020 2021 2022 2023 2024 2025 2026 2027 2028 2029 2030
GE  1.0  1.0  1.0  1.0  1.0  1.0  1.0  1.0  1.0  1.0  1.0  1.0  1.0  1.0  1.0  1.0  1.0  1.0  1.0  1.0  1.0  1.0  1.0
TU  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0
HR  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0
;

* <%FORMAT ###,##0%>
* <%USERLEVEL 2%>
* <%BOUNDS%>
* *.* 0  1 BOOLEAN
* <%ENDBOUNDS%>
* <%NONEDIT%>
* *.(base,2010)
* <%ENDNONEDIT%>

* 0 = No member
* 1 = member
* <%ENDINFO%>
* <%/INPUT%>

set extent_memb(sim) /2031*2050/;

membership(cc,extent_memb) = membership(cc,"2030");

membership(EU27,sim) = membership('GE',sim);



$ontext
Table cp_EU15(cp_st_,ccplus) Base yield and set-aside data EU-15
            AT      BE     DK     FI     FR    GE    GR     IE    IT    NL    PT     ES      SW     UK   SI   MT
efsetas_    103     28     217    172   1541  1165   30     32    261   19    90    1442     256    668
vol_set     33       3     39     90     342   326   20      8    44     4    46     688     132    265
marg_land  0.4     0.4    0.4    0.05   0.5   0.5   0.05   0.3   0.05  0.6   0.05   0.05    0.4    0.5
;
$offtext

* <%INPUT%>
Table cp_EU15(cp_st_,ccplus) Base yield and set-aside data EU-15
            AT      BE     DK     FI     FR    GE    GR     IE    IT    NL    PT     ES      SW     UK
efsetas_    64      22     149    204    1088  585   144     5    230   15    117    1045    279    286
vol_set      9       4     57     147    688   378   56      2    49    3     95     468     229    104
marg_land  0.4     0.4    0.4    0.05    0.5   0.5   0.05   0.3   0.05  0.6   0.05   0.05    0.4    0.5
;
* <%FORMAT #,###,##0.###%>
* <%/INPUT%>

$ontext
Table cp_old(cp_st_,ccplus) Base yield and set-aside data EU aggregate and NMS
           EU      PL     HU     EE     LV    LT    SI     CZ    SK    BG    RO     CY    MT    HR      TU
efsetas_   6024    100     50    17      2    2      2      2     2     2     2      2    2
vol_set    2040    100     50    17      2    2      2      2     2     2     2      2    2
marg_land  0.700   1.000  1.000  1.000  1.000 1.000 1.000  1.000 1.000 1.000 1.000  1.000 1.000 1.000   1.000
;
$offtext

* <%INPUT%>
Table cp_old(cp_st_,ccplus) Base yield and set-aside data EU aggregate and NMS
           EU      PL     HU     EE     LV    LT    SI     CZ    SK    BG    RO     CY    MT    HR      TU
efsetas_   6589    160    13     17     62    108   1      10    12    1     167    15    0.5
vol_set    2605    160    13     17     62    108   1      10    12    1     167    15    0.5
marg_land  0.700   1.000  1.000  1.000  1.000 1.000 1.000  1.000 1.000 1.000 1.000  1.000 1.000 1.000   1.000
;
* <%FORMAT #,###,##0.###%>
* <%/INPUT%>

set
setastest(cc) used for assigning initial DP for setaside in EU12 /
EE
lv
lt
si
cz
sk
bg
ro
cy
mt
/;


marg_land(eu15) = cp_EU15('marg_land',eu15);
marg_land(eu12) = cp_old('marg_land',eu12);
marg_land(cand) = cp_old('marg_land',cand);

chg_oblsetas(one) = 0.0;

cp(cp_st_,ccplus)$ (cc(ccplus) and not old_EU15(ccplus))  = cp_old(cp_st_,ccplus);
cp(cp_st_,ccplus)$ old_EU15(ccplus) = cp_EU15(cp_st_,ccplus);

cp("efsetas_","EU") = cp_old("efsetas_","EU") - SUM (ccplus $ old_EU15(ccplus), cp_EU15("efsetas_",ccplus));
cp("vol_set","EU") = cp_old("vol_set","EU") - SUM (ccplus $ old_Eu15(ccplus), cp_EU15("vol_set",ccplus));



TABLE  chg_delay(delay_c,sim) Reduction of single market prices due to delayed integration
*          BASE       2008     2009     2010     2011     2012     2013     2014     2015     2016     2017     2018     2019     2020     2021     2022     2023     2024     2025     2026     2027     2028     2029     2030
*"CWHEAT"  1.000      1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000
*"CORN"    1.000      1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000
*"BARLEY"  1.000      1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000
*"RYE"     1.000      1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000
*"OTHGRA"  1.000      1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000
*;
          BASE        2009     2010     2011     2012     2013     2014     2015     2016     2017     2018     2019     2020     2021     2022     2023     2024     2025     2026     2027     2028     2029     2030
"CWHEAT"  1.000       1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000
"CORN"    1.000       1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000
"BARLEY"  1.000       1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000
"RYE"     1.000       1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000
"OTHGRA"  1.000       1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000    1.000
;

* Reduction of single market pices due to delayed integration
* 1.00 = no reduction and fully integrated into Single European Market
* Attention! The set delay_r(cc) is emptied in the current version at the end of set.gms.

chg_delay(delay_c,time_cal) = chg_delay(delay_c,"2030");


*<%INPUT%>
TABLE  biofuel_premia(sim,premia_st_) Total eligible premia for biofuels in Mill EUR
       "PREMIA"
BASE   67.5
*2008   90.0
2009   67.5
*2009   90.0
2010   0.0
2011   0.0
2012   0.0
2013   0.0
2014   0.0
2015   0.0
2016   0.0
2017   0.0
2018   0.0
2019   0.0
2020   0.0
2021   0.0
2022   0.0
2023   0.0
2024   0.0
2025   0.0
2026   0.0
2027   0.0
2028   0.0
2029   0.0
2030   0.0
;
* <%FORMAT ###,##0.###%>
* <%USERLEVEL 2%>
* <%/INPUT%>


newmember(c) = 0.0;

MEMBER(ONE)   =    YES$(MEMBERSHIP(ONE,"BASE") EQ 1);
NOMEMBER(ONE) =    YES$(MEMBERSHIP(ONE,"BASE") EQ 0.0);
NMS(ONE)      =    YES$(NEWMEMBER(ONE) EQ 1);



*<%INPUT%>
TABLE  psh_mlk(cc,comm) Shadow price for milk in the EU-15
          MILK
AT        0.90
BE        0.76
DK        0.88
FI        1.00
FR        1.00
GE        1.00
GR        1.00
IE        0.80
IT        1.00
NL        0.59
PT        1.00
ES        1.00
SW        1.00
UK        1.00
;
* <%FORMAT ###,##0.###%>
* <%USERLEVEL 2%>

* Source: Paolo Sckokai "Do estimated quota rents reflect the competitiveness of the EU dairy industry?" (Presentation); Long-run Cost.
*     +IPTS (Nov 2011)
* <%ENDINFO%>
* <%BOUNDS%>
* *.* 0  1
* <%ENDBOUNDS%>
* <%/INPUT%>

psh_mlk(eu12,"MILK") = 1;




$ontext
* ---- chg_int_ann is not used anymore ----
* <%INPUT%>
TABLE  chg_int_ann(comm,sim)  Non linear changes in intervention prices w.r. to previous period
* annual change w.r. to previous (!!!) period's level
           BASE 2008 2009 2010 2011 2012 2013 2014 2015 2016 2017 2018 2019 2020 2021 2022 2023 2024 2025 2026 2027 2028 2029 2030
RICE         0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0
SMP          0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0
BUTTER       0   -5    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0
CWHEAT       0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0
DURUM        0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0
BARLEY       0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0
CORN         0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0
RYE          0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0
SUGAR        0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0
;
* <%FORMAT ###,##0.##%>
* <%USERLEVEL 99999 hide%>
* <%BOUNDS%>
* *.* -100  100
* <%ENDBOUNDS%>
* <%NONEDIT%>
* *.(base,2008,2009)
* <%ENDNONEDIT%>
* <%/INPUT%>
$offtext


dp_change("GE",comm,sim_base) = dpchg_GE(comm,sim_base);
dp_change("AT",comm,sim_base) = dpchg_AT(comm,sim_base);
dp_change("BE",comm,sim_base) = dpchg_BE(comm,sim_base);
dp_change("DK",comm,sim_base) = dpchg_DK(comm,sim_base);
dp_change("FI",comm,sim_base) = dpchg_FI(comm,sim_base);
dp_change("FR",comm,sim_base) = dpchg_FR(comm,sim_base);
dp_change("GR",comm,sim_base) = dpchg_GR(comm,sim_base);
dp_change("IE",comm,sim_base) = dpchg_IE(comm,sim_base);
dp_change("IT",comm,sim_base) = dpchg_IT(comm,sim_base);
dp_change("NL",comm,sim_base) = dpchg_NL(comm,sim_base);
dp_change("PT",comm,sim_base) = dpchg_PT(comm,sim_base);
dp_change("ES",comm,sim_base) = dpchg_ES(comm,sim_base);
dp_change("SW",comm,sim_base) = dpchg_SW(comm,sim_base);
dp_change("UK",comm,sim_base) = dpchg_UK(comm,sim_base);
dp_change("SI",comm,sim_base) = dpchg_SI(comm,sim_base);

art_change("GE",comm,sim_base) = artchg_GE(comm,sim_base);
art_change("AT",comm,sim_base) = artchg_AT(comm,sim_base);
art_change("BE",comm,sim_base) = artchg_BE(comm,sim_base);
art_change("DK",comm,sim_base) = artchg_DK(comm,sim_base);
art_change("FI",comm,sim_base) = artchg_FI(comm,sim_base);
art_change("FR",comm,sim_base) = artchg_FR(comm,sim_base);
art_change("GR",comm,sim_base) = artchg_GR(comm,sim_base);
art_change("IE",comm,sim_base) = artchg_IE(comm,sim_base);
art_change("IT",comm,sim_base) = artchg_IT(comm,sim_base);
art_change("NL",comm,sim_base) = artchg_NL(comm,sim_base);
art_change("PT",comm,sim_base) = artchg_PT(comm,sim_base);
art_change("ES",comm,sim_base) = artchg_ES(comm,sim_base);
art_change("SW",comm,sim_base) = artchg_SW(comm,sim_base);
art_change("UK",comm,sim_base) = artchg_UK(comm,sim_base);

art_change("BG",comm,sim_base) = artchg_BG(comm,sim_base);
art_change("RO",comm,sim_base) = artchg_RO(comm,sim_base);
art_change("PL",comm,sim_base) = artchg_PL(comm,sim_base);
art_change("CY",comm,sim_base) = artchg_CY(comm,sim_base);
art_change("CZ",comm,sim_base) = artchg_CZ(comm,sim_base);
art_change("EE",comm,sim_base) = artchg_EE(comm,sim_base);
art_change("HU",comm,sim_base) = artchg_HU(comm,sim_base);
art_change("LV",comm,sim_base) = artchg_LV(comm,sim_base);
art_change("LT",comm,sim_base) = artchg_LT(comm,sim_base);
art_change("MT",comm,sim_base) = artchg_MT(comm,sim_base);
art_change("SK",comm,sim_base) = artchg_SK(comm,sim_base);
art_change("SI",comm,sim_base) = artchg_SI(comm,sim_base);




Artificial_value(cc)=1000;



sugar_compensation(cc,sim_base) = sugar_envelop(cc,sim_base);



parameter
abs_setas_area(cc,sim) Oligatory setaside area (in Mill. ha)
;

*andresetas
*$GDXin 'SETAS.gdx'
*$load abs_setas_area
*$GDXIN
abs_setas_area(eu15,sim) = 0;
abs_setas_area(eu15,"base") = (cp("efsetas_",eu15) - cp("vol_set",eu15))/scaler;

abs_setas_area(eu15,"base")=0;


*<%INPUT%>
Table adj_rec_1(cc,ag) Weighting factors in recursive model stucture for the t-1 period
     CWHEAT PULS   BARLEY CORN   RYE  OTHGRA   RICE  SUGAR POTATO SOYBEAN RAPSEED SUNSEED   SMAIZE FODDER GRAS  SETASIDE   MILK  BEEF  SHEEP PORK  POULTRY  EGGS  PALMOIL
GE   0.0    0.0    0.0    0.0    0.0     0.0    0.0    0.0  0.0     0.0    0.0    0.0        0.0    0.0    0.0   0.0        0.0  0.0    0.0   0.0   0.0      0.0   0.0
AT   0.0    0.0    0.0    0.0    0.0     0.0    0.0    0.0  0.0     0.0    0.0    0.0        0.0    0.0    0.0   0.0        0.0  0.0    0.0   0.0   0.0      0.0   0.0
BE   0.0    0.0    0.0    0.0    0.0     0.0    0.0    0.0  0.0     0.0    0.0    0.0        0.0    0.0    0.0   0.0        0.0  0.0    0.0   0.0   0.0      0.0   0.0
DK   0.0    0.0    0.0    0.0    0.0     0.0    0.0    0.0  0.0     0.0    0.0    0.0        0.0    0.0    0.0   0.0        0.0  0.0    0.0   0.0   0.0      0.0   0.0
FI   0.0    0.0    0.0    0.0    0.0     0.0    0.0    0.0  0.0     0.0    0.0    0.0        0.0    0.0    0.0   0.0        0.0  0.0    0.0   0.0   0.0      0.0   0.0
FR   0.0    0.0    0.0    0.0    0.0     0.0    0.0    0.0  0.0     0.0    0.0    0.0        0.0    0.0    0.0   0.0        0.0  0.0    0.0   0.0   0.0      0.0   0.0
GR   0.0    0.0    0.0    0.0    0.0     0.0    0.0    0.0  0.0     0.0    0.0    0.0        0.0    0.0    0.0   0.0        0.0  0.0    0.0   0.0   0.0      0.0   0.0
IE   0.0    0.0    0.0    0.0    0.0     0.0    0.0    0.0  0.0     0.0    0.0    0.0        0.0    0.0    0.0   0.0        0.0  0.0    0.0   0.0   0.0      0.0   0.0
IT   0.0    0.0    0.0    0.0    0.0     0.0    0.0    0.0  0.0     0.0    0.0    0.0        0.0    0.0    0.0   0.0        0.0  0.0    0.0   0.0   0.0      0.0   0.0
NL   0.0    0.0    0.0    0.0    0.0     0.0    0.0    0.0  0.0     0.0    0.0    0.0        0.0    0.0    0.0   0.0        0.0  0.0    0.0   0.0   0.0      0.0   0.0
PT   0.0    0.0    0.0    0.0    0.0     0.0    0.0    0.0  0.0     0.0    0.0    0.0        0.0    0.0    0.0   0.0        0.0  0.0    0.0   0.0   0.0      0.0   0.0
ES   0.0    0.0    0.0    0.0    0.0     0.0    0.0    0.0  0.0     0.0    0.0    0.0        0.0    0.0    0.0   0.0        0.0  0.0    0.0   0.0   0.0      0.0   0.0
SW   0.0    0.0    0.0    0.0    0.0     0.0    0.0    0.0  0.0     0.0    0.0    0.0        0.0    0.0    0.0   0.0        0.0  0.0    0.0   0.0   0.0      0.0   0.0
UK   0.0    0.0    0.0    0.0    0.0     0.0    0.0    0.0  0.0     0.0    0.0    0.0        0.0    0.0    0.0   0.0        0.0  0.0    0.0   0.0   0.0      0.0   0.0
LV   0.0    0.0    0.0    0.0    0.0     0.0    0.0    0.0  0.0     0.0    0.0    0.0        0.0    0.0    0.0   0.0        0.0  0.0    0.0   0.0   0.0      0.0   0.0
RO   0.0    0.0    0.0    0.0    0.0     0.0    0.0    0.0  0.0     0.0    0.0    0.0        0.0    0.0    0.0   0.0        0.0  0.0    0.0   0.0   0.0      0.0   0.0
SI   0.0    0.0    0.0    0.0    0.0     0.0    0.0    0.0  0.0     0.0    0.0    0.0        0.0    0.0    0.0   0.0        0.0  0.0    0.0   0.0   0.0      0.0   0.0
LT   0.0    0.0    0.0    0.0    0.0     0.0    0.0    0.0  0.0     0.0    0.0    0.0        0.0    0.0    0.0   0.0        0.0  0.0    0.0   0.0   0.0      0.0   0.0
BG   0.0    0.0    0.0    0.0    0.0     0.0    0.0    0.0  0.0     0.0    0.0    0.0        0.0    0.0    0.0   0.0        0.0  0.0    0.0   0.0   0.0      0.0   0.0
PL   0.0    0.0    0.0    0.0    0.0     0.0    0.0    0.0  0.0     0.0    0.0    0.0        0.0    0.0    0.0   0.0        0.0  0.0    0.0   0.0   0.0      0.0   0.0
HU   0.0    0.0    0.0    0.0    0.0     0.0    0.0    0.0  0.0     0.0    0.0    0.0        0.0    0.0    0.0   0.0        0.0  0.0    0.0   0.0   0.0      0.0   0.0
CZ   0.0    0.0    0.0    0.0    0.0     0.0    0.0    0.0  0.0     0.0    0.0    0.0        0.0    0.0    0.0   0.0        0.0  0.0    0.0   0.0   0.0      0.0   0.0
SK   0.0    0.0    0.0    0.0    0.0     0.0    0.0    0.0  0.0     0.0    0.0    0.0        0.0    0.0    0.0   0.0        0.0  0.0    0.0   0.0   0.0      0.0   0.0
EE   0.0    0.0    0.0    0.0    0.0     0.0    0.0    0.0  0.0     0.0    0.0    0.0        0.0    0.0    0.0   0.0        0.0  0.0    0.0   0.0   0.0      0.0   0.0
CY   0.0    0.0    0.0    0.0    0.0     0.0    0.0    0.0  0.0     0.0    0.0    0.0        0.0    0.0    0.0   0.0        0.0  0.0    0.0   0.0   0.0      0.0   0.0
MT   0.0    0.0    0.0    0.0    0.0     0.0    0.0    0.0  0.0     0.0    0.0    0.0        0.0    0.0    0.0   0.0        0.0  0.0    0.0   0.0   0.0      0.0   0.0
TU   0.0    0.0    0.0    0.0    0.0     0.0    0.0    0.0  0.0     0.0    0.0    0.0        0.0    0.0    0.0   0.0        0.0  0.0    0.0   0.0   0.0      0.0   0.0
HR   0.0    0.0    0.0    0.0    0.0     0.0    0.0    0.0  0.0     0.0    0.0    0.0        0.0    0.0    0.0   0.0        0.0  0.0    0.0   0.0   0.0      0.0   0.0
WB   0.0    0.0    0.0    0.0    0.0     0.0    0.0    0.0  0.0     0.0    0.0    0.0        0.0    0.0    0.0   0.0        0.0  0.0    0.0   0.0   0.0      0.0   0.0
US   0.0    0.0    0.0    0.0    0.0     0.0    0.0    0.0  0.0     0.0    0.0    0.0        0.0    0.0    0.0   0.0        0.0  0.0    0.0   0.0   0.0      0.0   0.0
ROW  0.0    0.0    0.0    0.0    0.0     0.0    0.0    0.0  0.0     0.0    0.0    0.0        0.0    0.0    0.0   0.0        0.0  0.0    0.0   0.0   0.0      0.0   0.0
;
* <%FORMAT ###,##0.#%>
* <%USERLEVEL 3%>
* <%BOUNDS%>
* *.* 0  1
* <%ENDBOUNDS%>
* <%/INPUT%>

*<%INPUT%>
Table adj_rec_2(cc,ag) Weighting factors in recursive model stucture for the t-2 period
     CWHEAT  PULS  BARLEY CORN   RYE  OTHGRA  RICE  SUGAR  POTATO  SOYBEAN  RAPSEED  SUNSEED    SMAIZE  FODDER  GRAS  SETASIDE  MILK  BEEF  SHEEP  PORK  POULTRY  EGGS  PALMOIL
GE   0.0     0.0    0.0    0.0    0.0  0.0     0.0    0.0   0.0      0.0      0.0     0.0        0.0     0.0     0.0   0.0        0.0  0.0    0.0   0.0   0.0      0.0   0.0
AT   0.0     0.0    0.0    0.0    0.0  0.0     0.0    0.0   0.0      0.0      0.0     0.0        0.0     0.0     0.0   0.0        0.0  0.0    0.0   0.0   0.0      0.0   0.0
BE   0.0     0.0    0.0    0.0    0.0  0.0     0.0    0.0   0.0      0.0      0.0     0.0        0.0     0.0     0.0   0.0        0.0  0.0    0.0   0.0   0.0      0.0   0.0
DK   0.0     0.0    0.0    0.0    0.0  0.0     0.0    0.0   0.0      0.0      0.0     0.0        0.0     0.0     0.0   0.0        0.0  0.0    0.0   0.0   0.0      0.0   0.0
FI   0.0     0.0    0.0    0.0    0.0  0.0     0.0    0.0   0.0      0.0      0.0     0.0        0.0     0.0     0.0   0.0        0.0  0.0    0.0   0.0   0.0      0.0   0.0
FR   0.0     0.0    0.0    0.0    0.0  0.0     0.0    0.0   0.0      0.0      0.0     0.0        0.0     0.0     0.0   0.0        0.0  0.0    0.0   0.0   0.0      0.0   0.0
GR   0.0     0.0    0.0    0.0    0.0  0.0     0.0    0.0   0.0      0.0      0.0     0.0        0.0     0.0     0.0   0.0        0.0  0.0    0.0   0.0   0.0      0.0   0.0
IE   0.0     0.0    0.0    0.0    0.0  0.0     0.0    0.0   0.0      0.0      0.0     0.0        0.0     0.0     0.0   0.0        0.0  0.0    0.0   0.0   0.0      0.0   0.0
IT   0.0     0.0    0.0    0.0    0.0  0.0     0.0    0.0   0.0      0.0      0.0     0.0        0.0     0.0     0.0   0.0        0.0  0.0    0.0   0.0   0.0      0.0   0.0
NL   0.0     0.0    0.0    0.0    0.0  0.0     0.0    0.0   0.0      0.0      0.0     0.0        0.0     0.0     0.0   0.0        0.0  0.0    0.0   0.0   0.0      0.0   0.0
PT   0.0     0.0    0.0    0.0    0.0  0.0     0.0    0.0   0.0      0.0      0.0     0.0        0.0     0.0     0.0   0.0        0.0  0.0    0.0   0.0   0.0      0.0   0.0
ES   0.0     0.0    0.0    0.0    0.0  0.0     0.0    0.0   0.0      0.0      0.0     0.0        0.0     0.0     0.0   0.0        0.0  0.0    0.0   0.0   0.0      0.0   0.0
SW   0.0     0.0    0.0    0.0    0.0  0.0     0.0    0.0   0.0      0.0      0.0     0.0        0.0     0.0     0.0   0.0        0.0  0.0    0.0   0.0   0.0      0.0   0.0
UK   0.0     0.0    0.0    0.0    0.0  0.0     0.0    0.0   0.0      0.0      0.0     0.0        0.0     0.0     0.0   0.0        0.0  0.0    0.0   0.0   0.0      0.0   0.0
LV   0.0     0.0    0.0    0.0    0.0  0.0     0.0    0.0   0.0      0.0      0.0     0.0        0.0     0.0     0.0   0.0        0.0  0.0    0.0   0.0   0.0      0.0   0.0
RO   0.0     0.0    0.0    0.0    0.0  0.0     0.0    0.0   0.0      0.0      0.0     0.0        0.0     0.0     0.0   0.0        0.0  0.0    0.0   0.0   0.0      0.0   0.0
SI   0.0     0.0    0.0    0.0    0.0  0.0     0.0    0.0   0.0      0.0      0.0     0.0        0.0     0.0     0.0   0.0        0.0  0.0    0.0   0.0   0.0      0.0   0.0
LT   0.0     0.0    0.0    0.0    0.0  0.0     0.0    0.0   0.0      0.0      0.0     0.0        0.0     0.0     0.0   0.0        0.0  0.0    0.0   0.0   0.0      0.0   0.0
BG   0.0     0.0    0.0    0.0    0.0  0.0     0.0    0.0   0.0      0.0      0.0     0.0        0.0     0.0     0.0   0.0        0.0  0.0    0.0   0.0   0.0      0.0   0.0
PL   0.0     0.0    0.0    0.0    0.0  0.0     0.0    0.0   0.0      0.0      0.0     0.0        0.0     0.0     0.0   0.0        0.0  0.0    0.0   0.0   0.0      0.0   0.0
HU   0.0     0.0    0.0    0.0    0.0  0.0     0.0    0.0   0.0      0.0      0.0     0.0        0.0     0.0     0.0   0.0        0.0  0.0    0.0   0.0   0.0      0.0   0.0
CZ   0.0     0.0    0.0    0.0    0.0  0.0     0.0    0.0   0.0      0.0      0.0     0.0        0.0     0.0     0.0   0.0        0.0  0.0    0.0   0.0   0.0      0.0   0.0
SK   0.0     0.0    0.0    0.0    0.0  0.0     0.0    0.0   0.0      0.0      0.0     0.0        0.0     0.0     0.0   0.0        0.0  0.0    0.0   0.0   0.0      0.0   0.0
EE   0.0     0.0    0.0    0.0    0.0  0.0     0.0    0.0   0.0      0.0      0.0     0.0        0.0     0.0     0.0   0.0        0.0  0.0    0.0   0.0   0.0      0.0   0.0
CY   0.0     0.0    0.0    0.0    0.0  0.0     0.0    0.0   0.0      0.0      0.0     0.0        0.0     0.0     0.0   0.0        0.0  0.0    0.0   0.0   0.0      0.0   0.0
MT   0.0     0.0    0.0    0.0    0.0  0.0     0.0    0.0   0.0      0.0      0.0     0.0        0.0     0.0     0.0   0.0        0.0  0.0    0.0   0.0   0.0      0.0   0.0
TU   0.0     0.0    0.0    0.0    0.0  0.0     0.0    0.0   0.0      0.0      0.0     0.0        0.0     0.0     0.0   0.0        0.0  0.0    0.0   0.0   0.0      0.0   0.0
HR   0.0     0.0    0.0    0.0    0.0  0.0     0.0    0.0   0.0      0.0      0.0     0.0        0.0     0.0     0.0   0.0        0.0  0.0    0.0   0.0   0.0      0.0   0.0
WB   0.0     0.0    0.0    0.0    0.0  0.0     0.0    0.0   0.0      0.0      0.0     0.0        0.0     0.0     0.0   0.0        0.0  0.0    0.0   0.0   0.0      0.0   0.0
US   0.0     0.0    0.0    0.0    0.0  0.0     0.0    0.0   0.0      0.0      0.0     0.0        0.0     0.0     0.0   0.0        0.0  0.0    0.0   0.0   0.0      0.0   0.0
ROW  0.0     0.0    0.0    0.0    0.0  0.0     0.0    0.0   0.0      0.0      0.0     0.0        0.0     0.0     0.0   0.0        0.0  0.0    0.0   0.0   0.0      0.0   0.0
;
* <%FORMAT ###,##0.#%>
* <%USERLEVEL 3%>
* <%BOUNDS%>
* *.* 0  1
* <%ENDBOUNDS%>
* <%/INPUT%>

lag_weight(cc,ag,"t_1") = adj_rec_1(cc,ag);
lag_weight(cc,ag,"t_2") = adj_rec_2(cc,ag);

display lag_weight;

*<%INPUT%>
table trq_para1(trq_pp,sug_q_st_) Intercept and elasticity parameter for variable preferential imports of sugar in the EU
            under_quota          w_o_quota
trq_int     -6.626195457917400   -6.60131193680124
trq_elast    3.065785580396370    3.15476323543266
;
* <%FORMAT #.#####%>
* <%USERLEVEL 3%>
* <%/INPUT%>


*<%INPUT%>
table trq_para(sim,trq_p)   'Variable preferential imports of sugar in the EU'
          trq_tc  preftrq         sug_exog    sugar_quot
*BASE      20      1900.202        3800.202     1.00
BASE      20      1900.202        4100.202     1.00
2009      20      1900.202        4100.202     1.00
*2009      20      4500.000        4100.202     1.00
2010      20      4500.000        4100.202     1.00
2011      20      4500.000        4100.202     1.00
2012      20      4500.000        4100.202     1.00
2013      20      4500.000        4100.202     1.00
2014      20      4500.000        4100.202     1.00

*2015      20      4500.000       4100.202     1.00
2015      20      10000.000       4100.202     1.00
2016      20      10000.000       4100.202     1.00
2017      20      10000.000       4100.202     1.00
2018      20      10000.000       4100.202     1.00
2019      20      10000.000       4100.202     1.00
2020      20      10000.000       4100.202     1.00
2021      20      10000.000       4100.202     1.00
2022      20      10000.000       4100.202     1.00
2023      20      10000.000       4100.202     1.00
2024      20      10000.000       4100.202     1.00
2025      20      10000.000       4100.202     1.00
2026      20      10000.000       4100.202     1.00
2027      20      10000.000       4100.202     1.00
2028      20      10000.000       4100.202     1.00
2029      20      10000.000       4100.202     1.00
2030      20      10000.000       4100.202     1.00
;
* <%FORMAT #####0.###%>
* <%USERLEVEL 2%>
* <%NONEDIT%>
* base.*
* <%ENDNONEDIT%>

* If SUGAR_QUOT = 1.0 quotas are in place [default]
* If SUGAR_QUOT = 0.0 quotas are abolished from that year on [option]
* <%ENDINFO%>
* <%/INPUT%>

trq_para(time_cal,trq_p) = trq_para("2030",trq_p);


trq_int  = exp(trq_para1("trq_int",'under_quota'))  ;
trq_elast= trq_para1("trq_elast",'under_quota');
trq_tc   = trq_para('base',"trq_tc")   ;
preftrq  = trq_para('base',"preftrq")  ;
sug_imp_exog('sugar') = trq_para('base',"sug_exog")  ;


parameter
C_sugar_exports(it)
area_factor_sug_0(cc)
price_sug_0(cc)
;
C_sugar_exports(it) = 0;

***      Abolition:

*trq_para(sim,'sugar_quot')$(ord (sim) ge 10) = 0;
*chg_quota_sim2('2019',EU27) = 1.7;
*chg_quota_sim2('2016',EU27) = 1.7;
*chg_quota_sim2('2017',EU27) = 1.7;
*chg_quota_sim2('2018',EU27) = 1.7;

***      Abolition END



* <%INPUT%>
Table chg_qual(it,chg_qual_st) Changes in markup values of exports without export refunds
           "Qualchange"    "year"
CHEESE
PORK           0            2010
;
* <%FORMAT ###,##0.##%>
* <%USERLEVEL 1%>
* <%BOUNDS%>
* *.Qualchange -100  100
* *.year 2008 2020 integer
* <%ENDBOUNDS%>
* <%/INPUT%>


* <%INPUT%>
Table chg_quant(it,chg_quant_st) Changes in quantities of exports with prices different from world market and without export refunds
           "Quant_change"     "period"
CHEESE
PORK            0               2010
;
* <%FORMAT ###,##0.##%>
* <%USERLEVEL 1%>
* <%BOUNDS%>
* *.Quant_change -99  100
* *.period 2008 2020 integer
* <%ENDBOUNDS%>
* <%/INPUT%>



*----- Original Taggs of Tables in GAMS code - by now read in via excel workbook ----

* <%INPUT%>
*TABLE  phase_in_eu(sim,cc) Phasing in of EU direct payments

* <%FORMAT ###,##0%>
* <%USERLEVEL 3%>
* <%BOUNDS%>
* *.* 0  100
* <%ENDBOUNDS%>

* Direct payments: EU payments (% of full EU rate)
* <%ENDINFO%>
* <%/INPUT%>

* <%INPUT%>
*Table top_up_reduction(sim,cc) Reduction of national top up payments in NMS (values represent % of baseyear)

* <%FORMAT #0.##%>
* <%USERLEVEL 3%>
* <%BOUNDS%>
* *.* 0  1
* <%ENDBOUNDS%>

* Percentage changes of national top up ceilings - refered to base situation (1.00 = no change; 0=no payments)
* <%ENDINFO%>
* <%/INPUT%>



*<%INPUT%>
*TABLE  chg_quota_sim1(sim,cc) Change in milk quota in percent

* <%FORMAT ###,##0.###%>
* <%USERLEVEL 2%>
* <%/INPUT%>


*<%INPUT%>
*TABLE  chg_quota_sim2(sim,cc) Change in sugar quota in percent

* <%FORMAT ###,##0.###%>
* <%USERLEVEL 2%>
* <%/INPUT%>



* <%INPUT%>
*TABLE  chg_int_pre(comm,sim) Predetermined changes in intervention prices w.r. to previous period in%

* <%FORMAT ###,##0.##%>
* <%USERLEVEL 1%>

* annual reduction w.r. to previous (!!!)  period's level
* <%ENDINFO%>
* <%/INPUT%>



* <%INPUT%>
*TABLE  chg_int(comm,CHG_ST_) Linear changes in intervention prices
*         total change          implementation period
*             (in %)          first year    last year

* <%FORMAT #####0.##%>
* <%USERLEVEL 99999 hide%>
* <%BOUNDS%>
* *.chg -100  100
* *.first 2008 2020 integer
* *.final 2008 2020 integer
* <%ENDBOUNDS%>
* <%/INPUT%>

* <%PROGRAM%>
* <%DESCRIPTION Change Intervention Prices%>
* <%STARTUP $GSEROOTDIR\ESIM.exe%>
* <%STARTUPPARAMETERS $RUNROOTDIR%>
* <%EXPORTFROMGSE%>
* GAMSOUT parameter CHG_INT "JUMP.OUT"
* GAMSOUT parameter chg_int_ann "TREND.OUT"
* GAMSOUT set comm "comm.out"
* GAMSOUT set CHG_ST_ "col.out"
* GAMSOUT set SIM "SIM.out"
* <%ENDEXPORTFROMGSE%>
* <%IMPORTTOGSE%>
* GAMSIN parameter CHG_INT 'JUMP.OUT'
* GAMSIN parameter chg_int_ann 'TREND.OUT'
* <%ENDIMPORTTOGSE%>
* <%/PROGRAM%>



* <%INPUT%>
*TABLE  chg_thresh_pre(comm,sim) Pre-determined changes in threshold prices
* annual reduction w.r. to base period's level

* <%FORMAT ###,##0.##%>
* <%USERLEVEL 1%>
* <%NONEDIT%>
* *.*
* <%ENDNONEDIT%>
* <%/INPUT%>


* <%INPUT%>
*TABLE  thresh_n(comm,CHG_ST_) Changes in threshold prices
*         total change          implementation period
*             (in %)          first year    last year

* <%FORMAT ###,##0.##%>
* <%USERLEVEL 1%>
* <%BOUNDS%>
* *.chg -100  100
* *.first 2008 2020 integer
* *.final 2008 2020 integer
* <%ENDBOUNDS%>
* <%/INPUT%>


* <%INPUT%>
*TABLE  chg_tar_v(it,chg_st_) Changes in ad-valorem tariffs
*         total change          implementation period
*             (in %)          first year  last year

* <%FORMAT ###,##0.##%>
* <%USERLEVEL 1%>
* <%BOUNDS%>
* *.chg -100  100
* *.first 2008 2020 integer
* *.final 2008 2020 integer
* <%ENDBOUNDS%>
* <%/INPUT%>

* <%INPUT%>
*TABLE  chg_tar_s(comm,chg_st_) Changes in specific tariffs
*         total change       implementation period
*             (in %)         first year    last year

* <%FORMAT ###,##0.##%>
* <%USERLEVEL 1%>
* <%BOUNDS%>
* *.chg -100  100
* *.first 2008 2020 integer
* *.final 2008 2020 integer
* <%ENDBOUNDS%>
* <%/INPUT%>

* <%INPUT%>
*TABLE  chg_subsidy(comm,chg_subsidy_st_) Changes in export subsidies
*                   change              implementation period
*             values    quantitites
*             (in %)      (in %)        first year    last year

* <%FORMAT ###,##0.##%>
* <%USERLEVEL 1%>
* <%BOUNDS%>
* *.(chg_v,chg_q) -100  100
* *.first 2008 2020 integer
* *.final 2008 2020 integer
* <%ENDBOUNDS%>
* <%/INPUT%>

* <%INPUT%>
*TABLE  chg_trq(trq_comm,chg_st_) Changes in tariff rate quotas
*               change             implementation period
*               (in %)             first year    last year

* <%FORMAT ###,##0.##%>
* <%USERLEVEL 1%>
* <%BOUNDS%>
* *.chg -100  100
* *.first 2008 2020 integer
* *.final 2008 2020 integer
* <%ENDBOUNDS%>
* <%/INPUT%>

* <%INPUT%>
*TABLE  intro_trq(pot_trq_comm,chg_trq_st_) Commodities with new introduced TRQ
*                            implementation period
*          (in 1000t)       first year  last year

* <%FORMAT ###,##0.##%>
* <%USERLEVEL 1%>
* <%BOUNDS%>
* *.TRQ 0  +inf
* *.first 2008 2020 integer
* *.final 2008 2020 integer
* <%ENDBOUNDS%>
* <%/INPUT%>



* <%INPUT%>
*Table sugar_envelop(cc,sim_base) "Direct payments sugar: only Changes (Differences to the precious year, in Mio €)"

* <%FORMAT ###,##0.###%>
* <%USERLEVEL 2%>

* Source: Annex XV of Reg 73/2009 from 2009 (+ corrigendum) and Table 1 Annex VII of Reg. 1782/2003 from 2006 to 2008
* <%ENDINFO%>
* <%/INPUT%>



* <%INPUT%>
*TABLE  chg_dp(cc,sim) Change in direct payments compared to previous year

* <%FORMAT ###,##0.##%>
* <%USERLEVEL 1%>
* <%BOUNDS%>
* *.* 0  100
* <%ENDBOUNDS%>
* <%/INPUT%>
