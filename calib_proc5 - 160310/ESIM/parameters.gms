PARAMETERS
sugar_compensation

results(cc,*,*,*)
pd_t_1(cc,ag)             market price in period t-1
pd_t_2(cc,ag)             market price in period t-2
lag_weight(cc,ag,lag_period)  weights in lagged price formation

pd_t1(cc,ag)             market price in functions with one period time lag
pd_t2(cc,ag)             market price in functions with two periods time lag
psh_0                    shadow price in the data base for quota products


fedrat(cc,feed,livest)   feed rates
exrate(ccplus)               exchange rate of domestic currency to USD

tp_gr(cc,i)              technical progress in supply
tp_fr(cc,i)              technical progress in feed use
pdem_tr(cc,comm)         trends in processing capacities in biofuel production
hdem_tr(cc,comm)         trends in private consumption
area_corpar(cc,comm)     area correction parameter for individual countries and products

fdem_tr

defl_pol(ccplus,sim_base)         Deflation of policies for indiv. countries

pop_gr(cc)               population growth rate
inc_gr(cc)               income growth rate
area_gr(cc)              growth rate of area
Population_sim(ccplus,sim)   Population in Mill

cap_ind(cc)              Capital Cost Index
lab_ind(cc)              Labor Cost Index
int_ind(cc)              Intermed Cost Index
eng_ind(cc)              Energy Cost Index
frt_ind(cc)              Fertilizer Cost Index
oth_ind(cc)              Cost Index of other products in hdem

cost_ind(ecc,cc)         cost index for different types of exogenous costs (lab cap int frt eng)

oilsd_c(cc,i,j)          technical parameter oilseed processing
elastcr(cc,i,j)           oilseed crushing demand

dairy_input_coeff(cc,dairy_comp,mlkproc) Techn. coeff. of fat and protein in the dairy products
addcomp_dairy(cc,comm)                   Intercept in dairy processing
addcomp_milk(cc,comm)                    Intercept in milk price eqn
content_milk(cc,comm)              Fat and protein content in processed milk
elastdm(cc,comm,comm1)                   dairy processing
elastdm_n(cc,dairy_comp,comm,comm1)      dairy processing based on splitting fat and protein

* Parameters for land supply function

bend_ld1(cc)             Determ. the bending of the supply curve (non set-aside land)
bend_ld2(cc)             Determ. the bending of the supply curve (set-aside land)
shift_ld(cc)             2nd parameter in land supply function determ. shift of the supply curve
elast_landpr(cc,i)         elast. of land supply
area_max(cc)             Maximal available agricultural area
ch_area(cc)              Chg in area available for agricultural uses
ch_area_rate(cc)         Yearly rate of area available for agricultural uses

straw_ratio(cc,comm,*)     straw yield based on crop yield data base from CAPRI (hyungsik)

* Parameter for the stochastic part of ESIM

stoch (cc,comm)                     Stochastic term in model equation
stoch_d(cc,comm,strun)              Stochastic terms for each run
st_comm(ccplus,strun,comm,res_comm) Parameter for saving stochastic results for all runs which are commodity specific
st_cc(ccplus,strun,res_cc)          Parameter for saving stochastic results for all runs which are not comm. specific

* elasticities

elastsp(cc,i,j)         elast. supply w.r. to producer price
elastyd(cc,i,j)         elast. yield w.r. to producer price
*elastfd(cc,i,j,g)       elast. feed demand w.r. to feed prices
elastfd(cc,i,j,g)       elast. feed demand w.r. to feed prices
elasthd(cc,I,J)         elast. human demand w.r. to price
elastin(cc,I)           elast. humand demand w.r. to income

elast_y_i(cc,i)         elast. yield w.r. to intermediate costs
elast_y_l(cc,i)         elast. yield w.r. to labor costs
elast_y_f(cc,i)         elast. yield w.r. to fertilizer costs
elast_y_e(cc,i)         elast. yield w.r. to energy costs
elast_y_c(cc,i)         elast. yield w.r. to capital costs
* same data in a single parameter over exogenous cost components set:
elast_y(ecc,cc,i)       elast. yield w.r. to the different exogenous cost components

