********************************************************************************
$ontext

   CAPRI project

   GAMS file : SETS.GMS

   @purpose  : Define SETS (= list of labels used for indices
               in GAMS) for the CAPRI project

   @author   : W. Britz and others
   @date     : 27.10.09
   @since    : Spring 2005
   @refDoc   :
   @seeAlso  :

   changes
        06.11.09    T Jansson   Added the land class ASYM which is > UAAR to
                                the set of columns. Also removed SGMF from
                                the set of marketable outputs.

$offtext
********************************************************************************
*
  SET LINES /0*10000/;
*
  SET TTT / 40*99,00*39/;
*
  SET SIMYY_YBAS / 1940*1999,2000*2050,Y,BAS,BASM,CUR,CAL,TRD,SRT,MEAN,S1*S50/;
*
  SET SIMYY(SIMYY_YBAS) / 1940*1999,2000*2050/;
*
  SET Y_BAS_CUR(SIMYY_YBAS)     / Y,BAS,CUR /;
  SET basCalCur(SIMYY_YBAS)     / BAS,CAL,CUR /;
  SET basCal(basCalCur)          / BAS,CAL /;

  SET SIMYYY(SIMYY);
  ALIAS(SIMYYY,SIMYYY1);

  SET SIMYYYY(SIMYY);

  SET XMILK / XMILK /;
*
  PARAMETER CALYEA "Numerical value for the calendar year";
*
  SCALAR p_iYear;
  p_iYear = 1940;
  LOOP(SIMYY,
      CALYEA(SIMYY) = p_iYear;
      p_iYear = p_iYear + 1;
  );

  SET TOP / TOP /;


  alias(*,D1,D2,D3)

  SET SET_BIO_FUEL_ROWS "Bio-ethanol and bio-diesel" /
      BIOE   Bioethanol
      BIOD   Biodiesel
      /;


*
*---------------------- production activities -------------------------------------------
*

   SET CERE_COLS "Cereals according to Grandes Cultures definition " /

      SWHE   "Soft wheat production activity"
      DWHE   "Durum wheat production activity"
      RYEM   "Rye and meslin production activity"
      BARL   "Barley production activity"
      OATS   "Oats and summer cereal mixes production activity without triticale"
      MAIZ   "Grain maize production activity"
      OCER   "Other cereals production activity including triticale"
   /;

   SET OILS_COLS "Oilseeds according to Grandes Cultures definition " /

      RAPE   "Rape production activity"
      SUNF   "Sunflower production activity"
      SOYA   "Soya production activity"

   /;
*
   SET MFCACT "Fixed crop production activities comprised in model" /

      OOIL   "Other seed production activities for the oil industry"
      OIND   "Other industrial crops production activity"
*
*     Production measured in constant prices
*
      NURS   "Nurseries production activity"
      FLOW   "Flowers production activity"
      OCRO   "Other crops production activity"
      NECR   "New energy crops"
   /;


*
  SET FEDACT_COLS "Feed producing endogenous crop activities" /
*
*     Fodder production on arable land
*
      MAIF   "Fodder maize production activity"
      ROOF   "Fodder root crops production activity"
      OFAR   "Fodder other on arable land production activity"
*
*     Production on grassland
*
      GRAE   "Gras and grazings production activity extensive"
      GRAI   "Gras and grazings production activity intensive"
  /;

  SET GRAS_COLS "GRAS cols used in energy indicator stuff" /
      PGRAS, MGRAS, HGRAS, ALL
  /;


*
   SET MECACT "Endogenous crop production activities comprised in model" /
*
*         (Cereals)
*
      SET.CERE_COLS
      PARI   Paddy rice production activity,
*
*         (Oilseeds)
*
      SET.OILS_COLS
      OLIV   Olive production activity for the oil industry
*
      PULS   Pulses production activity
      POTA   Potatoes production activity
      SUGB   Sugar beet production activity
      TEXT   Flax and hemp production activity
      TOBA   Tobacco production activity
*
      TOMA   Tomatoes production activity
      OVEG   Other vegetables production activity
      APPL   Apples  pears and peaches production activity
      OFRU   Other fruits production activity
      CITR   Citrus fruits production activity
      TAGR   Table grapes production activity
      TABO   Table olives production activity
      TWIN   Wine production activity
*
      FALL   Fallow land
*
*     *** set aside block
*
      ISET   Set aside obligatory idling
      GSET   Set aside obligatory used as grass land
      TSET   Set aside obligatory fast growing trees
      VSET   Set aside voluntary
      ,
      SET.FEDACT_COLS
   /;


    SET MEAACT "Endogenous animal production activities comprised in model" /
*
      DCOL   Dairy cows production activity low yield
      DCOH   Dairy cows  production activityhigh yield
      BULL   Male adult fattening activity low final weight
      BULH   Male adult fattening activity high final weight
      HEIL   Heifers fattening activity low final weight
      HEIH   Heifers fattening activity high final weight
*
      SCOW   Suckler cows production activity
      HEIR   Heifers raising activity
      CAMF   Calves male fattening activity
      CAFF   Calves female fattening activity
      CAMR   Calves male raising activity
      CAFR   Calves female raising activity
*
      PIGF   Pig fattening activity
      SOWS   Sows for piglet production
*
      SHGM   Sheep and goats activity for milk production
      SHGF   Sheep and goats activity for fattening
*
      HENS   Laying hens production activity
      POUF   Poultry fattening activity
    /;


   SET DCACT "Crop activities aggregated in data base"
   /
      GRAS   "Gras and grazings production activity"
      NONF   "Non food production on set-aside"
      OSET   "Obligatory set-aside"
      SETA   "Set aside total"
    /;

   SET DAACT "Animal activities aggregated in data base"
   /
      DCOW   Dairy cows production activity
      BULF   Male adult fattening activity
      HEIF   Heifers fattening activity
    /;

      SET Add_LandUse "additional codes for land use classes"
   /
     OART      " artificial"
     ARAO      "(other) arable crops - all arable crops excluding rice and fallow (see also definition of ARAC below)"
*     PARI     "paddy rice (already defined)"
     GRAT      "temporary grassland (alternative code used for CORINE data, definition identical to TGRA"
     FRCT      "fruit and citrus"
     OLIVGR    "Olive Groves"
*     VINY     "vineyard (already defined)"
     NUPC      "nursery and permanent crops (Note: the aggregate PERM also includes flowers and other vegetables"
     BLWO      "board leaved wood"
     COWO      "coniferous wood"
     MIWO      "mixed wood"
     POEU      "plantations (wood) and eucalyptus"
     SHRUNTC   "shrub land - no tree cover"
     SHRUTC    "shrub land - tree cover"
     GRANTC    "Grassland - no tree cover"
     GRATC     "Grassland - tree cover"
*     FALL     "fallow land (already defined)"
     OSPA      "other sparsely vegetated or bare"
     INLW      "inland waters"
     MARW      "marine waters"
     KITC      "kitchen garden"
   /;

  SET Add_LandUseAgg "additional codes land use aggregates"
  /
     LAND       "Land area - Total"
     SVBA       "sparsely vegetated or bare"
     OLND       "other land - shrub, sparsely vegetated or bare"
     OLNDARTIF  "other land + artificial (aggregate used by ZPA1)"
     ARAC       "arable crops including paddy, fallow and arable fodder but excluding permanent grassland and other permanent crops "
     FRUN       "fruits, nursery and (other) permanent crops"
     WATER      "inland or marine waters"
     ARTIF      "artificial - buildings or roads"
     OWL        "other wooded land - shrub with tree cover (definition to be discussed)"
     TWL        "total wooded land - forest + other wooded land"
     SHRU       "shrub land"
*     FORE      "forest   (already defined)"
*     GRAS      "grassland (already defined)"
*     ARAB      "arable    (already defined)"
*     PERM      "permanent crops  (already defined)"
*     UAAR      "utilizable agricultural area (already defined)"
     ARTO       "total area - total land and inland waters"
     ARTM       "total area including marine waters"
     CROP       "crop area  - arable and permanentcrops but no permanent grassland"
  /;



*
*---------------------- balance positions -------------------------------

   SET FRMBAL_COLS "Positions of the farm balance" /
      GROF   "Gross production or use"
      SEDF   "Seed use on farm"
      LOSF   "Losses on farm"
      INTF   "Internal use on farm"
      NETF   "Net production or use EAA"
   /;

   SET TRDPOS_COLS "External trade positions"  /
      IMPE   "Imports from Europe"
      IMPW   "Imports from the world"
      IMPT   "Imports total"
      EXPE   "Exports from Europe"
      EXPW   "Exports from the world"
      EXPT   "Exports total"
   /;

   SET MRKBAL_COLS "Positions of the market balance" /
      FEDM   "Feed use on market"
      SEDM   "Seed use on market"
      INDM   "Industrial use market"
      PRCM   "Processing to derived products market"
      BIOF   "Processing to biofuels"
      HCOM   "Human consumption market"
      LOSM   "Losses on market"
      STCM   "Stock changes on market"
      SADM   "Statistical adjustment on markets (difference USAP and GROF)"
   /;

   SET BALPOS_COLS  "Position of the farm and market balance" /
*
*     *** Farm balance
*
      SET.FRMBAL_COLS
*
*     *** Imports and exports
*
      SET.TRDPOS_COLS
*
*     *** domestic marketable production
*
      MAPR   "Domestic marketable production",
*
*     *** Market balance
*
      SET.MRKBAL_COLS
*
      DOMM   Domestic use on market
   /;



*   Partial Standard Shares
    SET sets_TSGM_POS/TSGM,P1,P11,P2,P3,P4,P5,sgm_gr,sgm_fc,R,Rd,Rs,Rv,FODDERTYPE,D21_HA,E_HA,J18_HIVE,P1_13_14,G04_HA,G1_G2,G03_HA,J07_HEADS,P41,P42/;

*
    SET FODDIS  "Non tradeable feedingstuffs as inputs without straw"
       /
         FGRA   "Gras"
         FMAI   "Fodder maize"
         FOFA   "Fodder other on arable land"
         FROO   "Fodder root crops"
         FCOM   "Milk for feeding"
         FSGM   "Sheep and Goat Milk for feeding"
      /;
*
*
    SET FODDI_ROWS   "Non tradeable feedingstuffs as inputs with straw"
       /
         SET.FODDIS,
         FSTR   Straw
       /;


     SET FEDTRD_ROWS "Feed inputs" /

      FCER   Feed cereals
      FPRO   Feed rich protein
      FENE   Feed rich energy
      FMIL   Feed from milk product
      FOTH   Feed other

    /;

     SET FEED_ROWS "Feed inputs" /

      SET.FEDTRD_ROWS
      SET.FODDI_ROWS

    /;
*
*---------------------- Nutrient content  -------------------------------
*
   SET REQS_MOD "Nutrient contents or energy requirement" /
*
      ENNE   Net energy lactation
*
      CRPR   Crude protein
      LISI   Lysine
*
      DRMN   Dry matter min
      DRMX   Dry matter max
*
      FIDI   Fiber digestible
      FILG   Fiber long
      FICO   Fiber dairy cows
      FICT   Fiber cattle
      FISM   Fiber sheep and goat milk
      FISF   Fiber sheep and goat fattening
   /;
*
   SET REQS_SET "Nutrient contents or energy requirement, as calculated by requirement functions" /
*
      SET.REQS_MOD
*
      DRMA   Dry matter
*
      ENMR   Net energy raising
      ENMC   Net energy chicken
      ENMH   Net energy horses
      ENMP   Net energy pigs

    /;
*
   SET REQSR_SET "Animal requirements" /
*
      SET.REQS_MOD
      SET.FEED_ROWS
*
    /;
*
   SET NBIL_COLS Nutrient balance positions
              /
$ontext
*          Export:
                NEXP "Export with harvest"
                NH3O "Ammonia losses from organic fertilizer"
                NH3G "Ammonia losses from manure on grazings"
                NH3H "Ammonia losses from manure in housing"
                NH3S "Ammonia losses from manure in storage sytems"
                NH3A "Ammonia losses from manure during application"
                NH3M "Ammonia losses from mineral fertiliser"
                NH3T "Ammonia losses total"
*# 010307:
                GAST "Gaseous losses of N total"
                RUNT "Runoff losses total"
*          Import:
                MINE "Import by mineral fertilizer"
                EXCR "Import by manure"
                BFIX "Biological fixation"
                NATM "Atmospheric deposition"
                MILS "Mineralisation from soil organic matter"
                CRES "Crop residues"
                SURS "Surplus to soil"
                SURT "Surplus"
*# 010307:
*          Disaggregation of surplus to soil:
                LEAC "Leaching"
                DNIT "Denitrification"
                ACCU "Accumulation in soil organic matter"
$offtext
*                AVAILA      "Nitrogen applied according to availability assessment by the farmer "
                EXPPRD      "Nitrogen export with harvested material and crop residues or animal products"
                ATMOSD        "Atmospheric deposition"
                CRESID       "Crop residues"
                NUPTK       "Nitrogen in plant above-ground plant material - straw+product"
*AL200901 additional disaggregation of crop residues
*##ig to check: STRANR,PLANTR,STRANL,STRANM (not in FW files)
                STRANR      "Straw left on or returned  STRANL to the field STRANM"
                PLANTR      "Plant residues left on the fiels (e.g. beet leaves) as given in the table RESID in fertpar.gms"
                STRANL      "Straw left on the field as e.g. stubbles and ploughed into the soil"
                STRANM      "Straw returned to the field e.g. with manure"
                STRACM      "Straw carbon returned to the field e.g. with manure"
                STRAWN      "Total nitrogen in straw"

                BIOFIX        "Biological fixation"
                MINSAT      "Mineralisation from soil organic matter"
*                NETMAN      "Supply from manure is excretion net of runoff and gaseous emissions"
*                NETMAN2     "Manure application version 2"
                MINFER      "Mineral fertilizer applied including some parts lost in runoff or emissions"
                GASMIN      "Losses in gaseous emissons NH3 and N20 and NOX from mineral fertilizer"
                RUNMIN      "Losses in runoff from mineral fertilizer"
                SURSOI       "Surplus to soil"
                SURTOT       "Total surplus is nutrient input net of exports in products"
                LEACHI       "Leaching below rooting zone to groundwater or surface waters"
                DENITR      "Denitrification below rooting zone"
                ACCUMU      "Accumulation of surplus in soil organic matter"
                EXCRET      "Nitrogen in excretion of animals"
                MANFER      "Manure-N application to the soil. Losses occurring during housing and manure storage are already subtracted. MANFER=MANLIQ+MANSOL"
                MANGRA      "Manure-N deposited directly on grazed land."
                MANFCN      "Manure-C/N ratio in the finally applied manure"
                GASMAN      "N in gaseous losses during manure management as NH3 and N2O and N2 and NOX"
                NOXGRA      "NOx losses from manure on grazings"
                NOXMIN      "NOx losses from mineral fertiliser"
                N2OMIN      "N2O losses from mineral fertiliser"
                NOXAPP      "NOx losses from manure applications on soils"
                NOXHOU      "NOx losses from manure in housing"
                N2OHOU      "N2O losses from manure in housing"
                NOXSTO      "NOX losses from manure in storage sytems"
                N2OSTO      "N2O losses from manure in storage sytems"
                NH3MAN      "N in gaseous losses during manure management as NH3"
                NH3GRA      "Ammonia losses from manure on grazings"
                NH3HOU      "Ammonia losses from manure in housing"
                NH3STO      "Ammonia losses from manure in storage sytems"
                NH3APP      "Ammonia losses from manure during application"
                NH3MIN      "Ammonia losses from mineral fertiliser"
                NH3TOT      "Ammonia losses total"
                GASTOT      "Gaseous losses of N total"
                RUNTOT      "Runoff losses total"
                RUNSUR      "N in runoff from the soil surface"
                RUNGRA      "N from manure deposited by grazind animals in runoff from the soil surface"
                RUNMAN      "N in runoff from manure management"
                RUNHOU      "N in runoff from manure management"
*for testing:
                EXCR2       "total excretion version 2"
                IMPORT      "Total imports"
                 /;

*
    SET GHGS_DEL
    /
      N2OMAN     Direct nitrous oxide emissions stemming from manure managment and application except grazings(IPCC)
      N2OMA2     Direct nitrous oxide emissions stemming from manure management (only housing and storage) (IPCC)
      N2OAP2     Direct nitrous oxide emissions stemming from manure application on soils except grazings (IPCC)
      N2OAPL     Direct nitrous oxide emissins from manure application on soils (except grazing) due to livestock production
      N2OGRA     Direct nitrous oxide emissions stemming from manure managment on grazings (IPCC)
      N2OSYN     Direct nitrous oxide emissions from anorganic fertilizer application (IPCC)
      N2OSYL     Direct nitrous oxide emissions from anorganic fertilizer application due to livestock production
      N2OSYS     Direct nitrous oxide emissions from anorganic fertilizers application saved due to the application of manure
      N2OWAS     Direct nitrous oxide emissions from animal waste on the field (IPCC)
      N2OHIS     Direct nitrous oxide emissions from cultivation of histosols (IPCC via Miterra)
      N2OHIL     Direct nitrous oxide emissions from cultivation of histosols (IPCC via Miterra) due to livestock production
      N2OLEA     Indirect nitrous oxide emissions from leaching (IPCC via Miterra)
      N2OLEL     Indirect nitrous oxide emissions from leaching due to livestock production
      N2OLES     Indirect mitrous oxide emissions from leaching of mineral fertilizer application saved due to the application of manure
      N2OCRO     Direct nitrous oxide emissions from crop residues (IPCC)
      N2OCRL     Direct nitrous oxide emissions from crop residues due to livestock production
      N2OFIX     Direct nitrous oxide emissions from nitrogen fixing crops (IPCC)
      N2OAMM     Indirect nitrous oxide emissions from ammonia volatilisation (IPCC)
      N2OAML     Indirect nitrous oxide emissions from ammonia volatilisation due to livestock production
*
      N2OAPP     Direct nitrous oxide emissions from fertilizer application not including grassland (IPCC)
      N2OPRD     Nitrous oxide emissions during fertilizer production (Expert Data)
      N2OPRL     Nitrous oxide emissions during fertilizer production due to livestock production
      N2OPRS     Nitrous oxide emissions from anorganic fertilizers production saved due to the application of manure
      N2ODEP     Direct nitrous oxide emissions from atmosferic deposition (IPCC)
      N2OBUR     Nitrous oxide emissions from land use change (IPCC)
      N2OBUL     Nitrous oxide emissions from land use change due to feed use of european livestock production (IPCC)

*
      CH4EN1     Methane emissions from enteric fermentation (IPCC)
      CH4EN2     Methane emissions from enteric fermentation (IPCC)
      CH4MA1     Methane emissions from manure management (IPCC)
      CH4MA2     Methane emissions from manure management (IPCC)
      CH4RIC     Methane emissions from rice production (IPCC)
      CH4BUR     Methane emissions from land use change (IPCC)
      CH4BUL     Methane emissions from land use change due to feed use of european livestock production (IPCC)

*
      CO2PRD     Carbon Dioxide emissions during fertilizer production
      CO2PRL     Carbon Dioxide emissions during fertilizer production due to livestock production
      CO2PRS     Carbon Dioxide emissions from anorganic fertilizers production saved due to the application of manure
      CO2DIE     Carbon Dioxide emissions from diesel consumption in machinery use
      CO2DIL     Carbon Dioxide emissions from diesel consumption in machinery use due to livestock production
      CO2OFU     Carbon Dioxide emissions from consumption of other fuels
      CO2OFL     Carbon Dioxide emissions from consumption of other fuels due to livestock production
      CO2ELE     Carbon Dioxide emissions from electricity consumption
      CO2ELL     Carbon Dioxide emissions from electricity consumption due to livestock production
      CO2IND     Indirect Carbon Dioxide emissions from machinery and buildings
      CO2INL     Indirect Carbon Dioxide emissions from machinery and buildings due to livestock production
      CO2FTR     Carbon Dioxide emissions from feed transport
      CO2FPR     Carbon Dioxide emissions from feed processing
      CO2SEE     Carbon Dioxide emissions from seed production
      CO2SEL     Carbon Dioxide emissions from seed production due to livestock production
      CO2PPT     Carbon Dioxide emissions from plant protection
      CO2PPL     Carbon Dioxide emissions from plant protection due to livestock production
      CO2BIO     Carbon dioxide emissions from land use change due to losses of carbon in biomass and litter (IPCC)
      CO2BIL     Carbon dioxide emissions from land use change due to losses of carbon in biomass and litter caused by feed use of european livestock production(IPCC)
      CO2SOI     Carbon dioxide emissions from land use change due to soil carbon losses (IPCC)
      CO2SOL     Carbon dioxide emissions from land use change due to soil carbon losses caused by feed use of european livestock production (IPCC)
      CO2SEQ     Carbon dioxide emissions due to lost carbon sequestration of grassland (for grassland negative)
      CO2SQL     Carbon dioxide emissions due to lost carbon sequestration of grassland (for grassland negative) caused by feed use of european livestock production
      CO2HIS     Carbon dioxide emissions from the cultivation of histosols
      CO2HIL     Carbon dioxide emissions from the cultivation of histosols due to livestock production


/;


 SET GHGS_ROWS
    /
      SET.GHGS_DEL

      GWPT   Global Warming Potential, CO2 equivalents (IPCC)
      CARB   carbon sinks
  /;

SET MFIND_COLS "Multifunctionality indicators"    /
*
*      --- human consumption at regional level
*
                S1COM        "Self-sufficiency 1 commodity"
                S1CAL        "Self-sufficincy 1 calories"
                S1FAT        "Self-sufficiency 1 fat"
                S1PRO        "Self-sufficiency 1 protein"
*
                S2COM        "Self-sufficiency 2 commodity"
                S2CAL        "Self-sufficiency 2 calories"
                S2FAT        "Self-sufficiency 2 fat"
                S2PRO        "Self-sufficiency 2 protein"
*
                UAACAP       "Utilized agricultural area per capita"
                ARACAP       "Utilized non-grass land agricultural area per capita"
                RUCAP        "Ruminant units per capita"
                GRCAP        "Granivor units per capita"
                SHANN        "Shannons diversity index"
                RUDE         "Ruminant density GRAS"
*
                MGVA_PER_HA     "Agricultural income per ha UAAR"
                N_CAL_PER_HA    "Calories produced per ha of UAAR"
                N_CAL_PER_EURO  "Calories produced per Euro of intermediate cost"
                MGVA_PER_HEAD   "Agricultural income per capita"
                TOOU_PER_TOIN   "Euro output value per euro intermediate cost"
                PRME_PER_TOOU   "Euro premiums per euro outputs"
                LandRent        "Agricultural rent pr ha UAAR"
    /;

   SET NCNC_POS /

      N_CAL       "Nutrient content, calories"
      N_FAT       "Nutrient content, fat"
      N_PRO       "Nutrient content, protein"
   /;


   SET WELFPOS_SET "Positions of the welfare calculation" / PROFITPROC   "Profit of the processing industry"
                                                            PROFITDAIRY  "Profit of the dairy industry"
                                                            PROFITAGR    "Profit of agriculture"
                                                            PROFITFEED   "Profit of feed processors"
                                                            ProfitFeed1
                                                            ProfitLandUse "Profit of non-agricultural land use",
                                                            TARIFFREV    "Tariff revenues"
                                                            PSES         "Producer support equivalents in OECD definition (PSEs)"
                                                            TRQRents     "Tariff Rate Quota Rents"
                                                            WELFARE      "Total welfare"
                                                             /;

   SET ARMPRICE_SET / ARM1P      "Average price in market, weighted from domestic producer and import price"
                      ARM2P      "Average import price"
                      PPRI       "Producer pricex"
                      CPRI       "Consumer price"
                      EXPSUB     "Per unit export subsidy"
                      PROCMARG   "Revenue from processing minus feedstock costs per unit of output"
                      CMrg       "Absolute difference between consumer and average market price"
                      PMrkMrg
                      PMrg
                      BioProcMarg "Revenue from biofuel and secondaries per feedstock divided by feedstock cost"
                     /;
   SET MARKET_BALPOS / ARM1      "Domestic consumption, Armington aggregate of domestic sales and import aggregate"
                       ARM2      "Armington aggregate of import quantities"
                       DSales    "Domestic sales"
                       TrqImports /;
   SET DAIRYRES_SET / FATSVAL,PROTVAL /;
   SET MQPOS_SET    / HCON    "Human consumption in primary product equivalents"
                      PROC    "Processing (excluding to bio-fuel) in primary product equivalents"
                      IMPORTS "Imports"
                      EXPORTS "Exports"/;

   SET FEO_ITEMS_COLS "Feoga budget calculation position"/
       SILA,CATT,BEAS,ITOT,ITEC,IOTH,IDEP,IPRV,IFIN,ITO1,CSE,CSE1,EXPR,EXP1,RFAI,RFA1,RFPR,RFP1,RFP2,RFP3,OTHR,OTH1,OTH2,OTH3,LEVY,TREV,
       INTC_F,INTC_D,INTC_O,FEOA,CSET /;

   SET FEOGA_COLS /
      FEOP    Premiums
      FEOE    Exports subsidies
      FEOS    Intervention stock cost
      FEOC    Consumption aid
      FEOF    Aid to feed industry
      FEOI    Aid to processing industry
      FEOS_T
      FEOS_F
      FEOS_O
      FEOS_D
   /;

   SET ADD_MARKET_COLS / INCE           "Income"
                         INTK
                         INTD1
                         INTP1
                         ExpsVal        "Value of subdidised exports without cut factor"
                         C_TOST         "Shift parameter for intervention stock release function"
                         C_TOST1        "Shift parameter for intervention stock purchase function"
                         C_TOST2        "Scale parameter for intervention stock release and purchase functions"
                         AREP
                         Yield
                         ExportsUvae    "Unit value exports"
                         Arm1V          "Value of Armington 1 aggregate  (imports and domestic sales)"
                         Arm2V          "Value of Armington 2 aggregates (trade flows from different importers)"
                         QEXPS
                         ExpCost
                         Demand         "Aggregate of demand positions"
                         Corr           "Scaler between physical units and Armington aggregator"
                         TrqNT          "TRQ quota quantity as applied"
                         TrqNT_notified "TRQ quota quantity as notified"
                         ImportsR       "Imports under TRQ entering the calculation of the rents"
                         Rent           "TRQ rent"
                         Rent_per_unit  "TRQ rent per unit of in quota imports"
                         TaAppl         "Applied ad valorem tariff"
                         TsAppl         "Applied specific tariff"
                         Weights
                         TAPREF         "Preferential ad valorem tariff"
                         TAMFN          "MFN ad ad valorem tariff"
                         TSPREF         "Preferential specific tariff"
                         TSMFN          "MFN preferential tariff"
                         Exporter
                         adval_equ      "Ad valorem equivalent tariff"
                         adval_equf
                         adVal_equn
                         tarMult
                         RED            "Reduction of prefential tariffs compared to MFN ones"
                         RED_Tarv
                         EntryPrice
                         Pimp
                         Pimp_adval ,
$IF %BASELINE%==ON       SET.FEO_ITEMS_COLS,
                         ExpSub1
                         FeedDiff
                         ImportQ        "Bilateral import quantity"
                         ImportP        "Bilateral import price"
                         TCost          "Bilateral transport margin"
                         Fob            "Free on board"

                         FeedCal        "Feed demand in calibration point"
                         PPriCal        "Producer price in calibration point"
                         /;


    SET INTERM_COCO_COLS "Intermediate positions used by COCO and CAPREG"/
*
      LAMB   "Lamb data used in COCO"
