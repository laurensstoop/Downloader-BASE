# Modified from UCAR standard script
#
# authenticate - NOTE: You should only execute this command ONE TIME.
# Executing this command for every data file you download may cause
# your download privileges to be suspended.
wget $cert_opt -O auth_status.rda.ucar.edu --save-cookies auth.rda.ucar.edu.$$ --post-data="email=l.p.stoop@uu.nl&passwd=$1&action=login" https://rda.ucar.edu/cgi-bin/login
#
# download the file(s)
# NOTE:  if you get 403 Forbidden errors when downloading the data files, check
#        the contents of the file 'auth_status.rda.ucar.edu'
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds628.0/fcst_surf/1958/fcst_surf.011_tmp.reg_tl319.1958010100_1958033121
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds628.0/fcst_surf/1958/fcst_surf.033_ugrd.reg_tl319.1958010100_1958033121
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds628.0/fcst_surf/1958/fcst_surf.034_vgrd.reg_tl319.1958010100_1958033121
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds628.0/fcst_phy2m/1958/fcst_phy2m.204_dswrf.reg_tl319.1958010100_1958033121
#
# clean up
rm auth.rda.ucar.edu.$$ auth_status.rda.ucar.edu
