********************************************************************************
$ontext

   CAPRI project

   GAMS file : ARM_SETS.GMS

   @purpose  : Defines the sets used in the context of the global
               market model.

   @module   : market_model
   @author   : W. Britz
   @date     : 15.01.10
   @since    : 2007
   @refDoc   :
   @seeAlso  : arm\market_model.gms
   @calledBy : capmod.gms

$offtext
********************************************************************************


 SET CERE_DEF "Cereals" /
           WHEA "Wheat"
           BARL "Barley"
           MAIZ "Maize"
           RYEM "Rye"
           OATS "Oats"
           OCER "other cereals"
           RICE "Rice"
 /;

 SET SED_DEF   "Oilseeds" /
           SOYA  "Soybean"
           SUNF  "Sunflower"
           RAPE  "Rapeseed"
 /;

 SET OIL_DEF   "Oils derived from oilseeds" /
           SOYO  Soya oil
           SUNO  Sunflower oil
           RAPO  Rape oil
 /;

 SET CAK_DEF   "Cakes derived from oilseeds" /
           SOYC  Soya cake
           SUNC  Sunflower seed cake
           RAPC  Rape seed cake
 /;

 SET MEAT_DEF   "Meats in market model"
          /
           BEEF  "Beef"
           PORK  "Pork meat"
           SGMT  "Sheep and goat meat"
           POUM  "Poultry"
 /;




 SET DAIRY_DEF   "Dairy products in market model exluding raw milk"
          /
           FRMI  "Fresh milk products"
           CHES  "Cheese"
           BUTT  "Butter"
           CREM  "Cream"
           SMIP  "Skimmed milk powder"
           COCM  "Concentraded milk"
           WMIO  "Whole milk powder"
           WHEP  "Whey poweder"
           CASE  "Casein"
 /;

 SET CROPS_DEF   "Crop products in market model"
          /
           SET.CERE_DEF,

           POTA "Potatoes"
           SUGA "Sugar"
           PULS "Pulses",

           SET.SED_DEF,

           TOBA "Tobacco"
           TEXT "Textiles"
           OLIO "Olive oil"
           PLMO "Palm oil"
           OTHO "Other vegetable oil"

*          STAR  "Starch from potatoes"
*          MOLA  "Molasse as by-product from sugar"


           APPL "Apples pears peaches"
           CITR "Citrus"
           TAGR "Table grapes"
           OFRU "Other fruits"
           TOMA "Tomatoes"
           TABO "Table olives"
           OVEG "Other vegetables"
           TWIN "Table wine"


           COFF "Coffee, dry equivalent"
           TEAS "Tea, dry equivalent"
           COCO "Cocoa beans, dry equivalent"

           FFIS  "Freshwater fish"
           SFIS  "Saltwater fish"
           OAQU  "Other acquatic product"

           DDGS "destilled dried grains from bio-ethanol production"
           FPRI "Protein rich feed (by-products of milling and brewing industry)"
           FENI "Energy rich feed (by-products of sugar-beet processing), manioc, cassava, yams, other root and tubers etc."
 /;

 SET XX1_ADD_DEF "Inpe (all non agricultural goods) and ince (income)" /

           INPE  "All non agricultural goods"
           INCE  "Income elasticities"
           LAND  "Land"
           FEDE  "Feed energy - output of the feed industry"
           YILD  "Yield response"
 /;

 SET XX_DEF   "The product list of the market model"
          /
           SET.CROPS_DEF,
           MILK  "Raw milk at dairy",
           SET.MEAT_DEF,
           EGGS  "Eggs",
           SET.OIL_DEF,
           SET.CAK_DEF,
           SET.Seco_bioF,
           SET.DAIRY_DEF
  /;


 SET SET_trimReqs "Animal requirements used in elasticity calibration" / ENNE,CRPR /;

 SET XX_ALL(ROWS)   "Product list of the market model including the non agricultural good and income"
          /

           SET.XX_DEF,
           SET.XX1_ADD_DEF,
           SET.SET_TrimReqs
         /;

 SET trimReqs(ROWS) "Animal requirements used in elasticity calibration" / set.SET_trimReqs /;

 SET XX1(XX_ALL)   "Product list of the market model including the non agricultural good and income"
          /

           SET.XX_DEF,
           SET.XX1_ADD_DEF

         /;
 ALIAS(XX1,YY1,ZZ1);

 SET XX(XX1)  "The product list of the market model"
          /
           SET.XX_DEF
  /;

 Alias (rows,rowsxx,rowsxx1);


 SET XX_ANIM(XX1)   "Animal products" /
           SET.MEAT_DEF,
           EGGS  "Eggs",
           SET.DAIRY_DEF
           MILK
  /;

 ALIAS(XX_ANIM,XX_ANIM1);

 SET XX_ANIM_FEED(XX1)   "Animal products produced by primary agriculture" /
           SET.MEAT_DEF,
           EGGS  "Eggs",
           MILK
  /;

 ALIAS(XX_ANIM,XX_ANIM1);

 SET XX_CROPS(XX) / set.crops_def /;
