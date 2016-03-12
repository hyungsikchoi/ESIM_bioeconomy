set obl / OBLSETA/;

Parameters

r_eu_pr
r_eu_yl
r_eu_ar
r_eu_hd
r_eu_prd
r_eu_fd
r_eu_sd
r_eu_nx
r_eu_pd
r_eu_trq
r_eu_expsubs
r_eu_oblset
r_eu_dirpay
r_eu_dirpay_c
r_eu_dirpay_d

r_pol_pr
r_pol_yl
r_pol_ar
r_pol_hd
r_pol_prd
r_pol_fd
r_pol_sd
r_pol_nx
r_pol_pd
r_pol_oblset
r_pol_dirpay
r_pol_dirpay_c
r_pol_dirpay_d

r_hu_pr
r_hu_yl
r_hu_ar
r_hu_hd
r_hu_prd
r_hu_fd
r_hu_sd
r_hu_nx
r_hu_pd
r_hu_oblset

r_cz_pr
r_cz_yl
r_cz_ar
r_cz_hd
r_cz_prd
r_cz_fd
r_cz_sd
r_cz_nx
r_cz_pd
r_cz_oblset

r_ro_pr
r_ro_yl
r_ro_ar
r_ro_hd
r_ro_prd
r_ro_fd
r_ro_sd
r_ro_nx
r_ro_pd
r_ro_oblset

r_bg_pr
r_bg_yl
r_bg_ar
r_bg_hd
r_bg_prd
r_bg_fd
r_bg_sd
r_bg_nx
r_bg_pd
r_bg_oblset

r_ee_pr
r_ee_yl
r_ee_ar
r_ee_hd
r_ee_prd
r_ee_fd
r_ee_sd
r_ee_nx
r_ee_pd
r_ee_oblset

r_lt_pr
r_lt_yl
r_lt_ar
r_lt_hd
r_lt_prd
r_lt_fd
r_lt_sd
r_lt_nx
r_lt_pd
r_lt_oblset

r_lv_pr
r_lv_yl
r_lv_ar
r_lv_hd
r_lv_prd
r_lv_fd
r_lv_sd
r_lv_nx
r_lv_pd
r_lv_oblset

r_sl_pr
r_sl_yl
r_sl_ar
r_sl_hd
r_sl_prd
r_sl_fd
r_sl_sd
r_sl_nx
r_sl_pd
r_sl_oblset

r_si_pr
r_si_yl
r_si_ar
r_si_hd
r_si_prd
r_si_fd
r_si_sd
r_si_nx
r_si_pd
r_si_oblset

r_cy_pr
r_cy_yl
r_cy_ar
r_cy_hd
r_cy_prd
r_cy_fd
r_cy_sd
r_cy_nx
r_cy_pd
r_cy_oblset

r_mt_pr
r_mt_yl
r_mt_ar
r_mt_hd
r_mt_prd
r_mt_fd
r_mt_sd
r_mt_nx
r_mt_pd
r_mt_oblset

r_tu_pr
r_tu_yl
r_tu_ar
r_tu_hd
r_tu_prd
r_tu_fd
r_tu_sd
r_tu_nx
r_tu_pd
r_tu_oblset

pw_sim_1
;

pw_sim_1(sim,it)  =     RESULTS("row","pd",sim,it) ;

****  Results for the Level of World Prices

$libinclude xlexport pw_sim_1   .\output\base\eu15.xls pwm

****  Results for the EU-15

r_eu_pr(sim,comm)   =   RESULTS("eu","prod",sim,comm) ;
r_eu_yl(sim,crops)  =   RESULTS("eu","yld",sim,crops)  ;
r_eu_ar(sim,crops)  =   RESULTS("eu","area",sim,crops) ;
r_eu_hd(sim,comm)   =   RESULTS("eu","hdem",sim,comm) ;
r_eu_sd(sim,comm)   =   RESULTS("eu","sdem",sim,comm) ;
r_eu_fd(sim,comm)   =   RESULTS("eu","fdem",sim,comm) ;
r_eu_prd(sim,comm)  =   RESULTS("eu","pdem",sim,comm) ;
r_eu_nx(sim,comm)   =   RESULTS("eu","netexp",sim,comm) ;
r_eu_pd(sim,comm)   =   RESULTS("eu","pd",sim,comm) ;
r_eu_trq(sim,comm)   =   RESULTS("eu","trq",sim,comm) ;
r_eu_expsubs(sim,comm)   =  RESULTS("eu","SUBSQU",sim,comm) ;
r_eu_oblset(sim,obl)     =  RESULTS("eu","AREA",SIM,"OBLSETA");
r_eu_dirpay(sim,comm)    =  RESULTS("eu","DIRPAY",SIM,COMM) ;
r_eu_dirpay_c(sim,comm)  =  RESULTS("eu","DP_C",SIM,COMM) ;
r_eu_dirpay_d(sim,comm)  =  RESULTS("eu","DP_D",SIM,COMM) ;

