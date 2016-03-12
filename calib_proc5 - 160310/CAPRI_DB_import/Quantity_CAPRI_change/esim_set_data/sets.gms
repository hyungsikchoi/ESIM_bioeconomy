*<%SET%>
SETS
    i   Products included in the ESIM model
         /
             CWHEAT
             DURUM
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
             STRA
             PULS

             SETASIDE
             GLUTFD
             OENERGY
**New from CAPRI
             OPROT
             FENE        OENERGY_CAPRI( MOLA TOMA OVEG APPL OFRU CITR)
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
             BIODIESEL_NAGR
             ETHANOL
             ETHANOL_NAGR

             C_OIL




                        /
comm(i) Agri-food commodities
         /   CWHEAT
             DURUM
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
             STRA
             PULS

             SETASIDE
             GLUTFD
             OENERGY
             OPROT
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

             BIODIESEL
             BIODIESEL_NAGR
             ETHANOL
             ETHANOL_NAGR


             C_OIL
*New from CAPRI
             FENE OENERGY_CAPRI

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
             DURUM
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
             MANIOC
             SMAIZE
             FODDER
             GRAS
             GLUTFD
             OENERGY
             OPROT
             SMP

***New feed from CAPRI
             DURUM
             RICE
             SUGAR
             Whey
             OTHDAIRY
             RAPOIL
             SUNOIL
             WMP
             FENE       OENERGY_CAPRI
             PULS

             rapseed
             soyoil
             CONC_MLK
             CMILK
             MILK

/



pl(comm) Plant products
/
CWHEAT
DURUM
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
*OTHDAIRY
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
Barley

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
/

i_ethanol(comm) Input in Bioethanol production

/
CORN
CWHEAT
SUGAR
/


i_ethanol_ns(comm) Input in Bioethanol production

/
CORN
CWHEAT
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
*           SETASIDE
           FAT
           PROTEIN
*           OTHDAIRY
*           OENERGY
*           OPROT
           FENE      OENERGY_CAPRI
           MILK
           CMILK
           SMAIZE
           FODDER
           GRAS
/
nt_mlk(comm)   Non tradable commodities without milk
           /
           POTATO
*           SETASIDE
           FAT
           PROTEIN
*           OTHDAIRY

*           OPROT
*           MILK
           CMILK
           SMAIZE
           FODDER
           GRAS
*NEW from CAPRI
           FENE     OENERGY_CAPRI
/

it(comm)   Tradable commodities
         /   CWHEAT
             DURUM
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
             MANIOC
             GLUTFD
             PULS    new from capri
             OTHDAIRY  new from capri
* ### NEW DAIRY PRODUCTS ###
             SMP
             WMP
             CREAM
             CONC_MLK
             ACID_MLK
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
*CAPRI change
             OPROT
             OENERGY

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
   DURUM
   BARLEY
   CORN
   RYE
   OTHGRA
   RICE
 /

switch_comm(bound_comm)   Products which might change the set in price formation mechanism
         /
             CWHEAT
             DURUM
             BARLEY
             CORN
              /




ag(comm)     Agricultural products produced on-farm
         /   CWHEAT
             DURUM
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
             MANIOC
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
             DURUM
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
             MANIOC
             SMAIZE
             FODDER
             GRAS
             SETASIDE
*             GLUTFD
             PALMOIL

            /
nonsug(crops)    Arable crops other than sugar
         /   CWHEAT
             DURUM
             BARLEY
             CORN
             RYE
             OTHGRA
             RICE
*             SUGAR
             POTATO
             SOYBEAN
             RAPSEED
             SUNSEED
             MANIOC
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
             ACID_MLK
             WHEY
* ##########################
             CMILK
             BUTTER
             CHEESE
             OTHDAIRY
        /




comcrop(crops) Arable crops eligible for direct payments
           /  CWHEAT
              DURUM
              BARLEY
              CORN
              RYE
              OTHGRA
              SOYBEAN
              RAPSEED
              SUNSEED
              SMAIZE
              /

    time /1990*2005,base,2006*2030/
    sim1(time) Time horizon of the model runs /base, 2008*2030/
    hist(time) Time period for historical data /1990*2005/
    sim_base(sim1) Time horizon of the model runs in BASELINE /base, 2008*2020/
    sim_trial(sim1) Time horizon of the model runs in BASELINE /base, 2008*2010/

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
             DURUM
             BARLEY
             CORN
             RYE
             OTHGRA
             RICE
*             SUGAR
             POTATO
             SOYBEAN
             RAPSEED
             SUNSEED
             MANIOC
             SMAIZE
             FODDER
*             GRAS
             SETASIDE
             GLUTFD
             PALMOIL
             /
cr_n_gr_sae(comm)  Arable crop products without pasture area  and energy crops on setaside
         /   CWHEAT
             DURUM
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
             MANIOC
             SMAIZE
             FODDER
*             GRAS
             SETASIDE
             GLUTFD
             PALMOIL

             /


SET ecc(i) exogenous cost components
   /
   INTERMED  intermediates
   CAPITAL   capital
   LABOR     labor
   ENERGY    energy
   FERTIL    fertilizer
   /
;
