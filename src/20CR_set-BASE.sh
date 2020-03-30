# Laurens Stoop l.p.stoop@uu.nl
#
# 

### Run in the origin folder the following commandline, the selparam remove the single height (sfc/2m/10m) info from the dimensions
for filename in ./air* ;do
   cdo -f nc copy -sellonlatbox,-31,74.25,34.5,80 -selparam,-1 $filename /media/stoop/DataFiles/20CR/europe/$filename
done 
for filename in ./dswrf* ;do
   cdo -f nc copy -sellonlatbox,-31,74.25,34.5,80 -selparam,-1 $filename /media/stoop/DataFiles/20CR/europe/$filename
done 
for filename in ./uwnd* ;do
   cdo -f nc copy -sellonlatbox,-31,74.25,34.5,80 -selparam,-1 $filename /media/stoop/DataFiles/20CR/europe/$filename
done 
for filename in ./vwnd* ;do
   cdo -f nc copy -sellonlatbox,-31,74.25,34.5,80 -selparam,-1 $filename /media/stoop/DataFiles/20CR/europe/$filename
done 








### Run in the europe folder
for Y in $(seq 1836 2015);do 
    # Fix the variables for the radiation
    cdo chname,dswrf,ssrd dswrf.sfc.$Y.nc /media/stoop/DataFiles/20CR/20CR-EU_BASE/20CR-EU_ssrd_$Y.nc

    # Rename the attributes and set the variables attributes for windspeed
    ncatted -O -a map_area,global,o,c,"Europe" -h /media/stoop/DataFiles/20CR/20CR-EU_BASE/20CR-EU_ssrd_$Y.nc
    ncatted -O -a experiment,global,o,c,"Model: 20CR" -h /media/stoop/DataFiles/20CR/20CR-EU_BASE/20CR-EU_ssrd_$Y.nc
    ncatted -O -a author,global,a,c,"; Laurens Stoop, UU/KNMI/TenneT" -h /media/stoop/DataFiles/20CR/20CR-EU_BASE/20CR-EU_ssrd_$Y.nc
    ncatted -O -a email,global,a,c,"; l.p.stoop@uu.nl" -h /media/stoop/DataFiles/20CR/20CR-EU_BASE/20CR-EU_ssrd_$Y.nc
    ncatted -O -a long_name,t2m,o,c,"Downward short-wave radiation flux masked for European region" -h /media/stoop/DataFiles/20CR/20CR-EU_BASE/20CR-EU_ssrd_$Y.nc
    ncatted -O -a short_name,t2m,o,c,"ssrd" -h /media/stoop/DataFiles/20CR/20CR-EU_BASE/20CR-EU_ssrd_$Y.nc
    ncatted -O -a history,global,d,, -h /media/stoop/DataFiles/20CR/20CR-EU_BASE/20CR-EU_ssrd_$Y.nc
done

for Y in $(seq 1836 2015);do 
    # Fix the variables for the temperature
    cdo chname,air,t2m -addc,-273.15 air.2m.$Y.nc /media/stoop/DataFiles/20CR/20CR-EU_BASE/20CR-EU_t2m_$Y.nc

    # Rename the attributes and set the variables attributes for windspeed
    ncatted -O -a map_area,global,o,c,"Europe" -h /media/stoop/DataFiles/20CR/20CR-EU_BASE/20CR-EU_t2m_$Y.nc
    ncatted -O -a experiment,global,o,c,"Model: 20CR" -h /media/stoop/DataFiles/20CR/20CR-EU_BASE/20CR-EU_t2m_$Y.nc
    ncatted -O -a author,global,a,c,"; Laurens Stoop, UU/KNMI/TenneT" -h /media/stoop/DataFiles/20CR/20CR-EU_BASE/20CR-EU_t2m_$Y.nc
    ncatted -O -a email,global,a,c,"; l.p.stoop@uu.nl" -h /media/stoop/DataFiles/20CR/20CR-EU_BASE/20CR-EU_t2m_$Y.nc
    ncatted -O -a long_name,t2m,o,c,"Temperature at 2 meter masked for European region" -h /media/stoop/DataFiles/20CR/20CR-EU_BASE/20CR-EU_t2m_$Y.nc
    ncatted -O -a short_name,t2m,o,c,"t2m" -h /media/stoop/DataFiles/20CR/20CR-EU_BASE/20CR-EU_t2m_$Y.nc
    ncatted -O -a units,t2m,o,c,"degC" -h /media/stoop/DataFiles/20CR/20CR-EU_BASE/20CR-EU_t2m_$Y.nc
    ncatted -O -a history,global,d,, -h /media/stoop/DataFiles/20CR/20CR-EU_BASE/20CR-EU_t2m_$Y.nc
done

for Y in $(seq 1836 2015);do 
    # Fix the variables for the windspeed
    cdo chname,uwnd,wspd -sqrt -add -sqr uwnd.10m.$Y.nc -sqr vwnd.10m.$Y.nc.nc /media/stoop/DataFiles/20CR/20CR-EU_BASE/20CR-EU_wspd_$Y.nc
    # Rename the attributes and set the variables attributes for windspeed
    ncatted -O -a map_area,global,o,c,"Europe" -h /media/stoop/DataFiles/20CR/20CR-EU_BASE/20CR-EU_wspd_$Y.nc
    ncatted -O -a experiment,global,o,c,"Model: 20CR" -h /media/stoop/DataFiles/20CR/20CR-EU_BASE/20CR-EU_wspd_$Y.nc
    ncatted -O -a author,global,a,c,"; Laurens Stoop, UU/KNMI/TenneT" -h /media/stoop/DataFiles/20CR/20CR-EU_BASE/20CR-EU_wspd_$Y.nc
    ncatted -O -a email,global,a,c,"; l.p.stoop@uu.nl" -h /media/stoop/DataFiles/20CR/20CR-EU_BASE/20CR-EU_wspd_$Y.nc
    ncatted -O -a long_name,wspd,o,c,"Windspeed at 10 meter masked for European region" -h /media/stoop/DataFiles/20CR/20CR-EU_BASE/20CR-EU_wspd_$Y.nc
    ncatted -O -a short_name,wspd,o,c,"wspd" -h /media/stoop/DataFiles/20CR/20CR-EU_BASE/20CR-EU_wspd_$Y.nc
    ncatted -O -a history,global,d,, -h /media/stoop/DataFiles/20CR/20CR-EU_BASE/20CR-EU_wspd_$Y.nc
done


