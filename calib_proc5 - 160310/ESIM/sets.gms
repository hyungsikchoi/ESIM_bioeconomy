*<%SET%>
SETS
    i   Products included in the ESIM model
         /   CWHEAT
*             DURUM
             BARLEY
             CORN
             RYE
             OTHGRA
             RICE
             SUGAR
             POTATO
             SOYBEAN
             RAPSEED
             SUNSEED
             SOYMEAL
             RAPMEAL
             SUNMEAL
             MANIOC
             SMAIZE
             FODDER
             GRAS
             SETASIDE
             GLUTFD
             OENERGY
* New from CAPRI
             STRA
             PULS
             FENE    OENERGY_CAPRI
             OPROT
* New from the Bioeconomy
             LINO  lignocellosic biomass
* ### NEW DAIRY PRODUCTS ###
             FAT
             PROTEIN
             SMP
             WMP
             CREAM
             CONC_MLK
             ACID_MLK
             WHEY
* ##########################
             MILK
             CMILK
             BUTTER
             CHEESE
             OTHDAIRY
             BEEF
             SHEEP
             PORK
             POULTRY
             EGGS
             SOYOIL
             RAPOIL
             SUNOIL
             PALMOIL
             LABOR
             CAPITAL
             INTERMED
             FERTIL
             ENERGY
             LAND
             FEEDING
             FEED
             OTHER
             OBSETAS

             BIODIESEL
             ETHANOL
             C_OIL
                        /
comm(i) Agri-food commodities
         /   CWHEAT
*             DURUM
             BARLEY
             CORN
             RYE
             OTHGRA
             RICE
             SUGAR
             POTATO
             SOYBEAN
             RAPSEED
             SUNSEED
             SOYMEAL
             RAPMEAL
             SUNMEAL
*             MANIOC
             SMAIZE
             FODDER
             GRAS
             SETASIDE
             GLUTFD
             OENERGY
*New from CAPRI
             STRA
             PULS
             LINO       lignocellosic biomass
             FENE       OENERGY_CAPRI
             OPROT
* ### NEW DAIRY PRODUCTS ###
             FAT
             PROTEIN
             SMP
             WMP
             CREAM
             CONC_MLK
*             ACID_MLK
             WHEY
* ##########################
             MILK
             CMILK
             BUTTER
             CHEESE
             OTHDAIRY
             BEEF
             SHEEP
             PORK
             POULTRY
             EGGS
             SOYOIL
             RAPOIL
             SUNOIL
             PALMOIL

             BIODIESEL
             ETHANOL
             C_OIL

          /


pot_trq_comm(comm) Agricultural products with possibly new introduced TRQ
         /
*RICE
             POULTRY
             EGGS
         /

trq_comm(comm) Agricultural products with TRQ in the base period
         /   CWHEAT
             rice
*            DURUM
             CORN
             BARLEY
             RYE
             OTHGRA
*             SUGAR
             SMP
             BUTTER
             CHEESE
             BEEF
             PORK
             SHEEP
         /

livest(comm) Livestock products
        /    MILK
             BEEF
             SHEEP
             PORK
             POULTRY
             EGGS    /

feed(comm)   Feed products
         /   CWHEAT
             BARLEY
             CORN
             RYE
             OTHGRA
             POTATO
             SOYBEAN
             SOYMEAL
             RAPMEAL
             SUNSEED
             SUNMEAL
*             MANIOC
             SMAIZE
             FODDER
             GRAS
             GLUTFD
             OENERGY
             OPROT
             SMP

***New feed from CAPRI
             STRA
             PULS
*             DURUM
             RICE
             SUGAR
             Whey
             OTHDAIRY
             RAPOIL
             SUNOIL
             WMP
             FENE          OENERGY_CAPRI
             rapseed
             soyoil
             CONC_MLK


/



pl(comm) Plant products
/
CWHEAT
*DURUM
BARLEY
CORN
RYE
OTHGRA
RICE
SUGAR
POTATO
SOYBEAN
RAPSEED
SUNSEED
SOYMEAL
RAPMEAL
SUNMEAL
PULS    new from CAPRI
*MANIOC
SMAIZE
FODDER
GRAS
GLUTFD
OENERGY
OPROT
SOYOIL
RAPOIL
SUNOIL
PALMOIL
/

an(comm) Animal products
/
CMILK
SMP
BUTTER
CHEESE
OTHDAIRY
BEEF
SHEEP
PORK
POULTRY
EGGS
/

en_crp(comm) Crops for energy use
/
RAPSEED
SUNSEED
SUGAR
CWHEAT
CORN
***new crop from CAPRI
RYE
OTHGRA
BARLEY
/


energy(i)    relevant energy products (including crude oil)
/
             BIODIESEL
             ETHANOL
             C_OIL

/

energ(comm)  produced energy products
/
             BIODIESEL
             ETHANOL
/

biof_d(comm)  biodiesel
/
             BIODIESEL
/

biof_e(comm)  ethanol
/
             ETHANOL
/
cr_oil(comm) set for crude oil only
/
             C_OIL
/

i_diesel(comm) Input in Biodiesel production
/
RAPOIL
SUNOIL
PALMOIL
SOYOIL
***New set from CAPRI
/

i_ethanol(comm) Input in Bioethanol production

/
CORN
CWHEAT
SUGAR
***New set from CAPRI
RYE
OTHGRA
Barley
/


i_ethanol_ns(comm) Input in Bioethanol production

/
CORN
CWHEAT
***New set from CAPRI
RYE
OTHGRA
Barley
/


i_ethanol_s(comm) Input in Bioethanol production

/
SUGAR
/



