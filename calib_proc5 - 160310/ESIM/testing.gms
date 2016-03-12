$INCLUDE 'sets.gms'
SETS
tgtregs country tgtregates
   /EU15, EU12, NONEU/
euregs(tgtregs)  only the regions
   /EU15, EU12/
tgtregmap(tgtregs, ccplus) mapping countries to tgtregates
tgtvars tgtget variables
   /SUPPLY, TUSE, NETEXP, PW/
tgtvarmap(tgtvars, data_base) mapping variables to tgtregate variables
   /SUPPLY.PROD, TUSE.HDEM, TUSE.FDEM, TUSE.SDEM, TUSE.PDEM/
yrs years
   /base, 2008*2008/
NONEU(cc) non-EU countries set
;

PARAMETERS
pp_results (i,cc,res_pp) prices including world market prices
show_data(i,data_base,ccplus) "Consolidated data base, in 1000 t"
tgtdataagg(tgtregs,i,tgtvars,yrs)    aggregated to EU12 and EU15 and to SUPPLY and TUSE
tgtinput(tgtregs,i,tgtvars,yrs)   input target values given in (%) change terms
tgtdata(ccplus,i,tgtvars,yrs)    target values for each country
;

$CALL GDXXRW.EXE "../calib_input.xls" index=Index!A1 output="data_in.gdx"
$GDXIN "data_in.gdx"
$LOAD tgtregmap tgtinput
$GDXIN

* load ESIM quantities database:
$GDXin 'Quantities.gdx'
$load show_data
$GDXIN

* make table tgtdata with dimensions {countries} X {commodities} X {SUPPLY, TUSE, NETEXP}:
* load base data:
LOOP(i,
   LOOP(tgtvars,
         LOOP(tgtregmap(euregs, cc),
            tgtdata(cc,i,tgtvars,'base') =
                 SUM(tgtvarmap(tgtvars, data_base), show_data(i,data_base,cc));
         );
   );
);

* load & assign ESIM world market prices:
$GDXin 'Prices_Policies.gdx'
$load pp_results
$GDXIN
tgtdata('ROW',i,'PW','base') = pp_results(i,'ROW','PD');

* calculate absolute values from target percentage changes:
* assume same percentage change applies to all countries of the aggregate region {EU12, EU15}
loop(tgtregmap(tgtregs, cc),
   tgtdata(cc,i,tgtvars,yrs)$(
         NOT sameas(yrs,"base") AND NOT sameas(tgtvars,"NETEXP")) =
                 tgtdata(cc,i,tgtvars,'base')*(1+tgtinput(tgtregs,i,tgtvars,yrs)/100);
);

* calculate NETEXP as difference of supply - tuse:
*TODO: NETEXP is given exogenously, do not calculate here !!!
tgtdata(cc,i,'NETEXP',yrs) = tgtdata(cc,i,'SUPPLY',yrs) - tgtdata(cc,i,'TUSE',yrs);

* aggregate table tgtdataagg with dimensions {EU12, EU15} X {commodities} X {SUPPLY, TUSE, NETEXP}:
LOOP(i,
   LOOP(tgtvars,
         LOOP(tgtregs,
            tgtdataagg(tgtregs,i,tgtvars,yrs) =
                 SUM(tgtregmap(tgtregs, ccplus), tgtdata(ccplus,i,tgtvars,yrs));
         );
   );
);

display tgtinput, tgtdata, tgtdataagg;
