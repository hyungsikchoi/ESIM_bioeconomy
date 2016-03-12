*2) Aggregation per country group
*# Commodity specific results
*#* Aggregation over countries
r_comm("eu_to",sim_run,comm,res_agg) =
sum(one, r_comm(one,sim_run,comm,res_agg)*r_cc(one,sim_run,"r_memb"));

r_comm("eu_to",sim_run,'milk','r_fill')$sum(one, r_comm(one,sim_run,'milk',"r_quot") *r_cc(one,sim_run,"r_memb")) =
sum(one, (r_comm(one,sim_run,'milk','r_deliv')*r_cc(one,sim_run,"r_memb")))/
sum(one, r_comm(one,sim_run,'milk',"r_quot") *r_cc(one,sim_run,"r_memb")) *100;

r_comm("eu_15",sim_run,comm,res_agg) =
sum(eu15, r_comm(eu15,sim_run,comm,res_agg));

r_comm("eu_15",sim_run,'milk','r_fill')$sum(eu15, r_comm(eu15,sim_run,'milk',"r_quot"))=
sum(eu15, r_comm(eu15,sim_run,'milk','r_deliv'))/sum(eu15, r_comm(eu15,sim_run,'milk',"r_quot")) *100;

r_comm("nms12",sim_run,comm,res_agg) =
sum(eu12, r_comm(eu12,sim_run,comm,res_agg));

r_comm("nms12",sim_run,'milk','r_fill')$sum(eu12, r_comm(eu12,sim_run,'milk',"r_quot")) =
sum(eu12, r_comm(eu12,sim_run,'milk','r_deliv'))/sum(eu12, r_comm(eu12,sim_run,'milk',"r_quot")) *100;

r_comm("ACC",sim_run,comm,res_agg) =
SUM(cand, r_comm(cand,sim_run,comm,res_agg));

r_comm("acc",sim_run,'milk','r_fill')$sum(cand, r_comm(cand,sim_run,'milk',"r_quot")) =
sum(cand, r_comm(cand,sim_run,'milk','r_deliv'))/sum(cand, r_comm(cand,sim_run,'milk',"r_quot")) *100;


*#* Definition for those results for which total EU is identical to the EU 15
r_comm("eu_to",sim_run,comm,res_def) = SUM(EURO1, r_comm(EURO1,sim_run,comm,res_def));

*#* Definition for those results which are weighted averages (prices)
*#*# Results for Total EU
r_comm("eu_to",sim_run,comm,"r_pd") $(sum(one,r_comm(one,sim_run,comm,"r_tuse")) gt 0) =
sum(one $r_member(one,sim_run), r_comm(one,sim_run,comm,"r_pd")*
r_comm(one,"base",comm,"r_tuse")/sum(one1$r_member(one1,sim_run),r_comm(one1,"base",comm,"r_tuse")));

r_comm("eu_to",sim_run,comm,"r_pc") $(sum(one,r_comm(one,sim_run,comm,"r_tuse")) gt 0) =
sum(one $r_member(one,sim_run), r_comm(one,sim_run,comm,"r_pc")*
r_comm(one,"base",comm,"r_tuse")/sum(one1 $r_member(one1,sim_run),r_comm(one1,"base",comm,"r_tuse")));

r_comm("eu_to",sim_run,comm,"r_pp") $(sum(one,r_comm(one,sim_run,comm,"r_supp")) gt 0) =
sum(one $r_member(one,sim_run), r_comm(one,sim_run,comm,"r_pp")*
r_comm(one,"base",comm,"r_supp")/sum(one1 $r_member(one1,sim_run),r_comm(one1,"base",comm,"r_supp")));

r_comm("eu_to",sim_run,comm,"r_inc") $(sum(one,r_comm(one,sim_run,comm,"r_supp")) gt 0) =
sum(one $r_member(one,sim_run), r_comm(one,sim_run,comm,"r_inc")*
r_comm(one,"base",comm,"r_supp")/sum(one1 $r_member(one1,sim_run),r_comm(one1,"base",comm,"r_supp")));

r_comm("eu_to",sim_run,livest,"r_fci") $ (sum(one,r_comm(one,sim_run,livest,"r_supp")) gt 0) =
sum(one $r_member(one,sim_run), r_comm(one,sim_run,livest,"r_fci")*
r_comm(one,"base",livest,"r_supp")/sum(one1 $r_member(one1,sim_run),r_comm(one1,"base",livest,"r_supp")));

