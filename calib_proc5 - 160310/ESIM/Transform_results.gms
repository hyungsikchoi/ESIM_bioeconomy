* The following export subsidy limits for intervention products are just for accounting purposes
$ontext
Parameter
ES_quant(it)
ES_quant_t(sim_base,it)
;

ES_quant("rye")=1000;
ES_quant("cwheat")=13400;
ES_quant("barley")=7400;
ES_quant("corn")=500;
ES_quant("rice")=140;
ES_quant("butter")=370;
ES_quant("SMP")=234;

* Calculate ES for all products
*#* Scale down after CAP
ES_quant_t(sim_base,it) =
SUM(EURO1, r_comm(EURO1,sim_base,it,"r_esqu")) +ES_quant(it);
$offtext

* This file is for calculating all kind of result transformation which need not
* be based on more than one scenario:

* 1) Values
* 2) Aggregate per country group
* 3) Indices
* 4) Budget
* 5) Expenditure shares and compensated elasticities for welfare calculations
* 6) Consumption per capita


* 1) Values
* Product specific farm production value
r_comm(cc,sim_base,comm,"r_valp") =
r_comm(cc,sim_base,comm,"r_supp")*r_comm(cc,sim_base,comm,"r_pp")/1000;

* Product specific consumption value (at wholesale prices adjusted for subsidies)
r_comm(cc,sim_base,comm,"r_valc") =
r_comm(cc,sim_base,comm,"r_hdem")*r_comm(cc,sim_base,comm,"r_pc")/1000;


* Aggregated values
*# Farm production values
r_cc(cc,sim_base,"val_cr")       =
sum(crops,r_comm(cc,sim_base,crops,"r_valp"));

r_cc(cc,sim_base,"val_li")       =
sum(livest,r_comm(cc,sim_base,livest,"r_valp"));

r_cc(cc,sim_base,"val_fa")       =
sum(ag,r_comm(cc,sim_base,ag,"r_valp"));

*# Consumption values
r_cc(cc,sim_base,"val_pl")       =
sum(pl,r_comm(cc,sim_base,pl,"r_valc"));

r_cc(cc,sim_base,"val_an")       =
sum(an,r_comm(cc,sim_base,an,"r_valc"));

r_cc(cc,sim_base,"val_co")       =
sum(comm,r_comm(cc,sim_base,comm,"r_valc"));

*# Value of net export per country
r_cc(cc,sim_base,"val_nx")     =
Sum(comm, r_comm(cc,sim_base,comm,"r_nx")*r_comm(cc,sim_base,comm,"r_pd"))/1000;



*2) Aggregation per country group
*# Commodity specific results
*#* Aggregation over countries
r_comm("eu_to",sim_base,comm,res_agg) =
sum(one, r_comm(one,sim_base,comm,res_agg)*r_cc(one,sim_base,"r_memb"));

r_comm("eu_to",sim_base,'milk','r_fill')$sum(one, r_comm(one,sim_base,'milk',"r_quot") *r_cc(one,sim_base,"r_memb")) =
sum(one, (r_comm(one,sim_base,'milk','r_deliv')*r_cc(one,sim_base,"r_memb")))/
sum(one, r_comm(one,sim_base,'milk',"r_quot") *r_cc(one,sim_base,"r_memb")) *100;

r_comm("eu_15",sim_base,comm,res_agg) =
sum(eu15, r_comm(eu15,sim_base,comm,res_agg));

r_comm("eu_15",sim_base,'milk','r_fill')$sum(eu15, r_comm(eu15,sim_base,'milk',"r_quot"))=
sum(eu15, r_comm(eu15,sim_base,'milk','r_deliv'))/sum(eu15, r_comm(eu15,sim_base,'milk',"r_quot")) *100;

r_comm("nms12",sim_base,comm,res_agg) =
sum(eu12, r_comm(eu12,sim_base,comm,res_agg));

r_comm("nms12",sim_base,'milk','r_fill')$sum(eu12, r_comm(eu12,sim_base,'milk',"r_quot")) =
sum(eu12, r_comm(eu12,sim_base,'milk','r_deliv'))/sum(eu12, r_comm(eu12,sim_base,'milk',"r_quot")) *100;

r_comm("ACC",sim_base,comm,res_agg) =
SUM(cand, r_comm(cand,sim_base,comm,res_agg));

r_comm("acc",sim_base,'milk','r_fill')$sum(cand, r_comm(cand,sim_base,'milk',"r_quot")) =
sum(cand, r_comm(cand,sim_base,'milk','r_deliv'))/sum(cand, r_comm(cand,sim_base,'milk',"r_quot")) *100;


*#* Definition for those results for which total EU is identical to the EU 15
r_comm("eu_to",sim_base,comm,res_def) = SUM(EURO1, r_comm(EURO1,sim_base,comm,res_def));

*#* Definition for those results which are weighted averages (prices)
*#*# Results for Total EU
r_comm("eu_to",sim_base,comm,"r_pd") $(sum(one,r_comm(one,sim_base,comm,"r_tuse")) gt 0) =
sum(one $r_member(one,sim_base), r_comm(one,sim_base,comm,"r_pd")*
r_comm(one,"base",comm,"r_tuse")/sum(one1$r_member(one1,sim_base),r_comm(one1,"base",comm,"r_tuse")));

r_comm("eu_to",sim_base,comm,"r_pc") $(sum(one,r_comm(one,sim_base,comm,"r_tuse")) gt 0) =
sum(one $r_member(one,sim_base), r_comm(one,sim_base,comm,"r_pc")*
r_comm(one,"base",comm,"r_tuse")/sum(one1 $r_member(one1,sim_base),r_comm(one1,"base",comm,"r_tuse")));

r_comm("eu_to",sim_base,comm,"r_pp") $(sum(one,r_comm(one,sim_base,comm,"r_supp")) gt 0) =
sum(one $r_member(one,sim_base), r_comm(one,sim_base,comm,"r_pp")*
r_comm(one,"base",comm,"r_supp")/sum(one1 $r_member(one1,sim_base),r_comm(one1,"base",comm,"r_supp")));

r_comm("eu_to",sim_base,comm,"r_inc") $(sum(one,r_comm(one,sim_base,comm,"r_supp")) gt 0) =
sum(one $r_member(one,sim_base), r_comm(one,sim_base,comm,"r_inc")*
r_comm(one,"base",comm,"r_supp")/sum(one1 $r_member(one1,sim_base),r_comm(one1,"base",comm,"r_supp")));

