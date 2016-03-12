* Adjustment of Subsistence Milk Farming in Poland, Bulgaria and Romania

cons_shr(subsreg,all_p_milk)$subs_milk_d0(subsreg,"cmilk") = ((HDEM.l(subsreg,all_p_milk) - subs_milk_d(subsreg,all_p_milk))* coeff_d_c(all_p_milk,subsreg))
                  / SUM(all_p_milk1, (HDEM.l(subsreg,all_p_milk1)-subs_milk_d(subsreg,all_p_milk1))* coeff_d_c(all_p_milk1,subsreg));


subs_milk_s_1(cc,comm) = subs_milk_s(cc,comm) ;

IF(ORD(sim_idema) eq 1,
subs_milk(cc,comm) = subs_milk0(cc,comm)*(1-adj_subs)**(ord(sim_idema)-1);
subs_milk_s(cc,comm) = subs_milk_s0(cc,comm)*(1-adj_subs)**(ord(sim_idema)-1);

subs_milk_d_1(cc,comm) = subs_milk_d(cc,comm) ;
subs_milk_d(cc,comm) = subs_milk_d0(cc,comm)*(1-adj_subs)**(ord(sim_idema)-1);
);

IF(ORD(sim_idema) gt 1,
subs_milk(cc,comm) = subs_milk0(cc,comm)*(1-adj_subs)**(ord(sim_idema));
subs_milk_s(cc,comm) = subs_milk_s0(cc,comm)*(1-adj_subs)**(ord(sim_idema));

subs_milk_d_1(cc,comm) = subs_milk_d(cc,comm) ;
subs_milk_d(cc,comm) = subs_milk_d0(cc,comm)*(1-adj_subs)**(ord(sim_idema));
);

d_subs_milk(cc,comm) = subs_milk_d_1(cc,comm) - subs_milk_d(cc,comm) ;
s_subs_milk(cc,comm) = subs_milk_s_1(cc,comm) - subs_milk_s(cc,comm) ;






IF(ORD(sim_idema) eq 1.0,
sup_int(subsreg,"milk")$PR(subsreg,"milk") = sup_int(subsreg,"milk");
subs_shift(subsreg,all_p_milk)$HD(subsreg,all_p_milk)  = 1.0;
);

IF(ORD(sim_idema) gt 1.0,

sup_int(subsreg,"milk")$PR(subsreg,"milk") = [
                              log((SUPPLY.l(subsreg,"milk")-subs_milk_s(subsreg,"milk")
                                        -FDEM_MLK.l(subsreg,"milk")    )/tp_gr_1(subsreg,"milk"))
            -sum(livest1$ppp(subsreg,livest1),elastsp(subsreg,"milk",livest1)
                         *(log(PI.l(subsreg,livest1))))
            -elast_lv_i(subsreg,"milk")*log(int_ind(subsreg))
            -elast_lv_l(subsreg,"milk")*log(lab_ind(subsreg))
            -elast_lv_c(subsreg,"milk")*log(cap_ind(subsreg))
            -elast_lv_f(subsreg,"milk")*log(FCI.l(subsreg,"milk"))
                                                ]$(subs_milk_s0(subsreg,"milk") gt 0.0);;


hdem_int_chg(subsreg,all_milk_tra)$HD(subsreg,all_milk_tra) =  [
                                log(HDEM.l(subsreg,all_milk_tra)
                               + (cons_shr(subsreg,all_milk_tra)*d_subs_milk(subsreg,"cmilk"))/coeff_d_c(all_milk_tra,subsreg) )
                           -   sum(comm1$(PD.l(subsreg,comm1)),
                                  elasthd(subsreg,all_milk_tra,comm1)*log(PD.l(subsreg,comm1)))
                           -  log(pop_gr(subsreg))
                           -  log(inc_gr(subsreg))*elastin(subsreg,all_milk_tra)]$(subs_milk_d0(subsreg,"cmilk") gt 0.0);


hdem_int_chg(subsreg,"cmilk")$HD(subsreg,"cmilk") =  [
                                log(HDEM.l(subsreg,"cmilk") - subs_milk_d_1(subsreg,"cmilk")
                               + (cons_shr(subsreg,"cmilk")*d_subs_milk(subsreg,"cmilk"))/coeff_d_c("cmilk",subsreg) )
                           -   sum(comm1$(PD.l(subsreg,comm1)),
                                  elasthd(subsreg,"cmilk",comm1)*log(PD.l(subsreg,comm1)))
                           -  log(pop_gr(subsreg))
                           -  log(inc_gr(subsreg))*elastin(subsreg,"cmilk")]$(subs_milk_d0(subsreg,"cmilk") gt 0.0);



subs_shift(subsreg,all_p_milk)$HD(subsreg,all_p_milk)  = [ hdem_int_chg(subsreg,all_p_milk) / hdem_int(subsreg,all_p_milk) ]$(subs_milk_d0(subsreg,"cmilk") gt 0.0);

subs_shift(subsreg,"powder")$HD(subsreg,"powder")  = subs_shift(subsreg,"butter");

);


s_shift_d(sim_idema,subsreg,all_p_milk) = subs_shift(subsreg,all_p_milk);
s_shift_s(sim_idema,subsreg) = subs_shift_s(subsreg,"milk");
s_shift_s(sim_idema,subsreg) = sup_int(subsreg,"milk")/sup_int0(subsreg,"milk");

