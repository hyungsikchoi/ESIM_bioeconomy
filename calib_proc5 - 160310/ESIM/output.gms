$include "Transform_results.gms"

PARAMETER rR_THR(sim_base,it)   Yes if product is a thresh product in the respective year;
PARAMETER rR_INT(sim_base,it)   Yes if product is an intervention product in the resp. year;
PARAMETER rR_TAR(sim_base,it)   Yes if the product is a tariff product in the resp. year;
PARAMETER rR_MEMBER(cc,sim_base) Yes if country is member;

rR_THR(sim_base,it)$R_THR(sim_base,it)=1;
rR_INT(sim_base,it)$R_INT(sim_base,it)=1;
rR_TAR(sim_base,it)$R_TAR(sim_base,it)=1;
rR_MEMBER(cc,sim_base)$R_MEMBER(cc,sim_base)=1;

*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#
*#* The GDX OUTPUT statement *#*
*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#

* Dynamic sets which are used in the transformation of results

execute_UNLOAD 'results.gdx',r_cc,rr_thr,rr_int,rr_tar,rr_member,r_comm,expenditure,elasthd_c,exp_share,elasthd_c,texp_share,r_er,r_pw;
execute_UNLOAD 'core_res.gdx',r_core_res;
* <%GDXOUTPUT%>
* <%OUTPUT FILE results.gdx%>

* <%SYMBOL%>
*    <%PARAMETER r_cc(CCplus,sim_base1,res_cc) Non commodity specific results%>
*    <%FORMAT #,###,##0.%>
* <%ENDSYMBOL%>

* <%SYMBOL%>
*    <%PARAMETER rR_THR(sim_base1,it)   Yes if product is a thresh product in the respective year%>
*    <%FORMAT #,###,##0.####%>
* <%ENDSYMBOL%>

* <%SYMBOL%>
*    <%PARAMETER rR_INT(sim_base1,it)   Yes if product is an intervention product in the resp. year%>
*    <%FORMAT #,###,##0.####%>
* <%ENDSYMBOL%>

* <%SYMBOL%>
*    <%PARAMETER rR_TAR(sim_base1,it)   Yes if the product is a tariff product in the resp. year%>
*    <%FORMAT #,###,##0.####%>
* <%ENDSYMBOL%>

* <%SYMBOL%>
*    <%PARAMETER rR_MEMBER(cc,sim_base1) Yes if country is member%>
*    <%FORMAT #,###,##0.####%>
* <%ENDSYMBOL%>

* <%SYMBOL%>
*    <%PARAMETER r_comm(ccplus,sim,comm,res_comm) Commodity specific results%>
*    <%FORMAT #,###,##0.%>
* <%ENDSYMBOL%>

* <%SYMBOL%>
*    <%PARAMETER expenditure(cc) Total consumption expenditure%>
*    <%FORMAT #,###,##0.####%>
* <%ENDSYMBOL%>

* <%SYMBOL%>
*    <%PARAMETER exp_share(cc,comm)   Exp. shares of single ESIM products in total%>
*    <%FORMAT #,###,##0.####%>
* <%ENDSYMBOL%>

* <%SYMBOL%>
*    <%PARAMETER elasthd_c(cc,i,j) Compensated price elasticities of human demand%>
*    <%FORMAT #,###,##0.####%>
* <%ENDSYMBOL%>

* <%SYMBOL%>
*    <%PARAMETER texp_share(cc) Exp. share of total ESIM products in total exp. in base%>
*    <%FORMAT #,###,##0.####%>
* <%ENDSYMBOL%>
* <%/GDXOUTPUT%>


*set seeds(i) / sunseed, rapseed, soybean /;


*$ontext
Parameter
r_calib_pw
r_calib_eth
r_calib_bd
r_calib_eth_PROD
r_calib_BD_PROD
r_idiesel
r_seeds
r_barley_nex
r_barley_supp
;



r_idiesel(i_diesel,sim_base,res_comm) = r_comm("eu_to",sim_base,i_diesel,res_comm);
r_seeds(oilseed,sim_base,res_comm)    = r_comm("eu_to",sim_base,oilseed,res_comm);

r_barley_nex(sim_base) = r_comm("eu_to",sim_base,"barley","r_nx");
r_barley_supp(sim_base)= r_comm("eu_to",sim_base,"barley","r_supp");


r_calib_pw(it) = r_pw("2020",it);

r_calib_eth(sim_base) = r_comm("eu_to",sim_base,"ETHANOL","r_hdem");
r_calib_bd(sim_base)  = r_comm("eu_to",sim_base,"BIODIESEL","r_hdem");

r_calib_eth_PROD(sim_base) = r_comm("eu_to",sim_base,"ETHANOL","r_supp");
r_calib_BD_PROD(sim_base)  = r_comm("eu_to",sim_base,"BIODIESEL","r_supp");

execute_UNLOAD 'calib.gdx' r_calib_pw, r_calib_eth, r_calib_bd, r_calib_eth_PROD, r_calib_BD_PROD, r_idiesel, r_seeds, r_barley_nex, r_barley_supp;

execute 'gdxxrw calib.gdx output=Calibration_WMP.xls par=r_calib_pw rng=calib!e4 rdim=1 par=r_calib_bd rng=calib!v4 rdim=1 par=r_calib_eth rng=calib!x4 rdim=1 par=r_calib_BD_PROD rng=calib!aa4 rdim=1 par=r_calib_eth_PROD rng=calib!ac4 rdim=1 par=r_idiesel rng=oils!a1:p57 rdim=2 par=r_seeds rng=seeds!a1 rdim=2 par=r_barley_nex rng=barley!a1 rdim=1 par=r_barley_supp rng=barley!a20 rdim=1';
*$offtext
