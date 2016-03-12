set
cr
/
CWHEAT
DURUM
BARLEY
CORN
RYE
OTHGRA
PULS new
RICE
SUGAR
POTATO
SOYBEAN
RAPSEED
SUNSEED
SMAIZE
FODDER
GRAS
SETASIDE
/
l        livestock products
/
MILK
BEEF
SHEEP
PORK
POULTRY
EGGS
/
c        countries
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

e(c)     EU countries
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
UK
/
i        inputs
/
FEED
FERTIL
ENERGY
INTERMED
LABOR
CAPITAL
LAND
/
;
alias (cr,ccrr),(c,cc),(l,ll),(i,ii),(e,ee);
table default_cr(cr,i)   From the Bavarian Ministry of Agriculture: See XLS file 'Cost.xls' for details
              FERTIL        ENERGY        INTERMED      CAPITAL       LABOR         LAND
CWHEAT        0.0550        0.0467        0.5723        0.1367        0.0755        0.1137
DURUM         0.1242        0.0473        0.5038        0.1307        0.0758        0.1182
BARLEY        0.0738        0.0493        0.5246        0.1478        0.0791        0.1254
CORN          0.0920        0.0336        0.6324        0.1075        0.0531        0.0813
RYE           0.0412        0.0528        0.5414        0.1460        0.0845        0.1340
OTHGRA        0.1561        0.0460        0.4480        0.1436        0.0833        0.1230
RICE          0.1615        0.0462        0.4769        0.1427        0.0773        0.0954
SUGAR         0.1222        0.0363        0.5758        0.1335        0.0553        0.0769
POTATO        0.1234        0.0562        0.4606        0.2034        0.1185        0.0380
SOYBEAN       0.0854        0.0463        0.5461        0.1186        0.0734        0.1302
PULS          0.0854        0.0463        0.5461        0.1186        0.0734        0.1302
*new item HS
RAPSEED       0.0370        0.0494        0.6021        0.1281        0.0709        0.1125
SUNSEED       0.2126        0.0442        0.4355        0.1212        0.0689        0.1176
SMAIZE        0.3184        0.0496        0.3912        0.1234        0.0423        0.0750
FODDER        0.3542        0.0416        0.3345        0.1255        0.0622        0.0821
GRAS          0.3974        0.0319        0.2659        0.1280        0.0862        0.0906
SETASIDE      0.0000        0.0742        0.3043        0.1929        0.1171        0.3115
;

table default_l(l,i)     From the Bavarian Ministry of Agriculture: See XLS file 'Cost.xls' for details
               FEED        ENERGY        INTERMED     LABOR        CAPITAL
MILK           0.361        0.022        0.263        0.243        0.112
BEEF           0.363        0.024        0.326        0.174        0.113
SHEEP          0.363        0.024        0.326        0.174        0.113
PORK           0.380        0.030        0.402        0.106        0.082
POULTRY        0.380        0.030        0.402        0.106        0.082
EGGS           0.380        0.030        0.402        0.106        0.082
;

table CW(e,i)    FADN based cost shares for CWHEAT: See XLS files 'Cereals.xls' and 'Cost.xls' for details
          FERTIL        ENERGY        INTERMED      CAPITAL       LABOR         LAND
