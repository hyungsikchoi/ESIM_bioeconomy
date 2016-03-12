

logit_scale(one,it) = 1.0;
logit_scale(eu27,'sugar') = 2.0;
logit_scale(eu27,'pork') = 1;
logit_scale(eu27,'eggs') = 3;
logit_scale(eu27,'poultry') = 2.0;

logit_scale(cand,it) = 1.0;
logitshift(one,it) = 1.0;



PARAMETER
chk_floor_c(*,*,*) Calibration results of the LOGIT Function: Candidate Countries
chk_floor_d(*,*,*) Calibration results of the LOGIT Function: Delayed Integration to Single Market
chk_floor_eu(*,*,*) Calibration results of the LOGIT Function: EU-25 Countries
chk_floor_eu1(*,*) Calibration results of the LOGIT Function: EU-25 Countries

subs_ad_0

;


*
* First test of calibration of domestic prices of tradeable products
*
chk_floor_c(cand,it,"P_UP")        = P_UP.l(cand,it) ;
chk_floor_c(cand,it,"P_LO")        = P_LO.l(cand,it) ;
chk_floor_c(cand,it,"MKTPR")       = mrktpri0(cand,it);
chk_floor_c(cand,it,"NETEXP")      = netexp.l(cand,it) ;
chk_floor_c(cand,it,"SHR in %")    = tradeshr.l(cand,it) ;


chk_floor_d(one,delay_c,"P_UP")$(delay_r(one) and member(one))     = P_UP.l(one,delay_c) ;
chk_floor_d(one,delay_c,"P_LO")$(delay_r(one) and member(one))     = P_LO.l(one,delay_c) ;
chk_floor_d(one,delay_c,"SHR in %")$(delay_r(one) and member(one)) = tradeshr_d.l(delay_c);
chk_floor_d(one,delay_c,"MKTPR")$(delay_r(one) and member(one))    = mrktpri0(one,delay_c);
chk_floor_d(one,delay_c,"NETEXP")$(delay_r(one) and member(one))   = SUM(one1$delay_r(one1), netexp.l(one1,delay_c)) ;



chk_floor_eu(eu27,it,"P_UP")       = P_UP.l(eu27,it) ;
chk_floor_eu(eu27,it,"P_LO")       = P_LO.l(eu27,it) ;
chk_floor_EU(eu27,it,"P_UP_2")     = P_UP_2.l(eu27,it) ;
chk_floor_eu(eu27,it,"SHR in %")   = tradeshr_eu.l(it);
chk_floor_eu(eu27,it,"MKTPR")      = mrktpri0(eu27,it);



*tradeshr_eu.l('sugar')=10;

chk_floor_c(one,it,"PD_CALC")$cand(one) =
    (P_UP.l(one,it) - P_LO.l(one,it))
                  *( (-1)*logitshift(one,it)*(exp(tradeshr.l(one,it))  /
                     (1+logitshift(one,it)*exp(tradeshr.l(one,it))) ))
                 + P_UP.l(one,it) ;

display chk_floor_c,P_UP.l,tradeshr.l;




chk_floor_d(one,delay_c,"PD_CALC")$(delay_r(one) and member(one)) =
    (P_UP.l(one,delay_c) - P_LO.l(one,delay_c))
                  *( (-1)*logitshift(one,delay_c)*(exp(tradeshr_d.l(delay_c))  /
                     (1+logitshift(one,delay_c)*exp(tradeshr_d.l(delay_c))) ))
                 + P_UP.l(one,delay_c) ;

display chk_floor_d;

chk_floor_eu(eu27,it,"PD_CALC") =
    (P_UP.l(eu27,it) - P_LO.l(eu27,it))
                  *( (-1)*logitshift(eu27,it)*(exp(trqshr_eu.l(it)+tradeshr_eu.l(it))  /
                     (1+logitshift(eu27,it)*exp(trqshr_eu.l(it)+tradeshr_eu.l(it))) ))
                 + P_UP.l(eu27,it) ;

chk_floor_eu(eu27,it,"PD_CALC") $sameas(it,'sugar') =
    (P_UP.l(eu27,it) - P_LO.l(eu27,it))
                  *( (-1)*logitshift(eu27,it)*(exp(logit_scale(eu27,'sugar')*(trqshr_eu.l(it)+tradeshr_eu.l(it)))  /
                     (1+logitshift(eu27,it)*exp(logit_scale(eu27,'sugar')*(trqshr_eu.l(it)+tradeshr_eu.l(it)))) ))
                 + P_UP.l(eu27,it) ;




display chk_floor_eu,trqshr_eu.l,tradeshr_eu.l,logitshift;