r_comm("eu_to",sim_base,livest,"r_fci") $ (sum(one,r_comm(one,sim_base,livest,"r_supp")) gt 0) =
sum(one $r_member(one,sim_base), r_comm(one,sim_base,livest,"r_fci")*
r_comm(one,"base",livest,"r_supp")/sum(one1 $r_member(one1,sim_base),r_comm(one1,"base",livest,"r_supp")));

*#*# Results for EU 15
r_comm("eu_15",sim_base,comm,"r_pd") $ (sum(eu15,r_comm(eu15,sim_base,comm,"r_tuse")) gt 0) =
sum(eu15, r_comm(eu15,sim_base,comm,"r_pd")*
r_comm(eu15,"base",comm,"r_tuse")/sum(eu15_1,r_comm(eu15_1,"base",comm,"r_tuse")));

r_comm("eu_15",sim_base,comm,"r_pc") $ (sum(eu15,r_comm(eu15,sim_base,comm,"r_tuse")) gt 0) =
sum(eu15, r_comm(eu15,sim_base,comm,"r_pc")*
r_comm(eu15,"base",comm,"r_tuse")/sum(eu15_1,r_comm(eu15_1,"base",comm,"r_tuse")));

r_comm("eu_15",sim_base,comm,"r_pp") $ (sum(eu15,r_comm(eu15,sim_base,comm,"r_supp")) gt 0) =
sum(eu15, r_comm(eu15,sim_base,comm,"r_pp")*
r_comm(eu15,"base",comm,"r_supp")/sum(eu15_1,r_comm(eu15_1,"base",comm,"r_supp")));

r_comm("eu_15",sim_base,comm,"r_inc") $ (sum(eu15,r_comm(eu15,sim_base,comm,"r_supp")) gt 0) =
sum(eu15, r_comm(eu15,sim_base,comm,"r_inc")*
r_comm(eu15,"base",comm,"r_supp")/sum(eu15_1,r_comm(eu15_1,"base",comm,"r_supp")));

r_comm("eu_15",sim_base,livest,"r_fci") $ (sum(eu15,r_comm(eu15,sim_base,livest,"r_supp")) gt 0) =
sum(eu15, r_comm(eu15,sim_base,livest,"r_fci")*
r_comm(eu15,"base",livest,"r_supp")/sum(eu15_1,r_comm(eu15_1,"base",livest,"r_supp")));

*#*# Results for NMS 12
r_comm("nms12",sim_base,comm,"r_pd") $ (sum(eu12,r_comm(eu12,sim_base,comm,"r_tuse")) gt 0) =
sum(eu12, r_comm(eu12,sim_base,comm,"r_pd")*
r_comm(eu12,"base",comm,"r_tuse")/sum(eu12_1,r_comm(eu12_1,"base",comm,"r_tuse")));

r_comm("nms12",sim_base,comm,"r_pc") $ (sum(eu12,r_comm(eu12,sim_base,comm,"r_tuse")) gt 0) =
sum(eu12, r_comm(eu12,sim_base,comm,"r_pc")*
r_comm(eu12,"base",comm,"r_tuse")/sum(eu12_1,r_comm(eu12_1,"base",comm,"r_tuse")));

r_comm("nms12",sim_base,comm,"r_pp") $ (sum(eu12,r_comm(eu12,sim_base,comm,"r_supp")) gt 0) =
sum(eu12, r_comm(eu12,sim_base,comm,"r_pp")*
r_comm(eu12,"base",comm,"r_supp")/sum(eu12_1,r_comm(eu12_1,"base",comm,"r_supp")));

r_comm("nms12",sim_base,comm,"r_inc") $ (sum(eu12,r_comm(eu12,sim_base,comm,"r_supp")) gt 0) =
sum(eu12, r_comm(eu12,sim_base,comm,"r_inc")*
r_comm(eu12,"base",comm,"r_supp")/sum(eu12_1,r_comm(eu12_1,"base",comm,"r_supp")));

r_comm("nms12",sim_base,livest,"r_fci") $ (sum(eu12,r_comm(eu12,sim_base,livest,"r_supp")) gt 0) =
sum(eu12, r_comm(eu12,sim_base,livest,"r_fci")*
r_comm(eu12,"base",livest,"r_supp")/sum(eu12_1,r_comm(eu12_1,"base",livest,"r_supp")));



*#*# Results for Accession Countries
r_comm("ACC",sim_base,comm,"r_pd") $ (sum(cand,r_comm(cand,sim_base,comm,"r_tuse")) gt 0) =
sum(cand, r_comm(cand,sim_base,comm,"r_pd")*
r_comm(cand,"base",comm,"r_tuse")/sum(cand1,r_comm(cand1,"base",comm,"r_tuse")));

r_comm("ACC",sim_base,comm,"r_pc") $ (sum(cand,r_comm(cand,sim_base,comm,"r_tuse")) gt 0) =
sum(cand, r_comm(cand,sim_base,comm,"r_pc")*
r_comm(cand,"base",comm,"r_tuse")/sum(cand1,r_comm(cand1,"base",comm,"r_tuse")));

r_comm("ACC",sim_base,comm,"r_pp") $ (sum(cand,r_comm(cand,sim_base,comm,"r_supp")) gt 0) =
sum(cand, r_comm(cand,sim_base,comm,"r_pp")*
r_comm(cand,"base",comm,"r_supp")/sum(cand1,r_comm(cand1,"base",comm,"r_supp")));

r_comm("ACC",sim_base,comm,"r_inc") $ (sum(cand,r_comm(cand,sim_base,comm,"r_supp")) gt 0) =
sum(cand, r_comm(cand,sim_base,comm,"r_inc")*
r_comm(cand,"base",comm,"r_supp")/sum(cand1,r_comm(cand1,"base",comm,"r_supp")));

r_comm("ACC",sim_base,livest,"r_fci") $ (sum(cand,r_comm(cand,sim_base,livest,"r_supp")) gt 0) =
sum(cand, r_comm(cand,sim_base,livest,"r_fci")*
r_comm(cand,"base",livest,"r_supp")/sum(cand1,r_comm(cand1,"base",livest,"r_supp")));

*# Non-commodity specific results
*#* Aggregation over countries
r_cc("eu_to",sim_base,res_agg_cc) =
sum(one, r_cc(one,sim_base,res_agg_cc)*r_cc(one,sim_base,"r_memb"));