ccplus    Countries and regions in ESIM with aggregated regions
/
EU        EU without individual countries included in cc
GE        Germany
AT        Austria
BE        Belgium_Luxembourg
DK        Denmark
FI        Finland
FR        France
GR        Greece
IE        Ireland
IT        Italy
NL        Netherlands
PT        Portugal
ES        Spain
SW        Sweden
UK        United Kingdom
LV        LATVIA
RO        ROMANIA
SI        SLOVENIA
LT        LITHUANIA
BG        BULGARIA
PL        POLAND
HU        HUNGARY
CZ        CZECH REPUBLIC
SK        SLOVAK REPUBLIC
EE        ESTONIA
CY        CYPRUS
MT        MALTA
TU        TURKEY
HR        CROATIA
WB        Western Balkan Countries
US        United States of America
ROW       ROW (Residual Rest-of-World)
EU_to     Total EU
EU_15     EU with 15 old members
EU_25     EU with 25 members
NMS10     10 new member states
NMS12     12 new member states
BG_RO     Bulgaria and Romania
ACC       Total accession candidates
/



cc(ccplus)   Countries
         /
         GE        GERMANY
         AT        AUSTRIA
         BE        BELGIUM_LUXEMBOURG
         DK        DENMARK
         FI        FINLAND
         FR        FRANCE
         GR        Greece
         IE        Ireland
         IT        Italy
         NL        Netherlands
         PT        Portugal
         ES        Spain
         SW        Sweden
         UK        United Kingdom
         LV        LATVIA
         RO        ROMANIA
         SI        SLOVENIA
         LT        LITHUANIA
         BG        BULGARIA
         PL        POLAND
         HU        HUNGARY
         CZ        CZECH REPUBLIC
         SK        SLOVAK REPUBLIC
         EE        ESTONIA
         CY        CYPRUS
         MT        MALTA

         TU        TURKEY
         HR        CROATIA


         WB        Western Balkan Countries
         US        United States of America
         ROW       ROW (Residual Rest-of-World)
         /



EU27(cc)
         /
         GE        GERMANY
         AT        AUSTRIA
         BE        BELGIUM_LUXEMBOURG
         DK        DENMARK
         FI        FINLAND
         FR        FRANCE
         GR        Greece
         IE        Ireland
         IT        Italy
         NL        Netherlands
         PT        Portugal
         ES        Spain
         SW        Sweden
         UK        United Kingdom
         LV        LATVIA
         RO        ROMANIA
         SI        SLOVENIA
         LT        LITHUANIA
         BG        BULGARIA
         PL        POLAND
         HU        HUNGARY
         CZ        CZECH REPUBLIC
         SK        SLOVAK REPUBLIC
         EE        ESTONIA
         CY        CYPRUS
         MT        MALTA
         /

EU25(cc)
         /
         GE        GERMANY
         AT        AUSTRIA
         BE        BELGIUM_LUXEMBOURG
         DK        DENMARK
         FI        FINLAND
         FR        FRANCE
         GR        Greece
         IE        Ireland
         IT        Italy
         NL        Netherlands
         PT        Portugal
         ES        Spain
         SW        Sweden
         UK        United Kingdom
         LV        LATVIA
         SI        SLOVENIA
         LT        LITHUANIA
         PL        POLAND
         HU        HUNGARY
         CZ        CZECH REPUBLIC
         SK        SLOVAK REPUBLIC
         EE        ESTONIA
         CY        CYPRUS
         MT        MALTA
         /




EU12(cc)
         /
         LV        LATVIA
         SI        SLOVENIA
         LT        LITHUANIA
         PL        POLAND
         HU        HUNGARY
         CZ        CZECH REPUBLIC
         SK        SLOVAK REPUBLIC
         EE        ESTONIA
         CY        CYPRUS
         MT        MALTA
         RO        ROMANIA
         BG        BULGARIA
         /


EU15(cc)
         /
         GE        GERMANY
         AT        AUSTRIA
         BE        BELGIUM_LUXEMBOURG
         DK        DENMARK
         FI        FINLAND
         FR        FRANCE
         GR        Greece
         IE        Ireland
         IT        Italy
         NL        Netherlands
         PT        Portugal
         ES        Spain
         SW        Sweden
         UK        United Kingdom
         /

delay_r(cc)  delayed regions for full market integration
/
*         SI        SLOVENIA
*         HU        HUNGARY
*         CZ        CZECH REPUBLIC
*         SK        SLOVAK REPUBLIC
*         RO        ROMANIA
         BG        BULGARIA
/







b  Years in data base including average
         /2002*2005,AVG/
*<%/SET%>


*<%SET%>
res_pp
/         pp
          pd
          marg
          tar_ad
          sp_d
          exp_sub
          thrpr
          intpr
          TRQ
          es_limit
          qual_comp
          premium
          exstab
          feed_aid
          cons_aid
          aid_quant
/




pol(res_pp)  different policy instruments in CAP
         /tar_ad
          sp_d
          exp_sub
          thrpr
          intpr
          TRQ
          es_limit
          qual_comp
          premium
          exstab
          feed_aid
          cons_aid
          aid_quant
         /

nt(comm)   Non tradable commodities
           /
           POTATO
*           GLUTFD
           SETASIDE
           FAT
           PROTEIN
*           OTHDAIRY
*          OENERGY
           FENE        OENERGY_CAPRI
*           OPROT
           MILK
           CMILK
           SMAIZE
           FODDER
           GRAS
           STRA       new from CAPRI
/
nt_mlk(comm)   Non tradable commodities without milk
           /
           POTATO
           SETASIDE
           FAT
           PROTEIN
*           OTHDAIRY
*           OENERGY
*          NEW from CAPRI
           FENE           OENERGY_CAPRI
*           OPROT
*           MILK
           CMILK
           SMAIZE
           FODDER
           GRAS
