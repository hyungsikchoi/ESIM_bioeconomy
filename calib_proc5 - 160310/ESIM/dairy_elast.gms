


***Fat and Proteine demand elasticities
Parameter
dairy_el(cc,i,j,comm);


$GDXin Database_GDX\dairy_el.gdx
$load  dairy_el
$GDXIN

*# milk

elastdm_n(cc,'fat',mlkproc,comm)     = dairy_el(cc,mlkproc,"fat",comm);
elastdm_n(cc,'protein',mlkproc,comm) = dairy_el(cc,mlkproc,"protein",comm);

*** for CAPRI

*elastdm_n('IT','fat',mlkproc,comm)     = dairy_el('ES',mlkproc,"fat",comm);
*elastdm_n('IT','protein',mlkproc,comm) = dairy_el('ES',mlkproc,"protein",comm);

display elastdm_n;
