* inject S. Nolte's new feed data from data_prices.gdx & data_quantities.gdx into Quantities.gdx & Prices_Policies.gdx
$ONMULTI
$ONEMPTY

$include sets.gms
$include alias.gms
$include parameters.gms

Parameters
oil_content
crops_to_ethanol
oil_to_diesel
PD00(cc,comm) Final prices (PD) after calib logistic function
PP00(cc,comm) Final producer prices (PP) after calib logistic function
;

$GDXin './Nolte_new_feed_data/Prices_Policies - org.gdx'
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

$GDXin '.\Nolte_new_feed_data\data_prices.gdx'
$  load PD00
$  load PP00
$GDXin

$GDXin './Nolte_new_feed_data/Quantities - org.gdx'
$load show_data
$load consolid_area
$load input_biodiesel
$load input_ethanol
$load oil_to_diesel
$load crops_to_ethanol
$load dairy_pdem
$load content_milk
$load oil_content
$GDXIN

$GDXin './Nolte_new_feed_data/data_quantities.gdx'
$  load prod0
$  load fdem0
$GDXin

* check data:
PARAMETER diff(*,cc,i);
diff('dPD',cc,comm) = pp_results(comm,cc,'PD')-pd00(cc,comm);
diff('dPP',cc,comm) = pp_results(comm,cc,'PP')-pd00(cc,comm);
diff('dPROD',cc,comm) = show_data(comm,'PROD',cc)-prod0(cc,comm);
diff('dFDEM',cc,comm) = show_data(comm,'FDEM',cc)-prod0(cc,comm);

diff('newPD',cc,comm)$(NOT pp_results(comm,cc,'PD') AND pd00(cc,comm)) = pd00(cc,comm);
diff('delPD',cc,comm)$(pp_results(comm,cc,'PD') AND NOT pd00(cc,comm)) = pp_results(comm,cc,'PD');

diff('newPP',cc,comm)$(NOT pp_results(comm,cc,'PP') AND PP00(cc,comm)) = PP00(cc,comm);
diff('delPP',cc,comm)$(pp_results(comm,cc,'PP') AND NOT PP00(cc,comm)) = pp_results(comm,cc,'PP');

diff('newPROD',cc,comm)$(NOT show_data(comm,'PROD',cc) AND PROD0(cc,comm)) = PROD0(cc,comm);
diff('delPROD',cc,comm)$(show_data(comm,'PROD',cc) AND NOT PROD0(cc,comm)) = show_data(comm,'PROD',cc);

diff('newFDEM',cc,comm)$(NOT show_data(comm,'FDEM',cc) AND FDEM0(cc,comm)) = FDEM0(cc,comm);
diff('delFDEM',cc,comm)$(show_data(comm,'FDEM',cc) AND NOT FDEM0(cc,comm)) = show_data(comm,'FDEM',cc);

display diff;
execute_unload './Nolte_new_feed_data/diff.gdx',
diff;


SET SETPD(comm) /SMAIZE, GRAS, FODDER/;
pp_results(SETPD,cc,'PD') = pd00(cc,SETPD);
SET SETPP(comm) /OPROT, OENERGY, SMAIZE, GRAS, FODDER/;
pp_results(SETPP,cc,'PP') = PP00(cc,SETPP);

execute_unload './Nolte_new_feed_data/Prices_Policies.gdx',
pp_results
DP_DECOUP
DP_COUP
DP_decoup_ha
DP_coup_ha
DP_coup_env
Art_69_env
Art_69_ha
CNDP_ha
CNDP_env
;

SET SETQ_EU(comm) /OPROT, OENERGY/;
SET SETQ_ROW(comm) /OPROT, OENERGY, FODDER/;
show_data(SETQ_EU,'PROD',cc)$one(cc) = prod0(cc,SETQ_EU);
show_data(SETQ_EU,'FDEM',cc)$one(cc) = fdem0(cc,SETQ_EU);
show_data(SETQ_ROW,'PROD',cc)$rest(cc) = prod0(cc,SETQ_ROW);
show_data(SETQ_ROW,'FDEM',cc)$rest(cc) = fdem0(cc,SETQ_ROW);

execute_unload './Nolte_new_feed_data/Quantities.gdx',
show_data
consolid_area
input_biodiesel
input_ethanol
oil_to_diesel
crops_to_ethanol
dairy_pdem
content_milk
oil_content
;

