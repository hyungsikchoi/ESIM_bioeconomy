Set
c        countries
/
AT
BE
DK
FI
FR
GE
GR
IE
IT
NL
PT
ES
SW
UK
LV
RO
SI
LT
BG
PL
HU
CZ
SK
EE
CY
MT
TU
HR
WB
US
ROW
/
e(c)     European countries
/
AT
BE
DK
FI
FR
GE
GR
IE
IT
NL
PT
ES
SW
UK
LV
RO
SI
LT
BG
PL
HU
CZ
SK
EE
CY
MT
*TU
*US
*ROW
/

i        products
/
CWHEAT
*DURUM
BARLEY
CORN
RYE
OTHGRA
PULS new
RICE
SUGAR
POTATO
*MANIOC
SOYBEAN
SUNSEED
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
SOYOIL
RAPOIL
SUNOIL
PALMOIL

WMP
CREAM
CONC_MLK
*ACID_MLK
WHEY
OTHER

OENERGY
OPROT

*BIODIESEL
*ETHANOL
/


Alias (i,j,ii);
;


parameters
hdem(i,c)        Human Demand mio tons
price(i,c)       Price in domestic currency per ton
allena(i,j)      Starting values for Allen Elasticities of Substitution
inc(c,i)         Starting values for Income Elasticities of Demand
own(c,i)         Starting values for Own Price Elasticities of Demand
value_shr(i,c)   Share of Product in total consumption expenditure
HH_EXP(c)        houshold expenditure
;