*

 SET solvePosi "ordering set for ranking in fitit1 and fitit6" /XX1*XX100/;

 SET fititOrder(solvePosi,XX1) /
       XX1 .   WHEA     "Wheat"
       XX2 .   BARL     "Barley"
       XX3 .   RYEM     "Rye"
       XX4 .   MAIZ     "Maize"
       XX5 .   OATS     "Oats"
       XX6 .   OCER     "other cereals"
       XX7 .   RICE     "Rice"
       XX8 .   SUNF     "Sunflower"
       XX9 .   RAPE     "Rapeseed"
       XX10.   OTHO     "Other vegeatable oils"
       XX11.   PLMO     "Palm oil"
       XX12.   SOYA     "Soybean"
       XX13.   SUGA     "Sugar"
       XX14.   TWIN     "Table wine"
       XX15.   BIOE     "Bioethanol"
       XX16.   BIOD     "Biodiesel"
       XX17.   DDGS     "destilled dried grains from bio-ethanol production"
       XX18.   POTA     "Potatoes"
       XX19.   PULS     "Pulses"
       XX20.   APPL     "Apples pears peaches"
       XX21.   CITR     "Citrus"
       XX22.   OFRU     "Other fruits"
       XX23.   OLIO     "Olive oil"
       XX24.   OVEG     "Other vegetables"
       XX25.   TAGR     "Table grapes"
       XX26.   TOBA     "Tobacco"
       XX27.   TOMA     "Tomatoes"
       XX28.   TEXT     "Textiles"
       XX29.   TABO     "Table olives"
       XX30.   BEEF     "Beef"
       XX31.   PORK     "Pork meat"
       XX32.   POUM     "Poultry"
       XX33.   SGMT     "Sheep and goat meat"
       XX34.   EGGS     "Eggs"
       XX35.   FENI     "Energy rich feed (by-products of sugar-beet processing), manioc, cassava etc."
       XX36.   FPRI     "Protein rich feed (by-products of milling and brewing industry)"
       XX37.   FRMI     "Fresh milk products"
       XX38.   COFF
       XX39.   COCO
       XX40.   TEAS
       XX41.   FFIS  "Freshwater fish"
       XX42.   SFIS  "Saltwater fish"
       XX43.   OAQU  "Other acquatic product"
       /;

 SET XCERE(XX) "Cereals in market model" / SET.CERE_DEF/;
 ALIAS (XCERE,XCERE1,XCERE2);

 SET SED(XX) "Oilseeds"  / SET.SED_DEF/;
 SET OIL_CAPRI(XX)   / SET.OIL_DEF /;
 SET XOIL(XX)  / SET.OIL_DEF
                   PLMO/;
 SET CAK(XX)  / SET.CAK_DEF /;

 SET XMEAT(XX)  / SET.MEAT_DEF /;
 ALIAS (XMEAT,XMEAT1);

 ALIAS(XX,YY,ZZ);
*
  SET FEED_TO_XX(FEED_TRD,XX);
  FEED_TO_XX(FEED_TRD,XX) = FEED_TO_O(FEED_TRD,XX);
  FEED_TO_XX("FCER","WHEA") = YES;