*
      CAT1   "Cattle production activity less than one year (CAPREG)"
      CAT2   "Cattle production activity above one year (CAPREG)"

      FAGO   "Other annual green fodder"
      FCLV   "Clover and mixtures"
      FLUC   "Lucerne"
      FPGO   "Other perennial green fodder are usually legumes"
      TGRA   "Temporary grazings"
      PMEA   "Permanent meadows"
      PPAS   "Permanent pastures"
      ROO1   "Fodder beet"
      ROO2   "Other fodder root crops"

      FRUT   "Fruit trees used in COCO and FSS data"
      COWS   "Total cows production activity"
      CALV   "Total calves production activity"
   /;

   SET s_PS_WTO "WTO support categories" /
        Amberbox        "Amber box"
        MarketPriceSup  "Market price support"
        AmberBoxOther   "Amber box other"
        BlueBox         "Blue box payments"
        GreenBox        "Green box payments"
        DeMinimis       "De-minimis payments"
   /;

   SET s_PS_PSE "PSE support categories" /

        PSE_A1          "A.1 Market price support"
        PSE_A2          "A.2 Support based on current output of an agricultural commodity"
        PSE_B1          "B.1 Support related to variable inputs"
        PSE_B2          "B.2 Support related to fixed capital formation"
        PSE_B3          "B.3 Support related on farm services"
        PSE_C1          "C.1 Support Based on current receipts/income"
        PSE_C2          "C.2 Based on current area/animal numbers"
        PSE_D           "D   Based on not current, production required"
        PSE_E1          "E.1 Based on not current, production not required, variable"
        PSE_E2          "E.2 Based on not current, production not required, fixed"
        PSE_F1          "F.1 Long term resource retirement"
        PSE_F2          "F.2 Non commodity outputs of good and services"
        PSE_F3          "F.3 Provided equally to all farmers, such as a flat-rate or lump-sum payment"
        PSE_G           "G   Miscellaneous payment"


   /;

   SET s_PS_budget /

        budEU     "EU contribution total"
        budPil1   "Pillar I contribution"
        budPil2   "Pillar II contribution"
        budRestEU "Other EU contribution"
        budNat    "National contribution"
        budNatEU  "National contribution to EU budget",

*
*       --- WTO categories
*
        set.s_PS_WTO,
*
*       --- PSE categories
*
        set.s_PS_PSE
    /;
*
    SET MARKET_POLICY_COLS /
*
*     *** Political market intervention and FEOGA budget
*
      INTP   Intervention purchases
      INTS   Intervention sales
      STKS   Intervention stocks
      EXPS   Exports subsidized
*
      FEOG   "Costs to tax payer",

      INTD   Intervention releases
      ISCH   Intervention stock change
      ISTK   Intervention stocks
*
      MinBordP Minimum Border price used to determine levies
      PSEI   OECD producer support equivalent indirect
      PSED   OECD producer support equivalent direct
      FSEI   Feed support equivalent indirect
      CSEI   OECD consumer support equivalent indirect
      CSED   OECD consumer support equivalent direct
      PRCA   Processing aid in Euro per ton
      INTC_T Technical costs of intervention stocks in Euro per ton

      TARS_applied   Tariff specific applied
      TARS_bind      Tariff specific binding
      TARV_applied   Tariff ad valorem applied
      TARV_bind      Tariff ad valorem binding
      FEOE_max       Commitment on export subsidy outlays

      TriggerP       Trigger price of EU entry price for fruits and vegs
      PrefTrigPrice  Preferential trigger price of EU entry price for fruits and vegs
     /;



* ---------------------------------------------------------------------------
*
*   @start
*   @Author Gocht
*   @Area   Capreg, FsstoTypes
*   @Usage  cols Items for FSS raw data
*   @refDoc 2.2 Concept
   set Frm_COLS "Farm type FSS Aggregates"/
   A_CERE  "aggregate for cereales"
   A_OAFC  "aggregate for other crops on arable land"
   A_FOAL  "aggregate for fodder on arable land"
   A_OILS  "aggregate for oils"
   A_GRAS  "aggregate for gras production"
   A_FRUI  "aggregate for fruites"
   A_VEGA  "aggregate for vegetables"
   A_AOLI  "aggregate for olives"
   A_WIN   "aggregate for win product activities"
   A_INT   "aggregate for industrial crops"
   A_INS   "aggregate for for industrial crops minus the area of oils, taboco"
   A_SETA  "aggregate for of seta"
   A_SET1  "aggregate without nonf"
   SENO    "nonf alone"
   A_CALF  "total calf less than 1 year"
   A_PIG   "total pigs from ori fss"
   JHOLD   "Number holding"
   J_LSU   "LSU from FSS"
   SETR    "Set aside rate"
   HSTY    "historic yields"
   SUM     "Sum position"
   LSU     "one calculared LSU"
   /;


   SET SET_bioRepCols/
       bioECere   "Ethanol processed from cereals"
       bioECgra   "Ethanol processed from coursegrains"
       bioEExog   "Ethanol processed from crops not represented in Market model"
       bioEWhea   "Ethanol processed from wheat"
       bioEBarl   "Ethanol processed from barley"
       bioERyem   "Ethanol processed from rye and meslin"
       bioEMaiz   "Ethanol processed from maize"
       bioEOats   "Ethanol processed from oats"
       bioEOcer   "Ethanol processed from other cereals"
       bioESuga   "Ethanol processed from sugar(beets)"
       bioEMola   "Ethanol processed from molasses"
       bioETwin   "Ethanol processed from wine"
       bioDOilP   "Biodiesel processed from oils"
       bioDRapo   "Biodiesel processed from rape oil"
       bioDSuno   "Biodiesel processed from sunflower oil"
       bioDSoyo   "Biodiesel processed from soy oil"
       bioDPlmo   "Biodiesel processed from palm oil"
       bioDExog   "Biodiesel processed from crops not represented in Market model"
       bioARES    "Biofuels  processed from crops residues and forestry"
       bioNECR    "Biofuels  processed from crops residues and forestry"

        /;


   SET SET_ACT_AGG /
*
*     *** Activity aggregates
*
      ARAB   Arable crops
      GRCU   Grandes cultures production activity
      CERE   Common cereals production activity
      PERM   Permanent crops and vegetables
      FODD   Fodder production
      SETF   Set aside and fallow land
*      OCES   Oats and other cereals, provisional activity for linking to ESIM
      CER2   Special cereals production activities
      OILS   Oilseeds production activity
      INDU   Industrial crops production activity
      VEGE   Vegetables production activity
      FRUI   Fruits production activity
      VINY   Vineyards production activity
      FARA   Fodder production activity on arable land
      OARA   "Other arable crops in behavioural functions (PMP group)"
      OAR1   "Arable crops other than cereals and oilseeds (report category)"

      NOCR   Crops with no physical yield
*
      RUMI   Ruminants
      NRUM   Non ruminants
      CATA All cattle activities
      BEFM Beef meat production
      PKPL Other animals
      AGGT Sum

      PIGS     "Pigs"
      CACR     "Cows, raising activities and calf fattening"
      POUL     "Poultry"
      SGHT    "Sheep and goat"
      TREE     "Permanent crops"
      FODA     "Fodder production on arable land"
    /;

    SET SLGT_COLS "Columns relating to slauhtering statistics" /

      IMPL   "Imported live animals (tons: IMPL.PORK, hds: IMPL.IPIG)"
      IMLW   "Live imported weight per head, COCO"
      EXPL   "Exported live animals (tons: EXPL.PORK, hds: EXPL.IPIG)"
      EXLW   "Live exported weight per head, COCO"
      SLGH   Slaughtered heads
      SLGT   Slaughtered tons
      SLGW   "Slaughter weight, COCO"
      MEAT   "Raw data for GROF in COOC (eg GROF.PORK<->MEAT.IPIG)"

    /;

    SET SET_EMIS_COLS /

      GNH3   Ammonia emissions
      GCH4   Methane emissions
      GCO2   Carbon dioxide emissions
      GN2O   Nitrous oxide emissions
      WATR   Water surplus

      CH4A   "Methane from animals"
      CH4F   "Methane linked to fertiliser use"
      CO2F   "CO2 linked to fertiliser use"
      N2OF   "N20 linked to fertiliser use"

     NH3MA2   Ammonia emissions from manure management
     NH3GR2   Ammonia emissions from grazing
     NH3AP2   Ammonia emissions from manure application without grazing
     NH3APL   Ammonia emissions from manure application without grazing due to livestock production
     NH3SYN   Ammonia emissions from application of mineral fertilizers
     NH3SYL   Ammonia emissions from application of mineral fertilizers due to livestock production
     NH3SYS   Ammonia emissions from anorganic fertilizers production saved due to the application of manure
     NH3CRO   Ammonia emissions from crop residues
     NH3CRL   Ammonia emissions from crop residues due to livestock production

     NOXMA2   NOX emissions from manure management
     NOXGR2   NOX emissions from grazing
     NOXAP2   NOX emissions from manure application without grazing
     NOXAPL   NOX emissions from manure application without grazing due to livestock production
     NOXSYN   NOX emissions from application of mineral fertilizers
     NOXSYL   NOX emissions from application of mineral fertilizers due to livestock production
     NOXSYS   NOX emissions from anorganic fertilizers production saved due to the application of manure
     NOXCRO   NOX emissions from crop residues
     NOXCRL   NOX emissions from crop residues due to livestock production

/;

    SET Bio_Cols /
                  NAGR   "non agricultural sourced biofuel production"
                  FSTG   "bio fuel quantities from first generation"
                  SECG   "bio fuel quantities from second generation"
                  EXOG   "bio fuel quantities from agricultural comodities not covered explicetly"
                  HCOS    "energy share of biofuels in total fuel consumption"
                /;

   SET ScenShifterPos_COLS "Scenario shifter positions"
    /
                             "ChangeFactor"      "Change factor applied to to the calibration point, (1.02 = 2% increase)"
                             "PercentageChange"  "Percentage change compared to the calibration point, defined in points (10=10% increase)"
                             "AbsoluteLevel"     "Absolute value"
                             "AbsoluteChange"    "Absolute change, added to the calibration point"
    /;

   set set_greeningMeasures /
                         permGras      "Maintainance of permanent grass land"
                         cropDiv       "Crop diversity"
                         winterCover   "Winter cover in crop land"
                         ecoSetAside   "Ecological set-aside"
                        /;



* ---------------------------------------------------------------------------
*
*   @start
*
*   Cols is the "mother" set for all columns on the DATA
*   array, and used widely as a domain for declaration
*   of other sets and parameters.
*
*   @Author Britz
*   @Usage  Top level set of all columns used on DATA
*   @refDoc 2.2 Concept

    SET SET_DB_COLS "CAPRI Data base columns" /

      " "
      SET.MECACT,
      SET.MFCACT,
      SET.DCACT,

      SET.MEAACT,
      OANI   Other animals activity,
      SET.DAACT

      OWIN,
      CATC   "Catch crop, no area required",
*
*     *** Balance positions
*
      SET.BALPOS_COLS,
$IF %MARKET_M%==ON SET.MARKET_BALPOS,
*
      STKM   Final stocks on market
*
*
      USAP   Usable production,
      SET.SLGT_COLS,
*
*     *** Prices
*
      UVAP    Unit value EAA producer price
      UVAB    Unit value EAA basic price
      UVAD    Unit value consumer price
      UVAG    Unit value EAA gross producer price
      UvagA   Price for A sugarbeets
      UvagB   Price for B sugarbeets
      UvagC   Price for C sugarbeets
      UvagE   Expected unit value
      UVAN    Unit value as used in iterations
*
      UVAI   Unit value imports
      UVAE   Unit value exports
      PMRK   Domestic market price
      PSHW   Shadow price of supply balance
*
      PRII   Price index EAA
      PRIC   Selling price
      QPRI   Quota price
*
*     *** EAA
*
      EAAP   EAA at producer price (current prices)
      EAAS   EAA subsidies (current prices)
      EAAT   EAA taxes (current prices)
      EAAB   EAA basic price (current prices)
      EAAU   EAA unit value
      EAAQ   EAA quantity
      EAAG   EAA at gross producer prices
*
*     *** Aggregates
*
      AGGR   Aggregates
      INHA   Inhabitants
      EXPD   Expenditures
      CSSP   Equivalent variation
*
*     *** Political variables
*
      PADM   Administrative price
      TARS   Tariff specific
      TARV   Tariff ad valorem
      INTC   Intervention stock costs per unit
      MODU   Modulation ammount
*
      INTM   Max intervention purchases
      QUTI   Quota imports
      QUTE   Quota exports
      QUTS   Quota endowments
      QUTA   A-Quota endowments
      QUTB   B-Quota endowments,
*
*     *** consumer taxes
*
      CTAX   Consumer taxes,
*
*     *** Activities broken down in supply model
*
*     *** Nutrient content
*
      SET.REQS_SET
*
*     *** Total positions as sum of farm and market balance
*
      SEDT   Seed use total
      LOST   Losses total
*
*     ***
*
      PRCY   Processing yield of product per unit of primary one
      PRCB   Processing yield for each product processed to bio fuel
      PRCBY  Processing yield of by-products for each product processed to bio fuel,
*
*     *** Content of protein and fat
*
      FATS   Fat content
      PROT   Protein content
*
*     *** UAA
*
      FORE   "Forest area"
      FORP   "Professional managed forest area"
      UAAR   "Usable agricultural area"
      HOLD   number of holdings
*tj
      ASYM   "Total land potentially available for agriculture"
      CORF   Correction factor for input distribution,
      NTRD   Net trade

      NITF   "N uptake of crops per ton of product"
      PHOF   "Phosphate uptake of crops per ton of product [P2O5]"
      POTF   "Potassium uptake of crops per ton of product [K2O]",


      FLEG   "Clover"
      PROD   "Production or marketable production",
      YILD   "Main yield coefficient",

      SET.NBIL_COLS,
      AVAILA      "Nitrogen applied according to availability assessment by the farmer ",

      LABT      "Labour totals"
      Impact    "Total impact of environmental indicators"
      ImpactGwp "Total impact of environmental indicators, in GWP"
      ImpactHa  "Total impact of environmental indicators, per ha"

      MINS
      QUDRA
      QUDRF,
*
      SET.GHGS_ROWS,
      SET.SET_EMIS_COLS,
      SET.Bio_COLS,
      SET.Frm_COLS "Farm type FSS Aggregates",
      SET.SET_ACT_AGG,
      SET.sets_TSGM_POS
*
      SHEP   "Sheep data from COCO used in reqfcn for weighting"
      GOAT   "Goat data from COCO used in reqfcn for weighting"
      /;

    SET COLS "CAPRI columns as used in COCO, CAPREG and CAPMOD" /


      SET.SET_DB_COLS,

      GDP  "GDP"

      GRAA "Abandondent grass land without economic use"
      ARAA "Abandondent arable land without economic use",
      ANNC "Annual crops",
*
*     *** intermediate COCO
*
      SET.INTERM_COCO_COLS,
*
      SET.MARKET_POLICY_COLS,
      SET.MFIND_COLS,
*
$IF %MARKET_M%==ON SET.WELFPOS_SET,
SET.ARMPRICE_SET,
$IF %MARKET_M%==ON SET.DAIRYRES_SET,
$IF %MARKET_M%==ON SET.MQPOS_SET,
$IF %MARKET_M%==ON SET.ADD_MARKET_COLS,
*
      LEVL  "Production activity level",
      FEED  "Feed use in primary product equivalents",
      SET.FEOGA_COLS,
      set.s_PS_budget,
      SET.NCNC_POS,
      SET.SET_bioRepCols,

      TRAD         "Net trade"
      DEMD          "Demand"
      FOOD          "Food"
      FARM          "Farm use"
      PRCC          "Processing"
      LOSC          "Losses and stock changes"
      LU     "Livestock units"
      BF_S   "Bio fuel feedstock shares"
      CEIL   "Ceilings, used in supply model for environmental constraints"
      CONC   "Concentrates",
      NETMAN      "Supply from manure is excretion net of runoff and gaseous emissions"
      NETMAN2     "Manure application version 2",
      GROF_A      "Total nutrient output from manure",

      SET.ScenShifterPos_COLS,
      SET.set_greeningMeasures,
      SET.GRAS_COLS,
      SET.Add_LandUse,
      SET.Add_LandUseAgg
$ifi %CAPDIS%==ON ,SET.set_capdis_add_cols
    /;

    SET EMIS_COLS(COLS) / SET.SET_EMIS_COLS /;


    SET DB_COLS(COLS) "Columns stored by CAPREG" /
      SET.SET_DB_COLS
      ARTO,
      KITC,
      ARTIF,
      INLW,
      OLND
    /;
$iftheni %MARKET_M%==ON
    set market_model_cols(cols) /
       SET.WELFPOS_SET,
       SET.DAIRYRES_SET,
       SET.MQPOS_SET,
       SET.ADD_MARKET_COLS,
       SET.MARKET_POLICY_COLS
    /;
$endif
*



  set TSGM_SPOS(COLS) "partial standard gross margins in the consistency step"
      /P1,P2,P3,P4,P5,D21_HA,E_HA,J18_HIVE,P1_13_14,G04_HA,G1_G2,G03_HA,P41,P42,J07_HEADS/;

  set TSGM_POS(COLS) "partial standard gross margins all positions"
      /set.sets_TSGM_POS/;







   ALIAS (COLS,COLS1);

   SET REQSC(COLS) "Nutrient contents" / SET.REQS_SET /;
*
*----------------Sets used fo domain checked declaration -----------------------------
*

  SET CERE(COLS)  "Cereals according to Grandes Cultures definition "
    / SET.CERE_COLS /;

  SET OILS(COLS)  "Oils seeds according to Grandes Cultures definition "
    / SET.OILS_COLS /;
*
  SET PACT(COLS) "All production activities" /

      SET.MECACT,
      SET.MFCACT,
      SET.DCACT,

      SET.MEAACT,
      SET.DAACT,
      OANI    Other animals activity
      CATC    "Catch crop"
      /;

  ALIAS(PACT,PACT1);

*
  SET CACT(PACT) "Crop production activities" /
      SET.MECACT,
      SET.MFCACT,
      SET.DCACT

   /;
*
  SET MPACT(PACT) "Produciton activities in supply model" /

      SET.MECACT,
      SET.MFCACT,
      SET.MEAACT,
      OANI    Other animals activity
      CATC    "Catch crop"
       /;
  ALIAS (MPACT,MPACT1,MPAC1);
*
  SET EACT(MPACT) "Activities whose level are determined by model" /
       SET.MECACT
       SET.MEAACT
   /;
   ALIAS(EACT,EACT1);



  SET MCACT(MPACT) "Crop production activities comprised in model"/
     SET.MECACT,
     SET.MFCACT
   /;
  ALIAS(MCACT,MCACT1);

  SET FEDACT(MCACT) "Feed producing endogenous crop activities" / SET.FEDACT_COLS /;

  SET GRCU(CACT) "Grandes cultures" /
        SET.CERE,SET.OILS,
        PULS,ISET,GSET,TSET,VSET,MAIF
   /;

  SET RSET(MPACT) "Activity on obligatory set-aside with the exemption of non-food production" / ISET,GSET,TSET /;

  SET setaPact(PACT) "Activities eligible to cover obligatory set-aside" / ISET,GSET,TSET,NONF /;

  SET MAACT(MPACT) "Animal production activities comprised in model"/
        SET.MEAACT
    /;
  ALIAS(MAACT,MAACT1);

  SET DACT(PACT) "Production activities aggregated in the data base " /
       SET.DCACT
       SET.DAACT
   /;

  SET AACT(PACT) "Animal production activities" /

       SET.MAACT,
       OANI  Other animals activity,
       SET.DAACT
  /;

   SET MACT(MAACT) "Disaggregated animal activities in model"  / DCOL,DCOH,BULL,BULH,HEIL,HEIH /;

   SET SplitActs(MPACT) "Disaggregated activities in model"  / DCOL,DCOH,BULL,BULH,HEIL,HEIH,GRAE,GRAI /;

   SET MDACT(AACT) "All animal activities in the data base";
   MDACT(AACT) = YES;
   MDACT(AACT) $ SUM(SAMEAS(MACT,AACT),1) = NO;
   ALIAS(CACT,CACT1);

*
   SET FACT(MPACT) "Fixed production activities not endogenously calculated" /
      SET.MFCACT
      OANI  Other animals activity
       /;

*TJ Estimated activity groups (see ESTNLP/ESTNLP.GMS for details)
    set GRP(COLS)     "Activity groups between which direct cross-effects are allowed" /CERE,CER2,OILS,OARA,FARA/;
*   set GRP(COLS)     "Activity groups between which direct cross-effects are allowed" /CERE,CER2,OILS,OARA,FARA,NOCR/;
*    SET GRP(COLS) / PULS,INDU,CERE,OILS,FARA,SETA /;
    ALIAS(GRP,GRP1);


    SET ENLPGRP(GRP) "Activity groups for which PMP terms are estimated";
    ALIAS(ENLPGRP,ENLPGRP1,ENLPGRP2);

    SET LandUse(COLS)
    /
    SET.Add_LandUse
     PARI
     OLIV
     VINY
     FALL
     FARA
*     GRAE
*     GRAI
    /;
    ALIAS(LandUse,LandUse1);

    SET LandUseAgg(COLS)
    /
    SET.Add_LandUseAgg
     FORE
     GRAS
     UAAR
    /;

  SET LandUse_TO_LandUseAgg(LandUse,LandUseAgg) "mapping of land use to land use aggregates"
    /
     (GRANTC, GRATC) . GRAS
     (SHRUNTC, SHRUTC, OSPA) . OLND
     (SHRUNTC, OSPA). SVBA
     (OART, SHRUNTC, SHRUTC, OSPA) . OLNDARTIF
     (PARI, FALL, ARAO, GRAT) . ARAC
     (FRCT, OLIVGR, NUPC, VINY) . FRUN
     (INLW, MARW) . WATER
     (OART) . ARTIF
     (SHRUTC) . OWL
*    from definitions the following mapping would be possible, but creates an overlap, since OWL would then be partially UAAR and OLND
*    (SHRUTC, GRATC) . OWL
*     (BLWO, COWO, MIWO, POEU, SHRUTC, GRATC) . TWL
     (BLWO, COWO, MIWO, POEU, SHRUTC) . TWL
     (SHRUNTC, SHRUTC) . SHRU
     (PARI, FALL, OART, ARAO, GRAT, FRCT, OLIVGR, NUPC, BLWO, COWO, MIWO, POEU, SHRUNTC, SHRUTC, GRANTC, GRATC, OSPA, INLW, KITC, VINY) . ARTO
     (PARI, FALL, OART, ARAO, GRAT, FRCT, OLIVGR, NUPC, BLWO, COWO, MIWO, POEU, SHRUNTC, SHRUTC, GRANTC, GRATC, OSPA, INLW, MARW, KITC, VINY) . ARTM
     (PARI, FALL, ARAO, GRAT, FRCT, OLIVGR, NUPC, VINY) . CROP
     (BLWO, COWO, MIWO, POEU) . FORE
     (PARI, FALL, ARAO, GRAT, FRCT, OLIVGR, NUPC, GRANTC, GRATC, KITC, VINY) . UAAR
    /;


  SET LandUseARTO(COLS) "mutually exclusive subset adding up to ARTO" /

      UAAR
      FORE
      OLND
      ARTIF
      INLW
      /;
  ALIAS(LandUseARTO,LandUseARTO1);

    set EPRD_TO_GRP(COLS,GRP) 'Mapping of crops to groups according to ESTNLP' /

        (SWHE,DWHE,RYEM,BARL,OATS).CERE
        (MAIZ,OCER,PARI).CER2
*        OILS.(RAPE,SUNF,SOYA,OOIL,NONF)
        (RAPE,SUNF,SOYA).OILS
        (PULS,POTA,SUGB).OARA
*        OARA.(PULS,POTA,SUGB,TEXT)
        (MAIF,ROOF,OFAR).FARA
*       (ISET,GSET,TSET,VSET,FALL).NOCR/;
*       (GSET,TSET,VSET,FALL).NOCR

        /;

   SET ACT_AGG(COLS) /    SET.SET_ACT_AGG /;


*
   SET GRDCUL(CACT) "Grandes Cultures without oilseeds"
    / SWHE , DWHE , RYEM , BARL , OATS , MAIZ , OCER , PULS /;
*
*
   SET GRSACT(MCACT)  "Gras and Grazings" / GRAE, GRAI /;

   ALIAS (GRSACT,GRSACT1);
*
   SET arbAct(MCACT) "Crops on arable land";
   ALIAS(arbAct,arbAct1);
     arbAct(MCACT) = NOT GRSACT(MCACT);
*
   SET annualCrops(MCACT) "Annual crops" /
       SET.CERE_COLS,
       PARI,
       SET.OILS_COLS,

       PULS
       POTA
       SUGB
       TEXT
       TOBA

       TOMA
       OVEG
       FALL

       OOIL
       OIND
       FLOW

       ISET
       GSET
       TSET
       VSET

       MAIF
       ROOF
       OFAR
     /;

   alias (annualCrops,annualCrops1);


   set cropDivGrps(*) "Crops or crop group which cound as a single crop in the Shannon crop diversity index";
   cropDivGrps(AnnualCrops) = YES;
   cropDivGrps(RSET)        = NO;
   cropDivGrps("VSET")      = NO;
   cropDivGrps("FALL")      = NO;
   cropDivGrps("OSET")      = YES;

   set cropDivGrps_mCact(*,mPact);
   cropDivGrps_mCact(cropDivGrps,annualCrops) $ sameAs(cropDivGrps,annualCrops) = YES;
   cropDivGrps_mCact("OSET",RSET)   = YES;
   cropDivGrps_mCact("OSET","VSET") = YES;
   cropDivGrps_mCact("OSET","FALL") = YES;

   SET permanentCrops(MCACT);
   permanentCrops(MCACT) $ (not annualCrops(MCACT)) = YES;

*
   SET GRPS(COLS)    / GRCU,OILS,DWHE,BULF,DCOW,SHGM,CAMF,PARI/;
*
   SET GRPS_TO_A(*,*) "Mapping between groups of activities and single activities" / GRCU.(SWHE,DWHE,BARL,RYEM,OATS,OCER,MAIZ,RAPE,SUNF,SOYA,PULS,OSET,VSET,MAIF,NONF),
                        OILS.(RAPE,SUNF,SOYA),
                        DWHE.DWHE,
                        BULF.BULF,
                        SCOW.SCOW,
                        SHGM.SHGM,
                        CAMF.(CAMF,CAFF),
                        PARI.PARI /;
*
   SET POLACT(PACT) "Political production activities" / ISET,GSET,TSET,VSET /;


   SET landTypesBal(COLS)      "Different land types" / ARAB, GRAS, ANNC /
   SET landTypes(landTypesBal)  "Different land types with markets" / ARAB, GRAS /
   alias (landTypes,landTypes1,landTypes2);
   SET landTypesTot(COLS) "Land types on all levels of the land use tree" /
     SET.landTypes,
     UAAR            "Utilized agricultural area (1000 ha)"
     ASYM            "Maximum available area (1000 ha)"/;

   set greeningMeasures(COLS) / SET.set_greeningMeasures /;



*
*
   SET DACT_TO_PACT(DACT,PACT) "Mapping between data base activities from COCO and high/low yield variants used in CAPREG/CAPMOD" /  DCOW.(DCOL,DCOH),
                                   BULF.(BULL,BULH),
                                   HEIF.(HEIL,HEIH),
                                   OSET.(ISET,GSET,TSET,NONF),
                                   SETA.(ISET,GSET,TSET,NONF,VSET),
                                   GRAS.(GRAI,GRAE) /;