r_cc("eu_15",sim_base,res_agg_cc) =
sum(eu15, r_cc(eu15,sim_base,res_agg_cc));

r_cc("nms12",sim_base,res_agg_cc) =
sum(eu12, r_cc(eu12,sim_base,res_agg_cc));

r_cc("ACC",sim_base,res_agg_cc) =
sum(cand, r_cc(cand,sim_base,res_agg_cc));


* 3) Indices (base = 100)
*# Product specific indices
*#* Product specific price indices (base=100)
r_comm(ccplus,sim_base,comm,"pi_pd") $(r_comm(ccplus,sim_base,comm,"r_pd") gt 0) =
r_comm(ccplus,sim_base,comm,"r_pd")/r_comm(ccplus,"base",comm,"r_pd")*100;

r_comm(ccplus,sim_base,comm,"pi_pc") $(r_comm(ccplus,sim_base,comm,"r_pc") gt 0) =
r_comm(ccplus,sim_base,comm,"r_pc")/r_comm(ccplus,"base",comm,"r_pc")*100;

r_comm(ccplus,sim_base,comm,"pi_pp") $(r_comm(ccplus,sim_base,comm,"r_pp") gt 0) =
r_comm(ccplus,sim_base,comm,"r_pp")/r_comm(ccplus,"base",comm,"r_pp")*100;

r_comm(ccplus,sim_base,comm,"pi_inc") $(r_comm(ccplus,sim_base,comm,"r_inc") gt 0) =
r_comm(ccplus,sim_base,comm,"r_inc")/r_comm(ccplus,"base",comm,"r_inc")*100;

r_comm(ccplus,sim_base,comm,"pi_pf") $(r_comm(ccplus,sim_base,comm,"r_pf") gt 0) =
r_comm(ccplus,sim_base,comm,"r_pf")/r_comm(ccplus,"base",comm,"r_pf")*100;

r_comm(ccplus,sim_base,comm,"pi_fc") $(r_comm(ccplus,sim_base,comm,"r_fci") gt 0) =
r_comm(ccplus,sim_base,comm,"r_fci")/r_comm(ccplus,"base",comm,"r_fci")*100;

*#* Product specific price indices (world market =100)
r_comm(ccplus,sim_base,comm,"pd_relative_to_pw") $(r_comm(ccplus,sim_base,comm,"r_pd") gt 0
and r_comm("row",sim_base,comm,"r_pd") gt 0)=
r_comm(ccplus,sim_base,comm,"r_pd")/r_comm("row",sim_base,comm,"r_pd")*100;

*#* Product specific quantity indices (base=100)
r_comm(ccplus,sim_base,comm,"qi_supp") $ (r_comm(ccplus,sim_base,comm,"r_supp") gt 0) =
r_comm(ccplus,sim_base,comm,"r_supp")/r_comm(ccplus,"base",comm,"r_supp")*100;

r_comm(ccplus,sim_base,comm,"qi_hdem") $ (r_comm(ccplus,sim_base,comm,"r_hdem") gt 0) =
r_comm(ccplus,sim_base,comm,"r_hdem")/r_comm(ccplus,"base",comm,"r_hdem")*100;

r_comm(ccplus,sim_base,comm,"qi_pdem") $ (r_comm(ccplus,sim_base,comm,"r_pdem") gt 0) =
r_comm(ccplus,sim_base,comm,"r_pdem")/r_comm(ccplus,"base",comm,"r_pdem")*100;

r_comm(ccplus,sim_base,comm,"qi_fdem") $ (r_comm(ccplus,sim_base,comm,"r_fdem") gt 0) =
r_comm(ccplus,sim_base,comm,"r_fdem")/r_comm(ccplus,"base",comm,"r_fdem")*100;


*#* Product specific value indices (base=100)
r_comm(ccplus,sim_base,comm,"vi_supp") $ (r_comm(ccplus,sim_base,comm,"r_valp") gt 0) =
r_comm(ccplus,sim_base,comm,"r_valp")/r_comm(ccplus,"base",comm,"r_valp")*100;

r_comm(ccplus,sim_base,comm,"vi_hdem") $ (r_comm(ccplus,sim_base,comm,"r_valc") gt 0) =
r_comm(ccplus,sim_base,comm,"r_valc")/r_comm(ccplus,"base",comm,"r_valc")*100;


*# Product group indices
*#* Exchange rate index
r_cc(cc,sim_base,"r_exind")=
r_cc(cc,sim_base,"r_exra")/r_cc(cc,"base","r_exra")*100;

*#* Product group price indices, base quantity weighted (base = 100)
*#*# Producer price indices
r_cc(ccplus,sim_base,"pi_cr")$sum(crops, r_comm(ccplus,"base",crops,"r_pp")*r_comm(ccplus,"base",crops,"r_supp"))=
sum(crops, r_comm(ccplus,sim_base,crops,"r_pp")*r_comm(ccplus,"base",crops,"r_supp"))/
sum(crops, r_comm(ccplus,"base",crops,"r_pp")*r_comm(ccplus,"base",crops,"r_supp"))*100;

r_cc(ccplus,sim_base,"pi_lv")$sum(livest, r_comm(ccplus,"base",livest,"r_pp")*r_comm(ccplus,"base",livest,"r_supp"))=
sum(livest, r_comm(ccplus,sim_base,livest,"r_pp")*r_comm(ccplus,"base",livest,"r_supp"))/
sum(livest, r_comm(ccplus,"base",livest,"r_pp")*r_comm(ccplus,"base",livest,"r_supp"))*100;

r_cc(ccplus,sim_base,"pi_fa")$sum(ag, r_comm(ccplus,"base",ag,"r_pp")*r_comm(ccplus,"base",ag,"r_supp"))=
sum(ag, r_comm(ccplus,sim_base,ag,"r_pp")*r_comm(ccplus,"base",ag,"r_supp"))/
sum(ag, r_comm(ccplus,"base",ag,"r_pp")*r_comm(ccplus,"base",ag,"r_supp"))*100;

*#*# Incentive price indices
r_cc(ccplus,sim_base,"pi_inc_cr")$sum(crops, r_comm(ccplus,"base",crops,"r_inc")*r_comm(ccplus,"base",crops,"r_supp"))=
sum(crops, r_comm(ccplus,sim_base,crops,"r_inc")*r_comm(ccplus,"base",crops,"r_supp"))/
sum(crops, r_comm(ccplus,"base",crops,"r_inc")*r_comm(ccplus,"base",crops,"r_supp"))*100;

