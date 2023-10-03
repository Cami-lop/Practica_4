dset ^data.r4  
undef -999  
title monthly temperature (land only)  
*produced by IRI  
ydef 181 linear -90.000000 1.000  
xdef 360 linear 0.000000 1.000000  
tdef 348 linear Jan1982 1mo  
zdef 1 linear 1 1  
vars 1  
t2m 0 81,1,0  \*\* mean temperature over land (celcius)  
ENDVARS 
