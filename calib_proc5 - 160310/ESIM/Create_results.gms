* The following three rows can be inserted at the end of the "assignments" file

* Save of scenario results; File is included in the solve loop over simulations

*# Results specified per commodity
*#* Quantity results
*#*# Demand results
r_comm(cc,sim_run,comm,"r_hdem")      = HDEM.L(cc,comm);
r_comm(cc,sim_run,comm,"r_sdem")      = SDEM.L(cc,comm);
r_comm(cc,sim_run,comm,"r_pdem")      = PDEM.L(cc,comm);
r_comm(cc,sim_run,comm,"r_fdem")      = FDEM.L(cc,comm);
r_comm(cc,sim_run,comm,"r_tuse")      = TUSE.L(cc,comm);
r_comm(cc,sim_run,"milk","r_fdem")    = FDEM_MLK.L(cc,"milk");

*#*# Supply results
r_comm(cc,sim_run,comm,"r_supp")      = SUPPLY.L(cc,comm);
r_comm(cc,sim_run,comm,"r_quot")      = QUOTA(cc,comm);
r_comm(cc,sim_run,'milk',"r_deliv")   = SUPPLY.L(cc,'milk') - FDEM_MLK.L(cc,"milk");
r_comm(cc,sim_run,'milk',"r_fill")$QUOTA(cc,'milk')    = (SUPPLY.L(cc,'milk') - FDEM_MLK.L(cc,"milk"))/QUOTA(cc,'milk')*100;
r_comm(one,sim_run,crops,"r_yiel")    = YIELD.L(one,crops)*1000;
r_comm(one,sim_run,crops,"r_area")    = ALAREA.L(one,crops);

*#*# Trade results
r_comm(cc,sim_run,comm,"r_nx")        = NETEXP.L(cc,comm);
r_comm(one,sim_run,comm,"r_trsh")     = TRADESHR.L(one,comm);

*#* Price results
r_comm(cc,sim_run,comm,"r_pd")       = PD.L(cc,comm) *exrate(cc)/SUM(euro1, exrate(euro1));
r_comm('row',sim_run,comm,"r_pw")    = PD.L('row',comm);
r_comm(cc,sim_run,i_ethanol,"r_netpd")  = NETPD.L(cc,'ethanol',i_ethanol) *exrate(cc)/SUM(euro1, exrate(euro1));

r_comm(cc,sim_run,ag,"r_pp")         = PP.L(cc,ag)   *exrate(cc)/SUM(euro1, exrate(euro1));
r_comm(one,sim_run,"sugar","r_pp")   = (PD.L(one,"sugar") /margin0(one,"sugar"))*exrate(one)/SUM(euro1, exrate(euro1));
r_comm(one,sim_run,"milk","r_pp")    = (PD.L(one,"milk") /margin0(one,"milk"))*exrate(one)/SUM(euro1, exrate(euro1));



r_comm(cc,sim_run,ag,"r_inc")             = PI.L(cc,ag) *exrate(cc)/SUM(euro1, exrate(euro1));

r_comm(one,sim_run,it,"r_pint")     = INTPR(one,it)      *exrate(one)/SUM(euro1, exrate(euro1));
r_comm(one,sim_run,it,"r_pthr")     = THRPR(one,it)      *exrate(one)/SUM(euro1, exrate(euro1));
r_comm(one,sim_run,comm,"r_psh")    = PSH.L(one,comm)    *exrate(one)/SUM(euro1, exrate(euro1));
r_comm(cc,sim_run,livest,"r_fci")   = FCI.L(cc,livest)   *100;
r_comm(cc,sim_run,energ,"r_bci")    = BCI.L(cc,energ)   *100;
r_comm(one,sim_run,it,"r_pup")      = P_UP.L(one,it)     *exrate(one)/SUM(euro1, exrate(euro1));
r_comm(one,sim_run,it,"r_pup2")     = P_UP_2.L(one,it)   *exrate(one)/SUM(euro1, exrate(euro1));
r_comm(one,sim_run,it,"r_plo")      = P_LO.L(one,it)     *exrate(one)/SUM(euro1, exrate(euro1));

