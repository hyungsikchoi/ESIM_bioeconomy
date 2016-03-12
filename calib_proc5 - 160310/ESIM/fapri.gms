* EU Shifter

*tech_progr("cwheat",eu27) = tech_progr("cwheat",eu27)*1.5;
*tech_progr("pork",eu27) = 1;
*tech_progr("poultry",eu27) = 1;
*tech_progr("sheep",eu27) = -2.2;

tech_progr("pork",eu15) = 2.6;
tech_progr("pork",eu12) = -2.3;
*tech_progr("poultry",eu27) = 1.6;
tech_progr("poultry",eu15) = 5.9;
tech_progr("poultry",eu12) = -0.01;
tech_progr("sheep",eu27) = -1;



* Shifter for World Market
* Use Set shift!

tech_progr("barley",shift)  = 2.8 * tech_progr("barley",shift);
*hdem_shft("barley",shift)   = 2.5;

tech_progr("corn",shift)    = 7.2 * tech_progr("corn",shift);
tech_progr("cwheat",shift)  = 1.2 * tech_progr("cwheat",shift);
tech_progr("durum",shift)  = 1.1 * tech_progr("durum",shift);
tech_progr("manioc",shift)  = 2.4 * tech_progr("manioc",shift);
tech_progr("rye",shift)  = 3.1 * tech_progr("rye",shift);
tech_progr("othgra",shift)  = 2.3 * tech_progr("othgra",shift);

tech_progr("sugar",shift)  = 6.9 * tech_progr("sugar",shift);

*tech_progr("pork",shift)  = 3.4;
tech_progr("pork",shift)  = 3.0;
tech_progr("beef",shift)  = 0.8 ;
tech_progr("sheep",shift)  = 2.5;
*tech_progr("poultry",shift)  = 2.7;
tech_progr("poultry",shift)  = 2.5;
tech_progr("eggs",shift)  = 1.8 ;

hdem_shft("rice",shift)   = 1.15;

tech_progr("rapseed",shift)  = 4.2 * tech_progr("rapseed",shift);
tech_progr("sunseed",shift)  = 2.9 * tech_progr("sunseed",shift);
tech_progr("soybean",shift)  = -0.5 * tech_progr("soybean",shift);

hdem_shft("butter",shift) = 3.7;
hdem_shft("cream",shift)  = -2;
hdem_shft("conc_mlk",shift) = 3.2;
hdem_shft("whey",shift) = 4;
hdem_shft("smp",shift) = 2.5;
hdem_shft("wmp",shift) = 2.28;
hdem_shft("acid_mlk",shift) = 0.6;

hdem_shft("palmoil",shift)   = -1.2;

hdem_shft("soyoil",shift)   = -1.5;
hdem_shft("sunoil",shift)   = -5;


$ontext
tech_progr("pork",shift)  = 3.4;
tech_progr("beef",shift)  = 2.8 ;
tech_progr("sheep",shift)  = 0.25;
tech_progr("poultry",shift)  = 2.4;
tech_progr("eggs",shift)  = 1.6 ;


tech_progr("barley",shift)  = 2.4 * tech_progr("barley",shift);
tech_progr("corn",shift)    = 4.15 * tech_progr("corn",shift);
tech_progr("cwheat",shift)  = 1.1 * tech_progr("cwheat",shift);
tech_progr("durum",shift)  = 1.0 * tech_progr("durum",shift);
tech_progr("manioc",shift)  = 1.7 * tech_progr("manioc",shift);
tech_progr("rye",shift)  = 2.1 * tech_progr("rye",shift);
tech_progr("othgra",shift)  = 1.7 * tech_progr("othgra",shift);

*tech_progr("sugar",shift)  = 4.9 * tech_progr("sugar",shift);
tech_progr("sugar",shift)  = 8.5 * tech_progr("sugar",shift);

hdem_shft("rice",shift)   = 1.15;


tech_progr("rapseed",shift)  = 5.4 * tech_progr("rapseed",shift);
tech_progr("sunseed",shift)  = 3.99 * tech_progr("sunseed",shift);
tech_progr("soybean",shift)  = 1. * tech_progr("soybean",shift);

tech_progr("milk",shift)    = 1 * tech_progr("milk",shift);
*hdem_shft("soyoil",shift)   = 0.54;
hdem_shft("soyoil",shift)   = 0.18;
hdem_shft("sunoil",shift)   = 2.8;
*hdem_shft("rapoil",shift)   = 3.2;
hdem_shft("rapoil",shift)   = 4.2;
hdem_shft("palmoil",shift)   = 0.5;

*hdem_shft("acid_mlk",shift) = 0.6;
hdem_shft("butter",shift) = 2.5;
hdem_shft("conc_mlk",shift) = -3;
hdem_shft("cream",shift)  = -1;
hdem_shft("whey",shift) = 0.5;
*hdem_shft("cheese",shift) = -1;
hdem_shft("wmp",shift) = 2.5;
hdem_shft("smp",shift) = -4.5;

hdem_shft("sheep",shift) = 0.3;

*tech_progr("palmoil",shift)  = 1.5;


hdem_shft("sugar",EU27) = -0.3;
$offtext
