r_cc(ccplus,sim_base,"pi_inc_lv")$sum(livest, r_comm(ccplus,"base",livest,"r_inc")*r_comm(ccplus,"base",livest,"r_supp"))=
sum(livest, r_comm(ccplus,sim_base,livest,"r_inc")*r_comm(ccplus,"base",livest,"r_supp"))/
sum(livest, r_comm(ccplus,"base",livest,"r_inc")*r_comm(ccplus,"base",livest,"r_supp"))*100;

r_cc(ccplus,sim_base,"pi_inc_fa")$sum(ag, r_comm(ccplus,"base",ag,"r_inc")*r_comm(ccplus,"base",ag,"r_supp"))=
sum(ag, r_comm(ccplus,sim_base,ag,"r_inc")*r_comm(ccplus,"base",ag,"r_supp"))/
sum(ag, r_comm(ccplus,"base",ag,"r_inc")*r_comm(ccplus,"base",ag,"r_supp"))*100;


*#*# Consumer price indices
r_cc(ccplus,sim_base,"pi_pl")$sum(pl, r_comm(ccplus,"base",pl,"r_pc")*r_comm(ccplus,"base",pl,"r_hdem"))=
sum(pl, r_comm(ccplus,sim_base,pl,"r_pc")*r_comm(ccplus,"base",pl,"r_hdem"))/
sum(pl, r_comm(ccplus,"base",pl,"r_pc")*r_comm(ccplus,"base",pl,"r_hdem"))*100;

r_cc(ccplus,sim_base,"pi_an")$sum(an, r_comm(ccplus,"base",an,"r_pc")*r_comm(ccplus,"base",an,"r_hdem"))=
sum(an, r_comm(ccplus,sim_base,an,"r_pc")*r_comm(ccplus,"base",an,"r_hdem"))/
sum(an, r_comm(ccplus,"base",an,"r_pc")*r_comm(ccplus,"base",an,"r_hdem"))*100;

r_cc(ccplus,sim_base,"pi_co")$sum(comm, r_comm(ccplus,"base",comm,"r_pc")*r_comm(ccplus,"base",comm,"r_hdem"))=
sum(comm, r_comm(ccplus,sim_base,comm,"r_pc")*r_comm(ccplus,"base",comm,"r_hdem"))/
sum(comm, r_comm(ccplus,"base",comm,"r_pc")*r_comm(ccplus,"base",comm,"r_hdem"))*100;

*#* Product group quantity indices (base = 100)
*#*# Supply indices
r_cc(ccplus,sim_base,"qi_cr")$sum(crops, r_comm(ccplus,"base",crops,"r_pp")*r_comm(ccplus,"base",crops,"r_supp"))=
sum(crops, r_comm(ccplus,"base",crops,"r_pp")*r_comm(ccplus,sim_base,crops,"r_supp"))/
sum(crops, r_comm(ccplus,"base",crops,"r_pp")*r_comm(ccplus,"base",crops,"r_supp"))*100;

r_cc(ccplus,sim_base,"qi_lv")$sum(livest, r_comm(ccplus,"base",livest,"r_pp")*r_comm(ccplus,"base",livest,"r_supp"))=
sum(livest, r_comm(ccplus,"base",livest,"r_pp")*r_comm(ccplus,sim_base,livest,"r_supp"))/
sum(livest, r_comm(ccplus,"base",livest,"r_pp")*r_comm(ccplus,"base",livest,"r_supp"))*100;

r_cc(ccplus,sim_base,"qi_fa")$sum(ag, r_comm(ccplus,"base",ag,"r_pp")*r_comm(ccplus,"base",ag,"r_supp"))=
sum(ag, r_comm(ccplus,"base",ag,"r_pp")*r_comm(ccplus,sim_base,ag,"r_supp"))/
sum(ag, r_comm(ccplus,"base",ag,"r_pp")*r_comm(ccplus,"base",ag,"r_supp"))*100;

*#*#* In order to avoid misinterpretation the total EU indices are set back to zero
r_cc("eu_to",sim_base,"qi_cr")= 0;
r_cc("eu_to",sim_base,"qi_lv")= 0;
r_cc("eu_to",sim_base,"qi_fa")= 0;

*#*# Demand indices
r_cc(ccplus,sim_base,"qi_pl")$sum(pl, r_comm(ccplus,"base",pl,"r_pc")*r_comm(ccplus,"base",pl,"r_hdem"))=
sum(pl, r_comm(ccplus,"base",pl,"r_pc")*r_comm(ccplus,sim_base,pl,"r_hdem"))/
sum(pl, r_comm(ccplus,"base",pl,"r_pc")*r_comm(ccplus,"base",pl,"r_hdem"))*100;

r_cc(ccplus,sim_base,"qi_an")$sum(an, r_comm(ccplus,"base",an,"r_pc")*r_comm(ccplus,"base",an,"r_hdem"))=
sum(an, r_comm(ccplus,"base",an,"r_pc")*r_comm(ccplus,sim_base,an,"r_hdem"))/
sum(an, r_comm(ccplus,"base",an,"r_pc")*r_comm(ccplus,"base",an,"r_hdem"))*100;

r_cc(ccplus,sim_base,"qi_co")$sum(comm, r_comm(ccplus,"base",comm,"r_pc")*r_comm(ccplus,"base",comm,"r_hdem"))=
sum(comm, r_comm(ccplus,"base",comm,"r_pc")*r_comm(ccplus,sim_base,comm,"r_hdem"))/
sum(comm, r_comm(ccplus,"base",comm,"r_pc")*r_comm(ccplus,"base",comm,"r_hdem"))*100;

*#*#* In order to avoid misinterpretation the total EU indices are set back to zero
r_cc("eu_to",sim_base,"qi_pl")= 0;
r_cc("eu_to",sim_base,"qi_an")= 0;
r_cc("eu_to",sim_base,"qi_co")= 0;


*#* Product group value indices (base = 100)
*#*# Production value indices
r_cc(ccplus,sim_base,"vi_cr")$r_cc(ccplus,"base","val_cr")=
r_cc(ccplus,sim_base,"val_cr")/r_cc(ccplus,"base","val_cr")*100;

r_cc(ccplus,sim_base,"vi_lv")$r_cc(ccplus,"base","val_li")=
r_cc(ccplus,sim_base,"val_li")/r_cc(ccplus,"base","val_li")*100;

