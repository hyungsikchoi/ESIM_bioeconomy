*
* Testing the consistency of the data base and adjusting supply in row: SUM OF WORLD NET EXPORTS EQ 0.0
*
PARAMETER
chk_nx_1 First test of adding-up the world's netexports
chk_nx   Adding-up of world's netexports after correction
chk_nt   Test for domestic market-clearing of non tradeables
;

chk_nx_1(it)         = SUM(cc, NETEXP.l(cc,it));
chk_nt(cc,nt)     = SUPPLY.l(cc,nt) - hdem.l(cc,nt)
   - sdem.l(cc,nt) - FDEM.l(cc,nt) - PDEM.l(cc,nt) - FDEM_MLK.l(cc,nt) ;

* Usually the base data already should be consistent; if this is not the case for SUM OF WORLD NET EXPORTS
* ---> abort to show that something is wrong.

display chk_nx_1,chk_nt;





Loop(it,
ABORT$(abs(chk_nx_1(it)) gt 0.0001) "WORLD NET EXPORTS DO NOT SUM UP To 0", chk_nx_1;
);

* Ad hoc solution would be possible with:
* supply.l("row",it)   = supply.l("row",it) - chk_nx_1(it);

NETEXP.l(cc,it)   =  supply.l(cc,it) - hdem.l(cc,it)
   - sdem.l(cc,it) - FDEM.l(cc,it) - PDEM.l(cc,it) - FDEM_MLK.l(cc,it) ;

weight(cc,comm)   =  Supply.l(cc,comm)/SUM((c,comm1), supply.l(c,comm1));

chk_nx(it) = SUM(cc, NETEXP.l(cc,it));



display chk_nx_1,chk_nt;




*
* Testing the consistency of the data base: SUM OF FRATE * SUPPLY(livest) = Feed Demand
*
PARAMETER
test_fr     1st check of the consistency of feed rates
test_chg    "Deviation of the feed demand calculated by frates and feed demand of the data base"
frate_rev   Adjusted feed-rates for the European countries
frate_row   Adjusted feed-rates for the USA and the RoW
*frate_wb0   Initial feed-rates for the Western Balkan countries
*frate_wb   Adjusted feed-rates for the Western Balkan countries
chk_fdem    Final check of the consistency of feed rates
chk_feed    Checks the percentage deviation of ALL feed components in total

;

LOOP(one,
LOOP(feed,
*wenn die Summe der Feed rates ueber alle Tierprodukte bei einer Futterkomponente ungleich 0 wäre,
*aber gleichzeitig keine Futternachfrage (fdem.l) nach dieser Komponente bestünde,
*würde abgebrochen.
ABORT$(SUM(livest, FRATE_0(one,feed,livest)) ne 0.0 and fdem.l(one,feed) eq 0.0)
    "FEED DEMAND DOESN'T MATCH BASE FEED RATIOS", frate_0,fdem.l;
);
);


$ontext
* Abort if deviation between the accumulated feedrates and the accumulated feeddemand (all feed added up) too high!
chk_feed(cc)$sum(feed,fdem.l(cc,feed)) = (sum(feed, sum(livest, FRATE_0(cc,feed,livest)* SUPPLY.l(cc,livest)) + feed_exog(cc,feed)) ) / sum(feed,fdem.l(cc,feed));
Loop(cc,
ABORT$(abs(1-chk_feed(cc)) gt 0.05) "FEEDDEMAND DIFFERS TOO MUCH FROM ORIGINALLY ESTIMATED FEEDRATES";
);
$offtext

*test_fr(rest,feed)$fdem.l(rest,feed) =  (sum(livest, FRATE_0(rest,feed,livest)* SUPPLY.l(rest,livest)) + feed_exog(rest,feed))  / fdem.l(rest,feed);
test_fr(cc,feed)$fdem.l(cc,feed)   =  (sum(livest, FRATE_0(cc,feed,livest)* SUPPLY.l(cc,livest)) + feed_exog(cc,feed)) / fdem.l(cc,feed);
*display test_fr;


display test_fr,FRATE_0,fdem.l;






*frate_row(rest,feed,livest)$test_fr(rest,feed) =  FRATE_0(rest,feed,livest)/test_fr(rest,feed);
frate_rev(cc,feed,livest)$test_fr(cc,feed)  =  FRATE_0(cc,feed,livest)/test_fr(cc,feed);

*Abweichung von FRATE_0 von FDEM in Prozent:

test_chg(cc,feed,livest)$FRATE_0(cc,feed,livest)   = (frate_rev(cc,feed,livest)/FRATE_0(cc,feed,livest)-1)*100;

*FRATE.l(rest,feed,livest)  = frate_row(rest,feed,livest);

FRATE.l(cc,feed,livest)  = frate_rev(cc,feed,livest);

test_fr(cc,feed)$fdem.l(cc,feed)   =  (sum(livest, FRATE.l(cc,feed,livest)* SUPPLY.l(cc,livest)) + feed_exog(cc,feed)) / fdem.l(cc,feed);

display test_fr;

parameter test_frate(cc,feed,*);

test_frate(cc,feed,'fr')
  $sameas(cc,'BE')
 = sum(livest, FRATE.l(cc,feed,livest)* SUPPLY.l(cc,livest));

test_frate(cc,feed,'obs')
     $sameas(cc,'BE')
 = fdem.l(cc,feed);

display test_frate;





*<<<DEL:
parameter test_feed_exog(cc,feed);
test_feed_exog(cc,feed) = feed_exog(cc,feed) AND NOT test_fr(cc,feed);
display test_fr, test_feed_exog, FRATE_0, feed_exog, fdem.l;
*>>>






***changed from the source test_fr added
feed_exog(cc,feed)$ (feed_exog(cc,feed))
   =  feed_exog(cc,feed) / test_fr(cc,feed)   ;
display feed_exog;




*feed_exog(rest,feed)$feed_exog(rest,feed) =  feed_exog(rest,feed) / chk_fdem(rest,feed)   ;


*chk_fdem(rest,feed)$FDEM.l(rest,feed) =  (feed_exog(rest,feed) + sum(livest, FRATE.l(rest,feed,livest)* SUPPLY.l(rest,livest)))/fdem.l(rest,feed);

*chk_fdem(one,feed)$FDEM.l(one,feed) =   (feed_exog(one,feed) + sum(livest, FRATE.l(one,feed,livest)
*                                                                           * SUPPLY.l(one,livest)))/ fdem.l(one,feed);



*frate.l(one,feed,livest)$FDEM.l(one,feed) =   FRATE.l(one,feed,livest) / chk_fdem(one,feed)   ;