/

it(comm)   Tradable commodities
         /   CWHEAT
*             DURUM
             BARLEY
             CORN
             RYE
             OTHGRA
             RICE
             SUGAR
             SOYBEAN
             RAPSEED
             SUNSEED
             SOYMEAL
             RAPMEAL
             SUNMEAL
*             MANIOC   deleted
             GLUTFD
             PULS      new from capri
             OTHDAIRY  new from capri
* ### NEW DAIRY PRODUCTS ###
             SMP
             WMP
             CREAM
             CONC_MLK
*             ACID_MLK
             WHEY
* ##########################
             BUTTER
             CHEESE
             BEEF
             SHEEP
             PORK
             POULTRY
             EGGS
             SOYOIL
             RAPOIL
             SUNOIL
             PALMOIL
             BIODIESEL
             ETHANOL

            OENERGY
            OPROT


          /

delay_c(it)  commodities for delayed integration to the Single European Market
         /   CWHEAT
             BARLEY
             CORN
             RYE
             OTHGRA
         /

bound_comm(it)
  /
   CWHEAT
*   DURUM
   BARLEY
   CORN
   RYE
   OTHGRA
   RICE
 /

switch_comm(bound_comm)   Products which might change the set in price formation mechanism
         /
             CWHEAT
*             DURUM
             BARLEY
             CORN
              /




ag(comm)     Agricultural products produced on-farm
         /   CWHEAT
*             DURUM
             BARLEY
             CORN
             RYE
             OTHGRA
             RICE
             SUGAR
             PULS   new from capri
             POTATO
             SOYBEAN
             RAPSEED
             SUNSEED
*             MANIOC   deleted
             SMAIZE
             FODDER
             GRAS
             SETASIDE
*             GLUTFD
             MILK
             BEEF
             SHEEP
             PORK
             POULTRY
             EGGS
             PALMOIL

/

crops(comm)  Arable crop products
         /   CWHEAT
*             DURUM
             BARLEY
             CORN
             RYE
             OTHGRA
             RICE
             SUGAR
             POTATO
             PULS    new from capri
             SOYBEAN
             RAPSEED
             SUNSEED
*             MANIOC   deleted
             SMAIZE
             FODDER
             GRAS
             SETASIDE
*             GLUTFD
             PALMOIL
             LINO    lignocellosic crops
            /

nonlino(crops)  Arable crop products
         /   CWHEAT
*             DURUM
             BARLEY
             CORN
             RYE
             OTHGRA
             RICE
             SUGAR
             POTATO
             PULS    new from capri
             SOYBEAN
             RAPSEED
             SUNSEED
*             MANIOC   deleted
             SMAIZE
             FODDER
             GRAS
             SETASIDE
*             GLUTFD
             PALMOIL
*             LINO    lignocellosic crops
            /

nonsug(crops)    Arable crops other than sugar
         /   CWHEAT
*             DURUM
             BARLEY
             CORN
             RYE
             OTHGRA
             RICE
*             SUGAR
             PULS     new from capri
             POTATO
             SOYBEAN
             RAPSEED
             SUNSEED
*             MANIOC   deleted
             SMAIZE
             FODDER
             GRAS
             SETASIDE
*             GLUTFD

             /

trq_p    parameter for variable preferential imports of sugar in the EU
         /
         trq_tc
         preftrq
         sug_exog
         sugar_quot
         /
trq_pp   additional parameters for variable preferential imports of sugar in the EU
         /
         trq_int
         trq_elast
         /


*<%/SET%>

cer_nd(comm)  Cereals eligible for direct payments without durum
   /        CWHEAT
            BARLEY
            CORN
            RYE
            OTHGRA
            SMAIZE /


*These are mainly residuals from the food industry for which domestic supply
*functions are specified with own price being the only independent variable.

feedres(comm) Residual feed products
           /
           OENERGY
           OPROT
           FENE
           /


*<%SET%>
oilseed(comm)   Oilseeds
         /
             SOYBEAN
             RAPSEED
             SUNSEED
         /

ospro(comm)   Products from oilseed processing
/
             SOYMEAL
             RAPMEAL
             SUNMEAL
             SOYOIL
             RAPOIL
             SUNOIL
/
*<%/SET%>

oil(comm)   Oil Products from oilseed processing
/
             SOYOIL
             RAPOIL
             SUNOIL
/
meal(comm)   Cake Products from oilseed processing
/
             SOYMEAL
             RAPMEAL
             SUNMEAL
/

eth_pro(comm)   products from energy crop processing to ethanol
/
             glutfd   Gluten Feed

/



  dairy_comp(comm)
  /
  FAT
  PROTEIN
  /

*<%SET%>
mlkproc(comm) Outputs from the dairy industry
        /
* ### NEW DAIRY PRODUCTS ###
             SMP
             WMP
             CREAM
             CONC_MLK
*             ACID_MLK
             WHEY
* ##########################
             CMILK
             BUTTER
             CHEESE
             OTHDAIRY
        /




comcrop(crops) Arable crops eligible for direct payments
           /  CWHEAT
*              DURUM
              BARLEY
              CORN
              RYE
              OTHGRA
              SOYBEAN
              RAPSEED
              SUNSEED
              SMAIZE
              /

    time /1990*2005,base,2009*2050/
    sim1(time) Time horizon of the model runs /base, 2009*2050/
    hist(time) Time period for historical data /1990*2005/
    sim_base(sim1) Time horizon of the model runs in BASELINE /base, 2009*2050/
    sim_trial(sim1) Time horizon of the model runs in BASELINE /base, 2009*2050/

    pre Timespan for validation run /base, 1999, 1998, 1997,1996,1995/







