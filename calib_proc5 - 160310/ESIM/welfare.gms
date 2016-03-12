Sets
sc_wf(scenario) scenarios for which welfare changes are calculated compared to the baseline results
/access/
;

expenditure(cc) = expen (cc, "expenditure");

*expenditure(scale100)=expenditure(scale100)/100;
*expenditure(scale100000)=expenditure(scale100000)/100000;

* Calculation of weighted prices and price indices
**Parameter declaration
Parameter
share_crops(sc,cc,sim,crops)   Quantity share of resp. crop in total crop prod.
share_livest(sc,cc,sim,livest) Quantity share of resp. animal in total animal prod.
share_farm(sc,cc,sim,ag)       Quantity share of resp. product in total farm prod.
share_comm(sc,cc,sim,comm)     Quantity share of resp. product in total consumpt.

pp_crops(sc,cc,sim)    Quantity weighted crop producer price
pp_livest(sc,cc,sim)   Quantity weighted animal product producer price
pp_farm(sc,cc,sim)     Quantity weighted farm product producer price
pd_pl(sc,cc,sim)  Quantity weighted wholesale price for plant products
pd_an(sc,cc,sim)  Quantity weighted wholesale price for animal products
pd_comm(sc,cc,sim)     Quantity weighted wholesale price

pi_crops(sc,cc,sim)   Crop price index compared to base (weighted with base qu.)
pi_livest(sc,cc,sim)  Animal prod. price index compared to base (weighted with base qu.)
pi_farm(sc,cc,sim)    Farm prod. price index compared to base (weighted with base qu.)
pi_pl(sc,cc,sim) Wholesale price index for plant products compared to base (weighted with base qu.)
pi_an(sc,cc,sim) Wholesale price index for animal products compared to base (weighted with base qu.)
pi_comm(sc,cc,sim)    Wholesale price index compared to base (weighted with base qu.)

pi_crops_sc(sc_wf,cc,sim)   Crop producer price index compared to baseline
pi_livest_sc(sc_wf,cc,sim)  Animal prod. producer price index compared to baseline
pi_farm_sc(sc_wf,cc,sim)    Farm price index compared to baseline
pi_pl_sc(sc_wf,cc,sim) Wholesale price index for plant products compared to baseline
pi_an_sc(sc_wf,cc,sim) Wholesale price index for animal products compared to baseline
pi_comm_sc(sc_wf,cc,sim)    Wholesale price index compared to baseline

value_crops(sc,cc,sim)  Farm production value of crops
value_livest(sc,cc,sim) Farm production value of livestock
value_farm(sc,cc,sim)   Farm production value

value_pl(sc,cc,sim)     Consumption value of plant products at wholesale prices
value_an(sc,cc,sim)     Consumption value of animal products at wholesale prices
value_comm(sc,cc,sim)   Consumption value at wholesale prices

si_crops(sc,cc,sim)  Index of crop prod. compared to base (base price weighted)
si_livest(sc,cc,sim) Index of animal prod. compared to base (base price weighted)
si_farm(sc,cc,sim)   Index of farm prod. compared to base (base price weighted)

di_pl(sc,cc,sim)   Index of h. demand for crop prod. compared to base (base price weighted)
di_an(sc,cc,sim)   Index of h. demand for animal prod. compared to base (base price weighted)
di_comm(sc,cc,sim) Index of h. demand compared to base (base price weighted)
;

** Calculation of production shares as a base for producer price indices
share_crops(cc,crops)  =
r_supply(cc,crops) / sum(crops1, r_supply(cc,crops1));

share_livest(cc,sim,livest) =
r_supply(cc,sim,livest) / sum(livest1, r_supply(cc,sim,livest1));

share_farm(cc,sim,ag)       =
r_supply(cc,sim,ag) / sum(ag1, r_supply(cc,sim,ag1));

**Calculation of consumption shares as a base for consumer price indices
share_comm(sc,cc,sim,comm) =
r_hdem(sc,cc,sim,comm) / sum(comm1, r_hdem(sc,cc,sim,comm1));

**Calculation of weighted producer prices
pp_crops(sc,cc,sim)    =
sum(crops, r_pp(sc,cc,sim,crops)*share_crops(sc,cc,sim,crops));

pp_livest(sc,cc,sim)   =
sum(livest, r_pp(sc,cc,sim,livest)*share_livest(sc,cc,sim,livest));

pp_farm(sc,cc,sim)     =
sum(ag, r_pp(sc,cc,sim,ag)*share_farm(sc,cc,sim,ag));