BG        0.1449        0.1783        0.3016        0.1523        0.1287        0.0942
CY        0.1983        0.1302        0.3671        0.0790        0.1322        0.0932
CZ        0.1258        0.1229        0.4516        0.0660        0.1382        0.0955
DK        0.0787        0.0479        0.3688        0.2253        0.1400        0.1393
GE        0.1611        0.0935        0.4085        0.1100        0.1211        0.1058
GR        0.1281        0.0928        0.2468        0.2432        0.1386        0.1504
ES        0.1252        0.0868        0.2962        0.1354        0.2726        0.0838
EE        0.2213        0.1370        0.3495        0.0806        0.0987        0.1129
FR        0.1557        0.0605        0.4260        0.0929        0.1254        0.1396
HU        0.1378        0.1517        0.3863        0.1114        0.1107        0.1020
IE        0.1370        0.0769        0.4052        0.1447        0.1467        0.0895
IT        0.0734        0.0677        0.2534        0.1363        0.3849        0.0843
LT        0.2784        0.1279        0.3106        0.1128        0.0889        0.0813
LV        0.2350        0.1473        0.3470        0.0719        0.0909        0.1080
PL        0.2063        0.1206        0.3460        0.1113        0.1470        0.0688
PT        0.1370        0.0769        0.4052        0.1447        0.1467        0.0895
RO        0.1192        0.1242        0.3947        0.0606        0.2101        0.0912
FI        0.1101        0.1088        0.3774        0.1138        0.1241        0.1657
SW        0.1662        0.1222        0.3537        0.0870        0.1401        0.1309
SK        0.1561        0.1091        0.4487        0.0548        0.1488        0.0824
UK        0.1214        0.0829        0.4474        0.1074        0.1479        0.0930
AT        0.1370        0.0769        0.4052        0.1447        0.1467        0.0895
BE        0.1370        0.0769        0.4052        0.1447        0.1467        0.0895
NL        0.1370        0.0769        0.4052        0.1447        0.1467        0.0895
MT        0.1983        0.1302        0.3671        0.0790        0.1322        0.0932
SI        0.1983        0.1302        0.3671        0.0790        0.1322        0.0932
;

table BA(e,i)    FADN based cost shares for BARLEY: See XLS files 'Cereals.xls' and 'Cost.xls' for details
          FERTIL        ENERGY        INTERMED      CAPITAL       LABOR         LAND
BG        0.0827        0.1959        0.3927        0.1142        0.1440        0.0706
CY        0.1615        0.0604        0.2933        0.0980        0.2393        0.1474
CZ        0.1291        0.1344        0.4228        0.0756        0.1244        0.1137
DK        0.0823        0.0461        0.3692        0.2175        0.1504        0.1345
GE        0.1312        0.1071        0.3902        0.1242        0.1510        0.0963
GR        0.1435        0.0790        0.2410        0.2350        0.1562        0.1454
ES        0.1406        0.1036        0.2661        0.1536        0.2411        0.0950
EE        0.1988        0.1672        0.3176        0.0780        0.1461        0.0923
FR        0.1260        0.0899        0.2785        0.1879        0.2015        0.1162
HU        0.1698        0.1294        0.3225        0.1037        0.1861        0.0885
IE        0.1625        0.0557        0.3561        0.1129        0.1897        0.1231
IT        0.0578        0.0830        0.1967        0.1669        0.3923        0.1032
LT        0.2133        0.1480        0.2857        0.1305        0.1418        0.0807
LV        0.1698        0.1294        0.3225        0.1037        0.1861        0.0885
PL        0.1674        0.1062        0.2776        0.1387        0.2243        0.0858
PT        0.1260        0.0899        0.2785        0.1879        0.2015        0.1162
RO        0.0827        0.1959        0.3927        0.1142        0.1440        0.0706
FI        0.1127        0.1144        0.3482        0.1295        0.1305        0.1647
SW        0.1260        0.0899        0.2785        0.1879        0.2015        0.1162
SK        0.1698        0.1294        0.3225        0.1037        0.1861        0.0885
UK        0.1429        0.0837        0.4089        0.1185        0.1542        0.0919
AT        0.1260        0.0899        0.2785        0.1879        0.2015        0.1162
BE        0.1260        0.0899        0.2785        0.1879        0.2015        0.1162
NL        0.1260        0.0899        0.2785        0.1879        0.2015        0.1162
MT        0.1698        0.1294        0.3225        0.1037        0.1861        0.0885
SI        0.1698        0.1294        0.3225        0.1037        0.1861        0.0885
;

table DW(e,i)    FADN based cost shares for DURUM: See XLS files 'Cereals.xls' and 'Cost.xls' for details
          FERTIL        ENERGY        INTERMED      CAPITAL       LABOR         LAND
