# Laurens Stoop l.p.stoop@uu.nl / laurensstoop.nl
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
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.1/2011/tmp2m.gdas.201101.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.1/2011/tmp2m.gdas.201102.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.1/2011/tmp2m.gdas.201103.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.1/2011/tmp2m.cdas1.201104.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.1/2011/tmp2m.cdas1.201105.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.1/2011/tmp2m.cdas1.201106.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.1/2011/tmp2m.cdas1.201107.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.1/2011/tmp2m.cdas1.201108.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.1/2011/tmp2m.cdas1.201109.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.1/2011/tmp2m.cdas1.201110.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.1/2011/tmp2m.cdas1.201111.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.1/2011/tmp2m.cdas1.201112.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.1/2012/tmp2m.cdas1.201201.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.1/2012/tmp2m.cdas1.201202.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.1/2012/tmp2m.cdas1.201203.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.1/2012/tmp2m.cdas1.201204.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.1/2012/tmp2m.cdas1.201205.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.1/2012/tmp2m.cdas1.201206.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.1/2012/tmp2m.cdas1.201207.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.1/2012/tmp2m.cdas1.201208.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.1/2012/tmp2m.cdas1.201209.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.1/2012/tmp2m.cdas1.201210.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.1/2012/tmp2m.cdas1.201211.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.1/2012/tmp2m.cdas1.201212.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.1/2013/tmp2m.cdas1.201301.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.1/2013/tmp2m.cdas1.201302.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.1/2013/tmp2m.cdas1.201303.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.1/2013/tmp2m.cdas1.201304.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.1/2013/tmp2m.cdas1.201305.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.1/2013/tmp2m.cdas1.201306.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.1/2013/tmp2m.cdas1.201307.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.1/2013/tmp2m.cdas1.201308.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.1/2013/tmp2m.cdas1.201309.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.1/2013/tmp2m.cdas1.201310.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.1/2013/tmp2m.cdas1.201311.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.1/2013/tmp2m.cdas1.201312.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.1/2014/tmp2m.cdas1.201401.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.1/2014/tmp2m.cdas1.201402.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.1/2014/tmp2m.cdas1.201403.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.1/2014/tmp2m.cdas1.201404.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.1/2014/tmp2m.cdas1.201405.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.1/2014/tmp2m.cdas1.201406.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.1/2014/tmp2m.cdas1.201407.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.1/2014/tmp2m.cdas1.201408.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.1/2014/tmp2m.cdas1.201409.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.1/2014/tmp2m.cdas1.201410.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.1/2014/tmp2m.cdas1.201411.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.1/2014/tmp2m.cdas1.201412.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.1/2015/tmp2m.cdas1.201501.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.1/2015/tmp2m.cdas1.201502.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.1/2015/tmp2m.cdas1.201503.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.1/2015/tmp2m.cdas1.201504.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.1/2015/tmp2m.cdas1.201505.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.1/2015/tmp2m.cdas1.201506.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.1/2015/tmp2m.cdas1.201507.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.1/2015/tmp2m.cdas1.201508.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.1/2015/tmp2m.cdas1.201509.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.1/2015/tmp2m.cdas1.201510.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.1/2015/tmp2m.cdas1.201511.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.1/2015/tmp2m.cdas1.201512.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.1/2016/tmp2m.cdas1.201601.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.1/2016/tmp2m.cdas1.201602.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.1/2016/tmp2m.cdas1.201603.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.1/2016/tmp2m.cdas1.201604.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.1/2016/tmp2m.cdas1.201605.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.1/2016/tmp2m.cdas1.201606.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.1/2016/tmp2m.cdas1.201607.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.1/2016/tmp2m.cdas1.201608.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.1/2016/tmp2m.cdas1.201609.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.1/2016/tmp2m.cdas1.201610.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.1/2016/tmp2m.cdas1.201611.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.1/2016/tmp2m.cdas1.201612.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.1/2017/tmp2m.cdas1.201701.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.1/2017/tmp2m.cdas1.201702.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.1/2017/tmp2m.cdas1.201703.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.1/2017/tmp2m.cdas1.201704.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.1/2017/tmp2m.cdas1.201705.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.1/2017/tmp2m.cdas1.201706.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.1/2017/tmp2m.cdas1.201707.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.1/2017/tmp2m.cdas1.201708.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.1/2017/tmp2m.cdas1.201709.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.1/2017/tmp2m.cdas1.201710.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.1/2017/tmp2m.cdas1.201711.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.1/2017/tmp2m.cdas1.201712.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.1/2018/tmp2m.cdas1.201801.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.1/2018/tmp2m.cdas1.201802.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.1/2018/tmp2m.cdas1.201803.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.1/2018/tmp2m.cdas1.201804.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.1/2018/tmp2m.cdas1.201805.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.1/2018/tmp2m.cdas1.201806.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.1/2018/tmp2m.cdas1.201807.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.1/2018/tmp2m.cdas1.201808.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.1/2018/tmp2m.cdas1.201809.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.1/2018/tmp2m.cdas1.201810.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.1/2018/tmp2m.cdas1.201811.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.1/2018/tmp2m.cdas1.201812.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.1/2019/tmp2m.cdas1.201901.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.1/2019/tmp2m.cdas1.201902.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.1/2019/tmp2m.cdas1.201903.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.1/2019/tmp2m.cdas1.201904.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.1/2019/tmp2m.cdas1.201905.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.1/2019/tmp2m.cdas1.201906.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.1/2019/tmp2m.cdas1.201907.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.1/2019/tmp2m.cdas1.201908.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.1/2019/tmp2m.cdas1.201909.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.1/2019/tmp2m.cdas1.201910.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.1/2019/tmp2m.cdas1.201911.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.1/2019/tmp2m.cdas1.201912.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.1/2020/tmp2m.cdas1.202001.grb2
wget $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.1/2020/tmp2m.cdas1.202002.grb2
#
# clean up
rm auth.rda.ucar.edu.$$ auth_status.rda.ucar.edu