*#* Macro results
r_comm(cc,sim_run,ag,"r_tpg")       =tp_gr(cc,ag)*100;
r_comm(cc,sim_run,ag,"r_tpf")       =tp_fr(cc,ag)*100;


*#* Policy results
*#*# Policy variables

r_comm(one,sim_run,crops,"r_dp_EU")$alarea.l(one,crops)       = ((ENV_COUP_EU(one,crops) + ENV_ART_69(one,crops))/ALAREA.l(one,CROPS)) + (ENV_DECOUP_EU(one)/SUM(crops1,ALAREA.l(one,crops1)));
r_comm(one,sim_run,"SUGAR","r_dp_EU")$alarea.l(one,"SUGAR")   = ((ENV_COUP_EU(one,"SUGAR") + ENV_ART_69(one,"SUGAR"))/area0(one,"SUGAR")) + (ENV_DECOUP_EU(one)/SUM(crops1,ALAREA.l(one,crops1)));
r_comm(one,sim_run,livest,"r_dp_EU")$prod0(one,livest)        = ((ENV_COUP_EU(one,livest) + ENV_ART_69(one,livest))/SUPPLY.l(one,livest));

r_comm(one,sim_run,crops,"r_dp_68")$alarea.l(one,crops)       =  ENV_ART_69(one,CROPS) / ALAREA.l(one,CROPS);
r_comm(one,sim_run,"SUGAR","r_dp_68")$alarea.l(one,"SUGAR")   =  ENV_ART_69(one,"SUGAR") / area0(one,"SUGAR");
r_comm(one,sim_run,livest,"r_dp_68")$prod0(one,livest)        =  ENV_ART_69(one,livest) / SUPPLY.l(one,livest);

r_comm(one,sim_run,crops,"r_dp_top")$alarea.l(one,crops)      =  (ENV_DCNDP(one)/SUM(crops1,ALAREA.l(one,crops1))) + (ENV_CNDP(one,crops) /ALAREA.l(one,CROPS));
r_comm(one,sim_run,"SUGAR","r_dp_top")$alarea.l(one,"SUGAR")  =  (ENV_DCNDP(one)/SUM(crops1,ALAREA.l(one,crops1))) + (ENV_CNDP(one,"SUGAR") /ALAREA.l(one,"SUGAR"));
r_comm(one,sim_run,livest,"r_dp_top")$prod0(one,livest)       =  ENV_CNDP(one,livest)/SUPPLY.l(one,livest);

r_comm(one,sim_run,crops,"r_dp_no68")$alarea.l(one,crops)     =  (ENV_COUP_EU(one,crops)/ALAREA.l(one,CROPS)) + (ENV_DECOUP_EU(one)/SUM(crops1,ALAREA.l(one,crops1)));
r_comm(one,sim_run,"SUGAR","r_dp_no68")$alarea.l(one,"SUGAR") =  (ENV_COUP_EU(one,"SUGAR")/area0(one,"SUGAR")) + (ENV_DECOUP_EU(one)/SUM(crops1,ALAREA.l(one,crops1)));
r_comm(one,sim_run,livest,"r_dp_no68")$prod0(one,livest)      =  ENV_COUP_EU(one,livest)/SUPPLY.l(one,livest);

r_comm(one,sim_run,crops,"r_dpay")$ALAREA.l(one,crops)        =  ((OVERALL_DECOUP(one)/SUM(crops1,ALAREA.l(one,crops1))) + (OVERALL_COUP(one,crops)/ALAREA.l(one,crops))$(not sameas("sugar",crops)) + (OVERALL_COUP(one,crops)/AREA0(one,crops))$(sameas("sugar",crops))) *exrate(one)/SUM(euro1, exrate(euro1));
r_comm(one,sim_run,livest,"r_dpay")$SUPPLY.l(one,livest)      =  DIRPAY.l(one,livest) / prod_effdp(livest,"effdp") *exrate(one)/SUM(euro1, exrate(euro1));