$libinclude xlexport r_eu_pr   .\output\base\eu15.xls supply
$libinclude xlexport r_eu_yl   .\output\base\eu15.xls yield
$libinclude xlexport r_eu_ar   .\output\base\eu15.xls area
$libinclude xlexport r_eu_hd   .\output\base\eu15.xls hdem
$libinclude xlexport r_eu_prd  .\output\base\eu15.xls pdem
$libinclude xlexport r_eu_sd   .\output\base\eu15.xls sdem
$libinclude xlexport r_eu_fd   .\output\base\eu15.xls fdem
$libinclude xlexport r_eu_nx   .\output\base\eu15.xls nx
$libinclude xlexport r_eu_pd   .\output\base\eu15.xls pd
$libinclude xlexport r_eu_trq   .\output\base\eu15.xls trq_eu

$libinclude xlexport r_eu_dirpay   .\output\base\eu15.xls dp_eu
$libinclude xlexport r_eu_dirpay_c   .\output\base\eu15.xls dpc_eu
$libinclude xlexport r_eu_dirpay_d   .\output\base\eu15.xls dpd_eu

$libinclude xlexport r_eu_expsubs   .\output\base\eu15.xls exps_eu
$libinclude xlexport r_eu_oblset   .\output\base\eu15.xls obl_eu


****  Results for Poland

r_pol_pr(sim,comm)   =   RESULTS("pl","prod",sim,comm) ;
r_pol_yl(sim,crops)  =   RESULTS("pl","yld",sim,crops)  ;
r_pol_ar(sim,crops)  =   RESULTS("pl","area",sim,crops) ;
r_pol_hd(sim,comm)   =   RESULTS("pl","hdem",sim,comm) ;
r_pol_sd(sim,comm)   =   RESULTS("pl","sdem",sim,comm) ;
r_pol_fd(sim,comm)   =   RESULTS("pl","fdem",sim,comm) ;
r_pol_prd(sim,comm)  =   RESULTS("pl","pdem",sim,comm) ;
r_pol_nx(sim,comm)   =   RESULTS("pl","netexp",sim,comm) ;
r_pol_pd(sim,comm)   =   RESULTS("pl","pd",sim,comm) ;
r_pol_oblset(sim,obl) =  RESULTS("pl","AREA",SIM,"OBLSETA");
r_pol_dirpay(sim,comm)    =  RESULTS("pl","DIRPAY",SIM,COMM) ;
r_pol_dirpay_c(sim,comm)  =  RESULTS("pl","DP_C",SIM,COMM) ;
r_pol_dirpay_d(sim,comm)  =  RESULTS("pl","DP_D",SIM,COMM) ;


$libinclude xlexport r_pol_pr   .\output\base\poland.xls supply
$libinclude xlexport r_pol_yl   .\output\base\poland.xls yield
$libinclude xlexport r_pol_ar   .\output\base\poland.xls area
$libinclude xlexport r_pol_hd   .\output\base\poland.xls hdem
$libinclude xlexport r_pol_prd  .\output\base\poland.xls pdem
$libinclude xlexport r_pol_sd   .\output\base\poland.xls sdem
$libinclude xlexport r_pol_fd   .\output\base\poland.xls fdem
$libinclude xlexport r_pol_nx   .\output\base\poland.xls nx
$libinclude xlexport r_pol_pd   .\output\base\poland.xls pd

$libinclude xlexport r_pol_oblset   .\output\base\poland.xls obl

$libinclude xlexport r_pol_dirpay   .\output\base\poland.xls dp
$libinclude xlexport r_pol_dirpay_c   .\output\base\poland.xls dpc
$libinclude xlexport r_pol_dirpay_d   .\output\base\poland.xls dpd


****  Results for Hungary