*elast_a_i(cc,i)         elast. area alloc. w.r. to intermediate costs
*elast_a_l(cc,i)         elast. area alloc. w.r. to labor costs
*elast_a_c(cc,i)         elast. area alloc. w.r. to capital costs
elast_a(ecc,cc,i)       "elast. area alloc. w.r. to different input cost types (labor, capital, intermediates, fertilizer, energy)"

elast_lv_i(cc,i)        elast. lvstk supply w.r. to intermediate costs
elast_lv_l(cc,i)        elast. lvstk supply w.r. to labor costs
elast_lv_c(cc,i)        elast. lvstk supply w.r. to capital costs
elast_lv_f(cc,i)        elast. lvstk supply w.r. to the feed cost index
* have been renamed in latest parameter set:
elast_l_i(cc,i)        elast. lvstk supply w.r. to intermediate costs
elast_l_l(cc,i)        elast. lvstk supply w.r. to labor costs
elast_l_c(cc,i)        elast. lvstk supply w.r. to capital costs
elast_l_f(cc,i)        elast. lvstk supply w.r. to the feed cost index

el_area0(cc,i,j)       elast. area alloc. w.r. to land prices

* base values of variables


HIST_AREA(one,crops,hist)

hdem0(ccplus,i)             base volume of human consumption
prod0(ccplus,i)             base volume of total production
sdem0(ccplus,i)             base volume of seed demand
fdem0(ccplus,i)             base volume of feed demand
tuse0(ccplus,i)             base volume of total demand
feed_exog(ccplus,i)         base volume of exogenours (fixed) feed demand
procdem0(ccplus,i)          base volume of processing demand
pdem_en0(ccplus,i)          base volume of processing demand for biofuels
netexp0(ccplus,i)           base volume of net exports
mrktpri0(ccplus,i)          market prices in base period
dirpay0(ccplus,i)           direct payments per ton in base period
PRICE_DEV(i)                price deviation for delayed market integration
PRICE_DEV0(i,devia)         initial price deviation for delayed market integration
area0(ccplus,i)             area allocation in base period
yield0(ccplus,i)            yield in base period
delay(cc,comm)
landprice0(cc)

Peak_LINO_Area(one)              peak area of lignocellosic biomass
Peak_LINO_Area_scen(one)              peak area of lignocellosic biomass

alpha                            diffusion paramter alpha
diff_lino                             time in the diffusion equation
T_zero                           time in peak period in the diffusion equation


*base values of policy parameter
eu_pols(i,res_pp)          data on eu policies in base period
intpr0(ccplus,i)            base value of intervention prices

cp(cp_st_,ccplus)
chg_oblsetas(ccplus)           change in oblig setaside
chg_oblsetas_cum(ccplus)       cumulative change in oblig setaside
marg_land(ccplus)              share of marginal land in obligatory setaside
map_encr1(i,j)          mapping of conventional crops to energy crops on setaside
map_encr(i,j)           mapping of conventional crops to energy crops on setaside
*base values of price margins between market and producer prices

margin0(ccplus,i)           price margins between market and producer prices

logit_scale           scaling factor in LOGIT-function (default = 1.0)
logitshift            second scaling factor in LOGIT-function (default = 1.0)
intpr(ccplus,comm)       intervention price level
thrpr(ccplus,comm)         threshold price level
thrpr0(ccplus,comm)        threshold price level in base


pol_set               Type of price formation
tar_ad                ad valorem tariff
tar_ad_0              ad valorem tariff in base period
subs_ad               ad valorem export subsidy in base period in candidate countries
subs_ad_0             ad valorem export subsidy in base period in candidate countries
sp_d                  specific duty
sp_d_0                specific duty in base period
sp_d_n                nominal specific duty
exp_sub               export subsidy
exp_sub_0             export subsidy in base period
qual_ad               quality markup
qual_ad_0             quality markup in base period
subsquant             quantity commitments in export subsidies for 2000
subsquant_0           quantity commitments in export subsidies for 2000
qualquant             high quality quantities