*#*#Policy parameter*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*
r_comm('EU',sim_run,it,"r_esqu")     = SUBSQUANT(it);
r_comm('EU',sim_run,it,"r_trq")      = TRQ(it);
r_comm('EU',sim_run,it,"r_qualexp")      = qualquant(it);
r_comm('EU',sim_run,it,"r_prefsug")  = SUGIMP_EU.L(it);

r_comm(one,sim_run,comm,"r_fsub")   = 0.0;
r_comm(one,sim_run,comm,"r_hsub")   = 0.0;

r_comm(one,sim_run,it,"r_tarav")    = tar_ad  (one,it);
r_comm(one,sim_run,it,"r_tarsp")    = sp_d    (one,it) *exrate(one)/SUM(euro1, exrate(euro1));
r_comm(one,sim_run,it,"r_esav")     = subs_ad (one,it) *exrate(one)/SUM(euro1, exrate(euro1));
r_comm(one,sim_run,it,"r_essp")     = exp_sub (one,it) *exrate(one)/SUM(euro1, exrate(euro1));

*#Results specified per country





r_cc(cc,sim_run,"r_obsa")               = OBLSETAS.L(cc);
r_cc(cc,sim_run,"r_totsa")              = OBLSETAS.L(cc) + supply.l(cc,'setaside');
r_cc(cc,sim_run,"r_totarea")            = SUM(crops, alarea.l(cc,crops));
r_cc(cc,sim_run,"r_incg")               = inc_gr(cc)*100;
r_cc(cc,sim_run,"r_popg")               = pop_gr(cc)*100;

r_cc(cc,sim_run,"r_landpr1")              = landprice1.l(cc);

r_cc(cc,sim_run,"r_lands1")               = landsupply1.l(cc);

r_cc(cc,sim_run,"r_landpr_nc")            = landprice1.l(cc) / SUM(euro1, exrate(euro1)) *exrate(cc);

r_cc(cc,sim_run,"r_pinterm")            = int_ind(cc)*100;
r_cc(cc,sim_run,"r_pcap")               = cap_ind(cc)*100;
r_cc(cc,sim_run,"r_plab")               = lab_ind(cc)*100;
r_cc(cc,sim_run,"r_exra")               = exrate(cc);
r_cc(cc,sim_run,"r_subm")               = subs_milk(cc,"milk");
*r_cc(cc,sim_run,"r_saps")               = SFP_PER_HA_SIM(cc,sim_run);
r_cc(one,sim_run,"r_memb")              = 0;
r_cc(one,sim_run,"r_memb")$member(one)  = 1;

r_cc('EU',sim_run,"r_bfshr")    =  (SUM((one,energ)$member(one),
                          HDEM.L(one,energ)*conv_biofuel(energ))/1000)
                                       /transp_fuel(sim_run);

r_cc('EU',sim_run,"r_BD_shr")    =  (SUM(one$member(one),
                          HDEM.L(one,"BIODIESEL")*conv_biofuel("BIODIESEL"))/1000)
                                       /transp_fuel(sim_run);


r_cc('EU',sim_run,"r_ETH_shr")    =  (SUM(one$member(one),
                          HDEM.L(one,"ETHANOL")*conv_biofuel("ETHANOL"))/1000)
                                       /transp_fuel(sim_run);


* Saving the respective price formation mechanism
R_THR(sim_run,it) = yes$ (THRESH(it));
R_INT(sim_run,it) = yes$ (FLOOR(it));
R_TAR(sim_run,it) = yes$ (TAR(it));

* Saving membership
R_MEMBER(cc,sim_run) = yes$(member(cc));