r_hu_pr(sim,comm)   =   RESULTS("hu","prod",sim,comm) ;
r_hu_yl(sim,crops)  =   RESULTS("hu","yld",sim,crops)  ;
r_hu_ar(sim,crops)  =   RESULTS("hu","area",sim,crops) ;
r_hu_hd(sim,comm)   =   RESULTS("hu","hdem",sim,comm) ;
r_hu_sd(sim,comm)   =   RESULTS("hu","sdem",sim,comm) ;
r_hu_fd(sim,comm)   =   RESULTS("hu","fdem",sim,comm) ;
r_hu_prd(sim,comm)  =   RESULTS("hu","pdem",sim,comm) ;
r_hu_nx(sim,comm)   =   RESULTS("hu","netexp",sim,comm) ;
r_hu_pd(sim,comm)   =   RESULTS("hu","pd",sim,comm) ;
r_hu_oblset(sim,obl) =  RESULTS("hu","AREA",SIM,"OBLSETA");


$libinclude xlexport r_hu_pr   .\output\base\hungary.xls supply
$libinclude xlexport r_hu_yl   .\output\base\hungary.xls yield
$libinclude xlexport r_hu_ar   .\output\base\hungary.xls area
$libinclude xlexport r_hu_hd   .\output\base\hungary.xls hdem
$libinclude xlexport r_hu_prd  .\output\base\hungary.xls pdem
$libinclude xlexport r_hu_sd   .\output\base\hungary.xls sdem
$libinclude xlexport r_hu_fd   .\output\base\hungary.xls fdem
$libinclude xlexport r_hu_nx   .\output\base\hungary.xls nx
$libinclude xlexport r_hu_pd   .\output\base\hungary.xls pd

$libinclude xlexport r_hu_oblset   .\output\base\hungary.xls obl



****  Results for the Czech Republic

r_cz_pr(sim,comm)   =   RESULTS("cz","prod",sim,comm) ;
r_cz_yl(sim,crops)  =   RESULTS("cz","yld",sim,crops)  ;
r_cz_ar(sim,crops)  =   RESULTS("cz","area",sim,crops) ;
r_cz_hd(sim,comm)   =   RESULTS("cz","hdem",sim,comm) ;
r_cz_sd(sim,comm)   =   RESULTS("cz","sdem",sim,comm) ;
r_cz_fd(sim,comm)   =   RESULTS("cz","fdem",sim,comm) ;
r_cz_prd(sim,comm)  =   RESULTS("cz","pdem",sim,comm) ;
r_cz_nx(sim,comm)   =   RESULTS("cz","netexp",sim,comm) ;
r_cz_pd(sim,comm)   =   RESULTS("cz","pd",sim,comm) ;
r_cz_oblset(sim,obl) =  RESULTS("cz","AREA",SIM,"OBLSETA");


$libinclude xlexport r_cz_pr   .\output\base\czech.xls supply
$libinclude xlexport r_cz_yl   .\output\base\czech.xls yield
$libinclude xlexport r_cz_ar   .\output\base\czech.xls area
$libinclude xlexport r_cz_hd   .\output\base\czech.xls hdem
$libinclude xlexport r_cz_prd  .\output\base\czech.xls pdem
$libinclude xlexport r_cz_sd   .\output\base\czech.xls sdem
$libinclude xlexport r_cz_fd   .\output\base\czech.xls fdem
$libinclude xlexport r_cz_nx   .\output\base\czech.xls nx
$libinclude xlexport r_cz_pd   .\output\base\czech.xls pd

$libinclude xlexport r_cz_oblset   .\output\base\czech.xls obl

****  Results for Romania

r_ro_pr(sim,comm)   =   RESULTS("ro","prod",sim,comm) ;
r_ro_yl(sim,crops)  =   RESULTS("ro","yld",sim,crops)  ;
r_ro_ar(sim,crops)  =   RESULTS("ro","area",sim,crops) ;
r_ro_hd(sim,comm)   =   RESULTS("ro","hdem",sim,comm) ;
r_ro_sd(sim,comm)   =   RESULTS("ro","sdem",sim,comm) ;
r_ro_fd(sim,comm)   =   RESULTS("ro","fdem",sim,comm) ;
r_ro_prd(sim,comm)  =   RESULTS("ro","pdem",sim,comm) ;
r_ro_nx(sim,comm)   =   RESULTS("ro","netexp",sim,comm) ;
r_ro_pd(sim,comm)   =   RESULTS("ro","pd",sim,comm) ;
r_ro_oblset(sim,obl) =  RESULTS("ro","AREA",SIM,"OBLSETA");


