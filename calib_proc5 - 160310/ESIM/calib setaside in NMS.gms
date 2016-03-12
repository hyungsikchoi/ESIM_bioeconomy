

*****************************************************
* Setaside Requirements in the NMS                  *
* For EU-10 never implemented                       *
* For EU-02 never implemented                       *
* IMPORTANT:                                        *
* These assumptions MUST be synchronized            *
* with the entries in the excel file SETAS-AREA.XLS *
*                                                   *
*                                                   *
*                                                   *
* Abolition of mandatory setaside from 2008 also in *
* EU15                                              *
*                                                   *
*****************************************************




LOOP(eu15,
  IF((abs_setas_area(eu15,sim_run)*1000) eq 0.0 ,

OBLSETAS.FX(eu15) = 0.0;


     );







  IF((abs_setas_area(eu15,sim_run)*1000) gt 0.0 ,

OBLSETAS.up(eu15) = +inf;
OBLSETAS.lo(eu15) = 0.0;


     );


  );

* Setaside Requirements
IF(ORD(sim_run) gt 1.0,
setas_eu15(eu15)  = abs_setas_area(eu15,sim_run)*1000 ;
chg_oblsetas(eu15) = (abs_setas_area(eu15,sim_run-1)*1000) - (abs_setas_area(eu15,sim_run)*1000);
chg_oblsetas_cum(eu15) = chg_oblsetas_cum(eu15) + chg_oblsetas(eu15);
chg_oblsetas(eu15)$(chg_oblsetas(eu15) lt 0) = 0;
OBLSETAS.l(eu15) = setas_eu15(eu15);
);