**Calculation of weighted consumer prices
pd_pl(sc,cc,sim)     =
sum(pl, r_pd(sc,cc,sim,pl)*share_comm(sc,cc,sim,pl));

pd_an(sc,cc,sim)     =
sum(an, r_pd(sc,cc,sim,an)*share_comm(sc,cc,sim,an));

pd_comm(sc,cc,sim)     =
sum(comm, r_pd(sc,cc,sim,comm)*share_comm(sc,cc,sim,comm));

**Calculation of producer price indices, weighted with base quantities
***Assigning pd results as pp results for those countries, for which pp does not exist.
r_pp(sc,"row",sim,ag)=r_pd(sc,"row",sim,ag);
r_pp(sc,"us",sim,ag)=r_pd(sc,"us",sim,ag);

pi_crops(sc,cc,sim)    =
sum(crops, r_pp(sc,cc,sim,crops)*share_crops("baseli",cc,"base",crops))/
sum(crops, r_pp("baseli",cc,"base",crops)*share_crops("baseli",cc,"base",crops));

pi_livest(sc,cc,sim)   =
sum(livest, r_pp(sc,cc,sim,livest)*share_livest("baseli",cc,"base",livest))/
sum(livest, r_pp("baseli",cc,"base",livest)*share_livest("baseli",cc,"base",livest));

pi_farm(sc,cc,sim)     =
sum(ag, r_pp(sc,cc,sim,ag)*share_farm("baseli",cc,"base",ag))/
sum(ag, r_pp("baseli",cc,"base",ag)*share_farm("baseli",cc,"base",ag));

**Calculation of consumer price indices, weighted with base quantities
pi_pl(sc,cc,sim)    =
sum(pl, r_pd(sc,cc,sim,pl)*share_comm("baseli",cc,"base",pl))/
sum(pl, r_pd("baseli",cc,"base",pl)*share_comm("baseli",cc,"base",pl));

pi_an(sc,cc,sim)    =
sum(an, r_pd(sc,cc,sim,an)*share_comm("baseli",cc,"base",an))/
sum(an, r_pd("baseli",cc,"base",an)*share_comm("baseli",cc,"base",an));

pi_comm(sc,cc,sim)    =
sum(comm, r_pd(sc,cc,sim,comm)*share_comm("baseli",cc,"base",comm))/
sum(comm, r_pd("baseli",cc,"base",comm)*share_comm("baseli",cc,"base",comm));

**Calculation of price indices of scenario compared to baseline
pi_crops_sc(sc_wf,cc,sim) = pi_crops(sc_wf,cc,sim)/pi_crops("baseli",cc,sim);
pi_livest_sc(sc_wf,cc,sim) = pi_livest(sc_wf,cc,sim)/pi_livest("baseli",cc,sim);
pi_farm_sc(sc_wf,cc,sim) = pi_farm(sc_wf,cc,sim)/pi_farm("baseli",cc,sim);
pi_pl_sc(sc_wf,cc,sim) = pi_pl(sc_wf,cc,sim)/pi_pl("baseli",cc,sim);
pi_an_sc(sc_wf,cc,sim) = pi_an(sc_wf,cc,sim)/pi_an("baseli",cc,sim);
pi_comm_sc(sc_wf,cc,sim) = pi_comm(sc_wf,cc,sim)/pi_comm("baseli",cc,sim);

* Calculation of weighted poduction and production indices
**Parameter declaration

**Calculation of production value
value_crops(sc,cc,sim)    =
sum(crops, r_pp(sc,cc,sim,crops)*r_supply(sc,cc,sim,crops));

value_livest(sc,cc,sim)   =
sum(livest, r_pp(sc,cc,sim,livest)*r_supply(sc,cc,sim,livest));

value_farm(sc,cc,sim)     =
sum(ag, r_pp(sc,cc,sim,ag)*r_supply(sc,cc,sim,ag));

**Calculation of consumption value at wholesale prices
value_pl(sc,cc,sim)    =
sum(pl, r_pd(sc,cc,sim,pl)*r_hdem(sc,cc,sim,pl));

value_an(sc,cc,sim)    =
sum(an, r_pd(sc,cc,sim,an)*r_hdem(sc,cc,sim,an));

value_comm(sc,cc,sim)    =
sum(comm, r_pd(sc,cc,sim,comm)*r_hdem(sc,cc,sim,comm));

