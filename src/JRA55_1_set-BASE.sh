# Laurens Stoop l.p.stoop@uu.nl / laurensstoop.nl
#
# Not very clean, but it works. 

### Run in the origin folder the following commandline
for filename in ./fcst_phy2m.204* ;do
   cdo -f nc copy -sellonlatbox,-31,74.25,34.5,80 $filename $filename.nc
   cdo select,name=dswrf $filename.nc /media/DataDrive/JRA55/netcdf/$filename.nc
done 
for filename in ./fcst_surf.011* ;do
   cdo -f nc copy -sellonlatbox,-31,74.25,34.5,80 $filename /media/DataDrive/JRA55/netcdf/$filename.nc
done 
for filename in ./fcst_surf.033* ;do
   cdo -f nc copy -sellonlatbox,-31,74.25,34.5,80 $filename /media/DataDrive/JRA55/netcdf/$filename.nc
done 
for filename in ./fcst_surf.034* ;do
   cdo -f nc copy -sellonlatbox,-31,74.25,34.5,80 $filename /media/DataDrive/JRA55/netcdf/$filename.nc
done 





### Run in the netcdf folder
for Y in $(seq 1958 2018);do 
    cdo mergetime fcst_phy2m.204_dswrf.reg_tl319.$Y*.nc /media/DataDrive/JRA55/vars/JRA55-EU_ssrd_$Y.nc
done

for Y in $(seq 1958 2018);do 
    cdo mergetime fcst_surf.011_tmp.reg_tl319.$Y*.nc /media/DataDrive/JRA55/vars/JRA55-EU_t2m_$Y.nc
done

for Y in $(seq 1958 2018);do 
    cdo mergetime fcst_surf.033_ugrd.reg_tl319.$Y*.nc /media/DataDrive/JRA55/vars/JRA55-EU_u10_$Y.nc
done

for Y in $(seq 1958 2018);do 
    cdo mergetime fcst_surf.034_vgrd.reg_tl319.$Y*.nc /media/DataDrive/JRA55/vars/JRA55-EU_v10_$Y.nc
done







### Run in the Vars folder

for Y in $(seq 1958 2018);do 
    # Fix the variables for the radiation
    cdo chname,dswrf,ssrd -settaxis,$Y-01-01,00:00:00,3hours JRA55-EU_ssrd_$Y.nc /media/DataDrive/JRA55/JRA55-EU_BASE/JRA55-EU_ssrd_$Y.nc
    # Rename the attributes and set the variables attributes for windspeed
    ncatted -O -a map_area,global,o,c,"Europe" -h /media/DataDrive/JRA55/JRA55-EU_BASE/JRA55-EU_ssrd_$Y.nc
    ncatted -O -a experiment,global,o,c,"Model: JRA55" -h /media/DataDrive/JRA55/JRA55-EU_BASE/JRA55-EU_ssrd_$Y.nc
    ncatted -O -a author,global,a,c,"; Laurens Stoop, UU/KNMI/TenneT" -h /media/DataDrive/JRA55/JRA55-EU_BASE/JRA55-EU_ssrd_$Y.nc
    ncatted -O -a email,global,a,c,"; l.p.stoop@uu.nl" -h /media/DataDrive/JRA55/JRA55-EU_BASE/JRA55-EU_ssrd_$Y.nc
    ncatted -O -a long_name,ssrd,o,c,"Downward short-wave radiation flux masked for European region" -h /media/DataDrive/JRA55/JRA55-EU_BASE/JRA55-EU_ssrd_$Y.nc
    ncatted -O -a short_name,ssrd,o,c,"ssrd" -h /media/DataDrive/JRA55/JRA55-EU_BASE/JRA55-EU_ssrd_$Y.nc
done


for Y in $(seq 1958 2018);do 
    # Fix the variables for the temperature
    cdo chname,2t,t2m -addc,-273.15 JRA55-EU_t2m_$Y.nc /media/DataDrive/JRA55/JRA55-EU_BASE/JRA55-EU_t2m_$Y.nc
    # Rename the attributes and set the variables attributes for windspeed
    ncatted -O -a map_area,global,o,c,"Europe" -h /media/DataDrive/JRA55/JRA55-EU_BASE/JRA55-EU_t2m_$Y.nc
    ncatted -O -a experiment,global,o,c,"Model: JRA55" -h /media/DataDrive/JRA55/JRA55-EU_BASE/JRA55-EU_t2m_$Y.nc
    ncatted -O -a author,global,a,c,"; Laurens Stoop, UU/KNMI/TenneT" -h /media/DataDrive/JRA55/JRA55-EU_BASE/JRA55-EU_t2m_$Y.nc
    ncatted -O -a email,global,a,c,"; l.p.stoop@uu.nl" -h /media/DataDrive/JRA55/JRA55-EU_BASE/JRA55-EU_t2m_$Y.nc
    ncatted -O -a long_name,t2m,o,c,"Temperature at 2 meter masked for European region" -h /media/DataDrive/JRA55/JRA55-EU_BASE/JRA55-EU_t2m_$Y.nc
    ncatted -O -a short_name,t2m,o,c,"t2m" -h /media/DataDrive/JRA55/JRA55-EU_BASE/JRA55-EU_t2m_$Y.nc
    ncatted -O -a units,t2m,o,c,"degC" -h /media/DataDrive/JRA55/JRA55-EU_BASE/JRA55-EU_t2m_$Y.nc
done


for Y in $(seq 1958 2018);do 
    # Fix the variables for the windspeed
    cdo chname,10u,wspd -sqrt -add -sqr JRA55-EU_u10_$Y.nc -sqr JRA55-EU_u10_$Y.nc /media/DataDrive/JRA55/JRA55-EU_BASE/JRA55-EU_wspd_$Y.nc
    # Rename the attributes and set the variables attributes for windspeed
    ncatted -O -a map_area,global,o,c,"Europe" -h /media/DataDrive/JRA55/JRA55-EU_BASE/JRA55-EU_wspd_$Y.nc
    ncatted -O -a experiment,global,o,c,"Model: JRA55" -h /media/DataDrive/JRA55/JRA55-EU_BASE/JRA55-EU_wspd_$Y.nc
    ncatted -O -a author,global,a,c,"; Laurens Stoop, UU/KNMI/TenneT" -h /media/DataDrive/JRA55/JRA55-EU_BASE/JRA55-EU_wspd_$Y.nc
    ncatted -O -a email,global,a,c,"; l.p.stoop@uu.nl" -h /media/DataDrive/JRA55/JRA55-EU_BASE/JRA55-EU_wspd_$Y.nc
    ncatted -O -a long_name,wspd,o,c,"Windspeed at 10 meter masked for European region" -h /media/DataDrive/JRA55/JRA55-EU_BASE/JRA55-EU_wspd_$Y.nc
    ncatted -O -a short_name,wspd,o,c,"wspd" -h /media/DataDrive/JRA55/JRA55-EU_BASE/JRA55-EU_wspd_$Y.nc
done


