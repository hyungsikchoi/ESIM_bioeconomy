$inlinecom {  }
sets  c     countries
/
AT
BE
BG
CY
CZ
DK
EE
ES
FI
FR
GE
GR
HU
IE
IT
LV
LT
MT
NL
PL
PT
RO
SK
SI
SW
TU
UK
HR
WB
US
ROW
/
e(c)     European countries +WB
/
AT
BE
BG
CY
CZ
DK
EE
ES
FI
FR
GE
GR
HU
IE
IT
LV
LT
MT
NL
PL
PT
RO
SK
SI
SW
TU
UK
HR
WB
/
p        products
/
BARLEY
BEEF
BUTTER
GLUTFD
CHEESE
CMILK
CORN
CWHEAT
DURUM
EGGS
MANIOC
MILK
OENERGY
**New from CAPRI
FENE    OENERGY_CAPRI
OPROT
OTHGRA
OTHDAIRY
PORK
POTATO
POULTRY
RAPMEAL
RAPOIL
RAPSEED
RICE
RYE
SHEEP
SMP
SOYBEAN
SOYMEAL
SOYOIL
SUGAR
SUNMEAL
SUNOIL
SUNSEED
GRAS
FODDER
SMAIZE
PALMOIL
STRA
*OTHERS

WHEY
WMP
PULS
CONC_MLK
/

l(p)     livestock products
/
BEEF
EGGS
MILK
PORK
POULTRY
SHEEP
/

f(p)     feed products
/
BARLEY
GLUTFD
CORN
CWHEAT
MANIOC
MILK
OENERGY
OPROT
OTHGRA
POTATO
RAPMEAL
RYE
SMP
SOYBEAN
SOYMEAL
SUNMEAL
SUNSEED

GRAS
FODDER
SMAIZE

***New feed from CAPRI
STRA
PULS
FENE      OENERGY_CAPRI

            DURUM
            RICE
            SUGAR
*            OTHERS
            Whey
            OTHDAIRY
            RAPOIL
            SUNOIL
            SOYOIL
            WMP
            RAPSEED
            CONC_MLK

/

en(f)     energy feeds
/
BARLEY
CORN
CWHEAT
MANIOC
OENERGY
OTHGRA
POTATO
RYE
**CAPRI
DURUM
RICE
SUGAR
FENE
/

pr(f)     protein feeds
/
GLUTFD
OPROT
RAPMEAL
SMP
SOYBEAN
SOYMEAL
SUNMEAL
SUNSEED
**CAPRI
Whey
OTHDAIRY
RAPOIL
SUNOIL
SOYOIL
RAPSEED
WMP
CONC_MLK
PULS
/

ro(f)     roughages
/
GRAS
FODDER
SMAIZE
**CAPRI
STRA
FENE
/
gra(f)   grains
/
CWHEAT
BARLEY
CORN
RYE
OTHGRA
/

coa(gra) coarse grains
/
BARLEY
RYE
OTHGRA
/

nco(gra) non coarse grains
/
CWHEAT
CORN
/

mea(f)   oilseed meals
/
RAPMEAL
SOYMEAL
SUNMEAL
/

rou(f)   roughage feeds
/
GRAS
FODDER
SMAIZE
**CAPRI
STRA
FENE
/

ois(f)   oilseeds
/
SOYBEAN
SUNSEED
/

mpo(f)   imported feeds
/
MANIOC
GLUTFD
/

rum(l)   ruminants' products
/
MILK
BEEF
SHEEP
/

she(l)
/
SHEEP
/

pig(l)   pig meat
/
PORK
/

bir(l)   birds' products
/
POULTRY
EGGS
/

mil(l)
/
MILK
/


cal(f)   feed not used for both milk and beef
/
MILK
POTATO
/
sma(rou)
/
SMAIZE
/

exo(f) feeds which proportion is not fix
/
OENERGY
*OPROT
/

pot(f)
/
POTATO
/
co(f)
;
co(f)$(not rou(f)) = yes ;
alias(f,ff),(l,ll),(rou,rou1),(gra,gra1),(nco,nco1),(coa,coa1),(mea,mea1),(en,ee),(pr,pp),(ro,rr),(co,coco)
;