trq                   tariff rate quotas
chgtrq                change in tariff rate quotas
chgtrq_row            change in tariff rate quotas in Rest of World
trq0                  tariff rate quotas in base period
trq_int               intercept for variable preferential imports of sugar
trq_elast             elasticity of supply for variable preferential imports of sugar
trq_tc                cost parameter for preferential imports including transport cost differential transaction costs and cost of import-export swapping
preftrq               preferential trq for sugar - suspended after 2009
sug_imp_exog          exogenously pe-fixed sugar imports
exstab                additional support element in EU price policies
exstab_0              additional support element in EU price policies in initial situation
seed_c(cc,comm)       seed parameter seed per hectare or per tonne of cereal
sup_int               intercept in supply function (US and RoW)
area_int              intercept in area allocation function (European countries)
area_add_int_sug(cc)  additive intercept in area allocation function for sugar (negative)
area_factor_sug(cc)   factor in area allocation function for sugar
area_exponent_sug(cc) exponent in area allocation function for sugar
area_int2_sug(cc)     intercept in area allocation function for sugar to incorporate cross-price-effects
area_int3_sug(cc)     intercept in area allocation function for sugar to correct for yield
yild_int              intercept in yield function (European countries)
hdem_int              intercept in human demand function
cr_int                intercept in crushing demand (oilseed processing)
st_int                intercept in crushing demand (oilseed processing)
proc_int              intercept in milk processing demand in Non-European countries
frat_int              intercept in individual feed rate function
area_to               total agriculture area
frate_0               feed rate in base period
fc_0                  Feed Cost base period
feed_milk             Fresh milk consumed as feed per ton of produced milk

weight                weiht parameter in (artificial) objetive function
exrate_0              exchange rate in base period
newmember(c)          parameter indicating new EU member
quota                 quota volume

pdem0(cc,comm)        Processing demand in base period
pd_0(cc,comm)         Domestic price in base period
pp_0(cc,comm)         Farm-gate price in base period
pw_0                  world price level in base situation
dirpay_0              Level of direct payment in the base period
expenditure(cc)       Total consumption expenditure
pctax(cc,comm)        sales taxes for consumption
p0(cc,comm)           (exogenous) prices for consumer goods not presented in ESIM (crude oil)
chg_quota(sim,cc,ag)     Trigger to abloish quota regime

* modelling biofuels

elast_en_inp(cc,comm)      elasticity of biofuel supply w.r. to composite input price index

biof_CES_int(cc,energ)      intercept of input shares in  biofuels
biof_CES_el(cc,energ)       elasticity parameter of input demand in biofuels
biof_CES_shr(cc,energ,comm) share parameter of biobased inputs in biofuel production
BCI0(cc,comm)               biofuel cost index in base situation
shft_bioenergy(cc,comm)     shifter in biofuel demand
QUANCES0(cc,energ,comm)     input shares in biofuel production in initial situation
NetPD_0(cc,energ,comm)      Net Price in biofuel production in Base period
pay_biof                    Envelope for biofuel premia


* compensatory payments and set aside

area_gc_              area grande cultures

yield_b               base yield oilseeds EU


yield0
setas_eu15(ccplus)        setaside area in EU15 after 2004
setas_eu12(ccplus)        setaside area in EU12 after accession

subs_milk(cc,comm)    Subsistence milk production in new member states
subs_shr(cc,comm)     Share of subsistence milk production in total milk production in NMS
subs_milk0(cc,comm)   Subsistence milk production in new member states in base period
subs_milk_s(cc,comm)  Subsistence milk production in new member states
subs_milk_d(cc,comm)  Subsistence milk consumption in new member states
subs_milk_d_1(cc,comm) Subsistence milk consumption in new member states in previous period
subs_milk_s_1(cc,comm) Subsistence milk production in new member states in previous period

subs_shift(cc,comm)       Shifter on Demand Side (auxiliary parameter)
subs_shift_s(cc,comm)     Shifter on Supply Side (auxiliary parameter)



subs_milk_s0(cc,comm)  Subsistence milk production in new member states in base period
subs_milk_d0(cc,comm)  Subsistence milk consumption in new member states in base period

* Various
chk_sim          Control parameter of scenario (counting of periods)