$libinclude xlexport r_ro_pr   .\output\base\romania.xls supply
$libinclude xlexport r_ro_yl   .\output\base\romania.xls yield
$libinclude xlexport r_ro_ar   .\output\base\romania.xls area
$libinclude xlexport r_ro_hd   .\output\base\romania.xls hdem
$libinclude xlexport r_ro_prd  .\output\base\romania.xls pdem
$libinclude xlexport r_ro_sd   .\output\base\romania.xls sdem
$libinclude xlexport r_ro_fd   .\output\base\romania.xls fdem
$libinclude xlexport r_ro_nx   .\output\base\romania.xls nx
$libinclude xlexport r_ro_pd   .\output\base\romania.xls pd

$libinclude xlexport r_ro_oblset   .\output\base\romania.xls obl

****  Results for Bulgaria

r_bg_pr(sim,comm)   =   RESULTS("bg","prod",sim,comm) ;
r_bg_yl(sim,crops)  =   RESULTS("bg","yld",sim,crops)  ;
r_bg_ar(sim,crops)  =   RESULTS("bg","area",sim,crops) ;
r_bg_hd(sim,comm)   =   RESULTS("bg","hdem",sim,comm) ;
r_bg_sd(sim,comm)   =   RESULTS("bg","sdem",sim,comm) ;
r_bg_fd(sim,comm)   =   RESULTS("bg","fdem",sim,comm) ;
r_bg_prd(sim,comm)  =   RESULTS("bg","pdem",sim,comm) ;
r_bg_nx(sim,comm)   =   RESULTS("bg","netexp",sim,comm) ;
r_bg_pd(sim,comm)   =   RESULTS("bg","pd",sim,comm) ;
r_bg_oblset(sim,obl) =  RESULTS("bg","AREA",SIM,"OBLSETA");


$libinclude xlexport r_bg_pr   .\output\base\bulgaria.xls supply
$libinclude xlexport r_bg_yl   .\output\base\bulgaria.xls yield
$libinclude xlexport r_bg_ar   .\output\base\bulgaria.xls area
$libinclude xlexport r_bg_hd   .\output\base\bulgaria.xls hdem
$libinclude xlexport r_bg_prd  .\output\base\bulgaria.xls pdem
$libinclude xlexport r_bg_sd   .\output\base\bulgaria.xls sdem
$libinclude xlexport r_bg_fd   .\output\base\bulgaria.xls fdem
$libinclude xlexport r_bg_nx   .\output\base\bulgaria.xls nx
$libinclude xlexport r_bg_pd   .\output\base\bulgaria.xls pd

$libinclude xlexport r_bg_oblset   .\output\base\bulgaria.xls obl

****  Results for Estonia

r_ee_pr(sim,comm)   =   RESULTS("ee","prod",sim,comm) ;
r_ee_yl(sim,crops)  =   RESULTS("ee","yld",sim,crops)  ;
r_ee_ar(sim,crops)  =   RESULTS("ee","area",sim,crops) ;
r_ee_hd(sim,comm)   =   RESULTS("ee","hdem",sim,comm) ;
r_ee_sd(sim,comm)   =   RESULTS("ee","sdem",sim,comm) ;
r_ee_fd(sim,comm)   =   RESULTS("ee","fdem",sim,comm) ;
r_ee_prd(sim,comm)  =   RESULTS("ee","pdem",sim,comm) ;
r_ee_nx(sim,comm)   =   RESULTS("ee","netexp",sim,comm) ;
r_ee_pd(sim,comm)   =   RESULTS("ee","pd",sim,comm) ;
r_ee_oblset(sim,obl) =  RESULTS("ee","AREA",SIM,"OBLSETA");


$libinclude xlexport r_ee_pr   .\output\base\estonia.xls supply
$libinclude xlexport r_ee_yl   .\output\base\estonia.xls yield
$libinclude xlexport r_ee_ar   .\output\base\estonia.xls area
$libinclude xlexport r_ee_hd   .\output\base\estonia.xls hdem
$libinclude xlexport r_ee_prd  .\output\base\estonia.xls pdem
$libinclude xlexport r_ee_sd   .\output\base\estonia.xls sdem
$libinclude xlexport r_ee_fd   .\output\base\estonia.xls fdem
$libinclude xlexport r_ee_nx   .\output\base\estonia.xls nx
$libinclude xlexport r_ee_pd   .\output\base\estonia.xls pd