one(cc)  European regions and countries in ESIM
   /
           GE       GERMANY
           AT       AUSTRIA
           BE       BELGIUM_LUXEMBOURG
           DK       DENMARK
           FI       Finland
           FR       FRANCE
           GR       Greece
           IE       Ireland
           IT       Italy
           NL       Netherlands
           PT       Portugal
           ES       Spain
           SW       Sweden
           UK       United Kingdom
           LV       LATVIA
           RO       ROMANIA
           SI       SLOVENIA
           LT       LITHUANIA
           BG       BULGARIA
           PL       POLAND
           HU       HUNGARY
           CZ       CZECH REPUBLIC
           SK       SLOVAK REPUBLIC
           EE        ESTONIA
           CY        CYPRUS
           MT        MALTA
           TU        TURKEY
           HR        CROATIA
   /

europe(one)  European regions and countries in ESIM
   /
           GE       GERMANY
           AT       AUSTRIA
           BE       BELGIUM_LUXEMBOURG
           DK       DENMARK
           FI       Finland
           FR       FRANCE
           GR       Greece
           IE       Ireland
           IT       Italy
           NL       Netherlands
           PT       Portugal
           ES       Spain
           SW       Sweden
           UK       United Kingdom
           LV       LATVIA
           RO       ROMANIA
           SI       SLOVENIA
           LT       LITHUANIA
           BG       BULGARIA
           PL       POLAND
           HU       HUNGARY
           CZ       CZECH REPUBLIC
           SK       SLOVAK REPUBLIC
           EE        ESTONIA
           CY        CYPRUS
           MT        MALTA
           TU        TURKEY
           HR        CROATIA
   /

rest(cc)     / ROW,US,WB/
nms(cc)



cand(cc) Candidate countries modelled in ESIM
   /
*         RO        ROMANIA
*         BG        BULGARIA
         TU        TURKEY
         HR        CROATIA
   /





ceec(cc) Candidate countries modelled in ESIM from Central and Eastern Europe
   /
         LV        LATVIA
         RO        ROMANIA
         SI        SLOVENIA
         LT        LITHUANIA
         BG        BULGARIA
         PL        POLAND
         HU        HUNGARY
         CZ        CZECH REPUBLIC
         SK        SLOVAK REPUBLIC
         EE        ESTONIA
   /




EURO_ZONE (cc)
     / GE       Germany
       AT       Austria
       BE       Belgium_Luxembourg
*       DK       Denmark
       FI       Finland
       FR       France
       GR       Greece
       IE       Ireland
       IT       Italy
       NL       Netherlands
       PT       Portugal
       ES       Spain
*       SW       Sweden
*      UK       United Kingdom
    /

EURO1(ccplus) representative EUR area regions for EUR USD exchange rate
    / EU/


old_EU15(ccplus)
     / GE       Germany
       AT       Austria
       BE       Belgium_Luxembourg
       DK       Denmark
       FI       Finland
       FR       France
       GR       Greece
       IE       Ireland
       IT       Italy
       NL       Netherlands
       PT       Portugal
       ES       Spain
       SW       Sweden
       UK       United Kingdom
/




mlk(comm)
   / MILK/

sug(comm)
   / SUGAR/


cr_n_su_gr_sae(comm)  Arable crop products without sugar and pasture area and energy crops on setaside
         /   CWHEAT
*             DURUM
             BARLEY
             CORN
             RYE
             OTHGRA
             RICE
*             SUGAR
             PULS   new from capri
             POTATO
             SOYBEAN
             RAPSEED
             SUNSEED
*             MANIOC   deleted
             SMAIZE
             FODDER
*             GRAS
             SETASIDE
             GLUTFD
             PALMOIL
             /
cr_n_gr_sae(comm)  Arable crop products without pasture area  and energy crops on setaside
         /   CWHEAT
*             DURUM
             BARLEY
             CORN
             RYE
             OTHGRA
             RICE
             SUGAR
             POTATO
             SOYBEAN
             RAPSEED
             SUNSEED
             PULS   new from capri
*             MANIOC      deleted
             SMAIZE
             FODDER
*             GRAS
             SETASIDE
             GLUTFD
             PALMOIL

             /


* The following sets are all for the saving and transformation of results
res_comm Commodity specific results
/
* Quantity results
r_hdem      Human demand (1000 t)
r_hdem_PC   Human demand in kg per capita
r_sdem      Seed demand (1000 t)
r_pdem      Processing demand (1000 t)
r_fdem      Feed demand (1000 t)
r_tuse      Total use (1000 t)
r_supp      Supply (1000 t)
r_quot      Quotas (1000 t)
r_deliv     Milk delivered for processing (1000 t)
r_fill      'Fill rate of milk quotas (in %)'
r_yiel      Yield (kg per ha)
r_area      Area results (1000 ha)
r_area_hist Historical area use (1000 ha)
r_nx        Net export results (1000 t) (including stock changes)
r_trsh      Trade share results (%)
r_prefsug   Preferential sugar imports (endogenous or exogenously pre-fixed)

* Price results
r_pd        Wholesale price (� per t)
r_pw        World market price (USD per t)
r_netpd     Net price (� per t) in ethanol production
r_pp        Farmgate price (� per t)
r_pc        Consumer price (� per t)
r_pf        Feed price (� per t)
r_inc       Incentive price (� per t)
r_pint      Intervention price (� per t)
r_pthr      Threshhold price (� per t)
r_psh       Shadow price (� per t)
r_fci       Feed cost index relative to base
r_bci       Cost index in biofuel production relative to base
r_pup       Upper price bound (� per t)
r_pup2      Middle price bound (� per t)
r_plo       Lower price bound (� per t)

* Value results
r_valp     Production value  (Bill. �)
r_valc     Consumption value (Bill. �)