**Calculation of farm supply indices, weighted with base prices
si_crops(sc,cc,sim)    =
sum(crops, r_pp("baseli",cc,"base",crops)*r_supply(sc,cc,sim,crops))/
sum(crops, r_pp("baseli",cc,"base",crops)*r_supply("baseli",cc,"base",crops));

si_livest(sc,cc,sim)   =
sum(livest, r_pp("baseli",cc,"base",livest)*r_supply(sc,cc,sim,livest))/
sum(livest, r_pp("baseli",cc,"base",livest)*r_supply("baseli",cc,"base",livest));

si_farm(sc,cc,sim)     =
sum(ag, r_pp("baseli",cc,"base",ag)*r_supply(sc,cc,sim,ag))/
sum(ag, r_pp("baseli",cc,"base",ag)*r_supply("baseli",cc,"base",ag));

**Calculation of human demand indices, weighted with base prices
di_pl(sc,cc,sim)    =
sum(pl, r_pd("baseli",cc,"base",pl)*r_hdem(sc,cc,sim,pl))/
sum(pl, r_pd("baseli",cc,"base",pl)*r_hdem("baseli",cc,"base",pl));

di_an(sc,cc,sim)    =
sum(an, r_pd("baseli",cc,"base",an)*r_hdem(sc,cc,sim,an))/
sum(an, r_pd("baseli",cc,"base",an)*r_hdem("baseli",cc,"base",an));

di_comm(sc,cc,sim)    =
sum(comm, r_pd("baseli",cc,"base",comm)*r_hdem(sc,cc,sim,comm))/
sum(comm, r_pd("baseli",cc,"base",comm)*r_hdem("baseli",cc,"base",comm));


*Welfare calculations, reference: status quo


Parameter

**Help parameters not to be tagged
* Help parameters used for the calculation of integrals (upper and lower limit)
new(cc,i,sim)
old(cc,i,sim)
new1(cc)
old1(cc)
*new2(i,sim)
*old2(i,sim)

* Help parameters used for the calculation prod. surplus changes for quota products
x(cc)
y(cc)
z(cc)

* Parameters for the calculation of the compensated demand curve
elasthd_c(cc,i,j)   Compensated price elasticities of human demand
hdem_int_c(cc,i)    Intercepts of compensated demand curves
exp_share(cc,i)     Exp. shares of single ESIM products in total consumption exp.
texp_share(cc)      Exp. share of total ESIM products in total consumption exp.

* Price parameters (for stepwise introd. of price changes in the sequ. approach)
pp_ps(cc,i,sim)         Effective farm gate price used in the calc. of integrals
fci_ps(cc,livest,sim)   Effective feed cost index used in the calc. of integrals
pd_cv(cc,i,sim)         Effective wholesale price used in the calc. of integrals
psh_ps(cc,i,sim)        Effective shadow price used in the calc. of integrals

* Parameter for the calc. of prod. surplus changes due to feed cost changes
fe_per_ton(sc,cc,livest,sim)  Ton feed per ton of animal output

* Welfare measures
** Calculation of the compensating variation (reference: status quo scenario)
cv(sc_wf,cc,i,sim)   Compensating variation per product and per country
cv_t(sc_wf,cc,sim)   Total compensating variation per country
cv_rel(sc_wf,cc,sim) Compensating variation per country per total expenditure
cv_w(sc_wf,sim)      Total compensating variation

** Linear non-sequential welfare measures for comparison
linear_cs(sc_wf,cc,i,sim) Consumer surplus as linear non-sequential approximation under normal demand curve
linear_cs_t(sc_wf,cc,sim) Total linearly approximated consumer surplus per country
;


*Calculation of welfare effects for consumers
**Calculation of compensated price elasticities
exp_share(cc,i) =
results("baseli",cc,"pd","base",i)*results("baseli",cc,"hdem","base",i)*1000/expenditure(cc);

elasthd_c(cc,i,j) = elasthd(cc,i,j)+ exp_share(cc,j)*elastin(cc,i);

texp_share(cc)=sum(i,exp_share(cc,i));


**assignment of baseline prices
pp_ps(one,comm,sim)         =   r_pp("baseli",one,sim,comm);
fci_ps(cc,livest,sim)       =   r_fci("baseli",cc,sim,livest);
pd_cv(cc,comm,sim)          =   r_pd("baseli",cc,sim,comm);