$libinclude xlexport r_ee_oblset   .\output\base\estonia.xls obl

****  Results for Slovenia

r_si_pr(sim,comm)   =   RESULTS("si","prod",sim,comm) ;
r_si_yl(sim,crops)  =   RESULTS("si","yld",sim,crops)  ;
r_si_ar(sim,crops)  =   RESULTS("si","area",sim,crops) ;
r_si_hd(sim,comm)   =   RESULTS("si","hdem",sim,comm) ;
r_si_sd(sim,comm)   =   RESULTS("si","sdem",sim,comm) ;
r_si_fd(sim,comm)   =   RESULTS("si","fdem",sim,comm) ;
r_si_prd(sim,comm)  =   RESULTS("si","pdem",sim,comm) ;
r_si_nx(sim,comm)   =   RESULTS("si","netexp",sim,comm) ;
r_si_pd(sim,comm)   =   RESULTS("si","pd",sim,comm) ;
r_si_oblset(sim,obl) =  RESULTS("si","AREA",SIM,"OBLSETA");


$libinclude xlexport r_si_pr   .\output\base\slovenia.xls supply
$libinclude xlexport r_si_yl   .\output\base\slovenia.xls yield
$libinclude xlexport r_si_ar   .\output\base\slovenia.xls area
$libinclude xlexport r_si_hd   .\output\base\slovenia.xls hdem
$libinclude xlexport r_si_prd  .\output\base\slovenia.xls pdem
$libinclude xlexport r_si_sd   .\output\base\slovenia.xls sdem
$libinclude xlexport r_si_fd   .\output\base\slovenia.xls fdem
$libinclude xlexport r_si_nx   .\output\base\slovenia.xls nx
$libinclude xlexport r_si_pd   .\output\base\slovenia.xls pd

$libinclude xlexport r_si_oblset   .\output\base\slovenia.xls obl

****  Results for Slovak Republic

r_sl_pr(sim,comm)   =   RESULTS("sk","prod",sim,comm) ;
r_sl_yl(sim,crops)  =   RESULTS("sk","yld",sim,crops)  ;
r_sl_ar(sim,crops)  =   RESULTS("sk","area",sim,crops) ;
r_sl_hd(sim,comm)   =   RESULTS("sk","hdem",sim,comm) ;
r_sl_sd(sim,comm)   =   RESULTS("sk","sdem",sim,comm) ;
r_sl_fd(sim,comm)   =   RESULTS("sk","fdem",sim,comm) ;
r_sl_prd(sim,comm)  =   RESULTS("sk","pdem",sim,comm) ;
r_sl_nx(sim,comm)   =   RESULTS("sk","netexp",sim,comm) ;
r_sl_pd(sim,comm)   =   RESULTS("sk","pd",sim,comm) ;
r_sl_oblset(sim,obl) =  RESULTS("sk","AREA",SIM,"OBLSETA");


$libinclude xlexport r_sl_pr   .\output\base\slovakia.xls supply
$libinclude xlexport r_sl_yl   .\output\base\slovakia.xls yield
$libinclude xlexport r_sl_ar   .\output\base\slovakia.xls area
$libinclude xlexport r_sl_hd   .\output\base\slovakia.xls hdem
$libinclude xlexport r_sl_prd  .\output\base\slovakia.xls pdem
$libinclude xlexport r_sl_sd   .\output\base\slovakia.xls sdem
$libinclude xlexport r_sl_fd   .\output\base\slovakia.xls fdem
$libinclude xlexport r_sl_nx   .\output\base\slovakia.xls nx
$libinclude xlexport r_sl_pd   .\output\base\slovakia.xls pd

$libinclude xlexport r_sl_oblset   .\output\base\slovakia.xls obl

****  Results for Latvia