*

 SET XXGRPS(*);


 SET XXGRP "Pre-solve groups for the market model"
           /
             XCER1 "Major cereals"
             XCER2 "Minor cereals"
             XOILS "Oilseeds, cakes and oils"
             XRES1 "Potatoes, protein crops, tobacco"
             XRES2 "Sugar, table wine, pulses"
             XVEGE "Vegetables"
             XFRUI "Fruits"
             XBYPR "By products"
             XTROP "Cocoa, coffee, teas"
             XCROP "Fruits, vegetables, potatoes, protein crops"
             XFULL "Cereals, sugar, wine and By products"
             XFPRO "Oilseeds, oils and some other products in FPRO"
             XMEAT "Meats"
             XFISH "Acquatic products"
             XMILK "Dairy"
             XANIM "All animal and acquatic products"
             XFEDE "Feed energy"
             XLAND "Feed energy"
          /;
 ALIAS (XXGRPS,XXGRP1);

 SET XXGRP_XX(*,XX1) "Allocation of single products to pre-solve groups"

     /
       XCER1.(WHEA,BARL,MAIZ,RICE)
       XCER2.(RYEM,OATS,OCER)
       XFRUI.(APPL,CITR,TAGR,OFRU)
       XVEGE.(TOMA,TABO,OVEG,OLIO,OTHO,PLMO)
       XOILS.(SOYA,SUNF,RAPE,SOYO,SUNO,RAPO,SOYC,SUNC,RAPC)
       XRES1.(POTA,TOBA,TEXT)
       XRES2.(SUGA,TWIN,PULS)
       XBYPR.(FPRI,DDGS,FENI)
       XTROP.(COCO,COFF,TEAS)

       XCROP.(POTA,TOBA,TEXT,APPL,CITR,TAGR,OFRU,TOMA,TABO,OVEG,OLIO,OTHO)
       XFULL.(WHEA,BARL,RYEM,OATS,MAIZ,OCER,RICE,SUGA,TWIN,FENI,COCO,COFF,TEAS,BIOE,DDGS)
       XFPRO.(SOYA,SUNF,RAPE,SOYO,SUNO,RAPO,SOYC,SUNC,RAPC,PLMO,PULS,FPRI,DDGS,BIOD)

       XMILK.(SET.DAIRY_DEF,MILK)
       XMEAT.(BEEF,PORK,POUM,SGMT,EGGS)
       XFISH.(FFIS,SFIS,OAQU)

       XANIM.(BEEF,PORK,POUM,SGMT,EGGS,SET.DAIRY_DEF,MILK,FFIS,SFIS,OAQU)

       XFEDE.(FEDE)
       XLAND.(LAND)
     /;

  XXGRP_XX(XX,XX) = YES;

  SET XXBiof(XX1) /set.seco_biof/;


 Set fuelMatch(XXBioF,Fuel_Rows) "mapping of biefuels to fossil subsitute"
      /BIOE.GASL, BIOD.DISL/;

 Set demType "type of biofuel demmand" / add "additive", bld "blending", FFV "Flexibel fuels Vehicles"/;
 SET XBioStock(XX) "biofuel feedstocks" /
           WHEA,BARL,RYEM,OATS,MAIZ,OCER,SUGA,TWIN
           SOYO,SUNO,RAPO,PLMO /;

 ALIAS(XBioStock,YBioStock);
 SET MLK_CAPRI(XX) "Raw milk and derived products" /
           MILK  Raw milk
           SET.DAIRY_DEF
 /;

 ALIAS(MLK_CAPRI,MLK1,MLK2);
 ALIAS(SED,SED1);
 ALIAS(OIL_CAPRI,OIL1);
 ALIAS(CAK,CAK1,CAK2);

 SET XXX(XX)   "The agr. product currently included in the model"
 SET XXX1(XX1) "The products currently included in the model";

 ALIAS(XXX,YYY);
 ALIAS(XXX1,YYY1);

 SET XXXX(XX);

$IF %MARKET_M%==ON SET FATSPROT_R(ROWS) / FATS,PROT /;

 SET SED_TO_OIL(XX,XX) / SOYA.SOYO, SUNF.SUNO, RAPE.RAPO /;
 SET SED_TO_CAK(XX,XX) / SOYA.SOYC, SUNF.SUNC, RAPE.RAPC /;
 SET OIL_TO_CAK(XX,XX) / SOYO.SOYC, SUNO.SUNC, RAPO.RAPC /;


 XXGRP_XX(XX,YY) $ SED_TO_OIL(XX,YY) = YES;
 XXGRP_XX(XX,YY) $ SED_TO_CAK(XX,YY) = YES;

*
 SET CAP_TO_TRD(ROWS,*) "Connection CAPRI data base outputs to market model products" /
*
           (SWHE,DWHE).WHEA
           BARL.BARL
           MAIZ.MAIZ
           RYEM.RYEM
           OATS.OATS
           OCER.OCER
           RICE.RICE
           POTA.POTA
           SUGA.SUGA
           PULS.PULS
           SOYA.SOYA
           SUNF.SUNF
           RAPE.RAPE
           TOBA.TOBA
           TEXT.TEXT
           OLIO.OLIO
           APPL.APPL
           CITR.CITR
           TAGR.TAGR
           OFRU.OFRU
           TOMA.TOMA
           TABO.TABO
           OVEG.OVEG
           TWIN.TWIN