* macro results
r_tpg      Technical progress (base = 100)
r_tpf      Technical progress in feed use (base = 100)


* Policy results
r_esqu      Export subsidy limit (1000 t)
r_trq       Tariff rate quota(1000 t)
r_qualexp   Exports of high quality products without export subsidies (1000 t)
r_dpay      Direct payment (� per ha for crops and per t for livestock) including also Art. 68 69 payments (coupl. and decoup.)

r_dp_EU     aggregate DP (including Art. 68 69 payments) without national Top ups
r_dp_68     Art. 68 69 payments only (� per ha for crops and per t for livestock)
r_dp_top    National Top up direct payments in NMS (coupled and decoupled)(� per ha for crops and per t for livestock)
r_dp_no68   Direct payments (� per ha for crops and per t for livestock) only (without Art. 68 69 payments and top ups)

r_fsub      Feed subsidy (� per t)
r_hsub      Human demand subsidy (� per t)

r_tarav   Ad valorem tariff (%:100)
r_tarsp   Specific tariff   (%:100)
r_esav    Ad valorem export subsidy (� per ton)
r_essp    Specific export subsidy (� per ton)


* Product specific price indices (base=100)
pi_pd  Wholesale price relative to base
pi_pp  Farmgate price relative to base
pi_inc Incentive price relative to base
pi_pc  Consumer price relative to base
pi_pf  Feed price relative to base
pi_fc  Feed price index relative to base

* Product specific price indices (base=100)
pd_relative_to_pw Domestic price relative to world market price

* Product specific quantity indices (base=100)
qi_supp  Supply relative to base
qi_hdem  Humand demand relative to base
qi_pdem  Processing demand relative to base
qi_fdem  Feed demand relative to base

* Product specific value indices (base=100)
vi_supp  Supply value rel. to base
vi_hdem  Humand demand value rel. to base

* Budget results
b_dpa    Product specific outlays for direct payments (including Art 68 and national top ups)(Mill. �)

b_dp68   Product specific outlays for Art.68 69 payments (Mill. �)
b_dptop  Product specific outlays for national top ups (Mill. �)
b_dpEU   Product specific outlays for direct payments without national top ups (Mill. �)
b_dpno68 Product specific outlays for direct payments without Art 68 69 payments (Mill. �)

b_sub    Product specific outlays for product subsidies (Mill. �)
b_tar    Product specific tariff revenue (Mill. �)
b_exs    Product specific outlays for export subsidies (Mill. �)
b_tot    Product specific total budget (Mill. �)
/


res_cc Non commodity specific results
/
r_landpr1  Landprice 1
r_landpr2  landprice 2
r_lands1   landsupply 1
r_lands2   landsupply 2
r_landpr_nc landprice1 in national currency

r_obsa      Obligatory set aside (1000 ha)
r_totsa     Total set aside area (1000 ha)
r_totarea   Total effective area (1000 ha)
r_arsc      Area scaling factor
r_subm      Subsistence milk (1000 t)
r_saps      Area payment per ha under SFP (� per ha)
r_memb      Parameter which takes the value 1 if the country is a member in the respective simulation
r_bfshr     "Biofuel shares in the EU27 in % of transportation fuel"
r_bd_shr    "BioDIESEL shares in the EU27 in % of transportation fuel"
r_eth_shr   "Ethanol shares in the EU27 in % of transportation fuel"

r_spr_roil  Spread btw. rapoil and rapseed prices
r_spr_soil  Spread btw. sunoil and sunseed prices
r_spr_biod  Spread btw. biodiesel and oils input prices
r_spr_eth   Spread btw. ethanol and crop input prices
r_spr_soy   Spread btw. soyoil and soybean prices

r_spr_et_s  Spread btw. ethanol and sugar prices
r_spr_et_w  Spread btw. ethanol and wheat prices
r_spr_et_c  Spread btw. ethanol and corn prices

r_spr_bd_soy Spread btw. biodiesel and soyoil prices
r_spr_bd_sun Spread btw. biodiesel and sunoil prices
r_spr_bd_rap Spread btw. biodiesel and rapoil prices


* Development of macro shifter
r_incg      Income growth compared to base
r_popg      Population growth compared to base
r_pinterm   Price index for intermediates
r_pcap      Price index for capital
r_plab      Price index for labor


r_exra      Exchange rate
r_exind     Exchange rate relative to base

* Aggregated values
val_cr      Farm production value of crops (Mill. �)
val_li      Farm production value of livestock (Mill. �)
val_fa      Farm production value (Mill. �)

val_pl      Consumption value of plant products at wholesale prices (-subsidies) (Mill. �)
val_an      Consumption value of animal products at wholesale prices (-subsidies) (Mill. �)
val_co      Consumption value at wholesale prices (-subsidies) (Mill. �)

val_nx      Value of total net exports(Mill. �)

* Product group price indices (base = 100)
pi_cr       Producer price index for crops base quantity weighted
pi_lv       Producer price index for livestock products base quantity weighted
pi_fa       Producer price index for farm products base quantity weighted

pi_inc_cr   Producer incentive price index for crops base quantity weighted
pi_inc_lv   Producer incentive price index for livestock products base quantity weighted
pi_inc_fa   Producer incentive price index for farm products base quantity weighted

pi_pl       Consumer price index for plant products base quantity weighted
pi_an       Consumer price index for animal products base quantity weighted
pi_co       Consumer price index for all commodities base quantity weighted

* Product group quantity indices (base = 100)
qi_cr       Crop supply index base price weighted
qi_lv       Livestock supply index base price weighted
qi_fa       Farm supply index base price weighted
qi_pl       Human demand index for plant products base price weighted
qi_an       Human demand index for animal products base price weighted
qi_co       Human demand index for all commodities base price weighted