r_cc(ccplus,sim_base,"vi_fa")$r_cc(ccplus,"base","val_fa")=
r_cc(ccplus,sim_base,"val_fa")/r_cc(ccplus,"base","val_fa")*100;

*#*# Consumption value indices
r_cc(ccplus,sim_base,"vi_pl")$r_cc(ccplus,"base","val_pl")=
r_cc(ccplus,sim_base,"val_pl")/r_cc(ccplus,"base","val_pl")*100;

r_cc(ccplus,sim_base,"vi_an")$r_cc(ccplus,"base","val_an")=
r_cc(ccplus,sim_base,"val_an")/r_cc(ccplus,"base","val_an")*100;

r_cc(ccplus,sim_base,"vi_co")$r_cc(ccplus,"base","val_co")=
r_cc(ccplus,sim_base,"val_co")/r_cc(ccplus,"base","val_co")*100;

*#*#* In order to avoid misinterpretation the total EU indices are set back to zero
r_cc("eu_to",sim_base,"vi_pl")= 0;
r_cc("eu_to",sim_base,"vi_an")= 0;
r_cc("eu_to",sim_base,"vi_co")= 0;

r_cc("eu_to",sim_base,"vi_cr")= 0;
r_cc("eu_to",sim_base,"vi_lv")= 0;
r_cc("eu_to",sim_base,"vi_fa")= 0;

*#*#Export value index
r_cc(ccplus,sim_base,"vi_nx")$r_cc(ccplus,"base","val_nx")=
r_cc(ccplus,sim_base,"val_nx")/r_cc(ccplus,"base","val_nx")*100;

*#*#Price spread for oilseeds vs veg.oil and veg. oil vs biofuels

r_cc('EU',sim_base,"r_spr_roil")    = r_comm('EU_to',sim_base,'rapoil',"pi_pd") /
                                      r_comm('EU_to',sim_base,'rapseed',"pi_pd");

r_cc('EU',sim_base,"r_spr_soil")    = r_comm('EU_to',sim_base,'sunoil',"pi_pd") /
                                      r_comm('EU_to',sim_base,'sunseed',"pi_pd");

r_cc('EU',sim_base,"r_spr_soy")    = r_comm('EU_to',sim_base,'soyoil',"pi_pd") /
                                      r_comm('EU_to',sim_base,'soybean',"pi_pd");


r_cc('row',sim_base,"r_spr_roil")    = r_comm('row',sim_base,'rapoil',"pi_pd") /
                                      r_comm('row',sim_base,'rapseed',"pi_pd");

r_cc('row',sim_base,"r_spr_soil")    = r_comm('row',sim_base,'sunoil',"pi_pd") /
                                      r_comm('row',sim_base,'sunseed',"pi_pd");

r_cc('row',sim_base,"r_spr_soy")    = r_comm('row',sim_base,'soyoil',"pi_pd") /
                                      r_comm('row',sim_base,'soybean',"pi_pd");

r_cc('EU',sim_base,"r_spr_biod")    =    r_comm('EU_to',sim_base,'biodiesel',"pi_pd") /
                                       [SUM(i_diesel, r_comm('EU_to',sim_base,i_diesel,"pi_pd")*
                                       r_comm('EU_to',sim_base,i_diesel,"r_pdem")
                               /   SUM(i_diesel1, r_comm('EU_to',sim_base,i_diesel1,"r_pdem"))   )];


r_cc('EU',sim_base,"r_spr_eth")    =    r_comm('EU_to',sim_base,'ethanol',"pi_pd") /
                                    [SUM(i_ethanol, r_comm('EU_to',sim_base,i_ethanol,"pi_pd")*
                                       r_comm('EU_to',sim_base,i_ethanol,"r_pdem")
                               /   SUM(i_ethanol1, r_comm('EU_to',sim_base,i_ethanol1,"r_pdem"))   )];


r_cc('row',sim_base,"r_spr_biod")    =    r_comm('row',sim_base,'biodiesel',"pi_pd")/
                                      [SUM(i_diesel, r_comm('row',sim_base,i_diesel,"pi_pd")*
                                       r_comm('row',sim_base,i_diesel,"r_pdem")
                               /   SUM(i_diesel1, r_comm('row',sim_base,i_diesel1,"r_pdem"))   )];


r_cc('row',sim_base,"r_spr_eth")    = r_comm('row',sim_base,'ethanol',"pi_pd") /
                                         [SUM(i_ethanol, r_comm('row',sim_base,i_ethanol,"pi_pd")*
                                       r_comm('row',sim_base,i_ethanol,"r_pdem")
                               /   SUM(i_ethanol1, r_comm('row',sim_base,i_ethanol1,"r_pdem"))   )];

* 4) Budget (all budget positions in positive values)
*b_dpa    Product specific outlays for direct payments (including Art 68 and national top ups)(Mill. €)

*b_dp68   Product specific outlays for Art.68 69 payments (Mill. €)
*b_dptop  Product specific outlays for national top ups (Mill. €)
*b_dpEU   Product specific outlays for direct payments without national top ups (Mill. €)
*b_dpno68 Product specific outlays for direct payments without Art 68 69 payments (Mill. €)

*# Direct payments per product
*#* Country specific
r_comm(one,sim_base,crops,"b_dpa") =
r_comm(one,sim_base,crops,"r_dpay")*r_comm(one,sim_base,crops,"r_area")/1000;

r_comm(one,sim_base,livest,"b_dpa") =
r_comm(one,sim_base,livest,"r_dpay")*r_comm(one,sim_base,livest,"r_supp")/1000;

r_comm(one,sim_base,crops,"b_dp68") =
r_comm(one,sim_base,crops,"r_dp_68")*r_comm(one,sim_base,crops,"r_area")/1000;

r_comm(one,sim_base,livest,"b_dp68") =
r_comm(one,sim_base,livest,"r_dp_68")*r_comm(one,sim_base,livest,"r_supp")/1000;

r_comm(one,sim_base,crops,"b_dptop") =
r_comm(one,sim_base,crops,"r_dp_top")*r_comm(one,sim_base,crops,"r_area")/1000;

r_comm(one,sim_base,livest,"b_dptop") =
r_comm(one,sim_base,livest,"r_dp_top")*r_comm(one,sim_base,livest,"r_supp")/1000;

r_comm(one,sim_base,crops,"b_dpEU") =
r_comm(one,sim_base,crops,"r_dp_EU")*r_comm(one,sim_base,crops,"r_area")/1000;

