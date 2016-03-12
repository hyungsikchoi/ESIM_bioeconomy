
$include "calibration-data.gms"

$include "assign-dynamic-sets.gms"

$include "calibration-para.gms"



*fdem_tr(cc,feed) ]$FD(cc,feed);

display fdem_tr, fd, feed,qu, nq,lag_weight,margin0,volsaq,addcomp_dairy,supply.l;