BG        0.1178        0.0836        0.3311        0.1580        0.1879        0.1216
CY        0.1178        0.0836        0.3311        0.1580        0.1879        0.1216
GE        0.1178        0.0836        0.3311        0.1580        0.1879        0.1216
GR        0.1244        0.0902        0.2731        0.2471        0.1124        0.1528
ES        0.1276        0.0832        0.3082        0.1393        0.2555        0.0862
FR        0.1343        0.0679        0.4526        0.0876        0.1258        0.1317
HU        0.1178        0.0836        0.3311        0.1580        0.1879        0.1216
IT        0.0885        0.0950        0.2625        0.1681        0.2819        0.1040
PT        0.1178        0.0836        0.3311        0.1580        0.1879        0.1216
RO        0.1178        0.0836        0.3311        0.1580        0.1879        0.1216
SK        0.1178        0.0836        0.3311        0.1580        0.1879        0.1216
UK        0.1178        0.0836        0.3311        0.1580        0.1879        0.1216
AT        0.1178        0.0836        0.3311        0.1580        0.1879        0.1216
MT        0.1178        0.0836        0.3311        0.1580        0.1879        0.1216
;

table GM(e,i)    FADN based cost shares for CORN: See XLS files 'Cereals.xls' and 'Cost.xls' for details
          FERTIL        ENERGY        INTERMED      CAPITAL       LABOR         LAND
BG        0.1061        0.0891        0.4365        0.1195        0.1464        0.1024
CZ        0.1499        0.1535        0.4017        0.0733        0.1115        0.1102
GE        0.1320        0.0884        0.3682        0.1143        0.2176        0.0793
GR        0.1434        0.1065        0.3265        0.1554        0.1720        0.0961
ES        0.1293        0.0845        0.3666        0.0858        0.2598        0.0739
FR        0.1514        0.0795        0.4501        0.0696        0.1449        0.1046
HU        0.1359        0.1505        0.4095        0.0831        0.1096        0.1114
IE        0.1320        0.0884        0.3682        0.1143        0.2176        0.0793
IT        0.1021        0.0884        0.2747        0.1350        0.3162        0.0835
LT        0.1499        0.1535        0.4017        0.0733        0.1115        0.1102
PL        0.2183        0.1734        0.3038        0.1266        0.0996        0.0783
PT        0.1289        0.1429        0.3326        0.1173        0.2058        0.0725
RO        0.0987        0.1121        0.3311        0.0642        0.2974        0.0965
SK        0.1499        0.1535        0.4017        0.0733        0.1115        0.1102
AT        0.1320        0.0884        0.3682        0.1143        0.2176        0.0793
BE        0.1320        0.0884        0.3682        0.1143        0.2176        0.0793
NL        0.1320        0.0884        0.3682        0.1143        0.2176        0.0793
MT        0.1499        0.1535        0.4017        0.0733        0.1115        0.1102
SI        0.1499        0.1535        0.4017        0.0733        0.1115        0.1102
;

parameter
cost_share_crops(e,cr,i) cost shares for crops: add to 100% and are scaled later on
;

* Derived from the Reference crop and the default German data. Reference crop
* for all MS is CWHEAT, but for IE and CY it is BARLEY and for PT it is CORN

cost_share_crops(e,cr,i)$CW('GE',i) =  default_cr(cr,i) * CW(e,i) / CW('GE',i);
cost_share_crops('CY',cr,i)$BA('GE',i) =  default_cr(cr,i) * BA('CY',i) / BA('GE',i);
cost_share_crops('IE',cr,i)$BA('GE',i) =  default_cr(cr,i) * BA('IE',i) / BA('GE',i);
cost_share_crops('PT',cr,i)$GM('GE',i) =  default_cr(cr,i) * GM('PT',i) / GM('GE',i);

* Crops for which information from Sophie is available, i.e. for which rows in the crop specific tables are filled, are calculated differently:
* The calculation for CW does not need to be repeated, since it is the default formula for all MS where CW data is available from Sophie

cost_share_crops(e,'BARLEY',i)$(BA('GE',i) and BA(e,i)) =  default_cr('BARLEY',i) * BA(e,i) / BA('GE',i);
cost_share_crops(e,'DURUM',i)$(DW('GE',i) and DW(e,i)) =  default_cr('DURUM',i) * DW(e,i) / DW('GE',i);
cost_share_crops(e,'CORN',i)$(GM('GE',i) and GM(e,i)) =  default_cr('CORN',i) * GM(e,i) / GM('GE',i);