*
* The following equation is only for the EU and for those commodities with export subsidies
*
chk_floor_eu(eu27,it,"PD_CALC")$(subsquant(it) or qualquant(it)) =
                              MAX[
    (P_UP.l(eu27,it) - P_LO.l(eu27,it))
                  *( (-1)*(exp(trqshr_eu.l(it)+tradeshr_eu.l(it))  /
                     (1+exp(trqshr_eu.l(it)+tradeshr_eu.l(it)) ) ))
                 + P_UP.l(eu27,it) ,

    (P_UP_2.l(eu27,it) - P_LO.l(eu27,it))
                  *( (-1)*logitshift(eu27,it)*(exp(logit_scale(eu27,it)*(trqshr_eu.l(it)+tradeshr_eu.l(it) - SUBSHR_eu.l(it) - QUALSHR_EU.l(it)))  /
                     (1+exp(logit_scale(eu27,it)*(trqshr_eu.l(it)+tradeshr_eu.l(it) - SUBSHR_eu.l(it) - QUALSHR_EU.l(it)) ) ) ))
                 + P_UP_2.l(eu27,it)
                                     ]
;




chk_floor_eu(eu27,it,"PD_CALC1")$(subsquant(it) or qualquant(it)) =
    (P_UP.l(eu27,it) - P_LO.l(eu27,it))
                  *( (-1)*(exp(trqshr_eu.l(it)+tradeshr_eu.l(it))  /
                     (1+exp(trqshr_eu.l(it)+tradeshr_eu.l(it)) ) ))
                 + P_UP.l(eu27,it)
;


chk_floor_eu(eu27,it,"PD_CALC2")$(subsquant(it) or qualquant(it)) =
    (P_UP_2.l(eu27,it) - P_LO.l(eu27,it))
                  *( (-1)*logitshift(eu27,it)*(exp(logit_scale(eu27,it)*(trqshr_eu.l(it)+tradeshr_eu.l(it) - SUBSHR_eu.l(it) - QUALSHR_EU.l(it)))  /
                     (1+exp(logit_scale(eu27,it)*(trqshr_eu.l(it)+tradeshr_eu.l(it) - SUBSHR_eu.l(it) - QUALSHR_EU.l(it)) ) ) ))
                 + P_UP_2.l(eu27,it)

;

chk_floor_c(cand,it,"Differ CALC PD MKTPR")$mrktpri0(cand,it)  = ROUND((chk_floor_c(cand,it,"PD_CALC")
                                   -mrktpri0(cand,it)) / mrktpri0(cand,it) *100,3);

chk_floor_d(one,delay_c,"Differ CALC PD MKTPR")$(delay_r(one) and mrktpri0(one,delay_c) and member(one))  =
                                        ROUND((chk_floor_d(one,delay_c,"PD_CALC")
                                   -mrktpri0(one,delay_c)) / mrktpri0(one,delay_c) *100,3);

chk_floor_eu(eu27,it,"Differ CALC PD MKTPR")$mrktpri0(eu27,it)  = ROUND((chk_floor_eu(eu27,it,"PD_CALC")
                                   -mrktpri0(eu27,it)) / mrktpri0(eu27,it) *100,3);



*LOOP(it,

*IF(ABS(chk_floor_eu("eu27",it,"Differ CALC PD MKTPR")) gt 3,

chk_floor_eu1(it,"P_UP")       = P_UP.l("GE",it) ;
chk_floor_eu1(it,"P_LO")       = P_LO.l("GE",it) ;
chk_floor_EU1(it,"P_UP_2")     = P_UP_2.l('GE',it) ;
chk_floor_eu1(it,"SHR")   = tradeshr_eu.l(it);
chk_floor_eu1(it,"MKTPR")      = mrktpri0('GE',it);
chk_floor_eu1(it,"NETEXP")     = SUM(eu27, netexp.l(eu27,it)) ;
chk_floor_eu1(it,"TUSE")     = SUM(eu27, tuse.l(eu27,it)) ;
chk_floor_eu1(it,"PD_CALC")     = chk_floor_eu('ge',it,"PD_CALC") ;
chk_floor_eu1(it,"Differ")$mrktpri0('GE',it)  = ROUND((chk_floor_eu('ge',it,"PD_CALC")
                                   -mrktpri0('ge',it)) / mrktpri0('ge',it) *100,3);
chk_floor_eu1(it,"TRQSHR")   = trqshr_eu.l(it);
chk_floor_eu1(it,"SUBSHR")   = subshr_eu.l(it);
chk_floor_eu1(it,"QUALSHR")   = QUALSHR_EU.l(it);
chk_floor_eu1(it,"RELSHR")  =  trqshr_eu.l(it)+tradeshr_eu.l(it) - SUBSHR_eu.l(it) - QUALSHR_EU.l(it) ;

*);
*);


display chk_floor_d;
display chk_floor_c;
display chk_floor_eu1;
display subsquant,qualquant;
display logitshift,logit_scale;
