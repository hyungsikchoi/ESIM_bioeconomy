* <%INPUT%>
Table land_data(cc,land_st_) Data for calibration land supply function
          landprice  shift_land   max_land_use
AT        200        2            3225.26000
BE        185        3            1446.55980
DK        290        5            2798.36920
FI        150        4            2228.50000
FR        123        60           28660.39000
GE        200        40           17145.95410
GR        455        4            1899.81770
IE        200        8            3718.21800
IT        397        22           10711.33360
NL        370        3.5          2599.20150
PT        300        2            2858.61450
ES        400        35           17159.15775
SW        129        6            3068.37410
UK        198        22           15089.20455
LV        5.81       2            1825.79250
RO        1.56       26           13160.30320
SI        29.42      1            487.88250
LT        69.3       5            2660.62000
BG        9.75       8            4761.15640
PL        154.45     30           15272.05000
HU        109.43     10           5267.70000
CZ        7.09       8            3507.73500
SK        10.68      4.5          1905.43500
EE        1.88       1.5          813.56000
CY        51.21      0.14         114.99990
*MT        36.4       0.02         10.22175
MT        36.4       0.02         11.22175
TU        68.55      55           32078.16590
HR        14.71      1            1085.54145
;
* <%FORMAT ###,##0.##%>
* <%/INPUT%>

set area_chg(one)
/GR,IE,IT,ES,UK,LV,LT,PL,CZ,SK,EE,CY,HR/;

land_data(area_chg,'max_land_use')=land_data(area_chg,'max_land_use')*1.2;
land_data('GR','max_land_use')=land_data('GR','max_land_use')*1.5;


elast_landpr(one,i) = el_area0(one,i,"land");
elast_landpr(one,'lino') = el_area0(one,'barley',"land");

landprice1.l(one)  = land_data(one,'landprice')*SUM(euro1, exrate(euro1)) /exrate(one);
landprice0(one) = landprice1.l(one);

landsupply1.l(one) = SUM(crops, alarea.l(one,crops));
shift_ld(one)      = land_data(one,'shift_land');
area_max(one)      = land_data(one,'max_land_use');


*area_max("ro") = (land_data("ro","max_land_use") / 1.1) * 1.2;

ch_area(one) = 1.0;
ch_area_rate(one)= (indices("area",one)/100)+1 ;



Q_new1.l(one)= area_max(one) - oblsetas.l(one)*marg_land(one);
bend_ld1(one) = (q_new1.l(one) - landsupply1.l(one)) * (shift_ld(one) + landprice1.l(one));


parameter chk_available_land(*,*);
chk_available_land(one,'margin')
 =  Q_new1.l(one)- landsupply1.l(one);

chk_available_land(crops,one)
 =  alarea.l(one,crops);

display chk_available_land;

display landsupply1.l, q_new1.l, bend_ld1, shift_ld;




















































































