* Scale shares to 100%
Cost_share_crops(e,cr,i) = Cost_share_crops(e,cr,i)/sum(ii,Cost_share_crops(e,cr,ii));

* Values for Germany are taken from the default tables
Cost_share_crops('GE',cr,i) = default_cr(cr,i);

********************************************************************************
* CROPS - END ******************************************************************
********************************************************************************




********************************************************************************
* LIVESTOCK ********************************************************************
********************************************************************************


table MILK(e,i)    FADN based cost shares for MILK: See XLS files 'Dairy.xls' and 'Cost.xls' for details
          LABOR         CAPITAL       INTERMED      FEED          ENERGY
AT        0.0943        0.1429        0.1750        0.5521        0.0357
BE        0.0751        0.1146        0.1461        0.6303        0.0339
BG        0.0979        0.0819        0.0975        0.7008        0.0218
CY        0.0979        0.0819        0.0975        0.7008        0.0218
CZ        0.1485        0.0583        0.1453        0.6211        0.0269
DK        0.0819        0.1690        0.1236        0.6015        0.0239
EE        0.0979        0.0819        0.0975        0.7008        0.0218
ES        0.0527        0.0247        0.0931        0.8218        0.0076
FI        0.0907        0.1522        0.1477        0.5707        0.0388
FR        0.0713        0.1138        0.1344        0.6627        0.0179
GE        0.0743        0.0979        0.1586        0.6227        0.0465
GR        0.0751        0.1146        0.1461        0.6303        0.0339
HU        0.1048        0.0733        0.0993        0.6994        0.0233
IE        0.0751        0.1146        0.1461        0.6303        0.0339
IT        0.0751        0.1146        0.1461        0.6303        0.0339
LV        0.0979        0.0819        0.0975        0.7008        0.0218
LT        0.0979        0.0819        0.0975        0.7008        0.0218
MT        0.0979        0.0819        0.0975        0.7008        0.0218
NL        0.0511        0.1023        0.1751        0.6393        0.0322
PL        0.0904        0.0841        0.0884        0.7161        0.0211
PT        0.0751        0.1146        0.1461        0.6303        0.0339
RO        0.0979        0.0819        0.0975        0.7008        0.0218
SK        0.0979        0.0819        0.0975        0.7008        0.0218
SI        0.0979        0.0819        0.0975        0.7008        0.0218
SW        0.1089        0.1576        0.1062        0.5757        0.0516
UK        0.0751        0.1146        0.1461        0.6303        0.0339
;

table BEEF(e,i)    FADN based cost shares for MILK: See XLS files 'Beef.xls' and 'Cost.xls' for details
          LABOR         CAPITAL       INTERMED      FEED          ENERGY
AT        0.1830        0.1923        0.3023        0.2551        0.0673
BE        0.1182        0.1629        0.2564        0.4244        0.0381
BG        0.2757        0.0455        0.1755        0.3989        0.1044
CY        0.2464        0.1288        0.2059        0.3160        0.1029
CZ        0.2151        0.1276        0.2954        0.2378        0.1241
DK        0.1153        0.2097        0.2313        0.4155        0.0282
EE        0.2418        0.1022        0.2571        0.3008        0.0981
ES        0.2247        0.0664        0.1316        0.5368        0.0406
FI        0.1590        0.2021        0.2633        0.3094        0.0663
FR        0.1235        0.1913        0.3097        0.3267        0.0488
GE        0.1195        0.1477        0.2832        0.3665        0.0831
GR        0.1660        0.0551        0.1290        0.6234        0.0265
HU        0.1492        0.0879        0.1490        0.5049        0.1090
IE        0.2771        0.1737        0.2478        0.2613        0.0402
IT        0.2360        0.1026        0.1506        0.4512        0.0595
LV        0.2478        0.1394        0.1832        0.2736        0.1559
LT        0.2771        0.1506        0.1552        0.2909        0.1262
MT        0.2464        0.1288        0.2059        0.3160        0.1029
NL        0.1423        0.1437        0.2936        0.3843        0.0362
PL        0.2349        0.1293        0.1518        0.3964        0.0876
PT        0.2795        0.1138        0.1787        0.3463        0.0817
RO        0.2757        0.0455        0.1755        0.3989        0.1044
SK        0.2464        0.1288        0.2059        0.3160        0.1029
SI        0.3087        0.1682        0.2652        0.1602        0.0977
SW        0.2016        0.1822        0.2498        0.2880        0.0785
UK        0.1875        0.1488        0.3110        0.2933        0.0594
;