r_lv_pr(sim,comm)   =   RESULTS("lv","prod",sim,comm) ;
r_lv_yl(sim,crops)  =   RESULTS("lv","yld",sim,crops)  ;
r_lv_ar(sim,crops)  =   RESULTS("lv","area",sim,crops) ;
r_lv_hd(sim,comm)   =   RESULTS("lv","hdem",sim,comm) ;
r_lv_sd(sim,comm)   =   RESULTS("lv","sdem",sim,comm) ;
r_lv_fd(sim,comm)   =   RESULTS("lv","fdem",sim,comm) ;
r_lv_prd(sim,comm)  =   RESULTS("lv","pdem",sim,comm) ;
r_lv_nx(sim,comm)   =   RESULTS("lv","netexp",sim,comm) ;
r_lv_pd(sim,comm)   =   RESULTS("lv","pd",sim,comm) ;
r_lv_oblset(sim,obl) =  RESULTS("lv","AREA",SIM,"OBLSETA");


$libinclude xlexport r_lv_pr   .\output\base\latvia.xls supply
$libinclude xlexport r_lv_yl   .\output\base\latvia.xls yield
$libinclude xlexport r_lv_ar   .\output\base\latvia.xls area
$libinclude xlexport r_lv_hd   .\output\base\latvia.xls hdem
$libinclude xlexport r_lv_prd  .\output\base\latvia.xls pdem
$libinclude xlexport r_lv_sd   .\output\base\latvia.xls sdem
$libinclude xlexport r_lv_fd   .\output\base\latvia.xls fdem
$libinclude xlexport r_lv_nx   .\output\base\latvia.xls nx
$libinclude xlexport r_lv_pd   .\output\base\latvia.xls pd

$libinclude xlexport r_lv_oblset   .\output\base\latvia.xls obl

****  Results for Lithuania

r_lt_pr(sim,comm)   =   RESULTS("lt","prod",sim,comm) ;
r_lt_yl(sim,crops)  =   RESULTS("lt","yld",sim,crops)  ;
r_lt_ar(sim,crops)  =   RESULTS("lt","area",sim,crops) ;
r_lt_hd(sim,comm)   =   RESULTS("lt","hdem",sim,comm) ;
r_lt_sd(sim,comm)   =   RESULTS("lt","sdem",sim,comm) ;
r_lt_fd(sim,comm)   =   RESULTS("lt","fdem",sim,comm) ;
r_lt_prd(sim,comm)  =   RESULTS("lt","pdem",sim,comm) ;
r_lt_nx(sim,comm)   =   RESULTS("lt","netexp",sim,comm) ;
r_lt_pd(sim,comm)   =   RESULTS("lt","pd",sim,comm) ;
r_lt_oblset(sim,obl) =  RESULTS("lt","AREA",SIM,"OBLSETA");


$libinclude xlexport r_lt_pr   .\output\base\lithuania.xls supply
$libinclude xlexport r_lt_yl   .\output\base\lithuania.xls yield
$libinclude xlexport r_lt_ar   .\output\base\lithuania.xls area
$libinclude xlexport r_lt_hd   .\output\base\lithuania.xls hdem
$libinclude xlexport r_lt_prd  .\output\base\lithuania.xls pdem
$libinclude xlexport r_lt_sd   .\output\base\lithuania.xls sdem
$libinclude xlexport r_lt_fd   .\output\base\lithuania.xls fdem
$libinclude xlexport r_lt_nx   .\output\base\lithuania.xls nx
$libinclude xlexport r_lt_pd   .\output\base\lithuania.xls pd

$libinclude xlexport r_lt_oblset   .\output\base\lithuania.xls obl

****  Results for Cyprus

r_cy_pr(sim,comm)   =   RESULTS("cy","prod",sim,comm) ;
r_cy_yl(sim,crops)  =   RESULTS("cy","yld",sim,crops)  ;
r_cy_ar(sim,crops)  =   RESULTS("cy","area",sim,crops) ;
r_cy_hd(sim,comm)   =   RESULTS("cy","hdem",sim,comm) ;
r_cy_sd(sim,comm)   =   RESULTS("cy","sdem",sim,comm) ;
r_cy_fd(sim,comm)   =   RESULTS("cy","fdem",sim,comm) ;
r_cy_prd(sim,comm)  =   RESULTS("cy","pdem",sim,comm) ;
r_cy_nx(sim,comm)   =   RESULTS("cy","netexp",sim,comm) ;
r_cy_pd(sim,comm)   =   RESULTS("cy","pd",sim,comm) ;
r_cy_oblset(sim,obl) =  RESULTS("cy","AREA",SIM,"OBLSETA");


