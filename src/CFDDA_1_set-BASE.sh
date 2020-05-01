# Laurens Stoop l.p.stoop@uu.nl/ laurensstoop.nl
#
# 


stage='/home/stoop/TEMP0/CFDDA'
# Radiation
### Run in the origin folder
months='01 02 03 04 05 06 07 08 09 10 11 12'
for Y in $(seq 1985 2005);do  #1985 2005 
    for M in $months ; do
        # Convert from Grib2 data to netcdf
        cdo select,name=swdown -sellonlatbox,-31,74.25,34.5,80 /media/stoop/DataFiles/CFDDA/origin/cfdda_merge_${Y}${M}.nc $stage/temp_${Y}${M}.nc
        # Set the correct name
        cdo chname,swdown,ssrd $stage/temp_${Y}${M}.nc $stage/temp2_${Y}${M}.nc
    done
    # Merge the time 
    cdo mergetime $stage/temp2_$Y*.nc $stage/CFDDA-EU_ssrd_$Y.nc
    # Rename the attributes and set the variables attributes for windspeed
    ncatted -O -a map_area,global,o,c,"Europe" -h $stage/CFDDA-EU_ssrd_$Y.nc
    ncatted -O -a experiment,global,o,c,"Model: CFDDA" -h $stage/CFDDA-EU_ssrd_$Y.nc
    ncatted -O -a author,global,a,c,"; Laurens Stoop, UU/KNMI/TenneT" -h $stage/CFDDA-EU_ssrd_$Y.nc
    ncatted -O -a email,global,a,c,"; l.p.stoop@uu.nl" -h $stage/CFDDA-EU_ssrd_$Y.nc
    ncatted -O -a long_name,ssrd,o,c,"Downward short-wave radiation flux masked for European region" -h $stage/CFDDA-EU_ssrd_$Y.nc
    ncatted -O -a short_name,ssrd,o,c,"ssrd" -h $stage/CFDDA-EU_ssrd_$Y.nc
    ncatted -a history,global,d,, -h $stage/CFDDA-EU_ssrd_$Y.nc /media/stoop/DataFiles/CFDDA-EU_BASE/CFDDA-EU_ssrd_$Y.nc
    # Clean up 
    rm $stage/temp_$Y*.nc
    rm $stage/temp2_$Y*.nc
    rm $stage/CFDDA-EU_ssrd_$Y.nc
done



stage='/home/stoop/TEMP1/CFDDA'
# temperature
### Run in the origin folder
months='01 02 03 04 05 06 07 08 09 10 11 12'
for Y in $(seq 1985 2005);do  #1985 2005 
    for M in $months ; do
        # Convert from Grib2 data to netcdf
        cdo select,name=T2C -sellonlatbox,-31,74.25,34.5,80 /media/stoop/DataFiles/CFDDA/origin/cfdda_merge_${Y}${M}.nc $stage/temp_${Y}${M}.nc
        # Set the correct name
        cdo chname,T2C,t2m $stage/temp_${Y}${M}.nc $stage/temp2_${Y}${M}.nc
    done
    # Merge the time 
    cdo mergetime $stage/temp2_$Y*.nc $stage/CFDDA-EU_t2m_$Y.nc
    # Rename the attributes and set the variables attributes for windspeed
    ncatted -O -a map_area,global,o,c,"Europe" -h $stage/CFDDA-EU_t2m_$Y.nc
    ncatted -O -a experiment,global,o,c,"Model: CFDDA" -h $stage/CFDDA-EU_t2m_$Y.nc
    ncatted -O -a author,global,a,c,"; Laurens Stoop, UU/KNMI/TenneT" -h $stage/CFDDA-EU_t2m_$Y.nc
    ncatted -O -a email,global,a,c,"; l.p.stoop@uu.nl" -h $stage/CFDDA-EU_t2m_$Y.nc
    ncatted -O -a long_name,t2m,o,c,"Temperature at 2 meter masked for European region" -h $stage/CFDDA-EU_t2m_$Y.nc
    ncatted -O -a short_name,t2m,o,c,"t2m" -h $stage/CFDDA-EU_t2m_$Y.nc
    ncatted -O -a units,t2m,o,c,"degC" -h $stage/CFDDA-EU_t2m_$Y.nc
    ncatted -a history,global,d,, -h $stage/CFDDA-EU_t2m_$Y.nc /media/stoop/DataFiles/CFDDA-EU_BASE/CFDDA-EU_t2m_$Y.nc
    # Clean up 
    rm $stage/temp_$Y*.nc
    rm $stage/temp2_$Y*.nc
    rm $stage/CFDDA-EU_t2m_$Y.nc
done



stage='/home/stoop/TEMP2/CFDDA'
# wind speed
### Run in the origin folder
months='01 02 03 04 05 06 07 08 09 10 11 12'
for Y in $(seq 1985 2005);do  #1985 2005 
    for M in $months ; do
        # Convert from Grib2 data to netcdf
        cdo select,name=U10,V10 -sellonlatbox,-31,74.25,34.5,80 /media/stoop/DataFiles/CFDDA/origin/cfdda_merge_${Y}${M}.nc $stage/temp_${Y}${M}.nc
        # Set the correct name
        cdo 'expr,wspd=sqrt(U10^2+V10^2)' $stage/temp_${Y}${M}.nc $stage/temp2_${Y}${M}.nc
    done
    # Merge the time 
    cdo mergetime $stage/temp2_$Y*.nc $stage/CFDDA-EU_wspd_$Y.nc
    # Rename the attributes and set the variables attributes for windspeed
    ncatted -O -a map_area,global,o,c,"Europe" -h $stage/CFDDA-EU_wspd_$Y.nc
    ncatted -O -a experiment,global,o,c,"Model: CFDDA" -h $stage/CFDDA-EU_wspd_$Y.nc
    ncatted -O -a author,global,a,c,"; Laurens Stoop, UU/KNMI/TenneT" -h $stage/CFDDA-EU_wspd_$Y.nc
    ncatted -O -a email,global,a,c,"; l.p.stoop@uu.nl" -h $stage/CFDDA-EU_wspd_$Y.nc
    ncatted -O -a long_name,wspd,o,c,"Wind speed at 10 meter masked for European region" -h $stage/CFDDA-EU_wspd_$Y.nc
    ncatted -O -a short_name,wspd,o,c,"wspd" -h $stage/CFDDA-EU_wspd_$Y.nc
    ncatted -O -a units,wspd,o,c,"m s**-1" -h $stage/CFDDA-EU_wspd_$Y.nc
    ncatted -a history,global,d,, -h $stage/CFDDA-EU_wspd_$Y.nc /media/stoop/DataFiles/CFDDA-EU_BASE/CFDDA-EU_wspd_$Y.nc
    # Clean up 
    rm $stage/temp_$Y*.nc
    rm $stage/temp2_$Y*.nc
    rm $stage/CFDDA-EU_wspd_$Y.nc
done



