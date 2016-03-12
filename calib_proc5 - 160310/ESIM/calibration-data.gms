
subs_milk(one,"milk") = 0.0 ;

subs_milk_s(cc,"milk") = subs_milk(cc,"milk");
subs_milk_d(cc,"cmilk") = subs_milk(cc,"milk");


subs_shr(one,"milk")$(subs_milk(one,"milk") gt 0.0)  = subs_milk(one,"milk")/supply.l(one,"milk") ;

subs_shift(cc,comm)   = 1.0;
subs_shift_s(cc,comm) = 1.0;
subs_milk0(cc,comm)   = subs_milk(cc,comm);
subs_milk_s0(cc,comm) = subs_milk_s(cc,comm) ;
subs_milk_d0(cc,comm) = subs_milk_d(cc,comm) ;

display subs_milk;
*
*
*FRATE_0(rest,feed,livest)$FDEM.l(rest,feed)  =  FDEM.l(rest,feed) /  SUM(livest1, SUPPLY.l(rest,livest1)) ;
FRATE_0(rest,feed,livest)$FDEM.l(rest,feed)  =  FRATE.l(rest,feed,livest) ;
FRATE_0(one,feed,livest)$FDEM.l(one,feed)    =  FRATE.l(one,feed,livest) ;
*

display FRATE_0;


* The following file tests the consistency of the base data for trade data
* and for feed rates
*
$include "check-consist.gms"

*
*






FR(cc,feed,livest) = YES$frate.l(cc,feed,livest);
display FR,frate.l;