*
   SET DMPACT(MPACT) "Model activities which need to be aggregated to data base activities";
*
   DMPACT(MPACT) $ SUM(DACT_TO_PACT(DACT,MPACT), 1) = YES;

   SET GRAS(MCACT)  "Gras land activities"   / GRAE,GRAI /;
*
*  In coco2_feed CALF and CALR have to be subsets of AACT:
$ifi not %COCO%==YES SET CALF(MAACT)  "Calves fattening activities"           / CAMF, CAFF /;
$ifi not %COCO%==YES SET CALR(MAACT)  "Calves rearing activities"             / CAMR, CAFR /;
   SET MRUMI(MAACT) "Ruminant activities in model, used in multifunc.gms"
                / DCOL, DCOH, SCOW, BULH, BULL, HEIL, HEIH, HEIR, CAMF, CAFF, CAMR, CAFR, SHGM, SHGF /;

   SET DRUMI(AACT)  "Ruminant activities in CoCo"           / DCOW, SCOW, BULF, HEIF, HEIR, CAMF, CAFF, CAMR, CAFR, SHGM, SHGF /;
   SET DNRUMI(AACT) "Non Ruminant activities in CoCo"       / PIGF,SOWS,POUF,HENS /;

   SET MNRUMI(MAACT) "Not ruminant activities in the model";
   MNRUMI(MAACT) $ (NOT MRUMI(MAACT)) = YES;

*  For the emission module:

   SET EMAACT (*)    "Activities emitting gases" /SWIN,DAIRY,NDAIRY,SHGM,OANI/;

   SET POULTRY(AACT) "Poultry production activities, used in ammo.gms"          /HENS,POUF/;
*
   SET BALPOS(COLS)   "Position of the farm and market balance"/ SET.BALPOS_COLS /;
   SET FRMBAL(BALPOS) "Positions of the farm balance"          / SET.FRMBAL_COLS /;
   SET MRKBAL(BALPOS) "Positions of the market balance"        / SET.MRKBAL_COLS/;
   SET TRDPOS(BALPOS) "External trade positions"               / SET.TRDPOS_COLS/;
*
*
   SET CONS(COLS) / HCOM,INDM/;
*
   SET DOMM(COLS) "Market balance columns which add up to domestic use" /
      FEDM   Feed use on market
      SEDM   Seed use on market
      INDM   Industrial use market
      PRCM   Processing to derived products market
      BIOF   Processing for biofuels
      HCOM   Human consumption market
      LOSM   Losses on market
      STCM   Stock changes on market
   /;
*
   SET PRICES(COLS)   "EAA Prices" /
      UVAP    Unit value EAA producer price
      UVAB    Unit value EAA basic price
      UVAD    Unit value consumer price
*
      PRII   Price index EAA
      PRIC   Selling price
   /;
*
   SET NEAAC(COLS) "Net EAA Positions" / EAAP,EAAB,EAAS,EAAT /;
*
   SET UVAT(COLS) "Unit value prices weighted by sales or purchases" / UVAP,UVAB,PRIC /;

   SET FNUT_COLS(COLS) / NITF,POTF,PHOF /;

   SET NBIL(COLS) Nutrient balance positions / SET.NBIL_COLS,NITF /;


   SET MAPP(COLS)  "Prices link to EAA positions"          / UVAP,UVAG,UVAB /;
   SET GEAAC(COLS) "EAA positions, used in reporting part" / EAAP,EAAB,EAAG /;

   SET psBudCols(COLS)   "Bugdets (EU, pillar I, national ..) from which policy instruments are paid" / SET.s_PS_budget /;

   SET ScenShifterPos "Scenario shifter positions" /  SET.ScenShifterPos_COLS /;

   SET bioScenShifted(cols) / QUTS, CTAX, SECG, NAGR, EXOG /;

   set scenshiftedCols(COLS) / UVAG
$IF %MARKET_M%==ON             HCON
$IF %MARKET_M%==ON             FEED
$IF %MARKET_M%==ON             PROD
$IF %MARKET_M%==ON             PROC    ,
$IF %MARKET_M%==ON             SET.bioScenShifted
                              /;

   set scenshiftedColsWeights(COLS) / GROF
$IF %MARKET_M%==ON                HCON
$IF %MARKET_M%==ON                FEED
$IF %MARKET_M%==ON                PROD
$IF %MARKET_M%==ON                PROC ,
$IF %MARKET_M%==ON                SET.bioScenShifted
                              /;

   SET ScenShiftedCols_to_weights(scenshiftedCols,scenShiftedColsWeights) /
                                     UVAG.GROF
$IF %MARKET_M%==ON                   HCON.HCON
$IF %MARKET_M%==ON                   FEED.FEED
$IF %MARKET_M%==ON                   PROD.PROD
$IF %MARKET_M%==ON                   PROC.PROC
*$IF %MARKET_M%==ON                   BIOF.BIOF
                                            /;


 SET FATSPROT(COLS)   / FATS,PROT /;
*
*------------------------------------------------------------------------
*
*  SET DUUMY1 /
*               TOIA EAA Input
*               CRPI EAA Crop specific inputs
*               ANMI EAA Animal specific inputs
*               RESI EAA Other inputs
*               PRMA Premiums
*               AGGA Agricultural income
*           /;
*
*
    SET FCO "Final crop outputs" /
*
*     *** crop production outputs
*
      SWHE   Soft wheat
      DWHE   Durum wheat
      RYEM   Rye and meslin
      BARL   Barley
      OATS   Oats
      MAIZ   Grain maize
      OCER   Other cereals
      PARI   Paddy rice
*
      RAPE   Rape seed
      SUNF   Sunflower seed
      SOYA   Soya seed
      OLIV   Olive oil
      OOIL   Other oil
*
      PULS   Pulses
      POTA   Potatoes
      SUGB   Sugar beet
      TEXT   Flax and hemp
      TOBA   Tobacco
      OIND   Other industrial crops
*
      TOMA   Tomatoes
      OVEG   Other vegetables
      APPL   Apples  pears and peaches
      OFRU   Other fruits
      CITR   Citrus fruits
      TAGR   Table grapes
      TABO   Table olives
      TWIN   Table wine
*
      NURS   Nurseries
      FLOW   Flowers
      OCRO   Other crops
      NECR   New energy crops
        /;

   SET S_WHEA "Only the element WHEA" / WHEA "Wheat in the market model" /;


    SET ICO "Intermediate crop products" /
*
      GRAS   Gras
      MAIF   Fodder maize
      OFAR   Fodder other on from arable land
      ROOF   Fodder root crops
      STRA   Straw
      ARES   Agricultural residuals usable for biofuels
    /;

*
    SET OYANI_ROWS "Young animals" /
      YCOW   Young cow
      YBUL   Young bull
      YHEI   Young heifer
      YCAM   Young male calf
      YCAF   Young female calf
      YPIG   Young piglet
      YLAM   Young lamb
      YCHI   Young chicken
      /;
*
    SET ANIMO_ROWS "Animal outputs" /
*
*     *** Animal production output
*
      COMI   Milk for sales
      COMF   Milk for feeding
      BEEF   Beef
*
      PORK   Pork meat
*
      SGMI   Sheep and goat milk
      SGMF   Sheep and goat milk feeding
      SGMT   Sheep and goat meat
*
      EGGS   Eggs
      POUM   Poultry meat
      OANI   Other animals output,
*
*     *** Young animals
*
      SETS.OYANI_ROWS
*
*     *** Manure
*
      MANN   Nitrogen in manure
      MANP   Phospate in manure
      MANK   Potassium in manure
*
      LRES   Livestock residues usable for biofuels
*
      /;

*   -------------------- Sets related to inputs -------------------------
*
     SET FNUT_ROWS "Mineral fertilizing inputs" /
      NITF   "Nitrogen in fertiliser"
      PHOF   "Phospate in fertiliser [P2O5]"
      POTF   "Potassium in fertiliser [K2O]"
      /;


    SET IYANI_ROWS  "Young animals as inputs" /
          ICAM  Male calves
          ICAF  Female calves
          IHEI  Young heifers
          ICOW  Young cows
          IPIG  Piglets
          IBUL  Young bulls
          ILAM  Lambs
          ICHI  Chicken
           /;


   SET CIREST "Rest of crop specific inputs " /
      CAOF   Calcium in fertiliser
*
*     *** Other crop specific
*
      SEED   Seed
      PLAP   Plant protection

    /;

    SET IGEN "General inputs used by crops and animals" /
*
*     *** General inputs
*
      REPM   Maintenance materials
      REPB   Maintenance buildings
      ELEC   Electricity
      EGAS   Heating gas and oil
      EFUL   Fuels
      ELUB   Lubricants
      WATR   Water balance or deficit
      INPO   Other inputs
      SERI   Services input
    /;
*
    SET WHEPCASE_ROWS "Whey powder and casein"  /
*
      WHEP   "Whey powder"
      CASE   "Casein and caseinates"
    /;
*
    SET WMIP_ROWS "Whole milk powder only and Whey powder and Casein"/
*
      WMIO   "Whole milk powder only"
      SET.WHEPCASE_ROWS
    /;
*
*
    SET MLKSECDIS_ROWS "Disaggregated milk secondaries"  /
      BUTT   "Butter",
      SMIP   "Skimmed milk powder",
      CHES   "Cheese",
      FRMI   "Fresh milk products",
      CREM   "Cream",
      COCM   "Concentrated milk",
      SET.WMIP_ROWS
    /;

$SETGLOBAL MLK_DISAGG YES
*
    SET MLKSECO_ROWS "Dairy products" /
*
      BUTT   Butter
      SMIP   Skimmed milk powder
      CHES   Cheese
      FRMI   Fresh milk products
      CREM   Cream
      COCM   Concentrated milk

$IF NOT %MLK_DISAGG%==YES  WMIP   "Whole milk powder only and Whey powder and Casein"
$IF %MLK_DISAGG%==YES      WMIO   Whole milk powder only
$IF %MLK_DISAGG%==YES      WHEP   "Whey powder"
$IF %MLK_DISAGG%==YES      CASE   "Casein and caseinates"
       /;


    SET SET_Fuel_ROWS "Fossil fuels" /
      DISL   Diesel
      GASL   Gasoline
      CRDO   crude oil

       /;
*
    SET SECO_NO_DAIRY_ROWS "Processed Outputs without dairy" /
*
      SET.SET_BIO_FUEL_ROWS,
*
      RICE   "Rice milled"
      MOLA   "Molasse"
      STAR   "Starch"
      SUGA   "Processed sugar",

*
      RAPO   Rape seed oil
      SUNO   Sunflower seed oil
      SOYO   Soya oil
      OLIO   Olive oil
      PLMO   Palm oil
      OTHO   Other oil
*
      RAPC   Rape seed cake
      SUNC   Sunflowe seed cake
      SOYC   Soya cake
      OLIC   Olive cake
      OTHC   Other cake
*
      DDGS   "Destilled dried grains (byproduct from ethanol production)"
      GLYC   "Glycerine (byproduct from Biodiesel production)"

*
      MILK   Raw milk at dairy
         /;
*
    SET SECO_ROWS "Processed Outputs" /
*
      SET.SECO_NO_DAIRY_ROWS ,
      SET.MLKSECO_ROWS

         /;
*
   SET SECAll_ROWS "Processed Outputs with disaggregated WMIP components" /
*
      SET.SECO_NO_DAIRY_ROWS,
$IF NOT %MLK_DISAGG%==YES  WMIP   "Whole milk powder only and Whey powder and Casein",
      SET.MLKSECDIS_ROWS

         /;
*
    SET INCINDS "Agricultural income indicators"  /
*
      TOOU   Total output
      TOIN   Total intermediate input
      GVAP   Gross value added at producer prices
      GVAB   Gross value added at basic prices
      MGVA   Gross value added at producer prices plus CAP premiums
*
      /;



*
    SET INCIND "Income indicators"  /

      SET.INCINDS
      PRME   CAP premium effective,
      set.s_PS_budget,
      PRMD   CAP premium declared
       /;

    SET EAAIND_ROWS "Positions which define the GVAM" /
*
      DEPM   Fixed capital consumption equipment
      DEPB   Fixed capital consumption buildings
      DEPO   Depreciation others
      NVAB   Net value added at basic prices
*
      WAGE   Compensation of employees
      TAXO   Other taxes on production
      SUBO   Other subsisides on production
      NVAF   Factor income
      OPES   Operating surplus
*
      RENT   Rents and other real estate rental charges to be paid
      INTP   Interest paid
      INTR   Interest received
      ENTI   Entrepreneural income
   /;


   SET FERT_DIST_ROWS "Fertiliser application rates" /

      NRET   "N retained by crop",
      NMIN   "N from mineral fertilizer in kg/ha"
      NMAN   "N at tail applied per kg/ha"
      NCRD   "N from crops residues and atmospheric deposition in kg/ha"

      PRET   "P2O5 retained by crop"
      PMAN   "P2O5 at tail applied per kg/ha"
      PMIN   "P2O5 from mineral fertilizer in kg/ha"
      PCRD   "P2O5 from crop residueskg/ha"

      KRET   "P2O retained by crop"
      KMAN   "K2O at tail applied per kg/ha"
      KMIN   "K2O from mineral fertilizer in kg/ha"
      KCRD   "K2O from crop residueskg/ha"

      MINR   "Mineral application rate"

    /;

   SET OAGGR /
*
*     *** crop product aggregates
*
      CERE   Cereals
*      OCES   Oats and other cereals, provisional activity for linking to ESIM
      OILS   Oil seeds
      INDU   Industrial crops
      VEGE   Vegetables
      FRUI   Fruits
      VINY   Total vineyards
      FORA   Forage plants
*
      CATT   EAA value for cattle meat
*
    /;

   SET OAGG_ROWS /
*

       TOOA Total output
*      CERE Cereals
*      OILS Oilseeds
       OAFC Other arable field crops
       VGPM Vegetables and Permanent crops
       TROP Tropical beverages
       OCRP All other crops
       FODC Fodder crops
       MEAS Meat
       OANP All Other Animal products
       ACQU Fish and other acquatic products
       YANI Young animals
       MANC Manure output
       RESA Other output
       TOIA Total input
       FERC Fertiliser
       FEEC Feedingstuff
       IANC Remonte
       RPEN Repair and energy
       INPC Other inputs
       MILC Milk products
       OILP Oils
       CAKS Oil cakes
       SECO Secondary products
       ALLP All agricultural outputs
        /;
*

     SET EAAGA_ROWS  / CRPA,ANIA,CRPI,ANMI,RESI,PRMA,AGGA/;

     SET D_DUALS_LEVL_ROWS Derivatives of Lagrangean with respect to activity levels /
        D_FEED      Value of feeding
        D_FEDL      Value attached to binding bounds of feed input coefficients
        D_YANI      Value of young animals
        D_NUTNED    Cost for complying with fertilization requirements
        D_NUTMIN    Cost for complying with fertilization requirements
        D_NUTMAX    Cost for complying with fertilization requirements
        D_fertDistCres Marginal value of nutrients in crop residues
        D_NUT       Total marginal value of all nutrient requirements of crops
        D_AREA      Cost of land constraints
        D_SETA      Cost of setaside
        D_O         Dual value of output
        D_QP        Cost for production quotas
        D_OBJC      Variable inputs
        D_PREM      Premiums per activity
        D_PMPL      Contribution of PMP terms
        D_PMPF      Marginal value of PMP terms for feeding
        D_sumEntl           Marginal value of premium scheme entitlements
        D_permGrasGreening  Marginal value of grassland restriction in Greening
        D_cropDivGreening   Marginal value of crop diversity restriction in Greening
        D_ecoSetAside       Marginal value of ecological set aside in Greening
        D_winterCover       Marginal value of winter cover restriction
        D_ENER      Marginal cost of limits on energy use
        D_PROV      The right hand side of the first order conditions that should equal zero
        /;

     SET D_DUALS_REQM_ROWS Partial derivatives of animal requirements /
        D_ENNE,D_CRPR,D_DRMN,D_DRMX,D_LISI,D_FIBR,D_MAXS,D_MINS
     /;

     SET D_DUALS_FEED_ROWS Partial derivatives of lagrangean with respect to feeding /
        SET.D_DUALS_REQM_ROWS,D_FPMP
        /;

     SET D_DUALS_ROWS "Result positions from the dual analysis of the supply module" /
*
        SET.D_DUALS_LEVL_ROWS,
        SET.D_DUALS_FEED_ROWS
        /;

     SET Frm_ROWS "Positions for generating types from FSS raw farm groups"/
         FSSL     "Level from FSS in CAPRI Def"
         FSSSARE  'FSS Shares livestock units'
         LSU2     'Livestock units after consistency'
         LSU1
         LEVL_1
         LEVL_2
         LEVL_3
     /;
    SET FEO_ITEMS_ROWS  "Positions read from the FEOGA budget" / PRMS,PRMV,PRS1,PRS2,PRMP,PRP1,PRP2,PRP3,PRM1,PRM2,PRM3,PRM4,PRM5,PRM6,TOTL,REST,FRVG,MILP,FISH,STRC /;
    SET ADD_MARKET_ROWS / FATS,PROT,EXPE,INHA,RMLK,
$IF %BASELINE%==ON     SET.FEO_ITEMS_ROWS,
        PerCap
        own         "own price effect"
        cross       "cross price effects"
    /;

    SET ADD_LABOUR_ROWS /
      LABT_APRI
      LABF_APRI
      LABT_PRIOR
      LABF_PRIOR
      LABP_PRIOR
      LABT_REG
      LABF_REG
      LABP_REG
      LABT_REL
      LABF_REL
      LABP_REL
      LABT_ADD
      LABF_ADD
      LABP_ADD
      LABT_FADN
      LABF_FADN
      LABP_FADN
      LABT_DIFF
      LABF_DIFF
      LABP_DIFF
      LABT_TOOU
      LABF_TOOU
      LABP_TOOU
    /;

    SET INTERM_COCO_ROWS "Intermediate positions used by COCO and CAPREG"/
*
      dailySplitFac "non constant split factor for daily growth of adult cattle fattening activities"
      daysSplitFac  "non constant split factor for process length of  adult cattle fattening activities"
      COMISplitFac  "non constant split factor for dairy cow milk yield"

*
      PIGS   Pigs
      LAMM   Meat from lamb (no adults)
      SHGM   Adult shep and goat
*
      YCAT   Young cattle
      ICAT   Input cattle
      YCAL   Young calves
      ICAL   Input calf
*
      GIPR   Gross indigenous production
      LAMB   Lambs
      CAMR   Calves male raised
      CAFR   Calves femaile raised
*
      FAGO   Other annual green fodder
      FCLV   Clover and mixtures
      FLUC   Lucerne
      FPGO   Other legumes
      TGRA   Temporary grazings
      PMEA   Permanent meadows
      PPAS   Permanent pastures
      ROO1   Fodder beet
      ROO2   Other fodder root crops
*
      APPS   Apples
      PEAR   Pears
      PEAC   Peaches
      KIDN   Kidney beans
*
      AGG1     "COCO row aggregate: TWIN+CITR+TAGR+TABO+NURS+FLOW"
      AGG2     "COCO row aggregate: POTA+SUGB"

      LEVCLC     "Land use levels derived from CORINE Land Cover"
      LEVRegio   "Land use levels derived from Eurostat REGIO domain"
      LEVFAO     "Land use levels taken from FAO"
      LEVLucas   "Land use levels taken from Lucas 2009 survey"
      LEVLandCov "Land use levels taken from Eurostat Environment:  Land Cover (highly aggregated)"
      LEVEnvio   "Land use levels taken from Eurostat Environment"
      LEVMcpfe   "Land use levels taken from MCPFE - mainly forest data"

      LEVZPA1    "Land use levels taken from ZPA1"
      LEVFSS     "Land use levels taken from FSS"
*
    /;

    SET POLICY_POS /

*
      PRMR      Premium amount in regulation
      APPTYPE   Type of application
      APPFACT   Factor convertin PRMR to PRMD
      CEILCUT   Ceiling cut factor
   /;

   SET REPORT_ROWS /

      MREV   "Revenues from main output coefficient"
      MPRI   "Price for  main output coefficient"
      SREV   "Secondary product revenues"
      PROS   "Main output per activity in relation to UAA"
      PROD   "Production quantity of main output"
      DENS   "Acreage share or stocking density"
      YILD   "Main output coefficient"
   /;

   SET SET_GAS_EMIS /

      CH4A       "Methane from animals"
      CH4F       "Methane linked to fertiliser use"
      CO2F       "CO2 linked to fertiliser use"
      N2OF       "N20 linked to fertiliser use",

      GNH3   Ammonia emissions
      GCH4   Methane emissions
      GCO2   Carbon dioxide emissions
      GN2O   Nitrous oxide emissions

           NH3MA2   Ammonia emissions from manure management
           NH3GR2   Ammonia emissions from grazing
           NH3AP2   Ammonia emissions from manure application without grazing
           NH3APL   Ammonia emissions from manure application without grazing due to livestock production
           NH3SYN   Ammonia emissions from application of mineral fertilizers
           NH3SYL   Ammonia emissions from application of mineral fertilizers due to livestock production
           NH3SYS   Ammonia emissions from anorganic fertilizers production saved due to the application of manure
           NH3CRO   Ammonia emissions from crop residues
           NH3CRL   Ammonia emissions from crop residues due to livestock production

           NOXMA2   NOX emissions from manure management
           NOXGR2   NOX emissions from grazing
           NOXAP2   NOX emissions from manure application without grazing
           NOXAPL   NOX emissions from manure application without grazing due to livestock production
           NOXSYN   NOX emissions from application of mineral fertilizers
           NOXSYL   NOX emissions from application of mineral fertilizers due to livestock production
           NOXSYS   NOX emissions from anorganic fertilizers production saved due to the application of manure
           NOXCRO   NOX emissions from crop residues
           NOXCRL   NOX emissions from crop residues due to livestock production
   /;




    SET SET_DB_ROWS "CAPRI rows" /
*
*   --- (1) outputs
*
*   --- (1.1) crop outputs
*
       SET.FCO,
       SET.ICO,
       OWIN,
*
*   --- (1.2) animal outputs
*
       SET.ANIMO_ROWS,
*
*   --- (1.3) Other outputs according to EAA definitions
*
*
      RQUO   Renting of milk quota
      SERO   Agricultural Services Output
      NASA   Non Agricultural Secondary Activities,
*
*   --------------------------------------- inputs ------------------
*
      SET.FNUT_ROWS,
      SET.CIREST,
      SET.FEED_ROWS,
      SET.IYANI_ROWS,
*
*     *** Other animal specific
*
      IPHA   Pharmaceutical inputs,
      SET.IGEN,
*
*   --------------------------------------- EAA ---------------------
*
      SET.INCIND,
      SET.EAAIND_ROWS,
*
*
*     *** Level
*
      LEVL     Activity level
      LEVW     "Production activity level in weights (ha or livestock units)",
      SLAK     Slack of activity with respect to some constraint
*
*     *** Political variables
*
      PRMC   Premium ceiling
      HSTY   Historic yield
      SETR   Compulsory set aside rate effective
      NONS   Non food share on activity level
*
      PRMT   CAP premium per ton
*            *TJ   Policy tool positions
*
*     *** Labour input

      LABT           labour input - total
      LABF           labour input - family
      LABP           labour input - paid
      LABH,


*
      LABO     "Total labour in AWU"
      LABN     "Total non family labour in AWU"
      AGGR     "COCO row aggregate: PARI+PULS",
*
*     *** Derived products
*
      SET.SECO_ROWS,
$IF NOT %MLK_DISAGG% == YES   SET.WMIP_ROWS,
$IF %MLK_DISAGG% == YES       WMIP   "Whole milk powder only and Whey powder and Casein",

      COFF     "Coffee, dry equivalent"
      TEAS     "Tea, dry equivalent"
      COCO     "Cocoa beans, dry equivalent"

      FFIS     "Fresh water fish"
      SFIS     "Salt water fish"
      OAQU     "Other acquatic products",

      SET.SET_FUEL_ROWS
*
*     *** imported feddingstuff
*
      FPRI   Rich protein fodder imported
      FENI   Rich energy fodder imported,
*
*     *** crop product aggregates
*
      SET.OAGGR,
      SET.OAGG_ROWS,

      FARA   Fodder from arable land,
*
*     *** EAA intermediate consumption aggregates
*
      FERT   Fertilizer and soil improvers
      FEED   Animal feedingstuffs,
*
*     *** Nutrient need of animals
*
      SET.REQS_MOD,
*
*
      SLGT   Slaughterings in 1000 t
      SLGH   Number of slaughtered heads,
      CROP   "COCO row aggregate"
      ANIM   "COCO row aggregate"
*
      DEPP   Depreciation plants
      ENER   Energy
      REPA   Repair total
*
      LLEV   Last year activity level
*
      FLOOR  Floor for set aside calculation
      VCOF   Yield variation coefficient

      CRPR_EXPT "Export of crude protein in kg per head or 1000 heads",
      N_EXPT    "Export of N in kg per head or 1000 heads",
      SET.FERT_DIST_ROWS,
      NMIR   "Relative N from mineral fertilizer in %",
      MINS   "Share of mineral fertilizer",
      MAXS   "???",
      SET.REPORT_ROWS,

      O_HP   "Main output coefficient, HP filter smoothed"
      DAYS   "Days in production system"
      HERD   "Herd size"
*      YDAYS (= implied piglet days from 0-20 kg ) are useful to calculate the total PIGS.HERD
      YDAYS "process length of raising piglets to a weight of 20kg, linked to column PIGF"
*      DAILY growth from COCO/CAPTRD is input for requirement functions of some AACT
      DAILY "Daily growth in fattening or raising activities"
      EDAYS "Empty days for cleaning empty stables or seasonality (sheep) are a part of total process length DAYS"
      CC_S   "Concentrate share"
      WHEA   "Aggregate of soft wheat and durum",

*mih: sets for cost reporting
      FEEDS  "Aggregate of all feedstuff"
      RESTI  "Rest of inputs",
      SEED_cost "Seed costs"
      Plantp_cost "Plant protection costs"
      Other_in_RESTI "Other items in the GUI table Further cost breakdown"
      Operating_cost  "Operating cost as used in FADN -- not fully covered"
      SpecAnim_cost "specific costs of animal production -- feed, animal purchases and veterinary costs"
      SpecCrop_cost "specific costs of crop production  -- seed, plant protection, fertilizers"
      Fuel_energy  "Fuels and energy"
      NonSpec_cost "non-specific (other) operating costs",


      SET.EAAGA_ROWS,

      Impact    "Total impact of environmental indicators"
      ImpactHa  "Total impact of environmental indicators, per ha",
      SET.SET_GAS_EMIS,
      FEOG
      DIFR
      CSSP   Equivalent variation,

      AVAILA      "Nitrogen applied according to availability assessment by the farmer "
      NETMAN      "Supply from manure is excretion net of runoff and gaseous emissions"
      NETMAN2     "Manure application version 2"

      Penalty     "Term in feed distribution HDP for negative GVA"
      PMPT        "Pmp term"

      SUGBa
      SUGBb
      SUGBc

     INCE    Total available income,
     LAND    Land
     FEDE    Feed energy,
     SET.WELFPOS_SET,
