*
* DEFINITION OF DYNAMIC SETS
*

LINO(cc,'LINO')      =YES$ALAREA.l(cc,'LINO');
STRA(cc,'stra') = yes $(SUPPLY.L(cc,'stra'));
display stra;

PR(CC,COMM)        = YES$SUPPLY.L(CC,COMM);
PR_EU(COMM)        = YES$SUM(one$(member(one) and europe(one)), SUPPLY.L(ONE,COMM));

PPF(CC,COMM)       = YES$FDEM.L(CC,COMM);
PPC(CC,COMM)       = YES$(HDEM.L(CC,COMM) or P0(CC,COMM));
HD(CC,COMM)        = YES$HDEM.L(CC,COMM);

HD_(CC,COMM)        = YES$HDEM.L(CC,COMM);
HD_(ceec,"beef")     = NOT HDEM.L(ceec,"beef");
HD_(cc,"potato")     = NOT hdem.l(cc,"potato");
HD_RAPEU(eu25,"rapoil")  = YES$hdem.l(eu25,"rapoil");
HD_POTATO(CC,"potato")  = YES$hdem.l(cc,"potato");
HD_CECBF(CC,"beef")  = YES$hdem.l(cc,"beef")$CEEC(CC);

FD(CC,FEED)        = YES$FDEM.L(CC,FEED);
PROC(CC,COMM)      = YES$PDEM.L(CC,COMM);
SEED(CC,CROPS)     = YES$SDEM.L(CC,CROPS);
NQ(REST,COMM)      = YES$(QUOTA(REST,COMM) EQ 0.0);
NQ(ONE,COMM)       = YES$(QUOTA(ONE,COMM) EQ 0.0);
NQ(CC,'SETASIDE') = NO;

QU(ONE,COMM)       = YES$(QUOTA(ONE,COMM) NE 0.0);
QU_NOSA(ONE,"SUGAR") = YES$(QUOTA(ONE,"SUGAR"));
QU_NOSA(ONE,"MILK")  = YES$(QUOTA(ONE,"MILK"));
QU_SUGAR(ONE,"SUGAR")= YES$QUOTA(ONE,"SUGAR");
QU_S(ONE)          = YES$QUOTA(ONE,"SUGAR");
NQ_S(CC)           = NOT QU_S(CC);
QU_M(ONE)          = YES$QUOTA(ONE,"MILK");
NQ_M(CC)           = NOT QU_M(CC);

NX(ONE,COMM)       = YES$NETEXP.L(ONE,COMM);
NX_EU(COMM)        = YES$SUM(one$(member(one) and europe(one)), NETEXP.L(ONE,COMM));

EXPSUB(ONE,IT)     = YES$(qual_ad(one,it) or exp_sub(one,it));
NEXPSUB(ONE,IT)    = NOT EXPSUB(ONE,IT);

OILSPROC(CC,OSPRO)       = YES$SUPPLY.L(CC,OSPRO);
PROC_CER_S(cc,"SUGAR")      = YES$PDEM.l(CC,"SUGAR");
PROC_CER_S(cc,"CWHEAT")     = YES$PDEM.l(CC,"CWHEAT");
PROC_CER_S(cc,"CORN")       = YES$PDEM.l(CC,"CORN");

***NEW for ESIM-CAPRI
PROC_CER_S(cc,"RYE")       = YES$PDEM.l(CC,"RYE");
PROC_CER_S(cc,"OTHGRA")       = YES$PDEM.l(CC,"OTHGRA");
PROC_CER_S(cc,"BARLEY")       = YES$PDEM.l(CC,"BARLEY");

PROC_OIL_D(cc,"RAPOIL")     = YES$PDEM.l(CC,"RAPOIL");
PROC_OIL_D(cc,"SUNOIL")     = YES$PDEM.l(CC,"SUNOIL");
PROC_OIL_D(cc,"PALMOIL")    = YES$PDEM.l(CC,"PALMOIL");
PROC_OIL_D(cc,"SOYOIL")    = YES$PDEM.l(CC,"SOYOIL");

FEDRES(CC,FEEDRES)       = YES$SUPPLY.L(CC,FEEDRES);
MILKPROC(CC,MLKPROC)     = YES$SUPPLY.L(CC,MLKPROC);
MILK_CONT(cc,comm)       = YES$content_milk(cc,comm);
MILK_(cc,'MILK')           = YES$PDEM.L(CC,'MILK');

MILKPROC_exSMP(cc,MLKPROC)  = YES$SUPPLY.L(CC,MLKPROC);

MILKPROC_exSMP(cc,comm)  = NOT SUPPLY.L(CC,"SMP");

SMP(CC,"SMP")            = YES$SUPPLY.L(CC,"SMP");
PROC_OIL(CC,"SOYBEAN")   = YES$PDEM.L(CC,"SOYBEAN");
PROC_OIL(CC,"RAPSEED")   = YES$PDEM.L(CC,"RAPSEED");
PROC_OIL(CC,"SUNSEED")   = YES$PDEM.L(CC,"SUNSEED");
PROC_MLK(CC,"MILK")      = YES$PDEM.L(CC,"MILK");

PROC_DAIRY(cc,dairy_comp,mlkproc)   =  YES$MPDEM.l(cc,dairy_comp,mlkproc);

FD_MLK(CC)               = YES$FDEM_MLK.L(CC,"MILK");
CER_N_DURUM(ONE,CER_ND)  = YES$SUPPLY.L(ONE,CER_ND);
*CER_DURUM(ONE,"DURUM")   = YES$SUPPLY.L(ONE,"DURUM");
CER_OIL(ONE,OILSEED)     = YES$SUPPLY.L(ONE,OILSEED);
PAST(CC,"GRAS")          = YES$SUPPLY.L(CC,"GRAS");

NPAST(CC,CROPS)          = NOT PAST(CC,CROPS);
VOLSAQ(ONE,"SETASIDE")    = YES$(SUPPLY.L(ONE,"SETASIDE") and DP_POLS(one,'ag2000') eq 1.0) ;
VOLSA(ONE,"SETASIDE")     = YES$(SUPPLY.L(ONE,"SETASIDE")) ;



SFP__REG(ONE)            = 0.0;
*ONELAG(ONE,COMM)$(CROPS(COMM) and IT(COMM))  = YES$SUPPLY.L(ONE,COMM);
*ONELAG_LV(ONE,"PORK")       = YES$SUPPLY.L(ONE,"PORK");
*ONELAG_LV(ONE,"EGGS")       = YES$SUPPLY.L(ONE,"EGGS");
*ONELAG_LV(ONE,"POULTRY")    = YES$SUPPLY.L(ONE,"POULTRY");
*ONELAG_LV(ONE,"SHEEP")      = YES$SUPPLY.L(ONE,"SHEEP");
*TWOLAG(ONE,"BEEF")       = YES$SUPPLY.L(ONE,"BEEF");
*TWOLAG(ONE,"MILK")       = YES$SUPPLY.L(ONE,"MILK");
*NOLAG(CC,AG)             = NOT (ONELAG(CC,AG) OR (TWOLAG(CC,AG) OR ONELAG_LV(CC,AG)));
*NOLAG(CC,AG)             = NOT ONELAG(CC,AG);
NOLAG(CC,COMM)             = YES$SUPPLY.l(CC,COMM);
AGENDA(ONE)               = YES;
MTR(ONE)                  = NO;
nolag(cc,'sugar') = YES;
onelag(cc,'sugar') = NO;

i_biofuel('biodiesel',i_diesel)       = YES;
i_biofuel('ethanol',i_ethanol)        = YES;

