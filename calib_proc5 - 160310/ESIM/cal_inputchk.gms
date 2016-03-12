* some consistency checks on the user target input

*++++++++++++++++++++++++++++++++++++++++++++
*+ CHECK VALIDITY OF QUOTA PRODUCT TARGETS: +
*+ (only vaguely for MILK)                  +
*++++++++++++++++++++++++++++++++++++++++++++
rest_quota_agg(EU15EU12, comm, sim_run)$(SUPPLY_CS(EU15EU12,comm) AND sum(EUGRPMEM(EU15EU12,cc),QU(cc,comm))) =
                 sum(EUGRPMEM(EU15EU12,cc), quota(cc,comm)+(sum(sim_run2$(ord(sim_run2)=(ord(sim_run)-1)),simres('FDEM_MLK',cc,comm,sim_run2))+subs_milk_s(cc,comm))$sameas('MILK',comm))
                 - SUPPLYGRP.L(EU15EU12,comm);
rest_quota_agg(EU15EU12, comm, 'base')=0;
quota_agg(EU15EU12, comm, sim_run) = sum(EUGRPMEM(EU15EU12,cc), quota(cc,comm));
display rest_quota_agg, quota_agg;
loop((EU15EU12,COMM),
   if (rest_quota_agg(EU15EU12,COMM, sim_run)<0, abort "USER INPUT ERROR: Supply target exceeds quota limit! See PARAMETER rest_quota_agg.",rest_quota_agg);
);
*++++++++++++++++++++++++++++++++++++++++++++
*++++++++++++++++++++++++++++++++++++++++++++

*++++++++++++++++++++++++++++++++++++
*+ CHECK VALIDITY OF TARGET VALUES: +
*+ (only in base period)            +
*++++++++++++++++++++++++++++++++++++
if (sameas(sim_run,'base'),
   loop((cc,comm),
      if(SUPPLY.L(cc,comm)<0, abort "User input error: SUPPLY target value <0");
   );

   CHK_HDEMAGG(EUGRP,comm) = sum(cc$EUGRPMEM(EUGRP,cc),HDEM.L(cc,comm));
   CHK_FDEMAGG(EUGRP,comm) = sum(cc$EUGRPMEM(EUGRP,cc),FDEM.L(cc,comm));
   CHK_PDEMAGG(EUGRP,comm) = sum(cc$EUGRPMEM(EUGRP,cc),PDEM.L(cc,comm));
   CHK_TUSEAGG(EUGRP,comm) = sum(cc$EUGRPMEM(EUGRP,cc),TUSE.L(cc,comm));
   DEMSHR(EUGRP,comm,"HDEM")$CHK_TUSEAGG(EUGRP,comm) = sum(cc$EUGRPMEM(EUGRP,cc),HDEM.L(cc,comm)) / CHK_TUSEAGG(EUGRP,comm);
   DEMSHR(EUGRP,comm,"FDEM")$CHK_TUSEAGG(EUGRP,comm) = sum(cc$EUGRPMEM(EUGRP,cc),FDEM.L(cc,comm)) / CHK_TUSEAGG(EUGRP,comm);
   DEMSHR(EUGRP,comm,"PDEM")$CHK_TUSEAGG(EUGRP,comm) = sum(cc$EUGRPMEM(EUGRP,cc),PDEM.L(cc,comm)) / CHK_TUSEAGG(EUGRP,comm);
   DEMSHR(EUGRP,comm,"SDEM")$CHK_TUSEAGG(EUGRP,comm) = sum(cc$EUGRPMEM(EUGRP,cc),SDEM.L(cc,comm)) / CHK_TUSEAGG(EUGRP,comm);
   DEMSHR(EUGRP,comm,"NETEXP")$CHK_TUSEAGG(EUGRP,comm) = sum(cc$EUGRPMEM(EUGRP,cc),NETEXP.L(cc,comm)) / CHK_TUSEAGG(EUGRP,comm);

   display CHK_HDEMAGG, CHK_FDEMAGG, CHK_PDEMAGG, CHK_TUSEAGG, tusegrp.l, DEMSHR;

   loop(EUGRP,
      if (TUSE_CS(EUGRP, 'RAPSEED'),
         abort "User input problem: TUSE for RAPSEED cannot be calibrated."
      );
*     if (SUPPLY_CS(EUGRP, 'MANIOC'),
*         abort "User input problem: EU SUPPLY for MANIOC cannot be calibrated as there is no supply for MANIOC."
*      );
   );
);
*++++++++++++++++++++++++++++++++++++
*++++++++++++++++++++++++++++++++++++