$IF %MARKET_M%==ON SET.ADD_MARKET_ROWS,
     UvagA   Price for A sugarbeets
     UvagB   Price for B sugarbeets
     UvagC   Price for C sugarbeets
     INPE    Price index for agriculture
     ARAB
     FODD    Fodder in FEOGA
     HOPS    Hops in FEOGA
     EAAG    Use ind in FEOGA
     UAAR    Certain indicators expressed per UAA,

    SET.Frm_Rows
       /;


   SET SET_ENDW_COMM "Endowment commodities in GTAP used in CAPRI" /
    UnSkLab     "Unskilled labour"
    SkLab       "Skilled labour"
    Capital     "Capital"
    Land        "Land" /;

   SET ROWS(*) "Root for rows in the CAPRI data base (input, outputs, income and environmental indicators ...)" /
       SET.SET_DB_ROWS,
       SET.ADD_LABOUR_ROWS,
       SET.NBIL_COLS,
       SET.D_DUALS_ROWS,
       SET.GHGS_ROWS,
*
$IFI %non_policy_shocks%==on SET.SET_ENDW_COMM,
       SET.INTERM_COCO_ROWS,
       SET.POLICY_POS,
       SET.NCNC_POS
$ifi %CAPDIS%==ON ,SET.set_capdis_add_rows
   /;
   ALIAS (ROWS,ROWS1);

   SET DB_ROWS(ROWS) "Rows found in the data base"/
       SET.SET_DB_ROWS
       SET.GHGS_ROWS
   /;
   SET BIO_FUEL_ROWS(ROWS) / SET.SET_BIO_FUEL_ROWS /;
   SET FUEL_ROWS(ROWS) / SET.SET_FUEL_ROWS /;



$iftheni %MARKET_M%==ON
   SET MARKET_MODEL_ROWS(ROWS) /
     SET.WELFPOS_SET,
     SET.ADD_MARKET_ROWS
   /;
$endif

   SET INCINDS_ROWS(ROWS) "Income indicators" / set.incinds /;

   SET GAS_EMIS(ROWS) / SET.SET_GAS_EMIS /;

   SET ABC_R(ROWS) "Prices for A,B,C sugar" /
     UvagA   Price for A sugarbeets
     UvagB   Price for B sugarbeets
     UvagC   Price for C sugarbeets
   /;
*
  SET DUMMY / CNST
              CSSP Equivalent variation
              FEOG Feoga budget outlays first pillar
              TOOA EAA Output
              CRPA EAA Output crops
              ANIA EAA Output animals
              RESA EAA Output rest
  /;

   SET FERT_DIST(ROWS) "Fertiliser application rates (mineral, organic, other) per nutrient" / SET.FERT_DIST_ROWS /;
   ALIAS(FERT_DIST,FERT_DIST1);
*
   SET SECALL(ROWS) "Processed Outputs incl dairy" / SET.SECALL_ROWS /;
*
   SET SECO(ROWS) "Processed Outputs" / SET.SECO_NO_DAIRY_ROWS /;
   ALIAS(SECO,SECO1);
*
   SET SECO_BIOF(SECO) "Biofuels" /SET.SET_BIO_FUEL_ROWS /;
   SET bioRepCols(COLS) "Ethanol distinguished by source"    / SET.SET_bioRepCols /;
*
   Alias(bioRepCols,bioRepCols1);
*
   SET WHEPCASE(ROWS)   "Whey powder and casein"            /SET.WHEPCASE_ROWS/;
   SET MLKSECDIS(ROWS)  "Disaggregated milk secondaries"    /SET.MLKSECDIS_ROWS/;
*
   SET MlkMaprDis(ROWS) "Disaggregated milk prod with MAPR" /
      MILK   "Raw milk at dairy"
      SET.MLKSECDIS_ROWS
   /;
*
   SET MLKSECALL(ROWS)  "All milk secondaries" /
*$IF %PGMNAME%==GLOBAL WMIP   "Whole milk powder only and Whey powder and Casein"
      SET.MLKSECDIS_ROWS
   /;

   SET FNUT(ROWS) "Plant nutrient: nitrogen (N), phosphate (P2O5) and potash (K2O)" / SET.FNUT_ROWS /;

    SET O(ROWS)  "Outputs" /
      SET.FCO,
      SET.ICO,
      SET.ANIMO_ROWS,
      RQUO   Renting of milk quota
      SERO   Agricultural Services Output
      NASA   Non Agricultural Secondary Activities
    /;
*
    ALIAS (O,O1);


    SET CROPO(O) "Crop outputs" /

      SET.FCO
      SET.ICO
    /;

    SET FROWS(O) "Final crop and animal outputs" /
         SET.FCO,
         COMI   Milk for sales
         COMF   Milk for feeding
         BEEF   Beef
         PORK   Pork meat
         SGMI   Sheep and goat milk
         SGMF   Sheep and goat milk feeding
         SGMT   Sheep and goat meat
         EGGS   Laying hens
         POUM   Poultry meat
         OANI   Other animals output
     /;
*

    SET ANIMO(O) "Animal outputs" / SET.ANIMO_ROWS /;

    SET OYANI(O) "Young animals as outputs" / SET.OYANI_ROWS /;

    SET I_CAPRI(ROWS) "Inputs" /
*
      SET.FNUT_ROWS,
      SET.CIREST,
      SET.FEED_ROWS,
      SET.IYANI_ROWS,
*
*     *** Other animal specific
*
      IPHA   Pharmaceutical inputs,
      SET.IGEN
    /;

   SET IYANI(I_CAPRI) "Young animals as inputs" / SET.IYANI_ROWS /;
   SET FEED_CAPRI(I_CAPRI)  "Feedingstuff as inputs" / SET.FEED_ROWS /;
*   ALIAS (FEED_CAPRI,FEED1);

   SET FODDI(FEED_CAPRI) "Non tradeable feedingstuff as inputs" / SET.FODDI_ROWS /;

*
    ALIAS (CROPO,CROP1,CROPO1);
*
*   ---------------------------------- Rows -------------------------
*

    SET GHGSDEL_ROWS(ROWS)
      /
      SET.GHGS_DEL
     /;
*
*
    SET GHGS(ROWS)  / SET.GHGS_ROWS/;
*
    SET GASAGG(ROWS) / GCH4,GN2O,GCO2/;
*
*   Output of milk producing activities
*
    SET MLKO(ROWS) "COMI and SGMI als tradeable raw milk" / COMI, SGMI /;
    ALIAS (MLKO,MLKO1);
*
    SET MLKPRO(ROWS) / SET.MLKSECO_ROWS, MILK /;
    ALIAS (MLKPRO,MLKPR1);

    SET MLKSECO(ROWS) "Dairy products" / SET.MLKSECO_ROWS /;
*
    SET OSECO(ROWS) "Outputs and secondaries";
    OSECO(ROWS) = O(ROWS) + SECO(ROWS) + MLKSECO(ROWS);
*
    SET SECOM(ROWS) "Secondaries including dairy products";
    SECOM(ROWS) = SECO(ROWS) + MLKSECO(ROWS);
*
    SET IDW(ROWS) "Depreciation and wages" / DEPB,DEPM,DEPO,WAGE /;
*
    SET ILAB(ROWS) "Labour input" / LABT, LABF, LABP /;
*
    SET EAAIND(ROWS) "Positions which define the GVAM" / SET.EAAIND_ROWS /;
*
    SET psBudRows(ROWS) "Bugdets (EU, pillar I, national ..) from which policy instruments are paid" / SET.s_PS_budget /;
*
$IF %MARKET_M%==ON SET FATSPROTr(ROWS)   / FATS,PROT /;

*
    SET IO(ROWS) "Inputs and outputs";
     IO(ROWS) = O(ROWS) + I_CAPRI(ROWS) + SECO(ROWS);
*
    SET IOP(ROWS) "Input and outputs produced by activities";
     IOP(ROWS) = IO(ROWS) - SECO(ROWS);
*
    SET IO_NOFEED(ROWS) "Input and outputs produced by activities without feed";
     IO_NOFEED(ROWS) = IOP(ROWS) - FEED_ROWS(ROWS);
*
    SET PRCD(ROWS,ROWS) "I is processed from J"
     / RICE.PARI
       STAR.POTA
       MOLA.SUGB
       RAPO.RAPE
       SUNO.SUNF
       SOYO.SOYA
       OLIO.OLIV
       OTHO.OOIL
       RAPC.RAPE
       SUNC.SUNF
       SOYC.SOYA
       OLIC.OLIV
       OTHC.OOIL
       SUGA.SUGB
       MILK.(COMI,SGMI),
$IF NOT %MLK_DISAGG%==YES (BUTT,SMIP,CHES,FRMI,CREM,COCM,WMIP).MILK
$IF %MLK_DISAGG%==YES     (BUTT,SMIP,CHES,FRMI,CREM,COCM,WMIO,CASE,WHEP).MILK
        /;

      SET SECOD(SECO) "Processed outputs linked to PRCM";
      SECOD(SECO) $ SUM(PRCD(SECO,ROWS), 1) = YES;

      SET BIO_PRCD(ROWS,ROWS) /
          BIOE.WHEA
          BIOE.BARL
          BIOE.MAIZ
          BIOE.RYEM
          BIOE.OATS
          BIOE.OCER
          BIOE.TWIN
          BIOE.SUGA
          BIOD.SUNO
          BIOD.RAPO
          BIOD.SOYO
          BIOD.OOIL
            /;

      SET STOCK_TO_FUEL (ROWS,*) /
                   (WHEA,SWHE,BARL,MAIZ,OATS,RYEM,OCER,SUGA,TWIN).BIOE
                   (RAPO,SUNO,SOYO,PLMO,OTHO).BIOD /;

      SET bioStock (ROWS) "feedstocks used for bio fuel production" /
                   WHEA,SWHE,BARL,MAIZ,OATS,RYEM,OCER,SUGA,TWIN, RAPO,SUNO,SOYO,PLMO,OTHO,CERE,OILP /;

      SET bioStockCgra(bioStock) "coarse grains" / BARL,MAIZ,OATS,RYEM,OCER /;
      SET bioStockOilP(bioStock) "Oils" / RAPO,SUNO,SOYO,PLMO,OTHO /;

          Alias(BioStock,BioStock1);
          Alias(BioStockCgra,BioStockCgra1);

      SET BIO_BY(ROWS) "by- products of bio fuel production"
                /DDGS,GLYC/;

      SET bioCoef(COLS) "by- products of bio fuel production"
                /PRCB,PRCBY/;


      SET STOCK_TO_BY (ROWS,ROWS) /
                   (WHEA,SWHE,BARL,MAIZ,OATS,RYEM,OCER).DDGS
                   (RAPO,SUNO,SOYO,OTHO,PLMO).GLYC /;


      SET fuelByOrigin(seco_biof,bioRepCols,bioStock) /

      bioE.bioECere.Cere
      bioE.bioECgra.(BARL,MAIZ,OATS,RYEM,OCER)
      bioE.bioEWhea.Whea
      bioE.bioEBarl.Barl
      bioE.bioERyem.Ryem
      bioE.bioEMaiz.Maiz
      bioE.bioEOats.Oats
      bioE.bioEOcer.Ocer
      bioE.bioESuga.Suga
*      bioE.bioEMola.Mola
      bioE.bioETwin.Twin
      bioD.bioDOilP.OilP
      bioD.bioDRapo.Rapo
      bioD.bioDSuno.Suno
      bioD.bioDSoyo.Soyo
      bioD.bioDPlmo.Plmo
                         /;

*
*   Define inputs explictly handled as restrictions
*   as subset of INPUT
*
    SET IS(I_CAPRI) Inputs intrasectorally produced /
*
        NITF,  PHOF , POTF,
*       Feedingsstuff + young animals
        FCER , FPRO , FENE , FMIL , FOTH , FGRA,  FCOM, FSGM, FMAI, FROO, FOFA, FSTR,
        ICAM,  ICAF,  IHEI , ICOW , IPIG , IBUL,  ILAM /;
*

    SET FIX_YAI(PACT) Animals with fixed input coefficient for young animal / BULL,BULH,BULF,HEIL,HEIH,HEIF,PIGF,POUF,SHGF,HEIR,CAMR,CAFR,CAMF,CAFF /;
    SET FIX_YAO(PACT) Animals with fixed output coefficient for young animal / HEIR,CAMR,CAFR /;


    SET IY(I_CAPRI) "Directly yield dependent inputs";
    IY(I_CAPRI) $ (NOT IS(I_CAPRI)) = YES;
    IY("ICHI")          = NO;
    IY("WATR")          = NO;

    SET ISTORE(ROWS) "Input and incomce positions which are not needed as supply model runs";
    ISTORE(IY)        = YES;
    ISTORE(EAAIND)    = YES;
    ISTORE(FERT_DIST) = YES;
    ISTORE("LABF")    = YES;
    ISTORE("LABP")    = YES;
    ISTORE("LABT")    = YES;

*
*   Young animals, comprise outputs and inputs,
*   must be scaled later on
*
    SET OIYANI(ROWS) "Young animals" / SET.OYANI, SET.IYANI /;
*
*
   SET OM(ROWS) "Goods in supply model" /
*
     SWHE , DWHE , RYEM , BARL , OATS , MAIZ , OCER , PARI,
     RAPE , SUNF , SOYA , OLIV,
     PULS , POTA,  SUGB , TEXT, TOBA,
     TOMA , OVEG,  APPL , OFRU, CITR, TAGR,  TABO,  TWIN
     MAIF,  ROOF,  OFAR , GRAS,
     STRA

     COMI , COMF,
     BEEF , PORK , SGMI , SGMF,  SGMT , EGGS , POUM ,

     SET.OYANI_ROWS,
     SET.FNUT_ROWS
*
*    **** use of bulk feedingstuff
*
     FCER ,FPRO ,FENE ,FMIL ,FOTH /;

   SET OM_OUTPUT(ROWS) "Agricultural final outputs in supply model"/
*
     SWHE , DWHE , RYEM , BARL , OATS , MAIZ , OCER , PARI,
     RAPE , SUNF , SOYA , OLIV,
     PULS , POTA,  SUGB , TEXT, TOBA,
     TOMA , OVEG,  APPL , OFRU, CITR, TAGR,  TABO,  TWIN
     COMI ,
     BEEF , PORK , SGMI , SGMF,  SGMT , EGGS , POUM /;


   SET OM_OBJE(ROWS) "Goods in objective of supply model" /
     SWHE , DWHE , RYEM , BARL , OATS , MAIZ , OCER , PARI,
     RAPE , SUNF , SOYA , OLIV,
     PULS , POTA,  SUGB , TEXT, TOBA,
     TOMA , OVEG,  APPL , OFRU, CITR, TAGR,  TABO,  TWIN
     COMI ,
     BEEF , PORK , SGMI , SGMT , EGGS , POUM ,

     SET.OYANI_ROWS,
     SET.FNUT_ROWS
*
*    **** use of bulk feedingstuff
*
     FCER ,FPRO ,FENE ,FMIL ,FOTH /;

    set OM_OBJE_SCEN / set.om_obje /;

*
    ALIAS (OM,OM1);
*
   SET OMS(OM) "Goods with balances in the supply model" /
     SWHE , DWHE , RYEM , BARL , OATS , MAIZ , OCER , PARI,
     RAPE , SUNF , SOYA , OLIV,
     PULS , POTA,  SUGB , TEXT, TOBA
     TOMA , OVEG,  APPL , OFRU, CITR, TAGR,  TABO,  TWIN
     MAIF,  ROOF,  OFAR , GRAS

     COMI , COMF,
     BEEF , PORK , SGMI , SGMF,  SGMT , EGGS , POUM ,
     YCAM , YCAF,  YHEI , YCOW , YPIG ,
     STRA , YLAM , YCHI , YBUL ,
*
*    **** use of bulk feedingstuff
*
     FCER ,FPRO ,FENE ,FMIL ,FOTH /;

    SET OMYANI(OM) "Young animals as outputs in supply model" / SET.OYANI_ROWS /;
*
    SET RESIMP(ROWS) / FPRI,FENI /;

    SET RESIMP_T_O(*,*) "Link between by products from milling and processing and the products" /

        FPRI.(WHEA,SWHE,DWHE,RYEM,BARL,OATS,MAIZ,OCER,PARI)
        FENI.SUGA
    /;
*
   SET O_TO_YANI(ROWS,IYANI) Outputs -> Inputs/
*
*    e.g. Calves (CALV) are delivered to Input calves (ICAL)
*
    YCAM.ICAM
    YCAF.ICAF
    YHEI.IHEI
    YCOW.ICOW
    YPIG.IPIG
    YBUL.IBUL
    YCHI.ICHI
    YLAM.ILAM /
*
   SET PACT_TO_O(PACT,ROWS) "Mapping between production activities and outputs (main and secondaries) produced by them" /
*
       SWHE.(SWHE,STRA,MANN,MANP,MANK)
       DWHE.(DWHE,STRA,MANN,MANP,MANK)
       RYEM.(RYEM,STRA,MANN,MANP,MANK)
       BARL.(BARL,STRA,MANN,MANP,MANK)
       OATS.(OATS,STRA,MANN,MANP,MANK)
       MAIZ.(MAIZ,STRA,MANN,MANP,MANK)
       OCER.(OCER,STRA,MANN,MANP,MANK)
       PARI.(PARI,STRA,MANN,MANP,MANK)
       PULS.(PULS,MANN,MANP,MANK)
       POTA.(POTA,MANN,MANP,MANK)
       SUGB.(SUGB,MANN,MANP,MANK)
       RAPE.(RAPE,MANN,MANP,MANK)
       SUNF.(SUNF,MANN,MANP,MANK)
       SOYA.(SOYA,MANN,MANP,MANK)
       OLIV.(OLIV,MANN,MANP,MANK)
       OOIL.(OOIL,MANN,MANP,MANK)
       TEXT.(TEXT,OOIL,MANN,MANP,MANK)
       TOBA.(TOBA,MANN,MANP,MANK)
       OIND.(OIND,MANN,MANP,MANK)
       TOMA.(TOMA,MANN,MANP,MANK)
       OVEG.(OVEG,MANN,MANP,MANK)
       APPL.(APPL,MANN,MANP,MANK)
       OFRU.(OFRU,MANN,MANP,MANK)
       CITR.(CITR,MANN,MANP,MANK)
       TAGR.(TAGR,MANN,MANP,MANK)
       TABO.(TABO,MANN,MANP,MANK)
       TWIN.(TWIN,MANN,MANP,MANK)
       NURS.(NURS,MANN,MANP,MANK)
       FLOW.(FLOW,MANN,MANP,MANK)
       OCRO.(OCRO,MANN,MANP,MANK)
       NECR.(OCRO,MANN,MANP,MANK)
       DCOW.(COMI,COMF,BEEF,YCAM,YCAF,MANN,MANP,MANK)
       DCOL.(COMI,COMF,BEEF,YCAM,YCAF,MANN,MANP,MANK)
       DCOH.(COMI,COMF,BEEF,YCAM,YCAF,MANN,MANP,MANK)
       SCOW.(COMF,BEEF,YCAM,YCAF,MANN,MANP,MANK)
       BULF.(BEEF,MANN,MANP,MANK)
       BULL.(BEEF,MANN,MANP,MANK)
       BULH.(BEEF,MANN,MANP,MANK)
       CAMF.(BEEF,MANN,MANP,MANK)
       CAFF.(BEEF,MANN,MANP,MANK)
       PIGF.(PORK,MANN,MANP,MANK)
       SHGM.(SGMI,SGMF,SGMT,YLAM,MANN,MANP,MANK)
       SHGF.(SGMT,MANN,MANP,MANK)
       HENS.(EGGS,YCHI,POUM,MANN,MANP,MANK)
       POUF.(POUM,MANN,MANP,MANK)
       OANI.OANI
       MAIF.(MAIF,MANN,MANP,MANK)
       ROOF.(ROOF,MANN,MANP,MANK)
       OFAR.(OFAR,MANN,MANP,MANK)
       GRAS.(GRAS,MANN,MANP,MANK)
       GRAE.(GRAS,MANN,MANP,MANK)
       GRAI.(GRAS,MANN,MANP,MANK)
       GSET.(GRAS,MANN,MANP,MANK)
       TSET.(OCRO,MANN,MANP,MANK)
       CAMR.(YBUL,MANN,MANP,MANK)
       CAFR.(YHEI,MANN,MANP,MANK)
       HEIF.(BEEF,MANN,MANP,MANK)
       HEIL.(BEEF,MANN,MANP,MANK)
       HEIH.(BEEF,MANN,MANP,MANK)
       HEIR.(YCOW,MANN,MANP,MANK)
       SOWS.(YPIG,PORK,MANN,MANP,MANK)
       FALL.(MANN,MANP,MANK)
       VSET.(MANN,MANP,MANK)
       OSET.(MANN,MANP,MANK)
       /;
*
   SET NONEND(ROWS) "Products produced by fixed activities"
       END(ROWS)    "Products producted by non-fixed activities";


   set scenShiftedRows(ROWS) / YILD /;

   set scenShiftedRowsWeights(ROWS) / LEVL /;

   SET ScenShiftedRows_to_weights(scenshiftedRows,scenShiftedRowsWeights) / YILD.LEVL /;

*
   SET MrkBalE(COLS)   "Market balance positions to estimate"
                                          / IMPT,EXPT,FEDM,SEDM,INDM,PRCM,HCOM,LOSM /;
*
*  --- all outputs not produced by any endogenous activities are in the NONEND set
*
   NONEND(O)      $ (SUM(PACT_TO_O(EACT,O), 1.) EQ 0.)                        = YES;
*
*  --- as well as products derived from such outputs
*
   NONEND(SECO)   $ (SUM( (EACT,O) $ (PACT_TO_O(EACT,O) and PRCD(SECO,O)), 1.) EQ 0.) = YES;
   NONEND(SECO_biof)  = NO;
*
*  --- the remaining ones for endogenous
*
   END(OSECO)  = YES;
   END(O)      = YES;
   END(RESIMP) = YES;
   END(NONEND) = NO;
*
   SET PACT_TO_I(PACT,*) "Mapping between production activities and inputs used by them" /
*
       SWHE.(NITF,PHOF,POTF,CAOF,SEED,PLAP,REPM,REPB,ELEC,EGAS,EFUL,ELUB,WATR,INPO)
       DWHE.(NITF,PHOF,POTF,CAOF,SEED,PLAP,REPM,REPB,ELEC,EGAS,EFUL,ELUB,WATR,INPO)
       RYEM.(NITF,PHOF,POTF,CAOF,SEED,PLAP,REPM,REPB,ELEC,EGAS,EFUL,ELUB,WATR,INPO)
       BARL.(NITF,PHOF,POTF,CAOF,SEED,PLAP,REPM,REPB,ELEC,EGAS,EFUL,ELUB,WATR,INPO)
       OATS.(NITF,PHOF,POTF,CAOF,SEED,PLAP,REPM,REPB,ELEC,EGAS,EFUL,ELUB,WATR,INPO)
       MAIZ.(NITF,PHOF,POTF,CAOF,SEED,PLAP,REPM,REPB,ELEC,EGAS,EFUL,ELUB,WATR,INPO)
       OCER.(NITF,PHOF,POTF,CAOF,SEED,PLAP,REPM,REPB,ELEC,EGAS,EFUL,ELUB,WATR,INPO)
       PARI.(NITF,PHOF,POTF,CAOF,SEED,PLAP,REPM,REPB,ELEC,EGAS,EFUL,ELUB,WATR,INPO)
       PULS.(NITF,PHOF,POTF,CAOF,SEED,PLAP,REPM,REPB,ELEC,EGAS,EFUL,ELUB,WATR,INPO)
       POTA.(NITF,PHOF,POTF,CAOF,SEED,PLAP,REPM,REPB,ELEC,EGAS,EFUL,ELUB,WATR,INPO)
       SUGB.(NITF,PHOF,POTF,CAOF,SEED,PLAP,REPM,REPB,ELEC,EGAS,EFUL,ELUB,WATR,INPO)
       RAPE.(NITF,PHOF,POTF,CAOF,SEED,PLAP,REPM,REPB,ELEC,EGAS,EFUL,ELUB,WATR,INPO)
       SUNF.(NITF,PHOF,POTF,CAOF,SEED,PLAP,REPM,REPB,ELEC,EGAS,EFUL,ELUB,WATR,INPO)
       SOYA.(NITF,PHOF,POTF,CAOF,SEED,PLAP,REPM,REPB,ELEC,EGAS,EFUL,ELUB,WATR,INPO)
       OLIV.(NITF,PHOF,POTF,CAOF,SEED,PLAP,REPM,REPB,ELEC,EGAS,EFUL,ELUB,WATR,INPO)
       OOIL.(NITF,PHOF,POTF,CAOF,SEED,PLAP,REPM,REPB,ELEC,EGAS,EFUL,ELUB,WATR,INPO)
       TEXT.(NITF,PHOF,POTF,CAOF,SEED,PLAP,REPM,REPB,ELEC,EGAS,EFUL,ELUB,WATR,INPO)
       TOBA.(NITF,PHOF,POTF,CAOF,SEED,PLAP,REPM,REPB,ELEC,EGAS,EFUL,ELUB,WATR,INPO)
       OIND.(NITF,PHOF,POTF,CAOF,SEED,PLAP,REPM,REPB,ELEC,EGAS,EFUL,ELUB,WATR,INPO)
       TOMA.(NITF,PHOF,POTF,CAOF,SEED,PLAP,REPM,REPB,ELEC,EGAS,EFUL,ELUB,WATR,INPO)
       OVEG.(NITF,PHOF,POTF,CAOF,SEED,PLAP,REPM,REPB,ELEC,EGAS,EFUL,ELUB,WATR,INPO)
       APPL.(NITF,PHOF,POTF,CAOF,SEED,PLAP,REPM,REPB,ELEC,EGAS,EFUL,ELUB,WATR,INPO)
       OFRU.(NITF,PHOF,POTF,CAOF,SEED,PLAP,REPM,REPB,ELEC,EGAS,EFUL,ELUB,WATR,INPO)
       CITR.(NITF,PHOF,POTF,CAOF,SEED,PLAP,REPM,REPB,ELEC,EGAS,EFUL,ELUB,WATR,INPO)
       TAGR.(NITF,PHOF,POTF,CAOF,SEED,PLAP,REPM,REPB,ELEC,EGAS,EFUL,ELUB,WATR,INPO)
       TABO.(NITF,PHOF,POTF,CAOF,SEED,PLAP,REPM,REPB,ELEC,EGAS,EFUL,ELUB,WATR,INPO)
       TWIN.(NITF,PHOF,POTF,CAOF,SEED,PLAP,REPM,REPB,ELEC,EGAS,EFUL,ELUB,WATR,INPO)
       NURS.(NITF,PHOF,POTF,CAOF,SEED,PLAP,REPM,REPB,ELEC,EGAS,EFUL,ELUB,WATR,INPO)
       FLOW.(NITF,PHOF,POTF,CAOF,SEED,PLAP,REPM,REPB,ELEC,EGAS,EFUL,ELUB,WATR,INPO)
       OCRO.(NITF,PHOF,POTF,CAOF,SEED,PLAP,REPM,REPB,ELEC,EGAS,EFUL,ELUB,WATR,INPO)
       NECR.(NITF,PHOF,POTF,CAOF,SEED,PLAP,REPM,REPB,ELEC,EGAS,EFUL,ELUB,WATR,INPO)
       MAIF.(NITF,PHOF,POTF,CAOF,SEED,PLAP,REPM,REPB,ELEC,EGAS,EFUL,ELUB,WATR,INPO)
       ROOF.(NITF,PHOF,POTF,CAOF,SEED,PLAP,REPM,REPB,ELEC,EGAS,EFUL,ELUB,WATR,INPO)
       OFAR.(NITF,PHOF,POTF,CAOF,SEED,PLAP,REPM,REPB,ELEC,EGAS,EFUL,ELUB,WATR,INPO)
       GRAS.(NITF,PHOF,POTF,CAOF,SEED,PLAP,REPM,REPB,ELEC,EGAS,EFUL,ELUB,WATR,INPO)
       GRAE.(NITF,PHOF,POTF,CAOF,SEED,PLAP,REPM,REPB,ELEC,EGAS,EFUL,ELUB,WATR,INPO)
       GRAI.(NITF,PHOF,POTF,CAOF,SEED,PLAP,REPM,REPB,ELEC,EGAS,EFUL,ELUB,WATR,INPO)
       GSET.(NITF,PHOF,POTF,CAOF,SEED,PLAP,REPM,REPB,ELEC,EGAS,EFUL,ELUB,WATR,INPO)
       FALL.(NITF,PHOF,POTF,REPM,REPB,EFUL,ELUB,WATR,INPO)
       ISET.(NITF,PHOF,POTF,REPM,REPB,EFUL,ELUB,WATR,INPO)

       CATC.(SEED,REPM,REPB,EFUL,ELUB,WATR,INPO)
       TSET.(NITF,PHOF,POTF,CAOF,SEED,PLAP,REPM,REPB,ELEC,EGAS,EFUL,ELUB,WATR,INPO)
       VSET.(NITF,PHOF,POTF,REPM,REPB,EFUL,ELUB,WATR,INPO)
