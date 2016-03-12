$GDXin Database_GDX\esim_parameters_40%.gdx
$load elasthd
$load elastsp
$load elastyd
$load elastfd
*$load fedrat
$load elastin
$load elast_y_i
$load elast_y_l
$load elast_y_c
$load elast_y_f
$load elast_y_e
$load elast_lv_i
$load elast_lv_l
$load elast_lv_c
$load elast_lv_f
*$load feed_exog
$load el_area0
$GDXIN

$GDXin Database_GDX\frates_calc.gdx
$load fedrat=frate
$load feed_exog=f_int
$load feed_row=f_dem
$GDXIN

$GDXin Database_GDX\Straw_ratio.gdx
$load straw_ratio=stra_yield
$GDXIN



$ontext
parameter tfd(feed,feed1);
tfd(feed,feed1) = elastfd('RO',feed,feed1,'EGGS');
display tfd;
elastfd(cc,feed,feed1,livest)$((NOT sameas(feed,feed1)) AND (elastfd(cc,feed,feed,livest)=0)) = 0;
tfd(feed,feed1) = elastfd('RO',feed,feed1,'EGGS');
display tfd;
$offtext

elast_y('INTERMED',cc,i) = elast_y_i(cc,i);
elast_y('LABOR',cc,i)    = elast_y_l(cc,i);
elast_y('CAPITAL',cc,i)  = elast_y_c(cc,i);
elast_y('ENERGY',cc,i)   = elast_y_e(cc,i);
elast_y('FERTIL',cc,i)   = elast_y_f(cc,i);

elast_a(ecc,cc,crops) = el_area0(cc,crops,ecc);

*andresetaside:
elastsp(eu12,"setaside","setaside")= 0.12;

**hyungsik
elastsp('WB',"FODDER","FODDER")= 0.650;
elastsp('US',"FODDER","FODDER")= 0.650;
elastsp('ROW',"FODDER","FODDER")= 0.650;

display elastsp;



$GDXin Database_GDX\prices_policies.gdx
$load pp_results
$load DP_DECOUP
$load DP_COUP
$load DP_decoup_ha
$load DP_coup_ha
$load DP_coup_env
$load Art_69_env
$load Art_69_ha
$load CNDP_ha
$load CNDP_env
$GDXIN

DP_DECOUP('puls',ccplus)= DP_DECOUP('Barley',ccplus);
DP_DECOUP('MANIOC',ccplus)=0;


Parameters
oil_content
crops_to_ethanol
oil_to_diesel
;

$GDXin Database_GDX\Quantities.gdx
*$load show_data
*$load consolid_area
$load input_biodiesel
$load input_ethanol
*$load oil_to_diesel
*$load crops_to_ethanol
*$load dairy_pdem
$load content_milk
$load oil_content
$GDXIN


* CAPRI coefficients


**CAPRI parameters in 1st biofuel
oil_to_diesel = 0.922;
crops_to_ethanol('CWHEAT') = 0.274;
crops_to_ethanol('RYE') = 0.247;
crops_to_ethanol('OTHGRA') = 0.247;
crops_to_ethanol('CORN') = 0.335;
crops_to_ethanol('SUGAR') = 0.517;
crops_to_ethanol('BARLEY') = 0.247;


$GDXin Database_GDX\CAPRI_show_data.gdx
$load show_data=show_data_CAPRI
*$load dairy_pdem=show_diary_CAPRI
$GDXin

$GDXin Database_GDX\CapriProcess.gdx
$load dairy_pdem=CapriProcess_export
$GDXin


$GDXin Database_GDX\CAPRI_consolid_area.gdx
$load consolid_area=consolid_area_CAPRI
$GDXin

***hyungsik, setaside is abolisehd in 2008
*show_data('setaside','PROD',cc) = 0;

hdem0(cc,i) = show_data(i,'HDEM',cc);
sdem0(cc,i) = show_data(i,'SDEM',cc);
fdem0(cc,i) = show_data(i,'FDEM',cc);
procdem0(cc,i) = show_data(i,'PDEM',cc);
prod0(cc,i) = show_data(i,'PROD',cc);
area0(cc,i) = consolid_area(i,cc);

netexp0(cc,it) =   show_data(it,'PROD',cc)
                          -   show_data(it,'SDEM',cc)
                          -   show_data(it,'HDEM',cc)
                          -   show_data(it,'FDEM',cc)
                          -   show_data(it,'PDEM',cc);

display netexp0;
**
**==============puls, othdairy price (HS)=================
**

***Note!!compare it with paprameter calibration prices!!
pp_results ('PULS',cc,"pd") = pp_results ('OPROT',cc,"pd");
pp_results ('PULS',cc,"marg")= pp_results ('OPROT',cc,"marg");

pp_results ('OTHDAIRY',cc,"pd")$prod0(cc,'OTHDAIRY') = pp_results ('SMP',cc,"pd")*3;
pp_results ('OTHDAIRY',cc,"marg")$prod0(cc,'OTHDAIRY') = pp_results ('SMP',cc,"marg");


mrktpri0(cc,i) =   pp_results (i,cc,"pd");
*mrktpri0(cc,'puls') =   pp_results ('SUNMEAL',cc,"pd");


mrktpri0(cc,nt) =  pp_results (nt,cc,"pd");
margin0(cc,i)  =   pp_results (i,cc,"marg");

display margin0;







eu_pols(i,pol) =   pp_results(i,'GE',pol);

execute_UNLOAD 'complete_esim_database.gdx',
elasthd
elastsp,
elastyd,
elastfd,
fedrat,
elastin,
elast_y_i,
elast_y_l,
elast_y_c,
elast_y_e,
elast_y_f,
*elast_a_i,
*elast_a_l,
*elast_a_c,
elast_lv_i,
elast_lv_l,
elast_lv_c,
elast_lv_f,
feed_exog,
mrktpri0,
margin0,
eu_pols,
hdem0,
prod0,
sdem0,
fdem0,
procdem0,
*pdem_en0,
netexp0,
dirpay0,
price_dev,
area0,
hist_area;