* Product group value indices (base = 100)
vi_cr       Crop production value index base price weighted
vi_lv       Livestock production value index base price weighted
vi_fa       Farm production value index base price weighted
vi_pl       Human consumption value index for plant products base price weighted
vi_an       Human consumption value index for animal products base price weighted
vi_co       Human consumption value index for all commodities base price weighted
vi_nx       Net export index for agricultural products at wholesale prices

* Budget
dpa_cc     Budgetary outlays for direct payments per country (including Art 68 69 and nat. top ups) (Mill. �)

dp68_cc    Budgetary outlays for Art 68 69 payments per country (Mill. �)
dpno68_cc  Budgetary outlays for direct payments per country (without Art. 68 69 payments) (Mill. �)
dptop_cc   Budgetary outlays for national top up payments per country (Mill. �)
dpEU_cc    Budgetary outlays for direct payments (without nat. top ups) per country (Mill. �)

sub_cc     Budgetary outlays for product subsidies per country (Mill. �)
tar_cc     Tariff revenue per country (Mill. �)
exs_cc     Budgetary outlays for export subsidies per country (Mill. �)
tot_cc     Total ESIM budget per country (Mill. �)
/

* The following sets are all designed for aggregating certain results over country groups
res_agg(res_comm) Results which are commodity specific and aggregated over country groups
/
* Quantity results
r_hdem      Human demand results
r_sdem      Seed demand results
r_pdem      Processing demand results
r_fdem      Feed demand results
r_tuse      Total use
r_supp      Supply results
r_quot      Quotas
r_deliv     Milk delivered for processing (1000 t)
r_fill      'Fill rate of milk quotas (in %)'
r_area      Area results
r_nx        Net export results

* Value results
r_valp     Production value  (in Mill. currency units)
r_valc     Consumption value (in Mill. currency units)
/

res_def(res_comm) Results which are commodity specific and defined per country group as identical to EU 15
/
r_trsh      Trade share results

* Price results
r_pint      Intervention price results
r_pthr      Threshhold price results
r_pup       Upper price bound result
r_pup2      Middle price bound result
r_plo       Lower price bound result

* Policy results
r_esqu      Export subsidy limit
r_trq       Tariff rate quota
r_dpay      Direct payment (per ton)
r_dp_EU     aggregate DP (including Art. 68 69 payments) without national Top ups
r_dp_68     Art. 68 69 payments only (� per t)
r_dp_top    National Top up direct payments in NMS (coupled and decoupled)(� per t)
r_dp_no68   Direct payments (� per t) only (without Art. 68 69 payments)


r_fsub      Feed subsidy (per ton)
r_hsub      Human demand subsidy (per ton)
/


res_agg_cc(res_cc) Non commodity specific results aggregated over countries
/
* Aggregated values
r_obsa      Obligatory set aside
r_totarea   Total effective area

val_cr      Farm production value of crops
val_li      Farm production value of livestock
val_fa      Farm production value

val_pl      Consumption value of plant products at wholesale prices (-subsidies)
val_an      Consumption value of animal products at wholesale prices (-subsidies)
val_co      Consumption value at wholesale prices (-subsidies)

val_nx      Net export value
/

res_def_cc(res_cc) Non commodity specific results defined as identical to EU 15
/
r_pinterm   Price index for intermediates
r_pcap      Price index for capital
r_plab      Price index for labor
r_exra      Exchange rate
r_exind     Exchange rate
r_saps      Set aside payment per ha

/

* Some sets for "slicing" the results
res_quan(res_comm) Quantity results
/
r_hdem      Human demand (1000 t)
r_sdem      Seed demand (1000 t)
r_pdem      Processing demand (1000 t)
r_fdem      Feed demand (1000 t)
r_supp      Supply (1000 t)
r_quot      Quotas (1000 t)
r_deliv     Milk delivered for processing (1000 t)
r_fill      'Fill rate of milk quotas (in %)'
r_yiel      Yield (kg per ha)
r_area      Area results (1000 ha)
r_nx        Net export results (1000 t)
r_trsh      Trade share results (%)
/


res_price(res_comm) Price results
/
r_pd        Wholesale price (� per t)
r_pp        Farmgate price (� per t)
r_pc        Consumer price (� per t)
r_pf        Feed price (� per t)
r_inc       Incentive price (� per t)
r_pint      Intervention price (� per t)
r_pthr      Threshhold price (� per t)
r_psh       Shadow price (� per t)
r_fci       Feed cost index relative to base
r_pup       Upper price bound (� per t)
r_pup2      Middle price bound (� per t)
r_plo       Lower price bound (� per t)
/


res_bal(res_comm) Commodity balances
/
r_supp      Supply (1000 t)
r_hdem      Human demand (1000 t)
r_fdem      Feed demand (1000 t)
r_pdem      Processing demand (1000 t)
r_sdem      Seed demand (1000 t)
r_nx        Net export results (1000 t) (including stock changes)
/


comm_ind(res_comm) Commodity specific indices
/
* Product specific price indices (base=100)
pi_pd  Wholesale price relative to base
pi_pp  Farmgate price relative to base
pi_pc  Consumer price relative to base
pi_pf  Feed price relative to base
pi_inc Incentive price relative to base
pi_fc  Feed price index relative to base

* Product specific quantity indices (base=100)
qi_supp  Supply relative to base
qi_hdem  Humand demand relative to base
qi_pdem  Processing demand relative to base
qi_fdem  Feed demand relative to base

* Product specific value indices (base=100)
vi_supp  Supply relative to base
vi_hdem  Humand demand relative to base
/

comm_tp(res_comm) Commodity specific technical progress
/
r_tpg      Technical progress (base = 100)
r_tpf      Technical progress in feed use (base = 100)
/