*
       DCOW.(FCER,FPRO,FENE,FMIL,FOTH,FGRA,FMAI,FCOM,FROO,FSGM,FOFA,FSTR,IPHA,REPM,REPB,ELEC,EGAS,EFUL,ELUB,WATR,INPO,ICOW)
       DCOL.(FCER,FPRO,FENE,FMIL,FOTH,FGRA,FMAI,FCOM,FROO,FSGM,FOFA,FSTR,IPHA,REPM,REPB,ELEC,EGAS,EFUL,ELUB,WATR,INPO,ICOW)
       DCOH.(FCER,FPRO,FENE,FMIL,FOTH,FGRA,FMAI,FCOM,FROO,FSGM,FOFA,FSTR,IPHA,REPM,REPB,ELEC,EGAS,EFUL,ELUB,WATR,INPO,ICOW)
       SCOW.(FCER,FPRO,FENE,FMIL,FOTH,FGRA,FMAI,FCOM,FROO,FSGM,FOFA,FSTR,IPHA,REPM,REPB,ELEC,EGAS,EFUL,ELUB,WATR,INPO,ICOW)
       BULF.(FCER,FPRO,FENE,FMIL,FOTH,FGRA,FMAI,FCOM,FROO,FSGM,FOFA,FSTR,IPHA,REPM,REPB,ELEC,EGAS,EFUL,ELUB,WATR,INPO,IBUL)
       BULL.(FCER,FPRO,FENE,FMIL,FOTH,FGRA,FMAI,FCOM,FROO,FSGM,FOFA,FSTR,IPHA,REPM,REPB,ELEC,EGAS,EFUL,ELUB,WATR,INPO,IBUL)
       BULH.(FCER,FPRO,FENE,FMIL,FOTH,FGRA,FMAI,FCOM,FROO,FSGM,FOFA,FSTR,IPHA,REPM,REPB,ELEC,EGAS,EFUL,ELUB,WATR,INPO,IBUL)
       CAMF.(FCER,FPRO,FENE,FMIL,FOTH,FGRA,FMAI,FCOM,FROO,FSGM,FOFA,FSTR,IPHA,REPM,REPB,ELEC,EGAS,EFUL,ELUB,WATR,INPO,ICAM,ICAL)
       CAFF.(FCER,FPRO,FENE,FMIL,FOTH,FGRA,FMAI,FCOM,FROO,FSGM,FOFA,FSTR,IPHA,REPM,REPB,ELEC,EGAS,EFUL,ELUB,WATR,INPO,ICAF,ICAL)
       PIGF.(FCER,FPRO,FENE,FMIL,FOTH,FGRA,FMAI,FCOM,FROO,FSGM,FOFA,FSTR,IPHA,REPM,REPB,ELEC,EGAS,EFUL,ELUB,WATR,INPO,IPIG)
       SHGM.(FCER,FPRO,FENE,FMIL,FOTH,FGRA,FMAI,FCOM,FROO,FSGM,FOFA,FSTR,IPHA,REPM,REPB,ELEC,EGAS,EFUL,ELUB,WATR,INPO,ILAM)
       SHGF.(FCER,FPRO,FENE,FMIL,FOTH,FGRA,FMAI,FCOM,FROO,FSGM,FOFA,FSTR,IPHA,REPM,REPB,ELEC,EGAS,EFUL,ELUB,WATR,INPO,ILAM)
       HENS.(FCER,FPRO,FENE,FMIL,FOTH,FGRA,FMAI,FCOM,FROO,FSGM,FOFA,FSTR,IPHA,REPM,REPB,ELEC,EGAS,EFUL,ELUB,WATR,INPO,ICHI)
       POUF.(FCER,FPRO,FENE,FMIL,FOTH,FGRA,FMAI,FCOM,FROO,FSGM,FOFA,FSTR,IPHA,REPM,REPB,ELEC,EGAS,EFUL,ELUB,WATR,INPO,ICHI)
       OANI.(FCER,FPRO,FENE,FMIL,FOTH,FGRA,FMAI,FCOM,FROO,FSGM,FOFA,FSTR,IPHA,REPM,REPB,ELEC,EGAS,EFUL,ELUB,WATR,INPO)
       CAMR.(FCER,FPRO,FENE,FMIL,FOTH,FGRA,FMAI,FCOM,FROO,FSGM,FOFA,FSTR,IPHA,REPM,REPB,ELEC,EGAS,EFUL,ELUB,WATR,INPO,ICAM,ICAL)
       CAFR.(FCER,FPRO,FENE,FMIL,FOTH,FGRA,FMAI,FCOM,FROO,FSGM,FOFA,FSTR,IPHA,REPM,REPB,ELEC,EGAS,EFUL,ELUB,WATR,INPO,ICAF,ICAL)
       HEIF.(FCER,FPRO,FENE,FMIL,FOTH,FGRA,FMAI,FCOM,FROO,FSGM,FOFA,FSTR,IPHA,REPM,REPB,ELEC,EGAS,EFUL,ELUB,WATR,INPO,IHEI)
       HEIL.(FCER,FPRO,FENE,FMIL,FOTH,FGRA,FMAI,FCOM,FROO,FSGM,FOFA,FSTR,IPHA,REPM,REPB,ELEC,EGAS,EFUL,ELUB,WATR,INPO,IHEI)
       HEIH.(FCER,FPRO,FENE,FMIL,FOTH,FGRA,FMAI,FCOM,FROO,FSGM,FOFA,FSTR,IPHA,REPM,REPB,ELEC,EGAS,EFUL,ELUB,WATR,INPO,IHEI)
       HEIR.(FCER,FPRO,FENE,FMIL,FOTH,FGRA,FMAI,FCOM,FROO,FSGM,FOFA,FSTR,IPHA,REPM,REPB,ELEC,EGAS,EFUL,ELUB,WATR,INPO,IHEI)
       SOWS.(FCER,FPRO,FENE,FMIL,FOTH,FGRA,FMAI,FCOM,FROO,FSGM,FOFA,FSTR,IPHA,REPM,REPB,ELEC,EGAS,EFUL,ELUB,WATR,INPO,IPIG)
*
       /;
*
       SET PACT_TO_IO(*,ROWS);
       PACT_TO_IO(PACT,O) $ PACT_TO_O(PACT,O) = YES;
       PACT_TO_IO(PACT,I_CAPRI) $ PACT_TO_I(PACT,I_CAPRI) = YES;
*
*
*  ---------------------------- main output for activities ------------------------------------------
*
   SET PACT_TO_Y(*,*) "Mapping between production activities and main output produced by them" /
*
       SWHE.SWHE
       DWHE.DWHE
       RYEM.RYEM
       BARL.BARL
       OATS.OATS
       MAIZ.MAIZ
       OCER.OCER
       PARI.PARI
       PULS.PULS
       POTA.POTA
       SUGB.SUGB
       RAPE.RAPE
       SUNF.SUNF
       SOYA.SOYA
       OLIV.OLIV
       OOIL.OOIL
       TEXT.TEXT
       TOBA.TOBA
       OIND.OIND
       TOMA.TOMA
       OVEG.OVEG
       APPL.APPL
       OFRU.OFRU
       CITR.CITR
       TAGR.TAGR
       TABO.TABO
       TWIN.TWIN
       NURS.NURS
       FLOW.FLOW
       OCRO.OCRO
       NECR.OCRO
       DCOW.COMI
       DCOL.COMI
       DCOH.COMI
       BULF.BEEF
       BULH.BEEF
       BULL.BEEF
       CAMF.BEEF
       CAFF.BEEF
       PIGF.PORK
       SHGM.SGMI
       SHGF.SGMT
       HENS.EGGS
       POUF.POUM
       OANI.OANI
       MAIF.MAIF
       OFAR.OFAR
       ROOF.ROOF
       GRAS.GRAS
       GRAI.GRAS
       GRAE.GRAS
       SCOW.YCAM
       CAMR.YBUL
       CAFR.YHEI
*      pw211011 Both HEIF and BULF need entries for coco:
       HEIF.BEEF
       HEIH.BEEF
       HEIL.BEEF
       HEIR.YCOW
       SOWS.YPIG
       GSET.GRAS
       TSET.OCRO
       NONF.RAPE
*
       CERE.CERE
       OILT.OILT
       ARAB.ARAB
       PERM.PERM
       FODD.FODD
       BEEF.BEEF
*
*      --- used in COCO
*
       ROO1.ROO1
       ROO2.ROO2
        /;

*
*------------------------------------------------------------------------
*
*      Sets used in N,P,K balance
*
*------------------------------------------------------------------------
*


   SET FNUT_TO_R(FNUT,ROWS)  / NITF.(NMAN,NMIN,NCRD,NRET)
                               PHOF.(PMAN,PMIN,PCRD,PRET)
                               POTF.(KMAN,KMIN,KCRD,KRET)/;

   SET DISTPOS "Fertilizer sources and sinks (excretions, mineral, crop residues, retained in crops" / EXCR,MINE,CRES,RETE /;


   SET DIST_TO_P(FERT_DIST,*)   / (NRET,PRET,KRET).RETE
                                  (NMAN,PMAN,KMAN).EXCR
                                  (NMIN,PMIN,KMIN).MINE
                                  (NCRD,PCRD,KCRD).CRES
                                   /;
*
   SET FOUT(O)    "Output of N,P2O,K2O from animals and crops"  / MANN,MANP,MANK/;
*
   SET FOUT_T_NC(FOUT,FNUT_COLS)  "Connection nutrient output to input"
    / MANN.NITF, MANP.PHOF, MANK.POTF /;

   SET FOUT_T_N(FOUT,FNUT)  "Connection nutrient output to input"
    / MANN.NITF, MANP.PHOF, MANK.POTF /;
*
*------------------------------------------------------------------------
*
*  Requirements
*
*
*  EN..  are different energy measurement used for the animals.
*  CRPR  is crude protein.
*  DRMN is minimum dry matter intake.
*  DRMX is maximum dry matter intake.
*
*
   SET REQSR(ROWS)      "Animal requirements as rows" / SET.REQSR_SET /;

   SET REQ_FEED(ROWS)   "Correction for inidivual feed" / SET.FEED_ROWS /;
*
   ALIAS(REQSR,REQM);
*
   SET REQSRE(REQSR) "Animal requirement as equality restriction" / ENNE,CRPR /;
   alias(reqsre,reqsre1);
*
*  ---- requirements in supply model
*
  SET REQMS(COLS)      "Requirements with restrictions in the supply module" / SET.REQS_MOD /;
  SET REQSR_M(ROWS)    "Requirements with restrictions in the supply module" / SET.REQS_MOD /;

  SET REQM_TO_MAACT(REQSR_M,MAACT);

  REQM_TO_MAACT("ENNE",MAACT) = YES;
  REQM_TO_MAACT("CRPR",MAACT) = YES;
  REQM_TO_MAACT("DRMN",MAACT) = YES;
  REQM_TO_MAACT("DRMX",MAACT) = YES;
  REQM_TO_MAACT("LISI","SOWS") = YES;
  REQM_TO_MAACT("LISI","HENS") = YES;
  REQM_TO_MAACT("LISI","POUF") = YES;
  REQM_TO_MAACT("LISI","PIGF") = YES;

  REQM_TO_MAACT("FICO","DCOL") = YES;
  REQM_TO_MAACT("FICO","DCOH") = YES;
  REQM_TO_MAACT("FICO","SCOW") = YES;
  REQM_TO_MAACT("FIDI","DCOL") = YES;
  REQM_TO_MAACT("FIDI","DCOH") = YES;
  REQM_TO_MAACT("FIDI","SCOW") = YES;
  REQM_TO_MAACT("FILG","DCOL") = YES;
  REQM_TO_MAACT("FILG","DCOH") = YES;
  REQM_TO_MAACT("FILG","SCOW") = YES;

  REQM_TO_MAACT("FICT","HEIR") = YES;
  REQM_TO_MAACT("FICT","HEIL") = YES;
  REQM_TO_MAACT("FICT","HEIH") = YES;
  REQM_TO_MAACT("FICT","BULL") = YES;
  REQM_TO_MAACT("FICT","BULH") = YES;
  REQM_TO_MAACT("FICT","CAMF") = YES;
  REQM_TO_MAACT("FICT","CAFF") = YES;
  REQM_TO_MAACT("FICT","CAMR") = YES;
  REQM_TO_MAACT("FICT","CAFR") = YES;

  REQM_TO_MAACT("FISM","SHGM") = YES;
  REQM_TO_MAACT("FISF","SHGF") = YES;


  SET MAACT_TO_REQM(MAACT,REQSR_M) "Mapping of animals to requirments";

  MAACT_TO_REQM(MAACT,REQSR_M) = REQM_TO_MAACT(REQSR_M,MAACT);

*
   SET REQMSE(REQMS)  "Requirements with equality restrictions"
                    / ENNE,CRPR /;
*
   SET REQMSN(REQMS)  "Requirements with inequality restrictions"
                    / DRMN,DRMX,LISI,
                      FICO,FICT,FISM,FISF,FIDI,FILG/;
*
*  SET MINSMAXS(REQM) / MINS,MAXS /;
*
   SET REQDRM(COLS) "Fibre requirement, linked to dry matter related" / FICO,FICT,FISM,FISF,FIDI,FILG /;
*
    SET REQC(REQSC) / ENNE, CRPR, DRMA /;
    SET REQCDRM(COLS) / DRMN,DRMX /;
*
*changed 281106, pw    SET CORF(FEED) Fodder where content is changed in regionalisation / FGRA,FMAI,FOFA /;
    SET CORF(FEED_CAPRI) "Fodder where content is changed in regionalisation" / FGRA,FOFA /;
*
    SET FODDO(ROWS) "Not tradeable feedingstuff as outputs"
       / GRAS,ROOF,COMF,SGMF,MAIF,OFAR,STRA/;
*
*
    SET FODDIO(ROWS) "Fodder as inputs and outputs";
    FODDIO(FODDO) = YES;
    FODDIO(I_CAPRI) $ SUM(SAMEAS(I_CAPRI,FODDI),1) = YES;

*
    SET ANIMEAT(AACT) "Animal categories producing meat (for final live weight)" /
                      BULH, BULL , HEIH, HEIL , CAMF , CAFF , PIGF , SHGF , POUF /;
*
    SET DFOD(FODDO)   / OFAR,STRA/;
    SET FODF(FODDO)   / OFAR,GRAS,ROOF,MAIF/;
    SET FODCRP(FODDO) / GRAS,OFAR,ROOF,MAIF,STRA/;
    ALIAS(FODF,FODF1);
*
    SET FODDOEAAP(FODDO) "Fodder by EAA net concept"          / ROOF,GRAS,MAIF,OFAR,STRA /;
    SET FODDOEAAG(FODDO) "Fodder valued by EAA gross concept" / COMF,SGMF /;
*
    SET QP(OMS) "Quota products" /COMI,SUGB/;
*
    SET FEED_TRD(FEED_CAPRI)  / SET.FEDTRD_ROWS/;
    alias(feed_trd,feed_trd1);
*
*   nutrient content of "raw" products in SPEL
*   ( + other feedingstuff not used in our model)
*
    SET FEED_TO_O(I_CAPRI,ROWS) "Feedingstuff -> Outputs" /
*
*    e.g. Soft Wheat (SWHE) is delivered to Feedingstuff Cereals (FCER)
*
    FCER.(SWHE,DWHE,RYEM,BARL,OATS,MAIZ,OCER,PARI,RICE),

    FPRO.(PULS,RAPO,SUNO,SOYO,OLIO,OTHO,RAPC,SUNC,SOYC,OLIC,OTHC,DDGS,FPRI),

    FOTH.(POTA,RAPE,SUNF,SOYA,OLIV,OOIL,TEXT,TOMA,OVEG,APPL,OFRU,CITR,TAGR,TABO,TWIN,SUGA,EGGS,PORK,BEEF),

$IF NOT %MLK_DISAGG%==YES FMIL.(SMIP,WMIP,BUTT,CREM,COCM,CHES,FRMI),
$IF %MLK_DISAGG%==YES     FMIL.(SMIP,WMIO,CASE,WHEP,BUTT,CREM,COCM,CHES,FRMI),

    FENE.(MOLA,STAR,FENI),
*
*   **** regionally restricted/only regionally tradeable fodder
*
    FMAI.MAIF,
    FSTR.STRA,
    FGRA.GRAS,
    FOFA.OFAR,
    FROO.ROOF,
    FCOM.COMF
    FSGM.SGMF
    /;
*
    SET FEDACT_TO_FODDI(FEDACT,FODDI) "Mapping between fodder producing activities and non-tradeable fodder inputs";

    FEDACT_TO_FODDI(FEDACT,FODDI) = SUM(FEED_TO_O(FODDI,FODDO) $ PACT_TO_O(FEDACT,FODDO),1);
*
    SET ENB / ENNE,ENMR,ENMP,ENMC /;
*
   SET SUBENE /
    NEL "Net energy lactation IPCC"
    NEM "Net energy maintenance IPCC"
    NEA "Net energy activity IPCC"
    NEP "Net energy pregnancy IPCC"
    NEG "Net energy growth IPCC"
   /;

   SET OAGG(ROWS) / SET.OAGG_ROWS,CERE,OILS /;


   SET GASCOLS(COLS) /
    N2OMAN,N2OMA2,N2OAP2,N2OAPL,N2OGRA,N2OSYN,N2OSYL,N2OSYS,N2OWAS,N2OHIS,N2OHIL,N2OLEA,N2OLEL,N2OLES,N2OCRO,N2OCRL,N2OFIX,N2OAMM,N2OAML,
    N2OAPP,N2OPRD,N2OPRL,N2OPRS,N2ODEP,N2OBUR,N2OBUL,CH4EN1,CH4EN2,CH4MA1,CH4MA2,CH4RIC,CH4BUR,CH4BUL,CO2PRD,CO2PRL,CO2PRS,CO2DIE,
         CO2DIL,CO2OFU,CO2OFL,CO2ELE,CO2ELL,CO2IND,CO2INL,CO2FTR,CO2FPR,CO2SEE,CO2SEL,CO2PPT,CO2PPL,CO2BIO,CO2BIL,CO2SOI,CO2SOL,CO2SEQ,
    CO2SQL,CO2HIS,CO2HIL,NH3MA2,NH3GR2,NH3AP2,NH3APL,NH3SYN,NH3SYL,NH3SYS,NH3CRO,NH3CRL,NOXMA2,NOXGR2,NOXAP2,NOXAPL,NOXSYN,NOXSYL,
         NOXSYS,NOXCRO,NOXCRL

/;

   SET GASROWS(ROWS) /
    NH3MA2,NH3GR2,NH3AP2,NH3APL,NH3SYN,NH3SYL,NH3SYS,NH3CRO,NH3CRL,
    NOXMA2,NOXGR2,NOXAP2,NOXAPL,NOXSYN,NOXSYL,NOXSYS,NOXCRO,NOXCRL
/;

 SET GHGS_DEL_ROWS(ROWS) / SET.GHGS_DEL /;


*  ------ Regional sets -------------------------------------------------
*
   SET R_LEVL "Regional levels used in feed and fertilizer contribution" / TOP,MS,NUTS1,NUTS2 /;


*
   SET NUTS0_EU15 /

       BL000000  "Belgium and Luxembourg"
       DK000000  "Denmark"
       DE000000  "Germany"
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
*
   SET R_EU15 /

       BL000000
       DK000000
       DE000000
       EL000000
       ES000000
       FR000000
       IR000000
       IT000000
       NL000000
       AT000000
       PT000000
       SE000000
       FI000000
       UK000000

    /;
*
   SET NUTS0_EU10 /

    CY000000  "Cyprus"
    CZ000000  "Czech Republic"
    EE000000  "Estonia"
    HU000000  "Hungary"
    LT000000  "Lithuania"
    LV000000  "Latvia"
    MT000000  "Malta"
    PL000000  "Poland"
    SI000000  "Slovenia"
    SK000000  "Slovak Republic"
   /;
*
   SET R_EU10 /

    CY000000
    CZ000000
    EE000000
    HU000000
    LT000000
    LV000000
    MT000000
    PL000000
    SI000000
    SK000000
   /;

   SET NUTS0_EU11 /

    CY000000  "Cyprus"
    CZ000000  "Czech Republic"
    EE000000  "Estonia"
    HU000000  "Hungary"
    LT000000  "Lithuania"
    LV000000  "Latvia"
    MT000000  "Malta"
    PL000000  "Poland"
    SI000000  "Slovenia"
    SK000000  "Slovak Republic"
    HR000000  "Croatia"
   /;
*
   SET R_EU11 /

    CY000000
    CZ000000
    EE000000
    HU000000
    LT000000
    LV000000
    MT000000
    PL000000
    SI000000
    SK000000
    HR000000
   /;

SET R_EU25 "EU25 Member States" /

   SET.R_EU15,
   SET.R_EU10
   /;

   SET NUTS0_BUR /
    BG000000  "Bulgaria"
    RO000000  "Romania"
    /;

   SET R_BUR /
    BG000000
    RO000000
    /;
*
   SET NUTS0_WBA7 /
       AL000000  "Albania"
       MK000000  "Macedonia"
       CS000000  "Serbia"
       MO000000  "Montenegro"
       HR000000  "Croatia"
       BA000000  "Bosnia and Herzegovina"
       KO000000  "Kosovo"
   /;
*
   SET R_WBA7 /
       AL000000
       MK000000
       CS000000
       MO000000
       HR000000
       BA000000
       KO000000
   /;

   SET NUTS0_WBA6 /
       AL000000  "Albania"
       MK000000  "Macedonia"
       CS000000  "Serbia"
       MO000000  "Montenegro"
       BA000000  "Bosnia and Herzegovina"
       KO000000  "Kosovo"
   /;
*
   SET R_WBA6 /
       AL000000
       MK000000
       CS000000
       MO000000
       BA000000
       KO000000
   /;

   SET NUTS0_RALL "All member states" /
*
*  -------------------- Nuts 0: Member states -------------------------
*
*
     SET.NUTS0_EU15,
     SET.NUTS0_EU10,
     SET.NUTS0_BUR,
*

     NO000000 "Norway",
*
     SET.NUTS0_WBA7,
*
     TUR "Turkey"
*
        /;

   SET R_MSALL "All member states" /
*
*  -------------------- Nuts 0: Member states -------------------------
*
*
     SET.R_EU15,
     SET.R_EU10,
     SET.R_BUR,
     NO000000 "Norway",
     SET.R_WBA7,
     TUR
*
        /;



   SET R_BL_ADDNUTS1 /

  BL200000  "Vlaams Gewest"
  BL300000  "Region wallonne"
   /;

   SET R_BL_NUTS12 /
  BL400000  "Luxembourg (Grand-Duche)"
   /;

   SET R_BL_NUTS1 /
      SET.R_BL_ADDNUTS1
      SET.R_BL_NUTS12
   /;

   SET R_BL_ADDNUTS2 /

  BL210000  "Antwerpen (Arrondissement)"
  BL220000  "Limburg (B)"
  BL230000  "Oost-Vlaanderen"
  BL240000  "Vlaams Brabant"
  BL250000  "West-Vlaanderen"
  BL310000  "Brabant Wallon"
  BL320000  "Hainaut"
  BL330000  "Verviers"
  BL340000  "Luxembourg (B)"
  BL350000  "Namur"
   /;

   SET R_BL_NUTS2 /
      SET.R_BL_NUTS12
      SET.R_BL_ADDNUTS2
   /;

   SET R_BL_RALL /
      SET.R_BL_ADDNUTS1,
      SET.R_BL_NUTS12,
      SET.R_BL_ADDNUTS2
   /;

   SET R_DE_NUTS12 /
     DE400000  "Brandenburg"
     DE800000  "Mecklenburg-Vorpommern"
     DEC00000  "Saarland"
     DED00000  "Sachsen"
     DEE00000  "Sachsen-Anhalt"
     DEF00000  "Schleswig-Holstein"
     DEG00000  "Thueringen"
   /;

   SET R_DE_ADDNUTS1 /
     DE100000   "Baden-Wuerttemberg"
     DE200000   "Bayern"
     DE700000   "Hessen"
     DE900000   "Niedersachsen"
     DEA00000   "Nordrhein-Westfalen"
     DEB00000   "Rheinland-Pfalz"
*AGO     DEE00000   "Sachsen-Anhalt"
   /;


   SET R_DE_NUTS1 /
      SET.R_DE_ADDNUTS1
      SET.R_DE_NUTS12
   /;
   SET R_DE_ADDNUTS2 /
     DE110000  "Stuttgart"
     DE120000  "Karlsruhe"
     DE130000  "Freiburg"
     DE140000  "Tuebingen"
     DE210000  "Oberbayern"
     DE220000  "Niederbayern"
     DE230000  "Oberpfalz"
     DE240000  "Oberfranken"
     DE250000  "Mittelfranken"
     DE260000  "Unterfranken"
     DE270000  "Schwaben"
     DE710000  "Darmstadt"
     DE720000  "Giessen"
     DE730000  "Kassel"
     DE910000  "Braunschweig"
     DE920000  "Hannover"
     DE930000  "Lueneburg"
     DE940000  "Weser-Ems"
     DEA10000  "Duesseldorf"
     DEA20000  "Koeln"
     DEA30000  "Muenster"
     DEA40000  "Detmold"
     DEA50000  "Arnsberg"
     DEB10000  "Koblenz"
     DEB20000  "Trier"
     DEB30000  "Rheinhessen-Pfalz"
   /;


   SET R_DE_NUTS2 /
      SET.R_DE_NUTS12
      SET.R_DE_ADDNUTS2
   /;

$onempty
   SET R_DK_RALL(*)//;
   SET R_LT_RALL(*)//;
   SET R_LV_RALL(*)//;
   SET R_EE_RALL(*)//;
   SET R_SI_RALL(*)//;
   SET R_CY_RALL(*)//;
   SET R_MT_RALL(*)//;
   SET R_AL_RALL(*)//;
   SET R_MK_RALL(*)//;
   SET R_CS_RALL(*)//;
   SET R_MO_RALL(*)//;
   SET R_HR_RALL(*)//;
   SET R_BA_RALL(*)//;
   SET R_KO_RALL(*)//;