r_comm(one,sim_base,livest,"b_dpEU") =
r_comm(one,sim_base,livest,"r_dp_EU")*r_comm(one,sim_base,livest,"r_supp")/1000;

r_comm(one,sim_base,crops,"b_dpno68") =
r_comm(one,sim_base,crops,"r_dp_no68")*r_comm(one,sim_base,crops,"r_area")/1000;

r_comm(one,sim_base,livest,"b_dpno68") =
r_comm(one,sim_base,livest,"r_dp_no68")*r_comm(one,sim_base,livest,"r_supp")/1000;

*#*# In the following lines the set aside payments for obligatory set aside area are included
r_comm(one,sim_base,"setaside","b_dpa") = r_comm(one,sim_base,"setaside","b_dpa")+
r_cc(one,sim_base,"r_obsa")* r_comm(one,sim_base,"setaside","r_dpay")/1000;

r_comm(one,sim_base,"setaside","b_dpEU") = r_comm(one,sim_base,"setaside","b_dpEU")+
r_cc(one,sim_base,"r_obsa")* r_comm(one,sim_base,"setaside","r_dp_EU")/1000;

r_comm(one,sim_base,"setaside","b_dpno68") = r_comm(one,sim_base,"setaside","b_dpno68")+
r_cc(one,sim_base,"r_obsa")* r_comm(one,sim_base,"setaside","r_dp_no68")/1000;


*#* For aggregate country groups
r_comm("eu_to",sim_base,comm,"b_dpa") =
sum(one $r_member(one,sim_base), r_comm(one,sim_base,comm,"b_dpa"));

r_comm("EU_15",sim_base,comm,"b_dpa") =
sum(EU15, r_comm(EU15,sim_base,comm,"b_dpa"));

r_comm("nms12",sim_base,comm,"b_dpa") =
sum(eu12, r_comm(eu12,sim_base,comm,"b_dpa"));

r_comm("ACC",sim_base,comm,"b_dpa") =
sum(cand, r_comm(cand,sim_base,comm,"b_dpa"));

r_comm("eu_to",sim_base,comm,"b_dp68") =
sum(one $r_member(one,sim_base), r_comm(one,sim_base,comm,"b_dp68"));

r_comm("EU_15",sim_base,comm,"b_dp68") =
sum(EU15, r_comm(EU15,sim_base,comm,"b_dp68"));

r_comm("nms12",sim_base,comm,"b_dp68") =
sum(eu12, r_comm(eu12,sim_base,comm,"b_dp68"));

r_comm("ACC",sim_base,comm,"b_dp68") =
sum(cand, r_comm(cand,sim_base,comm,"b_dp68"));

r_comm("eu_to",sim_base,comm,"b_dptop") =
sum(one $r_member(one,sim_base), r_comm(one,sim_base,comm,"b_dptop"));

r_comm("EU_15",sim_base,comm,"b_dptop") =
sum(EU15, r_comm(EU15,sim_base,comm,"b_dptop"));

r_comm("nms12",sim_base,comm,"b_dptop") =
sum(eu12, r_comm(eu12,sim_base,comm,"b_dptop"));

r_comm("ACC",sim_base,comm,"b_dptop") =
sum(cand, r_comm(cand,sim_base,comm,"b_dptop"));

r_comm("eu_to",sim_base,comm,"b_dpEU") =
sum(one $r_member(one,sim_base), r_comm(one,sim_base,comm,"b_dpEU"));

r_comm("EU_15",sim_base,comm,"b_dpEU") =
sum(EU15, r_comm(EU15,sim_base,comm,"b_dpEU"));

r_comm("nms12",sim_base,comm,"b_dpEU") =
sum(eu12, r_comm(eu12,sim_base,comm,"b_dpEU"));

r_comm("ACC",sim_base,comm,"b_dpEU") =
sum(cand, r_comm(cand,sim_base,comm,"b_dpEU"));

r_comm("eu_to",sim_base,comm,"b_dpno68") =
sum(one $r_member(one,sim_base), r_comm(one,sim_base,comm,"b_dpno68"));

r_comm("EU_15",sim_base,comm,"b_dpno68") =
sum(EU15, r_comm(EU15,sim_base,comm,"b_dpno68"));

r_comm("nms12",sim_base,comm,"b_dpno68") =
sum(eu12, r_comm(eu12,sim_base,comm,"b_dpno68"));

r_comm("ACC",sim_base,comm,"b_dpno68") =
sum(cand, r_comm(cand,sim_base,comm,"b_dpno68"));


*# Total direct payments per country
r_cc(ccplus,sim_base,"dpa_cc") =
sum(comm, r_comm(ccplus,sim_base,comm,"b_dpa"))
;

r_cc(ccplus,sim_base,"dp68_cc") =
sum(comm, r_comm(ccplus,sim_base,comm,"b_dp68"))
;

r_cc(ccplus,sim_base,"dpno68_cc") =
sum(comm, r_comm(ccplus,sim_base,comm,"b_dpno68"))
;

r_cc(ccplus,sim_base,"dptop_cc") =
sum(comm, r_comm(ccplus,sim_base,comm,"b_dptop"))
;

r_cc(ccplus,sim_base,"dpEU_cc") =
sum(comm, r_comm(ccplus,sim_base,comm,"b_dpEU"))
;

*# Outlays for product subsidies
*#* Product specific
*#*# For individual countries
r_comm(one,sim_base,comm,"b_sub") =
(r_comm(one,sim_base,comm,"r_hsub")*r_comm(one,sim_base,comm,"r_hdem")+
r_comm(one,sim_base,comm,"r_fsub")*r_comm(one,sim_base,comm,"r_fdem"))/1000;

*#*# For aggregate country groups
r_comm("eu_to",sim_base,comm,"b_sub") =
sum(one $r_member(one,sim_base), r_comm(one,sim_base,comm,"b_sub"));

r_comm("eu_15",sim_base,comm,"b_sub") =
sum(eu15, r_comm(eu15,sim_base,comm,"b_sub"));

r_comm("nms12",sim_base,comm,"b_sub") =
sum(eu12, r_comm(eu12,sim_base,comm,"b_sub"));

r_comm("ACC",sim_base,comm,"b_sub") =
sum(cand, r_comm(cand,sim_base,comm,"b_sub"));

*#* For all products per country
r_cc(ccplus,sim_base,"sub_cc") =
sum(comm, r_comm(ccplus,sim_base,comm,"b_sub"));


