# Laurens Stoop l.p.stoop@uu.nl/ laurensstoop.nl
#
# 


stage='/home/stoop/TEMP3'
# Radiation
### Run in the origin folder
for Y in $(seq 1979 2018);do  #1985 2005 
    # Convert from Grib2 data to netcdf
    cdo -b 64 select,name=ssr /media/stoop/DataDrive/ERAinterim/origin/ERAinterim-EU_${Y}.nc $stage/temp_${Y}.nc
    # Select the timestep
    cdo seltimestep,1/2928/4 $stage/temp_${Y}.nc $stage/temp_${Y}1.nc
    cdo seltimestep,2/2928/4 $stage/temp_${Y}.nc $stage/temp_${Y}2.nc
    cdo seltimestep,3/2928/4 $stage/temp_${Y}.nc $stage/temp_${Y}3.nc
    cdo seltimestep,4/2928/4 $stage/temp_${Y}.nc $stage/temp_${Y}4.nc
    # Divide the specific timestep by the specific value
    cdo divc,10800 $stage/temp_${Y}1.nc $stage/temp_${Y}1s.nc
    cdo divc,21600 $stage/temp_${Y}2.nc $stage/temp_${Y}2s.nc
    cdo divc,32400 $stage/temp_${Y}3.nc $stage/temp_${Y}3s.nc
    cdo divc,43200 $stage/temp_${Y}4.nc $stage/temp_${Y}4s.nc
    # Merge the seperate times    
    cdo mergetime $stage/temp_${Y}*s.nc $stage/temp_s_${Y}.nc
    # Set the correct name
    cdo chname,ssr,ssrd $stage/temp_s_${Y}.nc $stage/ERAinterim-EU_ssrd_${Y}.nc
    # Rename the attributes and set the variables attributes for windspeed
    ncatted -O -a map_area,global,o,c,"Europe" -h $stage/ERAinterim-EU_ssrd_$Y.nc
    ncatted -O -a experiment,global,o,c,"Model: ERA Interim" -h $stage/ERAinterim-EU_ssrd_$Y.nc
    ncatted -O -a author,global,a,c,"; Laurens Stoop, UU/KNMI/TenneT" -h $stage/ERAinterim-EU_ssrd_$Y.nc
    ncatted -O -a email,global,a,c,"; l.p.stoop@uu.nl" -h $stage/ERAinterim-EU_ssrd_$Y.nc
    ncatted -O -a long_name,ssrd,o,c,"Downward short-wave radiation flux masked for European region" -h $stage/ERAinterim-EU_ssrd_$Y.nc
    ncatted -O -a short_name,ssrd,o,c,"ssrd" -h $stage/ERAinterim-EU_ssrd_$Y.nc
    ncatted -O -a units,ssrd,o,c,"W/m^2" -h $stage/ERAinterim-EU_ssrd_$Y.nc
    ncatted -a history,global,d,, -h $stage/ERAinterim-EU_ssrd_$Y.nc /media/stoop/DataDrive/ERAinterim-EU_BASE/ERAinterim-EU_ssrd_$Y.nc
    # Clean up 
    rm $stage/temp_*$Y.nc
    rm $stage/temp_$Y*.nc
    rm $stage/ERAinterim-EU_ssrd_$Y.nc
done



stage='/home/stoop/TEMP4'
# temperature
### Run in the origin folder
for Y in $(seq 1979 2018);do  #1979 2018 
    # Convert from Grib2 data to netcdf
    cdo -b 64 select,name=t2m /media/stoop/DataDrive/ERAinterim/origin/ERAinterim-EU_${Y}.nc $stage/temp_${Y}.nc
    # Set the correct name
    cdo select,name=t2m -addc,-273.15 $stage/temp_${Y}.nc $stage/ERAinterim-EU_t2m_$Y.nc
    # Rename the attributes and set the variables attributes for windspeed
    ncatted -O -a map_area,global,o,c,"Europe" -h $stage/ERAinterim-EU_t2m_$Y.nc
    ncatted -O -a experiment,global,o,c,"Model: ERAinterim" -h $stage/ERAinterim-EU_t2m_$Y.nc
    ncatted -O -a author,global,a,c,"; Laurens Stoop, UU/KNMI/TenneT" -h $stage/ERAinterim-EU_t2m_$Y.nc
    ncatted -O -a email,global,a,c,"; l.p.stoop@uu.nl" -h $stage/ERAinterim-EU_t2m_$Y.nc
    ncatted -O -a long_name,t2m,o,c,"Temperature at 2 meter masked for European region" -h $stage/ERAinterim-EU_t2m_$Y.nc
    ncatted -O -a short_name,t2m,o,c,"t2m" -h $stage/ERAinterim-EU_t2m_$Y.nc
    ncatted -O -a units,t2m,o,c,"degC" -h $stage/ERAinterim-EU_t2m_$Y.nc
    ncatted -a history,global,d,, -h $stage/ERAinterim-EU_t2m_$Y.nc /media/stoop/DataDrive/ERAinterim-EU_BASE/ERAinterim-EU_t2m_$Y.nc
    # Clean up 
    rm $stage/temp_$Y.nc
    rm $stage/ERAinterim-EU_t2m_$Y.nc
done



stage='/home/stoop/TEMP5'
# wind speed
### Run in the origin folder
for Y in $(seq 1979 2018);do  #1979 2018 
    # Convert from Grib2 data to netcdf
    cdo -b 64 select,name=u10,v10 /media/stoop/DataDrive/ERAinterim/origin/ERAinterim-EU_${Y}.nc $stage/temp_${Y}.nc
    # Set the correct name
    cdo 'expr,wspd=sqrt(u10^2+v10^2)' $stage/temp_${Y}.nc $stage/ERAinterim-EU_wspd_${Y}.nc
    # Rename the attributes and set the variables attributes for windspeed
    ncatted -O -a map_area,global,o,c,"Europe" -h $stage/ERAinterim-EU_wspd_$Y.nc
    ncatted -O -a experiment,global,o,c,"Model: ERAinterim" -h $stage/ERAinterim-EU_wspd_$Y.nc
    ncatted -O -a author,global,a,c,"; Laurens Stoop, UU/KNMI/TenneT" -h $stage/ERAinterim-EU_wspd_$Y.nc
    ncatted -O -a email,global,a,c,"; l.p.stoop@uu.nl" -h $stage/ERAinterim-EU_wspd_$Y.nc
    ncatted -O -a long_name,wspd,o,c,"Wind speed at 10 meter masked for European region" -h $stage/ERAinterim-EU_wspd_$Y.nc
    ncatted -O -a short_name,wspd,o,c,"wspd" -h $stage/ERAinterim-EU_wspd_$Y.nc
    ncatted -O -a units,wspd,o,c,"m s**-1" -h $stage/ERAinterim-EU_wspd_$Y.nc
    ncatted -a history,global,d,, -h $stage/ERAinterim-EU_wspd_$Y.nc /media/stoop/DataDrive/ERAinterim-EU_BASE/ERAinterim-EU_wspd_$Y.nc
    # Clean up 
    rm $stage/temp_$Y.nc
    rm $stage/ERAinterim-EU_wspd_$Y.nc
done