$offempty

   SET R_DE_RALL /
      SET.R_DE_ADDNUTS1,
      SET.R_DE_NUTS12,
      SET.R_DE_ADDNUTS2
   /;


   SET R_EL_ADDNUTS1 /
     EL100000  "Voreia Ellada"
     EL200000  "Kentriki Ellada"
     EL400000  "Nisia aigaiou, Kriti"
   /;

   SET R_EL_NUTS12/
     EL300000  "Attiki"
   /;

   SET R_EL_NUTS1 /
      SET.R_EL_ADDNUTS1
      SET.R_EL_NUTS12
   /;

   SET R_EL_ADDNUTS2 /
     EL110000  "Anatoliki Makedonia, Thraki"
     EL120000  "Kentriki Makedonia"
     EL130000  "Dytiki Makedonia"
     EL140000  "Thessalia"
     EL210000  "Ipeiros"
     EL220000  "Ionia Nisia"
     EL230000  "Dytiki Ellada"
     EL240000  "Sterea Ellada"
     EL250000  "Peloponnisos"
     EL410000  "Voreio Aigaio"
     EL420000  "Notio Aigaio"
     EL430000  "Kriti"
   /;

   SET R_EL_NUTS2 /
      SET.R_EL_NUTS12
      SET.R_EL_ADDNUTS2
   /;

   SET R_EL_RALL /
      SET.R_EL_ADDNUTS1,
      SET.R_EL_NUTS12,
      SET.R_EL_ADDNUTS2
   /;


   SET R_ES_ADDNUTS1 /
     ES100000  "Noroeste"
     ES200000  "Noreste"
     ES400000  "Centro (E)"
     ES500000  "Este"
     ES600000  "Sur"
   /;

   SET R_ES_NUTS12 /
     ES300000  "Madrid"
     ES700000  "Canarias"
   /;

   SET R_ES_NUTS1 /
      SET.R_ES_ADDNUTS1
      SET.R_ES_NUTS12
   /;


   SET R_ES_ADDNUTS2 /
     ES110000  "Galicia"
     ES120000  "Asturias"
     ES130000  "Cantabria"
     ES210000  "Pais Vasco"
     ES220000  "Navarra"
     ES230000  "Rioja"
     ES240000  "Aragon"
     ES410000  "Castilla-Leon"
     ES420000  "Castilla-La Mancha"
     ES430000  "Extremadura"
     ES510000  "Cataluna"
     ES520000  "Comunidad Valenciana"
     ES530000  "Baleares"
     ES610000  "Andalucia"
     ES620000  "Murcia"
   /;

   SET R_ES_NUTS2 /
      SET.R_ES_NUTS12
      SET.R_ES_ADDNUTS2
   /;

   SET R_ES_RALL /
      SET.R_ES_ADDNUTS1,
      SET.R_ES_NUTS12,
      SET.R_ES_ADDNUTS2
   /;

   SET R_FR_NUTS12 /
    FR100000  "Ile de France"
    FR300000  "Nord-Pas-de-Calais"
   /;

   SET R_FR_ADDNUTS1 /
    FR200000  "Bassin Parisien"
    FR400000  "Est"
    FR500000  "Ouest"
    FR600000  "Sud-Ouest"
    FR700000  "Centre-Est"
    FR800000  "Mediterranee"
   /;

   SET R_FR_NUTS1 /
      SET.R_FR_ADDNUTS1
      SET.R_FR_NUTS12
   /;

   SET R_FR_ADDNUTS2 /
    FR210000  "Champagne-Ardenne"
    FR220000  "Picardie"
    FR230000  "Haute-Normandie"
    FR240000  "Centre"
    FR250000  "Basse-Normandie"
    FR260000  "Bourgogne"
    FR410000  "Lorraine"
    FR420000  "Alsace"
    FR430000  "Franche-Comte"
    FR510000  "Pays de la Loire"
    FR520000  "Bretagne"
    FR530000  "Poitou-Charentes"
    FR610000  "Aquitaine"
    FR620000  "Midi-Pyrenees"
    FR630000  "Limousin"
    FR710000  "Rhone-Alpes"
    FR720000  "Auvergne"
    FR810000  "Languedoc-Roussillon"
    FR820000  "Provence-Alpes-Cote d'Azur"
    FR830000  "Corse"
   /;

   SET R_FR_NUTS2 /
      SET.R_FR_NUTS12
      SET.R_FR_ADDNUTS2
   /;

   SET R_FR_RALL /
      SET.R_FR_ADDNUTS1,
      SET.R_FR_NUTS12,
      SET.R_FR_ADDNUTS2
   /;


   SET R_IR_NUTS1 /
    IR010000  "Border, Midlands and Western"
    IR020000  "Southern and Eastern"
   /;

   SET R_IR_NUTS2 /
     SET.R_IR_NUTS1
   /;

   SET R_IR_RALL /
     SET.R_IR_NUTS1
   /;

   SET R_IT_NUTS12 /
    IT200000  "Lombardia"
    IT400000  "Emilia-romagna"
    IT600000  "Lazio"
    IT800000  "Campania"
    ITA00000  "Sicilia"
    ITB00000  "Sardegna"
   /;

   SET R_IT_ADDNUTS1 /
    IT100000 "Nord Ovest"
    IT300000 "Nord Est"
    IT500000 "Centro (I)"
    IT700000 "Abruzzo-Molise"
    IT900000 "Sud"
   /;


   SET R_IT_NUTS1 /
      SET.R_IT_ADDNUTS1,
      SET.R_IT_NUTS12
   /;


   SET R_IT_ADDNUTS2 /
    IT110000    "Piemonte"
    IT120000    "Valle d'Aosta"
    IT130000    "Liguria"
    IT310000    "Trentino-Alto Adige"
    IT320000    "Veneto"
    IT330000    "Friuli-Venezia Giulia"
    IT510000    "Toscana"
    IT520000    "Umbria"
    IT530000    "Marche"
    IT710000    "Abruzzo"
    IT720000    "Molise"
    IT910000    "Puglia"
    IT920000    "Basilicata"
    IT930000    "Calabria"
   /;

   SET R_IT_NUTS2 /
      SET.R_IT_NUTS12
      SET.R_IT_ADDNUTS2
   /;

   SET R_IT_RALL /
      SET.R_IT_ADDNUTS1,
      SET.R_IT_NUTS12,
      SET.R_IT_ADDNUTS2
   /;

   SET R_NL_NUTS1 /
    NL100000  "Noord-Nederland"
    NL200000  "Oost-Nederland"
    NL300000  "West-Nederland"
    NL400000  "Zuid-Nederland"
   /;

   SET R_NL_NUTS2 /
    NL110000  "Groningen"
    NL120000  "Friesland"
    NL130000  "Drenthe"
    NL210000  "Overijssel"
    NL220000  "Gelderland"
    NL230000  "Flevoland"
    NL310000  "Utrecht"
    NL320000  "Noord-Holland"
    NL330000  "Zuid-Holland"
    NL340000  "Zeeland"
    NL410000  "Noord-Brabant"
    NL420000  "Limburg (NL)"
   /;

   SET R_NL_RALL /
    SET.R_NL_NUTS1
    SET.R_NL_NUTS2
   /;

   SET R_AT_NUTS1 /
    AT100000  "Ostoesterreich"
    AT200000  "Suedoesterreich"
    AT300000  "Westoesterreich"
   /;

   SET R_AT_NUTS2 /
    AT110000  "Burgenland"
    AT120000  "Niederoesterreich"
    AT210000  "Kaernten"
    AT220000  "Niederoesterreich-sued"
    AT310000  "Oberoesterreich"
    AT320000  "Salzburg"
    AT330000  "Tirol"
    AT340000  "Vorarlberg"
   /;

   SET R_AT_RALL /
    SET.R_AT_NUTS1
    SET.R_AT_NUTS2
   /;


   SET R_PT_NUTS12 /
    PT200000  "Acores"
    PT300000  "Madeira"
   /;

   SET R_PT_ADDNUTS1 /
    PT100000  "Continente"
   /;

   SET R_PT_NUTS1 /
      SET.R_PT_ADDNUTS1
      SET.R_PT_NUTS12
   /;

   SET R_PT_ADDNUTS2 /
    PT110000  "Norte"
    PT150000  "Algarve"
    PT160000  "Centro (PT)"
    PT170000  "Lisboa"
    PT180000  "Alentejo"
   /;

   SET R_PT_NUTS2 /
      SET.R_PT_NUTS12
      SET.R_PT_ADDNUTS2
   /;

   SET R_PT_RALL /
      SET.R_PT_ADDNUTS1,
      SET.R_PT_NUTS12,
      SET.R_PT_ADDNUTS2
   /;

   SET R_SE_NUTS1 /
    SE010000 "Stockholm"
    SE020000 "Oestra Mellansverige"
    SE040000 "Sydsverige"
    SE060000 "Norra Mellansverige"
    SE070000 "Mellersta Norrland"
    SE080000 "Oevre Norrland"
    SE090000 "Smaaland med Oearna"
    SE0A0000 "Vaestsverige"
   /;

   SET R_SE_NUTS2 /
    SET.R_SE_NUTS1
   /;
   SET R_SE_RALL /
    SET.R_SE_NUTS1
   /;

   SET R_FI_NUTS12 /
    FI200000  "Ahvenanmaa/Aaland"
   /;

   SET R_FI_ADDNUTS1 /
    FI100000 "Manner-Suomi"
   /;

   SET R_FI_NUTS1 /
      SET.R_FI_ADDNUTS1,
      SET.R_FI_NUTS12
   /;

   SET R_FI_ADDNUTS2 /
    FI130000  "Itae-Suomi"
    FI180000  "Etelae-Suomi"
    FI190000  "Laensi-Suomi"
    FI1A0000  "Pohjois-Suomi"
   /;

   SET R_FI_NUTS2 /
      SET.R_FI_NUTS12
      SET.R_FI_ADDNUTS2
   /;

   SET R_FI_RALL /
      SET.R_FI_ADDNUTS1,
      SET.R_FI_NUTS12,
      SET.R_FI_ADDNUTS2
   /;

   SET R_UK_NUTS1 /
    UKC00000  "North East"
    UKD00000  "North West (including Merseyside)"
    UKE00000  "Yorkshire and The Humber"
    UKF00000  "East Midlands"
    UKG00000  "West Midlands"
    UKH00000  "Eastern"
    UKJ00000  "South East"
    UKK00000  "South West"
    UKL00000  "Wales"
    UKM00000  "Scotland"
    UKN00000  "Northern Ireland"
   /;

   SET R_UK_RALL /
     SET.R_UK_NUTS1
   /;
   SET R_UK_NUTS2 /
     SET.R_UK_NUTS1
   /;


   SET old_NO_NUTS2 /
    NO111000  "Finnmark"
    NO121000  "Troms"
    NO122000  "Nordland"
    NO123000  "Nord-Troendelag"
    NO231000  "Soer-Troendelag"
    NO232000  "Hedmark"
    NO233000  "Oppland"
    NO241000  "Moere og Romsdal"
    NO242000  "Sogn og Fjordane"
    NO243000  "Hordaland"
    NO244000  "Rogaland"
    NO251000  "Aust-Agder"
    NO252000  "Vest-Agder"
    NO253000  "Telemark"
    NO254000  "Vestfold"
    NO255000  "Buskerud"
    NO261000  "Oslo og Akershus"
    NO262000  "OEstfold"
   /;

   SET R_NO_NUTS12 /
    NO012000    "Akershus"
   /;

   SET R_NO_ADDNUTS1 /
    NO020000
    NO030000
    NO040000
    NO050000
    NO060000
    NO070000
   /;

   SET R_NO_NUTS1 /
      SET.R_NO_ADDNUTS1,
      SET.R_NO_NUTS12
   /;

   SET R_NO_ADDNUTS2 /
    NO073000    "Finnmark"
    NO072000    "Troms"
    NO071000    "Nordland"
    NO062000    "Nord-Troendelag"
    NO061000    "Soer-Troendelag"
    NO021000    "Hedmark"
    NO022000    "Oppland"
    NO053000    "Moere og Romsdal"
    NO052000    "Sogn og Fjordane"
    NO051000    "Hordaland"
    NO043000    "Rogaland"
    NO041000    "Aust-Agder"
    NO042000    "Vest-Agder"
    NO034000    "Telemark"
    NO033000    "Vestfold"
    NO032000    "Buskerud"
*   NO011000    "Oslo is part of urbanNUTS"
    NO031000    "OEstfold"
   /;

   SET R_NO_NUTS2 /
      SET.R_NO_NUTS12
      SET.R_NO_ADDNUTS2
   /;

   SET R_NO_RALL /
      SET.R_NO_ADDNUTS1,
      SET.R_NO_NUTS12,
      SET.R_NO_ADDNUTS2
   /;


   SET R_CZ_NUTS1 /
    CZ000000
   /;

   SET R_CZ_NUTS2 /
    CZ010000    "Praha"
    CZ020000    "Strední Cechy"
    CZ030000    "Jihozápad"
    CZ040000    "Severozápad"
    CZ050000    "Severovýchod"
    CZ060000    "Jihovýchod"
    CZ070000    "Strední Morava"
    CZ080000    "Moravskoslezko"
   /;

   SET R_CZ_RALL /
      SET.R_CZ_NUTS2
   /;

   SET R_HU_NUTS12 /
    HU100000  "Közép-Magyarország"
   /;

   SET R_HU_ADDNUTS1 /
    HU200000  "Dunántúl"
    HU300000  "Alföld és Észak"
   /;

   SET R_HU_NUTS1 /
      SET.R_HU_NUTS12
      SET.R_HU_ADDNUTS1
   /;

   SET R_HU_ADDNUTS2 /
    HU210000  "Közép-Dunántúl"
    HU220000  "Nyugat-Dunántúl"
    HU230000  "Dél-Dunántúl"
    HU310000  "Észak-Magyarország"
    HU320000  "Észak-Alföld"
    HU330000  "Dél-Alföld"
   /;

   SET R_HU_NUTS2 /
      SET.R_HU_NUTS12
      SET.R_HU_ADDNUTS2
   /;

   SET R_HU_RALL /
      SET.R_HU_ADDNUTS1,
      SET.R_HU_NUTS12,
      SET.R_HU_ADDNUTS2
   /;

   SET R_PL_NUTS1 /
    PL100000  "Centralny"
    PL200000  "Poludniowy"
    PL300000  "Wschodni"
    PL400000  "Pólnocno-Zachodni"
    PL500000  "Poludniowo-Zachodni"
    PL600000  "Pólnocny"
   /;

   SET R_PL_NUTS2 /
    PL110000  "Lódzkie"
    PL120000  "Mazowieckie"
    PL210000  "Malopolskie"
    PL220000  "Slaskie"
    PL310000  "Lubelskie"
    PL320000  "Podkarpackie"
    PL330000  "Swietokrzyskie"
    PL340000  "Podlaskie"
    PL410000  "Wielkopolskie"
    PL420000  "Zachodniopomorskie"
    PL430000  "Lubuskie"
    PL510000  "Dolnoslaskie"
    PL520000  "Opolskie"
    PL610000  "Kujawsko-Pomorskie"
    PL620000  "Warminsko-Mazurskie"
    PL630000  "Pomorskie"
   /;

   SET R_PL_RALL /
     SET.R_PL_NUTS1
     SET.R_PL_NUTS2
   /;

   SET R_SK_NUTS1 /
    SK000000   "Slovak Republic"
   /;


   SET R_SK_NUTS2/
    SK010000   "Bratislavsky"
    SK020000   "Západné Slovensko"
    SK030000   "Stredné Slovensko"
    SK040000   "Východné Slovensko"
   /;

   SET R_SK_RALL /
     SET.R_SK_NUTS2
   /;

$ontext
   SET R_SI_NUTS1 /
    SI000000   "Slovenia"
   /;


   SET R_SI_NUTS2/

   SI010000   "Vzhodna Slovenija"
   SI020000   "Zahodna Slovenija"
   /;
$offtext


   SET R_BG_NUTS2 /
    BG010000  "Severozapaden"
    BG020000  "Severen tsentralen"
    BG030000  "Severoiztochen"
    BG040000  "Yugozazapaden"
    BG050000  "Yuzhen tsentralen"
    BG060000  "Yugoiztochen"
   /;

   SET R_BG_NUTS1 /
    BG000000  "Bulgaria"
   /;

   SET R_BG_RALL /
     SET.R_BG_NUTS2
   /;

   SET R_RO_NUTS1 /
    RO000000 "Romania"
   /;

   SET R_RO_NUTS2 /
    RO010000 "Nord-Est"
    RO020000 "Sud-Est"
    RO030000 "Sud"
    RO040000 "Sud-Vest"
    RO050000 "Vest"
    RO060000 "Nord-Vest"
    RO070000 "Centru"
    RO080000 "Bucuresti"
   /;
   SET R_RO_RALL /
    SET.R_RO_NUTS2
   /;

   SET R_TUR_NUTS12 /
     TR100000 "Istanbul"
     TR900000 "Dogu Karadeniz"
   /;

  SET R_TUR_ADDNUTS1 /
     TR200000 "Bati Marmara"
     TR300000 "Ege"
     TR400000 "Dogu Marmara"
     TR500000 "Bati Anadolu"
     TR600000 "Akdeniz"
     TR700000 "Orta Anadolu"
     TR800000 "Bati Karadeniz"
     TRA00000 "Kuzeydogu Anadolu"
     TRB00000 "Ortadogu Anadolu"
     TRC00000 "Güneydogu Anadolu"
  /;

  SET R_TUR_ADDNUTS2 /
   TR210000 "Tekirdag"
   TR220000 "Balikesir"
   TR310000 "Izmir"
   TR320000 "Aydin"
   TR330000 "Manisa"
   TR410000 "Bursa"
   TR420000 "Kocaeli"
   TR510000 "Ankara"
   TR520000 "Konya"
   TR610000 "Antalya"
   TR620000 "Adana"
   TR630000 "Hatay"
   TR710000 "Kirikkale"
   TR720000 "Kayseri"
   TR810000 "Zonguldak"
   TR820000 "Kastamonu"
   TR830000 "Samsun"
   TRA10000 "Erzurum"
   TRA20000 "Agri"
   TRB10000 "Malatya"
   TRB20000 "Van"
   TRC10000 "Gaziantep"
   TRC20000 "Sanliurfa"
   TRC30000 "Mardin"
  /;


   SET R_TUR_NUTS1 /
      SET.R_TUR_NUTS12
      SET.R_TUR_ADDNUTS1
   /;
   SET R_TUR_NUTS2 /
      SET.R_TUR_NUTS12
      SET.R_TUR_ADDNUTS2
   /;

   SET R_TUR_RALL /
      SET.R_TUR_ADDNUTS1,
      SET.R_TUR_NUTS12,
      SET.R_TUR_ADDNUTS2
   /;


$iftheni.rsets not setglobal dontLoadRegionalSets
*
*       --- include the FSS raw farm types -> Model FARM_F(FSS)
*
$ifi %FARM_F%==ON  $include 'farmtype\frm_sets_java.gms'

*
*       --- include the Capri types for calculating a consistent baseyear from result folder farmtypes
*
$ifi %FARM_B%==ON  $include 'farmtype\frmb_sets.gms'

*  SET RT_RW "Regional aggregates in market model" //;

 SET R_RM_NOT_RMS /

*      EU015000  "European Union 15"
*      EU010000  "European Union 10"
*      BUR       "Bulgaria and Romania"
       WBA       "Western balcans"
       MED       "Other mediterrean countries"
       URUPAR    "Uruguay and Paraguay"
       MER_OTH   "Bolivia, Chile, Venezuela"

  /;

 SET R_RM_AND_RMS /
*
       CH         "Switzerland"
       REU        "Rest of Europe"
       RUS        "Russia"
       UKR        "Ukraine"
       BEL        "Belarus"
       KAZ        "Kazathan"
       FSU        "Former Soviet Union without Russia"

       MOR        "Morocco"
       MIDEAST    "Middle East"
       NGA        "Nigeria"
       ETH        "Ethiopia"
       ZAF        "South Africa"
       AFR_LDC    "Africcan LDCs"
       AFR_REST   "Africa Rest (practically ACP)"

       IND        "India"
       PAK        "Pakistan"
       BGD        "Bangladesh"
       CHN        "China"
       JAP        "Japan"
       MAL        "Malaysia"
       INDO       "Indonesia"
       TAW        "Taiwan"
       SKOR       "South Korea"
$ifi not %NewGlobal% ==ON       ASI_TIG    "Asian Tigers: Hong Kong, Singapore"
       VIET
       THAI
       ASOCE_LDC  "Asian and Ociania LDC (Afghanistan, Bhutan, Cambodia, Laos, Maldives, Myanmar, Nepal, Timor Este, Kiribati, Solomones, Samoa, Tuvalu, Vanuatu"
       ASOCE_REST "Rest of Asia"

       ANZ       "Australia and New Zealand"

       USA       "USA"
       CAN       "Canada"
       MEX       "Mexico"
       ARG       "Argentina"
       BRA       "Brazil"
       MSA_ACP   "Middle and South America ACP"
       RSA       "Rest of South and Middle America"
  /;

  SET R_RMS_NOT_RM /
       TUN       "Tunesia"
       ALG       "Algeria"
       EGY       "Egypt"
       ISR       "Israel"
       VEN       "Venezuela"
       CHL       "Chile"
       URU       "Uruguay"
       PAR       "Paraguay"
       BOL       "Bolivia"
  /;

  SET R_RM_AGG /
       NONEU_EU  "Europe, non EU"

       ASIA      "Asia"
       AFRICA    "Africa"

       N_AM      "North America"
       MS_AM     "Middle and South America"

       MER       "Mercosur"

       HI_INC
       MID_INC
       LDCACP    "LDC and ACP"
       LDC      "LDC countries"
       ACP      "ACP countries"

       NONEU
       WOR
       World

       ROW_ESIM  "Rest of the world aggregate in ESIM definition"
       NON_ROW_ESIM  "Sum of regions explicitly covered in ESIM"

  /;

  SET R_EU_AGG /
       EU_WEST   "Western part of the EU - equal EU015000"
       EU_EAST   "Eastern part of the EU - can be either EU0100000 or EU011000"
       BUR       "Bulgaria and Romania"
  /;
*
  SET RALL "All regional units used in the CAPRI system" /
*
  TOP
*
  EU000000  "European Union"
  EU028000  "European Union 28"
  EU027000  "European Union 27"
  EU025000  "European Union 25"
  EU015000  "European Union 15"
  EU013000  "European Union 13 from 2013 onwards",
  EU012000  "European Union 12 until 2013",
  EU011000  "European Union 11 from 2013 onwards",
  EU010000  "European Union 10 untill 2013",

  WBA6      "Western Balcans 6 countries from 2013 onwards"
  WBA7      "Western Balcans 7 countries untill 2013"
*  BUR       "Bulgaria and Romania",

  SET.R_EU_AGG,
*
  SET.NUTS0_RALL,
*
  SET.R_BL_RALL,
  BL100000 "Region de Bruxelles-Capitale",

*
*       --- make farm sets part of set RALL
*
*           FARM_FSS mode
$ifi %FARM_F%==ON $include 'farmtype\frm_activate_sets.gms'

*           FARM_Baseyear mode
$ifi %FARM_B%==ON  $include 'farmtype\frmb_activate_sets.gms'
*           account for the comma
$ifi %FARM_B%==ON  ,
$ifi %FARM_F%==ON  ,

*
  SET.R_DE_RALL,
  DE300000 "Berlin",
  DE500000 "Bremen",
  DE600000 "Hamburg",
*
  SET.R_EL_RALL,
*
  SET.R_ES_RALL,
  ES630000 "Ciudad Autonoma de Ceuta (ES)",
  ES640000 "Ciudad Autonoma de Melilla (ES)",
*
  SET.R_FR_RALL,
*
  SET.R_IR_RALL,
*

  SET.R_IT_RALL,
*
  SET.R_NL_RALL,
*
  SET.R_AT_RALL,
  AT130000 "Wien",
*
  SET.R_PT_RALL,
*
  SET.R_SE_RALL,
*
  SET.R_FI_RALL,
*
  SET.R_UK_RALL,
  UKI00000  "Greater London",
*
  SET.R_NO_RALL,
  NO011000    "Oslo",
*
  SET.R_CZ_RALL,

  SET.R_HU_RALL,

*
  SET.R_PL_RALL,
*
  SET.R_SK_RALL,
*
* SET.R_SI_RALL,
*
  SET.R_BG_RALL,
*
  SET.R_RO_RALL,
*
  SET.R_TUR_RALL,

*
  SET.R_RM_NOT_RMS,
*
  SET.R_RM_AND_RMS,
*
  SET.R_RMS_NOT_RM,
  SET.R_RM_AGG,

* some regions in the Eurostat classification used to load FADN data

* DE600000,
  DK040000, DK030000, DK020000, DK050000, DK010000,
  DE410000, DE420000,
  DED10000, DED20000, DED30000,
  DEE10000, DEE20000, DEE30000,
  ITC10000,
  ITC20000,
  ITC30000,
  ITC40000,
  ITD10000,
  ITD20000,
  ITD30000,
  ITD40000,
  ITD50000,
  ITE10000,
  ITE20000,
  ITE30000,
  ITE40000,
  ITF10000,
  ITF20000,
  ITF30000,
  ITF40000,
  ITF50000,
  ITF60000,
  ITG10000,
  ITG20000,

  UKC10000,
  UKC20000,
  UKD10000,
  UKD20000,
  UKD30000,
  UKD40000,
  UKD50000,
  UKE10000,
  UKE20000,
  UKE30000,
  UKE40000,
  UKF10000,
  UKF20000,
  UKF30000,
  UKG10000,
  UKG20000,
  UKG30000,
  UKH10000,
  UKH20000,
  UKH30000,
  UKJ10000,
  UKJ20000,
  UKJ30000,
  UKJ40000,
  UKK10000,
  UKK20000,
  UKK30000,
  UKK40000,
  UKL10000,
  UKL20000,
  UKM20000,
  UKM30000,
  UKM50000,
  UKM60000,
* finished


  RW,
  AllImporters,

*
* --- temporary to use results from old trunk
*
  ROW


* --- EU as one policy block in the market model (see set RMTP)
  EU "European Union"

  /;



    SET REU15(RALL) /

       BL000000  "Belgium and Luxembourg"
       DK000000  "Denmark"
       DE000000  "Germany"
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


   SET REU10 (RALL)/

    CY000000  "Cyprus"
    CZ000000  "Czech Republic"
    EE000000  "Estonia"
    HU000000  "Hungary"
    LT000000  "Lithuania"
    LV000000  "Latvia"
    MT000000  "Malta"
    PL000000  "Poland"
    SI000000  "Slovenia"
    SK000000  "Slovak Republic"
   /;

   SET REU11 (RALL)/

    CY000000  "Cyprus"
    CZ000000  "Czech Republic"
    EE000000  "Estonia"
    HU000000  "Hungary"
    LT000000  "Lithuania"
    LV000000  "Latvia"
    MT000000  "Malta"
    PL000000  "Poland"
    SI000000  "Slovenia"
    SK000000  "Slovak Republic"
    HR000000  "Croatia"
   /;


    SET REU02 (RALL)/
    RO000000
    BG000000
   /;





*
*
   SET RAGG(RALL) "Current regional aggregates(s), dynamically defined";
   ALIAS(RAGG,RAGG1);

   SET RCMP(RALL) "Current regional components, dynamically defined";
   ALIAS (RCMP,RCMP1);
*
   SET RUNAGG(RALL) "Current aggregete to work upon";
*
   SET INFESR;
