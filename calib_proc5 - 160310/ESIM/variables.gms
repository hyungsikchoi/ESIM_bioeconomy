*===  DEFINITION OF VARIABLES ===

POSITIVE VARIABLES

SUPPLY(cc,comm)      Supply

* AREA DISTRIBUTION

ALAREA(cc,comm)       Allocation of area in respect to commodity prices irrespective of availability
EFAREA(cc,comm)       Area constraint by total area available and set aside
AREA_UN(cc)           Area unconstraint
EFAREA_GC(cc)         Effective  total area grandes cultures
DIRPAY(cc,comm)       Direct payments
OBLSETAS(cc)          Obligatory set aside
LANDPRICE1(cc)        Price of land per hectare (for non setaside land)
LANDSUPPLY1(cc)       Total amount of UAA (for non setaside land)
Q_NEW1(cc)            Asymptote in land function (for non setaside land)

* YIELD

YIELD(cc,comm)        Yield in arable crop production

* Diffusion of crops

DIFF(cc,comm)        Diffustion of ligno crops in agricultural area


* LIVESTOCK

FRATE(cc,feed,livest)  Feed Rate for Animals
FCI(cc,comm)           Feed Cost Index

* DOMESTIC USE

HDEM(cc,comm)        Human demand
SDEM(cc,comm)        Seed demand
TUSE(cc,comm)        Total domestic use
FDEM(cc,comm)        Feed demand
FDEM_MLK(cc,comm)    Feed demand MILK
PDEM(cc,comm)        Processing demand
PDEM_BF(cc,energ,comm) Demand of inputs in biofuel production
MPDEM(cc,comm,comm)  Demand for raw milk for processing into dairy products

* PRICES

PD(cc,comm)          Domestic market prices
PC(cc,comm)          Domestic market prices at consumer level
NetPD(cc,energ,comm) Net-prices for input in biofuel production
PP(cc,comm)          Producer prices
PI(cc,comm)          Producer incentive price (farm-gate price plus premium)
PW(it)               World market price for tradeable commodities

P_LO(cc,it)          Lower Price bound in LOGIT-Function
P_UP(cc,it)          Upper Price bound in LOGIT-Function
P_UP_2(cc,it)        Upper Price bound in LOGIT-Function for subsidized exports quantities

BCI(cc,comm)        Price index in biofuel production

TRQSHR(cc,comm)      Share of TRQ in total domestic use in EU
SUBSHR(cc,comm)      Share of subsidized export quantities in total domestic use in EU
QUALSHR(cc,comm)     Share of high quality export quantities in total domestic use in EU

PSH(cc,comm)         Shadow prices for quota products
QUOTARENT(cc,comm)   Quota rent for MCP formulation of quotas

QUANCES(cc,energ,comm) Input quantities (unscaled) in biofuel production
;

FREE VARIABLES
NETEXP(cc,comm)      Net exports as a residual of supply and domestic use
TRADESHR(cc,comm)    Share of net-exports in total use or supply
TRADESHR_D(comm)     Trade share for Commodities which are excluded from full integration into Single Market

TRADESHR_EU(comm)    Share of net-exports in total use in aggregated EU-15 member states
TRQSHR_EU(comm)
SUGIMP_EU(comm)      Preferential sugar imports (either endogenous or exogenously fixed

SUBSHR_EU(comm)
QUALSHR_EU(comm)
;