* Read new 2006-07 data base
pp_results (i,cc,res_pp)
DP_COUP(i,ccplus) "Coupled direct payment in  € per  ha area used or t produced"
DP_DECOUP(i,ccplus) "Decoupled direct payment in  € per  ha area used or t produced"
DP_decoup_ha(ccplus,dp_star) "Decoupled direct payments by member state average 06/07, in €/ha"
DP_coup_ha(ccplus,i) "Coupled direct payments by member state average 06/07, in €/ha"
DP_coup_env(ccplus,i) "Coupled direct payments by member state average 06/07, in Mio € for animal products"
Art_69_env(ccplus,i) "LVSTK: Art. 69 payments by member state average 06/07, in million €"
Art_69_ha(ccplus,i) "CROPS: Art. 69 payments by member state average 06/07, in €/ha"
CNDP_ha(ccplus,i) "Nat. top-ups CROPS payments member state average 06/07, in €/ha"
CNDP_env(ccplus,i) "Nat. top-ups LVSTK payments member state average 06/07, in million €"

Envelop_total
Envelop_total_ha

DP_EU_contrib_nms(ccplus,comm)
DP_Nat_Topup_nms(ccplus,comm)
DP_Nat_contrib_nms(ccplus,comm)

ENVELOP_coup_ha(EU15,CROPS)     Envelope for decoupling coupled area payments
ENVELOP_coup_env(cc,LIVEST)
ENVELOP_Art_69_ha(EU15,CROPS)  'Envelope for decoupling coupled area payments, Art. 69 payments'
ENVELOP_Art_69_env(cc,LIVEST) Envelope for decoupling coupled livestock payments



dp_change(cc,comm,sim)  Change in DP per Member State
art_change(cc,comm,sim) Change in Art 69 paments per Member State
Artificial_value(cc)    Artificial para for the handling of changes in direct payment for Artikel 68


consolid_area(i,ccplus) "Consolidated area data, avg. 2006 and 2007, in 1000 ha"

show_data(i,data_base,ccplus) "Consolidated data base, in 1000 t"
crops_to_ethanol(ethanol_inputs) "Proc. coeff. cropsp to ethanol, (Source: KTBL(2008) Faustzahlen für Landwirtschaft)"
input_biodiesel(ccplus,i) Input shares in biodiesel production in percent
input_ethanol(ccplus,i) Input shares in ethanol production in percent
dairy_pdem(dairy_comm,dairy_inputs,ccplus)  Required fat and protein in the dairy sectors


* New parameters to save results
*# To be "peep tagged"
r_comm(ccplus,sim,comm,res_comm) Parameter for solving all results which are commodity specific
r_cc(ccplus,sim,res_cc)          Parameter for solving all results which are not comm. specific
r_core_res(ccplus,res_core,comm,sim) Parameter for storing core results

exp_share(cc,comm)   Exp. shares of single ESIM products in total exp. in base
texp_share(cc)       Exp. share of total ESIM products in total exp. in base
r_pw(sim,it)         World market price
r_er(cc,sim)         Exchange rates


* This should also be peep tagged but although it is calculated it is more an input than an output from a users point of view
elasthd_c(cc,i,j)                Compensated price elasticities of human demand

;

Scalar
oil_to_diesel "Proc. coeff. veget. oil to diesel, (Source: KTBL(2008) Faustzahlen für Landwirtschaft)"
;




* <%INPUT%>
scalar endog_sug Choice of endogenous or fixed preferential sugar imports /2/;
* <%FORMAT #,###,##0.##%>
* <%USERLEVEL 3%>
* <%BOUNDS%>
*  1 2
* <%ENDBOUNDS%>

* 2.0 = endogenous sugar imports (default option)
* 1.0 = exogenously pre-defined sugar imports
* <%ENDINFO%>
* <%/INPUT%>

* <%INPUT%>
scalar stochastics "Switch for stochastic version of ESIM"/1/;
* <%FORMAT #,###,##0%>
* <%USERLEVEL 1%>
* <%BOUNDS%>
* 1 2
* <%ENDBOUNDS%>

* 1 = Stochastic part of ESIM switched off (default option)
* 2 = Stochastic part of ESIM switched on
* <%ENDINFO%>
* <%/INPUT%>

ENVELOP_coup_ha(EU15,CROPS)     = 0.0;
ENVELOP_Art_69_ha(EU15,CROPS)   = 0.0;
ENVELOP_Art_69_env(eu15,LIVEST) = 0.0;
