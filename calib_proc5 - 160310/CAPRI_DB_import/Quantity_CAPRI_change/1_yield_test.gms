SETS year /y1*y3/, state /s1*s2/;

* 0 generate random yields
Parameter yield(year),lowbound /5/, upbound /10/;
yield(year) = uniform(lowbound,upbound);

display yield;

* 1 create yield classes
PARAMETER newyield(state,*);
newyield(state,"lowbound")
 = lowbound+(ord(state)-1)*(upbound-lowbound)/card(state);
newyield(state,"upbound")
 = lowbound+ord(state)*(upbound-lowbound)/card(state);
newyield(state,"midpoint")
 = (newyield(state,"lowbound")+newyield(state,"upbound"))/2;
newyield(state,"upbound")
 $(ord(state) eq card(state))
 = newyield(state,"upbound") + 0.000001;

* 2 assign yields to classes
newyield(state,"avgyield")
 $ SUM(year
    $(yield(year) ge newyield(state,"lowbound") and
      yield(year) lt newyield(state,"upbound")),
    1)
 = SUM(year
    $(yield(year) ge newyield(state,"lowbound") and
      yield(year) lt newyield(state,"upbound")),
    yield(year))/
   SUM(year
    $(yield(year) ge newyield(state,"lowbound") and
      yield(year) lt newyield(state,"upbound")),
    1);

newyield(state,"freq")
 = SUM(year
    $(yield(year) ge newyield(state,"lowbound") and
      yield(year) lt newyield(state,"upbound")),
    1);

newyield(state,"xxxyield")
 $ SUM(year
    $(yield(year) ge newyield(state,"lowbound") and
      yield(year) lt newyield(state,"upbound")),
    1)
 = SUM(year
    $(yield(year) ge newyield(state,"lowbound") and
      yield(year) lt newyield(state,"upbound")),
    yield(year))/
   SUM(year,1);


display newyield;

* 3 compute simple and enhanced probabilities
Parameter probability(state,*);
probability(state,"simple_P")
 = newyield(state,"freq")/card(year);
probability(state,"enh_P")
 = newyield(state,"xxxyield")/
   newyield(state,"midpoint");
display probability;

* 4 compare average yields
Parameter avgyield(*,*);
avgyield("original","yield comparison")
 = SUM(year,yield(year))/SUM(Year,1);
avgyield("simple transition","yield comparison")
 = SUM(state,
    probability(state,"simple_P")*
    newyield(state,"midpoint"));
avgyield("adjusted probabilities","yield comparison")
 = SUM(state,
    probability(state,"enh_P")*
    newyield(state,"midpoint"));
avgyield("adjusted class yields","yield comparison")
 = SUM(state,
    probability(state,"simple_P")*
    newyield(state,"avgyield"));
display avgyield;

*$setglobal gp_yrange 7:8
*$libinclude gnuplotxyz avgyield