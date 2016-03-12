*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
* set supply elasticities to zero to fix supply, ie. no supply reactions
*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
* Crops:
elastsp(rest,crops,crops1)$PR(rest,crops)= 0;

sup_int(rest,crops)$PR(rest,crops) =  log(SUPPLY.l(rest,crops))
            - sum(crops1$(PP.l(rest,crops1)), elastsp(rest,crops,crops1)
                         *log(PP.l(rest,crops1)));
tp_gr(rest,crops)$PR(rest,crops)=1;


* 2: setting elasticity of crops yields and of livestock in the EU to zero

** EU CROPS
elastyd(one,crops,crops)$(supply.l(one,crops)and not volsa(one,crops))= 0;
elast_y_i(one,crops)    $(supply.l(one,crops)and not volsa(one,crops))= 0;
elast_y_l(one,crops)    $(supply.l(one,crops)and not volsa(one,crops))= 0;

yild_int(one,crops)$(supply.l(one,crops)and not volsa(one,crops))=
                          (log(YIELD.l(one,crops))
                         - elastyd(one,crops,crops)
                          * log(PP.l(one,crops))
                          -elast_y_i(one,crops)*log(int_ind(one))
                          -elast_y_l(one,crops)*log(lab_ind(one)))$nq(one,crops)
            +
                          (log(YIELD.l(one,crops))
                         - elastyd(one,crops,crops)
                          * log(PP.l(one,crops))
*                          * MIN(log(PP.l(one,crops)),LOG(PSH.l(one,crops)) )
                          -elast_y_i(one,crops)*log(int_ind(one))
                          -elast_y_l(one,crops)*log(lab_ind(one)))$qu_sugar(one,crops)


;
tp_gr(one,crops) $(supply.l(one,crops)and not volsa(one,crops))=1;


*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
* Livestock:
elastsp(cc,comm,livest1)$(pr(cc,comm) and livest(comm) and ppp(cc,livest1)) = 0;
elast_lv_f(cc,comm)$(pr(cc,comm) and livest(comm)) = 0;
tp_gr(cc,comm)$(pr(cc,comm) and livest(comm)) = 1;

sup_int(one,livest)$PR(one,livest) = log(SUPPLY.l(one,livest)-subs_milk_s(one,livest)
                                        -FDEM_MLK.l(one,livest)    )
            -sum(livest1$ppp(one,livest1),elastsp(one,livest,livest1)
                         *(log(PI.l(one,livest1))))
            -elast_lv_i(one,livest)*log(int_ind(one))
            -elast_lv_l(one,livest)*log(lab_ind(one))
            -elast_lv_c(one,livest)*log(cap_ind(one))
            -elast_lv_f(one,livest)*log(FCI.l(one,livest));

sup_int(one,livest)$(PR(one,livest) and quota(one,livest))
                             = log(SUPPLY.l(one,livest)-subs_milk_s(one,livest)
                                        -FDEM_MLK.l(one,livest)    )
            -sum(livest1$ppp(one,livest1),elastsp(one,livest,livest1)
                         *(log(PI.l(one,livest1))))
            -elast_lv_i(one,livest)*log(int_ind(one))
            -elast_lv_l(one,livest)*log(lab_ind(one))
            -elast_lv_c(one,livest)*log(cap_ind(one))
            -elast_lv_f(one,livest)*log(FCI.l(one,livest));

sup_int(rest,livest)$PR(rest,livest) = log(SUPPLY.l(rest,livest)-FDEM_MLK.l(rest,livest) )
            -sum(livest1$ppp(rest,livest1),elastsp(rest,livest,livest1)
                         *(log(PP.l(rest,livest1))))
            -elast_lv_i(rest,livest)*log(int_ind(rest))
            -elast_lv_l(rest,livest)*log(lab_ind(rest))
            -elast_lv_c(rest,livest)*log(cap_ind(rest))
            -elast_lv_f(rest,livest)*log(FCI.l(rest,livest));
*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++