comm_policies(res_comm) Results of policies
/
r_esqu      Export subsidy limit
r_trq       Tariff rate quota
r_dpay      Direct payment (� per ton)

r_dp_EU     aggregate DP (including Art. 68 69 payments) without national Top ups
r_dp_68     Art. 68 69 payments only (� per t)
r_dp_top    National Top up direct payments in NMS (coupled and decoupled)(� per t)
r_dp_no68   Direct payments (� per t) only (without Art. 68 69 payments)

r_fsub      Feed subsidy (� per ton)
r_hsub      Human demand subsidy (� per ton)
r_tarav     Ad valorem tariff (%:100)
r_tarsp     Specific tariff   (%:100)
r_esav      Ad valorem export subsidy (� per ton)
r_essp      Specific export subsidy (� per ton)
/

comm_stocks(res_comm) Net exports and stock changes
/
r_nx     Net export results (1000 t) (including stock changes)
r_trq    Tariff rate quota
/

comm_budget(res_comm) Product specific budget
/
b_dpa    Product specific outlays for direct payments (including Art 68 and national top ups)(Mill. �)

b_dp68   Product specific outlays for Art.68 69 payments (Mill. �)
b_dptop  Product specific outlays for national top ups (Mill. �)
b_dpEU   Product specific outlays for direct payments without national top ups (Mill. �)
b_dpno68 Product specific outlays for direct payments without Art 68 69 payments (Mill. �)

b_sub    Product specific outlays for product subsidies (Mill. �)
b_tar    Product specific tariff revenue (Mill. �)
b_exs    Product specific outlays for export subsidies (Mill. �)
b_tot    Product specific total budget (Mill. �)
/


cc_ind(res_cc) Indices for product groups
/
* Product group price indices (base = 100)
pi_cr       Producer price index for crops base quantity weighted
pi_lv       Producer price index for livestock products base quantity weighted
pi_fa       Producer price index for farm products base quantity weighted

pi_inc_cr   Producer incentive price index for crops base quantity weighted
pi_inc_lv   Producer incentive price index for livestock products base quantity weighted
pi_inc_fa   Producer incentive price index for farm products base quantity weighted

pi_pl       Consumer price index for plant products base quantity weighted
pi_an       Consumer price index for animal products base quantity weighted
pi_co       Consumer price index for all commodities base quantity weighted

* Product group quantity indices (base = 100)
qi_cr       Crop supply index base price weighted
qi_lv       Livestock supply index base price weighted
qi_fa       Farm supply index base price weighted
qi_pl       Human demand index for plant products base price weighted
qi_an       Human demand index for animal products base price weighted
qi_co       Human demand index for all commodities base price weighted

* Product group value indices (base = 100)
vi_cr       Crop production value index base price weighted
vi_lv       Livestock production value index base price weighted
vi_fa       Farm production value index base price weighted
vi_pl       Human consumption value index for plant products base price weighted
vi_an       Human consumption value index for animal products base price weighted
vi_co       Human consumption value index for all commodities base price weighted

/

cc_price_ind(cc_ind) Price indices for product groups
/
* Product group price indices (base = 100)
pi_cr       Producer price index for crops base quantity weighted
pi_lv       Producer price index for livestock products base quantity weighted
pi_fa       Producer price index for farm products base quantity weighted

pi_inc_cr   Producer incentive price index for crops base quantity weighted
pi_inc_lv   Producer incentive price index for livestock products base quantity weighted
pi_inc_fa   Producer incentive price index for farm products base quantity weighted

pi_pl       Consumer price index for plant products base quantity weighted
pi_an       Consumer price index for animal products base quantity weighted
pi_co       Consumer price index for all commodities base quantity weighted
/

cc_quan_ind(cc_ind) Quantity indices for product groups
/
* Product group quantity indices (base = 100)
qi_cr       Crop supply index base price weighted
qi_lv       Livestock supply index base price weighted
qi_fa       Farm supply index base price weighted
qi_pl       Human demand index for plant products base price weighted
qi_an       Human demand index for animal products base price weighted
qi_co       Human demand index for all commodities base price weighted
/

cc_value_ind(cc_ind) Value indices for product groups
/
* Product group value indices (base = 100)
vi_cr       Crop production value index base price weighted
vi_lv       Livestock production value index base price weighted
vi_fa       Farm production value index base price weighted
vi_pl       Human consumption value index for plant products base price weighted
vi_an       Human consumption value index for animal products base price weighted
vi_co       Human consumption value index for all commodities base price weighted
/


cc_values(res_cc) Production consumption and trade values
/
* Aggregated values
val_cr      Farm production value of crops (Mill. �)
val_li      Farm production value of livestock (Mill. �)
val_fa      Farm production value (Mill. �)

val_pl      Consumption value of plant products at wholesale prices (-subsidies) (Mill. �)
val_an      Consumption value of animal products at wholesale prices (-subsidies) (Mill. �)
val_co      Consumption value at wholesale prices (-subsidies) (Mill. �)

val_nx      Value of total net exports(Mill. �)
r_bfshr      Biofuel share in the EU27 in percent of total transportation fuel consumption
r_bd_shr    "BioDIESEL shares in the EU27 in % of transportation fuel"
r_eth_shr   "Ethanol shares in the EU27 in % of transportation fuel"


/

cc_budget(res_cc) CAP budgetary positions
/
* Budget
dpa_cc     Budgetary outlays for direct payments per country (including Art 68 69 and nat. top ups) (Mill. �)

dp68_cc    Budgetary outlays for Art 68 69 payments per country (Mill. �)
dpno68_cc  Budgetary outlays for direct payments per country (without Art. 68 69 payments) (Mill. �)
dptop_cc   Budgetary outlays for national top up payments per country (Mill. �)
dpEU_cc    Budgetary outlays for direct payments (without nat. top ups) per country (Mill. �)