*          SEDO.SEDO
*          CRPO.CRPO
           SOYO.SOYO
           SUNO.SUNO
           RAPO.RAPO
           PLMO.PLMO
*          OSDO.OSDO
           SOYC.SOYC
           SUNC.SUNC
           RAPC.RAPC
*          CSDO.CSDO
           BEEF.BEEF
           PORK.PORK
           SGMT.SGMT
           POUM.POUM
           EGGS.EGGS
           MILK.MILK
           FRMI.FRMI
           CHES.CHES
           BUTT.BUTT
           CREM.CREM
           SMIP.SMIP
           WMIO.WMIO
           WHEP.WHEP
           CASE.CASE
           COCM.COCM
*          STAR.STAR
*          MOLA.MOLA
           DDGS.DDGS
           BIOE.BIOE
           BIOD.BIOD
           FPRI.FPRI
           FENI.FENI
           COCO.COCO
           COFF.COFF
           TEAS.TEAS
           SFIS.SFIS
           FFIS.FFIS
           OAQU.OAQU
      /;
*
 SET MARR(ROWS) "Rows linked to products in market model";
 ALIAS(MARR,MARR1);

 MARR(ROWS) $ SUM( CAP_TO_TRD(ROWS,XX), 1.) = YES;

 SET ADD_FEED(ROWS) "Feedingstuff not covered by market model";

 ADD_FEED(ROWS) $ (SUM(FEED_TO_O(FEED_TRD,ROWS),1) and (NOT MARR(ROWS))) = YES;

 ADD_FEED("RICE") = NO;
 ADD_FEED("OLIO") = NO;
 ADD_FEED("SUGA") = NO;

 SET XX_SUPPLY(XX) "Products in market model linked to products from supply model";
 XX_SUPPLY(XX) $ SUM( (PACT_TO_O(MPACT,O),CAP_TO_TRD(O,XX)),1) = YES


 SET OMS_XX(ROWS) "Products in supply model linked to products in market model";
 OMS_XX(OMS) $ SUM( CAP_TO_TRD(OMS,XX),1) = YES;
 OMS_XX("OLIV") = YES;
 OMS_XX("SUGB") = YES;
 OMS_XX("PARI") = YES;
 OMS_XX("COMI") = YES;
 OMS_XX("SGMI") = YES;

 SET IO_P_MRK(ROWS) "Rows whose prices are defined by market model";
*
*     --- outputs linked to products from market part
*
 IO_P_MRK(MARR)     = YES;
 IO_P_MRK("COMI")   = YES;
 IO_P_MRK("SGMI")   = YES;
 IO_P_MRK("PARI")   = YES;
 IO_P_MRK("SUGB")   = YES;
 IO_P_MRK("OLIV")   = YES;
 IO_P_MRK("ICHI")   = YES;
 IO_P_MRK("YCHI")   = YES;
*
*     --- bulk feed, linked to products from market part
*
 IO_P_MRK(FEED_TRD) = YES;
*
 SET MARRC(ROWS) "Rows which are not identical between supply and market part";

 MARRC(MARR) = YES;
 MARRC(ROWS)  $ (SUM(SAMEAS(ROWS,XX) ,1) eq 1)     = NO;
 MARRC(ROWS)  $ (not SUM(CAP_TO_TRD(MARRC,XX) ,1)) = NO;
*
 ALIAS(MARRC,MARRC1);

 SET XXC(XX)    "Rows of market part mapped to not identical rows";
 XXC(XX) $ SUM(CAP_TO_TRD(MARRC,XX),1) = YES;

$iftheni %market_m% == on
*
 SET TRQSet(COLS) "Positions stored on TRQ parameters"
  /
      TAPREF
      TAMFN
      TAAPPL
      TSPREF
      TSMFN
      TSAPPL
      TRQNT
      TRQNT_notified
      Imports
      ImportsR
      Exporter
      adval_equ
      adVal_equn
      Rent
      Rent_per_unit
      RED
      RED_Tarv
      PrefTrigPrice
      EntryPrice
  /;
 ALIAS (TrqSet,TrqSet1);

 SET TRQSet_Agg(TRQSET) "Positions of TRQSET calculate for quantity aggregates"
 /
      TAMFN
      TAAPPL
      TSMFN
      TSAPPL
      TRQNT
      Imports
      ImportsR
      Rent
      Rent_per_unit
  /;

 ALIAS (TrqSet_Agg,TrqSet_Agg1);

 Set TRQSet_nonAdd(TRQSET) "those positions in TRQSET that should not sum up by regional aggregations "
  /
      TAPREF
      TAMFN
      TAAPPL
      TSPREF
      TSMFN
      TSAPPL
      adval_equ
      adVal_equn
      RED
      RED_Tarv
      PrefTrigPrice
      EntryPrice
   /;



 ALIAS (TrqSet_nonAdd,TrqSet_nonAdd1);