*# Calculation of stock changes and total stocks for the EU
*#* Stock changes
$ontext
Loop(sim_base,
Loop(it,
if(R_THR(sim_base,it)or R_INT(sim_base,it),
if((r_comm("eu_to",sim_base,it,"r_nx")+ SUM(EURO1, r_comm(EURO1,sim_base,it,"r_trq")) )gt ES_quant_t(sim_base,it),
r_comm("eu_to",sim_base,it,"d_stock") =
r_comm("eu_to",sim_base,it,"r_nx")+ SUM(EURO1, r_comm(EURO1,sim_base,it,"r_trq"))- ES_quant_t(sim_base,it)
else
r_comm("eu_to",sim_base,it,"d_stock")=0)
else
r_comm("eu_to",sim_base,it,"d_stock")=0);
));

*#* Accumulation of stocks
Loop(sim_base,
If (Ord(sim_base) eq 1,
r_comm("eu_to",sim_base,it,"stock")= r_comm("eu_to",sim_base,it,"d_stock")
else
r_comm("eu_to",sim_base,it,"stock")=
r_comm("eu_to",sim_base,it,"d_stock")+r_comm("eu_to",sim_base-1,it,"stock")
));
$offtext

*# Product specific tariffs and export subsidies
*#* Definition of world market price
*r_pw(sim_base,it)=r_comm("row",sim_base,it,"r_pd");
r_pw(sim_base,it) = r_comm('row',sim_base,it,"r_pw");
* r_pw is declared in $!

*#* For Accession candidates if they are non-members
 r_comm(cand,sim_base,it,"b_tar")$(r_comm(cand,sim_base,it,"r_nx") lt 0) =
   r_comm(cand,sim_base,it,"r_nx")*(r_comm(cand,sim_base,it,"r_pup")-r_comm("row",sim_base,it,"r_pd"))*(-1+r_cc(cand,sim_base,"r_memb"))/1000;
 r_comm(cand,sim_base,it,"b_exs")$(r_comm(cand,sim_base,it,"r_nx") lt 0) = 0;
 r_comm(cand,sim_base,it,"b_tar")$(NOT r_comm(cand,sim_base,it,"r_nx") lt 0) = 0;
 r_comm(cand,sim_base,it,"b_exs")$(NOT r_comm(cand,sim_base,it,"r_nx") lt 0) = r_comm(cand,sim_base,it,"r_nx")/1000*
   (r_comm(cand,sim_base,it,"r_plo")  - r_comm("row",sim_base,it,"r_pd"))*(1-r_cc(cand,sim_base,"r_memb"));



$ontext
Loop(cand,
Loop(sim_base,
Loop(it,
If(r_comm(cand,sim_base,it,"r_nx") lt 0,
r_comm(cand,sim_base,it,"b_tar") =
*r_comm(cand,sim_base,it,"r_nx")*(r_comm(cand,sim_base,it,"r_pup")-r_pw(sim_base,it))*(-1+r_cc(cand,sim_base,"r_memb"))/1000;
r_comm(cand,sim_base,it,"r_nx")*(r_comm(cand,sim_base,it,"r_pup")-r_comm("row",sim_base,it,"r_pd"))*(-1+r_cc(cand,sim_base,"r_memb"))/1000;




r_comm(cand,sim_base,it,"b_exs") = 0;

else
r_comm(cand,sim_base,it,"b_tar") = 0;

r_comm(cand,sim_base,it,"b_exs") = r_comm(cand,sim_base,it,"r_nx")/1000*
*(r_comm(cand,sim_base,it,"r_plo")  - r_pw(sim_base,it))*(1-r_cc(cand,sim_base,"r_memb"));
(r_comm(cand,sim_base,it,"r_plo")  - r_comm("row",sim_base,it,"r_pd"))*(1-r_cc(cand,sim_base,"r_memb"));

))));
$offtext



*#* For the EU

parameter tst_eu_nx(sim_base,it)  only a helper parameter;
 tst_eu_nx(sim_base,it) = r_comm("eu_to",sim_base,it,"r_nx")+SUM(EURO1, r_comm(EURO1,sim_base,it,"r_trq"));
* < 0:
 r_comm("eu_to",sim_base,it,"b_tar")$(tst_eu_nx(sim_base,it) lt 0) =
   -1*((r_comm("eu_to",sim_base,it,"r_nx")+SUM(EURO1, r_comm(EURO1,sim_base,it,"r_trq")))*
   (r_comm("ge",sim_base,it,"r_pup")  - r_comm("row",sim_base,it,"r_pd")))/1000;
 r_comm("eu_to",sim_base,it,"b_exs")$(tst_eu_nx(sim_base,it) lt 0) = 0;
* > 0:
 r_comm("eu_to",sim_base,it,"b_tar")$(tst_eu_nx(sim_base,it) gt 0) = 0;
 r_comm("eu_to",sim_base,it,"b_exs")$(tst_eu_nx(sim_base,it) gt 0) =
   (r_comm("eu_to",sim_base,it,"r_nx")+r_comm("eu_to",sim_base,it,"r_trq"))*
   (r_comm("eu_to",sim_base,it,"r_pd")  - r_comm("row",sim_base,it,"r_pd"))/1000;
* = 0:
 r_comm("eu_to",sim_base,it,"b_tar")$(tst_eu_nx(sim_base,it) eq 0) = 0;
 r_comm("eu_to",sim_base,it,"b_exs")$(tst_eu_nx(sim_base,it) eq 0) = 0;