*
*
   SET RUNCLS        "Current cluster of member state";
*
   SET CLUST "Estimation clusters climate" / SOUTH, NORTH, ATLANT, CENTER /;
*

$ifi %FARM_B%==ON $include 'farmtype\frmb_set_alltypes.gms'
$ifi NOT %FARM_B%==ON SET ALLTYPES(RALL) /Top/;



   SET NONEU(*) / NO000000 "Norway"/;
*
   ALIAS (RALL,RALL1);

   SET R_BL(RALL) / SET.R_BL_RALL /;
   SET R_DE(RALL) / SET.R_DE_RALL /;
   SET R_EL(RALL) / SET.R_EL_RALL /;
   SET R_ES(RALL) / SET.R_ES_RALL /;
   SET R_FR(RALL) / SET.R_FR_RALL /;
   SET R_IR(RALL) / SET.R_IR_RALL /;
   SET R_IT(RALL) / SET.R_IT_RALL /;
   SET R_NL(RALL) / SET.R_NL_RALL /;
   SET R_AT(RALL) / SET.R_AT_RALL /;
   SET R_PT(RALL) / SET.R_PT_RALL /;
   SET R_FI(RALL) / SET.R_FI_RALL /;
   SET R_SE(RALL) / SET.R_SE_RALL /;
   SET R_UK(RALL) / SET.R_UK_RALL /;
   SET R_NO(RALL) / SET.R_NO_RALL /;
   SET R_CZ(RALL) / SET.R_CZ_RALL /;
   SET R_HU(RALL) / SET.R_HU_RALL /;
   SET R_PL(RALL) / SET.R_PL_RALL /;
   SET R_SK(RALL) / SET.R_SK_RALL /;
*  SET R_SI(RALL) / SET.R_SI_RALL /;
   SET R_BG(RALL) / SET.R_BG_RALL /;
   SET R_RO(RALL) / SET.R_RO_RALL /;
   SET R_TUR(RALL) / SET.R_TUR_RALL /;
* AGO This sets are necessary for a fast loadpoint from gdx data in captrdfrm
   SET R_MS_BL(RALL) / SET.R_BL_RALL,BL000000 /;
   SET R_MS_DE(RALL) / SET.R_DE_RALL,DE000000/;
   SET R_MS_EL(RALL) / SET.R_EL_RALL,EL000000/;
   SET R_MS_ES(RALL) / SET.R_ES_RALL,ES000000/;
   SET R_MS_FR(RALL) / SET.R_FR_RALL,FR000000/;
   SET R_MS_IR(RALL) / SET.R_IR_RALL,IR000000/;
   SET R_MS_IT(RALL) / SET.R_IT_RALL,IT000000/;
   SET R_MS_NL(RALL) / SET.R_NL_RALL,NL000000/;
   SET R_MS_AT(RALL) / SET.R_AT_RALL,AT000000/;
   SET R_MS_PT(RALL) / SET.R_PT_RALL,PT000000/;
   SET R_MS_FI(RALL) / SET.R_FI_RALL,FI000000/;
   SET R_MS_SE(RALL) / SET.R_SE_RALL,SE000000/;
   SET R_MS_UK(RALL) / SET.R_UK_RALL,UK000000/;
   SET R_MS_NO(RALL) / SET.R_NO_RALL,NO000000/;
   SET R_MS_CZ(RALL) / SET.R_CZ_RALL,CZ000000/;
   SET R_MS_HU(RALL) / SET.R_HU_RALL,HU000000/;
   SET R_MS_PL(RALL) / SET.R_PL_RALL,PL000000/;
   SET R_MS_SK(RALL) / SET.R_SK_RALL,SK000000/;
*  SET R_MS_SI(RALL) / SET.R_SI_RALL,SI000000/;
   SET R_MS_BG(RALL) / SET.R_BG_RALL,BG000000/;
   SET R_MS_RO(RALL) / SET.R_RO_RALL,RO000000/;
   SET R_MS_TUR(RALL) / SET.R_TUR_RALL,TUR/;

   SET R_MS_DK(RALL) / DK000000 /;
   SET R_MS_EE(RALL) / EE000000 /;
   SET R_MS_LT(RALL) / LT000000 /;
   SET R_MS_LV(RALL) / LV000000 /;
   SET R_MS_SI(RALL) / SI000000 /;
   SET R_MS_CY(RALL) / CY000000 /;
   SET R_MS_MT(RALL) / MT000000 /;
   SET R_MS_AL(RALL) / AL000000 /;
   SET R_MS_MK(RALL) / MK000000 /;
   SET R_MS_CS(RALL) / CS000000 /;
   SET R_MS_HR(RALL) / HR000000 /;
   SET R_MS_MO(RALL) / MO000000 /;
   SET R_MS_BA(RALL) / BA000000 /;
   SET R_MS_KO(RALL) / KO000000 /;

   SET R_NUTS0_EU15(RALL) / SET.NUTS0_EU15/;
   SET R_NUTS0_EU10(RALL) / SET.NUTS0_EU10/;
   SET R_NUTS0_EU11(RALL) / SET.NUTS0_EU11/;
   SET R_NUTS0_BUR (RALL) / SET.NUTS0_BUR /;
   SET R_NUTS0_WBA7 (RALL) / SET.NUTS0_WBA7 /;
   SET R_NUTS0_WBA6 (RALL) / SET.NUTS0_WBA6 /;

*

   ALIAS (RALL,RALL1);


set old_to_new_R_NO(old_NO_NUTS2,Rall) "mapping from old to new Norway regions" /
   NO111000.NO073000
   NO121000.NO072000
   NO122000.NO071000
   NO123000.NO062000
   NO231000.NO061000
   NO232000.NO021000
   NO233000.NO022000
   NO241000.NO053000
   NO242000.NO052000
   NO243000.NO051000
   NO244000.NO043000
   NO251000.NO041000
   NO252000.NO042000
   NO253000.NO034000
   NO254000.NO033000
   NO255000.NO032000
   NO261000.NO012000
   NO262000.NO031000
/;

* Note the set Map_RR shloud represent to EU27 or EU28 (but not both)
* for time being the Map_RR is defined here as the (testet and validated) EU27 and later updated

set Map_RR(RALL,RALL) "Regional hierarchy: mapping REGAGG->MS, MS->NUTS1, NUTS1->NUTS2, NUTS2->Farm tpyes" /


*
   BL000000.SET.R_BL
   BL000000.BL100000 "Region de Bruxelles-Capitale"
   BL200000.BL210000
   BL200000.BL220000
   BL200000.BL230000
   BL200000.BL240000
   BL200000.BL250000
   BL300000.BL310000
   BL300000.BL320000
   BL300000.BL330000
   BL300000.BL340000
   BL300000.BL350000
*
   DE000000.SET.R_DE
   DE000000.DE300000 "Berlin"
   DE000000.DE500000 "Bremen"
   DE000000.DE600000 "Hamburg"

   DE100000.DE110000
   DE100000.DE120000
   DE100000.DE130000
   DE100000.DE140000
   DE200000.DE210000
   DE200000.DE220000
   DE200000.DE230000
   DE200000.DE240000
   DE200000.DE250000
   DE200000.DE260000
   DE200000.DE270000
   DE700000.DE710000
   DE700000.DE720000
   DE700000.DE730000
   DE900000.DE910000
   DE900000.DE920000
   DE900000.DE930000
   DE900000.DE940000
   DEA00000.DEA10000
   DEA00000.DEA20000
   DEA00000.DEA30000
   DEA00000.DEA40000
   DEA00000.DEA50000
   DEB00000.DEB10000
   DEB00000.DEB20000
   DEB00000.DEB30000
*   DEE00000.DEE10000
*   DEE00000.DEE20000
*   DEE00000.DEE30000

   EL000000.SET.R_EL
   EL100000.EL110000
   EL100000.EL120000
   EL100000.EL130000
   EL100000.EL140000
   EL200000.EL210000
   EL200000.EL220000
   EL200000.EL230000
   EL200000.EL240000
   EL200000.EL250000
   EL400000.EL410000
   EL400000.EL420000
   EL400000.EL430000

   ES000000.SET.R_ES
   ES000000.ES630000 "Ciudad Autonoma de Ceuta (ES)"
   ES000000.ES640000 "Ciudad Autonoma de Melilla (ES)"
   ES100000.ES110000
   ES100000.ES120000
   ES100000.ES130000
   ES200000.ES210000
   ES200000.ES220000
   ES200000.ES230000
   ES200000.ES240000
   ES400000.ES410000
   ES400000.ES420000
   ES400000.ES430000
   ES500000.ES510000
   ES500000.ES520000
   ES500000.ES530000
   ES600000.ES610000
   ES600000.ES620000

   FR000000.SET.R_FR
   FR200000.FR210000
   FR200000.FR220000
   FR200000.FR230000
   FR200000.FR240000
   FR200000.FR250000
   FR200000.FR260000
   FR400000.FR410000
   FR400000.FR420000
   FR400000.FR430000
   FR500000.FR510000
   FR500000.FR520000
   FR500000.FR530000
   FR600000.FR610000
   FR600000.FR620000
   FR600000.FR630000
   FR700000.FR710000
   FR700000.FR720000
   FR800000.FR810000
   FR800000.FR820000
   FR800000.FR830000

   IR000000.SET.R_IR

   IT000000.SET.R_IT
   IT100000.IT110000
   IT100000.IT120000
   IT100000.IT130000
   IT300000.IT310000
   IT300000.IT320000
   IT300000.IT330000
   IT500000.IT510000
   IT500000.IT520000
   IT500000.IT530000
   IT700000.IT710000
   IT700000.IT720000
   IT900000.IT910000
   IT900000.IT920000
   IT900000.IT930000

   NL000000.SET.R_NL
   NL100000.NL110000
   NL100000.NL120000
   NL100000.NL130000
   NL200000.NL210000
   NL200000.NL220000
   NL200000.NL230000
   NL300000.NL310000
   NL300000.NL320000
   NL300000.NL330000
   NL300000.NL340000
   NL400000.NL410000
   NL400000.NL420000

   AT000000.SET.R_AT
   AT000000.AT130000   "Wien"
   AT100000.AT110000
   AT100000.AT120000
   AT200000.AT210000
   AT200000.AT220000
   AT300000.AT310000
   AT300000.AT320000
   AT300000.AT330000
   AT300000.AT340000

   PT000000.SET.R_PT
   PT100000.PT110000
   PT100000.PT150000
   PT100000.PT160000
   PT100000.PT170000
   PT100000.PT180000

   SE000000.SET.R_SE

   FI000000.FI000000
   FI000000.SET.R_FI
   FI100000.FI130000
   FI100000.FI180000
   FI100000.FI190000
   FI100000.FI1A0000

   UK000000.SET.R_UK
   UK000000.UKI00000  "Greater London"

   NO000000.NO000000
   NO000000.SET.R_NO
   NO000000.NO011000  "Oslo"
   NO070000.NO073000
   NO070000.NO072000
   NO070000.NO071000
   NO060000.NO062000
   NO060000.NO061000
   NO020000.NO021000
   NO020000.NO022000
   NO050000.NO053000
   NO050000.NO052000
   NO050000.NO051000
   NO040000.NO043000
   NO040000.NO041000
   NO040000.NO042000
   NO030000.NO034000
   NO030000.NO033000
   NO030000.NO032000
   NO030000.NO031000

   CZ000000.SET.R_CZ

   HU000000.SET.R_HU
   HU100000.HU100000
   HU200000.HU210000
   HU200000.HU220000
   HU200000.HU230000
   HU300000.HU310000
   HU300000.HU320000
   HU300000.HU330000

   PL000000.SET.R_PL
   PL100000.PL110000
   PL100000.PL120000
   PL200000.PL210000
   PL200000.PL220000
   PL300000.PL310000
   PL300000.PL320000
   PL300000.PL330000
   PL300000.PL340000
   PL400000.PL410000
   PL400000.PL420000
   PL400000.PL430000
   PL500000.PL510000
   PL500000.PL520000
   PL600000.PL610000
   PL600000.PL620000
   PL600000.PL630000

   SK000000.SET.R_SK

*  SI000000.SET.R_SI

   BG000000.SET.R_BG

   RO000000.SET.R_RO

   TUR     .SET.R_TUR
   TR100000.TR100000
   TR900000.TR900000
   TR200000.TR210000
   TR200000.TR220000
   TR300000.TR310000
   TR300000.TR320000
   TR300000.TR330000
   TR400000.TR410000
   TR400000.TR420000
   TR500000.TR510000
   TR500000.TR520000
   TR600000.TR610000
   TR600000.TR620000
   TR600000.TR630000
   TR700000.TR710000
   TR700000.TR720000
   TR800000.TR810000
   TR800000.TR820000
   TR800000.TR830000
   TRA00000.TRA10000
   TRA00000.TRA20000
   TRB00000.TRB10000
   TRB00000.TRB20000
   TRC00000.TRC10000
   TRC00000.TRC20000
   TRC00000.TRC30000



$ifi %FARM_B%==ON $include 'farmtype\frmb_map_rr_type.gms'


/;
*AGO ---  used in Farm_F capreg
   SET FULL_MAP_RR(*,*) "Copy of MAP_RR for reload";
   FULL_MAP_RR(RALL,RALL1)= MAP_RR(RALL,RALL1);



* added after the deliverable 1)
$ifi %FARM_B%==ON $include 'farmtype\frmb_set_aggrtypes.gms'




*





SET SRNUTS1(RALL) "Sub Regions that are nuts1 regions" /
*
*

       SET.R_BL_NUTS1,

       DK000000  "Denmark",

       SET.R_DE_NUTS1,
       SET.R_EL_NUTS1,
       SET.R_ES_NUTS1,
       SET.R_FR_NUTS1,
       SET.R_IR_NUTS1,
       SET.R_IT_NUTS1,
       SET.R_NL_NUTS1,
       SET.R_AT_NUTS1,
       SET.R_PT_NUTS1,
       SET.R_FI_NUTS1,

       SE000000,

       SET.R_UK_NUTS1,

       CZ000000
       EE000000
       LT000000
       LV000000
       SI000000
       SK000000
       CY000000
       MT000000,

       SET.R_HU_NUTS1,
       SET.R_PL_NUTS1,

       SET.R_NO_NUTS1
*
       BG000000
       RO000000,
*
       SET.R_TUR_NUTS1
*
       AL000000
       MK000000
       CS000000
       MO000000  "Montenegro"
       HR000000   "Croatia"
       BA000000
       KO000000
/;

SET NUTS0(RALL)   "Member states" / SET.NUTS0_RALL /

SET SRNUTS2_EXT(RALL) "Sub Regions that are nuts2 regions, including nuts2 without agriculture" /
*
  SET.R_BL_NUTS2,
  BL100000 "Region de Bruxelles-Capitale",

*
  DK000000 "Denmark",
*
  SET.R_DE_NUTS2,
  DE300000 "Berlin",
  DE500000 "Bremen",
  DE600000 "Hamburg",


  SET.R_EL_NUTS2,
  SET.R_ES_NUTS2,
  ES630000 "Ciudad Autónoma de Ceuta (ES)",
  ES640000 "Ciudad Autónoma de Melilla (ES)",

  SET.R_FR_NUTS2,
  SET.R_IR_NUTS2,
  SET.R_IT_NUTS2,
  SET.R_NL_NUTS2,
  SET.R_AT_NUTS2,
  AT130000 "Wien",

  SET.R_PT_NUTS2,
  SET.R_SE_NUTS2,
  SET.R_FI_NUTS2,
  SET.R_UK_NUTS2,
  UKI00000 "Greater London",
*
  SET.R_CZ_NUTS2,
*
  EE000000 "ESTONIA",
*
  SET.R_HU_NUTS2,
*
  LT000000 "LITHUANIA",
*
  LV000000 "LATVIA",
*
  SET.R_PL_NUTS2,
*
  SI000000 "Slovenia",
* SET.R_SI_NUTS2,
*
  SET.R_SK_NUTS2,
*
  CY000000 "CYPRUS",
*
  MT000000 "MALTA",
*
  SET.R_BG_NUTS2,
  SET.R_RO_NUTS2,
*
  SET.R_NO_NUTS2,
  NO011000    "Oslo",

  SET.R_TUR_NUTS2,
*
  AL000000  "Albania"
  MK000000  "Macedonia"
  CS000000  "Serbia"
  HR000000  "Croatia"
  MO000000  "Montenegro"
  BA000000  "Bosnia and Herzegovina"
  KO000000  "Kosovo"
/;
SET SRNUTS2(SRNUTS2_EXT) "Sub Regions that are nuts2 regions" /
*
  SET.R_BL_NUTS2,
*
  DK000000 "Denmark",
*
  SET.R_DE_NUTS2,
  SET.R_EL_NUTS2,
  SET.R_ES_NUTS2,
  SET.R_FR_NUTS2,
  SET.R_IR_NUTS2,
  SET.R_IT_NUTS2,
  SET.R_NL_NUTS2,
  SET.R_AT_NUTS2,
  SET.R_PT_NUTS2,
  SET.R_SE_NUTS2,
  SET.R_FI_NUTS2,
  SET.R_UK_NUTS2,
*
  SET.R_CZ_NUTS2,
*
  EE000000  "ESTONIA",
*
  SET.R_HU_NUTS2,
*
  LT000000 "LITHUANIA",
*
  LV000000 "LATVIA",
*
  SET.R_PL_NUTS2,
*
  SI000000 "Slovenia",

* SET.R_SI_NUTS2,
*
  SET.R_SK_NUTS2,
*
  CY000000 "CYPRUS",
*
  MT000000 "MALTA",
*
  SET.R_BG_NUTS2,
  SET.R_RO_NUTS2,
  SET.R_NO_NUTS2,
  SET.R_TUR_NUTS2,
*
  AL000000  "Albania"
  MK000000  "Macedonia"
  CS000000  "Serbia"
  HR000000  "Croatia"
  MO000000  "Montenegro"
  BA000000  "Bosnia and Herzegovina"
  KO000000  "Kosovo"
/;

  SET urbanNUTS(RALL) "Sub Regions that are nuts2 regions without agriculture" /
  BL100000 "Region de Bruxelles-Capitale",
  DE300000 "Berlin",
  DE500000 "Bremen",
  DE600000 "Hamburg",
  ES630000 "Ciudad Autónoma de Ceuta (ES)",
  ES640000 "Ciudad Autónoma de Melilla (ES)",
  AT130000 "Wien",
  UKI00000 "Greater London",
  NO011000 "Oslo"
/;

  SET R_DK_NUTS2(RALL) / DK000000 /;
  SET R_EE_NUTS2(RALL) / EE000000 /;
  SET R_LT_NUTS2(RALL) / LT000000 /;
  SET R_LV_NUTS2(RALL) / LV000000 /;
  SET R_SI_NUTS2(RALL) / SI000000 /;
  SET R_CY_NUTS2(RALL) / CY000000 /;
  SET R_MT_NUTS2(RALL) / MT000000 /;
  SET R_AL_NUTS2(RALL) / AL000000 /;
  SET R_MK_NUTS2(RALL) / MK000000 /;
  SET R_CS_NUTS2(RALL) / CS000000 /;
  SET R_HR_NUTS2(RALL) / HR000000 /;
  SET R_MO_NUTS2(RALL) / MO000000 /;
  SET R_BA_NUTS2(RALL) / BA000000 /;
  SET R_KO_NUTS2(RALL) / KO000000 /;


  ALIAS(SRNUTS2,SRNUTS21);

  SET NUTS0_and_2(RALL) /
*
  SET.NUTS0,

  SET.R_BL_NUTS2,
  SET.R_DE_NUTS2,
  SET.R_EL_NUTS2,
  SET.R_ES_NUTS2,
  SET.R_FR_NUTS2,
  SET.R_IR_NUTS2,
  SET.R_IT_NUTS2,
  SET.R_NL_NUTS2,
  SET.R_AT_NUTS2,
  SET.R_PT_NUTS2,
  SET.R_SE_NUTS2,
  SET.R_FI_NUTS2,
  SET.R_UK_NUTS2,
  SET.R_CZ_NUTS2,
  SET.R_HU_NUTS2,
  SET.R_PL_NUTS2,
  SET.R_SK_NUTS2,
* SET.R_SI_NUTS2,
  SET.R_BG_NUTS2,
  SET.R_RO_NUTS2,
  SET.R_NO_NUTS2,
  SET.R_TUR_NUTS2
  /;

  MAP_RR(NUTS0,NUTS0)     = YES;
  MAP_RR(SRNUTS2,SRNUTS2) $ (SRNUTS1(SRNUTS2)) = YES;

*
   SET MSALL(RALL) "All member states and aggregates" /
*
       EU027000 "European Union 27"
       EU025000 "European Union 25"
       EU015000 "European Union 15"
       EU012000 "European Union 12"
       EU010000 "European Union 10",
*
*  -------------------- Nuts 0: Member states -------------------------
*
       SET.NUTS0
    /;
*
   SET RUNMS(MSALL)   "Current member state";

   SET ASSMS(MSALL) / SET.NUTS0_EU10,TUR,SET.NUTS0_WBA7 /;
$ifi %EUMODE%==EU27    SET NEWMS(MSALL) / SET.NUTS0_EU10,SET.NUTS0_BUR /;
$ifi %EUMODE%==EU28    SET NEWMS(MSALL) / SET.NUTS0_EU11,SET.NUTS0_BUR /;

$IFI %EUMODE%==EU27 SET MSnoEU(RALL)  "Supply countries currently outside the EU" /NO000000,TUR,WBA,SET.R_NUTS0_WBA7/;
$IFI %EUMODE%==EU28 SET MSnoEU(RALL)  "Supply countries currently outside the EU" /NO000000,TUR,WBA,SET.R_NUTS0_WBA6/;

* --------------------------- define EU Aggregates --------------------------

 SET EUAllAgg(RALL) "All EU Aggragtes" /EU028000, EU027000, EU025000, EU015000, EU010000, EU011000, EU012000, EU013000, BUR/;

 SET EU28Agg(RALL) "Regions within EU28" /EU015000, EU011000, EU013000, BUR/;

 SET EU27Agg(RALL) "Regions within EU27" /EU015000, EU010000, EU012000, BUR/;

 SET EU25Agg(RALL) "Regions within EU25" /EU015000, EU010000/;

 SET EUTopAgg(RALL)     "top level aggregates of the EU" /EU025000, EU027000, EU028000/;
 SET EUSubAgg(RALL)     "Subdivisions of the EU" /EU015000, EU010000, EU011000, EU012000, EU013000, BUR/;
 SET EUWestAgg(RALL)    "Regions in Western part of EU" /EU015000 /;
 SET EUEastAgg(RALL)    "Regions in Eastern part of EU" /EU011000, EU010000, EU012000, EU013000, BUR/;
 SET EUEastEAgg(RALL)   "Regions in Eastern part of EU excluding Bulgaria, Romania" /EU011000, EU010000/;
 SET EUEastIAgg(RALL)   "Regions in Eastern part of EU including Bulgaria, Romania" /EU012000, EU013000/;

 SET EUWBAAgg(RALL) "All EU and WBA Aggragtes" /EU028000, EU027000, EU025000, EU015000, EU010000, EU011000, EU012000, EU013000, BUR, WBA6, WBA7/;

* --------------------------- Regional hierarchy changing over time ----------------------

SET MAP_RRT(RALL,RALL,*) "Regional hierarchy changing over time: mapping EUAGG -> REGAGG, REGAGG->MS";

* former static MAP_RR
*   EU000000.EU000000
*   EU000000.EU015000
*   EU000000.EU010000

*   EU015000.EU015000
*   EU010000.EU010000

*   EU015000.SET.R_NUTS0_EU15
*   EU010000.SET.R_NUTS0_EU10
*   BUR     .SET.R_NUTS0_BUR,
*   WBA     .SET.R_NUTS0_WBA7,

*
    MAP_RRT("EU000000","EU015000",SIMYY) $ (CALYEA(SIMYY) ge CALYEA("1984"))= YES;
    MAP_RRT("EU015000","EU015000",SIMYY) $ (CALYEA(SIMYY) ge CALYEA("1984"))= YES;
    MAP_RRT("EU_WEST","EU015000",SIMYY)  $ (CALYEA(SIMYY) ge CALYEA("1984"))= YES;
    MAP_RRT("EU010000","EU010000",SIMYY) $ ((CALYEA(SIMYY) ge CALYEA("2004")) and (CALYEA(SIMYY) le CALYEA("2012"))) = YES;
    MAP_RRT("EU_EAST","EU010000",SIMYY) $ ((CALYEA(SIMYY) ge CALYEA("2004")) and (CALYEA(SIMYY) le CALYEA("2012"))) = YES;
    MAP_RRT("EU_EAST","EU011000",SIMYY) $ (CALYEA(SIMYY) ge CALYEA("2013")) = YES;
    MAP_RRT("EU011000","EU011000",SIMYY) $ (CALYEA(SIMYY) ge CALYEA("2013")) = YES;
    MAP_RRT("BUR","BUR",SIMYY)      $ (CALYEA(SIMYY) ge CALYEA("2007")) = YES;

    MAP_RRT("EU",R_NUTS0_EU15,SIMYY) $ (CALYEA(SIMYY) ge CALYEA("1984")) = YES;
    MAP_RRT("EU",R_NUTS0_EU10,SIMYY) $ (CALYEA(SIMYY) ge CALYEA("2004")) = YES;
    MAP_RRT("EU",R_NUTS0_BUR,SIMYY)  $ (CALYEA(SIMYY) ge CALYEA("2007")) = YES;
    MAP_RRT("EU","HR000000",SIMYY)   $ (CALYEA(SIMYY) ge CALYEA("2013")) = YES;

    MAP_RRT("EU","EU015000",SIMYY) $ ((CALYEA(SIMYY) ge CALYEA("1984")) and (CALYEA(SIMYY) le CALYEA("2003"))) = YES;
    MAP_RRT("EU",EU25Agg,SIMYY) $ ((CALYEA(SIMYY) ge CALYEA("2004")) and (CALYEA(SIMYY) le CALYEA("2006"))) = YES;
    MAP_RRT("EU",EU27Agg,SIMYY) $ ((CALYEA(SIMYY) ge CALYEA("2007")) and (CALYEA(SIMYY) le CALYEA("2012"))) = YES;
    MAP_RRT("EU",EU28Agg,SIMYY) $ (CALYEA(SIMYY) ge CALYEA("2013"))  = YES;




    MAP_RRT("EU","EU_WEST",SIMYY) $ (CALYEA(SIMYY) ge CALYEA("1984")) = YES;
    MAP_RRT("EU","EU_EAST",SIMYY) $ (CALYEA(SIMYY) ge CALYEA("2004")) = YES;
    MAP_RRT("EU","BUR",SIMYY) $ (CALYEA(SIMYY) ge CALYEA("2007")) = YES;

    MAP_RRT("EU_WEST",R_NUTS0_EU15,SIMYY) $ MAP_RRT("EU_WEST","EU015000",SIMYY) = YES;
    MAP_RRT("EU_EAST",R_NUTS0_EU10,SIMYY) $ MAP_RRT("EU_EAST","EU010000",SIMYY) = YES;
    MAP_RRT("EU_EAST",R_NUTS0_EU11,SIMYY) $ MAP_RRT("EU_EAST","EU011000",SIMYY) = YES;
    MAP_RRT("EU015000",R_NUTS0_EU15,SIMYY) $ MAP_RRT("EU_WEST","EU015000",SIMYY) = YES;
    MAP_RRT("EU010000",R_NUTS0_EU10,SIMYY) $ MAP_RRT("EU_EAST","EU010000",SIMYY) = YES;
    MAP_RRT("EU011000",R_NUTS0_EU11,SIMYY) $ MAP_RRT("EU_EAST","EU011000",SIMYY) = YES;
    MAP_RRT("BUR",R_NUTS0_BUR,SIMYY)     $ MAP_RRT("BUR","BUR",SIMYY) = YES;
    MAP_RRT("WBA7",R_NUTS0_WBA7,SIMYY) $ ((CALYEA(SIMYY) ge CALYEA("1984")) and (CALYEA(SIMYY) lt CALYEA("2013")))  = YES;
    MAP_RRT("WBA6",R_NUTS0_WBA6,SIMYY) $ (CALYEA(SIMYY) ge CALYEA("2013"))  = YES;
    MAP_RRT("WBA",R_NUTS0_WBA7,SIMYY) $ ((CALYEA(SIMYY) ge CALYEA("1984")) and (CALYEA(SIMYY) lt CALYEA("2013")))  = YES;
    MAP_RRT("WBA",R_NUTS0_WBA6,SIMYY) $ (CALYEA(SIMYY) ge CALYEA("2013"))  = YES;


    MAP_RRT("EU_WEST","EU015000",SIMYY)  $ (CALYEA(SIMYY) ge CALYEA("1984"))= YES;