*#*# Results for EU 15
r_comm("eu_15",sim_run,comm,"r_pd") $ (sum(eu15,r_comm(eu15,sim_run,comm,"r_tuse")) gt 0) =
sum(eu15, r_comm(eu15,sim_run,comm,"r_pd")*
r_comm(eu15,"base",comm,"r_tuse")/sum(eu15_1,r_comm(eu15_1,"base",comm,"r_tuse")));

r_comm("eu_15",sim_run,comm,"r_pc") $ (sum(eu15,r_comm(eu15,sim_run,comm,"r_tuse")) gt 0) =
sum(eu15, r_comm(eu15,sim_run,comm,"r_pc")*
r_comm(eu15,"base",comm,"r_tuse")/sum(eu15_1,r_comm(eu15_1,"base",comm,"r_tuse")));

r_comm("eu_15",sim_run,comm,"r_pp") $ (sum(eu15,r_comm(eu15,sim_run,comm,"r_supp")) gt 0) =
sum(eu15, r_comm(eu15,sim_run,comm,"r_pp")*
r_comm(eu15,"base",comm,"r_supp")/sum(eu15_1,r_comm(eu15_1,"base",comm,"r_supp")));

r_comm("eu_15",sim_run,comm,"r_inc") $ (sum(eu15,r_comm(eu15,sim_run,comm,"r_supp")) gt 0) =
sum(eu15, r_comm(eu15,sim_run,comm,"r_inc")*
r_comm(eu15,"base",comm,"r_supp")/sum(eu15_1,r_comm(eu15_1,"base",comm,"r_supp")));

r_comm("eu_15",sim_run,livest,"r_fci") $ (sum(eu15,r_comm(eu15,sim_run,livest,"r_supp")) gt 0) =
sum(eu15, r_comm(eu15,sim_run,livest,"r_fci")*
r_comm(eu15,"base",livest,"r_supp")/sum(eu15_1,r_comm(eu15_1,"base",livest,"r_supp")));

*#*# Results for NMS 12
r_comm("nms12",sim_run,comm,"r_pd") $ (sum(eu12,r_comm(eu12,sim_run,comm,"r_tuse")) gt 0) =
sum(eu12, r_comm(eu12,sim_run,comm,"r_pd")*
r_comm(eu12,"base",comm,"r_tuse")/sum(eu12_1,r_comm(eu12_1,"base",comm,"r_tuse")));

r_comm("nms12",sim_run,comm,"r_pc") $ (sum(eu12,r_comm(eu12,sim_run,comm,"r_tuse")) gt 0) =
sum(eu12, r_comm(eu12,sim_run,comm,"r_pc")*
r_comm(eu12,"base",comm,"r_tuse")/sum(eu12_1,r_comm(eu12_1,"base",comm,"r_tuse")));

r_comm("nms12",sim_run,comm,"r_pp") $ (sum(eu12,r_comm(eu12,sim_run,comm,"r_supp")) gt 0) =
sum(eu12, r_comm(eu12,sim_run,comm,"r_pp")*
r_comm(eu12,"base",comm,"r_supp")/sum(eu12_1,r_comm(eu12_1,"base",comm,"r_supp")));

r_comm("nms12",sim_run,comm,"r_inc") $ (sum(eu12,r_comm(eu12,sim_run,comm,"r_supp")) gt 0) =
sum(eu12, r_comm(eu12,sim_run,comm,"r_inc")*
r_comm(eu12,"base",comm,"r_supp")/sum(eu12_1,r_comm(eu12_1,"base",comm,"r_supp")));

r_comm("nms12",sim_run,livest,"r_fci") $ (sum(eu12,r_comm(eu12,sim_run,livest,"r_supp")) gt 0) =
sum(eu12, r_comm(eu12,sim_run,livest,"r_fci")*
r_comm(eu12,"base",livest,"r_supp")/sum(eu12_1,r_comm(eu12_1,"base",livest,"r_supp")));



*# Non-commodity specific results
*#* Aggregation over countries
r_cc("eu_to",sim_run,res_agg_cc) =
sum(one, r_cc(one,sim_run,res_agg_cc)*r_cc(one,sim_run,"r_memb"));

r_cc("eu_15",sim_run,res_agg_cc) =
sum(eu15, r_cc(eu15,sim_run,res_agg_cc));

r_cc("nms12",sim_run,res_agg_cc) =
sum(eu12, r_cc(eu12,sim_run,res_agg_cc));