$libinclude xlexport r_cy_pr   .\output\base\cyprus.xls supply
$libinclude xlexport r_cy_yl   .\output\base\cyprus.xls yield
$libinclude xlexport r_cy_ar   .\output\base\cyprus.xls area
$libinclude xlexport r_cy_hd   .\output\base\cyprus.xls hdem
$libinclude xlexport r_cy_prd  .\output\base\cyprus.xls pdem
$libinclude xlexport r_cy_sd   .\output\base\cyprus.xls sdem
$libinclude xlexport r_cy_fd   .\output\base\cyprus.xls fdem
$libinclude xlexport r_cy_nx   .\output\base\cyprus.xls nx
$libinclude xlexport r_cy_pd   .\output\base\cyprus.xls pd

$libinclude xlexport r_cy_oblset   .\output\base\cyprus.xls obl

****  Results for Malta

r_mt_pr(sim,comm)   =   RESULTS("mt","prod",sim,comm) ;
r_mt_yl(sim,crops)  =   RESULTS("mt","yld",sim,crops)  ;
r_mt_ar(sim,crops)  =   RESULTS("mt","area",sim,crops) ;
r_mt_hd(sim,comm)   =   RESULTS("mt","hdem",sim,comm) ;
r_mt_sd(sim,comm)   =   RESULTS("mt","sdem",sim,comm) ;
r_mt_fd(sim,comm)   =   RESULTS("mt","fdem",sim,comm) ;
r_mt_prd(sim,comm)  =   RESULTS("mt","pdem",sim,comm) ;
r_mt_nx(sim,comm)   =   RESULTS("mt","netexp",sim,comm) ;
r_mt_pd(sim,comm)   =   RESULTS("mt","pd",sim,comm) ;
r_mt_oblset(sim,obl) =  RESULTS("mt","AREA",SIM,"OBLSETA");


$libinclude xlexport r_mt_pr   .\output\base\malta.xls supply
$libinclude xlexport r_mt_yl   .\output\base\malta.xls yield
$libinclude xlexport r_mt_ar   .\output\base\malta.xls area
$libinclude xlexport r_mt_hd   .\output\base\malta.xls hdem
$libinclude xlexport r_mt_prd  .\output\base\malta.xls pdem
$libinclude xlexport r_mt_sd   .\output\base\malta.xls sdem
$libinclude xlexport r_mt_fd   .\output\base\malta.xls fdem
$libinclude xlexport r_mt_nx   .\output\base\malta.xls nx
$libinclude xlexport r_mt_pd   .\output\base\malta.xls pd

$libinclude xlexport r_mt_oblset   .\output\base\malta.xls obl


****  Results for Turkey

r_tu_pr(sim,comm)   =   RESULTS("tu","prod",sim,comm) ;
r_tu_yl(sim,crops)  =   RESULTS("tu","yld",sim,crops)  ;
r_tu_ar(sim,crops)  =   RESULTS("tu","area",sim,crops) ;
r_tu_hd(sim,comm)   =   RESULTS("tu","hdem",sim,comm) ;
r_tu_sd(sim,comm)   =   RESULTS("tu","sdem",sim,comm) ;
r_tu_fd(sim,comm)   =   RESULTS("tu","fdem",sim,comm) ;
r_tu_prd(sim,comm)  =   RESULTS("tu","pdem",sim,comm) ;
r_tu_nx(sim,comm)   =   RESULTS("tu","netexp",sim,comm) ;
r_tu_pd(sim,comm)   =   RESULTS("tu","pd",sim,comm) ;
r_tu_oblset(sim,obl) =  RESULTS("tu","AREA",SIM,"OBLSETA");


$libinclude xlexport r_tu_pr   .\output\base\turkey.xls supply
$libinclude xlexport r_tu_yl   .\output\base\turkey.xls yield
$libinclude xlexport r_tu_ar   .\output\base\turkey.xls area
$libinclude xlexport r_tu_hd   .\output\base\turkey.xls hdem
$libinclude xlexport r_tu_prd  .\output\base\turkey.xls pdem
$libinclude xlexport r_tu_sd   .\output\base\turkey.xls sdem
$libinclude xlexport r_tu_fd   .\output\base\turkey.xls fdem
$libinclude xlexport r_tu_nx   .\output\base\turkey.xls nx
$libinclude xlexport r_tu_pd   .\output\base\turkey.xls pd

$libinclude xlexport r_tu_oblset   .\output\base\turkey.xls obl