* former static MAP_RR
* MAP_RR("EU025000",RALL) $ MAP_RR("EU015000",RALL) = YES;
* MAP_RR("EU025000",RALL) $ MAP_RR("EU010000",RALL) = YES;
* MAP_RR("EU012000",RALL) $ MAP_RR("EU010000",RALL) = YES;
* MAP_RR("EU012000",RALL) $ MAP_RR("BUR",RALL)      = YES;
* MAP_RR("EU027000",RALL) $ MAP_RR("EU025000",RALL) = YES;
* MAP_RR("EU027000",RALL) $ MAP_RR("BUR",RALL) = YES;
* MAP_RR("EU027000","BUR")  = YES;

    MAP_RRT("EU025000",RALL,SIMYY) $ ((MAP_RRT("EU015000",RALL,SIMYY) or MAP_RRT("EU010000",RALL,SIMYY))
                                     and (CALYEA(SIMYY) ge CALYEA("2004"))) = YES;

    MAP_RRT("EU027000",RALL,SIMYY) $ ((MAP_RRT("EU015000",RALL,SIMYY) or MAP_RRT("EU010000",RALL,SIMYY) or MAP_RRT("BUR",RALL,SIMYY))
                                     and (CALYEA(SIMYY) ge CALYEA("2007"))) = YES;

    MAP_RRT("EU028000",RALL,SIMYY) $ ((MAP_RRT("EU015000",RALL,SIMYY) or MAP_RRT("EU011000",RALL,SIMYY) or MAP_RRT("BUR",RALL,SIMYY))
                                     and (CALYEA(SIMYY) ge CALYEA("2013"))) = YES;

    MAP_RRT("EU012000",RALL,SIMYY) $ ((MAP_RRT("EU010000",RALL,SIMYY) or MAP_RRT("BUR",RALL,SIMYY))
                                     and (CALYEA(SIMYY) ge CALYEA("2007")))  = YES;

    MAP_RRT("EU013000",RALL,SIMYY) $ ((MAP_RRT("EU011000",RALL,SIMYY) or MAP_RRT("BUR",RALL,SIMYY))
                                     and (CALYEA(SIMYY) ge CALYEA("2013"))) = YES;


    MAP_RRT(RALL,RALL1,"FIX") = MAP_RR(RALL,RALL1);

    MAP_RRT(RALL,RALL1,"ALL") = 1 $ SUM(SIMYY, MAP_RRT(RALL,RALL1,SIMYY));

* after summing up over years, Croatia is in both aggregates, delete in one depending on the EUMode
$ifi %EUMODE%==EU28 MAP_RRT("WBA","HR000000","ALL") = NO;
$ifi %EUMODE%==EU27 MAP_RRT("EU_EAST","HR000000","ALL") = NO;

* in the 2010 the map is as it was static defined before,
* make capri work as it was before:

*$batinclude create_static_region_sets.gms ALL





*
* --------------------------- regional sets in the Armington market model ----------------------
*
 SET RM_NOT_RMS(RALL) /

       EU015000  "European Union 15"
       EU_EAST  "European Union 15"
       BUR       "Bulgaria and Romania",

       SET.R_RM_NOT_RMS
  /;


 SET RM_AND_RMS(RALL) /
  SET.R_RM_AND_RMS

  /;

 SET RMS_NOT_RM(RALL) /
  SET.R_RMS_NOT_RM
 /;

 SET R_RMS(RALL) /

       EU015000 "European Union 15"
       EU_EAST "European Union 10"
*
       BUR
       WBA
       MED,
*
       SET.R_MSALL,
*
       REU
       RUS

       USA
       CAN
       MEX
       VEN
       ARG
       BRA
       CHL
       URU
       PAR
       BOL
       MSA_ACP
       RSA

       IND
       CHN
       JAP
       TAW
       SKOR
       MAL
       INDO
$ifi not %NewGlobal% ==ON       ASI_TIG
       ASOCE_LDC
       ASOCE_REST

       ANZ

*      TUR
       MOR
       TUN
       ALG
       EGY
       ISR
       MIDEAST
       AFR_LDC
       AFR_REST


 /;

 SET RMall(Rall) "All regions in market model plus aggregates"
    /
       EU028000
       EU027000
       EU025000
       EU012000,
       EU013000,

       EU

       SET.NUTS0,
       SET.RM_NOT_RMS,
       SET.RM_AND_RMS,
       SET.RMS_NOT_RM,

       SET.R_RM_AGG,

       RW
       AllImporters
   /;

   ALIAS(RMALL,RMALL1);

*
 SET RM(RMall)  "Regional aggregates with own policy presentation"
     /
       NO000000 "Norway",
       TUR      "Turkey",
       SET.RM_NOT_RMS,
       SET.RM_AND_RMS
     /;
 ALIAS(RM,RM1,RM2,RM3);

*
 SET RMS(RMall) Regions with behavioural functions /

        SET.NUTS0,
        SET.RM_AND_RMS,
        SET.RMS_NOT_RM
*
        /;

  SET RMorRMS(RMall) Regions with behavioural functions /

        SET.NUTS0,
        SET.RM_AND_RMS,
        SET.RMS_NOT_RM
        SET.RM_NOT_RMS
*
        /;



 ALIAS (RMS,RMS1);

*
 SET RMSSUP(RMS) / SET.NUTS0 /;

 ALIAS (RMSSUP,RMSSUP1);


 SET RMS_TO_RM(RMS,*) "Match member states and aggregates to aggregates"

  /
        SET.R_NUTS0_EU15.EU015000,


        SET.R_NUTS0_EU10.EU_EAST,
$ifi %EUMODE%==EU28   HR000000.EU_EAST,

        SET.R_NUTS0_BUR.BUR,


        NO000000.NO000000,
        CH      .CH
        TUR     .TUR,

        SET.R_NUTS0_WBA6.WBA,
$ifi %EUMODE%==EU27   HR000000.WBA,

        RUS     .RUS
        UKR     .UKR
        BEL     .BEL
        KAZ     .KAZ
        FSU     .FSU
        REU     .REU

        MOR     .MOR
        (TUN,ALG,EGY,ISR).MED
        NGA     .NGA
        ETH     .ETH
        ZAF     .ZAF

        MIDEAST.MIDEAST

        AFR_LDC .AFR_LDC
        AFR_REST.AFR_REST

        IND     .IND
        CHN     .CHN
        PAK     .PAK
        BGD     .BGD
        JAP     .JAP
        MAL     .MAL
        VIET    .VIET
        THAI    .THAI
        INDO    .INDO
        TAW     .TAW
        SKOR    .SKOR
$ifi not %NewGlobal% ==ON       ASI_TIG .ASI_TIG
        ASOCE_LDC.ASOCE_LDC
        ASOCE_REST.ASOCE_REST

        USA     .USA
        CAN     .CAN
        MEX     .MEX
        ARG     .ARG  "Argentina"
        BRA     .BRA  "Brazil"
        MSA_ACP.MSA_ACP
        (URU,PAR).URUPAR
        (BOL,VEN,CHL).MER_OTH

        RSA     .RSA

        ANZ     .ANZ


      /;

     SET RM_TO_RMS(RM,RMS);
     RM_TO_RMS(RM,RMS) $ RMS_TO_RM(RMS,RM) = YES;

      parameter p_testRmsMapping(RMS);

      p_testRmsMapping(RMS) = sum(rms_to_rm(rms,rm), 1) -1;

 display p_testRmsMapping;

      if ( sum(rms $ p_testRmsMapping(RMS),1), abort "RMS element not or several times assigned ",p_testRmsMapping,RMS_TO_RM);
*

* EU regions in the market model
SET RMEU(rAll) /EU, EU015000, EU_EAST, BUR/;

SET EUMODE /EU27,EU28/;

* mapping market model regions to regions
SET RMEU_TO_EUAGG_EUMODE(RMEU,RALL,EUMODE) /
   EU.      EU027000.EU27
   EU015000.EU015000.EU27
   EU_EAST .EU010000.EU27
   BUR     .BUR     .EU27
   EU      .EU028000.EU28
   EU015000.EU015000.EU28
   EU_EAST .EU011000.EU28
   BUR     .BUR     .EU28
  /;

* mapping market model regions to regions over time
SET RMEU_TO_EUAGG_T(RMEU,RALL,*);

    RMEU_TO_EUAGG_T(RMEU,EUALLAGG,SIMYY) $  (CALYEA(SIMYY) ge CALYEA("2013")) = RMEU_TO_EUAGG_EUMODE(RMEU,EUALLAGG,"EU28");
    RMEU_TO_EUAGG_T(RMEU,EUALLAGG,SIMYY) $  (CALYEA(SIMYY) lt CALYEA("2013")) = RMEU_TO_EUAGG_EUMODE(RMEU,EUALLAGG,"EU27");


   SET MS_EU "Set without longtexts, used in the connection with META data handling" /
       BL000000,DK000000,DE000000,EL000000,ES000000,FR000000,IR000000,IT000000,NL000000,AT000000,PT000000,SE000000,FI000000,UK000000
       CY000000,CZ000000,EE000000,HU000000,LT000000,LV000000,MT000000,PL000000,SI000000,SK000000,BG000000,RO000000, HR000000 /;

*  all aggregate regions covered by supply model (used to aggregate market model results otherwise only availabe for rmAggSup)

 SET AggSup(RALL);
 AGGSup(RM) $ (SUM(MAP_RR(RM,RMSSUP),1) GT 1) = YES;
 AGGSup(EUWBAAgg) $ (SUM(MAP_RR(EUWBAAgg,RMSSUP),1) GT 1) = YES;


*  agregate market model regions covered by supply model

 SET RmAggSup(RM);
 RmAGGSup(RM) $ (SUM(MAP_RR(RM,RMSSUP),1) GT 1) = YES;


 SET RMAGG(RM);
 RMAGG(RM)  $ (SUM(RMS_TO_RM(RMS,RM),1) GT 1)    = YES;

 SET rmsAgg(RMS);
 rmsAGG(RMS)  $ SUM(RMS_TO_RM(RMS,RMAGG),1) = YES;

 SET RW(RMALL) /EU

$ifi %EUMODE%==EU27  EU027000
$ifi %EUMODE%==EU27  EU025000
$ifi %EUMODE%==EU27  EU012000
$ifi %EUMODE%==EU28  EU028000
$ifi %EUMODE%==EU28  EU013000

                NONEU_EU  "Europe, non EU"

                AFRICA    "Africa - geographic"
                ASIA      "Asia - geographic"
                N_AM      "North America"
                MS_AM     "Middle and South America"
                ANZ

                MER       "Mercosur"

                HI_INC    "High income"
                MID_INC   "Middle income"
                LDCACP    "LDCs and ACP countries"
                LDC      "LDC countries"
                ACP      "ACP countries"
*
                NONEU     "Non EU"

                ROW_ESIM      "Rest of world aggregate in ESIM definition"
                NON_ROW_ESIM  "Sum of regions explicitly covered in ESIM"

*               AllImporters
*               OutOfBlock
                World
                /;

 ALIAS(RW,RW1);

 SET RW_TO_RM(RW,RM) / EU.(EU015000,EU_EAST,BUR)
$ifi %EUMODE%==EU27     EU027000.(EU015000,EU_EAST,BUR)
$ifi %EUMODE%==EU27     EU025000.(EU015000,EU_EAST)
$ifi %EUMODE%==EU27     EU012000.(EU_EAST,BUR)
$ifi %EUMODE%==EU28     EU028000.(EU015000,EU_EAST,BUR)
$ifi %EUMODE%==EU28     EU013000.(EU_EAST,BUR)
*
*  --- (1) geographic
*
                       NONEU_EU.(CH,NO000000,WBA,REU,RUS,UKR,BEL,KAZ,FSU,TUR)

                       AFRICA.(MOR,MED,NGA,ETH,ZAF,AFR_LDC,AFR_REST)
                       ASIA.(MIDEAST,IND,PAK,BGD,CHN,JAP,MAL,INDO,TAW,SKOR,
$ifi not %NewGlobal% ==ON       ASI_TIG,
                             VIET,THAI,ASOCE_LDC,ASOCE_REST)
*
*                      MIDEAST is already a block
*
                       N_AM.(USA,CAN,MEX)
                       MS_AM.(ARG,BRA,URUPAR,MER_OTH,RSA,MSA_ACP)
*
                       ANZ.ANZ
*

*
*  --- (2) Political economy
*

                       HI_INC.(NO000000,REU,CH,USA,CAN,MEX,JAP,ANZ,TAW,SKOR
$ifi not %NewGlobal% ==ON       ,ASI_TIG
                               )
                       MER.(ARG,BRA,URUPAR)
                       MID_INC.(TUR,IND,PAK,CHN,MIDEAST,MER_OTH,RSA,MED,RUS,BEL,KAZ,UKR,FSU,WBA,VIET,THAI,MAL,INDO,ASOCE_REST)
                       LDCACP.(BGD,NGA,ETH,ZAF,AFR_LDC,AFR_REST,ASOCE_LDC,MSA_ACP)
                       LDC.(BGD,AFR_LDC,ASOCE_LDC,ETH)
                       ACP.(NGA,ZAF,AFR_REST,MSA_ACP)
                        /;

     set RW_ALLImporters(RW,RMALL) / EU.(HI_INC,MER,MID_INC,LDCACP)
                                  HI_INC.(EU,MER,MID_INC,LDCACP)
                                  MER.(HI_INC,EU,MID_INC,LDCACP)
                                  MID_INC.(HI_INC,EU,MER,LDCACP)
                                  LDCACP.(HI_INC,EU,MER,MID_INC)

                                NONEU_EU.(EU,AFRICA,ASIA,N_AM,MS_AM,ANZ)
                                NONEU.(NONEU_EU,AFRICA,ASIA,N_AM,MS_AM,ANZ)
                                AFRICA.(EU,NONEU_EU,ASIA,N_AM,MS_AM,ANZ)
                                ASIA.(EU,NONEU_EU,AFRICA,N_AM,MS_AM,ANZ)
                                N_AM.(EU,NONEU_EU,ASIA,MS_AM,ANZ)
                                MS_AM.(EU,NONEU_EU,ASIA,ANZ)
                              /;


*** LDC and ACP regions

    SET LDC(RM);
    LDC(RM) $ RW_TO_RM("LDC",RM) = YES;
    SET ACP(RM);
    ACP(RM) $ RW_TO_RM("ACP",RM) = YES;

 RW_TO_RM("NONEU",RM) $ (NOT (SAMEAS(RM,"EU015000") or SAMEAS(RM,"EU_EAST") or SAMEAS(RM,"BUR"))) = YES;
 RW_TO_RM("World",RM) = YES;

 set RMFTA(RMALL) "free trade areas --- one blocks regarding trade policies" /

$ifi %EU28% == ON          EU028000
$ifi not %EU28% == ON      EU027000
                           MER             "Mercosur"
                /;

 SET RMFTA_TO_RM(RMFTA,RM) "regional mapping between free trade areas and RM" /
$ifi %EU28% == ON        EU028000.(EU015000,EU_EAST,BUR)
$ifi not %EU28% == ON    EU027000.(EU015000,EU_EAST,BUR)
                         MER.(ARG,BRA,URUPAR)
 /;

 set merAggs(RM)  "RM market model regions within Mercosur" /ARG, BRA, URUPAR/;

 SET EUAGGS(RM) "RM market model regions within EU25 -- expost" /EU015000, EU_EAST /;
 Alias (EUAGGS,EUAGGS1);

 SET EU27AGGS(RM) "RM market model regions within EU27" /EU015000, EU_EAST, BUR/;
 ALIAS(EU27AGGS,EU27AGGS1);

 SET EU25AGGS(RM) /EU015000, EU_EAST/;
 ALIAS(EU25AGGS,EU25AGGS1);


   set RMTP(RMall) "market model regions or aggregates with unique trade policies (trade policy regions)";
   alias(rmtp,rmtp1);

   set RM_not_RMTP(RM) "market model regions aggregated to larger trade policy regions" /
*  ---  EU regions
       EU015000
       EU_EAST
       BUR
*  ---  Mercosur regions
       URUPAR
       BRA
       ARG
    /;
   alias(RM_not_RMTP,RM1_not_RMTP);

    set RMTP_not_RM(RMALL)  "trade policy regions aggregated from smaller market model regions" /
*  --- EU as one block
       EU
*  --- Mercosur as one block
       MER
/;
   alias(RMTP_not_RM,rmtpAgg,rmtpAgg1);

   set rmMod(RMall) "market model regions entering the model are trade policy regions or their components" /
       set.RM,
       set.RMTP_not_RM
/;
   alias(rmMod,rmMod1);

   RMTP(RM)    $ (not RM_not_RMTP(RM)) = yes;
   RMTP(RMALL) $ RMTP_not_RM(RMALL) = yes;

   SET RM_TO_RMTP(RMall,RMall) "regional mapping == market model regions (RM) to trade policy blocks (RMTP)" /
       (EU015000,EU_EAST,BUR).EU
       (URUPAR,BRA,ARG).MER
   /;

* --- market model regions that represent one unique policy block are mapped to itself
   RM_TO_RMTP(RM,RM) $ (not RM_not_RMTP(RM)) = yes;

   set rm1_to_rmtp(rmall,rmall);
   rm1_to_rmtp(rm,rmtp) = rm_to_rmtp(rm,rmtp) ;

   set rmtp_to_rm(rmall,rmall);
   rmtp_to_rm(rmtp,rm) $ rm_to_rmtp(rm,rmtp) = yes;

   set rmtp_to_rm1(rmall,rmall);
   rmtp_to_rm1(rmtp,rm) = rm_to_rmtp(rm,rmtp) ;

   set rms_to_rmtp(RMS,RMALL);
   rms_to_rmtp(rms,rmtp) $ sum(rm $ rms_to_rm(rms,rm), rm_to_rmtp(rm,rmtp)) = yes;

   set rw_to_rmtp(RW,RMALL);
   rw_to_rmtp(RW,RMTP) $ sum(RM $ rm_to_rmtp(RM,RMTP), rw_to_rm(RW,RM)) = yes;

* regions in the same policy blocks
   set same_pblock(rmall,rmall);
   same_pblock(rm,rm1) $ (sum(rmtp $ rm_to_rmtp(rm1,rmtp), rm_to_rmtp(rm,rmtp)) and (not sameas(rm,rm1))) = yes;

*display RMTP, RM_to_RMTP, rms_to_rmtp, rw_to_rmtp, same_pblock;

 SET REGS_OUT(RALL) 'Regions where data is temporarily removed from data parameter ';


*
*   ---   Sets related to the non-homothetic Armington demand system
*
set
           price_quant      "price or quantity"    /price, quantity/
           cal_points       "calibration points"   / observed, expected /
           rm_modArm(rm)    "importer countries with modified Armington second nest"
;
alias(cal_points,cal_points1);


* end of "$ifthen not setglobal dontLoadRegionalSets"
* Note: this is used in supply_model_thread to skip the definition of region sets
$endif.rsets


    SET QUOTAS(COLS) /QutA,QutB,QUTS/;
    SET SUGS(ROWS) /SUGBa,SUGBb,SUGBc,SUGB/;

    SET SugPos Positions describing regional sugar market /

        TrimPrice
        PricDiff

        AQuot
        BQuot

        AProd         Share of A sugar on total production
        BProd         Share of B sugar on total production
        CProd         Share of C sugar on total production

        APric
        BPric
        CPric
        CorFPric      "Correction factor to line up A B C prices with EAA value"

        Share         Production share
        QutR          Quota rents per ha
        Yild

        Lo
        Mid
        Hi

        ALevy
        BLevy

        APricM
        BPricM
        CPricM

    /;

    SET LoMidHi(SugPos) / Lo,Mid,Hi /;

*
    SET D_DUALS(ROWS)    / SET.D_DUALS_ROWS/;

    SET D_LEVL(D_DUALS)  / SET.D_DUALS_LEVL_ROWS/;

    SET D_FEED(D_DUALS)  / SET.D_DUALS_FEED_ROWS  /;

    SET D_REQM(D_FEED)   / SET.D_DUALS_REQM_ROWS  /;


    SET REQM_TO_D(REQMS,D_REQM)
               / ENNE.D_ENNE,CRPR.D_CRPR,DRMN.D_DRMN,DRMX.D_DRMX,LISI.D_LISI,
                 (FICO,FICT,FISM,FISF,FIDI,FILG).D_FIBR/;



*
  SET SOILBALPOS(COLS) "Positions and subcomponents of the soil balance"    /
                AVAILA      "Nitrogen applied according to availability assessment by the farmer "
                EXPPRD      "Nitrogen export with harvested material and crop residues or animal products"
                ATMOSD        "Atmospheric deposition"
                CRESID       "Crop residues"
                STRANR      "Straw left on or returned  STRANL to the field STRANM"
                PLANTR      "Plant residues left on the fiels (e.g. beet leaves) as given in the table RESID in fertpar.gms"
                STRANL      "Straw left on the field as e.g. stubbles and ploughed into the soil"
                STRANM      "Straw returned to the field e.g. with manure"
                BIOFIX        "Biological fixation"
                MINSAT      "Mineralisation from soil organic matter"
                NETMAN      "Supply from manure is excretion net of runoff and gaseous emissions"
                NETMAN2     "Manure application version 2"
                MINFER      "Mineral fertilizer applied including some parts lost in runoff or emissions"
                GASMIN      "Losses in gaseous emissons NH3 and N20 and NOX from mineral fertilizer"
                RUNMIN      "Losses in runoff from mineral fertilizer"
                SURSOI       "Surplus to soil"
                SURTOT       "Total surplus is nutrient input net of exports in products"
                LEACHI       "Leaching below rooting zone to groundwater or surface waters"
                DENITR      "Denitrification below rooting zone"
                ACCUMU      "Accumulation of surplus in soil organic matter"
                EXCRET      "Nitrogen in excretion of animals"
                GASMAN      "N in gaseous losses during manure management as NH3 and N2O and N2 and NOX"
                NH3MAN      "N in gaseous losses during manure management as NH3"
                NH3GRA      "Ammonia losses from manure on grazings"
                NH3HOU      "Ammonia losses from manure in housing"
                NH3STO      "Ammonia losses from manure in storage sytems"
                NH3APP      "Ammonia losses from manure during application"
                NH3MIN      "Ammonia losses from mineral fertiliser"
                NH3TOT      "Ammonia losses total"
                GASTOT      "Gaseous losses of N total"
                RUNTOT      "Runoff losses total"
                RUNMAN     "N in runoff from manure management"
*for testing:
                EXCR2       "total excretion version 2"
                NITF        "nitrogen purchases on NETF"
                 /;

  SET SOILBALPOS_R(ROWS) "Positions and subcomponents of the soil balance"    /
                AVAILA      "Nitrogen applied according to availability assessment by the farmer "
                EXPPRD      "Nitrogen export with harvested material and crop residues or animal products"
                ATMOSD        "Atmospheric deposition"
                CRESID       "Crop residues"
                BIOFIX        "Biological fixation"
                MINSAT      "Mineralisation from soil organic matter"
                NETMAN      "Supply from manure is excretion net of runoff and gaseous emissions"
                NETMAN2     "Manure application version 2"
                MINFER      "Mineral fertilizer applied including some parts lost in runoff or emissions"
                GASMIN      "Losses in gaseous emissons NH3 and N20 and NOX from mineral fertilizer"
                RUNMIN      "Losses in runoff from mineral fertilizer"
                SURSOI       "Surplus to soil"
                SURTOT       "Total surplus is nutrient input net of exports in products"
                LEACHI       "Leaching below rooting zone to groundwater or surface waters"
                DENITR      "Denitrification below rooting zone"
                ACCUMU      "Accumulation of surplus in soil organic matter"
                EXCRET      "Nitrogen in excretion of animals"
                GASMAN      "N in gaseous losses during manure management as NH3 and N2O and N2 and NOX"
                NH3MAN      "N in gaseous losses during manure management as NH3"
                NH3GRA      "Ammonia losses from manure on grazings"
                NH3HOU      "Ammonia losses from manure in housing"
                NH3STO      "Ammonia losses from manure in storage sytems"
                NH3APP      "Ammonia losses from manure during application"
                NH3MIN      "Ammonia losses from mineral fertiliser"
                NH3TOT      "Ammonia losses total"
                GASTOT      "Gaseous losses of N total"
                RUNTOT      "Runoff losses total"
                RUNMAN     "N in runoff from manure management"
*for testing:
                EXCR2       "total excretion version 2"
                NITF        "nitrogen purchases on NETF"
                 /;
*
     SETS
     COLS_OUT(COLS) 'Columns where data is temporarily removed from data parameter '
     COLS_STORE_DURING_MARKET(COLS,*) 'Columns where data are temporilry removed during market model solution'
     ROWS_STORE_DURING_MARKET(ROWS,*) 'Rows where data are temporilry removed during market model solution'
     SCEN_STORE_DURING_MARKET(*)    'Rows where data are temporilry removed during market model solution'
     ROWS_OUT(ROWS) 'Rows where data is temporarily removed from data parameter '
     YEARS_OUT(*)'Years where data is temporarily removed from data parameter '
     ;

option kill=SCEN_STORE_DURING_MARKET;


     SET META_ITEMS /
                       "Title of data set",
                       "Date of version",
                       "Abstract",
                       "Topic category"
                       "Key words",
                       "Temporal coverage",
                       "Language within the data set",
                       "Name of exchange format",
                       "Exchange format",
                       "Geographic coverage by name",
                       "Name of originator organisation",
                       "Name of owner organisation",
                       "Name of processor organisation",
                       "Description of process step"
                       BASEYEAR, SIMYEAR, MODEL_SWITCHES, WORKSTEP, KEY, SCENDES, USER, YEARS, DATETIME,"Member_States"
                        /;

     SET META_STEPS /
                      'ZPA1 domain'
                      'COSA domain'
                      'PRAG domain'
                      'Prepare national database'
                      'Finish national database'
                      'Build regional time series'
                      'Build regional database'
                      'FSS data'
                      'IFA data'
                      'FAO fertilizer use data'
                      'Standard gross Margins'
                      'REGIO database'
                      'FAPRI database and projection'
                      'ESIM base year and projection'
                      'Generate trend projection'
                      'Policy input'
                      'Policy input, bas'
                      'Baseline calibration'
                      'Run scenario'
                      /;
  ALIAS (META_STEPS,META_STEP1);


* SET SET_POL(LINES);




