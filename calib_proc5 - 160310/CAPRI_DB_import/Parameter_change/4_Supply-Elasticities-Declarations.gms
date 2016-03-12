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
TU
HR
WB
US
ROW
/
eu15(e)
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
/
eu12(e)
/
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
/
rest(e)
/
row
/
fi       all products & factors & column headings in the model
/
CWHEAT
DURUM
BARLEY
CORN
RYE
OTHGRA
PULS
RICE
SUGAR
POTATO
SOYBEAN
RAPSEED
SUNSEED
MANIOC
GLUTFD
MILK
BEEF
SHEEP
PORK
POULTRY
EGGS
GRAS
FODDER
SMAIZE
SETASIDE
OTHER    Other Crops- not in the model but important for homogeneity condition
LABOR
CAPITAL
FEED
INTERMED
LAND
ENERGY   new
FERTIL   new
OWN
YIELD
SOYMEAL
RAPMEAL
SUNMEAL
SMP
OENERGY
OPROT
PALMOIL
/
i(fi)        products - columns in area matrix
/
CWHEAT
DURUM
BARLEY
CORN
RYE
OTHGRA
PULS
RICE
SUGAR
POTATO
SOYBEAN
RAPSEED
SUNSEED
MANIOC
GLUTFD
MILK
BEEF
SHEEP
PORK
POULTRY
EGGS
GRAS
FODDER
SMAIZE
SETASIDE
PALMOIL
OTHER
LABOR
CAPITAL
FEED
INTERMED
LAND
ENERGY   new
FERTIL   new
/

yd(fi)   column headings in yield matrix
/
YIELD
LABOR
CAPITAL
INTERMED
ENERGY
FERTIL
/

farm(i)  farm products - rows in area matrix
/
CWHEAT
DURUM
BARLEY
CORN
RYE
OTHGRA
PULS   new
RICE
SUGAR
POTATO
SOYBEAN
RAPSEED
SUNSEED
*MANIOC
GLUTFD
MILK
BEEF
SHEEP
PORK
POULTRY
EGGS
GRAS
FODDER
SMAIZE
SETASIDE
OTHER
PALMOIL
/



crops(farm)
/
CWHEAT
DURUM
BARLEY
CORN
RYE
OTHGRA
PULS     new from capri
RICE
SUGAR
POTATO
SOYBEAN
RAPSEED
SUNSEED
*MANIOC
GRAS
FODDER
SMAIZE
SETASIDE
OTHER
/

livest(farm)
/
MILK
BEEF
SHEEP
PORK
POULTRY
EGGS
/

cer(crops)       cereals
/
CWHEAT
DURUM
BARLEY
CORN
RYE
OTHGRA
/

ric(crops)       rice
/
RICE
/

rop(crops)       root crops
/
SUGAR
POTATO
*MANIOC
PULS
/

ois(crops)       oilseeds
/
SOYBEAN
RAPSEED
SUNSEED
/

fed(crops)       roughage feed
/
GRAS
FODDER
SMAIZE
/

rum(livest)      ruminant products
/
MILK
BEEF
SHEEP
/

mon(livest)      monogastric livestock products
/
PORK
POULTRY
EGGS
/

policy
/
premium
/

f(fi)        feed products
/
CWHEAT
BARLEY
CORN
RYE
OTHGRA
SOYMEAL
RAPMEAL
SUNMEAL
SOYBEAN
SUNSEED
POTATO
MILK
MANIOC
GLUTFD
OENERGY
OPROT
SMAIZE
FODDER
GRAS
SMP
/



Alias (i,j,jj),(farm,farm1), (crops,crops1), (livest,livest1), (cer,cer1), (ric,ric1),
               (rop,rop1), (ois,ois1), (fed, fed1), (rum,rum1), (mon,mon1)
;

Parameters
area(c,farm)             area allocation for crops (needed to calculate value share impact of DP)
sigma(farm,j)            old allen elasticities of area allocation
epsilon(c,farm,j)        old price elasticities of area allocation
val_shr(c,farm)          value share
supply(c,farm)           production
price(c,fi)              price
dirpay(farm,c)           direct payment
margin(farm,c)           wholesale margin
yield(c,farm)            yield
forage_price(c,j)        used for import of roughage feed
f_dem(c,j)               feed demand used for roughage feed and OE and OP

*starting values filled at read-in
own_area(e,farm)
el_area0(c,farm,j)       area elasticities

cost_share_crops(c,crops,j)      cost shares of inputs and factors of production
cost_share_livest(c,livest,j)     cost shares of inputs and factors of production

*******HG***2015.10.31
**replace by reading from price and policy file
**********************************************

areapay(e)
/
BE        402.2709621
BG        51
CZ        95
DK        347
GE        335
EE        40
IE        275
GR        372
ES        231
FR        247
IT        388
CY        103
LV        34
LT        52
HU        95
MT        214
NL        367
AT        216
PL        74
PT        148
RO        48
SI        114
SK        70
FI        226
SW        205
UK        241
/

*******HG***2015.10.31
**replace by reading from price and policy file
**********************************************

exrate(e)
/
BG        0.6690506697
CY        2.2568636433
CZ        0.0467823058
EE        0.0838404957
HU        0.0050998469
LV        1.8619525307
LT        0.3789767415
MT        2.9611388594
PL        0.3419231516
RO        0.3837606049
SK        0.0369506275
SI        1.3117018644
TU        0.7342983611
US        1.0000000000
ROW       1.0000000000
DK        0.1759975182
UK        1.9206635899
SW        0.1418018827
AT        1.3120593713
BE        1.3120593713
FI        1.3120593713
FR        1.3120593713
GE        1.3120593713
GR        1.3120593713
IE        1.3120593713
IT        1.3120593713
NL        1.3120593713
PT        1.3120593713
ES        1.3120593713
HR        1.3120593713
WB        1.0000000000
/
elastyd(c,crops,crops) elasticity of yield with respect to own price
;