table PORK(e,i)    FADN based cost shares for MILK: See XLS files 'Pork.xls' and 'Cost.xls' for details
          LABOR         CAPITAL       INTERMED      FEED          ENERGY
AT        0.1866        0.1942        0.3097        0.2456        0.0640
BE        0.1662        0.2117        0.2617        0.3076        0.0529
BG        0.2161        0.0670        0.1427        0.4969        0.0772
CY        0.1964        0.1245        0.2077        0.3706        0.1007
CZ        0.2610        0.0898        0.2683        0.2704        0.1105
DK        0.1387        0.2838        0.2710        0.2736        0.0330
EE        0.2543        0.1108        0.1844        0.3471        0.1034
ES        0.1728        0.0620        0.1982        0.5142        0.0529
FI        0.2333        0.1741        0.2975        0.2343        0.0608
FR        0.1301        0.2004        0.3327        0.2857        0.0511
GE        0.1427        0.1612        0.3160        0.2934        0.0867
GR        0.0860        0.0483        0.0858        0.7530        0.0269
HU        0.1862        0.0964        0.2201        0.3949        0.1024
IE        0.2010        0.1693        0.2561        0.3288        0.0448
IT        0.2177        0.1054        0.1674        0.4394        0.0701
LV        0.2454        0.1497        0.1848        0.3019        0.1182
LT        0.1264        0.2839        0.2982        0.2240        0.0675
MT        0.1076        0.0486        0.0954        0.6821        0.0664
NL        0.1387        0.2415        0.3219        0.2515        0.0464
PL        0.1707        0.1341        0.1994        0.4009        0.0949
PT        0.1333        0.0916        0.2051        0.4979        0.0721
RO        0.3683        0.1066        0.1842        0.2612        0.0798
SK        0.2034        0.1735        0.2332        0.3021        0.0877
SI        0.2547        0.1925        0.2038        0.2489        0.1001
SW        0.2207        0.1509        0.2613        0.2998        0.0672
UK        0.1600        0.1734        0.2880        0.3183        0.0604
;
parameter
cost_share_livest(e,l,i) cost shares for crops: add to 100% and are scaled later on
;

* Derived from Sophie's Data and the default German data for Milk, Beef and Pork.
* No data for Sheep and Poultry/Eggs from Sophie

cost_share_livest(e,'MILK',i)$MILK('GE',i) =  default_l('MILK',i) * MILK(e,i) / MILK('GE',i);
cost_share_livest(e,'BEEF',i)$BEEF('GE',i) =  default_l('BEEF',i) * BEEF(e,i) / BEEF('GE',i);
cost_share_livest(e,'PORK',i)$PORK('GE',i) =  default_l('PORK',i) * PORK(e,i) / PORK('GE',i);



* Scale shares to 100%
Cost_share_livest(e,l,i)$sum(ii,Cost_share_livest(e,l,ii)) = Cost_share_livest(e,l,i)/sum(ii,Cost_share_livest(e,l,ii));

* Shares for Poultry, Eggs and Sheepmeat

cost_share_livest(e,'Poultry',i) = cost_share_livest(e,'PORK',i);
cost_share_livest(e,'Eggs',i)    = cost_share_livest(e,'PORK',i);
cost_share_livest(e,'Sheep',i)   = cost_share_livest(e,'BEEF',i);

* Values for Germany are taken from the default tables
Cost_share_livest('GE',l,i) = default_l(l,i);

********************************************************************************
* CROPS - END ******************************************************************
********************************************************************************
execute_unload 'cost_shares.gdx'  Cost_share_crops, Cost_share_livest;
