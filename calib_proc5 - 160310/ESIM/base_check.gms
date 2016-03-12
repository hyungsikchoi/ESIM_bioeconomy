*
* TEST OF REPRODUCTION OF THE DATA BASE AFTER THE FIRST SOLVE
* ABORT IF CERTAIN LEVEL IS BROKEN:
* HERE 3.0% TOLERANCE MARGIN COMPARED TO BASE DATA LEVEL
*

*display oblsetas.l,setas_eu15;

PARAMETER

chk_area      Difference between values of data base and variables AREA USE in per cent
chk_prod      Difference between values of data base and variables PRODUCTION in per cent
chk_hdem      Difference between values of data base and variables HUMAN DEMAND in per cent
chk_fdem      Difference between values of data base and variables FEED DEMAND in per cent
chk_sdem      Difference between values of data base and variables SEED DEMAND in per cent
chk_pdem      Difference between values of data base and variables PROC DEMAND in per cent
chk_pd        Difference between values of data base and variables DOMESTIC PRICES in per cent
chk_area_pr   Difference between values of data base and variables AREA PRICE in per cent
ind_exrate
;

chk_area(cc,comm)$area0(cc,comm)   = round((alarea.l(cc,comm) / area0(cc,comm) -1)*100, 6) ;
chk_prod(cc,comm)$prod0(cc,comm)   = round((supply.l(cc,comm) / prod0(cc,comm) -1)*100, 6) ;
chk_hdem(cc,comm)$hdem0(cc,comm)   = round((hdem.l(cc,comm) / hdem0(cc,comm) -1 ) * 100, 6);
chk_fdem(cc,comm)$fdem0(cc,comm)   = round((fdem.l(cc,comm) / fdem0(cc,comm) -1 ) * 100, 6);
chk_sdem(cc,comm)$sdem0(cc,comm)   = round((sdem.l(cc,comm) / sdem0(cc,comm) -1 ) * 100, 6);
chk_pdem(cc,comm)$pdem0(cc,comm)   = round((pdem.l(cc,comm) / pdem0(cc,comm) -1 ) * 100, 6);
chk_pd(cc,comm)$pd_0(cc,comm)      = round((pd.l(cc,comm) / pd_0(cc,comm) -1 ) * 100, 6);
chk_area_pr(one)$landprice0(one)    = round((landprice1.l(one)/landprice0(one) -1) *100, 6);


display prod0,pi.l;

display chk_area
        chk_prod
        chk_hdem
        chk_fdem
        chk_sdem
        chk_pdem
        chk_pd
        chk_area_pr;




LOOP(comm,
LOOP(cc,
 ABORT$(abs(chk_area(cc,comm)) gt 0.5) "BENCHMARK INCORRECT1: AREA USE" , chk_area;
 ABORT$(abs(chk_prod(cc,comm)) gt 0.5) "BENCHMARK INCORRECT1: PRODUCTION" , chk_prod;
 ABORT$(abs(chk_pd(cc,comm))   gt 0.5) "BENCHMARK INCORRECT1: PRICES" , chk_pd;
 ABORT$(abs(chk_hdem(cc,comm)) gt 0.5) "BENCHMARK INCORRECT1: HDEM" , chk_hdem;
 ABORT$(abs(chk_sdem(cc,comm)) gt 0.5) "BENCHMARK INCORRECT1: SDEM" , chk_sdem;
 ABORT$(abs(chk_pdem(cc,comm)) gt 0.5) "BENCHMARK INCORRECT1: PDEM" , chk_pdem;
 ABORT$(abs(chk_fdem(cc,comm)) gt 0.5) "BENCHMARK INCORRECT1: FDEM" , chk_fdem;

);
);

Loop(one,
* ABORT$(abs(chk_area_pr(one)) gt 0.5) "BENCHMARK INCORRECT: area_pr" , chk_area_pr;
);

option decimals = 3 ;

*$STOP

exrate_0(cc)        = exrate(cc);
trq0(it)            = trq(it);
tar_ad_0(one,tar)   = tar_ad(one,tar);
subs_ad_0(one,tar)  = subs_ad(one,tar);
sp_d_0(one,tar)     = sp_d(one,tar);
pw_0(it)            = PW.l(it);
pd_0(one,"milk")    = pd.l(one,"milk");
intpr0(one,floor)   = intpr(one,floor);
subsquant_0(it) = subsquant(it);