**Calculation of compensating variation
Loop(sc_wf,
*Loop(cc,
Loop(sim,

pd_cv(cc,comm,sim)          =   r_pd("baseli",cc,sim,comm)

Loop(comm,
*$HDEM(cc,i)
* Calibration of the compensated demand curves for the sequential approach
hdem_int_c(cc,comm) $HDEM.l(cc,comm) =
exp(hdem_int(cc,comm))* Prod(comm1, pd_cv(cc,comm1,sim)**elasthd(cc,comm,comm1))*
r_inc_gr("baseli",cc,sim)**elastin(cc,comm)*r_pop_gr("baseli",cc,sim)/
(Prod(comm1, pd_cv(cc,comm1,sim)**elasthd_c(cc,comm,comm1))*
r_inc_gr("baseli",cc,sim)**elastin(cc,comm)*r_pop_gr("baseli",cc,sim));

* Integral with status_quo price of product concerned as limit of integration
old1(cc) =
1/(1+elasthd_c(cc,comm,comm))*
hdem_int_c(cc,comm)*
pd_cv(cc,comm,sim)**(1+elasthd(cc,comm,comm))*
Prod(comm1, pd_cv(cc,comm1,sim)**elasthd_c(cc,comm,comm1))/
(pd_cv(cc,comm,sim)**elasthd(cc,comm,comm))*
r_inc_gr("baseli",cc,sim)**elastin(cc,comm)*
r_pop_gr("baseli",cc,sim);


* Replacement of the status_quo price of the product concerned by the price of the actual scenario. In the sequential approach this price "remains" the p_ef_ps for the following products, which may have cross price relationships with the product concerned
pd_cv(cc,comm,sim)= r_pd(sc_wf,cc,sim,comm);

* Integral with "new" price of product concerned as limit of integration
new1(cc) =
1/(1+elasthd_c(cc,comm,comm))*
hdem_int_c(cc,comm)*
pd_cv(cc,comm,sim)**(1+elasthd(cc,comm,comm))*
Prod(comm1, pd_cv(cc,comm1,sim)**elasthd_c(cc,comm,comm1))/
(pd_cv(cc,comm,sim)**elasthd(cc,comm,comm))*
r_inc_gr("baseli",cc,sim)**elastin(cc,comm)*
r_pop_gr("baseli",cc,sim);

* Calculation of the definite integral
cv(sc_wf,cc,comm,sim)=-(new1(cc)-old1(cc));

);
);
);



*Aggregation CV
cv_t(sc_wf,cc,sim) = sum(comm, cv(sc_wf,cc,comm,sim));

*der folgende muß mit WK angepaßt werden
cv_w(sc_wf,sim)    = sum(cc,cv_t(sc_wf,cc,sim));

*Relative CV measures
cv_rel(sc_wf,cc,sim) = cv_t(sc_wf,cc,sim)/
(sum(comm, r_pd("baseli",cc,"base",comm)*r_hdem("baseli",cc,"base",comm)));

*Linear approximations of consumer surplus
linear_cs(sc_wf,cc,comm,sim) =
-(r_pd(sc_wf,cc,sim,comm)-r_pd("baseli",cc,sim,comm))*
((r_hdem(sc_wf,cc,sim,comm)+r_hdem("baseli",cc,sim,comm))/2);

linear_cs_t(sc_wf,cc,sim) = sum(comm, linear_cs(sc_wf,cc,comm,sim));
;


*Calculation of budgetary effects compared to the baseline
Parameter
**Changes and absolute levels of stocks
d_stock(sc,comm,sim)       EU stock changes
stock(sc,comm,sim)         EU stocks
acc(sim)

** Effects per product
***Absolute levels
b_dirpay(sc,one,comm,sim) Outlays for direct payments per product
b_sub(sc,one,comm,sim)    Outlays for product subsidies per product
b_tariff(sc,one,comm,sim) Tariff revenue per product
b_es(sc,one,comm,sim)     Outlays for export subsidies per product
budget(sc,one,comm,sim) Total budgetary effects per product

*Changes compared to base situation
d_dirpay(sc_wf,one,comm,sim) Change in outlays for direct payments per product
d_sub(sc_wf,one,comm,sim)    Change in outlays for product subsidies per product
d_tariff(sc_wf,one,comm,sim) Change in tariff revenue per product
d_es(sc_wf,one,comm,sim)     Change in outlays for export subsidies per product
d_budget(sc_wf,one,comm,sim) Total budgetary changes per product

** National totals
***Absolute levels
b_dirpay_cc(sc,one,sim)       Total outlays for direct payments
b_sub_cc(sc,one,sim)          Total outlays for product subsidies
b_tariff_cc(sc,one,sim)       Total tariff revenue
b_es_cc(sc,one,sim)           Total outlays for export subsidies
budget_cc(sc,one,comm,sim)  Total budget

***Changes per product
d_dirpay_cc(sc_wf,one,sim)      Change in total outlays for direct payments
d_sub_cc(sc_wf,one,sim)         Change in total outlays for product subsidies
d_tariff_cc(sc_wf,one,sim)      Change in total tariff revenue
d_es_cc(sc_wf,one,sim)          Change in total outlays for export subsidies
d_budget_cc(sc_wf,one,comm,sim) Total budgetary changes
;

*Calculation of budgetary effects
**Hier noch Aggregation über Member states*********************************aus membership Tabelle?

*Direct payments in each scenario
b_dirpay(sc,one,comm,sim) =
r_dirpay(sc,one,sim,comm)*r_supply(sc,one,sim,comm);

b_dirpay_cc(sc,one,sim) =
sum(comm, b_dirpay(sc,one,comm,sim));


*Changes in direct payments compared to the baseline
d_dirpay(sc_wf,one,comm,sim) =
-(b_dirpay(sc_wf,one,comm,sim)- b_dirpay("baseli",one,comm,sim));

d_dirpay_cc(sc_wf,one,sim) =
-(b_dirpay_cc(sc_wf,one,sim)- b_dirpay_cc("baseli",one,sim));

*Outlays for product subsidies in each scenario
b_sub(sc,one,comm,sim) =
r_hdem_aid(sc,one,sim,comm)*r_hdem(sc,one,sim,comm)+
r_fdem_aid(sc,one,sim,comm)*r_fdem(sc,one,sim,comm);

b_sub_cc(sc,one,sim) = sum(comm, b_sub(sc,one,comm,sim));

*Changes in outlays for subsidies compared to the baseline
d_sub(sc_wf,one,comm,sim) =
-(b_sub(sc_wf,one,comm,sim)- b_sub("baseli",one,comm,sim));

d_sub_cc(sc_wf,one,sim) =
-(b_sub_cc(sc_wf,one,sim)- b_sub_cc("baseli",one,sim));

*Calculation of stock changes and total stocks for the EU
***Hier müssen wir noch sicherstellen, daß der Inhalt der dynamischen sets p_thresh und floor an der richtigen Stelle in model mcp abgegriffen wird
***Außerdem: das kann man bestimmt eleganter formulieren...
r_subsquant(sc,"eu",sim,"beef") = 200;

Loop(sc,
Loop(sim,
Loop(it,
if(p_thresh(it)or p_floor(it),
if((r_nx_eu(sc,sim,it)+ r_trq(sc,"eu",sim,it))gt r_subsquant(sc,"eu",sim,it),
d_stock(sc,it,sim)=
r_nx_eu(sc,sim,it)+ r_trq(sc,"eu",sim,it)- r_subsquant(sc,"eu",sim,it)
else
d_stock(sc,it,sim)=0)
else
d_stock(sc,it,sim)=0);
)));

*Kumulativ...**********Hier kommt noch Unsinn raus
acc(sim)=ord(sim);

Loop(sim,
stock(sc,it,sim)= sum(sim1, d_stock(sc,it,sim1) $ acc(sim) lt ord(sim)));

*display r_trq, r_nx_eu, r_subsquant, d_stock,b_sub, b_dirpay_cc;



*Calculation of tariffs and export subsidies for each scenario
***** Das läuft zwar, aber berücksichtigt noch nicht die EU-Mitgliedschaft (dann müssen NX für die EU addiert werden, und nicht mehr einzeln berücksichtigt); Rückgreifen auf membership Tabelle? if member, dann zu EU und national auf 0 setzen; sonst national?
Loop(sc,
Loop(one,
Loop(sim,
Loop(it,
If((r_nx(sc,one,sim,it)-r_trq(sc,one,sim,it)) lt 0,
b_tariff(sc,one,it,sim) = -1*(r_nx(sc,one,sim,it)-r_trq(sc,one,sim,it))*
(r_p_up(sc,one,sim,it) - r_pw(sc,sim,it));

b_es(sc,one,it,sim) = 0;

else
b_tariff(sc,one,it,sim)=0;
*Achtung:ES noch nicht fertig 1) nur bis WTO limit, 2) Difference aus Preisen?(sc,one,it,sim)
b_es(sc,one,it,sim) = 0;

)))));



* Calculation of the total budget for each scenario




* Calculation of changes in the budget compared to the baseline (negative numbers: higher outlays/less revenue)





* Change in producer surplus (ps) compared to the status quo scenario


* Changes in total net-welfare