$endif

 SET IOE(ROWS) "Set of prices for which price expectations work";
*
 IOE(OMYANI)  = YES;
 IOE(I_CAPRI) $ SUM(SAMEAS(I_CAPRI,IYANI),1) = YES;
 IOE(MARR)   = YES;
 IOE("PARI") = YES;
 IOE("OLIV") = YES;
 IOE("COMI") = YES;
 IOE("SGMI") = YES;
 IOE("SUGB") = YES;
 IOE(I_CAPRI) $ SUM(SAMEAS(I_CAPRI,FEED_CAPRI),1)  = YES;
 IOE("FENE") = YES;

 SET RESIMPX(XX) "Residual feed products (FPRI,FENI)" / FPRI, FENI /;


 SET BAS_AND_Y / BAS, Y /;

$IF NOT %MARKET_M%==ON SET M_ITEMS(*)    "Model items only found in market model"
$IF %MARKET_M%==ON     SET M_ITEMS(COLS) "Model items only found in market model"
                  /
                    PROD        "Production"
                    DSALES      "Domestic sales"
                    INTP        "intervention purchases to stocks"
                    EXPSVAL     "Value of subsidised exports"
                    EXPORTS     "Exports physical"
                    QUTE        "WTO quantity limit on subsidized exports"
                    PMRK        "OECD market price"
                    PPRI        "Producer price"
                    PADM        "Adminsitrative price limit"
                    EXPSUB      "Per unit export subsidy"
                    IMPORTS     "Imports physical"
                    DEMAND      "Demand"
                    HCON        "Human consumption"
                    FEED        "Feed use"
                    PROC        "Processing and other uses"
                    BIOF        "Processing and other uses"
                    CPRI        "Consumer price"
                    CMRG        "Consumer price margin"

                    ARM1P       "First stage Armington price index"
                    ARM2P       "Second stage Armington price index"
                    ARM1        "First stage Armington quantity aggregate"
                    ARM2        "Second stage Armington quantity aggregate"
                    PSED        "Direct Producer Subsidy Equivalent"
                    PSEI        "Indirect Producer Subsidy Equivalent"
                    CSED        "Direct Consumer Subsidy Equivalent"
                    CSEI        "Indirect Consumer Subsidy Equivalent"
                    TARS        "Most Favorite Nation specific tariff"
                    AREP        "Area payment"
                    YIELD       "Yield coefficient"
                    LEVL        "Activity level"

                    PMrkMrg
                  /;


$IF %MARKET_M%==ON      SET SITEMS(COLS) "Items to shift with trend"
$IF NOT %MARKET_M%==ON  SET SITEMS(*) "Items to shift with trend"
   / PROD,HCON,PROC,BIOF,FEED,YILD,ARM1,ARM2,DSALES,IMPORTS,TRQIMPORTS,EXPORTS,INTS,INTD,INTD1,INTP,INTP1,ISCH,PMrg,CMrg
     PMRK,PPRI,CPRI,ARM1P,ARM2P,ARM2V,EXPSUB,EXPSVAL,ExportsUVAE,UVAE,EXPS,PROCMARG,PMrkMrg,STKS,PRCY,C_TOST,C_TOST1,C_TOST2 /;

$IF %MARKET_M%==ON SET ScenItems(COLS) "Items which can be trend shifted via scendefinition" / set.scenshiftedCols /;

$IF %MARKET_M%==ON SET TrdITEMS(COLS) "Items to store trend values for welfare analysis"
$IF %MARKET_M%==ON   / PROD,HCON,PROC,FEED,PPRi,CPRI,Arm1P,PROCMARG /;

 SET INT(COLS) "Items relating to internvention sales" / INTP,INTD,ISCH,INTS,INTM /;

 SET M_ITEMS_A(M_ITEMS) / Prod,HCon,Feed,Proc,BioF /;

 ALIAS(XX1,YY1,ZZ1);


 SET COPYP(COLS) / UVAI,UVAE /;
*

 SET HCOM(COLS) / HCOM,LOSM /;

 SET EXCLUDE (*,*) 'Item combinations not to be removed from data parameter';

 SET PreStep "Maximal # of presteps in market model" /PP1*PP15/;

 SET BIOF_NUM(RMS,XXBioF,XX) "Numeraire feedstock for CES share equation for biofuel processing demand";