sub_cc     Budgetary outlays for product subsidies per country (Mill. �)
tar_cc     Tariff revenue per country (Mill. �)
exs_cc     Budgetary outlays for export subsidies per country (Mill. �)
tot_cc     Total ESIM budget per country (Mill. �)
/


cc_shifter(res_cc) Results of macro shifters
/
r_incg      Income growth compared to base
r_popg      Population growth compared to base
r_pinterm   Price index for intermediates
r_pcap      Price index for capital
r_plab      Price index for labor
r_exra      Exchange rate
r_exind     Exchange rate relative to base
/

res_core Core model results
/
area
yield
supply
human
process
feed
seed
tot_use
nettrad
fag_pric
whs_pric
/
*<%/SET%>


* DYNAMIC SETS
PR(cc,comm)           Products produced in that particular country
PR_EU(comm)        Products produced in the EU
PS(cc,comm)           Products with a domestic price in that particular country
PPF(cc,comm)          Products with a feed price in that particular country
PPC(cc,comm)          Products with a consumer price in that particular country
HD(cc,comm)           Products consumed by private households
HD_(cc,comm)           Products consumed by private households
HD_RAPEU(CC,COMM)     Rape oil consumed by private households
HD_POTATO(CC,COMM)    Potatoes consumed by private households in all countries
HD_CECBF(CC,COMM)     Beef consumed by private households in CEECs
FD(cc,comm)           feed products
PPP(cc,comm)          Products with a producer price in that particular country
PROC(cc,comm)         Products which will be processed
SEED(cc,comm)         Arable products with seed demand
SETAS_CRP(cc)         Countries with crops produced on setaside land in base situation
SETAS_CRP1(cc,comm)   Crops produced on setaside land
NQ(cc,comm)           Non-quota products
QU(cc,comm)           Quota products
QU_S(CC)              Countries with sugar quotas
QU_SUGAR(CC,COMM)     Countries with sugar quotas
NQ_S(CC)              Countries without sugar quotas
NQ_M(CC)              Countries without milk quotas
QU_M(CC)              Countries with milk quotas
MEMBER(cc)            Index of EU member countries
NOMEMBER(cc)          Index of European countries which are no EU member
NX(cc,comm)           Products which are traded
NX_EU(comm)           Products which are traded in one countries of the EU

FR(cc,feed,livest)    Feed components included in feed rates
EXPSUB(cc,it)         Products with export subsidies
NEXPSUB(cc,it)        Products without export subsidies
OILSPROC(cc,comm)     oilseed processing activites
PROC_CER_S(cc,comm)   processing of corn wheat or sugar to ethanol
PROC_OIL_D(cc,comm)   processing of oils to biodiesel
FEDRES(cc,comm)       countries producing residual feeding stuff
MILKPROC(cc,comm)     milk processing activities
SMP(cc,comm)          countries with SMP production
PAST(cc,comm)         pasture land
NPAST(cc,comm)        arable land but not pasture land
PROC_OIL(cc,comm)     countries which are processing oilseeds
PROC_MLK(cc,comm)     countries which are processing milk
MILK_CONT(cc,comm)    milk content: fat and protein
PROC_DAIRY(cc,dairy_comp,comm) Fat or protein demanded for milk processing
MILKPROC_exSMP(cc,comm)  processed milk products excl SMP
FD_MLK(cc)            feed milk
MILK_(cc,comm)         milk
CER_N_DURUM(one,comm) Cereals but no durum
CER_DURUM(one,comm)   Durum eligible for direct payments
CER_OIL(one,comm)     Oilseeds eligible for direct payments
FLOOR(IT)             Products with minimum (intervention) price plus tariff
THRESH(IT)            Products with minimum (intervention) price plus threshold price
TAR(IT)               Products for which EU price formation is dependent on world market price + tariffs or export subsidies
VOLSA(cc,comm)        Voluntary setaside
VOLSAQ(cc,comm)       Voluntary setaside as quota in Agenda 2000 regions
STRA(cc,comm)         straw in sets of commodity

SFP__REG(one)         Regions applying SFP
QU_NOSA(cc,comm)
* Dynamic sets which are used in the transformation of results
R_THR(sim1,it)   Yes if product is a thresh product in the respective year
R_INT(sim1,it)   Yes if product is an intervention product in the resp. year
R_TAR(sim1,it)   Yes if the product is a tariff product in the resp. year
R_MEMBER(cc,sim1) Yes if country is member
AGENDA(cc)
MTR(cc)
i_biofuel(energ,comm)
lino(cc,comm)    lignocellosic biomass cultivation regions
;

*<%SET%>
SETS

lag_period
/
             t_1   one period back
             t_2   two periods back
/


*<%/SET%>


onelag(cc,comm)
nolag(cc,comm)
twolag(cc,comm)

* ============================================ *
* Sets related to the stochastic part of ESIM  *
* ============================================ *

strun Number of runs for the stochastic simulation in 2015
/1*86/

r_st_type Type of result: deterministic - expected value - variance - standard deviation
/det, ev, var, sd/

data_base
/         PROD
          SDEM
          HDEM
          FDEM
          PDEM
/
ethanol_inputs(i) Crops used for ethanol production
        /    CORN
             CWHEAT
             SUGAR

             BARLEY
             RYE
             OTHGRA /



shift(cc)
/US
 ROW/

;
$include "set_star_input.gms"

delay_r(cc) = 0.0

SET ecc(i) exogenous cost components
   /
   INTERMED  intermediates
   CAPITAL   capital
   LABOR     labor
   ENERGY    energy
   FERTIL    fertilizer
   /
;