$ontext
Loop(sim_base,
Loop(it,
If((r_comm("eu_to",sim_base,it,"r_nx")+SUM(EURO1, r_comm(EURO1,sim_base,it,"r_trq"))) lt 0,

r_comm("eu_to",sim_base,it,"b_tar") =
-1*((r_comm("eu_to",sim_base,it,"r_nx")+SUM(EURO1, r_comm(EURO1,sim_base,it,"r_trq")))*

(r_comm("ge",sim_base,it,"r_pup")  - r_comm("row",sim_base,it,"r_pd")))/1000;
r_comm("eu_to",sim_base,it,"b_exs") = 0;

else
If((r_comm("eu_to",sim_base,it,"r_nx")+SUM(EURO1, r_comm(EURO1,sim_base,it,"r_trq"))) gt 0                 ,
r_comm("eu_to",sim_base,it,"b_tar") = 0;


*If(R_TAR(sim_base,it),
r_comm("eu_to",sim_base,it,"b_exs") = (r_comm("eu_to",sim_base,it,"r_nx")+r_comm("eu_to",sim_base,it,"r_trq"))*
*(r_comm("eu_to",sim_base,it,"r_pd")  - r_pw(sim_base,it))/1000;
(r_comm("eu_to",sim_base,it,"r_pd")  - r_comm("row",sim_base,it,"r_pd"))/1000
*)
;
*If(R_THR(sim_base,it)or R_INT(sim_base,it),
*If((r_comm("eu_to",sim_base,it,"r_nx")+ SUM(EURO1, r_comm(EURO1,sim_base,it,"r_trq")))gt ES_quant_t(sim_base,it),
*r_comm("eu_to",sim_base,it,"b_exs") = ES_quant_t(sim_base,it)*
*(r_comm("eu_to",sim_base,it,"r_pd")  - r_pw(sim_base,it))/1000;
*(r_comm("eu_to",sim_base,it,"r_pd")  - r_comm("row",sim_base,it,"r_pd"))/1000;

*else
*r_comm("eu_to",sim_base,it,"b_exs") = (r_comm("eu_to",sim_base,it,"r_nx")+r_comm("eu_to",sim_base,it,"r_trq"))*
*(r_comm("eu_to",sim_base,it,"r_pd")  - r_pw(sim_base,it))/1000;
*(r_comm("eu_to",sim_base,it,"r_pd")  - r_comm("row",sim_base,it,"r_pd"))/1000;
*)
*)
else
r_comm("eu_to",sim_base,it,"b_tar") = 0;
r_comm("eu_to",sim_base,it,"b_exs") = 0;
)
)
));
$offtext
*#* Trade policies for all products per country
r_cc(ccplus,sim_base,"tar_cc") =
sum(comm, r_comm(ccplus,sim_base,comm,"b_tar"));

r_cc(ccplus,sim_base,"exs_cc") =
sum(comm, r_comm(ccplus,sim_base,comm,"b_exs"));


*# Total Esim budget
*#* Total Esim budget per product
r_comm(ccplus,sim_base,it,"b_tot")=
r_comm(ccplus,sim_base,it,"b_dpa") + r_comm(ccplus,sim_base,it,"b_sub")-
r_comm(ccplus,sim_base,it,"b_tar") + r_comm(ccplus,sim_base,it,"b_exs");

*#* Total Esim budget per country
r_cc(ccplus,sim_base,"tot_cc")=
r_cc(ccplus,sim_base,"dpa_cc") + r_cc(ccplus,sim_base,"sub_cc")-
r_cc(ccplus,sim_base,"tar_cc") + r_cc(ccplus,sim_base,"exs_cc");

* 5) Expenditure shares and compensated elasticities for welfare calculations
expenditure(cc)           = expen (cc, "expenditure");

exp_share(cc,comm)$expenditure(cc)        =
r_comm(cc,"base",comm,"r_pd")*r_comm(cc,"base",comm,"r_hdem")*1000/expenditure(cc);

elasthd_c(cc,comm,comm1)$expenditure(cc)  =
elasthd(cc,comm,comm1)+ exp_share(cc,comm1)*elastin(cc,comm);

texp_share(cc)$expenditure(cc) = sum(comm,exp_share(cc,comm));

* 6) Consumption per capita
$ontext
Population_sim(cc,sim_base) = popul_grw(cc,sim_base) * Population_b(cc,'base');
Population_sim('eu_to',sim_base) = SUM(cc$member(cc), popul_grw(cc,sim_base) * Population_b(cc,'base'));
Population_sim('eu_15',sim_base) = SUM(eu15, popul_grw(eu15,sim_base) * Population_b(eu15,'base'));
Population_sim('NMS12',sim_base) = SUM(eu12, popul_grw(eu12,sim_base) * Population_b(eu12,'base'));
Population_sim('ACC',sim_base) = SUM(cand, Population_sim(cand,sim_base) * Population_b(cand,'base'));
$offtext
Population_sim(cc,sim_base) = popul_grw_acc(cc,sim_base) * Population_b(cc,'base');
Population_sim('eu_to',sim_base) = SUM(cc$member(cc), popul_grw_acc(cc,sim_base) * Population_b(cc,'base'));
Population_sim('eu_15',sim_base) = SUM(eu15, popul_grw_acc(eu15,sim_base) * Population_b(eu15,'base'));
Population_sim('NMS12',sim_base) = SUM(eu12, popul_grw_acc(eu12,sim_base) * Population_b(eu12,'base'));
Population_sim('ACC',sim_base) = SUM(cand, Population_sim(cand,sim_base) * Population_b(cand,'base'));

r_comm(ccplus,sim_base,comm,'r_hdem_PC')$Population_sim(ccplus,sim_base) = r_comm(ccplus,sim_base,comm,"r_hdem") /  Population_sim(ccplus,sim_base);

* 7) Core results

* Flaeche
r_core_res(one,'area',crops,sim_base)    =  r_comm(one,sim_base,crops,"r_area");
* Ertrag (t/ha)
r_core_res(one,'yield',crops,sim_base)   =  r_comm(one,sim_base,crops,"r_yiel")/1000 ;
* supply
r_core_res(one,'supply',comm,sim_base)   = r_comm(one,sim_base,comm,"r_supp") ;
* human consumption
r_core_res(one,'human',comm,sim_base)   = r_comm(one,sim_base,comm,"r_hdem");
* processing demand
r_core_res(one,'process',comm,sim_base)   = r_comm(one,sim_base,comm,"r_pdem");
* feed use
r_core_res(one,'feed',comm,sim_base)     = r_comm(one,sim_base,comm,"r_fdem");
r_core_res(one,'feed','milk',sim_base)   = r_comm(one,sim_base,"milk","r_fdem") ;
* seed use
r_core_res(one,'seed',comm,sim_base)   = r_comm(one,sim_base,comm,"r_sdem");
* total use
r_core_res(one,'tot_use',comm,sim_base)   = r_comm(one,sim_base,comm,"r_tuse");
* net trade
r_core_res(one,'nettrad',comm,sim_base)   = r_comm(one,sim_base,comm,"r_nx");
* farmgate prices in EURO
r_core_res(one,'fag_pric',comm,sim_base)  = r_comm(one,sim_base,comm,"r_pp");
* wholesale prices in EURO
r_core_res(one,'whs_pric',comm,sim_base)  = r_comm(one,sim_base,comm,"r_pd");
